
# Welcome to H|DBS Kit V1.2

## What I want coming up.
- Regex/LaTeX style aN formatting for easier, complex intergration of complex functions.
- Organization for InteractiveAction.luau and simple, clear instructions to build a stat. Many people are still confused about that.

## Configurations

### Main Install
Import HDBS Kit v1.2.0 into workspace and open up the folder. Then, drag each of the folders inside to the corresponding services (i.e. ServerScriptService, ReplicatedStorage) and then STRICTLY ungroup/unpack only that folder. Then, start making your buttons! 

### What can you configure

You can configure anything of the buttons, but do not change the name of the BillboardGui, any of the configuration and the configuration itself. Same with the orbs or buttons that trigger a stat.

### Making a stat
To create a stat, you must use a service called Tags, and there are two ways to do this.

1. GUI Friendly
 On the topbar of Roblox Studio, press the plus icon, name your new category something. Then right click on the empty space of your new category and search Tag and add the first one that has a store tag with it. Open it up and add a new tag and name it strictly to what stat you want to make, no spaces.
2. Direct
 Open up ServerStorage and open up TagList. Add a "Configuration" object inside that folder and name it stricly with the stat you want to make, no spaces.


After you are done setting up the tags, go into ServerScriptService, open up [DBS] Scripts, and go inside the script named "InteractiveActivation.luau". Scroll down the script and at the bottom-most line copy:
```
local [STAT]Table = {
	Tag = "STAT",
	Boosts = {
		["OTHERSTAT"] = "2e0", --do a key value pair ["STAT"] = Value and seperate each boost with a comma
		["OTHERSTAT2"] = "3e0",
		["OTHERSTAT3"] = "4e0",
		and so on.. -- do not put a comma at that last boost you want the stat to be boosted
	},
	CostTag = "COSTSTAT",
	RetuTag = "RETURNSTAT",
	Attributes = {
		Reset = {stat0, stat1, stat2},
		SubFromCTag = false,
		BillboardFormat = "Cost CostTag = Return RetuTag" --How you want to format the BillboardGUI on the button
	}
}

constructStat(UltraRebirthTable.Tag, UltraRebirthTable.CostTag, UltraRebirthTable.RetuTag, UltraRebirthTable.Boosts, UltraRebirthTable.Attributes)
```

If this is too confusing, do not be afraid to ask in /issues or dm .eychbee (disc). We are still working to make this system as flexible as possible that works with all the edge cases.

### Removing a stat

Keep in mind this is also a work in progress and may not work entirely.
Remove the table and function shown in the block of code up there of your stat. Then, go into all your other table function pairs and then remove anything related to the stat you want to remove (i.e. boosts and resets) 

## Github Repository (recommended to read)

The github repository does NOT support certain objects as in the rbxl and rbxm and only should be used to debug. Snapshots are formatted as "sshot[MMDDYY]c[COMMITNUMBER]f[VERSION]" and official and unofficial versions are formatted as "(u)vMAJOR.MINOR.PATCH". 

If you find any issues while installing or find any issues while playtesting the kit, please leave it in https://www.github.com/ojg1/Hellos-Button-Simulator-Kit/issues. 

## Changelog:
H|DBS Kit V1.1
--removed EternityNum because of precision errors
--rewrote InteractiveActivation (pre: TagHandler.lua) for clarity and debugging

H|DBS Kit V1.2
--added README.md (not located in actual kit) and README.lua (roblox)
--new formatting for InteractiveAction
--posted on GitHub

For beginners:
Move folder "ReplicatedStorage" in HDBS Kit V1.2 into game.ReplicatedStorage and unpack
Move folder "ServerScriptService" in HDBS Kit V1.2 into game.ServerScriptService and unpack
Move folder "ServerStorage" in HDBS Kit V1.2 into game.ServerStorage and unpack

README.md and README.luau not fully wrote. 

# Please write README and kit suggestions preferably in https://www.github.com/ojg1/Hellos-Button-Simulator-Kit/issues.
