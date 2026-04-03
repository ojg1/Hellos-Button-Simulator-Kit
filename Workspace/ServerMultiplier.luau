
--sadly still manual

local DBSConfig = require(game.ReplicatedStorage.DBSConfig)
local aN = require(game.ReplicatedStorage.Dependencies.NumberSystems.AlyaNum)

script.Parent.Touched:Connect(function(hit)
    if hit.Parent:FindFirstChild("Humanoid") then
        local Player = game.Players:GetPlayerFromCharacter(hit.Parent)
        local KitStats = Player:WaitForChild("KitStats")

        local C : Configuration = script.Parent.Configuration
        local B : BillboardGui = script.Parent.BillboardGui

        
    end
end)
