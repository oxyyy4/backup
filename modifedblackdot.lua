-- Modifed By NoxyL#0001

repeat
	wait()
until game.Players.LocalPlayer.Character:FindFirstChild("FULLY_LOADED_CHAR")

local Notif = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()
local CC = game:GetService'Workspace'.CurrentCamera
local Plr
local enabled = false
local mouse = game.Players.LocalPlayer:GetMouse()
local placemarker = Instance.new("Part", game.Workspace)
local guimain = Instance.new("Folder", game.CoreGui)

_G.blockyes = {
	Block = Enum.PartType.Block,
	Ball = Enum.PartType.Ball
}

local Tracer = Instance.new("Part", game.Workspace)
Tracer.Name = "wow"	
Tracer.Anchored = true		
Tracer.CanCollide = false
Tracer.Transparency = 0.3
Tracer.Parent = game.Workspace	
Tracer.Shape = _G.blockyes.Block
Tracer.Size = Vector3.new(6, 6, 6)
Tracer.Color = Color3.fromRGB(162, 69, 255)

local Cylind = Instance.new("Part", game.Workspace)
Cylind.Name = "ppw"	
Cylind.Anchored = true		
Cylind.CanCollide = false
Cylind.Transparency = 0.3
Cylind.Parent = game.Workspace	
Cylind.Shape = _G.blockyes.Ball
Cylind.Size = Vector3.new(3, 3, 3)
Cylind.Color = Color3.fromRGB(90, 90, 90)


function makemarker(Parent, Adornee, Color, Size, Size2)
	local e = Instance.new("BillboardGui", Parent)
	e.Name = "PP"
	e.Adornee = Adornee
	e.Size = UDim2.new(Size, Size2, Size, Size2)
	e.AlwaysOnTop = true
	local a = Instance.new("Frame", e)
	a.Size = UDim2.new(1, 0, 1, 0)
	a.BackgroundTransparency = 0.4
	a.BackgroundColor3 = Color
	local g = Instance.new("UICorner", a)
	g.CornerRadius = UDim.new(30, 30)
	return(e)
end

local data = game.Players:GetPlayers()
function noob(player)
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

Notif:MakeNotification({
	Name = "Warning!",
	Content = "This Is Just Modifed Of Black Dot. Modifed By NoxyL#0001",
	Image = "rbxassetid://2022095896",
	Time = 20
})

if getgenv().alreadyloaded == true then
	Notif:MakeNotification({
		Name = "Warning!",
		Content = "Black Dot Has Already Loaded",
		Image = "rbxassetid://2022095896",
		Time = 7
	})
	return
end

getgenv().alreadyloaded = true

for i = 1, #data do
	if data[i] ~= game.Players.LocalPlayer then
		noob(data[i])
	end
end

game.Players.PlayerAdded:connect(function(Player)
	noob(Player)
end)

game.Players.PlayerRemoving:Connect(function(player)
	guimain[player.Name]:Destroy()
end)

spawn(function()
	placemarker.Anchored = true
	placemarker.CanCollide = false
	placemarker.Size = Vector3.new(0.1, 0.1, 0.1)
	placemarker.Transparency = 10
	makemarker(placemarker, placemarker, Color3.fromRGB(90, 90, 90), 0.55, 0)
end)   

mouse.KeyDown:Connect(function(k)
	if k ~= getgenv().Keybind then return end  -- Keybind
	if enabled then
		enabled = false
		Notif:MakeNotification({
			Name = "Black Dot",
			Content = "Unlocked!",
			Image = "rbxassetid://6719192210",
			Time = 5
		})
		if getgenv().ChatNotif then
			local bbbb = "Unlocked!" local bbbb2 = "All" local Event = game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest Event:FireServer(bbbb, bbbb2) 
		end	
	else
		enabled = true 
		Plr = getClosestPlayerToCursor()
		Notif:MakeNotification({
			Name = "Black Dot",
			Content = "Locked: "..tostring(Plr.Character.Humanoid.DisplayName),
			Image = "rbxassetid://6719192210",
			Time = 5
		})
		if getgenv().ChatNotif then
			local bbb = "Locked: "..tostring(Plr.Character.Humanoid.DisplayName) local bbb2 = "All" local Event = game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest Event:FireServer(bbb, bbb2) 
		end	
	end    
end)

