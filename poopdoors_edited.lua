-- edited by mstudio45 | original by https://v3rmillion.net/member.php?action=profile&uid=1802731 
-- https://v3rmillion.net/showthread.php?tid=1200475
-- loadstring(game:HttpGet(("https://raw.githubusercontent.com/mstudio45/poopdoors_edited/main/poopdoors_edited.lua"), true)()

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

local currentver = "1.2"
local gui_data = nil
local s,e = pcall(function()
	gui_data = game:HttpGet(("https://raw.githubusercontent.com/mstudio45/poopdoors_edited/main/gui_data.json"), true)
	gui_data = game:GetService("HttpService"):JSONDecode(gui_data)
end)
if e then
	warnmessage("POOPDOORS EDITED v"..currentver, "Failed to get script data.", 10)
end

if POOPDOORSLOADED == true then warnmessage("POOPDOORS EDITED v"..currentver, "GUI already loaded!", 10) return end
if game.PlaceId ~= 6839171747 and game.PlaceId == 6516141723 then 
	--warnmessage("POOPDOORS EDITED v"..currentver, "You need to join a game to run this script.", 10) 
	confirmnotification("POOPDOORS EDITED v"..currentver, "Do you want to join a game?", 15, function(state)
		if state == true then
			loadstring(game:HttpGet(("https://raw.githubusercontent.com/mstudio45/poopdoors_edited/main/joinsolo.lua"), true))()
		end
	end)
	return
end
if game.PlaceId ~= 6839171747 and game.PlaceId ~= 6516141723 then 
	warnmessage("POOPDOORS EDITED v"..currentver, "You need to join DOORS to run this script.", 10) 
	return
end
if gui_data ~= nil then
	if currentver ~= gui_data.ver or gui_data.ver ~= currentver then
		warnmessage("POOPDOORS EDITED v"..currentver, "You are using an outdated version of this script. Loading latest version.", 10) 
		loadstring(game:HttpGet((gui_data.loadstring),true))()
		return
	else
		currentver = tostring(gui_data.ver)
	end
end
pcall(function() getgenv().POOPDOORSLOADED = true end)
normalmessage("POOPDOORS EDITED v"..currentver, "Loading script...", 2)
if gui_data ~= nil then
	normalmessage("INFO", gui_data.changelog, 20)
end

local SimplePath = loadstring(game:HttpGet(("https://raw.githubusercontent.com/mstudio45/poopdoors_edited/main/SimplePath_nojump.lua"--[["https://raw.githubusercontent.com/Zeref-Z/RBLX-SimplePath/main/src/SimplePath.lua"--]]),true))()
SimplePath.JUMP_WHEN_STUCK = false

-- credits alan1508 on v3erm
do
	task.spawn(function()
		if hookfunction then
			local f;
			f = hookfunction(game:GetService("ContentProvider").PreloadAsync, function(g, h, i)
				if table.find(h, game:GetService("CoreGui")) then
					local j = function(j, k)
						if (j:match("^rbxasset://") or j:match("^rbxthumb://")) then
							return i(j, k);
						end
					end;
					warn("Anticheat Check Detected");
					return f(g, h, j);
				end
				return f(g, h, i);
			end);
		end
	end)
end

local library = loadstring(game:HttpGet(--[['https://pastebin.com/raw/vPWzQEC8'--]]"https://raw.githubusercontent.com/mstudio45/poopdoors_edited/main/library.lua"))()
local plr = game.Players.LocalPlayer
local char = plr.Character or plr.CharacterAdded:Wait()
local hum = char:FindFirstChildOfClass("Humanoid") or char:WaitForChild("Humanoid")
local LatestRoom = game:GetService("ReplicatedStorage").GameData.LatestRoom
local Players = game:GetService("Players")

local esptableinstances = {}
function esp(what,color,core,name)
	local parts

	if typeof(what) == "Instance" then
		if what:IsA("Model") then
			parts = what:GetChildren()
		elseif what:IsA("BasePart") then
			parts = {what,table.unpack(what:GetChildren())}
		end
	elseif typeof(what) == "table" then
		parts = what
	end

	local bill
	local boxes = {}

	for i,v in pairs(parts) do
		if v:IsA("BasePart") then
			local box = Instance.new("BoxHandleAdornment")
			box.Size = v.Size
			box.AlwaysOnTop = true
			box.ZIndex = 1
			box.AdornCullingMode = Enum.AdornCullingMode.Never
			box.Color3 = color
			box.Transparency = 0.7
			box.Adornee = v
			box.Parent = game.CoreGui

			table.insert(boxes,box)

			task.spawn(function()
				while box do
					if box.Adornee == nil or not box.Adornee:IsDescendantOf(workspace) then
						box.Adornee = nil
						box.Visible = false
						box:Destroy()
					end  
					task.wait()
				end
			end)
		end
	end

	if core and name then
		bill = Instance.new("BillboardGui",game.CoreGui)
		bill.AlwaysOnTop = true
		bill.Size = UDim2.new(0,400,0,100)
		bill.Adornee = core
		bill.MaxDistance = 2000

		local mid = Instance.new("Frame",bill)
		mid.AnchorPoint = Vector2.new(0.5,0.5)
		mid.BackgroundColor3 = color
		mid.Size = UDim2.new(0,8,0,8)
		mid.Position = UDim2.new(0.5,0,0.5,0)
		Instance.new("UICorner",mid).CornerRadius = UDim.new(1,0)
		Instance.new("UIStroke",mid)

		local txt = Instance.new("TextLabel",bill)
		txt.AnchorPoint = Vector2.new(0.5,0.5)
		txt.BackgroundTransparency = 1
		txt.BackgroundColor3 = color
		txt.TextColor3 = color
		txt.Size = UDim2.new(1,0,0,20)
		txt.Position = UDim2.new(0.5,0,0.7,0)
		txt.Text = name
		Instance.new("UIStroke",txt)

		task.spawn(function()
			while bill do
				if bill.Adornee == nil or not bill.Adornee:IsDescendantOf(workspace) then
					bill.Enabled = false
					bill.Adornee = nil
					bill:Destroy() 
				end  
				task.wait()
			end
		end)
	end

	local ret = {}

	ret.delete = function()
		for i,v in pairs(boxes) do
			pcall(function()
				table.remove(esptableinstances, table.find(esptableinstances, v.Adornee))
			end)
			pcall(function()
				table.remove(esptableinstances, table.find(esptableinstances, v.Parent))
			end)
			v.Adornee = nil
			v.Visible = false
			v:Destroy()
		end

		if bill then
			pcall(function()
				table.remove(esptableinstances, table.find(esptableinstances, bill.Adornee))
			end)
			pcall(function()
				table.remove(esptableinstances, table.find(esptableinstances, bill.Parent))
			end)
			bill.Adornee = nil
			bill.Enabled = false
			bill:Destroy() 
		end
	end

	return ret 
end

local entityinfo = nil
task.spawn(function()
	if game.ReplicatedStorage:FindFirstChild("EntityInfo") then 
		entityinfo = game.ReplicatedStorage:FindFirstChild("EntityInfo") 
	else
		entityinfo = game.ReplicatedStorage:WaitForChild("EntityInfo")
	end	
end)

local avoidingYvalue = 22.5
local flags = {
	speed = 0,
	espdoors = false,
	espkeys = false,
	espitems = false,
	espbooks = false,
	esprush = false,
	espchest = false,
	esplocker = false,
	esphumans = false,
	espgold = false,
	goldespvalue = 0,
	hintrush = false,
	light = false,
	fullbright = false,
	instapp = false,
	noseek = false,
	nogates = false,
	nopuzzle = false,
	noa90 = false,
	noskeledoors = false,
	noscreech = false,
	getcode = false,
	roomsnolock = false,
	draweraura = false,
	keyaura = false,
	autorooms = false,
	heartbeatwin = false,
	noseekarmsfire = false,
	avoidrushambush = false,
	autoplayagain = false,
	bookcollecter = false,
	anticheatbypass = false,
	noeyesdamage = false,
	predictentities = false,
	noclip = false, --fly = false
	breakercollecter = false,
	autoskiprooms = false
}

local DELFLAGS = {table.unpack(flags)}
local esptable = {doors={},keys={},items={},books={},entity={},chests={},lockers={},people={},gold={}}

local window_player = library.window("player")
local window_entities = library.window("entities")
local window_roomsdoors = library.window("rooms (doors)")
local window_esp = library.window("esp")
local window_misc = library.window("misc")
local window_anticheatbyppasses = library.window("anticheat bypasses")
local window_experimentals = library.window("experimentals [beta]")
local window_rooms = library.window("the rooms")
window_rooms.hide()

local window_credits = library.window("credits")
window_credits.label("v3rm post: 1200475", 15)
window_credits.label("original by: zoophiliaphobic#6287",40) -- v3rm acc: 1802731
window_credits.label("edited by: mstudio45",30)

local gui_windows = {
	window_player,
	window_entities,
	window_roomsdoors,
	window_esp,
	window_misc,
	window_anticheatbyppasses,
	window_experimentals,
	window_credits,
}

window_esp.button("clear esp",function(val)
	pcall(function()
		for _,e in pairs(esptable) do
			for _,v in pairs(e) do
				pcall(function()
					v.delete()
				end)
			end
		end
	end)
end)

task.spawn(function()
	repeat task.wait(1) until flags.anticheatbypass == true

	window_player.toggle("noclip",false,function(val)
		flags.noclip = val

		if val then
			local Nocliprun = game:GetService("RunService").Stepped:Connect(function()
				if game.Players.LocalPlayer.Character ~= nil then
					for _,v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
						if v:IsA("BasePart") then
							pcall(function()
								v.CanCollide = false
							end)
						end
					end
				end
			end)

			repeat task.wait() until not flags.noclip
			if Nocliprun then Nocliprun:Disconnect() end
		end
	end)
end)

window_player.toggle("client glow",false,function(val)
	flags.light = val

	if val then
		local l = Instance.new("PointLight")
		l.Range = 10000
		l.Brightness = 2
		l.Parent = char.PrimaryPart

		repeat task.wait() until not flags.light
		l:Destroy() 
	end
end)

window_player.toggle("fullbright",false,function(val)
	flags.fullbright = val

	if val then
		local oldAmbient = game:GetService("Lighting").Ambient
		local oldColorShift_Bottom = game:GetService("Lighting").ColorShift_Bottom
		local oldColorShift_Top = game:GetService("Lighting").ColorShift_Top
		local function dofullbright()
			game:GetService("Lighting").Ambient = Color3.new(1, 1, 1)
			game:GetService("Lighting").ColorShift_Bottom = Color3.new(1, 1, 1)
			game:GetService("Lighting").ColorShift_Top = Color3.new(1, 1, 1)
		end

		dofullbright()
		local coneee = game:GetService("Lighting").LightingChanged:Connect(dofullbright)
		repeat task.wait() until not flags.fullbright
		coneee:Disconnect()
		game:GetService("Lighting").Ambient = oldAmbient
		game:GetService("Lighting").ColorShift_Bottom = oldColorShift_Bottom
		game:GetService("Lighting").ColorShift_Top = oldColorShift_Top
	end
end)
if fireproximityprompt then
	window_player.toggle("instant use",false,function(val)
		flags.instapp = val

		local holdconnect
		holdconnect = game:GetService("ProximityPromptService").PromptButtonHoldBegan:Connect(function(p)
			fireproximityprompt(p)
		end)

		repeat task.wait() until not flags.instapp
		holdconnect:Disconnect()
	end)
else
	warnmessage("POOPDOORS EDITED v"..currentver, "You need to have fireproximityprompt function for 'instant use'.", 7)
end

local walkspeedtoggle = false
local walkspeedslider = window_player.slider("walkspeed",16,22,1,16,function(val)
	flags.speed = val
	if walkspeedtoggle == true then
		hum.WalkSpeed = val
	end
end)

window_player.toggle("toggle walkspeed",false,function(val)
	walkspeedtoggle = val
	if not val then
		hum.WalkSpeed = 16
	end
end)

task.spawn(function()
	while task.wait() do
		if walkspeedtoggle == true then
			if hum.WalkSpeed < flags.speed then
				hum.WalkSpeed = flags.speed
			end
		end
	end
end)

window_player.button("kill yourself", function()
	confirmnotification("POOPDOORS EDITED v"..currentver, "Are you sure to kill yourself?", 15, function(state)
		if state == true then
			game.Players.LocalPlayer.Character.Humanoid.Health = 0
		end
	end)
end)

--[[window_player.label("\nif you use it anyone will be able to join your game and expose you of exploiting",32)
window_player.button("rejoin revive", function()
	if #game:GetService("Players"):GetPlayers() <= 1 or #game:GetService("Players"):GetPlayers() == 0 then
		game:GetService("Players").LocalPlayer:Kick("\nRejoining...")
		task.wait()
		game:GetService("TeleportService"):Teleport(game.PlaceId, game:GetService("Players").LocalPlayer)
	else
		game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId, game:GetService("Players").LocalPlayer)
	end
end)--]]

