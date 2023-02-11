-- edited by mstudio45 | original by https://v3rmillion.net/member.php?action=profile&uid=1802731 
-- https://v3rmillion.net/showthread.php?tid=1200475

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

function warnmessage(title, text, timee)
	Notification:Notify(
		{Title = title, Description = text},
		{OutlineColor = Color3.fromRGB(80, 80, 80),Time = timee or 5, Type = "image"},
		{Image = "http://www.roblox.com/asset/?id=6023426923", ImageColor = Color3.fromRGB(255, 84, 84)}
	)
end

if POOPDOORSLOADED then warnmessage("POOPDOORS EDITED", "GUI already loaded!", 10) return end
pcall(function() getgenv().POOPDOORSLOADED = true end)

-- credits alan1508 on v3erm
do
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
end

normalmessage("INFO", [[Currently fixing auto a-1000 and some bugs]])

local library = loadstring(game:HttpGet('https://pastebin.com/raw/vPWzQEC8'))()
local plr = game.Players.LocalPlayer
local char = plr.Character or plr.CharacterAdded:Wait()
local hum = char:FindFirstChildOfClass("Humanoid") or char:WaitForChild("Humanoid")
local LatestRoom = game:GetService("ReplicatedStorage").GameData.LatestRoom
local Players = game:GetService("Players")

if not fireproximityprompt then
	local msg = Instance.new("Message",workspace)
	msg.Text = "you dont have fireproximityprompt function bro get better executor"
	task.wait(6)
	msg:Destroy()
	error("no prox") 
end

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
	if entityinfo == nil then 
		if game.ReplicatedStorage:FindFirstChild("EntityInfo") then 
			entityinfo = game.ReplicatedStorage:FindFirstChild("EntityInfo") 
		else
			entityinfo = game.ReplicatedStorage:WaitForChild("EntityInfo")
		end		
	end
end)

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
	predictentities = false
}

local DELFLAGS = {table.unpack(flags)}
local esptable = {doors={},keys={},items={},books={},entity={},chests={},lockers={},people={},gold={}}

local window_player = library.window("player")
local window_entities = library.window("entities")
local window_roomsdoors = library.window("rooms (doors)")
local window_esp = library.window("esp")
local window_misc = library.window("misc")
local window_anticheatbyppasses = library.window("anticheat bypasses")

local window_credits = library.window("credits")
window_credits.label("original by: zoophiliaphobic#6287 (v3rm acc: 1802731)",32)
window_credits.label("v3rm post: 1200475", 15)
window_credits.label("edited by: mstudio45",32)

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

window_player.toggle("instant use",false,function(val)
	flags.instapp = val

	local holdconnect
	holdconnect = game:GetService("ProximityPromptService").PromptButtonHoldBegan:Connect(function(p)
		fireproximityprompt(p)
	end)

	repeat task.wait() until not flags.instapp
	holdconnect:Disconnect()
end)

