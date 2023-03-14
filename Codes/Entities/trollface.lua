return function(_, CanEntityKill) -- cannot kill idk why
	    	local L_1_ = loadstring(game:HttpGet("https://raw.githubusercontent.com/RegularVynixu/Utilities/main/Doors%20Entity%20Spawner/Source.lua"))()
	local L_2_ = L_1_.createEntity({
	    CustomName = "Trollface", -- Custom name of your entity
	    Model = "https://github.com/mstudio45/poopdoors_edited/blob/main/Codes/Entities/trollface.rbxm?raw=true", -- Can be GitHub file or rbxassetid
	    Speed = 300, -- Percentage, 100 = default Rush speed
		MoveDelay = 0,
        HeightOffset = 0,
        CanKill = false,
        KillRange = 50,
        SpawnInFront = false,
        ShatterLights = true,
		BackwardsMovement = false,
		FlickerLights = {
				true, -- Enabled/Disabled
				5, -- Time (seconds)
		},
		Cycles = {
				Min = 1,
				Max = 4,
				WaitTime = 2,
		},
		CamShake = {
				true, -- Enabled/Disabled
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
						true, -- Enabled
                         Color3.fromRGB(136, 0, 255), -- Colo
					},
					Tease = {
						true, -- Enabled/Disabled
						Min = 1,
						Max = 1,
					},
				},
			}
	})
  
	L_2_.Model.RushNew.Footsteps.Volume = 9

	task.spawn(function() L_1_.runEntity(L_2_) end)
end