window_esp.toggle("door esp",false,function(val)
	flags.espdoors = val

	if val then
		local function setup(room)
			task.wait(.1)
			local door = room:WaitForChild("Door"):WaitForChild("Door")

			if table.find(esptableinstances, door) then
				return
			end

			task.wait(0.1)
			local h = esp(door,Color3.fromRGB(255,240,0),door,"Door")
			table.insert(esptable.doors,h)
			table.insert(esptableinstances, door)

			door:WaitForChild("Open").Played:Connect(function()
				h.delete()
			end)

			door.AncestryChanged:Connect(function()
				h.delete()
			end)
		end

		local addconnect
		addconnect = workspace.CurrentRooms.ChildAdded:Connect(function(room)
			setup(room)
		end)

		for i,room in pairs(workspace.CurrentRooms:GetChildren()) do
			if room:FindFirstChild("Assets") then
				setup(room) 
			end
			task.wait()
		end

		if workspace.CurrentRooms[tostring(game:GetService("ReplicatedStorage").GameData.LatestRoom.Value)]:FindFirstChild("Assets") then
			setup(workspace.CurrentRooms[tostring(game:GetService("ReplicatedStorage").GameData.LatestRoom.Value)])
		end

		repeat task.wait() until not flags.espdoors
		addconnect:Disconnect()

		for i,v in pairs(esptable.doors) do
			v.delete()
		end 
	end
end)

window_esp.toggle("key/lever esp",false,function(val)
	flags.espkeys = val

	if val then
		local function check(v)
			if table.find(esptableinstances, v) then
				return
			end

			if v:IsA("Model") and (v.Name == "LeverForGate" or v.Name == "KeyObtain") then
				task.wait(0.1)
				if v.Name == "KeyObtain" then
					local hitbox = v:WaitForChild("Hitbox")
					local parts = hitbox:GetChildren()
					table.remove(parts,table.find(parts,hitbox:WaitForChild("PromptHitbox")))

					local h = esp(parts,Color3.fromRGB(90,255,40),hitbox,"Key")
					table.insert(esptable.keys,h)
					table.insert(esptableinstances, v)
				elseif v.Name == "LeverForGate" then
					local h = esp(v,Color3.fromRGB(90,255,40),v.PrimaryPart,"Lever")
					table.insert(esptable.keys,h)
					table.insert(esptableinstances, v)
					v.PrimaryPart:WaitForChild("SoundToPlay").Played:Connect(function()
						h.delete()
					end) 
				end
			end
		end

		local function setup(room)
			task.wait(.1)
			local assets = room:WaitForChild("Assets")

			assets.DescendantAdded:Connect(function(v)
				check(v) 
			end)

			for i,v in pairs(assets:GetDescendants()) do
				check(v)
			end 
		end

		local addconnect
		addconnect = workspace.CurrentRooms.ChildAdded:Connect(function(room)
			setup(room)
		end)

		for i,room in pairs(workspace.CurrentRooms:GetChildren()) do
			if room:FindFirstChild("Assets") then
				setup(room) 
			end
			task.wait()
		end

		if workspace.CurrentRooms[tostring(game:GetService("ReplicatedStorage").GameData.LatestRoom.Value)]:FindFirstChild("Assets") then
			setup(workspace.CurrentRooms[tostring(game:GetService("ReplicatedStorage").GameData.LatestRoom.Value)])
		end

		repeat task.wait() until not flags.espkeys
		addconnect:Disconnect()

		for i,v in pairs(esptable.keys) do
			v.delete()
		end 
	end
end)

window_esp.toggle("item esp",false,function(val)
	flags.espitems = val

	if val then
		local function check(v)
			if table.find(esptableinstances, v) then
				return
			end

			if v:IsA("Model") and (v:GetAttribute("Pickup") or v:GetAttribute("PropType")) then
				task.wait(0.1)

				local part = (v:FindFirstChild("Handle") or v:FindFirstChild("Prop"))
				local h = esp(part,Color3.fromRGB(160,190,255),part,v.Name)
				table.insert(esptable.items,h)
				table.insert(esptableinstances, v)				
			end
		end

		local function setup(room)
			task.wait(.1)
			local assets = room:WaitForChild("Assets")

			if assets then  
				local subaddcon
				subaddcon = assets.DescendantAdded:Connect(function(v)
					check(v) 
				end)

				for i,v in pairs(assets:GetDescendants()) do
					check(v)
				end

				task.spawn(function()
					repeat task.wait() until not flags.espitems
					subaddcon:Disconnect()  
				end) 
			end 
		end

		local addconnect
		addconnect = workspace.CurrentRooms.ChildAdded:Connect(function(room)
			setup(room)
		end)

		for i,room in pairs(workspace.CurrentRooms:GetChildren()) do
			if room:FindFirstChild("Assets") then
				setup(room) 
			end
			task.wait()
		end

		if workspace.CurrentRooms[tostring(game:GetService("ReplicatedStorage").GameData.LatestRoom.Value)]:FindFirstChild("Assets") then
			setup(workspace.CurrentRooms[tostring(game:GetService("ReplicatedStorage").GameData.LatestRoom.Value)])
		end

		repeat task.wait() until not flags.espitems
		addconnect:Disconnect()

		for i,v in pairs(esptable.items) do
			v.delete()
		end 
	end
end)

window_esp.toggle("book/breaker esp",false,function(val)
	flags.espbooks = val

	if val then
		local function check(v,room)
			if table.find(esptableinstances, v) then
				return
			end

			if v:IsA("Model") and (v.Name == "LiveHintBook" or v.Name == "LiveBreakerPolePickup") then
				task.wait(0.1)
				local h
				if v.Name == "LiveHintBook" then
					h = esp(v,Color3.fromRGB(160,190,255),v.PrimaryPart,"Book")
				elseif v.Name == "LiveBreakerPolePickup" then
					h = esp(v,Color3.fromRGB(160,190,255),v.PrimaryPart,"Breaker")
				end

				table.insert(esptable.books,h)
				table.insert(esptableinstances, v)

				v.AncestryChanged:Connect(function()
					if not v:IsDescendantOf(room) then
						h.delete() 
					end
				end)
			end
		end

		local function setup(room)
			task.wait(.1)
			if room.Name == "50" or room.Name == "100" then
				room.DescendantAdded:Connect(function(v)
					check(v,room) 
				end)

				for i,v in pairs(room:GetDescendants()) do
					check(v,room)
				end
			end
		end

		local addconnect
		addconnect = workspace.CurrentRooms.ChildAdded:Connect(function(room)
			setup(room)
		end)

		for i,room in pairs(workspace.CurrentRooms:GetChildren()) do
			setup(room) 
			task.wait()
		end

		if workspace.CurrentRooms[tostring(game:GetService("ReplicatedStorage").GameData.LatestRoom.Value)]:FindFirstChild("Assets") then
			setup(workspace.CurrentRooms[tostring(game:GetService("ReplicatedStorage").GameData.LatestRoom.Value)])
		end

		repeat task.wait() until not flags.espbooks
		addconnect:Disconnect()

		for i,v in pairs(esptable.books) do
			v.delete()
		end 
	end
end)

