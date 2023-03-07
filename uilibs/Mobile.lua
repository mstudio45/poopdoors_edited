-- made by mstudio45#5590
-- Services
local Players = game:GetService("Players")
local MarketplaceService = game:GetService("MarketplaceService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Mouse = Players.LocalPlayer:GetMouse()

-- Variables
local Viewport = workspace.CurrentCamera.ViewportSize

local scriptrunning = true
local function wait_check(...)
	if scriptrunning == true then
		return task.wait(...)
	else
		task.wait()
		return false
	end
end

local function has_property(instance, property)
	local clone = instance:Clone()
	clone:ClearAllChildren()

	return (pcall(function()
		return clone[property]
	end))
end

local function from_hex(hex)
	if typeof(hex) == "string" then
		local r, g, b = string.match(hex, "^#?(%w%w)(%w%w)(%w%w)$")
		return Color3.fromRGB(tonumber(r, 16),
			tonumber(g, 16), tonumber(b, 16))
	else
		return hex
	end
end
local function to_hex(color)
	if typeof(color) == "Color3" then
		return string.format("#%02X%02X%02X", color.R * 0xFF,
			color.G * 0xFF, color.B * 0xFF)
	else
		return color
	end
end

local customnotifid = "10469938989"
local oldcustomnotifid = "4590657391"
local NotificationHolder = loadstring(game:HttpGet("https://raw.githubusercontent.com/BocusLuke/UI/main/STX/Module.Lua"))()
local Notification = loadstring(game:HttpGet("https://raw.githubusercontent.com/BocusLuke/UI/main/STX/Client.Lua"))()
function message(text)
	task.spawn(function()
		local notif = Instance.new("Sound");notif.Parent = game.SoundService;notif.SoundId = "rbxassetid://4590657391";notif.Volume = 3;notif:Play();notif.Stopped:Wait();notif:Destroy()
	end)
	task.spawn(function()
		local msg = Instance.new("Message",workspace)
		msg.Text = tostring(text)
		task.wait(5)
		msg:Destroy()
	end)
end

function normalmessage(title, text, reason, timee, image, textlabel, waitforinsttodelete)
	task.spawn(function()
		do
			local AchievementsFolder = require(game:GetService("ReplicatedStorage"):WaitForChild("Achievements"))
			if not game.Players.LocalPlayer.PlayerGui:FindFirstChild("MainUI") then
				repeat task.wait() until game.Players.LocalPlayer.PlayerGui:FindFirstChild("MainUI")
			end
			local MainUI =  game.Players.LocalPlayer.PlayerGui.MainUI
			local TweenService = game:GetService("TweenService")

			if title == nil or typeof(title) ~= "string" or string.len(title) == 0 then return end
			if text == nil or typeof(text) ~= "string" or string.len(text) == 0 then return end
			if reason == nil or typeof(reason) ~= "string" or string.len(reason) == 0 then reason = "" end
			if textlabel == nil or typeof(textlabel) ~= "string" then textlabel = "NOTIFICATION" end
			if timee == nil or timee == 0 or typeof(timee) ~= "number" then timee = 5 end
			if image == nil or typeof(image) ~= "string" then 
				image = "6023426923" 
			end

			local AchievementFrame = MainUI.AchievementsHolder.Achievement:Clone();
			AchievementFrame.Size = UDim2.new(0, 0, 0, 0);
			AchievementFrame.Frame.Position = UDim2.new(1.1, 0, 0, 0);
			AchievementFrame.Name = "LiveAchievement";
			AchievementFrame.Visible = true;

			AchievementFrame.Frame.TextLabel.Text = textlabel
			if textlabel == "WARNING" then AchievementFrame.Frame.TextLabel.TextColor3 = Color3.fromRGB(175, 0, 0);AchievementFrame.Frame.UIStroke.Color = Color3.fromRGB(175, 0, 0);AchievementFrame.Frame.Glow.ImageColor3 = Color3.fromRGB(175, 0, 0); end
			AchievementFrame.Frame.Details.Desc.Text = tostring(text)
			AchievementFrame.Frame.Details.Title.Text = tostring(title)
			AchievementFrame.Frame.Details.Reason.Text = tostring(reason or "")

			AchievementFrame.Frame.ImageLabel.Image = "rbxassetid://"..tostring(image or "0")

			AchievementFrame.Parent = MainUI.AchievementsHolder;
			AchievementFrame.Sound.SoundId = "rbxassetid://"..customnotifid
			if textlabel == "WARNING" then AchievementFrame.Sound.Volume = 2 else AchievementFrame.Sound.Volume = 1 end
			AchievementFrame.Sound:Play();
			if textlabel == "WARNING" then AchievementFrame:TweenSize(UDim2.new(1, 0, 0.2, 0), "In", "Quad", 0.3, true); else AchievementFrame:TweenSize(UDim2.new(1, 0, 0.2, 0), "In", "Quad", 0.8, true); end
			if textlabel == "WARNING" then wait(0.3) else wait(0.8) end
			AchievementFrame.Frame:TweenPosition(UDim2.new(0, 0, 0, 0), "Out", "Quad", 0.5, true);
			TweenService:Create(AchievementFrame.Frame.Glow, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
				ImageTransparency = 1
			}):Play()
			if waitforinsttodelete ~= nil and typeof(waitforinsttodelete) == "Instance" then
				waitforinsttodelete.Destroying:Wait()
			else
				wait(timee)
			end
			AchievementFrame.Frame:TweenPosition(UDim2.new(1.1, 0, 0, 0), "In", "Quad", 0.5, true)
			wait(0.5)
			AchievementFrame:TweenSize(UDim2.new(1, 0, -0.1, 0), "InOut", "Quad", 0.5, true)
			wait(0.5)
			AchievementFrame:Destroy()
		end
	end)
end
function warnmessage(title, text, reason, timee, image, waitforinsttodelete)
	normalmessage(title, text, reason, timee, image, "WARNING", waitforinsttodelete)
end

function confirmnotification(title, text, timee, callback)
	task.spawn(function()
		local notif = Instance.new("Sound");notif.Parent = game.SoundService;notif.SoundId = "rbxassetid://"..oldcustomnotifid;notif.Volume = 1;notif:Play();notif.Stopped:Wait();notif:Destroy()
	end)
	Notification:Notify(
		{Title = title, Description = text},
		{OutlineColor = Color3.fromRGB(80, 80, 80), Time = timee or 10, Type = "option"},
		{Image = "http://www.roblox.com/asset/?id=6023426923", ImageColor = Color3.fromRGB(255, 84, 84), Callback = callback or function(state)end}
	)
end

function oldnormalmessage(title, text, timee)
	task.spawn(function()
		local notif = Instance.new("Sound");notif.Parent = game.SoundService;notif.SoundId = "rbxassetid://"..oldcustomnotifid;notif.Volume = 1;notif:Play();notif.Stopped:Wait();notif:Destroy()
	end)
	Notification:Notify(
		{Title = title, Description = text},
		{OutlineColor = Color3.fromRGB(80, 80, 80),Time = timee or 5, Type = "default"}
	)
end 

function oldwarnmessage(title, text, timee)
	task.spawn(function()
		local notif = Instance.new("Sound");notif.Parent = game.SoundService;notif.SoundId = "rbxassetid://"..oldcustomnotifid;notif.Volume = 2;notif:Play();notif.Stopped:Wait();notif:Destroy()
	end)
	Notification:Notify(
		{Title = title, Description = text},
		{OutlineColor = Color3.fromRGB(80, 80, 80),Time = timee or 5, Type = "image"},
		{Image = "http://www.roblox.com/asset/?id=6023426923", ImageColor = Color3.fromRGB(255, 84, 84)}
	)
end

local Library = {
	subs = {
		Wait = wait_check,
		wait = wait_check
	}
}

function Library:validate(Values, options)
	for i,v in pairs(Values) do
		if options[i] == nil then
			options[i] = v
		end
	end

	return options
end

function Library:tween(object, goal, Callback, tweeninfo)
	local tween = TweenService:Create(object, tweeninfo or TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), goal)
	tween.Completed:Connect(Callback or function() end)
	tween:Play()
end


function ResizeScrollingFrame(ScrollingFrame, UiListUiGrid, offset)
	ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, UiListUiGrid.AbsoluteContentSize.Y + offset or 10) 
end
function getAbsoluteSize(frame)
	local totalSize = Vector2.new()

	for _, Child in pairs(frame:GetChildren()) do
		if Child:IsA("GuiBase2d") then
			totalSize += Child.AbsoluteSize
		end
	end

	return totalSize
end

