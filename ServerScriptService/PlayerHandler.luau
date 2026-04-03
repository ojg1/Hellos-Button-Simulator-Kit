
--Services
local ReplicatedStorage = game.ReplicatedStorage
local Dependencies = ReplicatedStorage.Dependencies
local DataStoreService = game:GetService("DataStoreService")

--dependencies
local aN = require(Dependencies.NumberSystems.AlyaNum) --Dependencies/NumberSystems/AlyaNum
local DBSHelper = require(Dependencies.KitHelper) --Dependencies/KitHelper
local DBSConfig = require(Dependencies.Configuration) --Dependencies/Configuration

--DataStore and helper fucntions

local DBSData = DataStoreService:GetDataStore("DBSData")

game:BindToClose(function()
	for _,Player in pairs(game.Players:GetPlayers()) do
		DBSHelper["SaveData"..DBSConfig.PlayerFormat](Player)
	end		
end)


--PlayerRemoving and PlayerAdded

game.Players.PlayerAdded:Connect(function(Player : Player)

	local PlayerCharacter = Player.Character or Player.CharacterAdded:Wait()

	local StatGui = ReplicatedStorage.StatGUI:Clone()
	StatGui.Parent = PlayerCharacter:WaitForChild("Head")

	local KitStats = ReplicatedStorage.KitStats:Clone()
	KitStats.Parent = Player

	local RSkill = aN.fromString("0e0")
	local leaderstats = Instance.new("Folder")
	leaderstats.Parent = Player

	local LSkill = Instance.new("StringValue")
	LSkill.Parent = leaderstats

	local Data : string = ""

	local Success, ErrorMessage = pcall(function()
		Data = DBSData:GetAsync(Player.UserId)
	end)

	if Success and Data then
		DBSHelper["LoadData"..DBSConfig.PlayerFormat]()
	else
		print("No data found for userId and userName: "..Player.UserId.." "..Player.Name)
		print(ErrorMessage)
	end

	--main loop
	while task.wait(DBSConfig.MainIncrLoopTickRate) do
		local RSkill = aN.mul(aN.fromString("2e0"), 
			aN.log10(aN.fromStringBaseAlya(KitStats.Money.Value)))
		LSkill.Value = aN.toSuffix(RSkill)

		KitStats.Money.Value = aN.toStringBaseAlya(aN.add(aN.fromStringBaseAlya(KitStats.Money.Value), aN.fromStringBaseAlya(KitStats.Multi.Value)))
	end

end)

game.Players.PlayerRemoving:Connect(function(Player)
	DBSHelper["SaveData"..DBSConfig.PlayerFormat]()
end)