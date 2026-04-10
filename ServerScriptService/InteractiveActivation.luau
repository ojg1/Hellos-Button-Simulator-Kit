local CollectionService = game:GetService("CollectionService")
local RS = game.ReplicatedStorage
local aN = require(RS.Dependencies.NumberSystems.AlyaNum)
local KH = require(RS.Dependencies.KitHelper)
local DC = require(RS.Dependencies.Configuration)


type baseAttributes = {
	Reset : {},
	SubFromCStat: boolean,
	BillboardFormat: string | "Cost CostTag = Return RetuTag"
}


local function constructStat(Tag : string, CostTag : string, RetuTag : string, Boosts : {}, Attributes : baseAttributes)
	for _, Active : BasePart in pairs(CollectionService:GetTagged(Tag)) do
		local C : Configuration = Active:WaitForChild("Configuration")
		local B : BillboardGui = Active:WaitForChild("BillboardGui")

		--Billboard Configuration

		local Co : string = KH:CorrectNan(aN.toSuffix(aN.fromString(C.Cost.Value)))
		local Re : string = KH:CorrectNan(aN.toSuffix(aN.fromString(C.Return.Value)))
		
		local CostTagSub = string.gsub(Attributes.BillboardFormat, "CostTag", CostTag)

		local RetuTagSub = string.gsub(CostTagSub, "RetuTag", RetuTag)
		local CostSub = string.gsub(RetuTagSub, "Cost", Co)
		local Final = string.gsub(CostSub, "Return", Re)

		B.Exchange.Text = Final

		Active.Touched:Connect(function(hit)

			if hit.Parent:FindFirstChild("Humanoid") then

				local Player = game.Players:GetPlayerFromCharacter(hit.Parent)
				local PlayerStats = Player:WaitForChild("KitStats")

				--'p' player
				local pCTag = aN.fromStringBaseAlya(PlayerStats[CostTag].Value)
				local pRTag = aN.fromStringBaseAlya(PlayerStats[RetuTag].Value)

				if aN.moreEquals(pCTag, aN.fromString(C.Cost.Value)) then

					local addValue = aN.fromString(C.Return.Value)

					for boost, value in pairs(Boosts) do
						local KitStatValue = aN.fromStringBaseAlya(PlayerStats[boost].Value)
						local init = aN.mul(aN.fromString(value), KitStatValue)
						init = aN.add(init, aN.fromString("1e0"))


						addValue = aN.mul(init, addValue)
					end

					--add stat
					PlayerStats[RetuTag].Value = aN.toStringBaseAlya(aN.add(addValue, aN.fromStringBaseAlya(PlayerStats[RetuTag].Value)))

					if Attributes.SubFromCStat then
						PlayerStats[CostTag].Value = aN.toStringBaseAlya(aN.sub(aN.fromStringBaseAlya(PlayerStats[CostTag].Value), aN.fromString(C.Cost.Value)))		
					end


					for _,Stat in pairs(Attributes.Reset) do
						if Stat == "Multi" then PlayerStats["Multi"].Value = aN.toStringBaseAlya(aN.fromString("1e0")) continue end
						PlayerStats[Stat].Value = aN.toStringBaseAlya(aN.fromString("0e0"))
					end

				end

			end
		end)
	end
end

local function StatMaker(t : {})

	print("Successfully made stat "..t.Tag)

	constructStat(t.Tag or t[1], t.CostTag or t[2], t.RetuTag or t[3], t.Boosts or t[4], t.Attributes or t[5])
	
	return
end

local constStat = StatMaker
local constrStat = StatMaker
local structStat = StatMaker


-- v1.1.0 helloboy930 GPL license

