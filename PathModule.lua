local PathModule = {}
local PathfindingService = game:GetService("PathfindingService")
local VisualizerFolder = game.Workspace:FindFirstChild("PDVisualizer")
if VisualizerFolder == nil then
	VisualizerFolder = Instance.new("Folder", workspace)
	VisualizerFolder.Name = "PDVisualizer"
end
VisualizerFolder:ClearAllChildren()

local VisualizeColors = {
	Normal = Color3.fromRGB(255, 139, 0),
	Jump = Color3.fromRGB(255, 0, 0),
	Finish = Color3.fromRGB(0, 255, 0)
}

function PathModule.visualize(waypoints)
	for _, waypoint in ipairs(waypoints) do
		local visualWaypointClone = Instance.new("Part")
		visualWaypointClone.Size = Vector3.new(0.3, 0.3, 0.3)
		visualWaypointClone.Anchored = true
		visualWaypointClone.CanCollide = false
		visualWaypointClone.Material = Enum.Material.Neon
		visualWaypointClone.Shape = Enum.PartType.Ball
		visualWaypointClone.Position = waypoint.Position + Vector3.new(0, 3, 0)
		visualWaypointClone.Parent = VisualizerFolder
		visualWaypointClone.Color =
			(
				waypoint == waypoints[#waypoints] and VisualizeColors.Finish
				or (waypoint == waypoints[#waypoints-1] and VisualizeColors.Finish)
				or (waypoint == waypoints[#waypoints-2] and VisualizeColors.Finish)
				or (waypoint.Action == Enum.PathWaypointAction.Jump and VisualizeColors.Jump)
				or VisualizeColors.Normal
			)
	end
end
function PathModule.new(char, goal, agentParameters, jumpingAllowed, offset)
	if not (char and char:IsA("Model") and char.PrimaryPart) then return end
	if not PathfindingService then PathfindingService = game:GetService("PathfindingService") end 

	local Path = PathfindingService:CreatePath(agentParameters or {})
	local HRP = char:FindFirstChild("HumanoidRootPart")
	local Humanoid = char:FindFirstChildWhichIsA("Humanoid")

	if not HRP then HRP = char.PrimaryPart end
	if jumpingAllowed == nil or typeof(jumpingAllowed) ~= "boolean" then jumpingAllowed = false end

	local waypoints

	pcall(function() HRP:SetNetworkOwner(nil) end)

	local Success, ErrorMessage = pcall(function()
		if offset then
			Path:ComputeAsync(HRP.Position - offset, goal)
		else
			Path:ComputeAsync(HRP.Position, goal)
		end
	end)

	if Success and Path.Status == Enum.PathStatus.Success then 
		waypoints = Path:GetWaypoints()
		PathModule.visualize(waypoints)

		for i, v in pairs(waypoints) do
			if POOPDOORSLOADED == false then return end
			if not v then return end

			if plr.Character.HumanoidRootPart.Anchored ~= true then
				if jumpingAllowed == true then if v.Action == Enum.PathWaypointAction.Jump then Humanoid:ChangeState(Enum.HumanoidStateType.Jumping) end end
				Humanoid:MoveTo(v.Position)
				Humanoid.MoveToFinished:Wait()
			end
		end

		VisualizerFolder:ClearAllChildren()
		return true
	else
		return false
	end
end
return PathModule
