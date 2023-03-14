
-- by sponguss, i just fixed some stuff
local v1 = game.Players.LocalPlayer.PlayerGui:FindFirstAncestor("MainUI");
local l__EntityInfo__2 = game:GetService("ReplicatedStorage"):WaitForChild("EntityInfo");
local l__TweenService__1 = game:GetService("TweenService");
function seekintro(p1)
	if not workspace:FindFirstChild("SeekMoving", true) then
		warn("cant find elevator!");
		return;
	end;
	local l__SeekMoving__3 = workspace:FindFirstChild("SeekMoving", true);
	local l__PrimaryPart__4 = l__SeekMoving__3.PrimaryPart;
	p1.stopcam = true;
	p1.freemouse = true;
	p1.hideplayers = -1;
	p1.update();
	for v5, v6 in pairs(l__SeekMoving__3:GetDescendants()) do
		if v6.Name == "StringCheese" then
			v6.Enabled = true;
			delay(6 + math.random(1, 50) / 100, function()
				l__TweenService__1:Create(v6, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In, 0, false, 0), {
					Width1 = 0, 
					CurveSize0 = -2
				}):Play();
				l__TweenService__1:Create(v6, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In, 0, false, 0.1), {
					Width0 = 0, 
					CurveSize1 = -2
				}):Play();
				wait(0.2);
				v6.Enabled = false;
			end);
		end;
	end;
	local l__CamPos1__7 = l__PrimaryPart__4:FindFirstChild("CamPos1", true);
	local l__CamPos2__8 = l__PrimaryPart__4:FindFirstChild("CamPos2", true);
	local l__CamPos3__9 = l__PrimaryPart__4:FindFirstChild("CamPos2", true);
	local l__CamPos4__10 = l__PrimaryPart__4:FindFirstChild("CamPos2", true);
	local l__CamPos5__11 = l__PrimaryPart__4:FindFirstChild("CamPos2", true);
	local l__CamPos6__12 = l__PrimaryPart__4:FindFirstChild("CamPos2", true);
	local l__CFrame__13 = p1.cam.CFrame;
	local v14 = tick() + 1;
	local l__FieldOfView__15 = p1.cam.FieldOfView;
	p1.camShaker:ShakeOnce(12, 0.5, 2, 10);
	for v16 = 1, 100000 do
		task.wait();
		local v17 = l__TweenService__1:GetValue((1 - math.abs(tick() - v14)) / 1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut);
		if not (tick() <= v14) then
			break;
		end;
		p1.cam.CFrame = l__CFrame__13:Lerp(l__CamPos1__7.WorldCFrame, v17) * p1.csgo;
		p1.cam.FieldOfView = l__FieldOfView__15 + (p1.fovspring - l__FieldOfView__15) * v17;
	end;
	l__TweenService__1:Create(p1.cam, TweenInfo.new(2, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
		FieldOfView = 30
	}):Play();
	p1.camShaker:ShakeOnce(9, 0.5, 0.5, 7, (Vector3.new(0.1, 0.1, 0.1)));
	p1.camShaker:ShakeOnce(2, 3, 1, 12);
	local l__WorldCFrame__18 = l__CamPos1__7.WorldCFrame;
	local l__WorldCFrame__19 = l__CamPos2__8.WorldCFrame;
	local v20 = tick() + 2;
	l__TweenService__1:Create(p1.cam, TweenInfo.new(4, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
		FieldOfView = 60
	}):Play();
	for v21 = 1, 100000 do
		if not (tick() <= v20) then
			break;
		end;
		p1.cam.CFrame = l__CamPos1__7.WorldCFrame:Lerp(l__CamPos2__8.WorldCFrame, (l__TweenService__1:GetValue((2 - math.abs(tick() - v20)) / 2, Enum.EasingStyle.Sine, Enum.EasingDirection.In))) * p1.csgo;
		task.wait();
	end;
	local l__WorldCFrame__22 = l__CamPos3__9.WorldCFrame;
	local l__WorldCFrame__23 = l__CamPos4__10.WorldCFrame;
	local v24 = tick() + 3.4;
	p1.cam.FieldOfView = 45;
	for v25 = 1, 100000 do
		if not (tick() <= v24) then
			break;
		end;
		p1.cam.CFrame = l__WorldCFrame__22:Lerp(l__WorldCFrame__23, (l__TweenService__1:GetValue((3.4 - math.abs(tick() - v24)) / 3.4, Enum.EasingStyle.Linear, Enum.EasingDirection.In))) * p1.csgo;
		task.wait();
	end;
	local l__WorldCFrame__26 = l__CamPos5__11.WorldCFrame;
	local l__WorldCFrame__27 = l__CamPos6__12.WorldCFrame;
	local v28 = tick() + 1.2;
	p1.cam.FieldOfView = 60;
	for v29 = 1, 100000 do
		if not (tick() <= v28) then
			break;
		end;
		p1.cam.CFrame = l__WorldCFrame__26:Lerp(l__WorldCFrame__27, (l__TweenService__1:GetValue((1.2 - math.abs(tick() - v28)) / 1.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out))) * p1.csgo;
		task.wait();
	end;
	local v30, v31, v32 = CFrame.new(Vector3.new(0, 0, 0), l__PrimaryPart__4.CFrame.LookVector):ToOrientation();
	if math.abs(p1.ax - math.deg(v31)) > 180 then
		p1.ax_t = p1.ax_t - 360;
	end;
	p1.ax_t = math.deg(v31);
	local l__CFrame__33 = p1.cam.CFrame;
	local v34 = tick() + 1;
	local l__FieldOfView__35 = p1.cam.FieldOfView;
	for v36 = 1, 100000 do
		task.wait();
		local v37 = l__TweenService__1:GetValue((1 - math.abs(tick() - v34)) / 1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut);
		if not (tick() <= v34) then
			break;
		end;
		p1.cam.CFrame = l__CFrame__33:Lerp(p1.basecamcf, v37) * p1.csgo;
		p1.cam.FieldOfView = l__FieldOfView__35 + (p1.fovspring - l__FieldOfView__35) * v37;
	end;
	p1.chaseMove = true;
	p1.stopcam = false;
	p1.freemouse = false;
	p1.hideplayers = 1;
	p1.update();