local entitynames = {"RushMoving","AmbushMoving","Snare","A60","A120"}

window_esp.toggle("entity esp",false,function(val)
	flags.esprush = val

	if val then
		local addconnect
		addconnect = workspace.ChildAdded:Connect(function(v)
			if table.find(entitynames,v.Name) then
				task.wait(0.1)

				local h = esp(v,Color3.fromRGB(255,25,25),v.PrimaryPart,v.Name:gsub("Moving",""))
				table.insert(esptable.entity,h)
			end
		end)

		local function setup(room)
			task.wait(.1)
			if room.Name == "50" or room.Name == "100" then
				local figuresetup = room:WaitForChild("FigureSetup")

				if figuresetup then
					local fig = figuresetup:WaitForChild("FigureRagdoll")
					task.wait(0.1)

					local h = esp(fig,Color3.fromRGB(255,25,25),fig.PrimaryPart,"Figure")
					table.insert(esptable.entity,h)
				end 
			else
				local assets = room:WaitForChild("Assets")

				local function check(v)
					if v:IsA("Model") and table.find(entitynames,v.Name) then
						task.wait(0.1)

						local h = esp(v:WaitForChild("Base"),Color3.fromRGB(255,25,25),v.Base,"Snare")
						table.insert(esptable.entity,h)
					end
				end

				assets.DescendantAdded:Connect(function(v)
					check(v) 
				end)

				for i,v in pairs(assets:GetDescendants()) do
					check(v)
				end
			end 
		end

		local roomconnect
		roomconnect = workspace.CurrentRooms.ChildAdded:Connect(function(room)
			setup(room)
		end)

		for i,v in pairs(workspace.CurrentRooms:GetChildren()) do
			task.spawn(function()
				setup(v) 
			end)
		end

		setup(workspace.CurrentRooms[tostring(game:GetService("ReplicatedStorage").GameData.LatestRoom.Value)])

		repeat task.wait() until not flags.esprush
		addconnect:Disconnect()
		roomconnect:Disconnect()

		for i,v in pairs(esptable.entity) do
			v.delete()
		end 
	end
end)

window_esp.toggle("locker esp",false,function(val)
	flags.esplocker = val

	if val then
		local function check(v)
			if table.find(esptableinstances, v) then
				return
			end

			if v:IsA("Model") then
				task.wait(0.1)
				if v.Name == "Wardrobe" then
					local h = esp(v.PrimaryPart,Color3.fromRGB(145,100,25),v.PrimaryPart,"Closet")
					table.insert(esptable.lockers,h) 
					table.insert(esptableinstances, v)
				elseif (v.Name == "Rooms_Locker" or v.Name == "Rooms_Locker_Fridge") then
					local h = esp(v.PrimaryPart,Color3.fromRGB(145,100,25),v.PrimaryPart,"Locker")
					table.insert(esptable.lockers,h) 
					table.insert(esptableinstances, v)
				end
			end
		end

		local function setup(room)
			task.wait(.1)
			local assets = room:WaitForChild("Assets")

			if assets then
				local subaddcon
				subaddcon = assets.DescendantAdded:Connect(function(v)
					check(v) 
				end)

				for i,v in pairs(assets:GetDescendants()) do
					check(v)
				end

				task.spawn(function()
					repeat task.wait() until not flags.esplocker
					subaddcon:Disconnect()  
				end) 
			end 
		end

		local addconnect
		addconnect = workspace.CurrentRooms.ChildAdded:Connect(function(room)
			setup(room)
		end)

		for i,v in pairs(workspace.CurrentRooms:GetChildren()) do
			setup(v) 
			task.wait()
		end

		if workspace.CurrentRooms[tostring(game:GetService("ReplicatedStorage").GameData.LatestRoom.Value)]:FindFirstChild("Assets") then
			setup(workspace.CurrentRooms[tostring(game:GetService("ReplicatedStorage").GameData.LatestRoom.Value)])
		end

		repeat task.wait() until not flags.esplocker
		addconnect:Disconnect()

		for i,v in pairs(esptable.lockers) do
			v.delete()
		end 
	end
end)

window_esp.toggle("chest esp",false,function(val)
	flags.espchest = val

	if val then
		local function check(v)
			if table.find(esptableinstances, v) then
				return
			end

			if v:IsA("Model") then
				task.wait(0.1)
				if v.Name == "ChestBox" then
					warn(v.Name)
					local h = esp(v,Color3.fromRGB(205,120,255),v.PrimaryPart,"Chest")
					table.insert(esptable.chests,h) 
					table.insert(esptableinstances, v)
				elseif v.Name == "ChestBoxLocked" then
					local h = esp(v,Color3.fromRGB(255,120,205),v.PrimaryPart,"Locked Chest")
					table.insert(esptable.chests,h) 
					table.insert(esptableinstances, v)
				end
			end
		end

		local function setup(room)
			task.wait(.1)
			local subaddcon
			subaddcon = room.DescendantAdded:Connect(function(v)
				check(v) 
			end)

			for i,v in pairs(room:GetDescendants()) do
				check(v)
			end

			task.spawn(function()
				repeat task.wait() until not flags.espchest
				subaddcon:Disconnect()  
			end)  
		end

		local addconnect
		addconnect = workspace.CurrentRooms.ChildAdded:Connect(function(room)
			setup(room)
		end)

		for i,room in pairs(workspace.CurrentRooms:GetChildren()) do
			if room:FindFirstChild("Assets") then
				setup(room) 
			end
			task.wait()
		end

		if workspace.CurrentRooms[tostring(game:GetService("ReplicatedStorage").GameData.LatestRoom.Value)]:FindFirstChild("Assets") then
			setup(workspace.CurrentRooms[tostring(game:GetService("ReplicatedStorage").GameData.LatestRoom.Value)])
		end

		repeat task.wait() until not flags.espchest
		addconnect:Disconnect()

		for i,v in pairs(esptable.chests) do
			v.delete()
		end 
	end
end)

window_esp.toggle("player esp",false,function(val)
	flags.esphumans = val

	if val then
		local function personesp(v)
			if v:IsA("Player") then
				v.CharacterAdded:Connect(function(vc)
					local vh = vc:WaitForChild("Humanoid")
					local torso = vc:WaitForChild("UpperTorso")
					task.wait(0.1)

					local h = esp(vc,Color3.fromRGB(255,255,255),torso,v.DisplayName)
					table.insert(esptable.people,h) 
				end)

				if v.Character then
					local vc = v.Character
					local vh = vc:WaitForChild("Humanoid")
					local torso = vc:WaitForChild("UpperTorso")
					task.wait(0.1)

					local h = esp(vc,Color3.fromRGB(255,255,255),torso,v.DisplayName)
					table.insert(esptable.people,h) 
				end
			end
		end

		local addconnect
		addconnect = game.Players.PlayerAdded:Connect(function(v)
			if v ~= plr then
				personesp(v)
			end
		end)

		for i,v in pairs(game.Players:GetPlayers()) do
			if v ~= plr then
				personesp(v) 
			end
			task.wait()
		end

		if workspace.CurrentRooms[tostring(game:GetService("ReplicatedStorage").GameData.LatestRoom.Value)]:FindFirstChild("Assets") then
			personesp(workspace.CurrentRooms[tostring(game:GetService("ReplicatedStorage").GameData.LatestRoom.Value)])
		end

		repeat task.wait() until not flags.esphumans
		addconnect:Disconnect()

		for i,v in pairs(esptable.people) do
			v.delete()
		end 
	end
end)

window_esp.toggle("goldpile esp",false,function(val)
	flags.espgold = val

	if val then
		local function check(v)
			if table.find(esptableinstances, v) then
				return
			end

			if v:IsA("Model") then
				task.wait(0.1)
				local goldvalue = v:GetAttribute("GoldValue")

				if goldvalue and goldvalue >= flags.goldespvalue then
					local hitbox = v:WaitForChild("Hitbox")
					local h = esp(hitbox:GetChildren(),Color3.fromRGB(255,255,0),hitbox,"GoldPile [".. tostring(goldvalue).."]")
					table.insert(esptable.gold,h)
					table.insert(esptableinstances, v)
				end
			end
		end

		local function setup(room)
			task.wait(.1)
			local assets = room:WaitForChild("Assets")

			local subaddcon
			subaddcon = assets.DescendantAdded:Connect(function(v)
				check(v) 
			end)

			for i,v in pairs(assets:GetDescendants()) do
				check(v)
			end

			task.spawn(function()
				repeat task.wait() until not flags.espchest
				subaddcon:Disconnect()  
			end)  
		end

		local addconnect
		addconnect = workspace.CurrentRooms.ChildAdded:Connect(function(room)
			setup(room)
		end)

		for i,room in pairs(workspace.CurrentRooms:GetChildren()) do
			if room:FindFirstChild("Assets") then
				setup(room) 
			end
			task.wait()
		end

		if workspace.CurrentRooms[tostring(game:GetService("ReplicatedStorage").GameData.LatestRoom.Value)]:FindFirstChild("Assets") then
			setup(workspace.CurrentRooms[tostring(game:GetService("ReplicatedStorage").GameData.LatestRoom.Value)])
		end

		repeat task.wait() until not flags.espgold
		addconnect:Disconnect()

		for i,v in pairs(esptable.gold) do
			v.delete()
		end 
	end
end)

window_esp.slider("minimum gold value",5,150,5,5,function(val)
	flags.goldespvalue = val
end)

window_entities.toggle("notify entities",false,function(val)
	flags.hintrush = val
end)

window_entities.toggle("event prediction",false,function(val)
	flags.predictentities = val
end)
game:GetService("ReplicatedStorage").GameData.LatestRoom.Changed:Connect(function(value)
	if flags.predictentities == true then
		local ChaseStartVal = game:GetService("ReplicatedStorage").GameData.ChaseStart.Value - value;
		if ((0 < ChaseStartVal) and (ChaseStartVal < 4)) then
			--'" .. tostring(A) .. "' rooms
			warnmessage("EVENT PREDICTION", "There can be an event in or after Room "..tostring(game:GetService("ReplicatedStorage").GameData.LatestRoom.Value + ChaseStartVal).."!", 10);
		end
	end
end)

