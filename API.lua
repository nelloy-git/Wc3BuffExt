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
--[[
---@class Wc3BuffExt
local Wc3BuffExt = {}

---@type BuffExtContainerClass
Wc3BuffExt.Container = require('Container') or error('')
---@type BuffExtTypeClass
Wc3BuffExt.Type = require('Type') or error('')

---@type BuffExtClass
<<<<<<< HEAD
local Buff = require('BuffExt') or error('')
Wc3BuffExt.getBuffPeriod = Buff.getPeriod

=======
local BuffExt = require('Buff') or error('')
Wc3BuffExt.getBuffLoopPeriod = BuffExt.getPeriod

---@type BuffExtEffectShield
local Shield = require('Effects.Shield') or error('')
Wc3BuffExt.addShield = Shield.add
Wc3BuffExt.getShield = Shield.get
Wc3BuffExt.getMaxShield = Shield.getMax
]]
>>>>>>> 88c1f76b055bbff1a6d6feb1867395fe12ac2b6e
LibManager.endLib()

return Wc3BuffExt