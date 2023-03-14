return function(_, CanEntityKill)
    require(game.Players.LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game.RemoteListener.Modules.SpiderJumpscare)(require(game.Players.LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game), workspace:FindFirstChild("CurrentRooms"):FindFirstChild("DrawerContainer", true), 0.2)
    if CanEntityKill and game.Players.LocalPlayer.Character:FindFirstChildWhichIsA("Humanoid").Health>5 then
        game.Players.LocalPlayer.Character:FindFirstChildWhichIsA("Humanoid").Health-=5 
    end
    return workspace.CurrentCamera:WaitForChild("Spider")
end