window_entities.toggle("disable seek chase",false,function(val)
	flags.noseek = val

	if val then
		local addconnect
		addconnect = workspace.CurrentRooms.ChildAdded:Connect(function(room)
			local trigger = room:WaitForChild("TriggerEventCollision",2)

			if trigger then
				trigger:Destroy() 
			end
		end)

		repeat task.wait() until not flags.noseek
		addconnect:Disconnect()
	end
end)

local screechremote = nil
if entityinfo ~= nil then
	screechremote = entityinfo:FindFirstChild("Screech")
end
window_entities.toggle("harmless screech",false,function(val)
	flags.noscreech = val

	if val and screechremote then
		screechremote.Parent = nil
		repeat task.wait() until not flags.noscreech
		screechremote.Parent = entityinfo
	end	
end)
workspace.CurrentCamera.ChildAdded:Connect(function(child)
	if child.Name == "Screech" and flags.noscreech == true then
		child:Destroy()
	end
end)


if hookmetamethod and newcclosure and getnamecallmethod then
	window_entities.label("do not click when playing the heartbeat minigame if you have 'always win heartbeat' on", 20)
	window_entities.toggle("always win heartbeat",false,function(val)
		flags.heartbeatwin = val
	end)

	local old
	old = hookmetamethod(game,"__namecall",newcclosure(function(self,...)
		local args = {...}
		local method = getnamecallmethod()

		if tostring(self) == 'ClutchHeartbeat' and method == "FireServer" and flags.heartbeatwin == true then
			args[2] = true
			return old(self,unpack(args))
		end

		return old(self,...)
	end))
else
	warnmessage("POOPDOORS EDITED v"..currentver, "You need to have hookmetamethod and newcclosure and getnamecallmethod functions for 'always win heartbeat'.", 7)
end

window_entities.toggle("avoid rush/ambush",false,function(val)
	flags.avoidrushambush = val
end)
workspace.ChildAdded:Connect(function(inst)
	spawn(function()
		if flags.avoidrushambush == false then
			if flags.hintrush == true then
				if table.find(entitynames, inst.Name) then
					repeat task.wait() until plr:DistanceFromCharacter(inst:GetPivot().Position) < 1000 or not inst:IsDescendantOf(workspace)

					if inst:IsDescendantOf(workspace) then
						--message(inst.Name:gsub("Moving",""):lower().." is coming go hide")
						warnmessage("ENTITIES", inst.Name:gsub("Moving","").." is coming. Hide!", 7)
						inst.Destroying:Wait()
						warnmessage("ENTITIES", "It's now safe to leave the hiding spot.", 7)
					end
				end
			end
		end
	end)

	if flags.avoidrushambush == true then
		if inst.Name == "RushMoving" or inst.Name == "AmbushMoving" then
			repeat task.wait() until plr:DistanceFromCharacter(inst:GetPivot().Position) < 1000 or not inst:IsDescendantOf(workspace)

			if inst:IsDescendantOf(workspace) then
				--message("avoiding "..inst.Name:gsub("Moving",""):lower())
				warnmessage("ENTITIES", "Avoiding "..inst.Name:gsub("Moving","")..". Please wait...", 10)

				local OldPos = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
				local oldwalkspeed = hum.WalkSpeed
				--[[local CurrentRoom = workspace.CurrentRooms[tostring(game:GetService("ReplicatedStorage").GameData.LatestRoom.Value - 1)]
				local basepart = nil
				local arraysizes = {}
				for _,v in pairs(CurrentRoom:GetChildren()) do if v.Name == "Base" and v:IsA("Part") then table.insert(arraysizes, v.Size) end end
				table.sort(arraysizes, function(a, b)
					return a.Magnitude > b.Magnitude
				end)
				for _,v in pairs(CurrentRoom:GetChildren()) do 
					if v.Name == "Base" and v:IsA("Part") then 
						if v.Size == arraysizes[1]then 
							basepart = v
							break
						end
					end 
				end--]]
				local function getrecentroom(index)
					local rooms = workspace.CurrentRooms:GetChildren() 
					table.sort(rooms,function(a,b)
						return tonumber(a.Name) > tonumber(b.Name) 
					end)

					return rooms[index]
				end
				local room = getrecentroom(2)
				local door = room:WaitForChild("Door")
				local con = game:GetService("RunService").Heartbeat:Connect(function()
					--	hum.WalkSpeed = 0
					if door then
						game.Players.LocalPlayer.Character:MoveTo(door.Door.Position + Vector3.new(0,avoidingYvalue,0))
					else
						game.Players.LocalPlayer.Character:MoveTo(OldPos + Vector3.new(0,avoidingYvalue,0))
					end
					--game.Players.LocalPlayer.Character:MoveTo(OldPos + Vector3.new(0,125,0))
				end)

				inst.Destroying:Wait()
				task.wait(0.35)
				con:Disconnect()

				for i = 1,5 do				
					game.Players.LocalPlayer.Character:MoveTo(door.Door.Position)--OldPos)
				end
			end
		end
	end
end)

--[[if hookmetamethod and newcclosure and getnamecallmethod then
	window_entities.toggle("no eyes damage (didnt tested it)",false,function(val)
		flags.noeyesdamage = val
	end)

	local old
	old = hookmetamethod(game,"__namecall",newcclosure(function(self,...)
		local args = {...}
		local method = getnamecallmethod()

		if tostring(self) == 'DMG' and method == "FireServer" and flags.noeyesdamage == true then
			args[1] = 0
			return __namecall(self, unpack(args))
		end
		if tostring(self) == 'FALLEN_SEE' and method == "FireServer" and flags.noeyesdamage == true then
			args[1] = false
			return __namecall(self, unpack(args))
		end

		if self == game.Players.LocalPlayer and method == "Kick" then return wait(9e9) end

		return old(self,...)
	end))
else
	warnmessage("POOPDOORS EDITED v"..currentver, "You need to have hookmetamethod and newcclosure and getnamecallmethod functions for 'no eyes damage'.", 7)
end--]]

window_roomsdoors.toggle("no seek arms and fire",false,function(val)
	flags.noseekarmsfire = val

	if val then
		for _,descendant in pairs(game:GetService("Workspace").CurrentRooms:GetDescendants()) do
			if descendant.Name == "Seek_Arm" or descendant.Name == "ChandelierObstruction" then
				descendant.Parent = nil
				descendant:Destroy()
			end
		end
	end
end)
game:GetService("Workspace").CurrentRooms.ChildAdded:Connect(function(descendant)
	if flags.noseekarmsfire == true then
		for _,descendant in pairs(game:GetService("Workspace").CurrentRooms:GetDescendants()) do
			if descendant.Name == "Seek_Arm" or descendant.Name == "ChandelierObstruction" then
				descendant.Parent = nil
				descendant:Destroy()
			end
		end
	end
end)

if fireproximityprompt then
	window_roomsdoors.button("skip room",function()
		pcall(function()
			local key = false
			local lever = false
			local CurrentDoor = workspace.CurrentRooms[tostring(game:GetService("ReplicatedStorage").GameData.LatestRoom.Value)]:WaitForChild("Door")
			for _,object in ipairs(CurrentDoor.Parent:GetDescendants()) do
				if object.Name == "KeyObtain" then
					key = object
				end
			end
			for _,object in ipairs(CurrentDoor.Parent:GetDescendants()) do
				if object.Name == "LeverForGate" then
					lever = object
				end
			end
			if LatestRoom.Value == 50 then
				CurrentDoor = workspace.CurrentRooms[tostring(LatestRoom.Value + 1)]:WaitForChild("Door")
				game.Players.LocalPlayer.Character:PivotTo(CFrame.new(CurrentDoor.Door.Position))
			else
				if key then
					game.Players.LocalPlayer.Character:PivotTo(CFrame.new(key.Hitbox.Position))
					task.wait(.3)
					fireproximityprompt(key.ModulePrompt)
					task.wait(.3)
					game.Players.LocalPlayer.Character:PivotTo(CFrame.new(CurrentDoor.Door.Position))
					task.wait(.3)
					fireproximityprompt(CurrentDoor.Lock.UnlockPrompt)
				end
				if lever then
					game.Players.LocalPlayer.Character:PivotTo(CFrame.new(lever.Main.Position))
					task.wait(.3)
					fireproximityprompt(lever.ActivateEventPrompt)
					task.wait(.3)
					game.Players.LocalPlayer.Character:PivotTo(CFrame.new(CurrentDoor.Door.Position))
				end
				game.Players.LocalPlayer.Character:PivotTo(CFrame.new(CurrentDoor.Door.Position))
			end
			task.wait(.45)
			CurrentDoor.ClientOpen:FireServer()
		end)
	end)
else
	warnmessage("POOPDOORS EDITED v"..currentver, "You need to have fireproximityprompt function for 'skip room'.", 7)
end

window_roomsdoors.button("skip room 50",function()
	pcall(function()
		if LatestRoom.Value == 50 then
			local CurrentDoor = workspace.CurrentRooms[tostring(LatestRoom.Value + 1)]:WaitForChild("Door")
			game.Players.LocalPlayer.Character:PivotTo(CFrame.new(CurrentDoor.Door.Position))
		end
	end)
end)


