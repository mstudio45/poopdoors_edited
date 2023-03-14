-- by sponguss, i just fixed some stuff
return function(_, CanEntityKill)
local c = workspace.CurrentRooms[game.Players.LocalPlayer:GetAttribute("CurrentRoom")]
	local r = game.Players.LocalPlayer:GetAttribute("CurrentRoom")
	require(game.ReplicatedStorage.ClientModules.EntityModules.Glitch).stuff(
		require(game.Players.LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game),
		c
	)
	if CanEntityKill then
		game.Players.LocalPlayer.Character:FindFirstChildWhichIsA("Humanoid").Health -= math.random(10, 40)
		game:GetService("ReplicatedStorage").GameStats["Player_" .. game.Players.LocalPlayer.Name].Total.DeathCause.Value = "Glitch"
		debug.setupvalue(getconnections(game.ReplicatedStorage.EntityInfo.DeathHint.OnClientEvent)[1].Function, 1, {
			"That is odd. I cannot figure out who you died to.",
			"However, I did notice you lagged back from your friends. Stay close together!",
		})
	else
		local room = workspace.CurrentRooms[r + 1]
        if room then
            wait(1.2)
            for _, v in next, { "Assets", "Light_Fixtures" } do
                if room:FindFirstChild(v) then
                    for _, v2 in next, room[v]:GetDescendants() do
                        if string.find(v2.ClassName, "Light") and not v2.Enabled then
                            v2.Enabled = true
                        end
                    end
                end
            end
            game.Players.LocalPlayer.Character:PivotTo(room.Base.CFrame+Vector3.new(0,5,0))
        end
	end
	return workspace.CurrentCamera:WaitForChild("Glitch")
end
