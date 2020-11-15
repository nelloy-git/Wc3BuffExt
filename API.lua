LibManager.startLib('Wc3BuffExt')

--===========
-- Depencies
--===========

LibManager.addDepency('LuaClass', 'https://github.com/nelloy-git/LuaClass.git')
LibManager.addDepency('Wc3Handle', 'https://github.com/nelloy-git/Wc3Handle.git')
LibManager.addDepency('Wc3Utils', 'https://github.com/nelloy-git/Wc3Utils.git')

--=====
-- API
--=====

---@class Wc3BuffExt
local Wc3BuffExt = {}

---@type BuffExtContainerClass
Wc3BuffExt.Container = require('Container') or error('')
---@type BuffExtTypeClass
Wc3BuffExt.Type = require('Type') or error('')

---@type BuffExtClass
local Buff = require('BuffExt') or error('')
Wc3BuffExt.getBuffPeriod = Buff.getPeriod

LibManager.endLib()

return Wc3BuffExt