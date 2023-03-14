return function(...)
            game.Players.LocalPlayer.Character:SetAttribute("HideSickness", true)
            require(game.Players.LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game.RemoteListener.Modules.HideMonster)(require(game.Players.LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game), 0)
	return nil
end