if fireproximityprompt then
	window_roomsdoors.toggle("auto skip room",false,function(val)
		flags.autoskiprooms = val
		
		pcall(function()
			if val then
				repeat
					local key = false
					local lever = false
					local CurrentDoor = workspace.CurrentRooms[tostring(game:GetService("ReplicatedStorage").GameData.LatestRoom.Value)]:WaitForChild("Door")
					for _,object in ipairs(CurrentDoor.Parent:GetDescendants()) do
						if object.Name == "KeyObtain" then
							key = object
						end
					end
					for _,object in ipairs(CurrentDoor.Parent:GetDescendants()) do
						if object.Name == "LeverForGate" then
							lever = object
						end
					end
					if LatestRoom.Value == 50 then
						CurrentDoor = workspace.CurrentRooms[tostring(LatestRoom.Value + 1)]:WaitForChild("Door")
						game.Players.LocalPlayer.Character:PivotTo(CFrame.new(CurrentDoor.Door.Position))
					else
						if key then
							game.Players.LocalPlayer.Character:PivotTo(CFrame.new(key.Hitbox.Position))
							task.wait(.3)
							fireproximityprompt(key.ModulePrompt)
							task.wait(.3)
							game.Players.LocalPlayer.Character:PivotTo(CFrame.new(CurrentDoor.Door.Position))
							task.wait(.3)
							fireproximityprompt(CurrentDoor.Lock.UnlockPrompt)
						end
						if lever then
							game.Players.LocalPlayer.Character:PivotTo(CFrame.new(lever.Main.Position))
							task.wait(.3)
							fireproximityprompt(lever.ActivateEventPrompt)
							task.wait(.3)
							game.Players.LocalPlayer.Character:PivotTo(CFrame.new(CurrentDoor.Door.Position))
						end
						game.Players.LocalPlayer.Character:PivotTo(CFrame.new(CurrentDoor.Door.Position))
					end
					task.wait(.45)
					CurrentDoor.ClientOpen:FireServer()
					task.wait(.1)
				until not flags.autoskiprooms
			end
		end)
	end)
else
	warnmessage("POOPDOORS EDITED v"..currentver, "You need to have fireproximityprompt function for 'skip room'.", 7)
end

window_misc.toggle("delete gates",false,function(val)
	flags.nogates = val

	if val then
		spawn(function()
			for _,room in pairs(workspace.CurrentRooms:GetChildren()) do
				local gate = room:WaitForChild("Gate",2)

				if gate then
					local door = gate:WaitForChild("ThingToOpen",2)

					if door then
						door:Destroy() 
					end
				end
			end
		end)

		local addconnect
		addconnect = workspace.CurrentRooms.ChildAdded:Connect(function(room)
			local gate = room:WaitForChild("Gate",2)

			if gate then
				local door = gate:WaitForChild("ThingToOpen",2)

				if door then
					door:Destroy() 
				end
			end
		end)

		spawn(function()
			local gate = workspace.CurrentRooms[tostring(game:GetService("ReplicatedStorage").GameData.LatestRoom.Value)]:WaitForChild("Gate",2)
			if gate then
				local door = gate:WaitForChild("ThingToOpen",2)
				if door then
					door:Destroy() 
				end
			end
		end)

		repeat task.wait() until not flags.nogates
		addconnect:Disconnect()
	end
end)

window_misc.toggle("delete puzzle door",false,function(val)
	flags.nopuzzle = val

	if val then
		spawn(function()
			for _,room in pairs(workspace.CurrentRooms:GetChildren()) do
				local assets = room:WaitForChild("Assets")
				local paintings = assets:WaitForChild("Paintings",2)

				if paintings then
					local door = paintings:WaitForChild("MovingDoor",2)

					if door then
						door:Destroy() 
					end 
				end
			end
		end)

		local addconnect
		addconnect = workspace.CurrentRooms.ChildAdded:Connect(function(room)
			local assets = room:WaitForChild("Assets")
			local paintings = assets:WaitForChild("Paintings",2)

			if paintings then
				local door = paintings:WaitForChild("MovingDoor",2)

				if door then
					door:Destroy() 
				end 
			end
		end)

		spawn(function()
			local assets = workspace.CurrentRooms[tostring(game:GetService("ReplicatedStorage").GameData.LatestRoom.Value)]:WaitForChild("Assets")
			local paintings = assets:WaitForChild("Paintings",2)
			if paintings then
				local door = paintings:WaitForChild("MovingDoor",2)
				if door then
					door:Destroy() 
				end 
			end
		end)

		repeat task.wait() until not flags.nopuzzle
		addconnect:Disconnect()
	end
end)

window_misc.toggle("no skeleton doors",false,function(val)
	flags.noskeledoors = val

	if val then
		local addconnect
		addconnect = workspace.CurrentRooms.ChildAdded:Connect(function(room)
			local door = room:WaitForChild("Wax_Door",2)

			if door then
				door:Destroy() 
			end
		end)

		spawn(function()
			local door = workspace.CurrentRooms[tostring(game:GetService("ReplicatedStorage").GameData.LatestRoom.Value)]:WaitForChild("Wax_Door",2)
			if door then
				door:Destroy() 
			end 
		end)

		repeat task.wait() until not flags.noskeledoors
		addconnect:Disconnect()
	end
end)

window_misc.toggle("auto library code",false,function(val)
	flags.getcode = val

	if val then
		local function deciphercode()
			local paper = char:FindFirstChild("LibraryHintPaper")
			local hints = plr.PlayerGui:WaitForChild("PermUI"):WaitForChild("Hints")

			local code = {[1]="_",[2]="_",[3]="_",[4]="_",[5]="_"}

			if paper then
				for i,v in pairs(paper:WaitForChild("UI"):GetChildren()) do
					if v:IsA("ImageLabel") and v.Name ~= "Image" then
						for i,img in pairs(hints:GetChildren()) do
							if img:IsA("ImageLabel") and img.Visible and v.ImageRectOffset == img.ImageRectOffset then
								local num = img:FindFirstChild("TextLabel").Text

								code[tonumber(v.Name)] = num 
							end
						end
					end
				end 
			end

			return code
		end

		local addconnect
		addconnect = char.ChildAdded:Connect(function(v)
			if v:IsA("Tool") and v.Name == "LibraryHintPaper" then
				task.wait()
				local code = table.concat(deciphercode())

				if code:find("_") then
					warnmessage("ROOM 50", "You are still missing some books! ('".. code.."').", 7)
				else
					normalmessage("ROOM 50", "The code is '".. code.."'.", 10)
				end
			end
		end)

		repeat task.wait() until not flags.getcode
		addconnect:Disconnect()
	end
end)

window_misc.toggle("A-000 door no locks",false,function(val)
	flags.roomsnolock = val

	if val then
		local function check(room)
			local door = room:WaitForChild("RoomsDoor_Entrance",2)

			if door then
				local prompt = door:WaitForChild("Door"):WaitForChild("EnterPrompt")
				prompt.Enabled = true
			end 
		end

		local addconnect
		addconnect = workspace.CurrentRooms.ChildAdded:Connect(function(room)
			check(room)
		end)

		for i,v in pairs(workspace.CurrentRooms:GetChildren()) do
			check(v)
		end

		spawn(function()
			check(workspace.CurrentRooms[tostring(game:GetService("ReplicatedStorage").GameData.LatestRoom.Value)])
		end)

		repeat task.wait() until not flags.roomsnolock
		addconnect:Disconnect()
	end
end)

if fireproximityprompt then
	window_misc.toggle("loot aura",false,function(val)
		flags.draweraura = val

		if val then
			local function setup(room)
				local function check(v)
					task.wait()
					if v:IsA("Model") then
						if v.PrimaryPart then
							if v.Name == "DrawerContainer" then
								local knob = v:WaitForChild("Knobs")

								if knob then
									local prompt = knob:WaitForChild("ActivateEventPrompt")
									local interactions = prompt:GetAttribute("Interactions")

									if not interactions then
										task.spawn(function()
											repeat task.wait(0.1)
												if plr:DistanceFromCharacter(knob.Position) <= 12 then
													fireproximityprompt(prompt)
												end
											until prompt:GetAttribute("Interactions") or not flags.draweraura
										end)
									end
								end
							elseif v.Name == "KeyObtain" then
								pcall(function()
									local prompt = v:WaitForChild("ModulePrompt")
									local interactions = prompt:GetAttribute("Interactions")

									if not interactions then
										task.spawn(function()
											repeat task.wait(0.1)
												pcall(function()
													if plr:DistanceFromCharacter(v.PrimaryPart.Position) <= 12 then
														fireproximityprompt(prompt) 
													end
												end)
											until prompt:GetAttribute("Interactions") or not flags.draweraura
										end)
									end
								end)
							elseif v.Name == "PickupItem" then
								if game:GetService("ReplicatedStorage").GameData.LatestRoom.Value == 51 or game:GetService("ReplicatedStorage").GameData.LatestRoom.Value == 52 then
									return
								end

								pcall(function()
									local prompt = v:WaitForChild("ModulePrompt")

									local okcanckl = 0
									task.spawn(function()
										repeat task.wait(0.1)
											if plr:DistanceFromCharacter(v.PrimaryPart.Position) <= 12 then
												fireproximityprompt(prompt) 
												okcanckl += 1
											end
										until not v:IsDescendantOf(workspace) or not prompt:IsDescendantOf(workspace) or not flags.draweraura or okcanckl > 20
									end)
								end)
							elseif v:GetAttribute("Pickup") or v:GetAttribute("PropType") then
								if game:GetService("ReplicatedStorage").GameData.LatestRoom.Value == 51 or game:GetService("ReplicatedStorage").GameData.LatestRoom.Value == 52 then
									return
								end

								pcall(function()
									local prompt = v:WaitForChild("ModulePrompt", 2)
									if prompt == nil then
										prompt = v:FindFirstChildWhichIsA("ProximityPrompt")
										if prompt == nil then
											for _,vvvvv in pairs(v:GetDescendants()) do
												if vvvvv:IsA("ProximityPrompt") then
													prompt = vvvvv
													break
												end
											end
										end
									end

									task.spawn(function()
										repeat task.wait(0.1)
											pcall(function()
												if plr:DistanceFromCharacter(v.PrimaryPart.Position) <= 12 then
													fireproximityprompt(prompt) 
												end
											end)
										until not v:IsDescendantOf(workspace) or not prompt:IsDescendantOf(workspace) or not flags.draweraura
									end)
								end)
							elseif v.Name == "GoldPile" then
								pcall(function()
									local prompt = v:WaitForChild("LootPrompt")
									local interactions = prompt:GetAttribute("Interactions")

									if not interactions then
										task.spawn(function()
											repeat task.wait(0.1)
												pcall(function()
													if plr:DistanceFromCharacter(v.PrimaryPart.Position) <= 12 then
														fireproximityprompt(prompt) 
													end 
												end)
											until prompt:GetAttribute("Interactions") or not flags.draweraura
										end)
									end
								end)
							elseif v.Name:sub(1,8) == "ChestBox" then
								local prompt = v:WaitForChild("ActivateEventPrompt")
								local interactions = prompt:GetAttribute("Interactions")

								if not interactions then
									task.spawn(function()
										repeat task.wait(0.1)
											pcall(function()
												if plr:DistanceFromCharacter(v.PrimaryPart.Position) <= 12 then
													fireproximityprompt(prompt)
												end
											end)
										until prompt:GetAttribute("Interactions") or not flags.draweraura
									end)
								end
							elseif v.Name == "RolltopContainer" then
								local prompt = v:WaitForChild("ActivateEventPrompt")
								local interactions = prompt:GetAttribute("Interactions")

								if not interactions then
									task.spawn(function()
										repeat task.wait(0.1)
											pcall(function()
												if plr:DistanceFromCharacter(v.PrimaryPart.Position) <= 12 then
													fireproximityprompt(prompt)
												end
											end)
										until prompt:GetAttribute("Interactions") or not flags.draweraura
									end)
								end
							end 
						end
					end
				end

				local subaddcon
				subaddcon = room.DescendantAdded:Connect(function(v)
					check(v) 
				end)

				for i,v in pairs(room:GetDescendants()) do
					check(v)
				end

				task.spawn(function()
					repeat task.wait() until not flags.draweraura
					subaddcon:Disconnect() 
				end)
			end

			local addconnect
			addconnect = workspace.CurrentRooms.ChildAdded:Connect(function(room)
				setup(room)
			end)

			for i,room in pairs(workspace.CurrentRooms:GetChildren()) do
				if room:FindFirstChild("Assets") then
					setup(room) 
				end
			end
			if workspace.CurrentRooms[tostring(game:GetService("ReplicatedStorage").GameData.LatestRoom.Value)]:FindFirstChild("Assets") then
				setup(workspace.CurrentRooms[tostring(game:GetService("ReplicatedStorage").GameData.LatestRoom.Value)])
			end

			repeat task.wait() until not flags.draweraura
			addconnect:Disconnect()
		end
	end)
