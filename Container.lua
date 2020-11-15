--=========
-- Include
--=========

local Class = LibManager.getDepency('LuaClass') or error('')
---@type Wc3Handle
local Wc3Handle = LibManager.getDepency('Wc3Handle') or error('')
local Unit = Wc3Handle.Unit or error('')
---@type Wc3Utils
local Wc3Utils = LibManager.getDepency('Wc3Utils') or error('')
local Action = Wc3Utils.Action or error('')
local ActionList = Wc3Utils.ActionList or error('')
local isTypeErr = Wc3Utils.isTypeErr or error('')
local Log = Wc3Utils.Log or error('')

---@type BuffExtClass
local BuffExt = require('BuffExt') or error('')
---@type BuffExtTypeClass
local BuffExtType = require('Type') or error('')

--=======
-- Class
--=======

local BuffExtContainer = Class.new('BuffExtContainer')
---@class BuffExtContainer
local public = BuffExtContainer.public
---@class BuffExtContainerClass
local static = BuffExtContainer.static
---@type BuffExtContainerClass
local override = BuffExtContainer.override
local private = {}

--=========
-- Static
--=========

---@param owner Unit
---@param child BuffExtContainer | nil
---@return BuffExtContainer
function static.new(owner, child)
    isTypeErr(owner, Unit, 'owner')
    isTypeErr(child, {BuffExtContainer, 'nil'}, 'child')

    local instance = child or Class.allocate(BuffExtContainer)
    private.newData(instance, owner)

    return instance
end

function static.get(owner)
    return private.owner2container[owner]
end

--========
-- Public
--========

---@param buff_type BuffExtType
---@param source Unit
---@param time number
---@param user_data any
---@return boolean
function public:add(source, buff_type, time, user_data)
    isTypeErr(self, BuffExtContainer, 'self')
    isTypeErr(buff_type, BuffExtType, 'buff_type')
    isTypeErr(source, Unit, 'source')
    isTypeErr(time, 'number', 'time')
    local priv = private.data[self]

    local buff = BuffExt.new(source, priv.owner, buff_type, user_data)
    buff:addCancelAction(private.removeBuff)
    buff:addFinishAction(private.removeBuff)
    buff:start(time)
    table.insert(priv.list, #priv.list + 1, buff)
    private.buffs2container[buff] = self

    priv.changed_actions:run(self)
end

---@return number
function public:count()
    isTypeErr(self, BuffExtContainer, 'self')
    return #private.data[self].list
end

---@param pos number
---@return BuffExt | nil
function public:get(pos)
    isTypeErr(self, BuffExtContainer, 'self')
    isTypeErr(pos, 'number', 'pos')
    return private.data[self].list[pos]
end

---@return table
function public:getAll()
    isTypeErr(self, BuffExtContainer, 'self')
    local priv = private.data[self]

    local copy = {}
    for i = 1, #priv.list do
        table.insert(copy, i, priv.list[i])
    end
    return copy
end

---@alias BuffExtContainerCallback fun(container:BuffExtContainer)

---@param callback BuffExtContainerCallback
---@return Action
function public:addChangedAction(callback)
    isTypeErr(self, BuffExtContainer, 'self')
    isTypeErr(callback, 'function', 'callback')
    return private.data[self].changed_actions:add(callback)
end

---@param action Action
---@return boolean
function public:removeAction(action)
    isTypeErr(self, BuffExtContainer, 'self')
    isTypeErr(action, Action, 'action')
    return private.data[self].changed_actions:remove(action)
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})
private.owner2container = setmetatable({}, {__mode = 'k'})
private.buffs2container = setmetatable({}, {__mode = 'k'})

---@param self BuffExtContainer
---@param owner Unit
function private.newData(self, owner)
    local priv = {
        owner = owner,
        list = {},

        changed_actions = ActionList.new(self)
    }
    private.data[self] = priv
    private.owner2container[owner] = self
end

function private.removeBuff(buff)
    ---@type BuffExtContainer
    local self = private.buffs2container[buff]
    local priv = private.data[self]

    for i = 1, #priv.list do
        if priv.list[i] == buff then
            table.remove(priv.list, i)
            priv.changed_actions:run(self)
            return
        end
    end

    Log:err(tostring(BuffExtContainer)..': buff for removal is not found')
end

return static