end;

return function(_,CanEntityKill)
	local SpawnerLibrary = {
		Tween = function(object, input, studspersecond, offset)
			local char = game:GetService("Players").LocalPlayer.Character;
			local input = input or error("input is nil");
			local studspersecond = studspersecond or 1000;
			local offset = offset or CFrame.new(0,0,0);
			local vec3, cframe;

			if typeof(input) == "table" then
				vec3 = Vector3.new(unpack(input)); cframe = CFrame.new(unpack(input));
			elseif typeof(input) ~= "Instance" then
				return error("wrong format used");
			end;

			local Time = (object.Value.Position - (vec3 or input.Position)).magnitude/studspersecond;

			local twn = game.TweenService:Create(object, TweenInfo.new(Time,Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {Value = (cframe or input.CFrame) * offset});
			twn:Play();
			twn.Completed:Wait()
		end;

		Calculate = function()
			local t = 0
			local Earliest = game.ReplicatedStorage.GameData.LatestRoom.Value-3
			if not workspace.CurrentRooms:FindFirstChild(tostring(Earliest)) then
 				Earliest = game.ReplicatedStorage.GameData.LatestRoom.Value-2
				if not workspace.CurrentRooms:FindFirstChild(tostring(Earliest)) then
					Earliest = game.ReplicatedStorage.GameData.LatestRoom.Value-1
					if not workspace.CurrentRooms:FindFirstChild(tostring(Earliest)) then
						Earliest = game.ReplicatedStorage.GameData.LatestRoom.Value
					end
				end
			end
			local Latest = game.ReplicatedStorage.GameData.LatestRoom.Value

			for _,Room in ipairs(workspace.CurrentRooms:GetChildren()) do
				t += 1
				if Room:FindFirstChild("RoomStart") and tonumber(Room.Name) == game.ReplicatedStorage.GameData.LatestRoom.Value then
					Earliest = tonumber(Room.Name)
					break;
				end
			end

			return workspace.CurrentRooms[Earliest], workspace.CurrentRooms[Latest]
		end
	}
	local Spawner = {}
	local firgur=nil
	local Entities = {
		Seek = {
			Model = nil,
			Func = function(Rooms, Kill)
				game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored=true
				Kill = Kill and Kill or false
				Rooms = Rooms and tonumber(Rooms) or 15
				local u2 = require(game.Players.LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game)

				workspace.Ambience_Seek.TimePosition = 0
				workspace["Ambience_Seek"]:Play()

				firgur = game:GetObjects("rbxassetid://10829142080")[1]

				firgur.Figure.Anchored = true
				firgur.Parent = workspace

				local val = Instance.new("CFrameValue")

				val.Changed:Connect(function()
					firgur.SeekRig:PivotTo(val.Value)
				end)

				local early, latest = SpawnerLibrary.Calculate()

				val.Value = early.Base.CFrame + Vector3.new(0,7,0)

				local anim = Instance.new("Animation")
				anim.AnimationId = "rbxassetid://9896641335"

				firgur.SeekRig.AnimationController:LoadAnimation(anim):Play()

				local orig = game.Players.LocalPlayer.Character.Humanoid.WalkSpeed
				game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 0
				
				local footon =firgur.Figure.Footsteps
				local foottwo=firgur.Figure.FootstepsFar	
				local knoccook=firgur.Figure.Knock					
				task.spawn(function()
					footon:Stop()
					foottwo:Stop()
					task.wait(4.95)
					footon:Play()
					foottwo:Play()
				end)
				
				pcall(function()
					--require(game:GetService("Players").LocalPlayer.PlayerGui.MainUI.Initiator["Main_Game"].RemoteListener.Cutscenes.SeekIntro)
					seekintro(u2)
				end)

				local anim = Instance.new("Animation")
				anim.AnimationId = "rbxassetid://7758895278"

				firgur.SeekRig.AnimationController:LoadAnimation(anim):Play()

				local chase = true

				coroutine.wrap(function()
					while task.wait(.2) do
						if chase then
							game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 20.5
							if math.random(1,100) == 95 then
								firgur.Figure.Scream:Play()
							end
						end
					end
				end)()

				game.Players.LocalPlayer.Character.HumanoidRootPart.Anchored=false
				if CanEntityKill then
					local touched=false
					firgur.Figure.Hitbox.Size = Vector3.new(22.5,22.5,22.5)
					firgur.Figure.Hitbox.Touched:Connect(function(t)
						if t.Parent==game.Players.LocalPlayer.Character and touched==false then
							touched=true
							local jumpscare=game.Players.LocalPlayer.PlayerGui.MainUI.Jumpscare.Jumpscare_Seek
							local jumpscareSound=game.Players.LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game.RemoteListener.Jumpscare_Seek
							jumpscareSound:Play()
							jumpscare.Visible=true
							repeat task.wait() until jumpscareSound.Playing==false
							game.Players.LocalPlayer.Character.Humanoid.Health=0
							jumpscare.Visible=false
							game:GetService("ReplicatedStorage").GameStats["Player_".. game.Players.LocalPlayer.Name].Total.DeathCause.Value = "Seek"
							debug.setupvalue(getconnections(game:GetService("ReplicatedStorage").EntityInfo.DeathHint.OnClientEvent)[1].Function, 1, {
								"You were caught by Seek...", "The obstacles have crawlspaces. Crouch into them! The lights shall guide you."
							})
						end
					end)
				end
				for i = 1,15 do
					for i,v in ipairs(workspace.CurrentRooms:GetChildren()) do
						if tonumber(v.Name) < tonumber(early.Name) then continue end
						if v:GetAttribute("lol") then continue end
						--if v:FindFirstChild("Nodes") then
							v:SetAttribute("lol", true)
							require(game:GetService("ReplicatedStorage").ClientModules.EntityModules.Seek).tease(nil, v, 14, 1665596753, true)
						--for i,v in ipairs(v.Nodes:GetChildren()) do
						local part = Instance.new("Part", workspace)
						part.Anchored = true
						part.CanCollide = false
						part.Transparency = 1
						part.Position = v.Base.Position + Vector3.new(0,3,0)
						SpawnerLibrary.Tween(val, part, 18.5, CFrame.new(0,5,0))
						part:Destroy()
							--end
						--end
					end
				end

				chase = false
				task.wait()
				
				knoccook:Play()
				task.wait(2.5)
				firgur:Destroy()

				game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = orig
				workspace.Ambience_Seek.TimePosition = 92.5

				task.wait(4)
				u2.hideplayers = 0
			end,
		}
	}

	function Spawner:Spawn(Entity, ...)
		local Args = {...}

		print(Entity)

		for Name,List in pairs(Entities) do
			print(Name)
			if Name == Entity then
				List["Func"](unpack(Args))
			end
		end
	end

	task.spawn(function() Spawner:Spawn("Seek", unpack({})) end)
	repeat task.wait() until firgur~=nil
	return firgur
end
