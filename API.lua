LibManager.startLib('Wc3AbilityExt')

--===========
-- Depencies
--===========

LibManager.addDepency('LuaClass', 'https://github.com/nelloy-git/LuaClass.git')
LibManager.addDepency('Wc3Binary', 'https://github.com/nelloy-git/Wc3Binary.git')
LibManager.addDepency('Wc3Damage', 'https://github.com/nelloy-git/Wc3Damage.git')
LibManager.addDepency('Wc3Handle', 'https://github.com/nelloy-git/Wc3Handle.git')
LibManager.addDepency('Wc3Parameter', 'https://github.com/nelloy-git/Wc3Parameter.git')
LibManager.addDepency('Wc3Utils', 'https://github.com/nelloy-git/Wc3Utils.git')

--=====
-- API
--=====

---@class Wc3BuffExt
local Wc3BuffExt = {}

---@type BuffContainerClass
Wc3BuffExt.Container = require('Container') or error('')
---@type BuffTypeClass
Wc3BuffExt.Type = require('Type') or error('')

---@type BuffClass
local Buff = require('Buff') or error('')
Wc3BuffExt.getBuffLoopPeriod = Buff.getPeriod

---@type BuffEffectShield
local Shield = require('Effects.Shield') or error('')
Wc3BuffExt.addShield = Shield.add
Wc3BuffExt.getShield = Shield.get
Wc3BuffExt.getMaxShield = Shield.getMax

LibManager.endLib()

return Wc3BuffExt