function randomString()local length = math.random(10,20);local array = {};for i = 1, length do array[i] = string.char(math.random(32, 126)) end;return table.concat(array);end
function Library:CreateWindow(options)
	options = Library:validate({
		Name = "ML",
		Themeable = false
	}, options or {})

	local GUI = {
		CurrentTab = nil,
		CanDrag = false,
		Minimize = {
			Hover = false,
			MouseDown = false,
			Opened = true
		},
		TotalTabs = 1
	}

	local Notifications = {

	}

	local function createObject(a,b,c)
		local ee = Instance.new(a,b)
		ee.Name = c
	end

	--300
	-- Main Frame
	do
		GUI["1"] = Instance.new("ScreenGui")
		GUI["1"]["Name"] = randomString()

		if get_hidden_gui or gethui then
			local HIDEUI = get_hidden_gui or gethui
			GUI["1"]["Parent"] = HIDEUI()
		elseif (not is_sirhurt_closure) and (syn and syn.protect_gui) then
			syn.protect_gui(GUI["1"])
			GUI["1"]["Parent"] = game:GetService("CoreGui")
		elseif game:GetService("CoreGui"):FindFirstChild('RobloxGui') then
			GUI["1"]["Parent"] = game:GetService("CoreGui").RobloxGui
		else
			GUI["1"]["Parent"] = game:GetService("CoreGui")
		end

		--GUI["1"]["Parent"] = game.Players.LocalPlayer:WaitForChild("PlayerGui")

		GUI["1"]["ZIndexBehavior"] = Enum.ZIndexBehavior.Sibling;
		GUI["1"]["IgnoreGuiInset"] = true;

		-- StarterGui.ML.Main
		GUI["2"] = Instance.new("Frame", GUI["1"]);
		GUI["2"]["BackgroundColor3"] = Color3.fromRGB(49, 49, 49);
		GUI["2"]["AnchorPoint"] = Vector2.new(0, 0);
		GUI["2"]["Size"] = UDim2.new(0, 400, 0, 300);
		GUI["2"]["ClipsDescendants"] = true;
		GUI["2"]["Position"] = UDim2.fromOffset((Viewport.X / 2) - (GUI["2"]["Size"].X.Offset / 2), (Viewport.Y / 2) - (GUI["2"]["Size"].Y.Offset / 2));
		GUI["2"]["Name"] = [[Main]];
		createObject("Color3Value", GUI["2"], "Background_Color")

		-- StarterGui.ML.Main.UICorner
		GUI["3"] = Instance.new("UICorner", GUI["2"]);
		GUI["3"]["CornerRadius"] = UDim.new(0, 6);

		-- StarterGui.ML.Main.DropShadowHolder
		GUI["4"] = Instance.new("Frame", GUI["2"]);
		GUI["4"]["ZIndex"] = 0;
		GUI["4"]["BorderSizePixel"] = 0;
		GUI["4"]["BackgroundTransparency"] = 1;
		GUI["4"]["Size"] = UDim2.new(1, 0, 1, 0);
		GUI["4"]["Name"] = [[DropShadowHolder]];

		-- StarterGui.ML.Main.DropShadowHolder.DropShadow
		GUI["5"] = Instance.new("ImageLabel", GUI["4"]);
		GUI["5"]["ZIndex"] = 0;
		GUI["5"]["BorderSizePixel"] = 0;
		GUI["5"]["SliceCenter"] = Rect.new(49, 49, 450, 450);
		GUI["5"]["ScaleType"] = Enum.ScaleType.Slice;
		GUI["5"]["ImageColor3"] = Color3.fromRGB(0, 0, 0);
		GUI["5"]["ImageTransparency"] = 0.5;
		GUI["5"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
		GUI["5"]["Image"] = [[rbxassetid://6014261993]];
		GUI["5"]["Size"] = UDim2.new(1, 47, 1, 47);
		GUI["5"]["Name"] = [[DropShadow]];
		GUI["5"]["BackgroundTransparency"] = 1;
		GUI["5"]["Position"] = UDim2.new(0.5, 0, 0.5, 0);

		-- StarterGui.ML.Main.TopBar
		GUI["6"] = Instance.new("Frame", GUI["2"]);
		GUI["6"]["BorderSizePixel"] = 0;
		GUI["6"]["BackgroundColor3"] = Color3.fromRGB(255, 0, 0);
		GUI["6"]["Size"] = UDim2.new(1, 0, 0, 30);
		GUI["6"]["Name"] = [[TopBar]];
		createObject("Color3Value", GUI["6"], "Topbar_Color")

		-- StarterGui.ML.Main.TopBar.UICorner
		GUI["7"] = Instance.new("UICorner", GUI["6"]);
		GUI["7"]["CornerRadius"] = UDim.new(0, 6);

		-- StarterGui.ML.Main.TopBar.Extension
		GUI["8"] = Instance.new("Frame", GUI["6"]);
		GUI["8"]["BorderSizePixel"] = 0;
		GUI["8"]["BackgroundColor3"] = Color3.fromRGB(255, 0, 0);
		GUI["8"]["AnchorPoint"] = Vector2.new(0, 1);
		GUI["8"]["Size"] = UDim2.new(1, 0, 0.5, 0);
		GUI["8"]["Position"] = UDim2.new(0, 0, 1, 0);
		GUI["8"]["Name"] = [[Extension]];
		createObject("Color3Value", GUI["8"], "Topbar_Color")

		-- StarterGui.ML.Main.TopBar.Title
		GUI["9"] = Instance.new("TextLabel", GUI["6"]);
		GUI["9"]["TextWrapped"] = true;
		GUI["9"]["TextXAlignment"] = Enum.TextXAlignment.Left;
		GUI["9"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
		GUI["9"]["TextSize"] = 14;
		GUI["9"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
		GUI["9"]["Size"] = UDim2.new(0.5, 0, 1, 0);
		GUI["9"]["Text"] = options["Name"];
		GUI["9"]["Name"] = [[Title]];
		GUI["9"]["Font"] = Enum.Font.Gotham;
		GUI["9"]["BackgroundTransparency"] = 1;

		-- StarterGui.ML.Main.TopBar.Title.UIPadding
		GUI["a"] = Instance.new("UIPadding", GUI["9"]);
		GUI["a"]["PaddingLeft"] = UDim.new(0, 8);

		-- StarterGui.ML.Main.TopBar.ExitBtn
		GUI["b"] = Instance.new("ImageButton", GUI["6"]);
		GUI["b"]["ZIndex"] = 2;
		GUI["b"]["BorderSizePixel"] = 0;
		GUI["b"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
		GUI["b"]["Selectable"] = true;
		GUI["b"]["AnchorPoint"] = Vector2.new(1, 0.5);
		GUI["b"]["Image"] = [[rbxassetid://3926305904]];
		GUI["b"]["ImageRectSize"] = Vector2.new(24, 24);
		GUI["b"]["Size"] = UDim2.new(0, 22, 0, 22);
		GUI["b"]["Active"] = true;
		GUI["b"]["Name"] = [[ExitBtn]];
		GUI["b"]["ImageRectOffset"] = Vector2.new(284, 4);
		GUI["b"]["BackgroundTransparency"] = 1;
		GUI["b"]["Position"] = UDim2.new(1, -4, 0.5, 0);

		-- StarterGui.ML.Main.TopBar.Minimize
		GUI["c"] = Instance.new("ImageButton", GUI["6"]);
		GUI["c"]["ZIndex"] = 2;
		GUI["c"]["BorderSizePixel"] = 0;
		GUI["c"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
		GUI["c"]["Selectable"] = true;
		GUI["c"]["AnchorPoint"] = Vector2.new(1, 0.5);
		GUI["c"]["Image"] = [[rbxassetid://6764432408]];
		GUI["c"]["ImageRectSize"] = Vector2.new(50, 50);
		GUI["c"]["Size"] = UDim2.new(0, 22, 0, 22);
		GUI["c"]["Active"] = true;
		GUI["c"]["Name"] = [[Minimize]];
		GUI["c"]["ImageRectOffset"] = Vector2.new(50, 550);
		GUI["c"]["BackgroundTransparency"] = 1;
		GUI["c"]["Position"] = UDim2.new(1, -30, 0.5, 0);

		-- StarterGui.ML.Main.TopBar.Line
		GUI["d"] = Instance.new("Frame", GUI["6"]);
		GUI["d"]["BorderSizePixel"] = 0;
		GUI["d"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
		GUI["d"]["AnchorPoint"] = Vector2.new(0, 1);
		GUI["d"]["Size"] = UDim2.new(1, 0, 0, 1);
		GUI["d"]["Position"] = UDim2.new(0, 0, 1, 0);
		GUI["d"]["Name"] = [[Line]];

		-- StarterGui.ML.Main.Content
		GUI["19"] = Instance.new("Frame", GUI["2"]);
		GUI["19"]["ZIndex"] = 2;
		GUI["19"]["BorderSizePixel"] = 0;
		GUI["19"]["BackgroundColor3"] = Color3.fromRGB(37, 37, 37);
		GUI["19"]["AnchorPoint"] = Vector2.new(1, 0);
		GUI["19"]["BackgroundTransparency"] = 1;
		GUI["19"]["Size"] = UDim2.new(1, -133, 1, -42);
		GUI["19"]["BorderColor3"] = Color3.fromRGB(55, 55, 55);
		GUI["19"]["Position"] = UDim2.new(1, -6, 0, 36);
		GUI["19"]["Name"] = [[Content]];

		-- StarterGui.ML.Main.Content.UICorner
		GUI["1a"] = Instance.new("UICorner", GUI["19"]);
		GUI["1a"]["CornerRadius"] = UDim.new(0, 6);

		-- StarterGui.ML.Main.Content.Fade
		GUI["5a"] = Instance.new("Frame", GUI["19"]);
		GUI["5a"]["ZIndex"] = 10;
		GUI["5a"]["BorderSizePixel"] = 0;
		GUI["5a"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
		GUI["5a"]["Size"] = UDim2.new(1, 0, 0, 30);
		GUI["5a"]["Visible"] = false;
		GUI["5a"]["Name"] = [[Fade]];

		-- StarterGui.ML.Main.Content.Fade.UIGradient
		GUI["5b"] = Instance.new("UIGradient", GUI["5a"]);
		GUI["5b"]["Rotation"] = 90;
		GUI["5b"]["Color"] = ColorSequence.new{ColorSequenceKeypoint.new(0.000, Color3.fromRGB(29, 29, 29)),ColorSequenceKeypoint.new(1.000, Color3.fromRGB(29, 29, 29))};
	end

	-- Navigation
	do
		-- StarterGui.ML.Main.Navigation
		GUI["e"] = Instance.new("Frame", GUI["2"]);
		GUI["e"]["BorderSizePixel"] = 0;
		GUI["e"]["BackgroundColor3"] = Color3.fromRGB(66, 66, 66);
		GUI["e"]["Size"] = UDim2.new(0, 120, 1, -30);
		GUI["e"]["Position"] = UDim2.new(0, 0, 0, 30);
		GUI["e"]["Name"] = [[Navigation]];
		createObject("Color3Value", GUI["e"], "Background_Second_Color")

		-- StarterGui.ML.Main.Navigation.UICorner
		GUI["f"] = Instance.new("UICorner", GUI["e"]);
		GUI["f"]["CornerRadius"] = UDim.new(0, 6);

		-- StarterGui.ML.Main.Navigation.Hide
		GUI["10"] = Instance.new("Frame", GUI["e"]);
		GUI["10"]["BorderSizePixel"] = 0;
		GUI["10"]["BackgroundColor3"] = Color3.fromRGB(66, 66, 66);
		GUI["10"]["Size"] = UDim2.new(1, 0, 0, 20);
		GUI["10"]["Name"] = [[Hide]];
		createObject("Color3Value", GUI["10"], "Background_Second_Color")

		-- StarterGui.ML.Main.Navigation.Hide2
		GUI["11"] = Instance.new("Frame", GUI["e"]);
		GUI["11"]["BorderSizePixel"] = 0;
		GUI["11"]["BackgroundColor3"] = Color3.fromRGB(66, 66, 66);
		GUI["11"]["AnchorPoint"] = Vector2.new(1, 0);
		GUI["11"]["Size"] = UDim2.new(0, 20, 1, 0);
		GUI["11"]["Position"] = UDim2.new(1, 0, 0, 0);
		GUI["11"]["Name"] = [[Hide2]];
		createObject("Color3Value", GUI["11"], "Background_Second_Color")

		-- StarterGui.ML.Main.Navigation.ButtonHolder
		GUI["12"] = Instance.new("Frame", GUI["e"]);
		GUI["12"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
		GUI["12"]["BackgroundTransparency"] = 1;
		GUI["12"]["Size"] = UDim2.new(1, 0, 1, 0);
		GUI["12"]["Name"] = [[ButtonHolder]];

		-- StarterGui.ML.Main.Navigation.ButtonHolder.UIPadding
		GUI["13"] = Instance.new("UIPadding", GUI["12"]);
		GUI["13"]["PaddingTop"] = UDim.new(0, 8);
		GUI["13"]["PaddingBottom"] = UDim.new(0, 8);

		-- StarterGui.ML.Main.Navigation.ButtonHolder.UIListLayout
		GUI["14"] = Instance.new("UIListLayout", GUI["12"]);
		GUI["14"]["Padding"] = UDim.new(0, 1);
		GUI["14"]["SortOrder"] = Enum.SortOrder.LayoutOrder;

		-- StarterGui.ML.Main.Navigation.Line
		GUI["18"] = Instance.new("Frame", GUI["e"]);
		GUI["18"]["BorderSizePixel"] = 0;
		GUI["18"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
		GUI["18"]["Size"] = UDim2.new(0, 1, 1, 0);
		GUI["18"]["Position"] = UDim2.new(1, 0, 0, 0);
		GUI["18"]["Name"] = [[Line]];
	end

	-- Logic
	do
		task.spawn(function()
			local gui = GUI["2"]
			local dragging
			local dragInput
			local dragStart
			local startPos
			local function update(input)
				local delta = input.Position - dragStart
				pcall(function()
					gui.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)-- gui:TweenPosition(UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y), 'Out', 'Linear', 0);
				end)
			end
			gui.InputBegan:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
					dragging = true
					dragStart = input.Position
					startPos = gui.Position

					input.Changed:Connect(function()
						if input.UserInputState == Enum.UserInputState.End then
							dragging = false
						end
					end)
				end
			end)
			gui.InputChanged:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
					dragInput = input
				end
			end)
			game:GetService("UserInputService").InputChanged:Connect(function(input)
				if input == dragInput and dragging then
					update(input)
				end
			end)
		end)

		task.spawn(function()
			local ExitBtn = {
				Hover = false,
				MouseDown = false,
				Opened = true
			}

			-- Logic
			do
				GUI["b"].MouseButton1Click:Connect(function()
					Library.unload()
				end)
			end

			GUI["2"]["Size"] = UDim2.new(0, 400, 0, 300);
		end)

		task.spawn(function()
			-- Logic
			do
				GUI["c"].MouseButton1Click:Connect(function()
					Library.toggle()
				end)
			end

			GUI["2"]["Size"] = UDim2.new(0, 400, 0, 300);
		end)
	end	

	function GUI:CreateTab(options)
		options = Library:validate({
			Name = "Preview Tab",
			Icon = "",--"rbxassetid://10888331510",
			IconOffset = Vector2.new(0, 0),
			IconSize =  Vector2.new(0, 0),
			ShowAsLast = false,
			ShowAsFirst = false,
		}, options or {})

		local Tab = {
			Hover = false,
			Active = false
		}

		if options.Name:match("__themedesigner") then
		else
			if GUI.CurrentTab == nil and options.Icon == "" then
				options.Icon = "rbxassetid://10888331510"
			end
		end

		-- Render
		do
			-- StarterGui.ML.Main.Navigation.ButtonHolder.Inactive
			Tab["15"] = Instance.new("TextButton", GUI["12"]);
			Tab["15"]["TextXAlignment"] = Enum.TextXAlignment.Left;
			Tab["15"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
			Tab["15"]["TextSize"] = 14;
			Tab["15"]["TextColor3"] = Color3.fromRGB(200, 200, 200);
			Tab["15"]["Size"] = UDim2.new(1, 0, 0, 24);
			Tab["15"]["Text"] = options["Name"];
			if options.Name == "__themedesigner" then
				Tab["15"]["Text"] = "Themes [BETA]";
			end
			Tab["15"]["Name"] = [[Inactive]];
			Tab["15"]["Font"] = Enum.Font.Gotham;
			Tab["15"]["BackgroundTransparency"] = 1;
			Tab["15"]["LayoutOrder"] = GUI.TotalTabs; pcall(function() GUI.TotalTabs = GUI.TotalTabs + 1 end)
			if options.ShowAsLast == true then Tab["15"]["LayoutOrder"] = 999999; end
			if options.ShowAsFirst == true then Tab["15"]["LayoutOrder"] = -999999; end

			-- StarterGui.ML.Main.Navigation.ButtonHolder.Inactive.UIPadding
			Tab["16"] = Instance.new("UIPadding", Tab["15"]);
			Tab["16"]["PaddingLeft"] = UDim.new(0, 28);

			-- StarterGui.ML.Main.Navigation.ButtonHolder.Inactive.Icon
			Tab["17"] = Instance.new("ImageLabel", Tab["15"]);
			Tab["17"]["BorderSizePixel"] = 0;
			Tab["17"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
			Tab["17"]["ImageColor3"] = Color3.fromRGB(200, 200, 200);
			Tab["17"]["AnchorPoint"] = Vector2.new(0, 0.5);
			Tab["17"]["Image"] = options["Icon"];
			Tab["17"]["ImageRectSize"] = options["IconSize"];
			Tab["17"]["Size"] = UDim2.new(0, 20, 0, 20);
			Tab["17"]["ImageRectOffset"] = options["IconOffset"];
			Tab["17"]["BackgroundTransparency"] = 1;
			Tab["15"]["Name"] = [[Icon]]
			Tab["17"]["Position"] = UDim2.new(0, -24, 0.5, 0);

			-- StarterGui.ML.Main.Content.Tab
			Tab["1b"] = Instance.new("ScrollingFrame", GUI["19"]);
			Tab["1b"]["BorderSizePixel"] = 0;
			Tab["1b"]["BackgroundColor3"] = Color3.fromRGB(48, 48, 48);
			Tab["1b"]["BackgroundTransparency"] = 1;
			Tab["1b"]["Size"] = UDim2.new(1, 0, 1, 0);
			Tab["1b"]["Selectable"] = false;
			Tab["1b"]["ScrollBarThickness"] = 0;
			Tab["1b"]["Name"] = options["Name"];
			--Tab["1b"]["AutomaticCanvasSize"] = Enum.AutomaticSize.Y;
			Tab["1b"]["SelectionGroup"] = false;
			Tab["1b"]["Visible"] = false;

			-- StarterGui.ML.Main.Content.HomeTab.UIPadding
			Tab["21"] = Instance.new("UIPadding", Tab["1b"]);
			Tab["21"]["PaddingTop"] = UDim.new(0, 1);
			Tab["21"]["PaddingRight"] = UDim.new(0, 1);
			Tab["21"]["PaddingBottom"] = UDim.new(0, 1);
			Tab["21"]["PaddingLeft"] = UDim.new(0, 1);

			-- StarterGui.ML.Main.Content.HomeTab.UIListLayout
			Tab["22"] = Instance.new("UIListLayout", Tab["1b"]);
			Tab["22"]["Padding"] = UDim.new(0, 6);
			Tab["22"]["SortOrder"] = Enum.SortOrder.LayoutOrder;
		end

		-- Methods
		function Tab:Activate()
			if Tab.Active == false then
				if GUI.CurrentTab ~= nil then
					GUI.CurrentTab:Deactivate()
				end

				Tab.Active = true
				Library:tween(Tab["15"], {TextColor3 = Color3.fromRGB(255, 255, 255)})
				Library:tween(Tab["17"], {ImageColor3 = Color3.fromRGB(255, 255, 255)})
				Library:tween(Tab["15"], {BackgroundTransparency = 0.8})
				Tab["1b"].Visible = true

				GUI.CurrentTab = Tab
			end
		end

		function Tab:Deactivate()
			if Tab.Active == true then
				Tab.Active = false
				Tab.Hover = false
				Library:tween(Tab["15"], {TextColor3 = Color3.fromRGB(200, 200, 200)})
				Library:tween(Tab["17"], {ImageColor3 = Color3.fromRGB(200, 200, 200)})
				Library:tween(Tab["15"], {BackgroundTransparency = 1})
				Tab["1b"].Visible = false
			end
		end

		-- Logic
		do
			Tab["15"].MouseButton1Click:Connect(function()
				Tab:Activate()
			end)

			if options.Name:match("__themedesigner") then else
				if GUI.CurrentTab == nil then
					Tab:Activate()
				end
			end
		end

		function Tab:CreateSection(options)
			options = Library:validate({
				Name = "Preview Section",
				Side = ""
			}, options or {})

			local Section = {
				Hover = false,
				Active = false,
				ResizeFunc = nil
			}

			-- Render
			do
				-- StarterGui.[L"~J:kcm=$E9P}`.:e&.Main.Content.Preview Tab.Preview Section
				Section["14"] = Instance.new("Frame", Tab["1b"]);
				Section["14"]["BorderSizePixel"] = 0;
				--Section["14"]["CanvasSize"] = UDim2.new(0, 0, 0, 36);
				Section["14"]["BackgroundColor3"] = Color3.fromRGB(59, 59, 59);
				Section["14"]["Size"] = UDim2.new(1, 0, 0, 26);
				Section["14"]["Selectable"] = false;
				--Section["14"]["ScrollBarThickness"] = 0;
				Section["14"]["Name"] = [[Section]];
				Section["14"]["SelectionGroup"] = false;
				createObject("Color3Value", Section["14"], "Section_Background_Color")

				-- StarterGui.[L"~J:kcm=$E9P}`.:e&.Main.Content.Preview Tab.Preview Section.UIStroke
				Section["15"] = Instance.new("UIStroke", Section["14"]);
				Section["15"]["Color"] = Color3.fromRGB(255, 255, 255);

				-- StarterGui.[L"~J:kcm=$E9P}`.:e&.Main.Content.Preview Tab.Preview Section.UIListLayout
				Section["19"] = Instance.new("UIListLayout", Section["14"]);
				Section["19"]["Padding"] = UDim.new(0, 6);
				Section["19"]["HorizontalAlignment"] = Enum.HorizontalAlignment.Center;
				Section["19"]["SortOrder"] = Enum.SortOrder.LayoutOrder;

				-- StarterGui.[L"~J:kcm=$E9P}`.:e&.Main.Content.Preview Tab.Preview Section.UIPadding
				Section["1a"] = Instance.new("UIPadding", Section["14"]);
				Section["1a"]["PaddingTop"] = UDim.new(0, 1);
				Section["1a"]["PaddingRight"] = UDim.new(0, 1);
				Section["1a"]["PaddingBottom"] = UDim.new(0, 1);
				Section["1a"]["PaddingLeft"] = UDim.new(0, 1);

				-- StarterGui.[L"~J:kcm=$E9P}`.:e&.Main.Content.Preview Tab.Preview Section.SectionTitle
				Section["16"] = Instance.new("Frame", Section["14"]);
				Section["16"]["BackgroundColor3"] = Color3.fromRGB(91, 0, 0);
				Section["16"]["BackgroundTransparency"] = 1;
				Section["16"]["LayoutOrder"] = -999999999;
				Section["16"]["Size"] = UDim2.new(1, 0, 0, 26);
				Section["16"]["Name"] = [[SectionTitle]];

				-- StarterGui.[L"~J:kcm=$E9P}`.:e&.Main.Content.Preview Tab.Preview Section.SectionTitle.Title
				Section["17"] = Instance.new("TextLabel", Section["16"]);
				Section["17"]["TextWrapped"] = true;
				Section["17"]["RichText"] = true;
				Section["17"]["TextXAlignment"] = Enum.TextXAlignment.Left;
				Section["17"]["TextYAlignment"] = Enum.TextYAlignment.Top;
				Section["17"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
				Section["17"]["TextSize"] = 14;
				Section["17"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
				Section["17"]["Size"] = UDim2.new(0.9930291771888733, 0, 1, 0);
				Section["17"]["Text"] = options["Name"];
				Section["17"]["Name"] = [[Title]];
				Section["17"]["Font"] = Enum.Font.GothamBold;
				Section["17"]["BackgroundTransparency"] = 1;
				Section["17"]["Position"] = UDim2.new(0.003952569328248501, 0, 0, 0);

				-- StarterGui.[L"~J:kcm=$E9P}`.:e&.Main.Content.Preview Tab.Preview Section.SectionTitle.UIPadding
				Section["18"] = Instance.new("UIPadding", Section["16"]);
				Section["18"]["PaddingTop"] = UDim.new(0, 6);
				Section["18"]["PaddingRight"] = UDim.new(0, 6);
				Section["18"]["PaddingBottom"] = UDim.new(0, 6);
				Section["18"]["PaddingLeft"] = UDim.new(0, 6);

				Section["14ee"] = Instance.new("Frame", Tab["1b"]);
				Section["14ee"]["BorderSizePixel"] = 0;
				Section["14ee"]["BackgroundTransparency"] = 1;
				Section["14ee"]["Size"] = UDim2.new(1, 0, 0, 5);
				Section["14ee"]["Selectable"] = false;
				Section["14ee"]["Name"] = [[InvisMiddleSection]];
				Section["14ee"]["SelectionGroup"] = false;
			end

			Section.ResizeFunc = function()
				task.spawn(function()
					Section["14"].Size = UDim2.new(1, 0, 0, Section["19"].AbsoluteContentSize.Y + 26) 
					task.wait()
					ResizeScrollingFrame(Tab["1b"] , Tab["22"], 26)
				end)
			end

			-- Contents
			function Section:AddButton(options)
				options = Library:validate({
					Name = "Button",
					Callback = function() end,
				}, options or {})

				local Button = {
					Hover = false,
					MouseDown = false
				}

				-- Render
				do
					-- StarterGui.ML.Main.Content.HomeTab.Button
					Button["1c"] = Instance.new("TextButton", Section["14"]);
					Button["1c"]["BackgroundColor3"] = Color3.fromRGB(27, 27, 27);
					Button["1c"]["Size"] = UDim2.new(0.95, 0, 0, 32);
					Button["1c"]["Name"] = [[Button]];
					Button["1c"]["Text"] = [[]];

					-- StarterGui.ML.Main.Content.HomeTab.Button.UICorner
					Button["1d"] = Instance.new("UICorner", Button["1c"]);
					Button["1d"]["CornerRadius"] = UDim.new(0, 4);

					-- StarterGui.ML.Main.Content.HomeTab.Button.UIStroke
					Button["1e"] = Instance.new("UIStroke", Button["1c"]);
					Button["1e"]["Color"] = Color3.fromRGB(82, 82, 82);
					Button["1e"]["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border;

					-- StarterGui.ML.Main.Content.HomeTab.Button.Title
					Button["1f"] = Instance.new("TextLabel", Button["1c"]);
					Button["1f"]["TextWrapped"] = true;
					Button["1f"]["AutomaticSize"] = Enum.AutomaticSize.Y;
					Button["1f"]["TextYAlignment"] = Enum.TextYAlignment.Top;
					--	Button["1f"]["TextTruncate"] = Enum.TextTruncate.AtEnd;
					Button["1f"]["TextXAlignment"] = Enum.TextXAlignment.Left;
					Button["1f"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
					Button["1f"]["TextSize"] = 14;
					Button["1f"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
					Button["1f"]["Size"] = UDim2.new(1, 0, 1, 0);
					Button["1f"]["Text"] = options["Name"];
					Button["1f"]["Name"] = [[Title]];
					Button["1f"]["Font"] = Enum.Font.Gotham;
					Button["1f"]["BackgroundTransparency"] = 1;

					-- StarterGui.ML.Main.Content.HomeTab.Button.UIPadding
					Button["20"] = Instance.new("UIPadding", Button["1c"]);
					Button["20"]["PaddingTop"] = UDim.new(0, 6);
					Button["20"]["PaddingRight"] = UDim.new(0, 6);
					Button["20"]["PaddingBottom"] = UDim.new(0, 6);
					Button["20"]["PaddingLeft"] = UDim.new(0, 6);
				end

				function Button:_update()
					Button["1c"]["Size"] = UDim2.new(Button["1c"]["Size"].X.Scale, Button["1c"]["Size"].X.Offset, 0, math.huge)
					Button["1c"]["Size"] = UDim2.new(Button["1c"]["Size"].X.Scale, Button["1c"]["Size"].X.Offset, 0, Button["1f"].TextBounds.Y)
					Button["1c"]["Size"] = UDim2.new(Button["1c"]["Size"].X.Scale, Button["1c"]["Size"].X.Offset, 0, Button["1f"].TextBounds.Y + (26-14))
					Section.ResizeFunc()
				end

				-- Logic
				do
					Button["1c"].MouseButton1Click:Connect(function()
						Library:tween(Button["1c"], {BackgroundColor3 = Color3.fromRGB(57, 57, 57)})
						Library:tween(Button["1e"], {Color = Color3.fromRGB(200, 200, 200)})
						options.Callback()
						task.wait(0.005)
						Library:tween(Button["1c"], {BackgroundColor3 = Color3.fromRGB(27, 27, 27)})
						Library:tween(Button["1e"], {Color = Color3.fromRGB(82, 82, 82)})
					end)
				end

				Button:_update()

				return Button
			end

			function Section:AddTextbox(options)
				options = Library:validate({
					Name = "Text box",
					Value = "",
					Multiline = false,
					Callback = function() end,
				}, options or {})

				local TextBox = {
					Hover = false,
					MouseDown = false
				}

				-- Render
				do
					Section:AddLabel({
						Name = options["Name"],
						Position = "Left"
					})
					-- StarterGui.ML.Main.Content.HomeTab.Button
					TextBox["1c"] = Instance.new("TextButton", Section["14"]);
					TextBox["1c"]["BackgroundColor3"] = Color3.fromRGB(27, 27, 27);
					TextBox["1c"]["Size"] = UDim2.new(0.95, 0, 0, 32);
					TextBox["1c"]["Name"] = [[TextBox]];
					TextBox["1c"]["Text"] = [[]];

					-- StarterGui.ML.Main.Content.HomeTab.Button.UICorner
					TextBox["1d"] = Instance.new("UICorner", TextBox["1c"]);
					TextBox["1d"]["CornerRadius"] = UDim.new(0, 4);

					-- StarterGui.ML.Main.Content.HomeTab.Button.UIStroke
					TextBox["1e"] = Instance.new("UIStroke", TextBox["1c"]);
					TextBox["1e"]["Color"] = Color3.fromRGB(82, 82, 82);
					TextBox["1e"]["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border;

					-- StarterGui.ML.Main.Content.HomeTab.Button.Title
					TextBox["1f"] = Instance.new("TextBox", TextBox["1c"]);
					TextBox["1f"]["TextWrapped"] = true;
					TextBox["1f"]["AutomaticSize"] = Enum.AutomaticSize.Y;
					TextBox["1f"]["TextYAlignment"] = Enum.TextYAlignment.Top;
					--TextBox["1f"]["TextTruncate"] = Enum.TextTruncate.AtEnd;
					TextBox["1f"]["TextXAlignment"] = Enum.TextXAlignment.Left;
					TextBox["1f"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
					TextBox["1f"]["TextSize"] = 14;
					TextBox["1f"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
					TextBox["1f"]["Size"] = UDim2.new(1, 0, 1, 0);
					TextBox["1f"]["Text"] = options["Value"];
					TextBox["1f"]["PlaceholderText"] = options["Value"];
					TextBox["1f"]["MultiLine"] = options["Multiline"];
					TextBox["1f"]["ClearTextOnFocus"] = false;
					TextBox["1f"]["Name"] = [[Title]];
					TextBox["1f"]["Font"] = Enum.Font.Gotham;
					TextBox["1f"]["BackgroundTransparency"] = 1;

					-- StarterGui.ML.Main.Content.HomeTab.Button.UIPadding
					TextBox["20"] = Instance.new("UIPadding", TextBox["1c"]);
					TextBox["20"]["PaddingTop"] = UDim.new(0, 6);
					TextBox["20"]["PaddingRight"] = UDim.new(0, 6);
					TextBox["20"]["PaddingBottom"] = UDim.new(0, 6);
					TextBox["20"]["PaddingLeft"] = UDim.new(0, 6);
				end

				-- Methods
				function TextBox:_update()
					TextBox["1c"]["Size"] = UDim2.new(TextBox["1c"]["Size"].X.Scale, TextBox["1c"]["Size"].X.Offset, 0, math.huge)
					TextBox["1c"]["Size"] = UDim2.new(TextBox["1c"]["Size"].X.Scale, TextBox["1c"]["Size"].X.Offset, 0, TextBox["1f"].TextBounds.Y)
					TextBox["1c"]["Size"] = UDim2.new(TextBox["1c"]["Size"].X.Scale, TextBox["1c"]["Size"].X.Offset, 0, TextBox["1f"].TextBounds.Y + (26-14))

					Section.ResizeFunc()
				end

				function TextBox:Set(Name)
					if string.len(Name) ~= 0 then
						TextBox["1f"]["Text"] = tostring(Name);
						TextBox:_update()
					end
				end
				function TextBox:Get()
					return TextBox["1f"]["Text"]
				end

				-- Logic
				do
					TextBox["1c"].MouseButton1Click:Connect(function()
						Library:tween(TextBox["1c"], {BackgroundColor3 = Color3.fromRGB(57, 57, 57)})
						Library:tween(TextBox["1e"], {Color = Color3.fromRGB(200, 200, 200)})
						options.Callback()
						task.wait(.005)
						Library:tween(TextBox["1c"], {BackgroundColor3 = Color3.fromRGB(27, 27, 27)})
						Library:tween(TextBox["1e"], {Color = Color3.fromRGB(82, 82, 82)})
					end)
				end

				Section.ResizeFunc()

				return TextBox
			end

			function Section:AddLabel(options)
				options = Library:validate({
					Name = "Label",
					Position = "center",
				}, options or {})

				local Text = {}

				options.Position = string.lower(options.Position)
				local Namexaligment = Enum.TextXAlignment.Left
				if options.Position == "left" then
					Namexaligment = Enum.TextXAlignment.Left
				end;if options.Position == "center" then
					Namexaligment = Enum.TextXAlignment.Center
				end;if options.Position == "right" then
					Namexaligment = Enum.TextXAlignment.Right
				end

				-- Render
				do
					-- StarterGui.ML.Main.Content.HomeTab.LabelLeft
					Text["23"] = Instance.new("Frame", Section["14"]);
					Text["23"]["BackgroundColor3"] = Color3.fromRGB(90, 0, 0);
					Text["23"]["BackgroundTransparency"] = 1;
					Text["23"]["Size"] = UDim2.new(0.95, 0, 0, 20);
					Text["23"]["Name"] = [[Label]];

					-- StarterGui.ML.Main.Content.HomeTab.LabelLeft.Title
					Text["24"] = Instance.new("TextLabel", Text["23"]);
					Text["24"]["TextWrapped"] = true;
					Text["24"]["AutomaticSize"] = Enum.AutomaticSize.Y;
					Text["24"]["TextYAlignment"] = Enum.TextYAlignment.Top;
					--Text["24"]["TextTruncate"] = Enum.TextTruncate.AtEnd;
					Text["24"]["TextXAlignment"] = Namexaligment;
					Text["24"]["TextYAlignment"] = Enum.TextYAlignment.Top;
					Text["24"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
					Text["24"]["TextSize"] = 14;
					Text["24"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
					Text["24"]["Size"] = UDim2.new(1, 0, 1, 0);
					Text["24"]["Text"] = options["Name"];
					Text["24"]["Name"] = [[Title]];
					Text["24"]["Font"] = Enum.Font.GothamBold;
					Text["24"]["BackgroundTransparency"] = 1;

					-- StarterGui.ML.Main.Content.HomeTab.LabelLeft.UIPadding
					Text["25"] = Instance.new("UIPadding", Text["23"]);
					Text["25"]["PaddingTop"] = UDim.new(0, 6);
					Text["25"]["PaddingRight"] = UDim.new(0, 6);
					Text["25"]["PaddingBottom"] = UDim.new(0, 6);
					Text["25"]["PaddingLeft"] = UDim.new(0, 6);
				end

				function Text:_update()
					Text["23"]["Size"] = UDim2.new(Text["23"]["Size"].X.Scale, Text["23"]["Size"].X.Offset, 0, math.huge)
					Text["23"]["Size"] = UDim2.new(Text["23"]["Size"].X.Scale, Text["23"]["Size"].X.Offset, 0, Text["24"].TextBounds.Y)
					Text["23"]["Size"] = UDim2.new(Text["23"]["Size"].X.Scale, Text["23"]["Size"].X.Offset, 0, Text["24"].TextBounds.Y + (26-14))
					Section.ResizeFunc()
				end

				function Text:Set(Name)
					if string.len(Name) ~= 0 then
						Text["24"]["Text"] = tostring(Name);
						Text:_update()
					end
				end
				function Text:Get()
					return Text["24"]["Text"]
				end

				Text:_update()

				Section.ResizeFunc()

				return Text
			end

			function Section:AddSlider(options)
				options = Library:validate({
					Name = "Slider",
					Value = 50,
					Min = 0,
					Max = 100,
					Callback = function(v) end
				}, options or {})

				local Slider = {
					Hover = false,
					MouseDown = false,
					Connection = nil
				}

				-- Render
				do
					-- StarterGui.ML.Main.Content.HomeTab.Slider
					Slider["2c"] = Instance.new("TextButton", Section["14"]);
					Slider["2c"]["BackgroundColor3"] = Color3.fromRGB(27, 27, 27);
					Slider["2c"]["Size"] = UDim2.new(0.95, 0, 0, 42);
					Slider["2c"]["Name"] = [[Slider]];
					Slider["2c"]["Text"] = [[]];

					-- StarterGui.ML.Main.Content.HomeTab.Slider.UICorner
					Slider["2d"] = Instance.new("UICorner", Slider["2c"]);
					Slider["2d"]["CornerRadius"] = UDim.new(0, 4);

					-- StarterGui.ML.Main.Content.HomeTab.Slider.UIStroke
					Slider["2e"] = Instance.new("UIStroke", Slider["2c"]);
					Slider["2e"]["Color"] = Color3.fromRGB(82, 82, 82);
					Slider["2e"]["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border;

					-- StarterGui.ML.Main.Content.HomeTab.Slider.Title
					Slider["2f"] = Instance.new("TextLabel", Slider["2c"]);
					Slider["2f"]["TextWrapped"] = true;
					Slider["2f"]["AutomaticSize"] = Enum.AutomaticSize.Y;
					Slider["2f"]["TextYAlignment"] = Enum.TextYAlignment.Top;
					--Slider["2f"]["TextTruncate"] = Enum.TextTruncate.AtEnd;
					Slider["2f"]["TextXAlignment"] = Enum.TextXAlignment.Left;
					Slider["2f"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
					Slider["2f"]["TextSize"] = 14;
					Slider["2f"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
					Slider["2f"]["Size"] = UDim2.new(0.8531798124313354, -24, 1, -10);
					Slider["2f"]["Text"] = options["Name"];
					Slider["2f"]["Name"] = [[Title]];
					Slider["2f"]["Font"] = Enum.Font.Gotham;
					Slider["2f"]["BackgroundTransparency"] = 1;

					-- StarterGui.ML.Main.Content.HomeTab.Slider.UIPadding
					Slider["30"] = Instance.new("UIPadding", Slider["2c"]);
					Slider["30"]["PaddingTop"] = UDim.new(0, 6);
					Slider["30"]["PaddingRight"] = UDim.new(0, 6);
					Slider["30"]["PaddingBottom"] = UDim.new(0, 6);
					Slider["30"]["PaddingLeft"] = UDim.new(0, 6);

					-- StarterGui.ML.Main.Content.HomeTab.Slider.Value
					Slider["31"] = Instance.new("TextLabel", Slider["2c"]);
					Slider["31"]["TextWrapped"] = true;
					Slider["31"]["TextXAlignment"] = Enum.TextXAlignment.Right;
					Slider["31"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
					Slider["31"]["TextSize"] = 14;
					Slider["31"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
					Slider["31"]["AnchorPoint"] = Vector2.new(1, 0);
					Slider["31"]["Size"] = UDim2.new(0.14681994915008545, 24, 1, -10);
					Slider["31"]["Text"] = tostring(options["Value"]);
					Slider["31"]["Name"] = [[Value]];
					Slider["31"]["Font"] = Enum.Font.Gotham;
					Slider["31"]["BackgroundTransparency"] = 1;
					Slider["31"]["Position"] = UDim2.new(1, 0, 0, 0);

					-- StarterGui.ML.Main.Content.HomeTab.Slider.SliderBG
					Slider["32"] = Instance.new("Frame", Slider["2c"]);
					Slider["32"]["BorderSizePixel"] = 0;
					Slider["32"]["BackgroundColor3"] = Color3.fromRGB(13, 13, 13);
					Slider["32"]["AnchorPoint"] = Vector2.new(0, 1);
					Slider["32"]["Size"] = UDim2.new(1, 0, 0, 4);
					Slider["32"]["BorderColor3"] = Color3.fromRGB(13, 13, 13);
					Slider["32"]["Position"] = UDim2.new(0, 0, 1, 0);
					Slider["32"]["Name"] = [[SliderBG]];

					-- StarterGui.ML.Main.Content.HomeTab.Slider.SliderBG.UICorner
					Slider["33"] = Instance.new("UICorner", Slider["32"]);
					Slider["33"]["CornerRadius"] = UDim.new(0, 4);

					-- StarterGui.ML.Main.Content.HomeTab.Slider.SliderBG.UIStroke
					Slider["34"] = Instance.new("UIStroke", Slider["32"]);
					Slider["34"]["Color"] = Color3.fromRGB(64, 64, 64);
					Slider["34"]["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border;

					-- StarterGui.ML.Main.Content.HomeTab.Slider.SliderBG.Draggable
					Slider["35"] = Instance.new("Frame", Slider["32"]);
					Slider["35"]["BackgroundColor3"] = Color3.fromRGB(41, 41, 41);
					Slider["35"]["Size"] = UDim2.new(0.5, 0, 1, 0);
					Slider["35"]["Name"] = [[Draggable]];

					-- StarterGui.ML.Main.Content.HomeTab.Slider.SliderBG.Draggable.UICorner
					Slider["36"] = Instance.new("UICorner", Slider["35"]);
					Slider["36"]["CornerRadius"] = UDim.new(0, 4);
				end

				-- Methods
				function Slider:_update()
					Slider["2c"]["Size"] = UDim2.new(Slider["2c"]["Size"].X.Scale, Slider["2c"]["Size"].X.Offset, 0, math.huge)
					Slider["2c"]["Size"] = UDim2.new(Slider["2c"]["Size"].X.Scale, Slider["2c"]["Size"].X.Offset, 0, Slider["2f"].TextBounds.Y)
					Slider["2c"]["Size"] = UDim2.new(Slider["2c"]["Size"].X.Scale, Slider["2c"]["Size"].X.Offset, 0, Slider["2f"].TextBounds.Y + 26)
					Section.ResizeFunc()
				end

				function Slider:SetText(Name)
					if string.len(Name) ~= 0 then
						Slider["2f"]["Text"] = tostring(Name)
					end
				end

				function Slider:Set(v)
					if v == nil then
						local percentage = math.clamp((Mouse.X - Slider["2c"].AbsolutePosition.X) / (Slider["2c"].AbsoluteSize.X), 0, 1)
						local value = math.floor(((options.Max - options.Min) * percentage) + options.Min)

						Slider["31"]["Text"] = tostring(value)
						Slider["35"]["Size"] = UDim2.fromScale(percentage, 1)
						--Library:tween(Slider["35"], {Size = UDim2.fromScale(percentage, 1)})
					else
						Slider["31"]["Text"] = tostring(v)
						Slider["35"]["Size"] = UDim2.fromScale(((v - options.Min) / (options.Max - options.Min)), 1)
						--Library:tween(Slider["35"], {Size = UDim2.fromScale(((v - options.Min) / (options.Max - options.Min)), 1)}, function() end, TweenInfo.new())				
					end

					options.Callback(Slider:Get())
				end

				function Slider:SetMax(v)
					if typeof(v) == "number" then
						if v >= options.Min then
							options.Max = v
							Slider:Set(Slider:Get())
						end
					end
				end
				
				function Slider:SetMin(v)
					if typeof(v) == "number" then
						if v <= options.Max then
							options.Min = v
							Slider:Set(Slider:Get())
						end
					end
				end

				function Slider:Get()
					return tonumber(Slider["31"]["Text"])
				end

				-- Logic
				do
					Slider["2c"].MouseButton1Down:Connect(function()
						GUI.CanDrag = false
						Slider.MouseDown = true
						Library:tween(Slider["2c"], {BackgroundColor3 = Color3.fromRGB(57, 57, 57)})
						Library:tween(Slider["2e"], {Color = Color3.fromRGB(200, 200, 200)})
						Library:tween(Slider["34"], {Color = Color3.fromRGB(200, 200, 200)})
						Library:tween(Slider["35"], {BackgroundColor3 = Color3.fromRGB(200, 200, 200)})

						if Slider.Connection == nil or not Slider.Connection then
							Slider.Connection = RunService.RenderStepped:Connect(function(deltaTime)
								GUI.CanDrag = false
								Slider:Set()
							end)
						end

						--[[Slider:Set()						
						Library:tween(Slider["2c"], {BackgroundColor3 = Color3.fromRGB(57, 57, 57)})
						Library:tween(Slider["2e"], {Color = Color3.fromRGB(200, 200, 200)})
						Library:tween(Slider["34"], {Color = Color3.fromRGB(200, 200, 200)})
						Library:tween(Slider["35"], {BackgroundColor3 = Color3.fromRGB(200, 200, 200)})

						task.wait(.005)

						Library:tween(Slider["2c"], {BackgroundColor3 = Color3.fromRGB(27, 27, 27)})
						Library:tween(Slider["2e"], {Color = Color3.fromRGB(82, 82, 82)})
						Library:tween(Slider["34"], {Color = Color3.fromRGB(82, 82, 82)})
						Library:tween(Slider["35"], {BackgroundColor3 = Color3.fromRGB(82, 82, 82)})--]]
					end)

					Slider["2c"].MouseButton1Up:Connect(function()
						GUI.CanDrag = true
						Slider.MouseDown = false

						Library:tween(Slider["2c"], {BackgroundColor3 = Color3.fromRGB(27, 27, 27)})
						Library:tween(Slider["2e"], {Color = Color3.fromRGB(82, 82, 82)})
						Library:tween(Slider["34"], {Color = Color3.fromRGB(82, 82, 82)})
						Library:tween(Slider["35"], {BackgroundColor3 = Color3.fromRGB(82, 82, 82)})

						if Slider.Connection then Slider.Connection:Disconnect()    end
						Slider.Connection = nil
					end)
					game:GetService("UserInputService").InputEnded:Connect(function(input, gp)
						if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) and Slider.MouseDown == true then
							GUI.CanDrag = true
							Slider.MouseDown = false

							Library:tween(Slider["2c"], {BackgroundColor3 = Color3.fromRGB(27, 27, 27)})
							Library:tween(Slider["2e"], {Color = Color3.fromRGB(82, 82, 82)})
							Library:tween(Slider["34"], {Color = Color3.fromRGB(82, 82, 82)})
							Library:tween(Slider["35"], {BackgroundColor3 = Color3.fromRGB(82, 82, 82)})

							if Slider.Connection then Slider.Connection:Disconnect()    end
							Slider.Connection = nil
						end
					end)
				end

				Slider:_update()

				return Slider
			end

			function Section:AddToggle(options)
				options = Library:validate({
					Name = "Toggle",
					Value = false,
					Callback = function(val) end
				}, options or {})

				local Toggle = {
					Hover = false,
					MouseDown = false,
					State = false
				}

				-- Render
				do
					-- StarterGui.ML.Main.Content.HomeTab.ToggleInactive
					Toggle["51"] = Instance.new("TextButton", Section["14"]);
					Toggle["51"]["BackgroundColor3"] = Color3.fromRGB(27, 27, 27);
					Toggle["51"]["Size"] = UDim2.new(0.95, 0, 0, 32);
					Toggle["51"]["Name"] = [[ToggleInactive]];
					Toggle["51"]["Text"] = [[]];

					-- StarterGui.ML.Main.Content.HomeTab.ToggleInactive.UICorner
					Toggle["52"] = Instance.new("UICorner", Toggle["51"]);
					Toggle["52"]["CornerRadius"] = UDim.new(0, 4);

					-- StarterGui.ML.Main.Content.HomeTab.ToggleInactive.UIStroke
					Toggle["53"] = Instance.new("UIStroke", Toggle["51"]);
					Toggle["53"]["Color"] = Color3.fromRGB(82, 82, 82);
					Toggle["53"]["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border;

					-- StarterGui.ML.Main.Content.HomeTab.ToggleInactive.Title
					Toggle["54"] = Instance.new("TextLabel", Toggle["51"]);
					Toggle["54"]["TextWrapped"] = true;
					Toggle["54"]["AutomaticSize"] = Enum.AutomaticSize.Y;
					Toggle["54"]["TextYAlignment"] = Enum.TextYAlignment.Top;
					--Toggle["54"]["TextTruncate"] = Enum.TextTruncate.AtEnd;
					Toggle["54"]["TextXAlignment"] = Enum.TextXAlignment.Left;
					Toggle["54"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
					Toggle["54"]["TextSize"] = 14;
					Toggle["54"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
					Toggle["54"]["Size"] = UDim2.new(1, -26, 1, 0);
					Toggle["54"]["Text"] = options["Name"];
					Toggle["54"]["Name"] = [[Title]];
					Toggle["54"]["Font"] = Enum.Font.Gotham;
					Toggle["54"]["BackgroundTransparency"] = 1;

					-- StarterGui.ML.Main.Content.HomeTab.ToggleInactive.UIPadding
					Toggle["55"] = Instance.new("UIPadding", Toggle["51"]);
					Toggle["55"]["PaddingTop"] = UDim.new(0, 6);
					Toggle["55"]["PaddingRight"] = UDim.new(0, 6);
					Toggle["55"]["PaddingBottom"] = UDim.new(0, 6);
					Toggle["55"]["PaddingLeft"] = UDim.new(0, 6);

					-- StarterGui.ML.Main.Content.HomeTab.ToggleInactive.CheckmarkHolder
					Toggle["56"] = Instance.new("Frame", Toggle["51"]);
					Toggle["56"]["Active"] = true;
					Toggle["56"]["BackgroundColor3"] = Color3.fromRGB(64, 64, 64);
					Toggle["56"]["AnchorPoint"] = Vector2.new(1, 0.5);
					Toggle["56"]["LayoutOrder"] = 3;
					Toggle["56"]["Size"] = UDim2.new(0, 16, 0, 16);
					Toggle["56"]["Selectable"] = true;
					Toggle["56"]["Position"] = UDim2.new(1, -3, 0.5, 0);
					Toggle["56"]["Name"] = [[CheckmarkHolder]];

					-- StarterGui.ML.Main.Content.HomeTab.ToggleInactive.CheckmarkHolder.UICorner
					Toggle["57"] = Instance.new("UICorner", Toggle["56"]);
					Toggle["57"]["CornerRadius"] = UDim.new(0, 4);

					-- StarterGui.ML.Main.Content.HomeTab.ToggleInactive.CheckmarkHolder.UIStroke
					Toggle["58"] = Instance.new("UIStroke", Toggle["56"]);
					Toggle["58"]["Color"] = Color3.fromRGB(82, 82, 82);
					Toggle["58"]["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border;

					-- StarterGui.ML.Main.Content.HomeTab.ToggleInactive.CheckmarkHolder.Checkmark
					Toggle["59"] = Instance.new("ImageButton", Toggle["56"]);
					Toggle["59"]["ZIndex"] = 2;
					Toggle["59"]["ImageTransparency"] = 1;
					Toggle["59"]["ImageColor3"] = Color3.fromRGB(0, 0, 0);
					Toggle["59"]["LayoutOrder"] = 3;
					Toggle["59"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
					Toggle["59"]["Image"] = [[rbxassetid://3926305904]];
					Toggle["59"]["ImageRectSize"] = Vector2.new(36, 36);
					Toggle["59"]["Size"] = UDim2.new(1, -2, 1, -2);
					Toggle["59"]["Name"] = [[Checkmark]];
					Toggle["59"]["ImageRectOffset"] = Vector2.new(644, 204);
					Toggle["59"]["Position"] = UDim2.new(0.5, 0, 0.5, 0);
					Toggle["59"]["BackgroundTransparency"] = 1;
				end

				-- Methods
				function Toggle:Get()
					return Toggle.State
				end

				function Toggle:Toggle()
					Toggle.State = not Toggle.State
					Library:tween(Toggle["56"], {BackgroundColor3 = Toggle.State and Color3.fromRGB(126, 255, 124) or Color3.fromRGB(64, 64, 64)})
					Library:tween(Toggle["59"], {ImageTransparency = Toggle.State and 0 or 1})

					task.spawn(function()
						task.wait()
						--print(Toggle:Get(), not Toggle:Get())
						options.Callback(Toggle:Get(), not Toggle:Get())
					end)
				end

				function Toggle:Set(v)
					if v ~= nil then
						Toggle.State = v
					end

					Library:tween(Toggle["56"], {BackgroundColor3 = Toggle.State and Color3.fromRGB(126, 255, 124) or Color3.fromRGB(64, 64, 64)})
					Library:tween(Toggle["59"], {ImageTransparency = Toggle.State and 0 or 1})

					task.spawn(function()
						task.wait()
						--print(Toggle:Get(), not Toggle:Get())
						options.Callback(Toggle:Get(), not Toggle:Get())
					end)
				end

				function Toggle:_update()
					Toggle["51"]["Size"] = UDim2.new(Toggle["51"]["Size"].X.Scale, Toggle["51"]["Size"].X.Offset, 0, math.huge)
					Toggle["51"]["Size"] = UDim2.new(Toggle["51"]["Size"].X.Scale, Toggle["51"]["Size"].X.Offset, 0, Toggle["54"].TextBounds.Y)
					Toggle["51"]["Size"] = UDim2.new(Toggle["51"]["Size"].X.Scale, Toggle["51"]["Size"].X.Offset, 0, Toggle["54"].TextBounds.Y + (26-14))
					Section.ResizeFunc()
				end

				Toggle:Set(options["Value"])

				-- Logic
				do
					Toggle["51"].MouseButton1Click:Connect(function()
						Library:tween(Toggle["51"], {BackgroundColor3 = Color3.fromRGB(57, 57, 57)})
						Library:tween(Toggle["53"], {Color = Color3.fromRGB(200, 200, 200)})

						Toggle:Toggle()	

						task.wait(.05)
						Library:tween(Toggle["51"], {BackgroundColor3 = Color3.fromRGB(27, 27, 27)})
						Library:tween(Toggle["53"], {Color = Color3.fromRGB(82, 82, 82)})
					end)
				end

				Toggle:_update()

				return Toggle
			end

			function Section:AddDropdown(options)
				options = Library:validate({
					Name = "Dropdown",
					Value = "",
					List = {},
					Callback = function(v) end
				}, options or {})

				local Dropdown = {
					Hover = false,
					MouseDown = false,
					Items = {},
					Opened = false,
					CurrentItem = nil,
					ToggleDebounce = false,
					HoveringItem = false
				}

				if options.Value == "" then
					options.Value = options.Name
					if #options.List ~= 0 then
						options.Value = options.List[1]
					end
				end

				-- Render
				do
					Section:AddLabel({
						Name = options["Name"],
						Position = "Left"
					})
					-- StarterGui.ML.Main.Content.HomeTab.Dropdown (frame)
					Dropdown["37"] = Instance.new("TextButton", Section["14"]);
					Dropdown["37"]["BackgroundColor3"] = Color3.fromRGB(27, 27, 27);
					Dropdown["37"]["Size"] = UDim2.new(0.95, 0, 0, 32);
					Dropdown["37"]["ClipsDescendants"] = true;
					Dropdown["37"]["Name"] = [[Dropdown]];
					Dropdown["37"]["Text"] = "";

					-- StarterGui.ML.Main.Content.HomeTab.Dropdown.UICorner
					Dropdown["38"] = Instance.new("UICorner", Dropdown["37"]);
					Dropdown["38"]["CornerRadius"] = UDim.new(0, 4);

					-- StarterGui.ML.Main.Content.HomeTab.Dropdown.UIStroke
					Dropdown["39"] = Instance.new("UIStroke", Dropdown["37"]);
					Dropdown["39"]["Color"] = Color3.fromRGB(82, 82, 82);
					Dropdown["39"]["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border;

					-- StarterGui.ML.Main.Content.HomeTab.Dropdown.Title
					Dropdown["3a"] = Instance.new("TextLabel", Dropdown["37"]);
					Dropdown["3a"]["TextWrapped"] = true;
					Dropdown["3a"]["AutomaticSize"] = Enum.AutomaticSize.Y;
					Dropdown["3a"]["TextYAlignment"] = Enum.TextYAlignment.Top;
					--	Dropdown["3a"]["TextTruncate"] = Enum.TextTruncate.AtEnd;
					Dropdown["3a"]["TextXAlignment"] = Enum.TextXAlignment.Left;
					Dropdown["3a"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
					Dropdown["3a"]["TextSize"] = 14;
					Dropdown["3a"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
					Dropdown["3a"]["Size"] = UDim2.new(1, 0, 0, 20);
					Dropdown["3a"]["Text"] = options["Value"];
					Dropdown["3a"]["Name"] = [[Title]];
					Dropdown["3a"]["Font"] = Enum.Font.Gotham;
					Dropdown["3a"]["BackgroundTransparency"] = 1;

					-- StarterGui.ML.Main.Content.HomeTab.Dropdown.UIPadding
					Dropdown["3b"] = Instance.new("UIPadding", Dropdown["37"]);
					Dropdown["3b"]["PaddingTop"] = UDim.new(0, 6);
					Dropdown["3b"]["PaddingRight"] = UDim.new(0, 6);
					Dropdown["3b"]["PaddingBottom"] = UDim.new(0, 6);
					Dropdown["3b"]["PaddingLeft"] = UDim.new(0, 6);

					-- StarterGui.ML.Main.Content.HomeTab.Dropdown.Icon
					Dropdown["3c"] = Instance.new("ImageLabel", Dropdown["37"]);
					Dropdown["3c"]["Selectable"] = true;
					Dropdown["3c"]["AnchorPoint"] = Vector2.new(1, 0);
					Dropdown["3c"]["Image"] = [[rbxassetid://6764432408]];
					Dropdown["3c"]["ImageRectSize"] = Vector2.new(50, 50);
					Dropdown["3c"]["LayoutOrder"] = 3;
					Dropdown["3c"]["Size"] = UDim2.new(0, 20, 0, 20);
					Dropdown["3c"]["Active"] = true;
					Dropdown["3c"]["Name"] = [[Icon]];
					Dropdown["3c"]["ImageRectOffset"] = Vector2.new(200, 550);
					Dropdown["3c"]["BackgroundTransparency"] = 1;
					Dropdown["3c"]["Position"] = UDim2.new(1, 0, 0, 0);

					-- StarterGui.ML.Main.Content.HomeTab.Dropdown.OptionHolder
					Dropdown["3d"] = Instance.new("Frame", Dropdown["37"]);
					Dropdown["3d"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
					Dropdown["3d"]["BackgroundTransparency"] = 1;
					Dropdown["3d"]["Size"] = UDim2.new(1, 0, 1, -24);
					Dropdown["3d"]["Position"] = UDim2.new(0, 0, 0, 26);
					Dropdown["3d"]["Visible"] = false;
					Dropdown["3d"]["Name"] = [[OptionHolder]];

					-- StarterGui.ML.Main.Content.HomeTab.Dropdown.OptionHolder.UIListLayout
					Dropdown["3e"] = Instance.new("UIListLayout", Dropdown["3d"]);
					Dropdown["3e"]["Padding"] = UDim.new(0, 6);
					Dropdown["3e"]["SortOrder"] = Enum.SortOrder.LayoutOrder;
				end

				-- Methods
				function Dropdown:Set(Name)
					pcall(function()--if typeof(name) == "string" then
						if string.len(Name) ~= 0 then
							Dropdown["3a"]["Text"] = tostring(Name)
						end
					end)
				end

				function Dropdown:Get()
					return Dropdown["3a"]["Text"]
					--return Dropdown.CurrentItem.id
				end

				function Dropdown:Resize()
					local count = 0
					for i,v in pairs(Dropdown.Items) do
						if v ~= nil then
							count += 1
						end
					end

					if count > 0 and Dropdown.Opened == true then
						Library:tween(Dropdown["37"], {Size = UDim2.new(0.95, 0, 0, 30 + (count * 32) + 4)}, function()
							Section.ResizeFunc()
						end)
					else
						Library:tween(Dropdown["37"], {Size = UDim2.new(0.95, 0, 0, 30)}, function()
							Section.ResizeFunc()
						end)
					end
				end

				function Dropdown:Add(id, value)
					if Dropdown.Items[id] ~= nil then
						if Dropdown["3d"]:FindFirstChild(id) then
							return
						else
							Dropdown.Items[id] = nil
						end
					end

					local Item = {
						Hover = false,
						MouseDown = false
					}

					Dropdown.Items[id] = {
						instance = {},
						value = value or id,
						id = id,
						Connections = {}
					}

					-- StarterGui.ML.Main.Content.HomeTab.Dropdown.OptionHolder.Option
					Dropdown.Items[id].instance["4d"] = Instance.new("TextButton", Dropdown["3d"]);
					Dropdown.Items[id].instance["4d"]["AutomaticSize"] = Enum.AutomaticSize.Y;
					Dropdown.Items[id].instance["4d"]["TextYAlignment"] = Enum.TextYAlignment.Top;
					--Dropdown.Items[id].instance["4d"]["TextTruncate"] = Enum.TextTruncate.AtEnd;
					Dropdown.Items[id].instance["4d"]["BackgroundColor3"] = Color3.fromRGB(57, 57, 57);
					Dropdown.Items[id].instance["4d"]["TextSize"] = 14;
					Dropdown.Items[id].instance["4d"]["TextColor3"] = Color3.fromRGB(203, 203, 203);
					Dropdown.Items[id].instance["4d"]["Size"] = UDim2.new(1, 0, 0, 16);
					Dropdown.Items[id].instance["4d"]["Text"] = id;
					Dropdown.Items[id].instance["4d"]["Name"] = id;
					Dropdown.Items[id].instance["4d"]["Font"] = Enum.Font.Gotham;

					-- StarterGui.ML.Main.Content.HomeTab.Dropdown.OptionHolder.Option.UIStroke
					Dropdown.Items[id].instance["4d_UIStroke"] = Instance.new("UIStroke", Dropdown.Items[id].instance["4d"]);
					Dropdown.Items[id].instance["4d_UIStroke"]["Color"] = Color3.fromRGB(82, 82, 82);
					Dropdown.Items[id].instance["4d_UIStroke"]["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border;

					-- StarterGui.ML.Main.Content.HomeTab.Dropdown.OptionHolder.Option.UICorner
					Dropdown.Items[id].instance["4d_UICorner"] = Instance.new("UICorner", Dropdown.Items[id].instance["4d"]);
					Dropdown.Items[id].instance["4d_UICorner"]["CornerRadius"] = UDim.new(0, 3);

					Dropdown.Items[id].instance["4d"]["Size"] = UDim2.new(Dropdown.Items[id].instance["4d"]["Size"].X.Scale, Dropdown.Items[id].instance["4d"]["Size"].X.Offset, 0, math.huge)
					Dropdown.Items[id].instance["4d"]["Size"] = UDim2.new(Dropdown.Items[id].instance["4d"]["Size"].X.Scale, Dropdown.Items[id].instance["4d"]["Size"].X.Offset, 0, Dropdown.Items[id].instance["4d"].TextBounds.Y)
					Dropdown.Items[id].instance["4d"]["Size"] = UDim2.new(Dropdown.Items[id].instance["4d"]["Size"].X.Scale, Dropdown.Items[id].instance["4d"]["Size"].X.Offset, 0, Dropdown.Items[id].instance["4d"].TextBounds.Y + (26-14))

					table.insert(
						Dropdown.Items[id].Connections,
						Dropdown.Items[id].instance["4d"].MouseButton1Click:Connect(function()
							if Dropdown.Items[id] == nil then return end

							Library:tween(Dropdown.Items[id].instance["4d_UIStroke"], {Color = Color3.fromRGB(200, 200, 200)})

							Dropdown.CurrentItem = Dropdown.Items[id]
							--if Dropdown.CurrentItem ~= nil then
							Dropdown:Set(Dropdown.CurrentItem.id)
							options.Callback(Dropdown.CurrentItem.id)
							Dropdown:Toggle()
							--end
							task.wait(0.05)
							Library:tween(Dropdown.Items[id].instance["4d_UIStroke"], {Color = Color3.fromRGB(82, 82, 82)})
						end)
					)

					Dropdown:Resize()
				end

				function Dropdown:Remove(id)
					if Dropdown.Items[id] ~= nil then
						if Dropdown.CurrentItem ~= nil then
							if Dropdown.CurrentItem.id == id then
								Dropdown.CurrentItem = nil
							end
						end

						for _, con in pairs(Dropdown.Items[id].Connections) do
							pcall(function()
								con:Disconnect()
							end)
						end
						for _,v in pairs(Dropdown.Items[id].instance) do
							pcall(function()
								v:Destroy()
							end)
						end
						Dropdown.Items[id] = nil
					end

					Dropdown:Resize()
				end

				function Dropdown:Clear()
					for i,v in pairs(Dropdown.Items) do
						Dropdown:Remove(i)
					end
				--[[local ulc = Dropdown["3e"]:Clone()
				Dropdown["3d"]:ClearAllChildren()
				ulc.Parent = Dropdown["3d"]--]]
					Dropdown.CurrentItem = nil
					Dropdown.Items = {}
					--Dropdown:Resize()
				end

				function Dropdown:Toggle()
					if Dropdown.ToggleDebounce == true then return end
					Dropdown.ToggleDebounce = true

					if Dropdown.Opened then
						Library:tween(Dropdown["3c"], {Rotation = 0})
						Library:tween(Dropdown["37"], {Size = UDim2.new(0.95, 0, 0, 30)}, function()
							Dropdown["3d"]["Visible"] = false
							Dropdown.Opened = false
							Dropdown.ToggleDebounce = false
							Section.ResizeFunc()
						end)
					else
						local count = 0
						for i,v in pairs(Dropdown.Items) do
							if v ~= nil then
								count += 1
							end
						end

						if count > 0 then
							Dropdown["3d"]["Visible"] = true
							Library:tween(Dropdown["3c"], {Rotation = 180})
							Library:tween(Dropdown["37"], {Size = UDim2.new(0.95, 0, 0, 30 + (count * 32) + 4)}, function()
								Dropdown.Opened = true
								Dropdown.ToggleDebounce = false
								Section.ResizeFunc()
							end)
						end
					end
				end

				function Dropdown:UpdateList(List)
					if typeof(List) == "table" then
						Dropdown:Clear()
						for _, value in pairs(options["List"]) do
							Dropdown:Add(value)
						end
					end
				end

				-- Logic
				do
					Dropdown["37"].MouseButton1Click:Connect(function()
						Library:tween(Dropdown["37"], {BackgroundColor3 = Color3.fromRGB(57, 57, 57)})
						Library:tween(Dropdown["39"], {Color = Color3.fromRGB(200, 200, 200)})

						if not Dropdown.HoveringItem then
							Dropdown:Toggle()
						end

						task.wait(.05)

						Library:tween(Dropdown["37"], {BackgroundColor3 = Color3.fromRGB(27, 27, 27)})
						Library:tween(Dropdown["39"], {Color = Color3.fromRGB(82, 82, 82)})
					end)
				end

				Dropdown:UpdateList(options["List"])

				Section.ResizeFunc()

				return Dropdown
			end
			
			function Section:AddOpenDropdown(options)
				options = Library:validate({
					Name = "Dropdown",
					Value = "",
					List = {},
					Callback = function(v) end
				}, options or {})

				local Dropdown = {
					Hover = false,
					MouseDown = false,
					Items = {},
					Opened = true,
					CurrentItem = nil,
					ToggleDebounce = true,
					HoveringItem = false
				}

				if options.Value == "" then
					options.Value = options.Name
					if #options.List ~= 0 then
						options.Value = options.List[1]
					end
				end

				-- Render
				do
					Section:AddLabel({
						Name = options["Name"],
						Position = "Left"
					})
					-- StarterGui.ML.Main.Content.HomeTab.Dropdown (frame)
					Dropdown["37"] = Instance.new("TextButton", Section["14"]);
					Dropdown["37"]["BackgroundColor3"] = Color3.fromRGB(27, 27, 27);
					Dropdown["37"]["Size"] = UDim2.new(0.95, 0, 0, 32);
					Dropdown["37"]["ClipsDescendants"] = true;
					Dropdown["37"]["Name"] = [[Dropdown]];
					Dropdown["37"]["Text"] = "";
					Dropdown["37"]["Visible"] = true;
					Dropdown["37"]["Active"] = false;
					
					-- StarterGui.ML.Main.Content.HomeTab.Dropdown.UICorner
					Dropdown["38"] = Instance.new("UICorner", Dropdown["37"]);
					Dropdown["38"]["CornerRadius"] = UDim.new(0, 4);

					-- StarterGui.ML.Main.Content.HomeTab.Dropdown.UIStroke
					Dropdown["39"] = Instance.new("UIStroke", Dropdown["37"]);
					Dropdown["39"]["Color"] = Color3.fromRGB(82, 82, 82);
					Dropdown["39"]["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border;

					-- StarterGui.ML.Main.Content.HomeTab.Dropdown.Title
					Dropdown["3a"] = Instance.new("TextLabel", Dropdown["37"]);
					Dropdown["3a"]["TextWrapped"] = true;
					Dropdown["3a"]["AutomaticSize"] = Enum.AutomaticSize.Y;
					Dropdown["3a"]["TextYAlignment"] = Enum.TextYAlignment.Top;
					--	Dropdown["3a"]["TextTruncate"] = Enum.TextTruncate.AtEnd;
					Dropdown["3a"]["TextXAlignment"] = Enum.TextXAlignment.Left;
					Dropdown["3a"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
					Dropdown["3a"]["TextSize"] = 14;
					Dropdown["3a"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
					Dropdown["3a"]["Size"] = UDim2.new(1, 0, 0, 20);
					Dropdown["3a"]["Text"] = options["Value"];
					Dropdown["3a"]["Name"] = [[Title]];
					Dropdown["3a"]["Font"] = Enum.Font.Gotham;
					Dropdown["3a"]["BackgroundTransparency"] = 1;

					-- StarterGui.ML.Main.Content.HomeTab.Dropdown.UIPadding
					Dropdown["3b"] = Instance.new("UIPadding", Dropdown["37"]);
					Dropdown["3b"]["PaddingTop"] = UDim.new(0, 6);
					Dropdown["3b"]["PaddingRight"] = UDim.new(0, 6);
					Dropdown["3b"]["PaddingBottom"] = UDim.new(0, 6);
					Dropdown["3b"]["PaddingLeft"] = UDim.new(0, 6);

					-- StarterGui.ML.Main.Content.HomeTab.Dropdown.Icon
					Dropdown["3c"] = Instance.new("ImageLabel", Dropdown["37"]);
					Dropdown["3c"]["Selectable"] = true;
					Dropdown["3c"]["AnchorPoint"] = Vector2.new(1, 0);
					Dropdown["3c"]["Image"] = [[rbxassetid://6764432408]];
					Dropdown["3c"]["ImageRectSize"] = Vector2.new(50, 50);
					Dropdown["3c"]["LayoutOrder"] = 3;
					Dropdown["3c"]["Size"] = UDim2.new(0, 20, 0, 20);
					Dropdown["3c"]["Active"] = true;
					Dropdown["3c"]["Name"] = [[Icon]];
					Dropdown["3c"]["ImageRectOffset"] = Vector2.new(200, 550);
					Dropdown["3c"]["BackgroundTransparency"] = 1;
					Dropdown["3c"]["Position"] = UDim2.new(1, 0, 0, 0);
					Dropdown["3c"]["Visible"] = false
					
					-- StarterGui.ML.Main.Content.HomeTab.Button.Title
					Dropdown["1freeererer"] = Instance.new("TextBox", Dropdown["37"]);
					Dropdown["1freeererer"]["TextWrapped"] = true;
					Dropdown["1freeererer"]["AutomaticSize"] = Enum.AutomaticSize.Y;
					Dropdown["1freeererer"]["TextYAlignment"] = Enum.TextYAlignment.Center;
					--Dropdown["1freeererer"]["TextTruncate"] = Enum.TextTruncate.AtEnd;
					Dropdown["1freeererer"]["TextXAlignment"] = Enum.TextXAlignment.Left;
					Dropdown["1freeererer"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
					Dropdown["1freeererer"]["TextSize"] = 14;
					Dropdown["1freeererer"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
					Dropdown["1freeererer"]["Size"] = UDim2.new(1, 0, 0, 26);
					Dropdown["1freeererer"]["Text"] = "";
					Dropdown["1freeererer"]["PlaceholderText"] = "Search";
					Dropdown["1freeererer"]["MultiLine"] = false;
					Dropdown["1freeererer"]["ClearTextOnFocus"] = false;
					Dropdown["1freeererer"]["Name"] = [[SearchBar]];
					Dropdown["1freeererer"]["Font"] = Enum.Font.Gotham;
					Dropdown["1freeererer"]["BackgroundColor3"] = Color3.fromRGB(30, 30, 30);
					Dropdown["1freeererer"]["Position"] = UDim2.new(0, 0, 0, 26)
					
					-- StarterGui.ML.Main.Content.HomeTab.Button.UICorner
					Dropdown["1eererrerererere"] = Instance.new("UICorner", Dropdown["1freeererer"]);
					Dropdown["1eererrerererere"]["CornerRadius"] = UDim.new(0, 4);

					-- StarterGui.ML.Main.Content.HomeTab.Button.UIStroke
					Dropdown["1eererrerererere"] = Instance.new("UIStroke", Dropdown["1freeererer"]);
					Dropdown["1eererrerererere"]["Color"] = Color3.fromRGB(82, 82, 82);
					Dropdown["1eererrerererere"]["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border;
					
					-- StarterGui.ML.Main.Content.HomeTab.Dropdown.OptionHolder
					Dropdown["3d"] = Instance.new("ScrollingFrame", Dropdown["37"]);
					Dropdown["3d"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
					Dropdown["3d"]["BackgroundTransparency"] = 1;
					Dropdown["3d"]["Size"] = UDim2.new(1, 0, 1, -24);
					Dropdown["3d"]["Position"] = UDim2.new(0, 0, 0, 26 + 32);
					Dropdown["3d"]["Visible"] = true;
					Dropdown["3d"]["Name"] = [[OptionHolder]];
					Dropdown["3d"]["ScrollBarThickness"] = 0;

					-- StarterGui.ML.Main.Content.HomeTab.Dropdown.OptionHolder.UIListLayout
					Dropdown["3e"] = Instance.new("UIListLayout", Dropdown["3d"]);
					Dropdown["3e"]["Padding"] = UDim.new(0, 6);
					Dropdown["3e"]["SortOrder"] = Enum.SortOrder.LayoutOrder;
					
					--StarterGui.ML.Main.Content.HomeTab.Dropdown.OptionHolder.Option
					Dropdown["4dreerereererer"] = Instance.new("TextButton", Dropdown["3d"]);
					Dropdown["4dreerereererer"]["AutomaticSize"] = Enum.AutomaticSize.Y;
					Dropdown["4dreerereererer"]["TextYAlignment"] = Enum.TextYAlignment.Top;
					--Dropdown["4d"]["TextTruncate"] = Enum.TextTruncate.AtEnd;
					Dropdown["4dreerereererer"]["BackgroundTransparency"] = 1;
					Dropdown["4dreerereererer"]["TextSize"] = 14;
					Dropdown["4dreerereererer"]["TextColor3"] = Color3.fromRGB(203, 203, 203);
					Dropdown["4dreerereererer"]["Size"] = UDim2.new(1, 0, 0, 1);
					Dropdown["4dreerereererer"]["Text"] = "";
					Dropdown["4dreerereererer"]["Name"] = "invismiddlesection";
					Dropdown["4dreerereererer"]["Font"] = Enum.Font.Gotham;

					-- StarterGui.ML.Main.Content.HomeTab.Dropdown.OptionHolder.Option.UICorner
					Dropdown["4ererrewereerd_UICorner"] = Instance.new("UICorner", Dropdown["4dreerereererer"]);
					Dropdown["4ererrewereerd_UICorner"]["CornerRadius"] = UDim.new(0, 3);
					
				end

				-- Methods
				function Dropdown:Set(Name)
					pcall(function()--if typeof(name) == "string" then
						if string.len(Name) ~= 0 then
							Dropdown["3a"]["Text"] = tostring(Name)
						end
					end)
				end

				function Dropdown:Get()
					return Dropdown["3a"]["Text"]
					--return Dropdown.CurrentItem.id
				end

				function Dropdown:Resize(counte)
					local count = 0
					if counte and typeof(counte) == "number" then
						count = counte
					else
						count = 0
						for i,v in pairs(Dropdown.Items) do
							if v ~= nil then
								count += 1
							end
						end
					end
					
					ResizeScrollingFrame(Dropdown["3d"], Dropdown["3e"], 32)
					if count > 0 and Dropdown.Opened == true then
						if count > 5 then
							Library:tween(Dropdown["37"], {Size = UDim2.new(0.95, 0, 0, 30 + (5 * 32) + 4)}, function()
								task.wait()
								Section.ResizeFunc()
							end)
						else
							Library:tween(Dropdown["37"], {Size = UDim2.new(0.95, 0, 0, 30 + (count * 32) + 4)}, function()
								task.wait()
								Section.ResizeFunc()
							end)
						end
					else
						Library:tween(Dropdown["37"], {Size = UDim2.new(0.95, 0, 0, 30)}, function()
							task.wait()
							Section.ResizeFunc()
						end)
					end
				end

				function Dropdown:Add(id, value)
					if Dropdown.Items[id] ~= nil then
						if Dropdown["3d"]:FindFirstChild(id) then
							return
						else
							Dropdown.Items[id] = nil
						end
					end

					local Item = {
						Hover = false,
						MouseDown = false
					}

					Dropdown.Items[id] = {
						instance = {},
						value = value or id,
						id = id,
						Connections = {}
					}

					-- StarterGui.ML.Main.Content.HomeTab.Dropdown.OptionHolder.Option
					Dropdown.Items[id].instance["4d"] = Instance.new("TextButton", Dropdown["3d"]);
					Dropdown.Items[id].instance["4d"]["AutomaticSize"] = Enum.AutomaticSize.Y;
					Dropdown.Items[id].instance["4d"]["TextYAlignment"] = Enum.TextYAlignment.Top;
					--Dropdown.Items[id].instance["4d"]["TextTruncate"] = Enum.TextTruncate.AtEnd;
					Dropdown.Items[id].instance["4d"]["BackgroundColor3"] = Color3.fromRGB(57, 57, 57);
					Dropdown.Items[id].instance["4d"]["TextSize"] = 14;
					Dropdown.Items[id].instance["4d"]["TextColor3"] = Color3.fromRGB(203, 203, 203);
					Dropdown.Items[id].instance["4d"]["Size"] = UDim2.new(1, 0, 0, 16);
					Dropdown.Items[id].instance["4d"]["Text"] = id;
					Dropdown.Items[id].instance["4d"]["Name"] = id;
					Dropdown.Items[id].instance["4d"]["Font"] = Enum.Font.Gotham;

					-- StarterGui.ML.Main.Content.HomeTab.Dropdown.OptionHolder.Option.UIStroke
					Dropdown.Items[id].instance["4d_UIStroke"] = Instance.new("UIStroke", Dropdown.Items[id].instance["4d"]);
					Dropdown.Items[id].instance["4d_UIStroke"]["Color"] = Color3.fromRGB(82, 82, 82);
					Dropdown.Items[id].instance["4d_UIStroke"]["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border;

					-- StarterGui.ML.Main.Content.HomeTab.Dropdown.OptionHolder.Option.UICorner
					Dropdown.Items[id].instance["4d_UICorner"] = Instance.new("UICorner", Dropdown.Items[id].instance["4d"]);
					Dropdown.Items[id].instance["4d_UICorner"]["CornerRadius"] = UDim.new(0, 3);

					Dropdown.Items[id].instance["4d"]["Size"] = UDim2.new(Dropdown.Items[id].instance["4d"]["Size"].X.Scale, Dropdown.Items[id].instance["4d"]["Size"].X.Offset, 0, math.huge)
					Dropdown.Items[id].instance["4d"]["Size"] = UDim2.new(Dropdown.Items[id].instance["4d"]["Size"].X.Scale, Dropdown.Items[id].instance["4d"]["Size"].X.Offset, 0, Dropdown.Items[id].instance["4d"].TextBounds.Y)
					Dropdown.Items[id].instance["4d"]["Size"] = UDim2.new(Dropdown.Items[id].instance["4d"]["Size"].X.Scale, Dropdown.Items[id].instance["4d"]["Size"].X.Offset, 0, Dropdown.Items[id].instance["4d"].TextBounds.Y + (26-14))

					table.insert(
						Dropdown.Items[id].Connections,
						Dropdown.Items[id].instance["4d"].MouseButton1Click:Connect(function()
							if Dropdown.Items[id] == nil then return end

							Library:tween(Dropdown.Items[id].instance["4d_UIStroke"], {Color = Color3.fromRGB(200, 200, 200)})

							Dropdown.CurrentItem = Dropdown.Items[id]
							--if Dropdown.CurrentItem ~= nil then
							Dropdown:Set(Dropdown.CurrentItem.id)
							options.Callback(Dropdown.CurrentItem.id)
							--Dropdown:Toggle()
							--end
							task.wait(0.05)
							Library:tween(Dropdown.Items[id].instance["4d_UIStroke"], {Color = Color3.fromRGB(82, 82, 82)})
						end)
					)

					Dropdown:Resize()
				end
				
				--[[function Dropdown:Toggle()
					if Dropdown.ToggleDebounce == true then return end
					Dropdown.ToggleDebounce = true

					if Dropdown.Opened then
						Library:tween(Dropdown["3c"], {Rotation = 0})
						Library:tween(Dropdown["37"], {Size = UDim2.new(0.95, 0, 0, 30)}, function()
							Dropdown["3d"]["Visible"] = false
							Dropdown.Opened = false
							--Dropdown.ToggleDebounce = false
							Section.ResizeFunc()
						end)
					else
						local count = 0
						for i,v in pairs(Dropdown.Items) do
							if v ~= nil then
								count += 1
							end
						end

						if count > 0 then
							Dropdown["3d"]["Visible"] = true
							Library:tween(Dropdown["3c"], {Rotation = 180})
							Library:tween(Dropdown["37"], {Size = UDim2.new(0.95, 0, 0, 30 + (count * 32) + 4)}, function()
								Dropdown.Opened = true
								--Dropdown.ToggleDebounce = false
								Section.ResizeFunc()
							end)
						end
					end
				end--]]
				
				function Dropdown:Remove(id)
					if Dropdown.Items[id] ~= nil then
						if Dropdown.CurrentItem ~= nil then
							if Dropdown.CurrentItem.id == id then
								Dropdown.CurrentItem = nil
							end
						end

						for _, con in pairs(Dropdown.Items[id].Connections) do
							pcall(function()
								con:Disconnect()
							end)
						end
						for _,v in pairs(Dropdown.Items[id].instance) do
							pcall(function()
								v:Destroy()
							end)
						end
						Dropdown.Items[id] = nil
					end

					Dropdown:Resize()
				end

				function Dropdown:Clear()
					for i,v in pairs(Dropdown.Items) do
						Dropdown:Remove(i)
					end
					Dropdown.CurrentItem = nil
					Dropdown.Items = {}
				end
				
				function Dropdown:UpdateList(List)
					if typeof(List) == "table" then
						Dropdown:Clear()
						for _, value in pairs(options["List"]) do
							Dropdown:Add(value)
						end
					end
				end
				
				-- Logic
				do
					local function Searching()
						local scrollingframe = Dropdown["3d"]
						local searchbar = Dropdown["1freeererer"]
						
						local function UpdateInputOfSearchText()
							local InputText = string.upper(searchbar.Text)
							local counte = 0
							for _,button in pairs(scrollingframe:GetChildren()) do
								if button:IsA("TextButton") then
									if InputText == "" or string.find(string.upper(button.Name), InputText) ~= nil or button.Name == "invismiddlesection" then
										button.Visible = true
										counte += 1
									else
										button.Visible = false
									end
									task.wait()
								end
							end
							
							task.wait(.1)
							Dropdown:Resize(counte)
						end
						
						searchbar:GetPropertyChangedSignal("Text"):Connect(UpdateInputOfSearchText)
					end
					task.spawn(Searching);
				end
				
				Dropdown:UpdateList(options["List"])
				Section.ResizeFunc()
				Dropdown:Resize()
				return Dropdown
			end
			
			return Section
		end

		function Tab:__designertheme(options)
			options = Library:validate({
				Name = "Theme",
				By = "Unknown",
				Deleteable = false,
				Background = Color3.fromRGB(49, 49, 49),
				Background_Second = Color3.fromRGB(66, 66, 66),
				Section_Background = Color3.fromRGB(59, 59, 59),
				Topbar = Color3.fromRGB(255, 0, 0)
			}, options or {})

			local Section = {
				Hover = false,
				Active = false,
				ResizeFunc = nil
			}

			-- Render
			do
				-- StarterGui.ml.Main.Content.Preview Tab.Section
				Section["15"] = Instance.new("Frame", Tab["1b"]);
				Section["15"]["BorderSizePixel"] = 0;
				Section["15"]["BackgroundColor3"] = Color3.fromRGB(60, 60, 60);
				Section["15"]["Size"] = UDim2.new(1, 0, 0.7029353380203247, 68);
				Section["15"]["Position"] = UDim2.new(0, 0, -0.07931160926818848, 0);
				Section["15"]["Name"] = options["Name"].."_theme";

				-- StarterGui.ml.Main.Content.Preview Tab.Section.UIStroke
				Section["16"] = Instance.new("UIStroke", Section["15"]);
				Section["16"]["Color"] = Color3.fromRGB(255, 255, 255);

				-- StarterGui.ml.Main.Content.Preview Tab.Section.UIListLayout
				Section["17"] = Instance.new("UIListLayout", Section["15"]);
				Section["17"]["HorizontalAlignment"] = Enum.HorizontalAlignment.Center;
				Section["17"]["Padding"] = UDim.new(0, 6);
				Section["17"]["SortOrder"] = Enum.SortOrder.LayoutOrder;

				-- StarterGui.ml.Main.Content.Preview Tab.Section.UIPadding
				Section["18"] = Instance.new("UIPadding", Section["15"]);
				Section["18"]["PaddingTop"] = UDim.new(0, 1);
				Section["18"]["PaddingRight"] = UDim.new(0, 1);
				Section["18"]["PaddingBottom"] = UDim.new(0, 1);
				Section["18"]["PaddingLeft"] = UDim.new(0, 1);

				-- StarterGui.ml.Main.Content.Preview Tab.Section.SectionTitle
				Section["19"] = Instance.new("Frame", Section["15"]);
				Section["19"]["BackgroundColor3"] = Color3.fromRGB(92, 0, 0);
				Section["19"]["BackgroundTransparency"] = 1;
				Section["19"]["LayoutOrder"] = -999999999;
				Section["19"]["Size"] = UDim2.new(1, 0, -0.08028612285852432, 26);
				Section["19"]["Name"] = [[SectionTitle]];

				-- StarterGui.ml.Main.Content.Preview Tab.Section.SectionTitle.UIPadding
				Section["1a"] = Instance.new("UIPadding", Section["19"]);
				Section["1a"]["PaddingTop"] = UDim.new(0, 6);
				Section["1a"]["PaddingRight"] = UDim.new(0, 6);
				Section["1a"]["PaddingBottom"] = UDim.new(0, 6);
				Section["1a"]["PaddingLeft"] = UDim.new(0, 6);

				-- StarterGui.ml.Main.Content.Preview Tab.Section.GUI_FAKE
				Section["1b"] = Instance.new("Frame", Section["15"]);
				Section["1b"]["BackgroundColor3"] = options["Background"];
				Section["1b"]["Size"] = UDim2.new(0, 251, 0, 150);
				Section["1b"]["ClipsDescendants"] = true;
				Section["1b"]["Position"] = UDim2.new(0, 6, 0, 9);
				Section["1b"]["Name"] = [[GUI_FAKE]];

				-- StarterGui.ml.Main.Content.Preview Tab.Section.GUI_FAKE.UICorner_GUI_FAKE
				Section["1c"] = Instance.new("UICorner", Section["1b"]);
				Section["1c"]["Name"] = [[UICorner_GUI_FAKE]];
				Section["1c"]["CornerRadius"] = UDim.new(0, 6);

				-- StarterGui.ml.Main.Content.Preview Tab.Section.GUI_FAKE.DropShadowHolder_GUI_FAKE
				Section["1d"] = Instance.new("Frame", Section["1b"]);
				Section["1d"]["ZIndex"] = 0;
				Section["1d"]["BorderSizePixel"] = 0;
				Section["1d"]["BackgroundTransparency"] = 1;
				Section["1d"]["Size"] = UDim2.new(1, 0, 1, 0);
				Section["1d"]["Name"] = [[DropShadowHolder_GUI_FAKE]];

				-- StarterGui.ml.Main.Content.Preview Tab.Section.GUI_FAKE.DropShadowHolder_GUI_FAKE.DropShadow_GUI_FAKE
				Section["1e"] = Instance.new("ImageLabel", Section["1d"]);
				Section["1e"]["ZIndex"] = 0;
				Section["1e"]["BorderSizePixel"] = 0;
				Section["1e"]["SliceCenter"] = Rect.new(49, 49, 450, 450);
				Section["1e"]["ScaleType"] = Enum.ScaleType.Slice;
				Section["1e"]["ImageColor3"] = Color3.fromRGB(0, 0, 0);
				Section["1e"]["ImageTransparency"] = 0.5;
				Section["1e"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
				Section["1e"]["Image"] = [[rbxassetid://6014261993]];
				Section["1e"]["Size"] = UDim2.new(1, 47, 1, 47);
				Section["1e"]["Name"] = [[DropShadow_GUI_FAKE]];
				Section["1e"]["BackgroundTransparency"] = 1;
				Section["1e"]["Position"] = UDim2.new(0.5, 0, 0.5, 0);

				-- StarterGui.ml.Main.Content.Preview Tab.Section.GUI_FAKE.TopBar_GUI_FAKE
				Section["1f"] = Instance.new("Frame", Section["1b"]);
				Section["1f"]["BorderSizePixel"] = 0;
				Section["1f"]["BackgroundColor3"] = options["Topbar"];
				Section["1f"]["Size"] = UDim2.new(1, 0, 0, 30);
				Section["1f"]["Name"] = [[TopBar_GUI_FAKE]];

				-- StarterGui.ml.Main.Content.Preview Tab.Section.GUI_FAKE.TopBar_GUI_FAKE.UICorner_GUI_FAKE
				Section["20"] = Instance.new("UICorner", Section["1f"]);
				Section["20"]["Name"] = [[UICorner_GUI_FAKE]];
				Section["20"]["CornerRadius"] = UDim.new(0, 6);

				-- StarterGui.ml.Main.Content.Preview Tab.Section.GUI_FAKE.TopBar_GUI_FAKE.Extension_GUI_FAKE
				Section["21"] = Instance.new("Frame", Section["1f"]);
				Section["21"]["BorderSizePixel"] = 0;
				Section["21"]["BackgroundColor3"] = options["Topbar"];
				Section["21"]["AnchorPoint"] = Vector2.new(0, 1);
				Section["21"]["Size"] = UDim2.new(1, 0, 0.5, 0);
				Section["21"]["Position"] = UDim2.new(0, 0, 1, 0);
				Section["21"]["Name"] = [[Extension_GUI_FAKE]];

				-- StarterGui.ml.Main.Content.Preview Tab.Section.GUI_FAKE.TopBar_GUI_FAKE.Title_GUI_FAKE
				Section["22"] = Instance.new("TextLabel", Section["1f"]);
				Section["22"]["TextWrapped"] = true;
				Section["22"]["TextXAlignment"] = Enum.TextXAlignment.Left;
				Section["22"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
				Section["22"]["TextSize"] = 14;
				Section["22"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
				Section["22"]["Size"] = UDim2.new(0.5, 0, 1, 0);
				Section["22"]["Text"] = [[mstudio45#5590]];
				Section["22"]["Name"] = [[Title_GUI_FAKE]];
				Section["22"]["Font"] = Enum.Font.Gotham;
				Section["22"]["BackgroundTransparency"] = 1;

				-- StarterGui.ml.Main.Content.Preview Tab.Section.GUI_FAKE.TopBar_GUI_FAKE.Title_GUI_FAKE.UIPadding
				Section["23"] = Instance.new("UIPadding", Section["22"]);
				Section["23"]["PaddingLeft"] = UDim.new(0, 8);

				-- StarterGui.ml.Main.Content.Preview Tab.Section.GUI_FAKE.TopBar_GUI_FAKE.ExitBtn_GUI_FAKE
				Section["24"] = Instance.new("ImageButton", Section["1f"]);
				Section["24"]["ZIndex"] = 2;
				Section["24"]["BorderSizePixel"] = 0;
				Section["24"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
				Section["24"]["AnchorPoint"] = Vector2.new(1, 0.5);
				Section["24"]["Image"] = [[rbxassetid://3926305904]];
				Section["24"]["ImageRectSize"] = Vector2.new(24, 24);
				Section["24"]["Size"] = UDim2.new(0, 22, 0, 22);
				Section["24"]["Name"] = [[ExitBtn_GUI_FAKE]];
				Section["24"]["ImageRectOffset"] = Vector2.new(284, 4);
				Section["24"]["Position"] = UDim2.new(1, -4, 0.5, 0);
				Section["24"]["BackgroundTransparency"] = 1;

				-- StarterGui.ml.Main.Content.Preview Tab.Section.GUI_FAKE.TopBar_GUI_FAKE.Minimize_GUI_FAKE
				Section["25"] = Instance.new("ImageButton", Section["1f"]);
				Section["25"]["ZIndex"] = 2;
				Section["25"]["BorderSizePixel"] = 0;
				Section["25"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
				Section["25"]["AnchorPoint"] = Vector2.new(1, 0.5);
				Section["25"]["Image"] = [[rbxassetid://6764432408]];
				Section["25"]["ImageRectSize"] = Vector2.new(50, 50);
				Section["25"]["Size"] = UDim2.new(0, 22, 0, 22);
				Section["25"]["Name"] = [[Minimize_GUI_FAKE]];
				Section["25"]["ImageRectOffset"] = Vector2.new(50, 550);
				Section["25"]["Position"] = UDim2.new(1, -30, 0.5, 0);
				Section["25"]["BackgroundTransparency"] = 1;

				-- StarterGui.ml.Main.Content.Preview Tab.Section.GUI_FAKE.TopBar_GUI_FAKE.Line_GUI_FAKE
				Section["26"] = Instance.new("Frame", Section["1f"]);
				Section["26"]["BorderSizePixel"] = 0;
				Section["26"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
				Section["26"]["AnchorPoint"] = Vector2.new(0, 1);
				Section["26"]["Size"] = UDim2.new(1, 0, 0, 1);
				Section["26"]["Position"] = UDim2.new(0, 0, 1, 0);
				Section["26"]["Name"] = [[Line_GUI_FAKE]];

				-- StarterGui.ml.Main.Content.Preview Tab.Section.GUI_FAKE.Content_GUI_FAKE
				Section["27"] = Instance.new("Frame", Section["1b"]);
				Section["27"]["ZIndex"] = 2;
				Section["27"]["BorderSizePixel"] = 0;
				Section["27"]["BackgroundColor3"] = Color3.fromRGB(38, 38, 38);
				Section["27"]["AnchorPoint"] = Vector2.new(1, 0);
				Section["27"]["BackgroundTransparency"] = 1;
				Section["27"]["Size"] = UDim2.new(1, -133, 1, -42);
				Section["27"]["BorderColor3"] = Color3.fromRGB(56, 56, 56);
				Section["27"]["Position"] = UDim2.new(1, -6, 0, 36);
				Section["27"]["Name"] = [[Content_GUI_FAKE]];

				-- StarterGui.ml.Main.Content.Preview Tab.Section.GUI_FAKE.Content_GUI_FAKE.UICorner_GUI_FAKE
				Section["28"] = Instance.new("UICorner", Section["27"]);
				Section["28"]["Name"] = [[UICorner_GUI_FAKE]];
				Section["28"]["CornerRadius"] = UDim.new(0, 6);

				-- StarterGui.ml.Main.Content.Preview Tab.Section.GUI_FAKE.Content_GUI_FAKE.Fade_GUI_FAKE
				Section["29"] = Instance.new("Frame", Section["27"]);
				Section["29"]["ZIndex"] = 10;
				Section["29"]["BorderSizePixel"] = 0;
				Section["29"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
				Section["29"]["Size"] = UDim2.new(1, 0, 0, 30);
				Section["29"]["Visible"] = false;
				Section["29"]["Name"] = [[Fade_GUI_FAKE]];

				-- StarterGui.ml.Main.Content.Preview Tab.Section.GUI_FAKE.Content_GUI_FAKE.Fade_GUI_FAKE.UIGradient_GUI_FAKE
				Section["2a"] = Instance.new("UIGradient", Section["29"]);
				Section["2a"]["Name"] = [[UIGradient_GUI_FAKE]];
				Section["2a"]["Rotation"] = 90;
				Section["2a"]["Color"] = ColorSequence.new{ColorSequenceKeypoint.new(0.000, Color3.fromRGB(30, 30, 30)),ColorSequenceKeypoint.new(1.000, Color3.fromRGB(30, 30, 30))};

				-- StarterGui.ml.Main.Content.Preview Tab.Section.GUI_FAKE.Content_GUI_FAKE.Preview Tab_GUI_FAKE
				Section["2b"] = Instance.new("ScrollingFrame", Section["27"]);
				Section["2b"]["BorderSizePixel"] = 0;
				Section["2b"]["CanvasSize"] = UDim2.new(0, 0, 0, 89);
				Section["2b"]["BackgroundColor3"] = options["Background"];
				Section["2b"]["BackgroundTransparency"] = 1;
				Section["2b"]["Size"] = UDim2.new(1, 0, 1, 0);
				Section["2b"]["Selectable"] = false;
				Section["2b"]["ScrollBarThickness"] = 0;
				Section["2b"]["Name"] = [[Preview Tab_GUI_FAKE]];
				Section["2b"]["SelectionGroup"] = false;

				-- StarterGui.ml.Main.Content.Preview Tab.Section.GUI_FAKE.Content_GUI_FAKE.Preview Tab_GUI_FAKE.UIPadding_GUI_FAKE
				Section["2c"] = Instance.new("UIPadding", Section["2b"]);
				Section["2c"]["PaddingTop"] = UDim.new(0, 1);
				Section["2c"]["Name"] = [[UIPadding_GUI_FAKE]];
				Section["2c"]["PaddingRight"] = UDim.new(0, 1);
				Section["2c"]["PaddingBottom"] = UDim.new(0, 1);
				Section["2c"]["PaddingLeft"] = UDim.new(0, 1);

				-- StarterGui.ml.Main.Content.Preview Tab.Section.GUI_FAKE.Content_GUI_FAKE.Preview Tab_GUI_FAKE.UIListLayout_GUI_FAKE
				Section["2d"] = Instance.new("UIListLayout", Section["2b"]);
				Section["2d"]["Name"] = [[UIListLayout_GUI_FAKE]];
				Section["2d"]["Padding"] = UDim.new(0, 6);
				Section["2d"]["SortOrder"] = Enum.SortOrder.LayoutOrder;

				-- StarterGui.ml.Main.Content.Preview Tab.Section.GUI_FAKE.Content_GUI_FAKE.Preview Tab_GUI_FAKE.Section_GUI_FAKE
				Section["2e"] = Instance.new("Frame", Section["2b"]);
				Section["2e"]["BorderSizePixel"] = 0;
				Section["2e"]["BackgroundColor3"] = options["Section_Background"];
				Section["2e"]["Size"] = UDim2.new(1, 0, 0, 68);
				Section["2e"]["Name"] = [[Section_GUI_FAKE]];

				-- StarterGui.ml.Main.Content.Preview Tab.Section.GUI_FAKE.Content_GUI_FAKE.Preview Tab_GUI_FAKE.Section_GUI_FAKE.UIStroke_GUI_FAKE
				Section["2f"] = Instance.new("UIStroke", Section["2e"]);
				Section["2f"]["Color"] = Color3.fromRGB(255, 255, 255);
				Section["2f"]["Name"] = [[UIStroke_GUI_FAKE]];

				-- StarterGui.ml.Main.Content.Preview Tab.Section.GUI_FAKE.Content_GUI_FAKE.Preview Tab_GUI_FAKE.Section_GUI_FAKE.UIListLayout_GUI_FAKE
				Section["30"] = Instance.new("UIListLayout", Section["2e"]);
				Section["30"]["Name"] = [[UIListLayout_GUI_FAKE]];
				Section["30"]["HorizontalAlignment"] = Enum.HorizontalAlignment.Center;
				Section["30"]["Padding"] = UDim.new(0, 6);
				Section["30"]["SortOrder"] = Enum.SortOrder.LayoutOrder;

				-- StarterGui.ml.Main.Content.Preview Tab.Section.GUI_FAKE.Content_GUI_FAKE.Preview Tab_GUI_FAKE.Section_GUI_FAKE.UIPadding_GUI_FAKE
				Section["31"] = Instance.new("UIPadding", Section["2e"]);
				Section["31"]["PaddingTop"] = UDim.new(0, 1);
				Section["31"]["Name"] = [[UIPadding_GUI_FAKE]];
				Section["31"]["PaddingRight"] = UDim.new(0, 1);
				Section["31"]["PaddingBottom"] = UDim.new(0, 1);
				Section["31"]["PaddingLeft"] = UDim.new(0, 1);

				-- StarterGui.ml.Main.Content.Preview Tab.Section.GUI_FAKE.Content_GUI_FAKE.Preview Tab_GUI_FAKE.Section_GUI_FAKE.SectionTitle_GUI_FAKE
				Section["32"] = Instance.new("Frame", Section["2e"]);
				Section["32"]["BackgroundColor3"] = Color3.fromRGB(92, 0, 0);
				Section["32"]["BackgroundTransparency"] = 1;
				Section["32"]["LayoutOrder"] = -999999999;
				Section["32"]["Size"] = UDim2.new(1, 0, 0, 26);
				Section["32"]["Name"] = [[SectionTitle_GUI_FAKE]];

				-- StarterGui.ml.Main.Content.Preview Tab.Section.GUI_FAKE.Content_GUI_FAKE.Preview Tab_GUI_FAKE.Section_GUI_FAKE.SectionTitle_GUI_FAKE.Title_GUI_FAKE
				Section["33"] = Instance.new("TextLabel", Section["32"]);
				Section["33"]["TextWrapped"] = true;
				Section["33"]["RichText"] = true;
				Section["33"]["TextXAlignment"] = Enum.TextXAlignment.Left;
				Section["33"]["TextYAlignment"] = Enum.TextYAlignment.Top;
				Section["33"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
				Section["33"]["TextSize"] = 14;
				Section["33"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
				Section["33"]["Size"] = UDim2.new(0.9930291771888733, 0, 1, 0);
				Section["33"]["Text"] = [[Preview Section]];
				Section["33"]["Name"] = [[Title_GUI_FAKE]];
				Section["33"]["Font"] = Enum.Font.GothamBold;
				Section["33"]["BackgroundTransparency"] = 1;
				Section["33"]["Position"] = UDim2.new(0.003952569328248501, 0, 0, 0);

				-- StarterGui.ml.Main.Content.Preview Tab.Section.GUI_FAKE.Content_GUI_FAKE.Preview Tab_GUI_FAKE.Section_GUI_FAKE.SectionTitle_GUI_FAKE.UIPadding_GUI_FAKE
				Section["34"] = Instance.new("UIPadding", Section["32"]);
				Section["34"]["PaddingTop"] = UDim.new(0, 6);
				Section["34"]["Name"] = [[UIPadding_GUI_FAKE]];
				Section["34"]["PaddingRight"] = UDim.new(0, 6);
				Section["34"]["PaddingBottom"] = UDim.new(0, 6);
				Section["34"]["PaddingLeft"] = UDim.new(0, 6);

				-- StarterGui.ml.Main.Content.Preview Tab.Section.GUI_FAKE.Content_GUI_FAKE.Preview Tab_GUI_FAKE.Section_GUI_FAKE.Label_GUI_FAKE
				Section["35"] = Instance.new("Frame", Section["2e"]);
				Section["35"]["BackgroundColor3"] = Color3.fromRGB(91, 0, 0);
				Section["35"]["BackgroundTransparency"] = 1;
				Section["35"]["Size"] = UDim2.new(0.949999988079071, 0, 0, 26);
				Section["35"]["Name"] = [[Label_GUI_FAKE]];

				-- StarterGui.ml.Main.Content.Preview Tab.Section.GUI_FAKE.Content_GUI_FAKE.Preview Tab_GUI_FAKE.Section_GUI_FAKE.Label_GUI_FAKE.Title_GUI_FAKE
				Section["36"] = Instance.new("TextLabel", Section["35"]);
				Section["36"]["TextWrapped"] = true;
				Section["36"]["TextYAlignment"] = Enum.TextYAlignment.Top;
				Section["36"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
				Section["36"]["TextSize"] = 14;
				Section["36"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
				Section["36"]["AutomaticSize"] = Enum.AutomaticSize.Y;
				Section["36"]["Size"] = UDim2.new(1, 0, 1, 0);
				Section["36"]["Name"] = [[Title_GUI_FAKE]];
				Section["36"]["Font"] = Enum.Font.GothamBold;
				Section["36"]["BackgroundTransparency"] = 1;

				-- StarterGui.ml.Main.Content.Preview Tab.Section.GUI_FAKE.Content_GUI_FAKE.Preview Tab_GUI_FAKE.Section_GUI_FAKE.Label_GUI_FAKE.UIPadding_GUI_FAKE
				Section["37"] = Instance.new("UIPadding", Section["35"]);
				Section["37"]["PaddingTop"] = UDim.new(0, 6);
				Section["37"]["Name"] = [[UIPadding_GUI_FAKE]];
				Section["37"]["PaddingRight"] = UDim.new(0, 6);
				Section["37"]["PaddingBottom"] = UDim.new(0, 6);
				Section["37"]["PaddingLeft"] = UDim.new(0, 6);

				-- StarterGui.ml.Main.Content.Preview Tab.Section.GUI_FAKE.Content_GUI_FAKE.Preview Tab_GUI_FAKE.InvisMiddleSection_GUI_FAKE
				Section["38"] = Instance.new("Frame", Section["2b"]);
				Section["38"]["BorderSizePixel"] = 0;
				Section["38"]["BackgroundTransparency"] = 1;
				Section["38"]["Size"] = UDim2.new(1, 0, 0, 5);
				Section["38"]["Name"] = [[InvisMiddleSection_GUI_FAKE]];

				-- StarterGui.ml.Main.Content.Preview Tab.Section.GUI_FAKE.Navigation_GUI_FAKE
				Section["39"] = Instance.new("Frame", Section["1b"]);
				Section["39"]["BorderSizePixel"] = 0;
				Section["39"]["BackgroundColor3"] = options["Background_Second"];
				Section["39"]["Size"] = UDim2.new(0, 120, 1, -30);
				Section["39"]["Position"] = UDim2.new(0, 0, 0, 30);
				Section["39"]["Name"] = [[Navigation_GUI_FAKE]];

				-- StarterGui.ml.Main.Content.Preview Tab.Section.GUI_FAKE.Navigation_GUI_FAKE.UICorner_GUI_FAKE
				Section["3a"] = Instance.new("UICorner", Section["39"]);
				Section["3a"]["Name"] = [[UICorner_GUI_FAKE]];
				Section["3a"]["CornerRadius"] = UDim.new(0, 6);

				-- StarterGui.ml.Main.Content.Preview Tab.Section.GUI_FAKE.Navigation_GUI_FAKE.Hide_GUI_FAKE
				Section["3b"] = Instance.new("Frame", Section["39"]);
				Section["3b"]["BorderSizePixel"] = 0;
				Section["3b"]["BackgroundColor3"] = options["Background_Second"];
				Section["3b"]["Size"] = UDim2.new(1, 0, 0, 20);
				Section["3b"]["Name"] = [[Hide_GUI_FAKE]];

				-- StarterGui.ml.Main.Content.Preview Tab.Section.GUI_FAKE.Navigation_GUI_FAKE.Hide2_GUI_FAKE
				Section["3c"] = Instance.new("Frame", Section["39"]);
				Section["3c"]["BorderSizePixel"] = 0;
				Section["3c"]["BackgroundColor3"] = options["Background_Second"];
				Section["3c"]["AnchorPoint"] = Vector2.new(1, 0);
				Section["3c"]["Size"] = UDim2.new(0, 20, 1, 0);
				Section["3c"]["Position"] = UDim2.new(1, 0, 0, 0);
				Section["3c"]["Name"] = [[Hide2_GUI_FAKE]];

				-- StarterGui.ml.Main.Content.Preview Tab.Section.GUI_FAKE.Navigation_GUI_FAKE.ButtonHolder_GUI_FAKE
				Section["3d"] = Instance.new("Frame", Section["39"]);
				Section["3d"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
				Section["3d"]["BackgroundTransparency"] = 1;
				Section["3d"]["Size"] = UDim2.new(1, 0, 1, 0);
				Section["3d"]["Name"] = [[ButtonHolder_GUI_FAKE]];

				-- StarterGui.ml.Main.Content.Preview Tab.Section.GUI_FAKE.Navigation_GUI_FAKE.ButtonHolder_GUI_FAKE.UIPadding_GUI_FAKE
				Section["3e"] = Instance.new("UIPadding", Section["3d"]);
				Section["3e"]["PaddingTop"] = UDim.new(0, 8);
				Section["3e"]["Name"] = [[UIPadding_GUI_FAKE]];
				Section["3e"]["PaddingBottom"] = UDim.new(0, 8);

				-- StarterGui.ml.Main.Content.Preview Tab.Section.GUI_FAKE.Navigation_GUI_FAKE.ButtonHolder_GUI_FAKE.UIListLayout_GUI_FAKE
				Section["3f"] = Instance.new("UIListLayout", Section["3d"]);
				Section["3f"]["Name"] = [[UIListLayout_GUI_FAKE]];
				Section["3f"]["Padding"] = UDim.new(0, 1);
				Section["3f"]["SortOrder"] = Enum.SortOrder.LayoutOrder;

				-- StarterGui.ml.Main.Content.Preview Tab.Section.GUI_FAKE.Navigation_GUI_FAKE.ButtonHolder_GUI_FAKE.Icon_GUI_FAKE
				Section["40"] = Instance.new("TextButton", Section["3d"]);
				Section["40"]["ZIndex"] = 0;
				Section["40"]["TextSize"] = 14;
				Section["40"]["TextXAlignment"] = Enum.TextXAlignment.Left;
				Section["40"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
				Section["40"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
				Section["40"]["Size"] = UDim2.new(1, 0, 0, 24);
				Section["40"]["Name"] = [[Icon_GUI_FAKE]];
				Section["40"]["Text"] = [[Preview Tab]];
				Section["40"]["Font"] = Enum.Font.Gotham;
				Section["40"]["BackgroundTransparency"] = 0.800000011920929;

				-- StarterGui.ml.Main.Content.Preview Tab.Section.GUI_FAKE.Navigation_GUI_FAKE.ButtonHolder_GUI_FAKE.Icon_GUI_FAKE.UIPadding_GUI_FAKE
				Section["41"] = Instance.new("UIPadding", Section["40"]);
				Section["41"]["Name"] = [[UIPadding_GUI_FAKE]];
				Section["41"]["PaddingLeft"] = UDim.new(0, 28);

				-- StarterGui.ml.Main.Content.Preview Tab.Section.GUI_FAKE.Navigation_GUI_FAKE.ButtonHolder_GUI_FAKE.Icon_GUI_FAKE.ImageLabel_GUI_FAKE
				Section["42"] = Instance.new("ImageLabel", Section["40"]);
				Section["42"]["BorderSizePixel"] = 0;
				Section["42"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
				Section["42"]["AnchorPoint"] = Vector2.new(0, 0.5);
				Section["42"]["Image"] = [[rbxassetid://10888331510]];
				Section["42"]["Size"] = UDim2.new(0, 20, 0, 20);
				Section["42"]["Name"] = [[ImageLabel_GUI_FAKE]];
				Section["42"]["BackgroundTransparency"] = 1;
				Section["42"]["Position"] = UDim2.new(0, -24, 0.5, 0);

				-- StarterGui.ml.Main.Content.Preview Tab.Section.GUI_FAKE.Navigation_GUI_FAKE.Line_GUI_FAKE
				Section["43"] = Instance.new("Frame", Section["39"]);
				Section["43"]["BorderSizePixel"] = 0;
				Section["43"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
				Section["43"]["Size"] = UDim2.new(0, 1, 1, 0);
				Section["43"]["Position"] = UDim2.new(1, 0, 0, 0);
				Section["43"]["Name"] = [[Line_GUI_FAKE]];

				-- StarterGui.ml.Main.Content.Preview Tab.Section..,U
				Section["44"] = Instance.new("Frame", Section["15"]);
				Section["44"]["BorderSizePixel"] = 0;
				Section["44"]["BackgroundColor3"] = Color3.fromRGB(66, 66, 66);
				Section["44"]["LayoutOrder"] = 1;
				Section["44"]["Size"] = UDim2.new(1, 0, 0.20301251113414764, 30);
				Section["44"]["Position"] = UDim2.new(0, 0, 0.6797480583190918, 0);
				Section["44"]["Name"] = [[PickTheme]];
				createObject("Color3Value", Section["44"], "Background_Second_Color")

				-- StarterGui.ml.Main.Content.Preview Tab.Section.PickTheme.UIPadding
				Section["45"] = Instance.new("UIPadding", Section["44"]);
				Section["45"]["PaddingTop"] = UDim.new(0, 6);
				Section["45"]["PaddingRight"] = UDim.new(0, 6);
				Section["45"]["PaddingBottom"] = UDim.new(0, 6);
				Section["45"]["PaddingLeft"] = UDim.new(0, 6);

				-- StarterGui.ml.Main.Content.Preview Tab.Section.PickTheme.ThemeName
				Section["46"] = Instance.new("TextLabel", Section["44"]);
				Section["46"]["TextWrapped"] = true;
				Section["46"]["RichText"] = true;
				Section["46"]["TextXAlignment"] = Enum.TextXAlignment.Left;
				Section["46"]["TextYAlignment"] = Enum.TextYAlignment.Top;
				Section["46"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
				Section["46"]["TextSize"] = 14;
				Section["46"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
				Section["46"]["Size"] = UDim2.new(0.9930291771888733, 0, 1, 0);
				Section["46"]["Text"] = options["Name"];
				Section["46"]["Name"] = [[ThemeName]];
				Section["46"]["Font"] = Enum.Font.GothamBold;
				Section["46"]["BackgroundTransparency"] = 1;
				Section["46"]["Position"] = UDim2.new(0.003952569328248501, 0, 0, 0);

				-- StarterGui.ml.Main.Content.Preview Tab.Section.PickTheme.ThemeBy
				Section["47"] = Instance.new("TextLabel", Section["44"]);
				Section["47"]["TextWrapped"] = true;
				Section["47"]["RichText"] = true;
				Section["47"]["TextXAlignment"] = Enum.TextXAlignment.Left;
				Section["47"]["TextYAlignment"] = Enum.TextYAlignment.Top;
				Section["47"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
				Section["47"]["TextSize"] = 14;
				Section["47"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
				Section["47"]["Size"] = UDim2.new(0.9930292367935181, 0, 0.7046798467636108, 0);
				Section["47"]["Text"] = "By: "..options["By"];
				Section["47"]["Name"] = [[ThemeBy]];
				Section["47"]["Font"] = Enum.Font.Gotham;
				Section["47"]["BackgroundTransparency"] = 1;
				Section["47"]["Position"] = UDim2.new(-0.00003161188215017319, 0, 0.28692305088043213, 0);

				if options.Deleteable == false then
					-- StarterGui.ml.Main.Content.Preview Tab.Section.PickTheme.UseTheme
					Section["48"] = Instance.new("TextButton", Section["44"]);
					Section["48"]["ZIndex"] = 0;
					Section["48"]["TextSize"] = 14;
					Section["48"]["TextXAlignment"] = Enum.TextXAlignment.Left;
					Section["48"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
					Section["48"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
					Section["48"]["Size"] = UDim2.new(1, 0, 0.44030657410621643, 0);
					Section["48"]["Name"] = [[UseTheme]];
					Section["48"]["Text"] = [[Use Theme]];
					Section["48"]["Font"] = Enum.Font.Gotham;
					Section["48"]["Position"] = UDim2.new(0, 0, 0.5596931576728821, 0);
					Section["48"]["BackgroundTransparency"] = 0.800000011920929;

					-- StarterGui.ml.Main.Content.Preview Tab.Section.PickTheme.UseTheme.UIPadding
					Section["49"] = Instance.new("UIPadding", Section["48"]);
					Section["49"]["PaddingLeft"] = UDim.new(0, 28);

					-- StarterGui.ml.Main.Content.Preview Tab.Section.PickTheme.UseTheme.ImageLabel
					Section["4a"] = Instance.new("ImageLabel", Section["48"]);
					Section["4a"]["BorderSizePixel"] = 0;
					Section["4a"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
					Section["4a"]["AnchorPoint"] = Vector2.new(0, 0.5);
					Section["4a"]["Image"] = [[rbxassetid://3926305904]];
					Section["4a"]["ImageRectSize"] = Vector2.new(36, 36);
					Section["4a"]["Size"] = UDim2.new(0, 20, 0, 20);
					Section["4a"]["ImageRectOffset"] = Vector2.new(924, 364);
					Section["4a"]["BackgroundTransparency"] = 1;
					Section["4a"]["Position"] = UDim2.new(0, -24, 0.5, 0);

					-- StarterGui.ml.Main.Content.Preview Tab.Section.PickTheme.UseTheme.UICorner
					Section["4b"] = Instance.new("UICorner", Section["48"]);
				else
					-- StarterGui.ml.Main.Content.Preview Tab.Section.PickTheme.UseTheme
					Section["48"] = Instance.new("TextButton", Section["44"]);
					Section["48"]["ZIndex"] = 0;
					Section["48"]["TextSize"] = 14;
					Section["48"]["TextXAlignment"] = Enum.TextXAlignment.Left;
					Section["48"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
					Section["48"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
					Section["48"]["Size"] = UDim2.new(0.46394428610801697, 0, 0.44030383229255676, 0);
					Section["48"]["Name"] = [[UseTheme]];
					Section["48"]["Text"] = [[Use Theme]];
					Section["48"]["Font"] = Enum.Font.Gotham;
					Section["48"]["Position"] = UDim2.new(0.5099601149559021, 0, 0.5596932768821716, 0);
					Section["48"]["BackgroundTransparency"] = 0.800000011920929;

					-- StarterGui.ml.Main.Content.Preview Tab.Section.PickTheme.UseTheme.UIPadding
					Section["49"] = Instance.new("UIPadding", Section["48"]);
					Section["49"]["PaddingLeft"] = UDim.new(0, 28);

					-- StarterGui.ml.Main.Content.Preview Tab.Section.PickTheme.UseTheme.ImageLabel
					Section["4a"] = Instance.new("ImageLabel", Section["48"]);
					Section["4a"]["BorderSizePixel"] = 0;
					Section["4a"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
					Section["4a"]["AnchorPoint"] = Vector2.new(0, 0.5);
					Section["4a"]["Image"] = [[rbxassetid://3926305904]];
					Section["4a"]["ImageRectSize"] = Vector2.new(36, 36);
					Section["4a"]["Size"] = UDim2.new(0, 20, 0, 20);
					Section["4a"]["ImageRectOffset"] = Vector2.new(924, 364);
					Section["4a"]["BackgroundTransparency"] = 1;
					Section["4a"]["Position"] = UDim2.new(0, -24, 0.5, 0);

					-- StarterGui.ml.Main.Content.Preview Tab.Section.PickTheme.UseTheme.UICorner
					Section["4b"] = Instance.new("UICorner", Section["48"]);


					-- StarterGui.ml.Main.Content.Preview Tab.Section.PickTheme.DeleteTheme
					Section["52-delete"] = Instance.new("TextButton", Section["44"]);
					Section["52-delete"]["ZIndex"] = 0;
					Section["52-delete"]["TextSize"] = 13;
					Section["52-delete"]["TextXAlignment"] = Enum.TextXAlignment.Left;
					Section["52-delete"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
					Section["52-delete"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
					Section["52-delete"]["Size"] = UDim2.new(0.45418328046798706, 0, 0.44030383229255676, 0);
					Section["52-delete"]["Name"] = [[DeleteTheme]];
					Section["52-delete"]["Text"] = [[Delete Theme]];
					Section["52-delete"]["Font"] = Enum.Font.Gotham;
					Section["52-delete"]["Position"] = UDim2.new(0.02390446700155735, 0, 0.5596932768821716, 0);
					Section["52-delete"]["BackgroundTransparency"] = 0.800000011920929;

					-- StarterGui.ml.Main.Content.Preview Tab.Section.PickTheme.DeleteTheme.UIPadding
					Section["53-delete"] = Instance.new("UIPadding", Section["52-delete"]);
					Section["53-delete"]["PaddingLeft"] = UDim.new(0, 28);

					-- StarterGui.ml.Main.Content.Preview Tab.Section.PickTheme.DeleteTheme.ImageLabel
					Section["54-delete"] = Instance.new("ImageLabel", Section["52-delete"]);
					Section["54-delete"]["BorderSizePixel"] = 0;
					Section["54-delete"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
					Section["54-delete"]["AnchorPoint"] = Vector2.new(0, 0.5);
					Section["54-delete"]["Image"] = [[rbxassetid://12403099678]];
					Section["54-delete"]["Size"] = UDim2.new(0, 20, 0, 20);
					Section["54-delete"]["BackgroundTransparency"] = 1;
					Section["54-delete"]["Position"] = UDim2.new(0, -24, 0.5, 0);

					-- StarterGui.ml.Main.Content.Preview Tab.Section.PickTheme.DeleteTheme.UICorner
					Section["55-delete"] = Instance.new("UICorner", Section["52-delete"]);
				end

				-- StarterGui.ml.Main.Content.Preview Tab.Section.PickTheme.UIStroke
				Section["4c"] = Instance.new("UIStroke", Section["44"]);
				Section["4c"]["Color"] = Color3.fromRGB(255, 255, 255);

				-- StarterGui.ml.Main.Content.Preview Tab.Section.PickTheme.ThemeData
				Section["4d"] = Instance.new("Folder", Section["44"]);
				Section["4d"]["Name"] = [[ThemeData]];

				-- StarterGui.ml.Main.Content.Preview Tab.Section.PickTheme.ThemeData.Topbar
				Section["4e"] = Instance.new("Color3Value", Section["4d"]);
				Section["4e"]["Name"] = [[Topbar]];

				-- StarterGui.ml.Main.Content.Preview Tab.Section.PickTheme.ThemeData.Section_Background
				Section["4f"] = Instance.new("Color3Value", Section["4d"]);
				Section["4f"]["Name"] = [[Section_Background]];

				-- StarterGui.ml.Main.Content.Preview Tab.Section.PickTheme.ThemeData.Background_Second
				Section["50"] = Instance.new("Color3Value", Section["4d"]);
				Section["50"]["Name"] = [[Background_Second]];

				-- StarterGui.ml.Main.Content.Preview Tab.Section.PickTheme.ThemeData.Background
				Section["51"] = Instance.new("Color3Value", Section["4d"]);
				Section["51"]["Name"] = [[Background]];

				-- StarterGui.ml.Main.Content.Preview Tab.InvisMiddleSection
				Section["52"] = Instance.new("Frame", Section["12"]);
				Section["52"]["BorderSizePixel"] = 0;
				Section["52"]["BackgroundTransparency"] = 1;
				Section["52"]["Size"] = UDim2.new(1, 0, 0, 5);
				Section["52"]["Name"] = [[InvisMiddleSection]];

				Section["14ee"] = Instance.new("Frame", Tab["1b"]);
				Section["14ee"]["BorderSizePixel"] = 0;
				Section["14ee"]["BackgroundTransparency"] = 1;
				Section["14ee"]["Size"] = UDim2.new(1, 0, 0, 5);
				Section["14ee"]["Selectable"] = false;
				Section["14ee"]["Name"] = options["Name"].."_theme_invis";
				Section["14ee"]["SelectionGroup"] = false;
			end

			-- Logic
			do
				Section["48"].MouseButton1Click:Connect(function()
					Library.setTheme({
						Background = options["Background"],
						Background_Second = options["Background_Second"],
						Section_Background = options["Section_Background"],
						Topbar = options["Topbar"],
					}, true)
					oldnormalmessage("THEMES", "Theme called '"..options["Name"].."' have been set.", 5)
				end)

				if options.Deleteable then
					Section["52-delete"].MouseButton1Click:Connect(function()
						Section.__delete()
						Library.__themes_deleteTheme(options["Name"])
					end)
				end
			end

			Section.ResizeFunc = function()
				task.spawn(function()
					if options.Deleteable == true then
						local k = Section["17"].AbsoluteContentSize.Y + 10 - 30 - 28
						if k > 250 then
							repeat
								k -= 1
							until k < 251
						end
						Section["15"].Size = UDim2.new(1, 0, 0, k) 
					else
						local k = Section["17"].AbsoluteContentSize.Y + 10 - 30
						if k > 250 then
							repeat
								k -= 1
							until k < 251
						end
						Section["15"].Size = UDim2.new(1, 0, 0, k) 
					end
					task.wait()
					ResizeScrollingFrame(Tab["1b"] , Tab["22"], 26)
				end)
			end

			Section.__delete = function()
				Section.ResizeFunc()
				pcall(function()
					Section["15"]:Destroy()
				end)
				pcall(function()
					Section["93"]:Destroy()
				end)
				for _,v in pairs(Tab["1b"]:GetChildren()) do
					if v.Name == options["Name"].."_theme" then
						v.Parent = nil
					end
					if v.Name == options["Name"].."_theme_invis" then
						v.Parent = nil
					end
				end
			end

			Section.ResizeFunc()
		end

		function Tab:__customdesignertheme(options)
			options = Library:validate({
				Name = "Theme",
				By = "Unknown",
				Background = Color3.fromRGB(49, 49, 49),
				Background_Second = Color3.fromRGB(66, 66, 66),
				Section_Background = Color3.fromRGB(59, 59, 59),
				Topbar = Color3.fromRGB(255, 0, 0)
			}, options or {})

			local Section = {
				Hover = false,
				Active = false,
				ResizeFunc = nil
			}

			-- Render
			do
				-- StarterGui.Yl{;R"}J)7{y5Rte*m7J.Main.Content.__themedesigner.ThemeDesignerSection
				Section["15"] = Instance.new("Frame", Tab["1b"]);
				Section["15"]["BorderSizePixel"] = 0;
				Section["15"]["BackgroundColor3"] = Color3.fromRGB(61, 61, 61);
				Section["15"]["Size"] = UDim2.new(1, 0, 0.6454859972000122, 250);
				Section["15"]["Position"] = UDim2.new(0, 0, -2.5078125, 0);
				Section["15"]["Name"] = [[ThemeDesignerSection]]

				-- StarterGui.Yl{;R"}J)7{y5Rte*m7J.Main.Content.__themedesigner.ThemeDesignerSection.UIStroke
				Section["16"] = Instance.new("UIStroke", Section["15"]);
				Section["16"]["Color"] = Color3.fromRGB(255, 255, 255);

				-- StarterGui.Yl{;R"}J)7{y5Rte*m7J.Main.Content.__themedesigner.ThemeDesignerSection.UIListLayout
				Section["17"] = Instance.new("UIListLayout", Section["15"]);
				Section["17"]["HorizontalAlignment"] = Enum.HorizontalAlignment.Center;
				Section["17"]["Padding"] = UDim.new(0, 6);
				Section["17"]["SortOrder"] = Enum.SortOrder.LayoutOrder;

				-- StarterGui.Yl{;R"}J)7{y5Rte*m7J.Main.Content.__themedesigner.ThemeDesignerSection.UIPadding
				Section["18"] = Instance.new("UIPadding", Section["15"]);
				Section["18"]["PaddingTop"] = UDim.new(0, 1);
				Section["18"]["PaddingRight"] = UDim.new(0, 1);
				Section["18"]["PaddingBottom"] = UDim.new(0, 1);
				Section["18"]["PaddingLeft"] = UDim.new(0, 1);

				-- StarterGui.Yl{;R"}J)7{y5Rte*m7J.Main.Content.__themedesigner.ThemeDesignerSection.SectionTitle
				Section["19"] = Instance.new("Frame", Section["15"]);
				Section["19"]["BackgroundColor3"] = Color3.fromRGB(93, 0, 0);
				Section["19"]["BackgroundTransparency"] = 1;
				Section["19"]["Size"] = UDim2.new(1, 0, -0.02187516540288925, 26);
				Section["19"]["Position"] = UDim2.new(0, 0, -0.05841095745563507, 0);
				Section["19"]["Name"] = [[SectionTitle]];

				-- StarterGui.Yl{;R"}J)7{y5Rte*m7J.Main.Content.__themedesigner.ThemeDesignerSection.GUI_FAKE
				Section["1a"] = Instance.new("Frame", Section["15"]);
				Section["1a"]["BackgroundColor3"] = options["Background"];
				Section["1a"]["Size"] = UDim2.new(0, 251, 0, 150);
				Section["1a"]["ClipsDescendants"] = true;
				Section["1a"]["Position"] = UDim2.new(0, 6, 0, 9);
				Section["1a"]["Name"] = [[GUI_FAKE]];

				-- StarterGui.Yl{;R"}J)7{y5Rte*m7J.Main.Content.__themedesigner.ThemeDesignerSection.GUI_FAKE.UICorner_GUI_FAKE
				Section["1b"] = Instance.new("UICorner", Section["1a"]);
				Section["1b"]["Name"] = [[UICorner_GUI_FAKE]];
				Section["1b"]["CornerRadius"] = UDim.new(0, 6);

				-- StarterGui.Yl{;R"}J)7{y5Rte*m7J.Main.Content.__themedesigner.ThemeDesignerSection.GUI_FAKE.DropShadowHolder_GUI_FAKE
				Section["1c"] = Instance.new("Frame", Section["1a"]);
				Section["1c"]["ZIndex"] = 0;
				Section["1c"]["BorderSizePixel"] = 0;
				Section["1c"]["BackgroundTransparency"] = 1;
				Section["1c"]["Size"] = UDim2.new(1, 0, 1, 0);
				Section["1c"]["Name"] = [[DropShadowHolder_GUI_FAKE]];

				-- StarterGui.Yl{;R"}J)7{y5Rte*m7J.Main.Content.__themedesigner.ThemeDesignerSection.GUI_FAKE.DropShadowHolder_GUI_FAKE.DropShadow_GUI_FAKE
				Section["1d"] = Instance.new("ImageLabel", Section["1c"]);
				Section["1d"]["ZIndex"] = 0;
				Section["1d"]["BorderSizePixel"] = 0;
				Section["1d"]["SliceCenter"] = Rect.new(49, 49, 450, 450);
				Section["1d"]["ScaleType"] = Enum.ScaleType.Slice;
				Section["1d"]["ImageColor3"] = Color3.fromRGB(0, 0, 0);
				Section["1d"]["ImageTransparency"] = 0.5;
				Section["1d"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
				Section["1d"]["Image"] = [[rbxassetid://6014261993]];
				Section["1d"]["Size"] = UDim2.new(1, 47, 1, 47);
				Section["1d"]["Name"] = [[DropShadow_GUI_FAKE]];
				Section["1d"]["BackgroundTransparency"] = 1;
				Section["1d"]["Position"] = UDim2.new(0.5, 0, 0.5, 0);

				-- StarterGui.Yl{;R"}J)7{y5Rte*m7J.Main.Content.__themedesigner.ThemeDesignerSection.GUI_FAKE.TopBar_GUI_FAKE
				Section["1e"] = Instance.new("Frame", Section["1a"]);
				Section["1e"]["BorderSizePixel"] = 0;
				Section["1e"]["BackgroundColor3"] = options["Topbar"];
				Section["1e"]["Size"] = UDim2.new(1, 0, 0, 30);
				Section["1e"]["Name"] = [[TopBar_GUI_FAKE]];

				-- StarterGui.Yl{;R"}J)7{y5Rte*m7J.Main.Content.__themedesigner.ThemeDesignerSection.GUI_FAKE.TopBar_GUI_FAKE.UICorner_GUI_FAKE
				Section["1f"] = Instance.new("UICorner", Section["1e"]);
				Section["1f"]["Name"] = [[UICorner_GUI_FAKE]];
				Section["1f"]["CornerRadius"] = UDim.new(0, 6);

				-- StarterGui.Yl{;R"}J)7{y5Rte*m7J.Main.Content.__themedesigner.ThemeDesignerSection.GUI_FAKE.TopBar_GUI_FAKE.Extension_GUI_FAKE
				Section["20"] = Instance.new("Frame", Section["1e"]);
				Section["20"]["BorderSizePixel"] = 0;
				Section["20"]["BackgroundColor3"] = options["Topbar"];
				Section["20"]["AnchorPoint"] = Vector2.new(0, 1);
				Section["20"]["Size"] = UDim2.new(1, 0, 0.5, 0);
				Section["20"]["Position"] = UDim2.new(0, 0, 1, 0);
				Section["20"]["Name"] = [[Extension_GUI_FAKE]];

				-- StarterGui.Yl{;R"}J)7{y5Rte*m7J.Main.Content.__themedesigner.ThemeDesignerSection.GUI_FAKE.TopBar_GUI_FAKE.Title_GUI_FAKE
				Section["21"] = Instance.new("TextLabel", Section["1e"]);
				Section["21"]["TextWrapped"] = true;
				Section["21"]["TextXAlignment"] = Enum.TextXAlignment.Left;
				Section["21"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
				Section["21"]["TextSize"] = 14;
				Section["21"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
				Section["21"]["Size"] = UDim2.new(0.5, 0, 1, 0);
				Section["21"]["Text"] = [[mstudio45#5590]];
				Section["21"]["Name"] = [[Title_GUI_FAKE]];
				Section["21"]["Font"] = Enum.Font.Gotham;
				Section["21"]["BackgroundTransparency"] = 1;

				-- StarterGui.Yl{;R"}J)7{y5Rte*m7J.Main.Content.__themedesigner.ThemeDesignerSection.GUI_FAKE.TopBar_GUI_FAKE.Title_GUI_FAKE.UIPadding
				Section["22"] = Instance.new("UIPadding", Section["21"]);
				Section["22"]["PaddingLeft"] = UDim.new(0, 8);

				-- StarterGui.Yl{;R"}J)7{y5Rte*m7J.Main.Content.__themedesigner.ThemeDesignerSection.GUI_FAKE.TopBar_GUI_FAKE.ExitBtn_GUI_FAKE
				Section["23"] = Instance.new("ImageButton", Section["1e"]);
				Section["23"]["ZIndex"] = 2;
				Section["23"]["BorderSizePixel"] = 0;
				Section["23"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
				Section["23"]["AnchorPoint"] = Vector2.new(1, 0.5);
				Section["23"]["Image"] = [[rbxassetid://3926305904]];
				Section["23"]["ImageRectSize"] = Vector2.new(24, 24);
				Section["23"]["Size"] = UDim2.new(0, 22, 0, 22);
				Section["23"]["Name"] = [[ExitBtn_GUI_FAKE]];
				Section["23"]["ImageRectOffset"] = Vector2.new(284, 4);
				Section["23"]["Position"] = UDim2.new(1, -4, 0.5, 0);
				Section["23"]["BackgroundTransparency"] = 1;

				-- StarterGui.Yl{;R"}J)7{y5Rte*m7J.Main.Content.__themedesigner.ThemeDesignerSection.GUI_FAKE.TopBar_GUI_FAKE.Minimize_GUI_FAKE
				Section["24"] = Instance.new("ImageButton", Section["1e"]);
				Section["24"]["ZIndex"] = 2;
				Section["24"]["BorderSizePixel"] = 0;
				Section["24"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
				Section["24"]["AnchorPoint"] = Vector2.new(1, 0.5);
				Section["24"]["Image"] = [[rbxassetid://6764432408]];
				Section["24"]["ImageRectSize"] = Vector2.new(50, 50);
				Section["24"]["Size"] = UDim2.new(0, 22, 0, 22);
				Section["24"]["Name"] = [[Minimize_GUI_FAKE]];
				Section["24"]["ImageRectOffset"] = Vector2.new(50, 550);
				Section["24"]["Position"] = UDim2.new(1, -30, 0.5, 0);
				Section["24"]["BackgroundTransparency"] = 1;

				-- StarterGui.Yl{;R"}J)7{y5Rte*m7J.Main.Content.__themedesigner.ThemeDesignerSection.GUI_FAKE.TopBar_GUI_FAKE.Line_GUI_FAKE
				Section["25"] = Instance.new("Frame", Section["1e"]);
				Section["25"]["BorderSizePixel"] = 0;
				Section["25"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
				Section["25"]["AnchorPoint"] = Vector2.new(0, 1);
				Section["25"]["Size"] = UDim2.new(1, 0, 0, 1);
				Section["25"]["Position"] = UDim2.new(0, 0, 1, 0);
				Section["25"]["Name"] = [[Line_GUI_FAKE]];

				-- StarterGui.Yl{;R"}J)7{y5Rte*m7J.Main.Content.__themedesigner.ThemeDesignerSection.GUI_FAKE.Content_GUI_FAKE
				Section["26"] = Instance.new("Frame", Section["1a"]);
				Section["26"]["ZIndex"] = 2;
				Section["26"]["BorderSizePixel"] = 0;
				Section["26"]["BackgroundColor3"] = Color3.fromRGB(39, 39, 39);
				Section["26"]["AnchorPoint"] = Vector2.new(1, 0);
				Section["26"]["BackgroundTransparency"] = 1;
				Section["26"]["Size"] = UDim2.new(1, -133, 1, -42);
				Section["26"]["BorderColor3"] = Color3.fromRGB(57, 57, 57);
				Section["26"]["Position"] = UDim2.new(1, -6, 0, 36);
				Section["26"]["Name"] = [[Content_GUI_FAKE]];

				-- StarterGui.Yl{;R"}J)7{y5Rte*m7J.Main.Content.__themedesigner.ThemeDesignerSection.GUI_FAKE.Content_GUI_FAKE.UICorner_GUI_FAKE
				Section["27"] = Instance.new("UICorner", Section["26"]);
				Section["27"]["Name"] = [[UICorner_GUI_FAKE]];
				Section["27"]["CornerRadius"] = UDim.new(0, 6);

				-- StarterGui.Yl{;R"}J)7{y5Rte*m7J.Main.Content.__themedesigner.ThemeDesignerSection.GUI_FAKE.Content_GUI_FAKE.Fade_GUI_FAKE
				Section["28"] = Instance.new("Frame", Section["26"]);
				Section["28"]["ZIndex"] = 10;
				Section["28"]["BorderSizePixel"] = 0;
				Section["28"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
				Section["28"]["Size"] = UDim2.new(1, 0, 0, 30);
				Section["28"]["Visible"] = false;
				Section["28"]["Name"] = [[Fade_GUI_FAKE]];

				-- StarterGui.Yl{;R"}J)7{y5Rte*m7J.Main.Content.__themedesigner.ThemeDesignerSection.GUI_FAKE.Content_GUI_FAKE.Fade_GUI_FAKE.UIGradient_GUI_FAKE
				Section["29"] = Instance.new("UIGradient", Section["28"]);
				Section["29"]["Name"] = [[UIGradient_GUI_FAKE]];
				Section["29"]["Rotation"] = 90;
				Section["29"]["Color"] = ColorSequence.new{ColorSequenceKeypoint.new(0.000, Color3.fromRGB(31, 31, 31)),ColorSequenceKeypoint.new(1.000, Color3.fromRGB(31, 31, 31))};

				-- StarterGui.Yl{;R"}J)7{y5Rte*m7J.Main.Content.__themedesigner.ThemeDesignerSection.GUI_FAKE.Content_GUI_FAKE.Preview Tab_GUI_FAKE
				Section["2a"] = Instance.new("ScrollingFrame", Section["26"]);
				Section["2a"]["BorderSizePixel"] = 0;
				Section["2a"]["CanvasSize"] = UDim2.new(0, 0, 0, 89);
				Section["2a"]["BackgroundColor3"] = options["Background"];
				Section["2a"]["BackgroundTransparency"] = 1;
				Section["2a"]["Size"] = UDim2.new(1, 0, 1, 0);
				Section["2a"]["Selectable"] = false;
				Section["2a"]["ScrollBarThickness"] = 0;
				Section["2a"]["Name"] = [[Preview Tab_GUI_FAKE]];
				Section["2a"]["SelectionGroup"] = false;

				-- StarterGui.Yl{;R"}J)7{y5Rte*m7J.Main.Content.__themedesigner.ThemeDesignerSection.GUI_FAKE.Content_GUI_FAKE.Preview Tab_GUI_FAKE.UIPadding_GUI_FAKE
				Section["2b"] = Instance.new("UIPadding", Section["2a"]);
				Section["2b"]["PaddingTop"] = UDim.new(0, 1);
				Section["2b"]["Name"] = [[UIPadding_GUI_FAKE]];
				Section["2b"]["PaddingRight"] = UDim.new(0, 1);
				Section["2b"]["PaddingBottom"] = UDim.new(0, 1);
				Section["2b"]["PaddingLeft"] = UDim.new(0, 1);

				-- StarterGui.Yl{;R"}J)7{y5Rte*m7J.Main.Content.__themedesigner.ThemeDesignerSection.GUI_FAKE.Content_GUI_FAKE.Preview Tab_GUI_FAKE.UIListLayout_GUI_FAKE
				Section["2c"] = Instance.new("UIListLayout", Section["2a"]);
				Section["2c"]["Name"] = [[UIListLayout_GUI_FAKE]];
				Section["2c"]["Padding"] = UDim.new(0, 6);
				Section["2c"]["SortOrder"] = Enum.SortOrder.LayoutOrder;

				-- StarterGui.Yl{;R"}J)7{y5Rte*m7J.Main.Content.__themedesigner.ThemeDesignerSection.GUI_FAKE.Content_GUI_FAKE.Preview Tab_GUI_FAKE.Section_GUI_FAKE
				Section["2d"] = Instance.new("Frame", Section["2a"]);
				Section["2d"]["BorderSizePixel"] = 0;
				Section["2d"]["BackgroundColor3"] = options["Section_Background"];
				Section["2d"]["Size"] = UDim2.new(1, 0, 0, 68);
				Section["2d"]["Name"] = [[Section_GUI_FAKE]];

				-- StarterGui.Yl{;R"}J)7{y5Rte*m7J.Main.Content.__themedesigner.ThemeDesignerSection.GUI_FAKE.Content_GUI_FAKE.Preview Tab_GUI_FAKE.Section_GUI_FAKE.UIStroke_GUI_FAKE
				Section["2e"] = Instance.new("UIStroke", Section["2d"]);
				Section["2e"]["Color"] = Color3.fromRGB(255, 255, 255);
				Section["2e"]["Name"] = [[UIStroke_GUI_FAKE]];

				-- StarterGui.Yl{;R"}J)7{y5Rte*m7J.Main.Content.__themedesigner.ThemeDesignerSection.GUI_FAKE.Content_GUI_FAKE.Preview Tab_GUI_FAKE.Section_GUI_FAKE.UIListLayout_GUI_FAKE
				Section["2f"] = Instance.new("UIListLayout", Section["2d"]);
				Section["2f"]["Name"] = [[UIListLayout_GUI_FAKE]];
				Section["2f"]["HorizontalAlignment"] = Enum.HorizontalAlignment.Center;
				Section["2f"]["Padding"] = UDim.new(0, 6);
				Section["2f"]["SortOrder"] = Enum.SortOrder.LayoutOrder;

				-- StarterGui.Yl{;R"}J)7{y5Rte*m7J.Main.Content.__themedesigner.ThemeDesignerSection.GUI_FAKE.Content_GUI_FAKE.Preview Tab_GUI_FAKE.Section_GUI_FAKE.UIPadding_GUI_FAKE
				Section["30"] = Instance.new("UIPadding", Section["2d"]);
				Section["30"]["PaddingTop"] = UDim.new(0, 1);
				Section["30"]["Name"] = [[UIPadding_GUI_FAKE]];
				Section["30"]["PaddingRight"] = UDim.new(0, 1);
				Section["30"]["PaddingBottom"] = UDim.new(0, 1);
				Section["30"]["PaddingLeft"] = UDim.new(0, 1);

				-- StarterGui.Yl{;R"}J)7{y5Rte*m7J.Main.Content.__themedesigner.ThemeDesignerSection.GUI_FAKE.Content_GUI_FAKE.Preview Tab_GUI_FAKE.Section_GUI_FAKE.SectionTitle_GUI_FAKE
				Section["31"] = Instance.new("Frame", Section["2d"]);
				Section["31"]["BackgroundColor3"] = Color3.fromRGB(93, 0, 0);
				Section["31"]["BackgroundTransparency"] = 1;
				Section["31"]["LayoutOrder"] = -999999999;
				Section["31"]["Size"] = UDim2.new(1, 0, 0, 26);
				Section["31"]["Name"] = [[SectionTitle_GUI_FAKE]];

				-- StarterGui.Yl{;R"}J)7{y5Rte*m7J.Main.Content.__themedesigner.ThemeDesignerSection.GUI_FAKE.Content_GUI_FAKE.Preview Tab_GUI_FAKE.Section_GUI_FAKE.SectionTitle_GUI_FAKE.Title_GUI_FAKE
				Section["32"] = Instance.new("TextLabel", Section["31"]);
				Section["32"]["TextWrapped"] = true;
				Section["32"]["RichText"] = true;
				Section["32"]["TextXAlignment"] = Enum.TextXAlignment.Left;
				Section["32"]["TextYAlignment"] = Enum.TextYAlignment.Top;
				Section["32"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
				Section["32"]["TextSize"] = 14;
				Section["32"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
				Section["32"]["Size"] = UDim2.new(0.9930291771888733, 0, 1, 0);
				Section["32"]["Text"] = [[Preview Section]];
				Section["32"]["Name"] = [[Title_GUI_FAKE]];
				Section["32"]["Font"] = Enum.Font.GothamBold;
				Section["32"]["BackgroundTransparency"] = 1;
				Section["32"]["Position"] = UDim2.new(0.003952569328248501, 0, 0, 0);

				-- StarterGui.Yl{;R"}J)7{y5Rte*m7J.Main.Content.__themedesigner.ThemeDesignerSection.GUI_FAKE.Content_GUI_FAKE.Preview Tab_GUI_FAKE.Section_GUI_FAKE.SectionTitle_GUI_FAKE.UIPadding_GUI_FAKE
				Section["33"] = Instance.new("UIPadding", Section["31"]);
				Section["33"]["PaddingTop"] = UDim.new(0, 6);
				Section["33"]["Name"] = [[UIPadding_GUI_FAKE]];
				Section["33"]["PaddingRight"] = UDim.new(0, 6);
				Section["33"]["PaddingBottom"] = UDim.new(0, 6);
				Section["33"]["PaddingLeft"] = UDim.new(0, 6);

				-- StarterGui.Yl{;R"}J)7{y5Rte*m7J.Main.Content.__themedesigner.ThemeDesignerSection.GUI_FAKE.Content_GUI_FAKE.Preview Tab_GUI_FAKE.Section_GUI_FAKE.Label_GUI_FAKE
				Section["34"] = Instance.new("Frame", Section["2d"]);
				Section["34"]["BackgroundColor3"] = Color3.fromRGB(92, 0, 0);
				Section["34"]["BackgroundTransparency"] = 1;
				Section["34"]["Size"] = UDim2.new(0.949999988079071, 0, 0, 26);
				Section["34"]["Name"] = [[Label_GUI_FAKE]];

				-- StarterGui.Yl{;R"}J)7{y5Rte*m7J.Main.Content.__themedesigner.ThemeDesignerSection.GUI_FAKE.Content_GUI_FAKE.Preview Tab_GUI_FAKE.Section_GUI_FAKE.Label_GUI_FAKE.Title_GUI_FAKE
				Section["35"] = Instance.new("TextLabel", Section["34"]);
				Section["35"]["TextWrapped"] = true;
				Section["35"]["TextYAlignment"] = Enum.TextYAlignment.Top;
				Section["35"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
				Section["35"]["TextSize"] = 14;
				Section["35"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
				Section["35"]["AutomaticSize"] = Enum.AutomaticSize.Y;
				Section["35"]["Size"] = UDim2.new(1, 0, 1, 0);
				Section["35"]["Name"] = [[Title_GUI_FAKE]];
				Section["35"]["Font"] = Enum.Font.GothamBold;
				Section["35"]["BackgroundTransparency"] = 1;

				-- StarterGui.Yl{;R"}J)7{y5Rte*m7J.Main.Content.__themedesigner.ThemeDesignerSection.GUI_FAKE.Content_GUI_FAKE.Preview Tab_GUI_FAKE.Section_GUI_FAKE.Label_GUI_FAKE.UIPadding_GUI_FAKE
				Section["36"] = Instance.new("UIPadding", Section["34"]);
				Section["36"]["PaddingTop"] = UDim.new(0, 6);
				Section["36"]["Name"] = [[UIPadding_GUI_FAKE]];
				Section["36"]["PaddingRight"] = UDim.new(0, 6);
				Section["36"]["PaddingBottom"] = UDim.new(0, 6);
				Section["36"]["PaddingLeft"] = UDim.new(0, 6);

				-- StarterGui.Yl{;R"}J)7{y5Rte*m7J.Main.Content.__themedesigner.ThemeDesignerSection.GUI_FAKE.Content_GUI_FAKE.Preview Tab_GUI_FAKE.InvisMiddleSection_GUI_FAKE
				Section["37"] = Instance.new("Frame", Section["2a"]);
				Section["37"]["BorderSizePixel"] = 0;
				Section["37"]["BackgroundTransparency"] = 1;
				Section["37"]["Size"] = UDim2.new(1, 0, 0, 5);
				Section["37"]["Name"] = [[InvisMiddleSection_GUI_FAKE]];

				-- StarterGui.Yl{;R"}J)7{y5Rte*m7J.Main.Content.__themedesigner.ThemeDesignerSection.GUI_FAKE.Navigation_GUI_FAKE
				Section["38"] = Instance.new("Frame", Section["1a"]);
				Section["38"]["BorderSizePixel"] = 0;
				Section["38"]["BackgroundColor3"] = options["Background_Second"];
				Section["38"]["Size"] = UDim2.new(0, 120, 1, -30);
				Section["38"]["Position"] = UDim2.new(0, 0, 0, 30);
				Section["38"]["Name"] = [[Navigation_GUI_FAKE]];

				-- StarterGui.Yl{;R"}J)7{y5Rte*m7J.Main.Content.__themedesigner.ThemeDesignerSection.GUI_FAKE.Navigation_GUI_FAKE.UICorner_GUI_FAKE
				Section["39"] = Instance.new("UICorner", Section["38"]);
				Section["39"]["Name"] = [[UICorner_GUI_FAKE]];
				Section["39"]["CornerRadius"] = UDim.new(0, 6);

				-- StarterGui.Yl{;R"}J)7{y5Rte*m7J.Main.Content.__themedesigner.ThemeDesignerSection.GUI_FAKE.Navigation_GUI_FAKE.Hide_GUI_FAKE
				Section["3a"] = Instance.new("Frame", Section["38"]);
				Section["3a"]["BorderSizePixel"] = 0;
				Section["3a"]["BackgroundColor3"] = options["Background_Second"];
				Section["3a"]["Size"] = UDim2.new(1, 0, 0, 20);
				Section["3a"]["Name"] = [[Hide_GUI_FAKE]];

				-- StarterGui.Yl{;R"}J)7{y5Rte*m7J.Main.Content.__themedesigner.ThemeDesignerSection.GUI_FAKE.Navigation_GUI_FAKE.Hide2_GUI_FAKE
				Section["3b"] = Instance.new("Frame", Section["38"]);
				Section["3b"]["BorderSizePixel"] = 0;
				Section["3b"]["BackgroundColor3"] = options["Background_Second"];
				Section["3b"]["AnchorPoint"] = Vector2.new(1, 0);
				Section["3b"]["Size"] = UDim2.new(0, 20, 1, 0);
				Section["3b"]["Position"] = UDim2.new(1, 0, 0, 0);
				Section["3b"]["Name"] = [[Hide2_GUI_FAKE]];

				-- StarterGui.Yl{;R"}J)7{y5Rte*m7J.Main.Content.__themedesigner.ThemeDesignerSection.GUI_FAKE.Navigation_GUI_FAKE.ButtonHolder_GUI_FAKE
				Section["3c"] = Instance.new("Frame", Section["38"]);
				Section["3c"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
				Section["3c"]["BackgroundTransparency"] = 1;
				Section["3c"]["Size"] = UDim2.new(1, 0, 1, 0);
				Section["3c"]["Name"] = [[ButtonHolder_GUI_FAKE]];

				-- StarterGui.Yl{;R"}J)7{y5Rte*m7J.Main.Content.__themedesigner.ThemeDesignerSection.GUI_FAKE.Navigation_GUI_FAKE.ButtonHolder_GUI_FAKE.UIPadding_GUI_FAKE
				Section["3d"] = Instance.new("UIPadding", Section["3c"]);
				Section["3d"]["PaddingTop"] = UDim.new(0, 8);
				Section["3d"]["Name"] = [[UIPadding_GUI_FAKE]];
				Section["3d"]["PaddingBottom"] = UDim.new(0, 8);

				-- StarterGui.Yl{;R"}J)7{y5Rte*m7J.Main.Content.__themedesigner.ThemeDesignerSection.GUI_FAKE.Navigation_GUI_FAKE.ButtonHolder_GUI_FAKE.UIListLayout_GUI_FAKE
				Section["3e"] = Instance.new("UIListLayout", Section["3c"]);
				Section["3e"]["Name"] = [[UIListLayout_GUI_FAKE]];
				Section["3e"]["Padding"] = UDim.new(0, 1);
				Section["3e"]["SortOrder"] = Enum.SortOrder.LayoutOrder;

				-- StarterGui.Yl{;R"}J)7{y5Rte*m7J.Main.Content.__themedesigner.ThemeDesignerSection.GUI_FAKE.Navigation_GUI_FAKE.ButtonHolder_GUI_FAKE.Icon_GUI_FAKE
				Section["3f"] = Instance.new("TextButton", Section["3c"]);
				Section["3f"]["ZIndex"] = 0;
				Section["3f"]["TextSize"] = 14;
				Section["3f"]["TextXAlignment"] = Enum.TextXAlignment.Left;
				Section["3f"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
				Section["3f"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
				Section["3f"]["Size"] = UDim2.new(1, 0, 0, 24);
				Section["3f"]["Name"] = [[Icon_GUI_FAKE]];
				Section["3f"]["Text"] = [[Preview Tab]];
				Section["3f"]["Font"] = Enum.Font.Gotham;
				Section["3f"]["BackgroundTransparency"] = 0.800000011920929;

				-- StarterGui.Yl{;R"}J)7{y5Rte*m7J.Main.Content.__themedesigner.ThemeDesignerSection.GUI_FAKE.Navigation_GUI_FAKE.ButtonHolder_GUI_FAKE.Icon_GUI_FAKE.UIPadding_GUI_FAKE
				Section["40"] = Instance.new("UIPadding", Section["3f"]);
				Section["40"]["Name"] = [[UIPadding_GUI_FAKE]];
				Section["40"]["PaddingLeft"] = UDim.new(0, 28);

				-- StarterGui.Yl{;R"}J)7{y5Rte*m7J.Main.Content.__themedesigner.ThemeDesignerSection.GUI_FAKE.Navigation_GUI_FAKE.ButtonHolder_GUI_FAKE.Icon_GUI_FAKE.ImageLabel_GUI_FAKE
				Section["41"] = Instance.new("ImageLabel", Section["3f"]);
				Section["41"]["BorderSizePixel"] = 0;
				Section["41"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
				Section["41"]["AnchorPoint"] = Vector2.new(0, 0.5);
				Section["41"]["Image"] = [[rbxassetid://10888331510]];
				Section["41"]["Size"] = UDim2.new(0, 20, 0, 20);
				Section["41"]["Name"] = [[ImageLabel_GUI_FAKE]];
				Section["41"]["BackgroundTransparency"] = 1;
				Section["41"]["Position"] = UDim2.new(0, -24, 0.5, 0);

				-- StarterGui.Yl{;R"}J)7{y5Rte*m7J.Main.Content.__themedesigner.ThemeDesignerSection.GUI_FAKE.Navigation_GUI_FAKE.Line_GUI_FAKE
				Section["42"] = Instance.new("Frame", Section["38"]);
				Section["42"]["BorderSizePixel"] = 0;
				Section["42"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
				Section["42"]["Size"] = UDim2.new(0, 1, 1, 0);
				Section["42"]["Position"] = UDim2.new(1, 0, 0, 0);
				Section["42"]["Name"] = [[Line_GUI_FAKE]];

				-- StarterGui.Yl{;R"}J)7{y5Rte*m7J.Main.Content.__themedesigner.ThemeDesignerSection.PickTheme
				Section["43"] = Instance.new("Frame", Section["15"]);
				Section["43"]["ZIndex"] = 0;
				Section["43"]["BorderSizePixel"] = 0;
				Section["43"]["BackgroundColor3"] = options["Background_Second"];
				Section["43"]["LayoutOrder"] = 1;
				Section["43"]["Size"] = UDim2.new(1, 0, 0.7467288374900818, 30);
				Section["43"]["Position"] = UDim2.new(0, 0, 0.20869439840316772, 0);
				Section["43"]["Name"] = [[PickTheme]];

				-- StarterGui.Yl{;R"}J)7{y5Rte*m7J.Main.Content.__themedesigner.ThemeDesignerSection.PickTheme.UIPadding
				Section["44"] = Instance.new("UIPadding", Section["43"]);
				Section["44"]["PaddingTop"] = UDim.new(0, 6);
				Section["44"]["PaddingRight"] = UDim.new(0, 6);
				Section["44"]["PaddingBottom"] = UDim.new(0, 6);
				Section["44"]["PaddingLeft"] = UDim.new(0, 6);

				-- StarterGui.Yl{;R"}J)7{y5Rte*m7J.Main.Content.__themedesigner.ThemeDesignerSection.PickTheme.SaveTheme
				Section["45"] = Instance.new("TextButton", Section["43"]);
				Section["45"]["ZIndex"] = 0;
				Section["45"]["TextSize"] = 14;
				Section["45"]["TextXAlignment"] = Enum.TextXAlignment.Left;
				Section["45"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
				Section["45"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
				Section["45"]["Size"] = UDim2.new(0.45418328046798706, 0, 0.06038012355566025, 0);
				Section["45"]["Name"] = [[SaveTheme]];
				Section["45"]["Text"] = [[Save Theme]];
				Section["45"]["Font"] = Enum.Font.Gotham;
				Section["45"]["Position"] = UDim2.new(0.023904383182525635, 0, 0.9396197199821472, 0);
				Section["45"]["BackgroundTransparency"] = 0.800000011920929;

				-- StarterGui.Yl{;R"}J)7{y5Rte*m7J.Main.Content.__themedesigner.ThemeDesignerSection.PickTheme.SaveTheme.UIPadding
				Section["46"] = Instance.new("UIPadding", Section["45"]);
				Section["46"]["PaddingLeft"] = UDim.new(0, 28);

				-- StarterGui.Yl{;R"}J)7{y5Rte*m7J.Main.Content.__themedesigner.ThemeDesignerSection.PickTheme.SaveTheme.ImageLabel
				Section["47"] = Instance.new("ImageLabel", Section["45"]);
				Section["47"]["BorderSizePixel"] = 0;
				Section["47"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
				Section["47"]["AnchorPoint"] = Vector2.new(0, 0.5);
				Section["47"]["Image"] = [[rbxassetid://12403099678]];
				Section["47"]["Size"] = UDim2.new(0, 20, 0, 20);
				Section["47"]["BackgroundTransparency"] = 1;
				Section["47"]["Position"] = UDim2.new(0, -24, 0.5, 0);

				-- StarterGui.Yl{;R"}J)7{y5Rte*m7J.Main.Content.__themedesigner.ThemeDesignerSection.PickTheme.SaveTheme.UICorner
				Section["48"] = Instance.new("UICorner", Section["45"]);


				-- StarterGui.Yl{;R"}J)7{y5Rte*m7J.Main.Content.__themedesigner.ThemeDesignerSection.PickTheme.UIStroke
				Section["49"] = Instance.new("UIStroke", Section["43"]);
				Section["49"]["Color"] = Color3.fromRGB(255, 255, 255);

				-- StarterGui.Yl{;R"}J)7{y5Rte*m7J.Main.Content.__themedesigner.ThemeDesignerSection.PickTheme.Topbar
				Section["4a"] = Instance.new("TextLabel", Section["43"]);
				Section["4a"]["TextWrapped"] = true;
				Section["4a"]["ZIndex"] = 99999999;
				Section["4a"]["TextXAlignment"] = Enum.TextXAlignment.Left;
				Section["4a"]["TextYAlignment"] = Enum.TextYAlignment.Top;
				Section["4a"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
				Section["4a"]["Selectable"] = true;
				Section["4a"]["TextSize"] = 14;
				Section["4a"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
				Section["4a"]["Size"] = UDim2.new(0.3944539725780487, 0, 0.04148159548640251, 0);
				Section["4a"]["Text"] = [[Topbar]];
				Section["4a"]["Name"] = [[Topbar]];
				Section["4a"]["Font"] = Enum.Font.GothamBold;
				Section["4a"]["BackgroundTransparency"] = 1;
				Section["4a"]["Position"] = UDim2.new(0.003952451981604099, 0, -0.0015722587704658508, 0);

				-- StarterGui.Yl{;R"}J)7{y5Rte*m7J.Main.Content.__themedesigner.ThemeDesignerSection.PickTheme.Topbar.ColourWheel
				Section["4b"] = Instance.new("ImageButton", Section["4a"]);
				Section["4b"]["Active"] = false;
				Section["4b"]["ZIndex"] = 2;
				Section["4b"]["BorderSizePixel"] = 0;
				Section["4b"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
				Section["4b"]["Selectable"] = false;
				Section["4b"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
				Section["4b"]["Image"] = [[http://www.roblox.com/asset/?id=6020299385]];
				Section["4b"]["Size"] = UDim2.new(1.3792054653167725, 0, 7.35777473449707, 0);
				Section["4b"]["Name"] = [[ColourWheel]];
				Section["4b"]["Position"] = UDim2.new(1.8287179470062256, 0, 2.585885524749756, 0);
				Section["4b"]["BackgroundTransparency"] = 1;

				-- StarterGui.Yl{;R"}J)7{y5Rte*m7J.Main.Content.__themedesigner.ThemeDesignerSection.PickTheme.Topbar.ColourWheel.UIAspectRatioConstraint
				Section["4c"] = Instance.new("UIAspectRatioConstraint", Section["4b"]);
				Section["4c"]["AspectRatio"] = 0.9999999403953552;

				-- StarterGui.Yl{;R"}J)7{y5Rte*m7J.Main.Content.__themedesigner.ThemeDesignerSection.PickTheme.Topbar.ColourWheel.Picker
				Section["4d"] = Instance.new("ImageLabel", Section["4b"]);
				Section["4d"]["BorderSizePixel"] = 0;
				Section["4d"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
				Section["4d"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
				Section["4d"]["Image"] = [[http://www.roblox.com/asset/?id=3678860011]];
				Section["4d"]["Size"] = UDim2.new(0.09002578258514404, 0, 0.09002579748630524, 0);
				Section["4d"]["Name"] = [[Picker]];
				Section["4d"]["BackgroundTransparency"] = 1;
				Section["4d"]["Position"] = UDim2.new(0.5, 0, 0.5, 0);

				-- StarterGui.Yl{;R"}J)7{y5Rte*m7J.Main.Content.__themedesigner.ThemeDesignerSection.PickTheme.Topbar.DarknessPicker
				Section["4e"] = Instance.new("ImageButton", Section["4a"]);
				Section["4e"]["Active"] = false;
				Section["4e"]["ZIndex"] = 2;
				Section["4e"]["BorderSizePixel"] = 0;
				Section["4e"]["SliceCenter"] = Rect.new(100, 100, 100, 100);
				Section["4e"]["ScaleType"] = Enum.ScaleType.Slice;
				Section["4e"]["SliceScale"] = 0.11999999731779099;
				Section["4e"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
				Section["4e"]["Selectable"] = false;
				Section["4e"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
				Section["4e"]["Image"] = [[rbxassetid://3570695787]];
				Section["4e"]["Size"] = UDim2.new(0.22401684522628784, 0, 7.122402667999268, 0);
				Section["4e"]["Name"] = [[DarknessPicker]];
				Section["4e"]["Position"] = UDim2.new(0.9763311743736267, 0, 2.6656672954559326, 0);
				Section["4e"]["BackgroundTransparency"] = 1;

				-- StarterGui.Yl{;R"}J)7{y5Rte*m7J.Main.Content.__themedesigner.ThemeDesignerSection.PickTheme.Topbar.DarknessPicker.UIGradient
				Section["4f"] = Instance.new("UIGradient", Section["4e"]);
				Section["4f"]["Rotation"] = 90;
				Section["4f"]["Color"] = ColorSequence.new{ColorSequenceKeypoint.new(0.000, Color3.fromRGB(255, 255, 255)),ColorSequenceKeypoint.new(1.000, Color3.fromRGB(0, 0, 0))};

				-- StarterGui.Yl{;R"}J)7{y5Rte*m7J.Main.Content.__themedesigner.ThemeDesignerSection.PickTheme.Topbar.DarknessPicker.Slider
				Section["50"] = Instance.new("ImageLabel", Section["4e"]);
				Section["50"]["ZIndex"] = 2;
				Section["50"]["BorderSizePixel"] = 0;
				Section["50"]["SliceCenter"] = Rect.new(100, 100, 100, 100);
				Section["50"]["ScaleType"] = Enum.ScaleType.Slice;
				Section["50"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
				Section["50"]["ImageColor3"] = Color3.fromRGB(255, 75, 75);
				Section["50"]["SliceScale"] = 0.11999999731779099;
				Section["50"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
				Section["50"]["Image"] = [[rbxassetid://3570695787]];
				Section["50"]["Size"] = UDim2.new(1.286563515663147, 0, 0.02650105021893978, 0);
				Section["50"]["Name"] = [[Slider]];
				Section["50"]["BackgroundTransparency"] = 1;
				Section["50"]["Position"] = UDim2.new(0.491197794675827, 0, 0.07336070388555527, 0);

				-- StarterGui.Yl{;R"}J)7{y5Rte*m7J.Main.Content.__themedesigner.ThemeDesignerSection.PickTheme.Topbar.DarknessPicker.UIAspectRatioConstraint
				Section["51"] = Instance.new("UIAspectRatioConstraint", Section["4e"]);
				Section["51"]["AspectRatio"] = 0.15738964080810547;

				-- StarterGui.Yl{;R"}J)7{y5Rte*m7J.Main.Content.__themedesigner.ThemeDesignerSection.PickTheme.Topbar.ColourWheelHandler
				Section["52"] = Instance.new("LocalScript", Section["4a"]);
				Section["52"]["Name"] = [[ColourWheelHandler]];

				-- StarterGui.Yl{;R"}J)7{y5Rte*m7J.Main.Content.__themedesigner.ThemeDesignerSection.PickTheme.Topbar.ColourDisplay
				Section["53"] = Instance.new("ImageButton", Section["4a"]);
				Section["53"]["Active"] = false;
				Section["53"]["ZIndex"] = 2;
				Section["53"]["BorderSizePixel"] = 0;
				Section["53"]["SliceCenter"] = Rect.new(100, 100, 100, 100);
				Section["53"]["ScaleType"] = Enum.ScaleType.Crop;
				Section["53"]["SliceScale"] = 0.11999999731779099;
				Section["53"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
				Section["53"]["ImageColor3"] = options["Topbar"];
				Section["53"]["Selectable"] = false;
				Section["53"]["Image"] = [[rbxassetid://1195495135]];
				Section["53"]["Size"] = UDim2.new(0.4862416982650757, 0, 2.3408830165863037, 0);
				Section["53"]["Name"] = [[ColourDisplay]];
				Section["53"]["Position"] = UDim2.new(-0.010020069777965546, 0, 0.9750795364379883, 0);
				Section["53"]["BackgroundTransparency"] = 1;

				-- StarterGui.Yl{;R"}J)7{y5Rte*m7J.Main.Content.__themedesigner.ThemeDesignerSection.PickTheme.Topbar.ColourDisplay.UIAspectRatioConstraint
				Section["54"] = Instance.new("UIAspectRatioConstraint", Section["53"]);


				-- StarterGui.Yl{;R"}J)7{y5Rte*m7J.Main.Content.__themedesigner.ThemeDesignerSection.PickTheme.Topbar.ColourDisplay.UIStroke
				Section["55"] = Instance.new("UIStroke", Section["53"]);
				Section["55"]["Thickness"] = 2;

				-- StarterGui.Yl{;R"}J)7{y5Rte*m7J.Main.Content.__themedesigner.ThemeDesignerSection.PickTheme.Topbar.ColourDisplay.UICorner
				Section["56"] = Instance.new("UICorner", Section["53"]);


				-- StarterGui.Yl{;R"}J)7{y5Rte*m7J.Main.Content.__themedesigner.ThemeDesignerSection.PickTheme.Background
				Section["57"] = Instance.new("TextLabel", Section["43"]);
				Section["57"]["TextWrapped"] = true;
				Section["57"]["ZIndex"] = 99999999;
				Section["57"]["TextXAlignment"] = Enum.TextXAlignment.Left;
				Section["57"]["TextYAlignment"] = Enum.TextYAlignment.Top;
				Section["57"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
				Section["57"]["Selectable"] = true;
				Section["57"]["TextSize"] = 14;
				Section["57"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
				Section["57"]["Size"] = UDim2.new(0.3944539725780487, 0, 0.04148159548640251, 0);
				Section["57"]["Text"] = [[Background]];
				Section["57"]["Name"] = [[Background]];
				Section["57"]["Font"] = Enum.Font.GothamBold;
				Section["57"]["BackgroundTransparency"] = 1;
				Section["57"]["Position"] = UDim2.new(0.003952451981604099, 0, 0.16493138670921326, 0);

				-- StarterGui.Yl{;R"}J)7{y5Rte*m7J.Main.Content.__themedesigner.ThemeDesignerSection.PickTheme.Background.ColourWheel
				Section["58"] = Instance.new("ImageButton", Section["57"]);
				Section["58"]["Active"] = false;
				Section["58"]["ZIndex"] = 2;
				Section["58"]["BorderSizePixel"] = 0;
				Section["58"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
				Section["58"]["Selectable"] = false;
				Section["58"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
				Section["58"]["Image"] = [[http://www.roblox.com/asset/?id=6020299385]];
				Section["58"]["Size"] = UDim2.new(1.3792054653167725, 0, 7.35777473449707, 0);
				Section["58"]["Name"] = [[ColourWheel]];
				Section["58"]["Position"] = UDim2.new(1.8489183187484741, 0, -1.433714509010315, 0);
				Section["58"]["BackgroundTransparency"] = 1;

				-- StarterGui.Yl{;R"}J)7{y5Rte*m7J.Main.Content.__themedesigner.ThemeDesignerSection.PickTheme.Background.ColourWheel.UIAspectRatioConstraint
				Section["59"] = Instance.new("UIAspectRatioConstraint", Section["58"]);
				Section["59"]["AspectRatio"] = 0.9999999403953552;

				-- StarterGui.Yl{;R"}J)7{y5Rte*m7J.Main.Content.__themedesigner.ThemeDesignerSection.PickTheme.Background.ColourWheel.Picker
				Section["5a"] = Instance.new("ImageLabel", Section["58"]);
				Section["5a"]["BorderSizePixel"] = 0;
				Section["5a"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
				Section["5a"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
				Section["5a"]["Image"] = [[http://www.roblox.com/asset/?id=3678860011]];
				Section["5a"]["Size"] = UDim2.new(0.09002578258514404, 0, 0.09002579748630524, 0);
				Section["5a"]["Name"] = [[Picker]];
				Section["5a"]["BackgroundTransparency"] = 1;
				Section["5a"]["Position"] = UDim2.new(0.5, 0, 0.5, 0);

				-- StarterGui.Yl{;R"}J)7{y5Rte*m7J.Main.Content.__themedesigner.ThemeDesignerSection.PickTheme.Background.DarknessPicker
				Section["5b"] = Instance.new("ImageButton", Section["57"]);
				Section["5b"]["Active"] = false;
				Section["5b"]["ZIndex"] = 2;
				Section["5b"]["BorderSizePixel"] = 0;
				Section["5b"]["SliceCenter"] = Rect.new(100, 100, 100, 100);
				Section["5b"]["ScaleType"] = Enum.ScaleType.Slice;
				Section["5b"]["SliceScale"] = 0.11999999731779099;
				Section["5b"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
				Section["5b"]["Selectable"] = false;
				Section["5b"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
				Section["5b"]["Image"] = [[rbxassetid://3570695787]];
				Section["5b"]["Size"] = UDim2.new(0.22401684522628784, 0, 7.122402667999268, 0);
				Section["5b"]["Name"] = [[DarknessPicker]];
				Section["5b"]["Position"] = UDim2.new(0.9763312339782715, 0, -1.3482481241226196, 0);
				Section["5b"]["BackgroundTransparency"] = 1;

				-- StarterGui.Yl{;R"}J)7{y5Rte*m7J.Main.Content.__themedesigner.ThemeDesignerSection.PickTheme.Background.DarknessPicker.UIGradient
				Section["5c"] = Instance.new("UIGradient", Section["5b"]);
				Section["5c"]["Rotation"] = 90;
				Section["5c"]["Color"] = ColorSequence.new{ColorSequenceKeypoint.new(0.000, Color3.fromRGB(255, 255, 255)),ColorSequenceKeypoint.new(1.000, Color3.fromRGB(0, 0, 0))};

				-- StarterGui.Yl{;R"}J)7{y5Rte*m7J.Main.Content.__themedesigner.ThemeDesignerSection.PickTheme.Background.DarknessPicker.Slider
				Section["5d"] = Instance.new("ImageLabel", Section["5b"]);
				Section["5d"]["ZIndex"] = 2;
				Section["5d"]["BorderSizePixel"] = 0;
				Section["5d"]["SliceCenter"] = Rect.new(100, 100, 100, 100);
				Section["5d"]["ScaleType"] = Enum.ScaleType.Slice;
				Section["5d"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
				Section["5d"]["ImageColor3"] = Color3.fromRGB(255, 75, 75);
				Section["5d"]["SliceScale"] = 0.11999999731779099;
				Section["5d"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
				Section["5d"]["Image"] = [[rbxassetid://3570695787]];
				Section["5d"]["Size"] = UDim2.new(1.286563515663147, 0, 0.02650105021893978, 0);
				Section["5d"]["Name"] = [[Slider]];
				Section["5d"]["BackgroundTransparency"] = 1;
				Section["5d"]["Position"] = UDim2.new(0.491197794675827, 0, 0.07336070388555527, 0);

				-- StarterGui.Yl{;R"}J)7{y5Rte*m7J.Main.Content.__themedesigner.ThemeDesignerSection.PickTheme.Background.DarknessPicker.UIAspectRatioConstraint
				Section["5e"] = Instance.new("UIAspectRatioConstraint", Section["5b"]);
				Section["5e"]["AspectRatio"] = 0.15738964080810547;

				-- StarterGui.Yl{;R"}J)7{y5Rte*m7J.Main.Content.__themedesigner.ThemeDesignerSection.PickTheme.Background.ColourWheelHandler
				Section["5f"] = Instance.new("LocalScript", Section["57"]);
				Section["5f"]["Name"] = [[ColourWheelHandler]];

				-- StarterGui.Yl{;R"}J)7{y5Rte*m7J.Main.Content.__themedesigner.ThemeDesignerSection.PickTheme.Background.ColourDisplay
				Section["60"] = Instance.new("ImageButton", Section["57"]);
				Section["60"]["Active"] = false;
				Section["60"]["ZIndex"] = 2;
				Section["60"]["BorderSizePixel"] = 0;
				Section["60"]["SliceCenter"] = Rect.new(100, 100, 100, 100);
				Section["60"]["ScaleType"] = Enum.ScaleType.Crop;
				Section["60"]["SliceScale"] = 0.11999999731779099;
				Section["60"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
				Section["60"]["ImageColor3"] = options["Background"];
				Section["60"]["Selectable"] = false;
				Section["60"]["Image"] = [[rbxassetid://1195495135]];
				Section["60"]["Size"] = UDim2.new(0.4862416982650757, 0, 2.3408830165863037, 0);
				Section["60"]["Name"] = [[ColourDisplay]];
				Section["60"]["Position"] = UDim2.new(-0.010020069777965546, 0, 0.9750795364379883, 0);
				Section["60"]["BackgroundTransparency"] = 1;

				-- StarterGui.Yl{;R"}J)7{y5Rte*m7J.Main.Content.__themedesigner.ThemeDesignerSection.PickTheme.Background.ColourDisplay.UIAspectRatioConstraint
				Section["61"] = Instance.new("UIAspectRatioConstraint", Section["60"]);


				-- StarterGui.Yl{;R"}J)7{y5Rte*m7J.Main.Content.__themedesigner.ThemeDesignerSection.PickTheme.Background.ColourDisplay.UIStroke
				Section["62"] = Instance.new("UIStroke", Section["60"]);
				Section["62"]["Thickness"] = 2;

				-- StarterGui.Yl{;R"}J)7{y5Rte*m7J.Main.Content.__themedesigner.ThemeDesignerSection.PickTheme.Background.ColourDisplay.UICorner
				Section["63"] = Instance.new("UICorner", Section["60"]);


				-- StarterGui.Yl{;R"}J)7{y5Rte*m7J.Main.Content.__themedesigner.ThemeDesignerSection.PickTheme.Secondary Background
				Section["64"] = Instance.new("TextLabel", Section["43"]);
				Section["64"]["TextWrapped"] = true;
				Section["64"]["ZIndex"] = 99999999;
				Section["64"]["TextXAlignment"] = Enum.TextXAlignment.Left;
				Section["64"]["TextYAlignment"] = Enum.TextYAlignment.Top;
				Section["64"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
				Section["64"]["Selectable"] = true;
				Section["64"]["TextSize"] = 14;
				Section["64"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
				Section["64"]["Size"] = UDim2.new(0.3944539725780487, 0, 0.07060789316892624, 0);
				Section["64"]["Text"] = [[Secondary Background]];
				Section["64"]["Name"] = [[Secondary Background]];
				Section["64"]["Font"] = Enum.Font.GothamBold;
				Section["64"]["BackgroundTransparency"] = 1;
				Section["64"]["Position"] = UDim2.new(0.003952451981604099, 0, 0.30694717168807983, 0);

				-- StarterGui.Yl{;R"}J)7{y5Rte*m7J.Main.Content.__themedesigner.ThemeDesignerSection.PickTheme.Secondary Background.ColourWheel
				Section["65"] = Instance.new("ImageButton", Section["64"]);
				Section["65"]["Active"] = false;
				Section["65"]["ZIndex"] = 2;
				Section["65"]["BorderSizePixel"] = 0;
				Section["65"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
				Section["65"]["Selectable"] = false;
				Section["65"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
				Section["65"]["Image"] = [[http://www.roblox.com/asset/?id=6020299385]];
				Section["65"]["Size"] = UDim2.new(1.3792054653167725, 0, 7.35777473449707, 0);
				Section["65"]["Name"] = [[ColourWheel]];
				Section["65"]["Position"] = UDim2.new(1.8186177015304565, 0, 0.8450292348861694, 0);
				Section["65"]["BackgroundTransparency"] = 1;

				-- StarterGui.Yl{;R"}J)7{y5Rte*m7J.Main.Content.__themedesigner.ThemeDesignerSection.PickTheme.Secondary Background.ColourWheel.UIAspectRatioConstraint
				Section["66"] = Instance.new("UIAspectRatioConstraint", Section["65"]);
				Section["66"]["AspectRatio"] = 0.9999999403953552;

				-- StarterGui.Yl{;R"}J)7{y5Rte*m7J.Main.Content.__themedesigner.ThemeDesignerSection.PickTheme.Secondary Background.ColourWheel.Picker
				Section["67"] = Instance.new("ImageLabel", Section["65"]);
				Section["67"]["BorderSizePixel"] = 0;
				Section["67"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
				Section["67"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
				Section["67"]["Image"] = [[http://www.roblox.com/asset/?id=3678860011]];
				Section["67"]["Size"] = UDim2.new(0.09002578258514404, 0, 0.09002579748630524, 0);
				Section["67"]["Name"] = [[Picker]];
				Section["67"]["BackgroundTransparency"] = 1;
				Section["67"]["Position"] = UDim2.new(0.5, 0, 0.5, 0);

				-- StarterGui.Yl{;R"}J)7{y5Rte*m7J.Main.Content.__themedesigner.ThemeDesignerSection.PickTheme.Secondary Background.DarknessPicker
				Section["68"] = Instance.new("ImageButton", Section["64"]);
				Section["68"]["Active"] = false;
				Section["68"]["ZIndex"] = 2;
				Section["68"]["BorderSizePixel"] = 0;
				Section["68"]["SliceCenter"] = Rect.new(100, 100, 100, 100);
				Section["68"]["ScaleType"] = Enum.ScaleType.Slice;
				Section["68"]["SliceScale"] = 0.11999999731779099;
				Section["68"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
				Section["68"]["Selectable"] = false;
				Section["68"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
				Section["68"]["Image"] = [[rbxassetid://3570695787]];
				Section["68"]["Size"] = UDim2.new(0.22401684522628784, 0, 7.122402667999268, 0);
				Section["68"]["Name"] = [[DarknessPicker]];
				Section["68"]["Position"] = UDim2.new(0.9763311743736267, 0, 0.8480112552642822, 0);
				Section["68"]["BackgroundTransparency"] = 1;

				-- StarterGui.Yl{;R"}J)7{y5Rte*m7J.Main.Content.__themedesigner.ThemeDesignerSection.PickTheme.Secondary Background.DarknessPicker.UIGradient
				Section["69"] = Instance.new("UIGradient", Section["68"]);
				Section["69"]["Rotation"] = 90;
				Section["69"]["Color"] = ColorSequence.new{ColorSequenceKeypoint.new(0.000, Color3.fromRGB(255, 255, 255)),ColorSequenceKeypoint.new(1.000, Color3.fromRGB(0, 0, 0))};

				-- StarterGui.Yl{;R"}J)7{y5Rte*m7J.Main.Content.__themedesigner.ThemeDesignerSection.PickTheme.Secondary Background.DarknessPicker.Slider
				Section["6a"] = Instance.new("ImageLabel", Section["68"]);
				Section["6a"]["ZIndex"] = 2;
				Section["6a"]["BorderSizePixel"] = 0;
				Section["6a"]["SliceCenter"] = Rect.new(100, 100, 100, 100);
				Section["6a"]["ScaleType"] = Enum.ScaleType.Slice;
				Section["6a"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
				Section["6a"]["ImageColor3"] = Color3.fromRGB(255, 75, 75);
				Section["6a"]["SliceScale"] = 0.11999999731779099;
				Section["6a"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
				Section["6a"]["Image"] = [[rbxassetid://3570695787]];
				Section["6a"]["Size"] = UDim2.new(1.286563515663147, 0, 0.02650105021893978, 0);
				Section["6a"]["Name"] = [[Slider]];
				Section["6a"]["BackgroundTransparency"] = 1;
				Section["6a"]["Position"] = UDim2.new(0.491197794675827, 0, 0.07336070388555527, 0);

				-- StarterGui.Yl{;R"}J)7{y5Rte*m7J.Main.Content.__themedesigner.ThemeDesignerSection.PickTheme.Secondary Background.DarknessPicker.UIAspectRatioConstraint
				Section["6b"] = Instance.new("UIAspectRatioConstraint", Section["68"]);
				Section["6b"]["AspectRatio"] = 0.15738964080810547;

				-- StarterGui.Yl{;R"}J)7{y5Rte*m7J.Main.Content.__themedesigner.ThemeDesignerSection.PickTheme.Secondary Background.ColourWheelHandler
				Section["6c"] = Instance.new("LocalScript", Section["64"]);
				Section["6c"]["Name"] = [[ColourWheelHandler]];

				-- StarterGui.Yl{;R"}J)7{y5Rte*m7J.Main.Content.__themedesigner.ThemeDesignerSection.PickTheme.Secondary Background.ColourDisplay
				Section["6d"] = Instance.new("ImageButton", Section["64"]);
				Section["6d"]["Active"] = false;
				Section["6d"]["ZIndex"] = 2;
				Section["6d"]["BorderSizePixel"] = 0;
				Section["6d"]["SliceCenter"] = Rect.new(100, 100, 100, 100);
				Section["6d"]["ScaleType"] = Enum.ScaleType.Crop;
				Section["6d"]["SliceScale"] = 0.11999999731779099;
				Section["6d"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
				Section["6d"]["ImageColor3"] = options["Background_Second"];
				Section["6d"]["Selectable"] = false;
				Section["6d"]["Image"] = [[rbxassetid://1195495135]];
				Section["6d"]["Size"] = UDim2.new(0.4862416982650757, 0, 2.3408830165863037, 0);
				Section["6d"]["Name"] = [[ColourDisplay]];
				Section["6d"]["Position"] = UDim2.new(-0.010020069777965546, 0, 0.9750795364379883, 0);
				Section["6d"]["BackgroundTransparency"] = 1;

				-- StarterGui.Yl{;R"}J)7{y5Rte*m7J.Main.Content.__themedesigner.ThemeDesignerSection.PickTheme.Secondary Background.ColourDisplay.UIAspectRatioConstraint
				Section["6e"] = Instance.new("UIAspectRatioConstraint", Section["6d"]);


				-- StarterGui.Yl{;R"}J)7{y5Rte*m7J.Main.Content.__themedesigner.ThemeDesignerSection.PickTheme.Secondary Background.ColourDisplay.UIStroke
				Section["6f"] = Instance.new("UIStroke", Section["6d"]);
				Section["6f"]["Thickness"] = 2;

				-- StarterGui.Yl{;R"}J)7{y5Rte*m7J.Main.Content.__themedesigner.ThemeDesignerSection.PickTheme.Secondary Background.ColourDisplay.UICorner
				Section["70"] = Instance.new("UICorner", Section["6d"]);


				-- StarterGui.Yl{;R"}J)7{y5Rte*m7J.Main.Content.__themedesigner.ThemeDesignerSection.PickTheme.Section Background
				Section["71"] = Instance.new("TextLabel", Section["43"]);
				Section["71"]["TextWrapped"] = true;
				Section["71"]["ZIndex"] = 99999999;
				Section["71"]["TextXAlignment"] = Enum.TextXAlignment.Left;
				Section["71"]["TextYAlignment"] = Enum.TextYAlignment.Top;
				Section["71"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
				Section["71"]["Selectable"] = true;
				Section["71"]["TextSize"] = 14;
				Section["71"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
				Section["71"]["Size"] = UDim2.new(0.3944539725780487, 0, 0.07060789316892624, 0);
				Section["71"]["Text"] = [[Section Background]];
				Section["71"]["Name"] = [[Section Background]];
				Section["71"]["Font"] = Enum.Font.GothamBold;
				Section["71"]["BackgroundTransparency"] = 1;
				Section["71"]["Position"] = UDim2.new(0.003952451981604099, 0, 0.5184963941574097, 0);

				-- StarterGui.Yl{;R"}J)7{y5Rte*m7J.Main.Content.__themedesigner.ThemeDesignerSection.PickTheme.Section Background.ColourWheel
				Section["72"] = Instance.new("ImageButton", Section["71"]);
				Section["72"]["Active"] = false;
				Section["72"]["ZIndex"] = 2;
				Section["72"]["BorderSizePixel"] = 0;
				Section["72"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
				Section["72"]["Selectable"] = false;
				Section["72"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
				Section["72"]["Image"] = [[http://www.roblox.com/asset/?id=6020299385]];
				Section["72"]["Size"] = UDim2.new(1.3792054653167725, 0, 7.35777473449707, 0);
				Section["72"]["Name"] = [[ColourWheel]];
				Section["72"]["Position"] = UDim2.new(1.8590185642242432, 0, 1.0415652990341187, 0);
				Section["72"]["BackgroundTransparency"] = 1;

				-- StarterGui.Yl{;R"}J)7{y5Rte*m7J.Main.Content.__themedesigner.ThemeDesignerSection.PickTheme.Section Background.ColourWheel.UIAspectRatioConstraint
				Section["73"] = Instance.new("UIAspectRatioConstraint", Section["72"]);
				Section["73"]["AspectRatio"] = 0.9999999403953552;

				-- StarterGui.Yl{;R"}J)7{y5Rte*m7J.Main.Content.__themedesigner.ThemeDesignerSection.PickTheme.Section Background.ColourWheel.Picker
				Section["74"] = Instance.new("ImageLabel", Section["72"]);
				Section["74"]["BorderSizePixel"] = 0;
				Section["74"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
				Section["74"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
				Section["74"]["Image"] = [[http://www.roblox.com/asset/?id=3678860011]];
				Section["74"]["Size"] = UDim2.new(0.09002578258514404, 0, 0.09002579748630524, 0);
				Section["74"]["Name"] = [[Picker]];
				Section["74"]["BackgroundTransparency"] = 1;
				Section["74"]["Position"] = UDim2.new(0.5, 0, 0.5, 0);

				-- StarterGui.Yl{;R"}J)7{y5Rte*m7J.Main.Content.__themedesigner.ThemeDesignerSection.PickTheme.Section Background.DarknessPicker
				Section["75"] = Instance.new("ImageButton", Section["71"]);
				Section["75"]["Active"] = false;
				Section["75"]["ZIndex"] = 2;
				Section["75"]["BorderSizePixel"] = 0;
				Section["75"]["SliceCenter"] = Rect.new(100, 100, 100, 100);
				Section["75"]["ScaleType"] = Enum.ScaleType.Slice;
				Section["75"]["SliceScale"] = 0.11999999731779099;
				Section["75"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
				Section["75"]["Selectable"] = false;
				Section["75"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
				Section["75"]["Image"] = [[rbxassetid://3570695787]];
				Section["75"]["Size"] = UDim2.new(0.22401684522628784, 0, 7.122402667999268, 0);
				Section["75"]["Name"] = [[DarknessPicker]];
				Section["75"]["Position"] = UDim2.new(0.9864314198493958, 0, 1.1781522035598755, 0);
				Section["75"]["BackgroundTransparency"] = 1;

				-- StarterGui.Yl{;R"}J)7{y5Rte*m7J.Main.Content.__themedesigner.ThemeDesignerSection.PickTheme.Section Background.DarknessPicker.UIGradient
				Section["76"] = Instance.new("UIGradient", Section["75"]);
				Section["76"]["Rotation"] = 90;
				Section["76"]["Color"] = ColorSequence.new{ColorSequenceKeypoint.new(0.000, Color3.fromRGB(255, 255, 255)),ColorSequenceKeypoint.new(1.000, Color3.fromRGB(0, 0, 0))};

				-- StarterGui.Yl{;R"}J)7{y5Rte*m7J.Main.Content.__themedesigner.ThemeDesignerSection.PickTheme.Section Background.DarknessPicker.Slider
				Section["77"] = Instance.new("ImageLabel", Section["75"]);
				Section["77"]["ZIndex"] = 2;
				Section["77"]["BorderSizePixel"] = 0;
				Section["77"]["SliceCenter"] = Rect.new(100, 100, 100, 100);
				Section["77"]["ScaleType"] = Enum.ScaleType.Slice;
				Section["77"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
				Section["77"]["ImageColor3"] = Color3.fromRGB(255, 75, 75);
				Section["77"]["SliceScale"] = 0.11999999731779099;
				Section["77"]["AnchorPoint"] = Vector2.new(0.5, 0.5);
				Section["77"]["Image"] = [[rbxassetid://3570695787]];
				Section["77"]["Size"] = UDim2.new(1.286563515663147, 0, 0.02650105021893978, 0);
				Section["77"]["Name"] = [[Slider]];
				Section["77"]["BackgroundTransparency"] = 1;
				Section["77"]["Position"] = UDim2.new(0.491197794675827, 0, 0.07336070388555527, 0);

				-- StarterGui.Yl{;R"}J)7{y5Rte*m7J.Main.Content.__themedesigner.ThemeDesignerSection.PickTheme.Section Background.DarknessPicker.UIAspectRatioConstraint
				Section["78"] = Instance.new("UIAspectRatioConstraint", Section["75"]);
				Section["78"]["AspectRatio"] = 0.15738964080810547;

				-- StarterGui.Yl{;R"}J)7{y5Rte*m7J.Main.Content.__themedesigner.ThemeDesignerSection.PickTheme.Section Background.ColourWheelHandler
				Section["79"] = Instance.new("LocalScript", Section["71"]);
				Section["79"]["Name"] = [[ColourWheelHandler]];

				-- StarterGui.Yl{;R"}J)7{y5Rte*m7J.Main.Content.__themedesigner.ThemeDesignerSection.PickTheme.Section Background.ColourDisplay
				Section["7a"] = Instance.new("ImageButton", Section["71"]);
				Section["7a"]["Active"] = false;
				Section["7a"]["ZIndex"] = 2;
				Section["7a"]["BorderSizePixel"] = 0;
				Section["7a"]["SliceCenter"] = Rect.new(100, 100, 100, 100);
				Section["7a"]["ScaleType"] = Enum.ScaleType.Crop;
				Section["7a"]["SliceScale"] = 0.11999999731779099;
				Section["7a"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
				Section["7a"]["ImageColor3"] = options["Section_Background"];
				Section["7a"]["Selectable"] = false;
				Section["7a"]["Image"] = [[rbxassetid://1195495135]];
				Section["7a"]["Size"] = UDim2.new(0.4862416982650757, 0, 2.3408830165863037, 0);
				Section["7a"]["Name"] = [[ColourDisplay]];
				Section["7a"]["Position"] = UDim2.new(-0.010020069777965546, 0, 0.9750795364379883, 0);
				Section["7a"]["BackgroundTransparency"] = 1;

				-- StarterGui.Yl{;R"}J)7{y5Rte*m7J.Main.Content.__themedesigner.ThemeDesignerSection.PickTheme.Section Background.ColourDisplay.UIAspectRatioConstraint
				Section["7b"] = Instance.new("UIAspectRatioConstraint", Section["7a"]);


				-- StarterGui.Yl{;R"}J)7{y5Rte*m7J.Main.Content.__themedesigner.ThemeDesignerSection.PickTheme.Section Background.ColourDisplay.UIStroke
				Section["7c"] = Instance.new("UIStroke", Section["7a"]);
				Section["7c"]["Thickness"] = 2;

				-- StarterGui.Yl{;R"}J)7{y5Rte*m7J.Main.Content.__themedesigner.ThemeDesignerSection.PickTheme.Section Background.ColourDisplay.UICorner
				Section["7d"] = Instance.new("UICorner", Section["7a"]);


				-- StarterGui.Yl{;R"}J)7{y5Rte*m7J.Main.Content.__themedesigner.ThemeDesignerSection.PickTheme.ThemeName
				Section["7e"] = Instance.new("TextButton", Section["43"]);
				Section["7e"]["ZIndex"] = 9999;
				Section["7e"]["BackgroundColor3"] = Color3.fromRGB(28, 28, 28);
				Section["7e"]["Size"] = UDim2.new(0.949999988079071, 0, 0, 32);
				Section["7e"]["Name"] = [[ThemeName]];
				Section["7e"]["Text"] = [[]];
				Section["7e"]["Position"] = UDim2.new(0.023904383182525635, 0, 0.7530794739723206, 0);

				-- StarterGui.Yl{;R"}J)7{y5Rte*m7J.Main.Content.__themedesigner.ThemeDesignerSection.PickTheme.ThemeName.UICorner
				Section["7f"] = Instance.new("UICorner", Section["7e"]);
				Section["7f"]["CornerRadius"] = UDim.new(0, 4);

				-- StarterGui.Yl{;R"}J)7{y5Rte*m7J.Main.Content.__themedesigner.ThemeDesignerSection.PickTheme.ThemeName.UIStroke
				Section["80"] = Instance.new("UIStroke", Section["7e"]);
				Section["80"]["Color"] = Color3.fromRGB(83, 83, 83);
				Section["80"]["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border;

				-- StarterGui.Yl{;R"}J)7{y5Rte*m7J.Main.Content.__themedesigner.ThemeDesignerSection.PickTheme.ThemeName.Title
				Section["81"] = Instance.new("TextBox", Section["7e"]);
				Section["81"]["CursorPosition"] = -1;
				Section["81"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
				Section["81"]["TextXAlignment"] = Enum.TextXAlignment.Left;
				Section["81"]["TextWrapped"] = true;
				Section["81"]["TextSize"] = 14;
				Section["81"]["TextYAlignment"] = Enum.TextYAlignment.Top;
				Section["81"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
				Section["81"]["BackgroundTransparency"] = 1;
				Section["81"]["PlaceholderText"] = [[Theme Name]];
				Section["81"]["Size"] = UDim2.new(1, 0, 0.9716278314590454, 0);
				Section["81"]["Text"] = options["Name"];
				Section["81"]["AutomaticSize"] = Enum.AutomaticSize.Y;
				Section["81"]["Font"] = Enum.Font.Gotham;
				Section["81"]["Name"] = [[Title]];
				Section["81"]["ClearTextOnFocus"] = false;

				-- StarterGui.Yl{;R"}J)7{y5Rte*m7J.Main.Content.__themedesigner.ThemeDesignerSection.PickTheme.ThemeName.UIPadding
				Section["82"] = Instance.new("UIPadding", Section["7e"]);
				Section["82"]["PaddingTop"] = UDim.new(0, 6);
				Section["82"]["PaddingRight"] = UDim.new(0, 6);
				Section["82"]["PaddingBottom"] = UDim.new(0, 6);
				Section["82"]["PaddingLeft"] = UDim.new(0, 6);

				-- StarterGui.Yl{;R"}J)7{y5Rte*m7J.Main.Content.__themedesigner.ThemeDesignerSection.PickTheme.ThemeNameLabel
				Section["83"] = Instance.new("Frame", Section["43"]);
				Section["83"]["ZIndex"] = 9999;
				Section["83"]["BackgroundColor3"] = Color3.fromRGB(91, 0, 0);
				Section["83"]["BackgroundTransparency"] = 1;
				Section["83"]["Size"] = UDim2.new(0.949999988079071, 0, 0, 26);
				Section["83"]["Position"] = UDim2.new(0.023904383182525635, 0, 0.7121216058731079, 0);
				Section["83"]["Name"] = [[ThemeNameLabel]];

				-- StarterGui.Yl{;R"}J)7{y5Rte*m7J.Main.Content.__themedesigner.ThemeDesignerSection.PickTheme.ThemeNameLabel.Title
				Section["84"] = Instance.new("TextLabel", Section["83"]);
				Section["84"]["TextWrapped"] = true;
				Section["84"]["TextXAlignment"] = Enum.TextXAlignment.Left;
				Section["84"]["TextYAlignment"] = Enum.TextYAlignment.Top;
				Section["84"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
				Section["84"]["TextSize"] = 14;
				Section["84"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
				Section["84"]["AutomaticSize"] = Enum.AutomaticSize.Y;
				Section["84"]["Size"] = UDim2.new(1, 0, 1, 0);
				Section["84"]["Text"] = [[Theme Name]];
				Section["84"]["Name"] = [[Title]];
				Section["84"]["Font"] = Enum.Font.GothamBold;
				Section["84"]["BackgroundTransparency"] = 1;

				-- StarterGui.Yl{;R"}J)7{y5Rte*m7J.Main.Content.__themedesigner.ThemeDesignerSection.PickTheme.ThemeNameLabel.UIPadding
				Section["85"] = Instance.new("UIPadding", Section["83"]);
				Section["85"]["PaddingTop"] = UDim.new(0, 6);
				Section["85"]["PaddingRight"] = UDim.new(0, 6);
				Section["85"]["PaddingBottom"] = UDim.new(0, 6);
				Section["85"]["PaddingLeft"] = UDim.new(0, 6);

				-- StarterGui.Yl{;R"}J)7{y5Rte*m7J.Main.Content.__themedesigner.ThemeDesignerSection.PickTheme.ThemeCreator
				Section["86"] = Instance.new("TextButton", Section["43"]);
				Section["86"]["ZIndex"] = 9999;
				Section["86"]["BackgroundColor3"] = Color3.fromRGB(28, 28, 28);
				Section["86"]["Size"] = UDim2.new(0.949999988079071, 0, 0, 32);
				Section["86"]["Name"] = [[ThemeCreator]];
				Section["86"]["Text"] = [[]];
				Section["86"]["Position"] = UDim2.new(0.023904383182525635, 0, 0.8536264896392822, 0);

				-- StarterGui.Yl{;R"}J)7{y5Rte*m7J.Main.Content.__themedesigner.ThemeDesignerSection.PickTheme.ThemeCreator.UICorner
				Section["87"] = Instance.new("UICorner", Section["86"]);
				Section["87"]["CornerRadius"] = UDim.new(0, 4);

				-- StarterGui.Yl{;R"}J)7{y5Rte*m7J.Main.Content.__themedesigner.ThemeDesignerSection.PickTheme.ThemeCreator.UIStroke
				Section["88"] = Instance.new("UIStroke", Section["86"]);
				Section["88"]["Color"] = Color3.fromRGB(83, 83, 83);
				Section["88"]["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border;

				-- StarterGui.Yl{;R"}J)7{y5Rte*m7J.Main.Content.__themedesigner.ThemeDesignerSection.PickTheme.ThemeCreator.Title
				Section["89"] = Instance.new("TextBox", Section["86"]);
				Section["89"]["CursorPosition"] = -1;
				Section["89"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
				Section["89"]["TextXAlignment"] = Enum.TextXAlignment.Left;
				Section["89"]["TextWrapped"] = true;
				Section["89"]["TextSize"] = 14;
				Section["89"]["TextYAlignment"] = Enum.TextYAlignment.Top;
				Section["89"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
				Section["89"]["BackgroundTransparency"] = 1;
				Section["89"]["PlaceholderText"] = [[Theme Creator]];
				Section["89"]["Size"] = UDim2.new(1, 0, 0.9716278314590454, 0);
				Section["89"]["Text"] = options["By"];
				Section["89"]["AutomaticSize"] = Enum.AutomaticSize.Y;
				Section["89"]["Font"] = Enum.Font.Gotham;
				Section["89"]["Name"] = [[Title]];
				Section["89"]["ClearTextOnFocus"] = false;

				-- StarterGui.Yl{;R"}J)7{y5Rte*m7J.Main.Content.__themedesigner.ThemeDesignerSection.PickTheme.ThemeCreator.UIPadding
				Section["8a"] = Instance.new("UIPadding", Section["86"]);
				Section["8a"]["PaddingTop"] = UDim.new(0, 6);
				Section["8a"]["PaddingRight"] = UDim.new(0, 6);
				Section["8a"]["PaddingBottom"] = UDim.new(0, 6);
				Section["8a"]["PaddingLeft"] = UDim.new(0, 6);

				-- StarterGui.Yl{;R"}J)7{y5Rte*m7J.Main.Content.__themedesigner.ThemeDesignerSection.PickTheme.ThemeCreatorLabel
				Section["8b"] = Instance.new("Frame", Section["43"]);
				Section["8b"]["ZIndex"] = 9999;
				Section["8b"]["BackgroundColor3"] = Color3.fromRGB(91, 0, 0);
				Section["8b"]["BackgroundTransparency"] = 1;
				Section["8b"]["Size"] = UDim2.new(0.949999988079071, 0, 0, 26);
				Section["8b"]["Position"] = UDim2.new(0.023904383182525635, 0, 0.8126686215400696, 0);
				Section["8b"]["Name"] = [[ThemeCreatorLabel]];

				-- StarterGui.Yl{;R"}J)7{y5Rte*m7J.Main.Content.__themedesigner.ThemeDesignerSection.PickTheme.ThemeCreatorLabel.Title
				Section["8c"] = Instance.new("TextLabel", Section["8b"]);
				Section["8c"]["TextWrapped"] = true;
				Section["8c"]["TextXAlignment"] = Enum.TextXAlignment.Left;
				Section["8c"]["TextYAlignment"] = Enum.TextYAlignment.Top;
				Section["8c"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
				Section["8c"]["TextSize"] = 14;
				Section["8c"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
				Section["8c"]["AutomaticSize"] = Enum.AutomaticSize.Y;
				Section["8c"]["Size"] = UDim2.new(1, 0, 1, 0);
				Section["8c"]["Text"] = [[Theme Creator]];
				Section["8c"]["Name"] = [[Title]];
				Section["8c"]["Font"] = Enum.Font.GothamBold;
				Section["8c"]["BackgroundTransparency"] = 1;

				-- StarterGui.Yl{;R"}J)7{y5Rte*m7J.Main.Content.__themedesigner.ThemeDesignerSection.PickTheme.ThemeCreatorLabel.UIPadding
				Section["8d"] = Instance.new("UIPadding", Section["8b"]);
				Section["8d"]["PaddingTop"] = UDim.new(0, 6);
				Section["8d"]["PaddingRight"] = UDim.new(0, 6);
				Section["8d"]["PaddingBottom"] = UDim.new(0, 6);
				Section["8d"]["PaddingLeft"] = UDim.new(0, 6);

				-- StarterGui.Yl{;R"}J)7{y5Rte*m7J.Main.Content.__themedesigner.ThemeDesignerSection.PickTheme.UseTheme
				Section["8e"] = Instance.new("TextButton", Section["43"]);
				Section["8e"]["ZIndex"] = 0;
				Section["8e"]["TextSize"] = 14;
				Section["8e"]["TextXAlignment"] = Enum.TextXAlignment.Left;
				Section["8e"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
				Section["8e"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
				Section["8e"]["Size"] = UDim2.new(0.46394428610801697, 0, 0.06038012355566025, 0);
				Section["8e"]["Name"] = [[UseTheme]];
				Section["8e"]["Text"] = [[Use Theme]];
				Section["8e"]["Font"] = Enum.Font.Gotham;
				Section["8e"]["Position"] = UDim2.new(0.5099601745605469, 0, 0.9396197199821472, 0);
				Section["8e"]["BackgroundTransparency"] = 0.800000011920929;

				-- StarterGui.Yl{;R"}J)7{y5Rte*m7J.Main.Content.__themedesigner.ThemeDesignerSection.PickTheme.UseTheme.UIPadding
				Section["8f"] = Instance.new("UIPadding", Section["8e"]);
				Section["8f"]["PaddingLeft"] = UDim.new(0, 28);

				-- StarterGui.Yl{;R"}J)7{y5Rte*m7J.Main.Content.__themedesigner.ThemeDesignerSection.PickTheme.UseTheme.ImageLabel
				Section["90"] = Instance.new("ImageLabel", Section["8e"]);
				Section["90"]["BorderSizePixel"] = 0;
				Section["90"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
				Section["90"]["AnchorPoint"] = Vector2.new(0, 0.5);
				Section["90"]["Image"] = [[rbxassetid://3926305904]];
				Section["90"]["ImageRectSize"] = Vector2.new(36, 36);
				Section["90"]["Size"] = UDim2.new(0, 20, 0, 20);
				Section["90"]["ImageRectOffset"] = Vector2.new(924, 364);
				Section["90"]["BackgroundTransparency"] = 1;
				Section["90"]["Position"] = UDim2.new(0, -24, 0.5, 0);

				-- StarterGui.Yl{;R"}J)7{y5Rte*m7J.Main.Content.__themedesigner.ThemeDesignerSection.PickTheme.UseTheme.UICorner
				Section["91"] = Instance.new("UICorner", Section["8e"]);


				-- StarterGui.Yl{;R"}J)7{y5Rte*m7J.Main.Content.__themedesigner.ThemeDesignerSection.SectionTitle
				Section["92"] = Instance.new("Frame", Section["15"]);
				Section["92"]["BackgroundColor3"] = Color3.fromRGB(93, 0, 0);
				Section["92"]["BackgroundTransparency"] = 1;
				Section["92"]["Size"] = UDim2.new(1, 0, -0.0242138858884573, 26);
				Section["92"]["Position"] = UDim2.new(0, 0, 0.15262220799922943, 0);
				Section["92"]["Name"] = [[SectionTitle]];

				-- StarterGui.Yl{;R"}J)7{y5Rte*m7J.Main.Content.__themedesigner.InvisMiddleSection
				Section["93"] = Instance.new("Frame", Section["12"]);
				Section["93"]["BorderSizePixel"] = 0;
				Section["93"]["BackgroundTransparency"] = 1;
				Section["93"]["Size"] = UDim2.new(1, 0, 0, 5);
				Section["93"]["Name"] = [[InvisMiddleSection]]
			end

			-- Logic (Colors)
			do
				local function colorPicker(scripte, colorVariable)
					local colourWheel = scripte.Parent:WaitForChild("ColourWheel")
					local wheelPicker = colourWheel:WaitForChild("Picker")
					local darknessPicker = scripte.Parent:WaitForChild("DarknessPicker")
					local darknessSlider = darknessPicker:WaitForChild("Slider")
					local colourDisplay = scripte.Parent:WaitForChild("ColourDisplay")
					local uis = game:GetService("UserInputService")
					local buttonDown = false
					local movingSlider = false

					local function updateColour(centreOfWheel)
						local colourPickerCentre = Vector2.new(
							colourWheel.Picker.AbsolutePosition.X + (colourWheel.Picker.AbsoluteSize.X/2),
							colourWheel.Picker.AbsolutePosition.Y + (colourWheel.Picker.AbsoluteSize.Y/2)
						)
						local h = (math.pi - math.atan2(colourPickerCentre.Y - centreOfWheel.Y, colourPickerCentre.X - centreOfWheel.X)) / (math.pi * 2)
						local s = (centreOfWheel - colourPickerCentre).Magnitude / (colourWheel.AbsoluteSize.X/2)
						local v = math.abs((darknessSlider.AbsolutePosition.Y - darknessPicker.AbsolutePosition.Y) / darknessPicker.AbsoluteSize.Y - 1)
						local hsv = Color3.fromHSV(math.clamp(h, 0, 1), math.clamp(s, 0, 1), math.clamp(v, 0, 1))
						colourDisplay.ImageColor3 = hsv
						darknessPicker.UIGradient.Color = ColorSequence.new{
							ColorSequenceKeypoint.new(0, hsv), 
							ColorSequenceKeypoint.new(1, Color3.new(0, 0, 0))
						}

						options[colorVariable] = hsv
						Section["2d"]["BackgroundColor3"] = options["Section_Background"];
						Section["38"]["BackgroundColor3"] = options["Background_Second"];
						Section["3a"]["BackgroundColor3"] = options["Background_Second"];
						Section["3b"]["BackgroundColor3"] = options["Background_Second"];
						Section["2a"]["BackgroundColor3"] = options["Background"];
						Section["1a"]["BackgroundColor3"] = options["Background"];
						Section["20"]["BackgroundColor3"] = options["Topbar"];
						Section["1e"]["BackgroundColor3"] = options["Topbar"];
					end

					colourWheel.MouseButton1Down:Connect(function()
						--GUI.CanDrag = false
						buttonDown = true
						--Tab["1b"]["ScrollingEnabled"] = false;
					end)

					darknessPicker.MouseButton1Down:Connect(function()
						--GUI.CanDrag = false;
						buttonDown = true
						movingSlider = true
						--Tab["1b"]["ScrollingEnabled"] = false;
					end)

					--[[ colourWheel.MouseButton1Up:Connect(function()
						GUI.CanDrag = true
						buttonDown = false
						Tab["1b"]["ScrollingEnabled"] = true;
					end)

					darknessPicker.MouseButton1Up:Connect(function()
						GUI.CanDrag = true
						--buttonDown = false
						movingSlider = false
						Tab["1b"]["ScrollingEnabled"] = true;
					end) --]]

					local InputEndeduis = nil
					InputEndeduis = uis.InputEnded:Connect(function(input)
						--if scriptrunning == true then

						if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) and buttonDown then
							buttonDown = false;movingSlider = false;--GUI.CanDrag = true
							--Tab["1b"]["ScrollingEnabled"] = true;
						end
						--else
						--	InputEndeduis:Disconnect()
						----end
					end)

					local toggled = false
					darknessPicker.Visible = false
					colourWheel.Visible = false
					colourDisplay.MouseButton1Click:Connect(function()	
						toggled = not toggled

						if toggled == true then
							darknessPicker.Visible = true
							colourWheel.Visible = true;GUI.CanDrag = false;Tab["1b"]["ScrollingEnabled"] = false

							Section["4a"].Visible = false
							Section["57"].Visible = false
							Section["64"].Visible = false
							Section["71"].Visible = false
							scripte.Parent.Visible = true
						else
							darknessPicker.Visible = false
							colourWheel.Visible = false;GUI.CanDrag = true;Tab["1b"]["ScrollingEnabled"] = true

							Section["4a"].Visible = true
							Section["57"].Visible = true
							Section["64"].Visible = true
							Section["71"].Visible = true
							scripte.Parent.Visible = true
						end
					end)

					local InputChangeduis = nil
					InputChangeduis = uis.InputChanged:Connect(function(input)
						if scriptrunning == true then
							if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then 
								if colourWheel.Visible == false then return end
								if darknessPicker.Visible == false then return end

								local mousePos = UIS:GetMouseLocation() - Vector2.new(0, game:GetService("GuiService"):GetGuiInset().Y)
								local centreOfWheel = Vector2.new(colourWheel.AbsolutePosition.X + (colourWheel.AbsoluteSize.X/2), colourWheel.AbsolutePosition.Y + (colourWheel.AbsoluteSize.Y/2))
								local distanceFromWheel = (mousePos - centreOfWheel).Magnitude

								if distanceFromWheel <= colourWheel.AbsoluteSize.X/2 and buttonDown then
									wheelPicker.Position = UDim2.new(0, mousePos.X - colourWheel.AbsolutePosition.X, 0, mousePos.Y - colourWheel.AbsolutePosition.Y)
								elseif movingSlider then
									darknessSlider.Position = UDim2.new(darknessSlider.Position.X.Scale, 0, 0, 
										math.clamp(
											mousePos.Y - darknessPicker.AbsolutePosition.Y, 
											0, 
											darknessPicker.AbsoluteSize.Y)
									)	
								end

								updateColour(centreOfWheel)
							end
						else
							InputChangeduis:Disconnect()
						end
					end)
				end
				-- StarterGui.Yl{;R"}J)7{y5Rte*m7J.Main.Content.__themedesigner.ThemeDesignerSection.PickTheme.Topbar.ColourWheelHandler
				Section["52"] = Instance.new("LocalScript", Section["4a"]);
				Section["52"]["Name"] = [[ColourWheelHandler]];
				local function C_52()
					colorPicker(Section["52"], "Topbar")
				end;
				task.spawn(C_52);
				-- StarterGui.Yl{;R"}J)7{y5Rte*m7J.Main.Content.__themedesigner.ThemeDesignerSection.PickTheme.Background.ColourWheelHandler
				Section["5f"] = Instance.new("LocalScript", Section["57"]);
				Section["5f"]["Name"] = [[ColourWheelHandler]];
				local function C_5f()
					colorPicker(Section["5f"], "Background")
				end;
				task.spawn(C_5f);
				-- StarterGui.Yl{;R"}J)7{y5Rte*m7J.Main.Content.__themedesigner.ThemeDesignerSection.PickTheme.Secondary Background.ColourWheelHandler
				Section["6c"] = Instance.new("LocalScript", Section["64"]);
				Section["6c"]["Name"] = [[ColourWheelHandler]];
				local function C_6c()
					colorPicker(Section["6c"], "Background_Second")
				end;
				task.spawn(C_6c);
				-- StarterGui.Yl{;R"}J)7{y5Rte*m7J.Main.Content.__themedesigner.ThemeDesignerSection.PickTheme.Section Background.ColourWheelHandler
				Section["79"] = Instance.new("LocalScript", Section["71"]);
				Section["79"]["Name"] = [[ColourWheelHandler]];
				local function C_79()
					colorPicker(Section["79"], "Section_Background")
				end;
				task.spawn(C_79);
			end

			-- Logic
			do
				Section["8e"]["Visible"] = false
				Section["8e"].MouseButton1Click:Connect(function()
					if Section["8e"]["Visible"] == true then
						Library.setTheme({
							Background = options["Background"],
							Background_Second = options["Background_Second"],
							Section_Background = options["Section_Background"],
							Topbar = options["Topbar"],
						}, true)
						oldnormalmessage("THEMES", "Custom Theme have been set.", 5)
					else

					end
				end)


				Section["45"].MouseButton1Click:Connect(function()
					local by = Section["89"]["Text"]
					local name = Section["81"]["Text"]
					if string.len(by) == 0 or by == " " or by == "" then Section["89"]["Text"] = "Unknown" end
					if string.len(name) == 0 or name == " " or name == "" then Section["81"]["Text"] = "Unknown's Theme" end
					Library.__themes_saveTheme(Section["81"]["Text"], Section["89"]["Text"], {
						Background = options["Background"],
						Background_Second = options["Background_Second"],
						Section_Background = options["Section_Background"],
						Topbar = options["Topbar"],
					}, false)
					Section["8e"]["Visible"] = true
				end)
			end

			Section.ResizeFunc = function()
				task.spawn(function()
					Section["15"].Size = UDim2.new(1, 0, 0, Section["17"].AbsoluteContentSize.Y + 10 - 30 + 200)
					task.wait()
					ResizeScrollingFrame(Tab["1b"] , Tab["22"], 26)
				end)
			end

			Section.ResizeFunc()

			Section.__delete = function()
				Section.ResizeFunc()
				pcall(function()
					Section["15"]:Destroy()
				end)
				pcall(function()
					Section["93"]:Destroy()
				end)
				for _,v in pairs(Tab["1b"]:GetChildren()) do
					if v.Name == options["Name"].."_theme" then
						v.Parent = nil
					end
					if v.Name == options["Name"].."_theme_invis" then
						v.Parent = nil
					end
				end
			end

			return Section
		end

		return Tab
	end

	Library.unload = function()
		spawn(function()
			task.wait(.265)
			GUI["4"]["Visible"] = false;GUI["19"]["Visible"] = false;GUI["e"]["Visible"] = false;
		end)
		Library:tween(GUI["2"], {Size = UDim2.new(0, 400, 0, 30)}, function()
			Library:tween(GUI["2"], {Size = UDim2.new(0, 0, 0, 30)}, function()
				scriptrunning = false;
				GUI["1"]:Destroy()
			end, TweenInfo.new(.35, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut))
		end, TweenInfo.new(.35, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut))
	end

	Library.vis_toggle = function()
		GUI["2"].Visible = not GUI["2"].Visible
	end

	Library.vis_show = function()
		GUI["2"].Visible = true
	end

	Library.vis_hide = function()
		GUI["2"].Visible = false
	end

	Library.toggle = function()
		Library.vis_show()
		if GUI.Minimize.Opened then
			spawn(function()
				task.wait(.265)
				GUI["4"]["Visible"] = false;GUI["19"]["Visible"] = false;GUI["e"]["Visible"] = false;
			end)
			Library:tween(GUI["2"], {Size = UDim2.new(0, 400, 0, 30)}, function()
				Library:tween(GUI["2"], {Size = UDim2.new(0, 200, 0, 30)}, function()
					GUI.Minimize.Opened = false
				end, TweenInfo.new(.35, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut))
			end, TweenInfo.new(.35, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut))
			--GUI["2"]["Size"] = UDim2.new(0, 400, 0, 300);
		else
			spawn(function()
				task.wait(.368)
				GUI["4"]["Visible"] = true;GUI["19"]["Visible"] = true;GUI["e"]["Visible"] = true;
			end)
			Library:tween(GUI["2"], {Size = UDim2.new(0, 400, 0, 30)}, function()
				Library:tween(GUI["2"], {Size = UDim2.new(0, 400, 0, 300)}, function()
					GUI.Minimize.Opened = true
				end, TweenInfo.new(.35, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut))
			end, TweenInfo.new(.35, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut))
		end
	end

	Library.show = function()
		Library.vis_show()
		if not GUI.Minimize.Opened then
			spawn(function()
				task.wait(.368)
				GUI["4"]["Visible"] = true;GUI["19"]["Visible"] = true;GUI["e"]["Visible"] = true;
			end)
			Library:tween(GUI["2"], {Size = UDim2.new(0, 400, 0, 30)}, function()
				Library:tween(GUI["2"], {Size = UDim2.new(0, 400, 0, 300)}, function()
					GUI.Minimize.Opened = true
				end, TweenInfo.new(.35, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut))
			end, TweenInfo.new(.35, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut))
		end
	end

	Library.hide = function()
		Library.vis_show()
		if GUI.Minimize.Opened then
			spawn(function()
				task.wait(.265)
				GUI["4"]["Visible"] = false;GUI["19"]["Visible"] = false;GUI["e"]["Visible"] = false;
			end)
			Library:tween(GUI["2"], {Size = UDim2.new(0, 400, 0, 30)}, function()
				Library:tween(GUI["2"], {Size = UDim2.new(0, 200, 0, 30)}, function()
					GUI.Minimize.Opened = false
				end, TweenInfo.new(.35, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut))
			end, TweenInfo.new(.35, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut))
			--GUI["2"]["Size"] = UDim2.new(0, 400, 0, 300);
		end
	end

	game:GetService("UserInputService").InputBegan:Connect(function(input, gpa)
		if input.KeyCode == Enum.KeyCode.RightShift and not UIS:GetFocusedTextBox() then
			Library.vis_toggle()
		end
	end)

	-- Themes
	local origincolors = {
		Background = Color3.fromRGB(49, 49, 49),
		Background_Second = Color3.fromRGB(66, 66, 66),
		Section_Background = Color3.fromRGB(59, 59, 59),
		Topbar = Color3.fromRGB(255, 0, 0)
	}

	Library.setTheme = function(colors, save)
		if typeof(colors) == "table" then
			local instances = {}

			for _,v in pairs(GUI["1"]:GetDescendants()) do
				task.spawn(function()
					if not v.Name:match("GUI_FAKE") then
						if has_property(v, "BackgroundColor3") then
							table.insert(instances, v)
						end
					end
				end)
			end

			if colors["Background"] then
				for _,v in pairs(instances) do
					task.spawn(function()
						if v:FindFirstChild("Background_Color") then
							v.BackgroundColor3 = colors["Background"]
						end
					end)
				end
				origincolors["Background"] = colors["Background"]
			end

			if colors["Background_Second"] then
				for _,v in pairs(instances) do
					task.spawn(function()
						if v:FindFirstChild("Background_Second_Color") then
							v.BackgroundColor3 = colors["Background_Second"]
						end
					end)
				end
				origincolors["Background_Second"] = colors["Background_Second"]
			end

			if colors["Section_Background"] then
				for _,v in pairs(instances) do
					task.spawn(function()
						if v:FindFirstChild("Section_Background_Color") then
							v.BackgroundColor3 = colors["Section_Background"]
						end
					end)
				end
				origincolors["Section_Background"] = colors["Section_Background"]
			end

			if colors["Topbar"] then
				for _,v in pairs(instances) do
					task.spawn(function()
						if v:FindFirstChild("Topbar_Color") then
							v.BackgroundColor3 = colors["Topbar"]
						end
					end)
				end
				origincolors["Topbar"] = colors["Topbar"]
			end

			if save == true then
				Library.__savetheme()
			end
		end
	end

	Library.__savetheme = function() end
	local loadOtherThemes = false
	local ThemesTab = GUI:CreateTab({
		Name = "__themedesigner",
		Icon = "rbxassetid://3926307971",
		IconSize = Vector2.new(36, 36),
		IconOffset = Vector2.new(804, 4),
		ShowAsLast = true
	})

	if isfolder and isfile and makefolder and writefile and delfile then
		local FOLDER_NAME = "POOPDOORS_EDITED_UI"
		local function checkdir() if not isfolder(FOLDER_NAME) then makefolder(FOLDER_NAME) end end
		checkdir()

		local themelist = {}	
		local CustomThemes = {}
		Library.__themes_loadTheme = function(name, deleteable)
			if isfile(FOLDER_NAME.."/"..name..".json") then
				local jsonecoded = readfile(FOLDER_NAME.."/"..name..".json")
				local flagsjson = game.HttpService:JSONDecode(jsonecoded)

				ThemesTab:__designertheme({
					Name = flagsjson["Name"],
					By = flagsjson["By"],
					Deleteable = deleteable or false,
					Background = from_hex(flagsjson["Background"]),
					Background_Second = from_hex(flagsjson["Background_Second"]),
					Section_Background = from_hex(flagsjson["Section_Background"]),
					Topbar = from_hex(flagsjson["Topbar"]),
				})

				table.insert(CustomThemes, name)
			end
		end

		Library.__themes_reloadThemesList = function()
			for _,r in pairs(CustomThemes) do
				for _,ve in pairs(ThemesTab["1b"]:GetChildren()) do
					if ve.Name == r.."_theme" then
						ve.Parent = nil
					end
					if ve.Name == r.."_theme_invis" then
						ve.Parent = nil
					end
				end
			end

			CustomThemes = {}
			themelist = {}
			for _,v in pairs(listfiles(FOLDER_NAME)) do
				if not v:match("currenttheme.json") then
					local filename = v
					filename = string.gsub(filename, FOLDER_NAME, "")
					filename = filename:sub(2)
					filename = string.gsub(filename, ".json", "")
					table.insert(themelist, filename)

					Library.__themes_loadTheme(filename, true)
					task.wait()
				end
				task.wait()
			end
		end

		Library.__themes_saveTheme = function(name, by, colors, replace)
			if typeof(colors) == "table" then
				if replace == nil then replace = false end

				local fileexists = isfile(FOLDER_NAME.."/"..name..".json")
				if not fileexists or replace == true then
					Library.setTheme(colors, false)
					local s,e
					repeat
						task.wait(.1)
						s,e = pcall(function()
							local oc = {
								Name = name,
								By = by,
								Background = to_hex(origincolors["Background"]),
								Background_Second = to_hex(origincolors["Background_Second"]),
								Section_Background = to_hex(origincolors["Section_Background"]),
								Topbar = to_hex(origincolors["Topbar"]),
							}
							local jsonencodedcolors = game.HttpService:JSONEncode(oc)
							writefile(FOLDER_NAME.."/"..name..".json", jsonencodedcolors)
						end)
					until not e and s
					Library.__themes_reloadThemesList()
					oldnormalmessage("THEMES", "Theme called '"..name.."' by '"..by.."' saved.", 5)
				end
			end
		end

		Library.__themes_deleteTheme = function(name)
			if isfile(FOLDER_NAME.."/"..name..".json") then
				local s,e
				repeat task.wait()
					s,e = pcall(function()
						delfile(FOLDER_NAME.."/"..name..".json")
					end)
				until not e and s
				oldnormalmessage("THEMES", "Theme called '"..name.."' deleted.", 5)
				Library.__themes_reloadThemesList()
			end
		end

		Library.__savetheme = function()
			local s,e
			repeat task.wait()
				s,e = pcall(function()
					local oc = {
						Background = to_hex(origincolors["Background"]),
						Background_Second = to_hex(origincolors["Background_Second"]),
						Section_Background = to_hex(origincolors["Section_Background"]),
						Topbar = to_hex(origincolors["Topbar"]),
					}
					local jsonencodedcolors = game.HttpService:JSONEncode(oc)
					writefile(FOLDER_NAME.."/currenttheme.json", jsonencodedcolors)
				end)
			until not e and s
		end

		Library.__loadtheme = function()
			if isfile(FOLDER_NAME.."/currenttheme.json") then
				local jsonecoded = readfile(FOLDER_NAME.."/currenttheme.json")
				local origcolo = game.HttpService:JSONDecode(jsonecoded)

				origcolo["Background"] = from_hex(origcolo["Background"])
				origcolo["Background_Second"] = from_hex(origcolo["Background_Second"])
				origcolo["Section_Background"] = from_hex(origcolo["Section_Background"])
				origcolo["Topbar"] = from_hex(origcolo["Topbar"])

				Library.setTheme(origcolo, false)
			end
		end

		ThemesTab:__customdesignertheme({
			Name = "Theme",
			By = game.Players.LocalPlayer.Name
		})

		task.wait()
		Library.__loadtheme()
		task.wait()
		task.spawn(function()
			Library.__themes_reloadThemesList()
			loadOtherThemes = true
		end)
	else

		loadOtherThemes = true
	end

	task.spawn(function()		
		repeat task.wait(.1) until loadOtherThemes == true or loadOtherThemes == nil

		ThemesTab:__designertheme({
			Name = "Default Theme",
			By = "mstudio45#5590",
			Deleteable = false,
		})
		ThemesTab:__designertheme({
			Name = "Blue Theme",
			By = "mstudio45#5590",
			Deleteable = false,
			Background = Color3.fromRGB(49, 49, 49),
			Background_Second = Color3.fromRGB(66, 66, 66),
			Section_Background = Color3.fromRGB(59, 59, 59),
			Topbar = Color3.fromRGB(85, 85, 255)
		})
		ThemesTab:__designertheme({
			Name = "Green Theme",
			By = "mstudio45#5590",
			Deleteable = false,
			Background = Color3.fromRGB(49, 49, 49),
			Background_Second = Color3.fromRGB(66, 66, 66),
			Section_Background = Color3.fromRGB(59, 59, 59),
			Topbar = Color3.fromRGB(0, 170, 0)
		})
	end)

	return GUI
end

return Library