local walkspeedtoggle = false
local walkspeedslider = window_player.slider("walkspeed",16,25,1,16,function(val)
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

window_player.label("credits: zoophiliaphobic#6287\noh my dayyzz",20)

task.spawn(function()
	while task.wait() do
		if walkspeedtoggle == true then
			if hum.WalkSpeed < flags.speed then
				hum.WalkSpeed = flags.speed
			end
		end
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

window_player.button("kill yourself", function()
	game.Players.LocalPlayer.Character.Humanoid.Health = 0
end)

window_player.label("\nif you use it anyone will be able to join your game and expose you of exploiting\nuse at your own risk",32)
window_player.button("rejoin revive", function()
	if #game:GetService("Players"):GetPlayers() <= 1 then
		game:GetService("Players").LocalPlayer:Kick("\nRejoining...")
		task.wait()
		game:GetService("TeleportService"):Teleport(game.PlaceId, game:GetService("Players").LocalPlayer)
	else
		game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId, game:GetService("Players").LocalPlayer)
	end
end)

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

				local h = esp(v,Color3.fromRGB(160,190,255),v.PrimaryPart,"Book")
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

window_entities.toggle("event notifier",false,function(val)
	flags.predictentities = val
end)
game:GetService("ReplicatedStorage").GameData.LatestRoom.Changed:Connect(function(value)
	if flags.predictentities == true then
		local A = game:GetService("ReplicatedStorage").GameData.LatestRoom.ChaseStart.Value - value;
		if ((0 < A) and (A < 4)) then
			warnmessage("EVENT NOTIFIER", "There is an event in '" .. tostring(A) .. "' rooms!", 10);
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
	warnmessage("POOPDOORS EDITED", "You need to have hookmetamethod and newcclosure and getnamecallmethod functions for 'always win heartbeat'.", 7)
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
						warnmessage("Entities", inst.Name:gsub("Moving","").." is coming. Hide!", 7)
						inst.Destroying:Wait()
						warnmessage("Entities", "It's now safe to leave the hiding spot.", 7)
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
				warnmessage("Entities", "Avoiding "..inst.Name:gsub("Moving","")..". Please wait...", 10)

				local OldPos = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
				local oldwalkspeed = hum.WalkSpeed
				local CurrentRoom = workspace.CurrentRooms[tostring(game:GetService("ReplicatedStorage").GameData.LatestRoom.Value - 1)]
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
				end
				local con = game:GetService("RunService").Heartbeat:Connect(function()
					--	hum.WalkSpeed = 0
					if basepart then
						game.Players.LocalPlayer.Character:MoveTo(basepart.Position + Vector3.new(0,21,0))
					else
						game.Players.LocalPlayer.Character:MoveTo(OldPos + Vector3.new(0,21,0))
					end
					--game.Players.LocalPlayer.Character:MoveTo(OldPos + Vector3.new(0,125,0))
				end)

				inst.Destroying:Wait()
				task.wait(0.35)
				con:Disconnect()

				for i = 1,5 do				
					--	hum.WalkSpeed = oldwalkspeed
					game.Players.LocalPlayer.Character:MoveTo(OldPos)
					--	task.wait()
				end
			end
		end
	end
end)

if hookmetamethod and newcclosure and getnamecallmethod then
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
	warnmessage("POOPDOORS EDITED", "You need to have hookmetamethod and newcclosure and getnamecallmethod functions for 'no eyes damage'.", 7)
end

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
window_roomsdoors.button("skip room 50",function()
	pcall(function()
		if LatestRoom.Value == 50 then
			local CurrentDoor = workspace.CurrentRooms[tostring(LatestRoom.Value + 1)]:WaitForChild("Door")
			game.Players.LocalPlayer.Character:PivotTo(CFrame.new(CurrentDoor.Door.Position))
		end
	end)
end)

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
					warnmessage("Door 50", "First collect all books!")
				else
					--message("the code is ".. code)
					normalmessage("Door 50", "The code is '".. code.."'.")
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

		repeat task.wait() until not flags.roomsnolock
		addconnect:Disconnect()
	end
end)

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
										if plr:DistanceFromCharacter(v.PrimaryPart.Position) <= 12 then
											fireproximityprompt(prompt)
										end
									until prompt:GetAttribute("Interactions") or not flags.draweraura
								end)
							end
						elseif v.Name == "RolltopContainer" then
							local prompt = v:WaitForChild("ActivateEventPrompt")
							local interactions = prompt:GetAttribute("Interactions")

							if not interactions then
								task.spawn(function()
									repeat task.wait(0.1)
										if plr:DistanceFromCharacter(v.PrimaryPart.Position) <= 12 then
											fireproximityprompt(prompt)
										end
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

window_anticheatbyppasses.label("method 1 makes it so you CANT pick up ANYTHING so only do this in multiplayer, if you use this in rooms you will not get the a-1000 badge!",50)
window_anticheatbyppasses.button("method 1",function()
	flags.anticheatbypass = true
	local newhum = hum:Clone()
	newhum.Name = "humlol"
	newhum.Parent = char
	task.wait()
	hum.Parent = nil

	hum = newhum
	walkspeedslider.setmax(100)
end)

if game.ReplicatedStorage:WaitForChild("GameData"):WaitForChild("Floor").Value == "Rooms" then
	local window_rooms = library.window("the rooms")

	local a90remote = game.ReplicatedStorage:WaitForChild("EntityInfo"):WaitForChild("A90")

	window_rooms.toggle("harmless A90",false,function(val)
		flags.noa90 = val

		if val  then
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

	window_rooms.toggle("auto a-1000",false,function(val)
		flags.autorooms = val

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

						repeat task.wait() until not v:IsDescendantOf(workspace)
						hide = false
					end
				end
			end)

			while flags.autorooms do
				local room = getrecentroom(2)
				local door = room:WaitForChild("Door")
				--local dpos = door:GetPivot()
				
				--[[
				if hide then
					repeat task.wait()
						char:PivotTo(dpos+Vector3.new(0,21,0))
					until not hide
				else
					repeat task.wait()
						char:PivotTo(dpos)
					until lastroom ~= room or not flags.autorooms
				end--]]
				
				if hide then
					local OldPos = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
					local oldwalkspeed = hum.WalkSpeed
					local CurrentRoom = workspace.CurrentRooms[tostring(game:GetService("ReplicatedStorage").GameData.LatestRoom.Value - 1)]
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
					end
					local con = game:GetService("RunService").Heartbeat:Connect(function()
						--	hum.WalkSpeed = 0
						if basepart then
							game.Players.LocalPlayer.Character:MoveTo(basepart.Position + Vector3.new(0,21,0))
						else
							game.Players.LocalPlayer.Character:MoveTo(OldPos + Vector3.new(0,21,0))
						end
						--game.Players.LocalPlayer.Character:MoveTo(OldPos + Vector3.new(0,125,0))
					end)
					
					repeat task.wait() until not hide
					
					--inst.Destroying:Wait()
					task.wait(0.35)
					con:Disconnect()

					for i = 1,5 do				
						--	hum.WalkSpeed = oldwalkspeed
						game.Players.LocalPlayer.Character:MoveTo(OldPos)
						--	task.wait()
					end	
				else
					repeat 
						task.wait()
						game.Players.LocalPlayer.Character:MoveTo(door.PrimaryPart.Position)
					until lastroom ~= room or not flags.autorooms
				end
				
				task.wait()
			end
			entconnect:Disconnect()
		end
	end)
end

window_misc.button("close gui",function()
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
	normalmessage("POOPDOORS EDITED", "GUI closed!")
end)

normalmessage("POOPDOORS EDITED", "Script loaded!")
