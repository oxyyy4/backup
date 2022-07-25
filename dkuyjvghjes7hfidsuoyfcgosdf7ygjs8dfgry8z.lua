repeat
	wait()
until game.Players.LocalPlayer.Character:FindFirstChild("FULLY_LOADED_CHAR")

-- MAIN CODE

local Enabled = false
local CurrentCamera = game:GetService "Workspace".CurrentCamera
local Mouse = game.Players.LocalPlayer:GetMouse()
local RunService = game:GetService("RunService")
local plr = game.Players.LocalPlayer
local localplayer = game.Players.LocalPlayer
local placemarker = Instance.new("Part", game.Workspace)
local guimain = Instance.new("Folder", game.CoreGui)


getgenv().Block = {
    FakeHitbox = Enum.PartType.Block
}

local LockTracer = Instance.new("Part", game.Workspace)
LockTracer.Name = "wow"	
LockTracer.Anchored = true		
LockTracer.CanCollide = false
LockTracer.Transparency = 0.3
LockTracer.Parent = game.Workspace	
LockTracer.Shape = getgenv().Block.FakeHitbox
LockTracer.Size = Vector3.new(6, 6, 6)
LockTracer.Color = Color3.fromRGB(187, 187, 187)

function makemarker(Parent, Adornee, Color, Size, Size2)
	local police = Instance.new("BillboardGui", Parent)
	police.Name = "PP"
	police.Adornee = Adornee
	police.Size = UDim2.new(Size, Size2, Size, Size2)
	police.AlwaysOnTop = true
	local whyimscarednow = Instance.new("Frame", police)
	whyimscarednow.Size = UDim2.new(1, 0, 1, 0)
	whyimscarednow.BackgroundTransparency = 0.4
	whyimscarednow.BackgroundColor3 = Color
	local crim = Instance.new("UICorner", whyimscarednow)
	crim.CornerRadius = UDim.new(30, 30)
	return(police)
end

local data = game.Players:GetPlayers()
function wewewewew(player)
	local character
	repeat wait() until player.Character
	local handler = makemarker(guimain, player.Character:WaitForChild("LowerTorso"), Color3.fromRGB(0, 76, 153), 0.0, 0)
	handler.Name = player.Name
	player.CharacterAdded:connect(function(Char) handler.Adornee = Char:WaitForChild("LowerTorso") end)

	local TextLabel = Instance.new("TextLabel", handler)
	TextLabel.BackgroundTransparency = 1
	TextLabel.Position = UDim2.new(0, 0, 0, -50)
	TextLabel.Size = UDim2.new(0, 100, 0, 100)
	TextLabel.Font = Enum.Font.SourceSansSemibold
	TextLabel.TextSize = 14
	TextLabel.TextColor3 = Color3.new(1, 1, 1)
	TextLabel.TextStrokeTransparency = 0
	TextLabel.TextYAlignment = Enum.TextYAlignment.Bottom
	TextLabel.Text = 'Name: '..player.Name
	TextLabel.ZIndex = 10

	spawn(function()
		while wait() do
			if player.Character then
				--TextLabel.Text = player.Name.." | Bounty: "..tostring(player:WaitForChild("leaderstats").Wanted.Value).." | "..tostring(math.floor(player.Character:WaitForChild("Humanoid").Health))
			end
		end
	end)
end

for i = 1, #data do
	if data[i] ~= game.Players.LocalPlayer then
		wewewewew(data[i])
	end
end

game.Players.PlayerAdded:connect(function(Player)
	wewewewew(Player)
end)

game.Players.PlayerRemoving:Connect(function(player)
	guimain[player.Name]:Destroy()
end)

game.StarterGui:SetCore("SendNotification", {
    Title = "Yeat.cc";
    Text = "Yeat.cc Is Loaded"
 })

if getgenv().dumbass == true then
    game.StarterGui:SetCore("SendNotification", {
       Title = "Yeat.cc";
       Text = "Yeat.cc Is Already Loaded"
    })
