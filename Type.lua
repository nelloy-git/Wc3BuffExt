--=========
-- Include
--=========

local Class = LibManager.getDepency('LuaClass') or error('')
---@type Wc3Utils
local Wc3Utils = LibManager.getDepency('Wc3Utils') or error('')
local isTypeErr = Wc3Utils.isTypeErr or error('')
local Log = Wc3Utils.Log or error('')

--=======
-- Class
--=======

local BuffExtType = Class.new('BuffExtType')
---@class BuffExtType
local public = BuffExtType.public
---@class BuffExtTypeClass
local static = BuffExtType.static
---@type BuffExtTypeClass
local override = BuffExtType.override
local private = {}

--========
-- Static
--========

---@param child BuffExtType | nil
---@return BuffExtType
function override.new(child)
    isTypeErr(child, {BuffExtType, 'nil'}, 'child')

    local instance = child or Class.allocate(BuffExtType)
    return instance
end

--========
-- Public
--========

--- Virtual function.
---@param buff BuffExt
function public:onStart(buff) end

--- Virtual function
---@param buff BuffExt
function public:onLoop(buff) end

--- Virtual function
---@param buff BuffExt
function public:onCancel(buff) end

--- Virtual function
---@param buff BuffExt
function public:onFinish(buff) end

--- Virtual function
---@param buff BuffExt
---@return string
function public:getName(buff) end

--- Virtual function
---@param buff BuffExt
---@return string
function public:getIcon(buff) end

--- Virtual function
---@param buff BuffExt
---@return string
function public:getTooltip(buff) end

--=========
-- Private
--=========

return static