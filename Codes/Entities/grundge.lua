return function(_, CanEntityKill)
	local Creator = loadstring(game:HttpGet("https://raw.githubusercontent.com/RegularVynixu/Utilities/main/Doors%20Entity%20Spawner/Source.lua"))()
	-- Create entity
	local entity = Creator.createEntity({
		CustomName = "Grundge", -- Custom name of your entity
	   Model = "rbxassetid://11482609355", -- Can be GitHub file or rbxassetid
		Speed = 1000, -- Percentage, 100 = default Rush speed
		DelayTime = 4, -- Time before starting cycles (seconds)
		HeightOffset = 0,
		CanKill = CanEntityKill,
		BreakLights = true,
		FlickerLights = {
			true, -- Enabled
			10, -- Time (seconds)
		},
		Cycles = {
			Min = 15,
			Max = 25,
			WaitTime = 4,
		 },
		CamShake = {
			true, -- Enabled
			{5, 15, 0.1, 1}, -- Shake values (don't change if you don't know)
			30, -- Shake start distance (from Entity to you)
		},
		   Jumpscare = {
			true, -- Enabled ('false' if you don't want jumpscare)
			{
				Image1 = "rbxassetid://11482510186", -- Image1 url
				Image2 = "rbxassetid://11482510186", -- Image2 url
				Shake = true,
				Sound1 = {
					0, -- SoundId
					 { Volume = 0.5 }, -- Sound properties
				},
				Sound2 = {
					9125712561, -- SoundId
					{ Volume = 0.5 }, -- Sound properties
				},
				Flashing = {
						true, -- Enabled
						Color3.fromRGB(1, 1, 255), -- Color
					},
				Tease = {
						true, -- Enabled ('false' if you don't want tease)
						Min = 3,
						Max = 4,
					},
			   },
		},
		CustomDialog = {"You died to Nerd...", "NERD ", "..., Ha ha he."}, -- Custom death message (can be as long as you want)
	})
	
	task.spawn(function()Creator.runEntity(entity) end)
	return entity.Model
end
