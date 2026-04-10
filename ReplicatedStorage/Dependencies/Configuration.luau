--ModuleScript /server/Configuration.lua
local DBSConfig = {}
local alyaNum = require(game.ReplicatedStorage.Dependencies.NumberSystems.AlyaNum)

DBSConfig.MainIncrLoopTickRate = 0.05 --how long it will take for main currency to += secondary currency

--your options "BaseAlya", "String", "Library"
DBSConfig.PlayerFormat = "BaseAlya" --this will also be for save, so PLEASE consider your option. once you pick you can not pick again
DBSConfig.UseLibdeflateTruncation = false --not fully incorporated

DBSConfig.DefaultCorrection = "0"
--will later support autoformatting (+2^log(2))
--modes are "pow" "mult"
DBSConfig.ServerMultiplierMode = "pow"
DBSConfig.ServerMultiplierIncrement = alyaNum.fromString("1e0")

return DBSConfig
