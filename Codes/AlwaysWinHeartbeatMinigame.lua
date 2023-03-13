local AlwaysWinHeartbeatMinigame_Data = {
    heartbeatwin = false
}

if hookmetamethod and newcclosure and getnamecallmethod then 
    local old
	old = hookmetamethod(game, "__namecall", newcclosure(function(self,...)
		local args = {...}
		local method = getnamecallmethod()

		if tostring(self) == 'ClutchHeartbeat' and method == "FireServer" and AlwaysWinHeartbeatMinigame_Data.heartbeatwin == true then
			args[2] = true
			return old(self,unpack(args))
		end

		return old(self,...)
	end))    
end

return AlwaysWinHeartbeatMinigame_Data