else
	warnmessage("POOPDOORS EDITED v"..currentver, "You need to have fireproximityprompt function for 'loot aura'.", 7)
end

if fireproximityprompt then
	window_misc.toggle("book aura",false,function(val)
		flags.bookcollecter = val

		if val then
			local function setup(room)
				local function check(v)
					if v:IsA("Model") then
						if v.PrimaryPart then
							if v.Name == "LiveHintBook" then
								local prompt = v:WaitForChild("ActivateEventPrompt")

								local okcanckl = 0
								task.spawn(function()
									repeat task.wait(0.1)
										if plr:DistanceFromCharacter(v.PrimaryPart.Position) <= 12 then
											fireproximityprompt(prompt) 
											okcanckl += 1
										end
									until not v:IsDescendantOf(workspace) or not prompt:IsDescendantOf(workspace) or not flags.bookcollecter or okcanckl > 50
								end)
							end
						end
					end

				end

				local subaddcon
				subaddcon = room.DescendantAdded:Connect(function(v)
					check(v) 
				end)

				for i,v in pairs(room:GetDescendants()) do
					check(v)
				end

				task.spawn(function()
					repeat task.wait() until not flags.bookcollecter
					subaddcon:Disconnect() 
				end)
			end

			repeat task.wait()if flags.bookcollecter == false then break end until game:GetService("ReplicatedStorage").GameData.LatestRoom.Value == 50

			if flags.bookcollecter == true then
				local addconnect
				addconnect = workspace.CurrentRooms.ChildAdded:Connect(function(room)
					setup(room)
				end)

				for i,room in pairs(workspace.CurrentRooms:GetChildren()) do
					if room:FindFirstChild("Assets") then
						setup(room) 
					end
				end
				--	if workspace.CurrentRooms[tostring(game:GetService("ReplicatedStorage").GameData.LatestRoom.Value)]:FindFirstChild("Assets") then
				setup(workspace.CurrentRooms[tostring(game:GetService("ReplicatedStorage").GameData.LatestRoom.Value)])
				--	end

				repeat task.wait() until not flags.bookcollecter
				addconnect:Disconnect()
			end
		end
	end)
else
	warnmessage("POOPDOORS EDITED v"..currentver, "You need to have fireproximityprompt function for 'book aura'.", 7)
end

if fireproximityprompt then
	window_misc.toggle("breaker aura",false,function(val)
		flags.breakercollecter = val

		if val then
			local function setup(room)
				local function check(v)
					if v:IsA("Model") then
						if v.PrimaryPart then
							if v.Name == "LiveBreakerPolePickup" then
								local prompt = v:WaitForChild("ActivateEventPrompt")

								local okcanckl = 0
								task.spawn(function()
									repeat task.wait(0.1)
										if plr:DistanceFromCharacter(v.PrimaryPart.Position) <= 12 then
											fireproximityprompt(prompt) 
											okcanckl += 1
										end
									until not v:IsDescendantOf(workspace) or not prompt:IsDescendantOf(workspace) or not flags.breakercollecter or okcanckl > 50
								end)
							end
						end
					end

				end

				local subaddcon
				subaddcon = room.DescendantAdded:Connect(function(v)
					check(v) 
				end)

				for i,v in pairs(room:GetDescendants()) do
					check(v)
				end

				task.spawn(function()
					repeat task.wait() until not flags.breakercollecter
					subaddcon:Disconnect() 
				end)
			end

			repeat task.wait()if flags.breakercollecter == false then break end until game:GetService("ReplicatedStorage").GameData.LatestRoom.Value == 100

			if flags.breakercollecter == true then
				local addconnect
				addconnect = workspace.CurrentRooms.ChildAdded:Connect(function(room)
					setup(room)
				end)

				for i,room in pairs(workspace.CurrentRooms:GetChildren()) do
					if room:FindFirstChild("Assets") then
						setup(room) 
					end
				end
				--	if workspace.CurrentRooms[tostring(game:GetService("ReplicatedStorage").GameData.LatestRoom.Value)]:FindFirstChild("Assets") then
				setup(workspace.CurrentRooms[tostring(game:GetService("ReplicatedStorage").GameData.LatestRoom.Value)])
				--	end

				repeat task.wait() until not flags.breakercollecter
				addconnect:Disconnect()
			end
		end
	end)
else
	warnmessage("POOPDOORS EDITED v"..currentver, "You need to have fireproximityprompt function for 'book aura'.", 7)
end

if #game.Players:GetChildren() <= 1 or #game.Players:GetChildren() == 0 then
	window_misc.button("instant leave",function()
		confirmnotification("CONFIRM", "Are you sure you want to leave?", 15, function(state)
			if state == true then
				task.spawn(function()
					task.wait(.05)
					game:Shutdown()
				end)
				game.Players.LocalPlayer:Kick()
			end
		end)
	end)
end

if syn then
	if syn.queue_on_teleport then
		window_experimentals.button("start a new solo run", function()
			syn.queue_on_teleport([[
				game.Loaded:Wait()
				loadstring(game:HttpGet(("https://raw.githubusercontent.com/mstudio45/poopdoors_edited/main/joinsolo.lua"),true))()
			]])
			game:GetService("TeleportService"):Teleport(6516141723, game:GetService("Players").LocalPlayer)
		end)
	end
elseif queue_on_teleport then
	window_experimentals.button("start a new solo run", function()
		queue_on_teleport([[
			game.Loaded:Wait()
			loadstring(game:HttpGet(("https://raw.githubusercontent.com/mstudio45/poopdoors_edited/main/joinsolo.lua"),true))()	
		]])
		game:GetService("TeleportService"):Teleport(6516141723, game:GetService("Players").LocalPlayer)
	end)
end

window_anticheatbyppasses.label("method 1 info:",30)
window_anticheatbyppasses.label("this method will make it so you CANT pick up ANYTHING so only do this in multiplayer",40)
window_anticheatbyppasses.label("if you use this in rooms you will may not get the a-1000 badge!", 40)
window_anticheatbyppasses.button("method 1",function()
	confirmnotification("AC BYPASS", "Are you sure you want to bypass anticheat with method 1?", 15, function(state)
		if state == true then
			normalmessage("AC BYPASS", "Anticheat bypassed with method 1!", 7)
			flags.anticheatbypass = true
			local newhum = hum:Clone()
			newhum.Name = "humlol"
			newhum.Parent = char
			task.wait()
			hum.Parent = nil

			hum = newhum
			walkspeedslider.setmax(75)
		end
	end)
end)

