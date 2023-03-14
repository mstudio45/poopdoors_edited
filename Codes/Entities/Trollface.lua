return function(_, CanEntityKill)
local Creator = loadstring(game:HttpGet("https://raw.githubusercontent.com/RegularVynixu/Utilities/main/Doors%20Entity%20Spawner/Source.lua"))()
	local L_1_ = Creator.createEntity({
		CustomName = "Trollface", -- Custom name of your entity
		Model = "rbxassetid://11612531225", -- Can be GitHub file or rbxassetid
		Speed = 5000, -- Percentage, 100 = default Rush speed
		DelayTime = 2, -- Time before starting cycles (seconds)
		HeightOffset = 0,
		CanKill = CanEntityKill,
		KillRange = 50,
		BreakLights = true,
		BackwardsMovement = false,
		FlickerLights = {
			true, -- Enabled/Disabled
			1, -- Time (seconds)
		},
		Cycles = {
			Min = 1,
			Max = 4,
			WaitTime = 2,
		},
		CamShake = {
			false, -- Enabled/Disabled
			{
				3.5,
				20,
				0.1,
				1
			}, -- Shake values (don't change if you don't know)
			100, -- Shake start distance (from Entity to you)
		},
		Jumpscare = {
			true, -- Enabled/Disabled
			{
				Image1 = "rbxassetid://8855759668", -- Image1 url
				Image2 = "rbxassetid://8855759668", -- Image2 url
				Shake = false,
				Sound1 = {
					8389041427, -- SoundId
					{
						Volume = 0.5
					}, -- Sound properties
				},
				Sound2 = {
					8389041427, -- SoundId
					{
						Volume = 0.5
					}, -- Sound properties
				},
				Flashing = {
					false, -- Enabled/Disabled
					Color3.fromRGB(255, 255, 255), -- Color
				},
				Tease = {
					true, -- Enabled/Disabled
					Min = 1,
					Max = 1,
				},
			},
		},
		CustomDialog = {
			"Tro",
			"lol",
			"lol",
			"lol"
		}, -- Custom death message
	})
	
	task.spawn(function() Creator.runEntity(L_1_) end)
	return L_1_.Model
end