function getClosestPlayerToCursor()
	local closestPlayer
	local shortestDistance = math.huge

	for i, v in pairs(game.Players:GetPlayers()) do
		if v ~= game.Players.LocalPlayer and v.Character and v.Character:FindFirstChild("Humanoid") and v.Character.Humanoid.Health ~= 0 and v.Character:FindFirstChild("Head") then
			local pos = CC:WorldToViewportPoint(v.Character.PrimaryPart.Position)
			local magnitude = (Vector2.new(pos.X, pos.Y) - Vector2.new(mouse.X, mouse.Y)).magnitude
			if magnitude < shortestDistance then
				closestPlayer = v
				shortestDistance = magnitude
			end
		end
	end
	return closestPlayer
end

game:GetService"RunService".Stepped:connect(function()
	if getgenv().Part then
		if enabled and Plr.Character and Plr.Character:FindFirstChild(getgenv().Hitbox) then
			Tracer.CFrame = CFrame.new(Plr.Character[getgenv().Hitbox].Position+(Plr.Character[getgenv().Hitbox].Velocity*getgenv().Prediction))
		else
			Tracer.CFrame = CFrame.new(0, 9999, 0)
		end
	end
end)

game:GetService"RunService".Stepped:connect(function()
	if getgenv().PartBall then
		if enabled and Plr.Character and Plr.Character:FindFirstChild(getgenv().Hitbox) then
			Cylind.CFrame = CFrame.new(Plr.Character[getgenv().Hitbox].Position+(Plr.Character[getgenv().Hitbox].Velocity*getgenv().Prediction))
		else
			Cylind.CFrame = CFrame.new(0, 9999, 0)
		end
	end
end)

game:GetService"RunService".Stepped:connect(function()
	if enabled and Plr.Character and Plr.Character:FindFirstChild(getgenv().Hitbox) then
		placemarker.CFrame = CFrame.new(Plr.Character[getgenv().Hitbox].Position+(Plr.Character[getgenv().Hitbox].Velocity*getgenv().Prediction))
	else
		placemarker.CFrame = CFrame.new(0, 9999, 0)
	end
end)

local mt = getrawmetatable(game)
local old = mt.__namecall
setreadonly(mt, false)
mt.__namecall = newcclosure(function(...)
	local args = {...}
	if enabled and getnamecallmethod() == "FireServer" and args[2] == "UpdateMousePos" then
		args[3] = Plr.Character[getgenv().Hitbox].Position+(Plr.Character[getgenv().Hitbox].Velocity*getgenv().Prediction)
		return old(unpack(args))
	end
	return old(...)
end)

-- Thanks For The Sets 

while wait() do
	if getgenv().AutoPrediction == true then
		local pingvalue = game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValueString()
		local split = string.split(pingvalue,'(')
		local ping = tonumber(split[1])
		if ping < 130 then
			getgenv().Prediction = 0.151
		elseif ping < 125 then
			getgenv().Prediction = 0.149
		elseif ping < 110 then
			getgenv().Prediction = 0.140
		elseif ping < 105 then
			getgenv().Prediction = 0.133
		elseif ping < 90 then
			getgenv().Prediction = 0.130
		elseif ping < 80 then
			getgenv().Prediction = 0.128
		elseif ping < 70 then
			getgenv().Prediction = 0.1230
		elseif ping < 60 then
			getgenv().Prediction = 0.1229
		elseif ping < 50 then
			getgenv().Prediction = 0.1225
		elseif ping < 40 then
			getgenv().Prediction = 0.1256
		end
	end
end