window_anticheatbyppasses.label("method 2 info:",30)
window_anticheatbyppasses.label("with this method you will not see proximity prompts but some still works",50)
window_anticheatbyppasses.label("if you want to use this method run it after the elevator is closed",30)
window_anticheatbyppasses.label("credits: Renzoo#5106", 10)
window_anticheatbyppasses.button("method 2", function()
	confirmnotification("AC BYPASS", "Are you sure you want to bypass anticheat with method 2?", 15, function(state)
		if state == true then
			task.spawn(function()
				local FLYING = false
				local QEfly = true
				local iyflyspeed = 1
				local vehicleflyspeed = 1
				local RunService = game:GetService("RunService")
				local Players = game:GetService("Players")
				local IYMouse = game.Players.LocalPlayer:GetMouse()
				local flyKeyDown,flyKeyUp
				local function sFLY(vfly)
					repeat wait() until Players.LocalPlayer and Players.LocalPlayer.Character and getRoot(Players.LocalPlayer.Character) and Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
					repeat wait() until IYMouse
					if flyKeyDown or flyKeyUp then flyKeyDown:Disconnect() flyKeyUp:Disconnect() end

					local T = getRoot(Players.LocalPlayer.Character)
					local CONTROL = {F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0}
					local lCONTROL = {F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0}
					local SPEED = 0

					local function FLY()
						FLYING = true
						local BG = Instance.new('BodyGyro')
						local BV = Instance.new('BodyVelocity')
						BG.P = 9e4
						BG.Parent = T
						BV.Parent = T
						BG.maxTorque = Vector3.new(9e9, 9e9, 9e9)
						BG.cframe = T.CFrame
						BV.velocity = Vector3.new(0, 0, 0)
						BV.maxForce = Vector3.new(9e9, 9e9, 9e9)
						task.spawn(function()
							repeat wait()
								if not vfly and Players.LocalPlayer.Character:FindFirstChildOfClass('Humanoid') then
									Players.LocalPlayer.Character:FindFirstChildOfClass('Humanoid').PlatformStand = true
								end
								if CONTROL.L + CONTROL.R ~= 0 or CONTROL.F + CONTROL.B ~= 0 or CONTROL.Q + CONTROL.E ~= 0 then
									SPEED = 50
								elseif not (CONTROL.L + CONTROL.R ~= 0 or CONTROL.F + CONTROL.B ~= 0 or CONTROL.Q + CONTROL.E ~= 0) and SPEED ~= 0 then
									SPEED = 0
								end
								if (CONTROL.L + CONTROL.R) ~= 0 or (CONTROL.F + CONTROL.B) ~= 0 or (CONTROL.Q + CONTROL.E) ~= 0 then
									BV.velocity = ((workspace.CurrentCamera.CoordinateFrame.lookVector * (CONTROL.F + CONTROL.B)) + ((workspace.CurrentCamera.CoordinateFrame * CFrame.new(CONTROL.L + CONTROL.R, (CONTROL.F + CONTROL.B + CONTROL.Q + CONTROL.E) * 0.2, 0).p) - workspace.CurrentCamera.CoordinateFrame.p)) * SPEED
									lCONTROL = {F = CONTROL.F, B = CONTROL.B, L = CONTROL.L, R = CONTROL.R}
								elseif (CONTROL.L + CONTROL.R) == 0 and (CONTROL.F + CONTROL.B) == 0 and (CONTROL.Q + CONTROL.E) == 0 and SPEED ~= 0 then
									BV.velocity = ((workspace.CurrentCamera.CoordinateFrame.lookVector * (lCONTROL.F + lCONTROL.B)) + ((workspace.CurrentCamera.CoordinateFrame * CFrame.new(lCONTROL.L + lCONTROL.R, (lCONTROL.F + lCONTROL.B + CONTROL.Q + CONTROL.E) * 0.2, 0).p) - workspace.CurrentCamera.CoordinateFrame.p)) * SPEED
								else
									BV.velocity = Vector3.new(0, 0, 0)
								end
								BG.cframe = workspace.CurrentCamera.CoordinateFrame
							until not FLYING
							CONTROL = {F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0}
							lCONTROL = {F = 0, B = 0, L = 0, R = 0, Q = 0, E = 0}
							SPEED = 0
							BG:Destroy()
							BV:Destroy()
							if Players.LocalPlayer.Character:FindFirstChildOfClass('Humanoid') then
								Players.LocalPlayer.Character:FindFirstChildOfClass('Humanoid').PlatformStand = false
							end
						end)
					end
					flyKeyDown = IYMouse.KeyDown:Connect(function(KEY)
						if KEY:lower() == 'w' then
							CONTROL.F = (vfly and vehicleflyspeed or iyflyspeed)
						elseif KEY:lower() == 's' then
							CONTROL.B = - (vfly and vehicleflyspeed or iyflyspeed)
						elseif KEY:lower() == 'a' then
							CONTROL.L = - (vfly and vehicleflyspeed or iyflyspeed)
						elseif KEY:lower() == 'd' then 
							CONTROL.R = (vfly and vehicleflyspeed or iyflyspeed)
						elseif QEfly and KEY:lower() == 'e' then
							CONTROL.Q = (vfly and vehicleflyspeed or iyflyspeed)*2
						elseif QEfly and KEY:lower() == 'q' then
							CONTROL.E = -(vfly and vehicleflyspeed or iyflyspeed)*2
						end
						pcall(function() workspace.CurrentCamera.CameraType = Enum.CameraType.Track end)
					end)
					flyKeyUp = IYMouse.KeyUp:Connect(function(KEY)
						if KEY:lower() == 'w' then
							CONTROL.F = 0
						elseif KEY:lower() == 's' then
							CONTROL.B = 0
						elseif KEY:lower() == 'a' then
							CONTROL.L = 0
						elseif KEY:lower() == 'd' then
							CONTROL.R = 0
						elseif KEY:lower() == 'e' then
							CONTROL.Q = 0
						elseif KEY:lower() == 'q' then
							CONTROL.E = 0
						end
					end)
					FLY()
				end

				local function NOFLY()
					FLYING = false
					if flyKeyDown or flyKeyUp then flyKeyDown:Disconnect() flyKeyUp:Disconnect() end
					if Players.LocalPlayer.Character:FindFirstChildOfClass('Humanoid') then
						Players.LocalPlayer.Character:FindFirstChildOfClass('Humanoid').PlatformStand = false
					end
					pcall(function() workspace.CurrentCamera.CameraType = Enum.CameraType.Custom end)
				end

				local function getRoot(char)
					local rootPart = char:FindFirstChild('HumanoidRootPart') or char:FindFirstChild('Torso') or char:FindFirstChild('UpperTorso')
					return rootPart
				end
				local speaker = game.Players.LocalPlayer
				local ch = speaker.Character
				local prt=Instance.new("Model")
				prt.Parent = speaker.Character

				local z1 = Instance.new("Part")
				z1.Name="Torso"
				z1.CanCollide = false
				z1.Anchored = true

				local z2 = Instance.new("Part")
				z2.Name="Head"
				z2.Parent = prt
				z2.Anchored = true
				z2.CanCollide = false

				local z3 =Instance.new("Humanoid")
				z3.Name="Humanoid"
				z3.Parent = prt

				z1.Position = Vector3.new(0,9999,0)
				speaker.Character=prt
				wait(3)
				speaker.Character=ch
				wait(3)
				local Hum = Instance.new("Humanoid")
				z2:Clone()
				Hum.Parent = speaker.Character
				--hum = Hum
				local root = getRoot(speaker.Character)
				for i,v in pairs(speaker.Character:GetChildren()) do
					if v ~= root and  v.Name ~= "Humanoid" then
						v:Destroy()
					end
				end
				root.Transparency = 0
				root.Color = Color3.new(1, 1, 1)

				local invisflingStepped
				invisflingStepped = RunService.Stepped:Connect(function()
					if speaker.Character and getRoot(speaker.Character) then
						getRoot(speaker.Character).CanCollide = false
					else
						invisflingStepped:Disconnect()
					end
				end)
				iyflyspeed = 1.5
				sFLY()
				workspace.CurrentCamera.CameraSubject = root
				game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.All, true)
				game:GetService("StarterGui"):SetCore("ResetButtonCallback", true)
				normalmessage("AC BYPASS", "Done!", 5)
				flags.anticheatbypass = true
			end)
		end
	end)
end)

