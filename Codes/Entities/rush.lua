
-- by sponguss, i just fixed some stuff
return function(_, CanEntityKill)
local L_1_ = loadstring(game:HttpGet("https://raw.githubusercontent.com/RegularVynixu/Utilities/main/Doors%20Entity%20Spawner/Source.lua"))()
local L_2_ = L_1_.createEntity({
	CustomName = "Rush",
	Model = "https://github.com/RegularVynixu/Utilities/blob/main/Doors/Entity%20Spawner/Assets/Entities/Rush.rbxm?raw=true",
	Speed = 100,
	DelayTime = 2,
	HeightOffset = 0,
	CanKill = CanEntityKill or false,
	KillRange = 50,
	BreakLights = true,
	BackwardsMovement = false,
	FlickerLights = {
		true,
		1
	},
	Cycles = {
		Min = 1,
		Max = 1,
		WaitTime = 2
	},
	CamShake = {
		true,
		{
			3.5,
			20,
			0.1,
			1
		},
		100
	},
	Jumpscare = {
		true,
		{
			Image1 = "rbxassetid://10483855823",
			Image2 = "rbxassetid://11288728218",
			Shake = true,
			Sound1 = { 
				11400679305,
				{
					Volume = 0.5
				}
			},
			Sound2 = {
				10483837590,
				{
					Volume = 0.5
				}
			},
			Flashing = {
				true,
				Color3.fromRGB(0, 0, 255)
			},
			Tease = {
				true,
				Min = 1,
				Max = 3
			}
		},
	},
	CustomDialog = {
		"It seems you are having trouble with Rush...",
		"The lights will always flicker when it is near.",
		"Whenever this happens, find a hiding spot!"
	}
})

L_1_.runJumpscare = function() -- my hand hurts from this help
	local L_3_ = game.Players.LocalPlayer.PlayerGui.MainUI
	game.SoundService.Main.Volume = 0
	game.Players.LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game.RemoteListener.Jumpscare_Rush:Play()
	L_3_.Jumpscare.Jumpscare_Rush.Visible = true
	local L_4_ = tick()
	local L_5_ = math.random(5, 30) / 10
	local L_6_ = L_5_ + math.random(10, 60) / 10
	local L_7_ = 0.25
	for L_9_forvar0 = 1, 100000 do
		task.wait()
		if L_4_ + L_5_ <= tick() then
			L_3_.Jumpscare.Jumpscare_Rush.ImageLabel.Visible = true
			L_5_ = L_5_ + math.random(7, 44) / 10
			game.Players.LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game.RemoteListener.Jumpscare_Rush.Pitch = 1 + math.random(-100, 100) / 500
			L_3_.Jumpscare.Jumpscare_Rush.BackgroundColor3 = Color3.new(0, 0, math.random(0, 10) / 255)
			L_3_.Jumpscare.Jumpscare_Rush.ImageLabel.Position = UDim2.new(0.5, math.random(-2, 2), 0.5, math.random(-2, 2))
			L_7_ = L_7_ + 0.05
			L_3_.Jumpscare.Jumpscare_Rush.ImageLabel.Size = UDim2.new(L_7_, 0, L_7_, 0)
		end
		if L_4_ + L_6_ <= tick() then
			break
		end
	end
	L_3_.Jumpscare.Jumpscare_Rush.ImageLabel.Visible = true
	game.Players.LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game.RemoteListener.Jumpscare_Rush:Stop()
	game.Players.LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game.RemoteListener.Jumpscare_Rush2:Play()
	L_3_.Jumpscare.Jumpscare_Rush.ImageLabel.Visible = false
	L_3_.Jumpscare.Jumpscare_Rush.ImageLabelBig.Visible = true
	L_3_.Jumpscare.Jumpscare_Rush.ImageLabelBig:TweenSize(UDim2.new(2.5, 0, 2.5, 0), "In", "Sine", 0.3, true)
	local L_8_ = tick()
	for L_10_forvar0 = 1, 1000 do
		local L_11_ = math.random(0, 10) / 10
		L_3_.Jumpscare.Jumpscare_Rush.BackgroundColor3 = Color3.new(L_11_, L_11_, math.clamp(math.random(25, 50) / 50, L_11_, 1))
		L_3_.Jumpscare.Jumpscare_Rush.ImageLabelBig.Position = UDim2.new(0.5 + math.random(-100, 100) / 5000, 0, 0.5 + math.random(-100, 100) / 3000, 0)
		task.wait(0.016666666666666666)
		if L_8_ + 0.3 <= tick() then
			break
		end
	end
	L_3_.Jumpscare.Jumpscare_Rush.ImageLabelBig.Visible = false
	L_3_.Jumpscare.Jumpscare_Rush.BackgroundColor3 = Color3.new(0, 0, 0)
	L_3_.Jumpscare.Jumpscare_Rush.Visible = false
end

task.spawn(function() L_1_.runEntity(L_2_) end)
end
