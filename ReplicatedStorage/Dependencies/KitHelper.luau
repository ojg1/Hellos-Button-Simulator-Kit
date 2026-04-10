local Helper = {}

local aN = require(game.ReplicatedStorage.Dependencies.NumberSystems.AlyaNum)
local DSS = game:GetService("DataStoreService")
local DBSData = DSS:GetDataStore("DBSData")
--Datastore helpers

--save data using aN lb
function Helper:SaveDataLibrary(Player : Player)
	local DataString = ""
	local PlayerKitStats = Player:WaitForChild("KitStats")

	for _,Stat in pairs(PlayerKitStats:GetChildren()) do
		DataString = DataString..Stat.Name..":"..tostring(aN.lbencode(aN.fromString(Stat.Value))).."|"
	end

	local Success, ErrorMessage = pcall(function()
		DBSData:SetAsync(Player.UserId, DataString)
	end)

	if Success then
		print("saved")
		return 
	else
		print("Failed to save data for userId:"..tostring(Player.UserId).."| userName:"..Player.Name)
		warn(ErrorMessage)
	end
end

function Helper:SaveDataBaseAlya(Player)
	print(Player)
	local DataString = ""
	local PlayerKitStats = Player:WaitForChild("KitStats")

	for _,Stat in pairs(PlayerKitStats:GetChildren()) do
		DataString = DataString..Stat.Name..":"..Stat.Value.."|"
	end

	local Success, ErrorMessage = pcall(function()
		DBSData:SetAsync(Player.UserId, DataString)
	end)

	if Success then
		print("saved")

		return 
	else
		print("Failed to save data for userId:"..tostring(Player.UserId).."| userName:"..Player.Name)
		warn(ErrorMessage)
	end
end

--save data using aN lb
function Helper:LoadDataBaseAlya(Player : Player, DataString : string)

	--redefine KitStats
	local KitStats = Player:WaitForChild("KitStats")
	local StatList = string.split(DataString, "|")

	for _, LBValue in pairs(StatList) do
		local Divide = string.split(LBValue, ":")
		local StatChild = KitStats:FindFirstChild(Divide[1])

		if StatChild then
			StatChild.Value = Divide[2]
		end

	end

end


--savedata with string as is
function Helper:SaveDataString(Player : Player)
	local DataString = ""
	local PlayerKitStats = Player:WaitForChild("KitStats")

	for _,Stat in pairs(PlayerKitStats:GetChildren()) do
		DataString = DataString..Stat.Name..":"..Stat.Value.."|"
	end

	local Success, ErrorMessage = pcall(function()
		DBSData:SetAsync(Player.UserId, DataString)
	end)

	if Success then
		print("saved")

		return
	else
		print("Failed to save data for userId:"..tostring(Player.UserId).."| userName:"..Player.Name)
		warn(ErrorMessage)
	end
end

--save data using aN lb
function Helper:LoadDataLibrary(Player : Player, DataString : string)

	--redefine KitStats
	local KitStats = Player:WaitForChild("KitStats")
	local StatList = string.split(DataString, "|")

	for _, LBValue in pairs(StatList) do
		local Divide = string.split(LBValue, ":")
		local StatChild = KitStats:FindFirstChild(Divide[1])

		if StatChild then
			StatChild.Value = aN.toString(aN.lbencode(tonumber(Divide[2])))
		end

	end

end

--loaddata with string as is
function Helper:LoadDataString(Player : Player, DataString : string)

	--redefine KitStats
	local KitStats = Player:WaitForChild("KitStats")
	local StatList = string.split(DataString, "|")

	for _, LBValue in pairs(StatList) do
		local Divide = string.split(LBValue, ":")
		local StatChild = KitStats:FindFirstChild(Divide[1])

		if StatChild then
			StatChild.Value = Divide[2]
		end

	end
end

--nan Correct: default
function Helper:CorrectNan(s : string)
	if s == "nan" then
		return "0"
	else
		return s
	end
end

return Helper