local Path = nil
local Wardrobes = {}
local Wardrobe = nil
local CurrentWardrobe = nil
local inRooms = false
if game.ReplicatedStorage:WaitForChild("GameData"):WaitForChild("Floor").Value == "Rooms" then
	inRooms = true
	window_rooms.show()

	local a90remote = game.ReplicatedStorage:WaitForChild("EntityInfo"):WaitForChild("A90")

	window_rooms.toggle("harmless A90",false,function(val)
		flags.noa90 = val

		if val then
			local jumpscare = plr.PlayerGui:WaitForChild("MainUI"):WaitForChild("Jumpscare"):FindFirstChild("Jumpscare_A90")

			if jumpscare then
				jumpscare.Parent = nil

				a90remote.Parent = nil
				repeat task.wait()
					game.SoundService.Main.Volume = 1
				until not flags.noa90
				jumpscare.Parent = plr.PlayerGui.MainUI.Jumpscare
				a90remote.Parent = entityinfo 
			end
		end
	end)

	function hidefunc()
		Wardrobes = {}
		Wardrobe = nil
		CurrentWardrobe = nil
		if Path then Path:Stop();Path = nil end
		for _,v in pairs(game:GetService("Workspace").CurrentRooms[game:GetService("ReplicatedStorage").GameData.LatestRoom.Value].Assets:GetChildren()) do
			if (v.Name == "Rooms_Locker" or v.Name == "Rooms_Locker_Fridge") and v:FindFirstChild("HidePrompt") and not table.find(Wardrobes, v) then
				pcall(function()
					v.WalkToPart:Destroy()
				end)
				local newPart = Instance.new("Part",v)
				newPart.Anchored = true
				newPart.CFrame = v.Base.CFrame:ToWorldSpace(CFrame.new(0, -4, -4))
				newPart.Name = "WalkToPart"
				newPart.CanCollide = false
				newPart.Transparency = 1
				table.insert(Wardrobes, v)
			end
		end
		for i = 1, 2 do
			task.spawn(function()
				for _,v in pairs(game:GetService("Workspace").CurrentRooms[game:GetService("ReplicatedStorage").GameData.LatestRoom.Value-i].Assets:GetChildren()) do
					if (v.Name == "Rooms_Locker" or v.Name == "Rooms_Locker_Fridge") and v:FindFirstChild("HidePrompt") and not table.find(Wardrobes, v) then
						pcall(function()
							v.WalkToPart:Destroy()
						end)
						local newPart = Instance.new("Part",v)
						newPart.Anchored = true
						newPart.CFrame = v.Base.CFrame:ToWorldSpace(CFrame.new(0, -4, -4))
						newPart.Name = "WalkToPart"
						newPart.CanCollide = false
						newPart.Transparency = 1
						table.insert(Wardrobes, v)
					end
				end
			end)
		end

		Wardrobe = Wardrobes[1]
		if #Wardrobes == 1 then
			Wardrobe = Wardrobes[1]
		else
			for i,v in pairs(Wardrobes) do
				if (game.Players.LocalPlayer.Character.PrimaryPart.Position - v.WalkToPart.Position).magnitude < (Wardrobe.WalkToPart.Position - game.Players.LocalPlayer.Character.PrimaryPart.Position).magnitude then
					Wardrobe = v
				end
			end
		end

		if Wardrobe.HiddenPlayer.Value ~= nil then
			pcall(function()
				table.remove(Wardrobes, Wardrobe)
			end)
			pcall(function()
				table.remove(Wardrobes, table.find(Wardrobes, Wardrobe))
			end)
			repeat
				task.wait()
				for i,v in pairs(Wardrobes) do
					if (game.Players.LocalPlayer.Character.PrimaryPart.Position - v.WalkToPart.Position).magnitude < (Wardrobe.WalkToPart.Position - game.Players.LocalPlayer.Character.PrimaryPart.Position).magnitude then
						Wardrobe = v
					end
				end
				local breewk = false
				--Wardrobe = Wardrobes[math.random(1, #Wardrobes)]
				pcall(function()
					if Wardrobe.HiddenPlayer.Value ~= nil then
						pcall(function()
							table.remove(Wardrobes, Wardrobe)
						end)
						pcall(function()
							table.remove(Wardrobes, table.find(Wardrobes, Wardrobe))
						end)
					else
						breewk = true
					end
				end)
				if breewk == true then break end
			until Wardrobe.HiddenPlayer.Value == nil
		end

		local HIDDEN = false
		if not Wardrobe:FindFirstChild("WalkToPart") then
			pcall(function()
				Wardrobe.WalkToPart:Destroy()
			end)
			local newPart = Instance.new("Part", Wardrobe)
			newPart.Anchored = true
			newPart.CFrame = Wardrobe.Base.CFrame:ToWorldSpace(CFrame.new(0, -4, -4))
			newPart.Name = "WalkToPart"
			newPart.CanCollide = false
			newPart.Transparency = 1
		end
		--local Goal = Wardrobe.WalkToPart.Position
		local Path = SimplePath.new(game.Players.LocalPlayer.Character, {
			AgentCanJump = false
		}, {
			TIME_VARIANCE = 0.07;
			COMPARISON_CHECKS = 5;
			JUMP_WHEN_STUCK = false;
		})
		Path.Visualize = true	
		Path.Blocked:Connect(function()
			if HIDDEN == true then if Path then Path:Stop() end return end
			--print("Path Blocked")
			if Path then
				Path:Run(Wardrobe.WalkToPart.Position)
			end
		end)
		Path.WaypointReached:Connect(function()
			if HIDDEN == true then if Path then Path:Stop() end return end
			if Path then
				Path:Run(Wardrobe.WalkToPart.Position)
			end
		end)
		Path.Error:Connect(function(errorType)
			if HIDDEN == true then if Path then Path:Stop() end return end
			--print("Path Error",errorType)
			if Path then
				Path:Run(Wardrobe.WalkToPart.Position)
			end
		end)
		Path.Reached:Connect(function()
			if Path then Path:Stop() end
			task.spawn(function()
				repeat
					task.wait()
					fireproximityprompt(Wardrobe.HidePrompt)
					if Wardrobe.HiddenPlayer.Value ~= nil then
						if Wardrobe.HiddenPlayer.Value.Name == game.Players.LocalPlayer.Name then
							if Path then Path:Stop() end
							HIDDEN = true
							CurrentWardrobe = Wardrobe
							break
						end
					end
				until true
			end)
		end)
		Path:Run(Wardrobe.WalkToPart.Position)
	end
	
	function unhidefunc()
		task.wait()
		game:GetService("VirtualUser"):SetKeyDown(119)
		task.wait(.5)
		game:GetService("VirtualUser"):SetKeyUp(119)
		CurrentWardrobe = nil
	end

	window_rooms.toggle("auto a-1000 (beta)",false,function(val)
		if flags.noa90 == false then
			normalmessage("AUTO A-1000", "Enable 'harmless a90' and keep this on if you want to use this.", 5)
			return
		end
		flags.autorooms = val
		normalmessage("AUTO A-1000", "IN BETA.", 10)
		
		if val then
			local hide = false

			local function getrecentroom(index)
				local rooms = workspace.CurrentRooms:GetChildren() 
				table.sort(rooms,function(a,b)
					return tonumber(a.Name) > tonumber(b.Name) 
				end)

				return rooms[index]
			end

			local entconnect
			entconnect = workspace.ChildAdded:Connect(function(v)
				if v:IsA("Model") then
					if v.Name == "A60" or v.Name == "A120" then
						hide = true

						--repeat task.wait() until not v:IsDescendantOf(workspace)
						v.Destroying:Wait()
						task.wait(0.35)
						hide = false
					end
				end
			end)
			
			local Finished
			while flags.autorooms do
				if flags.noa90 == false then
					break
				end
				
				if hide then
					if #Wardrobes >= 1 then
						hidefunc()
						repeat task.wait() until not hide
						unhidefunc()
					else
						local OldPos = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
						local function getrecentroom(index)
							local rooms = workspace.CurrentRooms:GetChildren() 
							table.sort(rooms,function(a,b)
								return tonumber(a.Name) > tonumber(b.Name) 
							end)

							return rooms[index]
						end
						local room = getrecentroom(2)
						local door = room:WaitForChild("Door")
						local con = game:GetService("RunService").Heartbeat:Connect(function()
							--	hum.WalkSpeed = 0
							if door then
								game.Players.LocalPlayer.Character:MoveTo(door.Door.Position + Vector3.new(0,avoidingYvalue,0))
							else
								game.Players.LocalPlayer.Character:MoveTo(OldPos + Vector3.new(0,avoidingYvalue,0))
							end
							--game.Players.LocalPlayer.Character:MoveTo(OldPos + Vector3.new(0,125,0))
						end)

						repeat task.wait() until not hide
						con:Disconnect()

						for i = 1,15 do				
							game.Players.LocalPlayer.Character:MoveTo(door.Door.Position)--OldPos)
							task.wait()
						end
					end
					if flags.noa90 == false then
						return
					end
				else
					repeat
						unhidefunc()
						task.wait()
						if flags.noa90 == false then
							break
						end
						task.wait()
						local room = workspace.CurrentRooms[tostring(game:GetService("ReplicatedStorage").GameData.LatestRoom.Value)]
						local door = room:FindFirstChild("Door")
						if door == nil then
							for _,v in pairs(room:GetChildren()) do
								if v.Name == "Door" and v:IsA("Model") and v:FindFirstChild("ClientOpen") then
									door = v
									break
								end
							end
						end
						
						Finished = false
						if Path then Path:Stop();Path = nil end
						--local Goal = door.Door.Position
						
						print("Going to",getrecentroom(1).Name..".")
						
						Path = SimplePath.new(game.Players.LocalPlayer.Character, {
							AgentCanJump = false
						}, {
							TIME_VARIANCE = 0.07;
							COMPARISON_CHECKS = 5;
							JUMP_WHEN_STUCK = false;
						})
						Path.Visualize = true	
						Path.Blocked:Connect(function()
							if Finished == true then if Path then Path:Stop() end return end
							if hide == true then
								repeat task.wait() until not hide
								unhidefunc()
							end
							--print("Path Blocked")
							if Path then
								Path:Run(door.Door.Position)
							end
						end)
						Path.WaypointReached:Connect(function()
							if Finished == true then if Path then Path:Stop() end return end
							if hide == true then
								repeat task.wait() until not hide
								unhidefunc()
							end
							if Path then
								Path:Run(door.Door.Position)
							end
						end)
						Path.Error:Connect(function(errorType)
							if Finished == true then if Path then Path:Stop() end return end
							if hide == true then
								repeat task.wait() until not hide
								unhidefunc()
							end
							--print("Path Error",errorType)
							if errorType == SimplePath.ErrorType.TargetUnreachable then
								if Path then
									Path:Run(door.Door.Position)
								end
							end
							--Path:Run(Goal)
						end)
						Path.Reached:Connect(function()
							if Path then Path:Stop() end
							Finished = true
							Path = nil
						end)
						Path:Run(door.Door.Position)
						
						repeat task.wait() until Finished == true or hide == true or flags.noa90 == false
					until lastroom ~= room or not flags.autorooms or hide == true or flags.noa90 == false
				end

				task.wait()
			end
			entconnect:Disconnect()
			if flags.noa90 == false then
				normalmessage("AUTO A-1000", "Enable 'harmless a90' and keep this on if you want to use this.", 5)
			end
		end
	end)
end

local hidden = false
function toggleguis()
	for _,v in pairs(gui_windows) do
		if hidden == false then
			v.hide()
			if inRooms == true then
				window_rooms.hide()
			end
		elseif hidden == true then
			v.show()
			if inRooms == true then
				window_rooms.show()
			end
		end
	end
	hidden = not hidden
end
window_misc.button("hide gui",function(val)
	normalmessage("POOPDOORS EDITED v"..currentver, "To toggle gui press 'RightShift'", 10)
	toggleguis()
end)
local aaaaa = game.UserInputService.InputBegan:Connect(function(key,gpa)
	--if gpa then return end
	if key.KeyCode == Enum.KeyCode.RightShift then
		toggleguis()
	end
end)

window_misc.button("close gui",function()
	if Path then Path:Stop();Path = nil end
	aaaaa:Disconnect()
	flags = DELFLAGS
	walkspeedtoggle = false
	pcall(function()
		for _,e in pairs(esptable) do
			for _,v in pairs(e) do
				pcall(function()
					v.delete()
				end)
			end
		end
	end)

	pcall(function() getgenv().POOPDOORSLOADED = false;POOPDOORSLOADED = false end)
	task.wait(.1)
	library.delete()
	normalmessage("POOPDOORS EDITED v"..currentver, "GUI closed!")
end)

normalmessage("POOPDOORS EDITED v"..currentver, "Script loaded!")