--[[

orb hierarchy and expected children

Orb 
--BillboardGui
--Configuration
--[--Cost
--[--Return


not req children (kit hypothetical)
--BoostOnly
--[--KitStat and TagHandler oriented name ... etc


buttonRender() para

Tag: orb name
Boosts: boosts please use TagName accordingly with KitStats v;"[STAT]":EN


]]

local RegTable = {
	Tag = "Buttons",
	Boosts = {
		["Rebirth"] = "1e0" -- placeholder boosts, you can change these
	},
	CostTag = "Money",
	RetuTag = "Multi",
	Attributes = {
		Reset = {},
		SubFromCTag = true,
		BillboardFormat = "$Cost = xReturn"
	}
}

--warning(argument #1 expects a string, but table was passed)
--constructStat{Tag=RegTable.Tag, CostTag=RegTable.CostTag, RetuTag=RegTable.RetuTag, Boosts=RegTable.Boosts, Attributes=RegTable.Attributes}
StatMaker(RegTable)

local RebirthTable = {
	Tag = "Rebirth",
	Boosts = {
		["UltraRebirth"] = "3e0"
	},
	CostTag = "Multi",
	RetuTag = "Rebirth",
	Attributes = {
		Reset = {"Money","Multi"},
		SubFromCTag = false,
		BillboardFormat = "Cost CostTag = Return RetuTag"
	}
}

StatMaker(RebirthTable)

local UltraRebirthTable = {
	Tag = "UltraRebirth",
	Boosts = {
		["Prestige"] = "2e0"
	},
	CostTag = "Rebirth",
	RetuTag = "UltraRebirth",
	Attributes = {
		Reset = {"Money","Multi","Rebirth"},
		SubFromCTag = false,
		BillboardFormat = "Cost CostTag = Return RetuTag"
	}
}

StatMaker(UltraRebirthTable)

-- if you need help on anythin just ask me k?
--yeah just like that  you get it right
local PrestigeTable = {
	Tag = "Prestige",
	Boosts = {
		["UltraPrestige"] = "2e0"
	},
	CostTag = "UltraRebirth",
	RetuTag = "Prestige",
	Attributes = {
		Reset = {"Money","Multi","Rebirth","UltraRebirth"},
		SubFromCTag = false,
		BillboardFormat = "Cost CostTag = Return RetuTag"
	}
}

StatMaker(PrestigeTable)

local UltraPrestigeTable = {
	Tag = "UltraPrestige",
	Boosts = {
		["MegaMultiplier"] = "2e0"
	},
	CostTag = "Prestige",
	RetuTag = "UltraPrestige",
	Attributes = {
		Reset = {"Money","Multi","Rebirth","UltraRebirth","Prestige"},
		SubFromCTag = false,
		BillboardFormat = "Cost CostTag = Return RetuTag"
	}
}

StatMaker(UltraPrestigeTable) 

local MegaMultiplierTable = {
	Tag = "MegaMultiplier",
	Boosts = {
		["Ascension"] = "2e0"
	},
	CostTag = "UltraPrestige",
	RetuTag = "MegaMultiplier",
	Attributes = {
		Reset = {"Money","Multi","Rebirth","UltraRebirth","Prestige","UltraPrestige"},
		SubFromCTag = false,
		BillboardFormat = "Cost CostTag = Return RetuTag"
	}
}

StatMaker(MegaMultiplierTable)

local AscensionTable = {
	Tag = "Ascension",
	Boosts = {
		["Power"] = "2e0"
	},
	CostTag = "MegaMultiplier",
	RetuTag = "Ascension",
	Attributes = {
		Reset = {"Money","Multi","Rebirth","UltraRebirth","Prestige","UltraPrestige","MegaMultiplier"},
		SubFromCTag = false,
		BillboardFormat = "Cost CostTag = Return RetuTag"
	}
}

StatMaker(AscensionTable)

local PowerTable = {
	Tag = "Power",
	Boosts = {
		["Infinity"] = "2e0"
	},
	CostTag = "Ascension",
	RetuTag = "Power",
	Attributes = {
		Reset = {"Money","Multi","Rebirth","UltraRebirth","Prestige","UltraPrestige","MegaMultiplier","Ascension"},
		SubFromCTag = false,
		BillboardFormat = "Cost CostTag = Return RetuTag"
	}
}
-- did you kknow this whole entire dbs runs on 2 scripts, thats how minimal this is

StatMaker(PowerTable)

local InfinityTable = {
	Tag = "Infinity",
	Boosts = {
		["OmegaRebirth"] = "2e0"
	},
	CostTag = "Power",
	RetuTag = "Infinity",
	Attributes = {
		Reset = {"Money","Multi","Rebirth","UltraRebirth","Prestige","UltraPrestige","MegaMultiplier","Ascension","Power"},
		SubFromCTag = false,
		BillboardFormat = "Cost CostTag = Return RetuTag"
	}
}

StatMaker(InfinityTable)

local OmegaRebirthTable = {
	Tag = "OmegaRebirth",
	Boosts = {
		["OmegaPrestige"] = "2e0"
	},
	CostTag = "Infinity",
	RetuTag = "OmegaRebirth",
	Attributes = {
		Reset = {"Money","Multi","Rebirth","UltraRebirth","Prestige","UltraPrestige","MegaMultiplier","Ascension","Power","Infinity"},
		SubFromCTag = false,
		BillboardFormat = "Cost CostTag = Return RetuTag"
	}
}

StatMaker(OmegaRebirthTable)

local OmegaPrestigeTable = {
	Tag = "OmegaPrestige",
	Boosts = {
		["Eternity"] = "2e0"
	},
	CostTag = "OmegaRebirth",
	RetuTag = "OmegaPrestige",
	Attributes = {
		Reset = {"Money","Multi","Rebirth","UltraRebirth","Prestige","UltraPrestige","MegaMultiplier","Ascension","Power","Infinity","OmegaRebirth"},
		SubFromCTag = false,
		BillboardFormat = "Cost CostTag = Return RetuTag"
	}
}

StatMaker(OmegaPrestigeTable)
