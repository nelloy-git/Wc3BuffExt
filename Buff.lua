--=========
-- Include
--=========

local Class = LibManager.getDepency('LuaClass') or error('')
---@type Wc3Handle
local Wc3Handle = LibManager.getDepency('Wc3Handle') or error('')
local TimedObj = Wc3Handle.TimedObj or error('')
local Unit = Wc3Handle.Unit or error('')
---@type Wc3Utils
local Wc3Utils = LibManager.getDepency('Wc3Utils') or error('')
local isTypeErr = Wc3Utils.isTypeErr or error('')

---@type BuffExtTypeClass
local BuffExtType = require('Type') or error('')

--=======
-- Class
--=======

local BuffExt = Class.new('Buff', TimedObj)
---@class BuffExt : TimedObj
local public = BuffExt.public
---@class BuffExtClass : TimedObjClass
local static = BuffExt.static
---@type BuffExtClass
local override = BuffExt.override
local private = {}

--=========
-- Static
--=========

---@param source Unit
---@param target Unit
---@param buff_type BuffExtType
---@param user_data any
---@param child BuffExt | nil
---@return BuffExt
function override.new(source, target, buff_type, user_data, child)
    isTypeErr(source, Unit, 'source')
    isTypeErr(target, Unit, 'target')
    isTypeErr(buff_type, BuffExtType, 'buff_type')
    isTypeErr(child, {BuffExt, 'nil'}, 'child')

    local instance = child or Class.allocate(BuffExt)
    instance = TimedObj.new(instance)

    private.newData(instance, source, target, buff_type, user_data)

    return instance
end

--========
-- Public
--========

---@return Unit
function public:getSource()
    isTypeErr(self, BuffExt, 'self')
    return private.data[self].source
end

---@return Unit
function public:getTarget()
    isTypeErr(self, BuffExt, 'self')
    return private.data[self].target
end

---@return BuffExtType
function public:getType()
    isTypeErr(self, BuffExt, 'self')
    return private.data[self].buff_type
end

---@return any
function public:getUserData()
    isTypeErr(self, BuffExt, 'self')
    return private.data[self].user_data
end

---@return string
function public:getName()
    isTypeErr(self, BuffExt, 'self')
    return private.data[self].buff_type:getName(self)
end

---@return string
function public:getIcon()
    isTypeErr(self, BuffExt, 'self')
    return private.data[self].buff_type:getIcon(self)
end

---@return string
function public:getTooltip()
    isTypeErr(self, BuffExt, 'self')
    return private.data[self].buff_type:getTooltip(self)
end

--=========
-- Private
--=========

private.data = setmetatable({}, {__mode = 'k'})

---@param self BuffExt
---@param source Unit
---@param target Unit
---@param buff_type BuffExtType
---@param user_data any
function private.newData(self, source, target, buff_type, user_data)
    local priv = {
        source = source,
        target = target,
        buff_type = buff_type,
        user_data = user_data,
    }
    private.data[self] = priv

    self:addStartAction(private.start)
    self:addLoopAction(private.loop)
    self:addCancelAction(private.cancel)
    self:addFinishAction(private.finish)
end

---@self Buff
function private.start(self)
    private.data[self].buff_type:onStart(self)
end

---@self Buff
function private.loop(self)
    private.data[self].buff_type:onLoop(self)
end

---@self Buff
function private.cancel(self)
    private.data[self].buff_type:onCancel(self)
end

---@self Buff
function private.finish(self)
    private.data[self].buff_type:onFinish(self)
end

return static