local NotificationHolder = loadstring(game:HttpGet("https://raw.githubusercontent.com/BocusLuke/UI/main/STX/Module.Lua"))()
local Notification = loadstring(game:HttpGet("https://raw.githubusercontent.com/BocusLuke/UI/main/STX/Client.Lua"))()
function message(text)
	spawn(function()
		local msg = Instance.new("Message",workspace)
		msg.Text = tostring(text)
		task.wait(5)
		msg:Destroy()

		--firesignal(entityinfo.Caption.OnClientEvent,tostring(text)) 
	end)
end

function normalmessage(title, text, timee)
	Notification:Notify(
		{Title = title, Description = text},
		{OutlineColor = Color3.fromRGB(80, 80, 80),Time = timee or 5, Type = "default"}
	)
end

function confirmnotification(title, text, timee, callback)
	Notification:Notify(
		{Title = title, Description = text},
		{OutlineColor = Color3.fromRGB(80, 80, 80), Time = timee or 10, Type = "option"},
		{Image = "http://www.roblox.com/asset/?id=6023426923", ImageColor = Color3.fromRGB(255, 84, 84), Callback = callback or function(state)end}
	)
end

function warnmessage(title, text, timee)
	Notification:Notify(
		{Title = title, Description = text},
		{OutlineColor = Color3.fromRGB(80, 80, 80),Time = timee or 5, Type = "image"},
		{Image = "http://www.roblox.com/asset/?id=6023426923", ImageColor = Color3.fromRGB(255, 84, 84)}
	)
end

local teleported = false
repeat
	for _,v in pairs(game:GetService("Workspace").Lobby.LobbyElevators:GetChildren()) do
		if v.DoorHitbox.BillboardGui.Title.Text == "0 / 1" or v.DoorHitbox.BillboardGui.Title.Text == "0 / 12" then
			repeat
				game.Players.LocalPlayer.Character:PivotTo(v.DoorHitbox.CFrame)
				task.wait()
			until v.DoorHitbox.BillboardGui.Title.Text == "1 / 1" or v.DoorHitbox.BillboardGui.Title.Text == "1 / 12"
			teleported = true
			break
		end
	end
	task.wait(1)
	if teleported == false then
		normalmessage("POOPDOORS EDITED", "Solo games are full, retrying...", 2)
	end
until teleported == true
normalmessage("POOPDOORS EDITED", "Joining...", 10)