end

getgenv().dumbass = true

spawn(function()
	placemarker.Anchored = true
	placemarker.CanCollide = false
	placemarker.Size = Vector3.new(0.1, 0.1, 0.1)
	placemarker.Transparency = 10
	makemarker(placemarker, placemarker, Color3.fromRGB(255, 255, 255), 0.55, 0)
end)   

Mouse.KeyDown:Connect(function(Pressed)
    if Pressed ~= getgenv().Keybind then
        return
    end
        if Enabled then
        Enabled = false
         game.StarterGui:SetCore("SendNotification", {
            Title = "Yeat.cc";
            Text = "Unlocked"
         })
         if getgenv().Spectate == true then
            game.Workspace.CurrentCamera.CameraSubject = game.Players.LocalPlayer.Character
        end
        else
            Enabled = true
            plr = FindClosestUser()
                Enabled = true
                game.StarterGui:SetCore("SendNotification", {
                    Title = "Yeat.cc";
                    Text = "Locked: "..tostring(plr.Character.Humanoid.DisplayName);
                 })
                 if getgenv().Spectate == true then
                    game.Workspace.CurrentCamera.CameraSubject = plr.Character
                end
                if getgenv().TeleportAim == true then
                    localplayer.Character.HumanoidRootPart.CFrame = plr.Character.HumanoidRootPart.CFrame
                end
    end
end)

function FindClosestUser()
    local closestPlayer
	local shortestDistance = math.huge

	for i, v in pairs(game.Players:GetPlayers()) do
		if v ~= game.Players.LocalPlayer and v.Character and v.Character:FindFirstChild("Humanoid") and v.Character.Humanoid.Health ~= 0 and v.Character:FindFirstChild("Head") then
			local pos = CurrentCamera:WorldToViewportPoint(v.Character.PrimaryPart.Position)
			local magnitude = (Vector2.new(pos.X, pos.Y) - Vector2.new(Mouse.X, Mouse.Y)).magnitude
			if magnitude < shortestDistance then
				closestPlayer = v
				shortestDistance = magnitude
			end
		end
	end
	return closestPlayer
end

local mt = getrawmetatable(game)
local old = mt.__namecall
setreadonly(mt, false)
mt.__namecall = newcclosure(function(...)
    local args = {...}
    if Enabled and getnamecallmethod() == "FireServer" and args[2] == "UpdateMousePos" then
        args[3] = plr.Character[getgenv().Part].Position +
                      (plr.Character[getgenv().Part].Velocity * getgenv().Prediction)
        return old(unpack(args))
    end
    return old(...)
end)

game:GetService"RunService".Stepped:connect(function()
	if Enabled and plr.Character and plr.Character:FindFirstChild(getgenv().Part) then
		placemarker.CFrame = CFrame.new(plr.Character[getgenv().Part].Position+(plr.Character[getgenv().Part].Velocity*getgenv().Prediction))
	else
		placemarker.CFrame = CFrame.new(0, 9999, 0)
	end
end)

game:GetService"RunService".Stepped:connect(function()
    if getgenv().Part then
		if Enabled and plr.Character and plr.Character:FindFirstChild(getgenv().Part) then
			LockTracer.CFrame = CFrame.new(plr.Character[getgenv().Part].Position+(plr.Character[getgenv().Part].Velocity*getgenv().Prediction))
		else
			LockTracer.CFrame = CFrame.new(0, 9999, 0)
		end
	end
end)

if getgenv().AirshotFunc == true then
    if plr.Character.Humanoid.Jump == true and plr.Character.Humanoid.FloorMaterial == Enum.Material.Air then
        getgenv().Part = getgenv().AirshotPart
    else
        plr.Character:WaitForChild("Humanoid").StateChanged:Connect(function(old,new)
            if new == Enum.HumanoidStateType.Freefall then
                getgenv().Part = getgenv().AirshotPart
            else
                getgenv().Part =  getgenv().Part
            end
        end)
    end
end
