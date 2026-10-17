-- [[ Astro Hub V21 - Private & Clean Edition ]] --
-- [[ Key System Enabled ]] --

if setfpscap then
    setfpscap(240)
end

local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local Stats = game:GetService("Stats")
local Workspace = game:GetService("Workspace")
local TeleportService = game:GetService("TeleportService")
local SoundService = game:GetService("SoundService")
local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera

-- 🛡️ تصفير وإيقاف كامل لجميع العمليات والحلقات السابقة
getgenv().AstroRunning = false
getgenv().AimbotConnection = nil
getgenv().NoclipConnection = nil
getgenv().InfJumpConnection = nil
getgenv().SpeedConnection = nil

local function KillAllConnections()
    getgenv().AstroRunning = false
    
    if getgenv().AimbotConnection then getgenv().AimbotConnection:Disconnect() getgenv().AimbotConnection = nil end
    if getgenv().NoclipConnection then getgenv().NoclipConnection:Disconnect() getgenv().NoclipConnection = nil end
    if getgenv().InfJumpConnection then getgenv().InfJumpConnection:Disconnect() getgenv().InfJumpConnection = nil end
    if getgenv().SpeedConnection then getgenv().SpeedConnection:Disconnect() getgenv().SpeedConnection = nil end
    
    if LocalPlayer.Character then
        local hum = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if hum then hum.PlatformStand = false end
        local hrp = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if hrp then
            for _, v in pairs(hrp:GetChildren()) do
                if v:IsA("BodyVelocity") or v:IsA("BodyGyro") then v:Destroy() end
            end
        end
    end

    for _, obj in pairs(Workspace:GetDescendants()) do
        if obj.Name == "AstroHighlight" or obj.Name == "AstroEggHighlight" or obj.Name == "AstroBossHighlight" or obj.Name == "AstroBossTag" then
            obj:Destroy()
        end
    end

    if LocalPlayer.Character then
        for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
            if part:IsA("BasePart") then part.CanCollide = true end
        end
    end
end

KillAllConnections()

if CoreGui:FindFirstChild("AstroHubGui") then
    CoreGui.AstroHubGui:Destroy()
end
if CoreGui:FindFirstChild("AstroKeyGui") then
    CoreGui.AstroKeyGui:Destroy()
end

getgenv().AutoReconnectState = false
CoreGui.RobloxPromptGui.promptOverlay.ChildAdded:Connect(function(child)
    if child.Name == 'ErrorPrompt' and getgenv().AutoReconnectState then
        task.wait(1)
        TeleportService:Teleport(game.PlaceId, LocalPlayer)
    end
end)

local function PlayClickSound()
    local sound = Instance.new("Sound")
    sound.SoundId = "rbxassetid://6042457221"
    sound.Volume = 0.5
    sound.Parent = SoundService
    sound:Play()
    game:GetService("Debris"):AddItem(sound, 1)
end

local KeyGui = Instance.new("ScreenGui")
KeyGui.Name = "AstroKeyGui"
KeyGui.Parent = CoreGui
KeyGui.IgnoreGuiInset = true

local KeyMain = Instance.new("Frame")
KeyMain.Size = UDim2.new(0, 320, 0, 200)
KeyMain.Position = UDim2.new(0.5, -160, 0.5, -100)
KeyMain.BackgroundColor3 = Color3.fromRGB(220, 235, 250)
KeyMain.BackgroundTransparency = 0.15
KeyMain.BorderSizePixel = 0
KeyMain.Parent = KeyGui

local KeyCorner = Instance.new("UICorner")
KeyCorner.CornerRadius = UDim.new(0, 16)
KeyCorner.Parent = KeyMain

local KeyStroke = Instance.new("UIStroke")
KeyStroke.Color = Color3.fromRGB(150, 210, 255)
KeyStroke.Thickness = 2.5
KeyStroke.Transparency = 0.2
KeyStroke.Parent = KeyMain

local KeyTitle = Instance.new("TextLabel")
KeyTitle.Size = UDim2.new(1, 0, 0, 40)
KeyTitle.BackgroundTransparency = 1
KeyTitle.Text = "❄️ Astro Hub - Key System ❄️"
KeyTitle.TextColor3 = Color3.fromRGB(20, 50, 90)
KeyTitle.TextSize = 16
KeyTitle.Font = Enum.Font.GothamBold
KeyTitle.Parent = KeyMain

local KeyBox = Instance.new("TextBox")
KeyBox.Size = UDim2.new(0.8, 0, 0, 40)
KeyBox.Position = UDim2.new(0.1, 0, 0.35, 0)
KeyBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
KeyBox.BackgroundTransparency = 0.3
KeyBox.TextColor3 = Color3.fromRGB(20, 40, 70)
KeyBox.PlaceholderText = "Enter Key Here..."
KeyBox.Text = ""
KeyBox.TextSize = 14
KeyBox.Font = Enum.Font.Gotham
KeyBox.Parent = KeyMain

local BoxCorner = Instance.new("UICorner")
BoxCorner.CornerRadius = UDim.new(0, 10)
BoxCorner.Parent = KeyBox

local SubmitBtn = Instance.new("TextButton")
SubmitBtn.Size = UDim2.new(0.8, 0, 0, 40)
SubmitBtn.Position = UDim2.new(0.1, 0, 0.65, 0)
SubmitBtn.BackgroundColor3 = Color3.fromRGB(70, 160, 230)
SubmitBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SubmitBtn.Text = "Login"
SubmitBtn.TextSize = 15
SubmitBtn.Font = Enum.Font.GothamBold
SubmitBtn.Parent = KeyMain

local BtnCorner = Instance.new("UICorner")
BtnCorner.CornerRadius = UDim.new(0, 10)
BtnCorner.Parent = SubmitBtn

local function LoadAstroHub()
    PlayClickSound()
    KeyGui:Destroy()
    
    KillAllConnections()
    getgenv().AstroRunning = true

    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "AstroHubGui"
    ScreenGui.Parent = CoreGui
    ScreenGui.IgnoreGuiInset = true

    local OpenBtn = Instance.new("TextButton")
    OpenBtn.Size = UDim2.new(0, 55, 0, 55)
    OpenBtn.Position = UDim2.new(0, 20, 0.5, -28)
    OpenBtn.BackgroundColor3 = Color3.fromRGB(200, 225, 245)
    OpenBtn.BackgroundTransparency = 0.2
    OpenBtn.TextColor3 = Color3.fromRGB(20, 60, 100)
    OpenBtn.Text = "❄️"
    OpenBtn.TextSize = 24
    OpenBtn.Font = Enum.Font.GothamBold
    OpenBtn.Parent = ScreenGui

    local OpenCorner = Instance.new("UICorner")
    OpenCorner.CornerRadius = UDim.new(1, 0)
    OpenCorner.Parent = OpenBtn

    local OpenStroke = Instance.new("UIStroke")
    OpenStroke.Color = Color3.fromRGB(120, 190, 255)
    OpenStroke.Thickness = 2.5
    OpenStroke.Parent = OpenBtn

    local dragging, dragStart, startPos
    OpenBtn.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = OpenBtn.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStart
            OpenBtn.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)

    local MainFrame = Instance.new("Frame")
    MainFrame.Size = UDim2.new(0, 540, 0, 380)
    MainFrame.Position = UDim2.new(0.5, -270, 0.5, -190)
    MainFrame.BackgroundColor3 = Color3.fromRGB(215, 232, 248)
    MainFrame.BackgroundTransparency = 0.15
    MainFrame.BorderSizePixel = 0
    MainFrame.Visible = true
    MainFrame.Parent = ScreenGui

    local MainCorner = Instance.new("UICorner")
    MainCorner.CornerRadius = UDim.new(0, 14)
    MainCorner.Parent = MainFrame

    local MainStroke = Instance.new("UIStroke")
    MainStroke.Color = Color3.fromRGB(140, 200, 255)
    MainStroke.Thickness = 2
    MainStroke.Parent = MainFrame

    local TopBar = Instance.new("Frame")
    TopBar.Size = UDim2.new(1, 0, 0, 40)
    TopBar.BackgroundColor3 = Color3.fromRGB(180, 210, 235)
    TopBar.BackgroundTransparency = 0.3
    TopBar.BorderSizePixel = 0
    TopBar.Parent = MainFrame

    local TopCorner = Instance.new("UICorner")
    TopCorner.CornerRadius = UDim.new(0, 14)
    TopCorner.Parent = TopBar

    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(0, 200, 1, 0)
    Title.Position = UDim2.new(0, 15, 0, 0)
    Title.BackgroundTransparency = 1
    Title.Text = "❄️ Astro Hub | Icy Edition"
    Title.TextColor3 = Color3.fromRGB(20, 50, 90)
    Title.TextSize = 15
    Title.Font = Enum.Font.GothamBold
    Title.Parent = TopBar

    local CloseBtn = Instance.new("TextButton")
    CloseBtn.Size = UDim2.new(0, 30, 0, 30)
    CloseBtn.Position = UDim2.new(1, -35, 0, 5)
    CloseBtn.BackgroundTransparency = 1
    CloseBtn.Text = "✕"
    CloseBtn.TextColor3 = Color3.fromRGB(180, 40, 40)
    CloseBtn.TextSize = 16
    CloseBtn.Font = Enum.Font.GothamBold
    CloseBtn.Parent = TopBar

    OpenBtn.MouseButton1Click:Connect(function() PlayClickSound() MainFrame.Visible = not MainFrame.Visible end)
    
    CloseBtn.MouseButton1Click:Connect(function()
        PlayClickSound()
        KillAllConnections()
        ScreenGui:Destroy()
    end)

    local Sidebar = Instance.new("ScrollingFrame")
    Sidebar.Size = UDim2.new(0, 150, 1, -40)
    Sidebar.Position = UDim2.new(0, 0, 0, 40)
    Sidebar.BackgroundColor3 = Color3.fromRGB(195, 218, 240)
    Sidebar.BackgroundTransparency = 0.4
    Sidebar.BorderSizePixel = 0
    Sidebar.CanvasSize = UDim2.new(0, 0, 0, 400)
    Sidebar.ScrollBarThickness = 2
    Sidebar.Parent = MainFrame

    local SideLayout = Instance.new("UIListLayout")
    SideLayout.Padding = UDim.new(0, 6)
    SideLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    SideLayout.Parent = Sidebar

    local ContentArea = Instance.new("Frame")
    ContentArea.Size = UDim2.new(1, -155, 1, -45)
    ContentArea.Position = UDim2.new(0, 155, 0, 42)
    ContentArea.BackgroundTransparency = 1
    ContentArea.Parent = MainFrame

    local pages = {}
    local function CreatePage(name)
        local scrolling = Instance.new("ScrollingFrame")
        scrolling.Size = UDim2.new(1, 0, 1, 0)
        scrolling.BackgroundTransparency = 1
        scrolling.CanvasSize = UDim2.new(0, 0, 0, 580)
        scrolling.ScrollBarThickness = 4
        scrolling.ScrollBarImageColor3 = Color3.fromRGB(100, 180, 255)
        scrolling.Visible = false
        scrolling.Parent = ContentArea

        local layout = Instance.new("UIListLayout")
        layout.Padding = UDim.new(0, 8)
        layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
        layout.Parent = scrolling

        local sideBtn = Instance.new("TextButton")
        sideBtn.Size = UDim2.new(0.9, 0, 0, 38)
        sideBtn.BackgroundColor3 = Color3.fromRGB(225, 240, 255)
        sideBtn.BackgroundTransparency = 0.4
        sideBtn.TextColor3 = Color3.fromRGB(20, 50, 90)
        sideBtn.Text = name
        sideBtn.TextSize = 13
        sideBtn.Font = Enum.Font.GothamBold
        sideBtn.Parent = Sidebar

        local sCorner = Instance.new("UICorner")
        sCorner.CornerRadius = UDim.new(0, 8)
        sCorner.Parent = sideBtn

        sideBtn.MouseButton1Click:Connect(function()
            PlayClickSound()
            for _, p in pairs(pages) do p.Visible = false end
            scrolling.Visible = true
        end)

        table.insert(pages, scrolling)
        if #pages == 1 then scrolling.Visible = true end
        return scrolling
    end

    local PageHome = CreatePage("🏠 Home / Stats")
    local PagePlayer = CreatePage("⚡ Player & Fly")
    local PageCombat = CreatePage("🎯 Aimbot")
    local PageDetect = CreatePage("🥚 Eggs & Rarities")
    local PageBoss = CreatePage("👹 Boss Finder")
    local PageVisual = CreatePage("👁️ ESP & Visuals")
    local PagePerf = CreatePage("🎮 Performance")

    local StatsCard = Instance.new("Frame")
    StatsCard.Size = UDim2.new(0.95, 0, 0, 160)
    StatsCard.BackgroundColor3 = Color3.fromRGB(230, 242, 255)
    StatsCard.BackgroundTransparency = 0.3
    StatsCard.Parent = PageHome

    local scCorner = Instance.new("UICorner")
    scCorner.CornerRadius = UDim.new(0, 10)
    scCorner.Parent = StatsCard

    local StatsText = Instance.new("TextLabel")
    StatsText.Size = UDim2.new(1, -20, 1, 0)
    StatsText.Position = UDim2.new(0, 10, 0, 0)
    StatsText.BackgroundTransparency = 1
    StatsText.Text = "⚡ FPS: --\n📡 Ping: -- ms\n💻 CPU: -- ms | 🎮 GPU: -- ms\n📍 Coords: X: 0, Y: 0, Z: 0"
    StatsText.TextColor3 = Color3.fromRGB(20, 60, 100)
    StatsText.TextSize = 13
    StatsText.Font = Enum.Font.GothamBold
    StatsText.TextXAlignment = Enum.TextXAlignment.Left
    StatsText.Parent = StatsCard

    -- 🛡️ تحديث Stats آمن تماماً لا يتسبب بتجمد الكونسول أو توقف السكربت
    local lastUpdate = tick()
    local frameCount = 0
    RunService.RenderStepped:Connect(function()
        if not getgenv().AstroRunning then return end
        frameCount = frameCount + 1
        if tick() - lastUpdate >= 1 then
            local fps = frameCount
            local ping = 0
            pcall(function()
                ping = math.floor(Stats.Network.ServerStatsItem["Data Ping"]:GetValue())
            end)
            
            local coords = "X: 0, Y: 0, Z: 0"
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                local pos = LocalPlayer.Character.HumanoidRootPart.Position
                coords = string.format("X: %d, Y: %d, Z: %d", math.floor(pos.X), math.floor(pos.Y), math.floor(pos.Z))
            end

            StatsText.Text = string.format("⚡ FPS: %d | 📡 Ping: %d ms\n💻 CPU: Active | 🎮 GPU: Stable\n📍 Coords: %s", fps, ping, coords)
            frameCount = 0
            lastUpdate = tick()
        end
    end)

    local DiscordBtn = Instance.new("TextButton")
    DiscordBtn.Size = UDim2.new(0.95, 0, 0, 42)
    DiscordBtn.BackgroundColor3 = Color3.fromRGB(114, 137, 218)
    DiscordBtn.BackgroundTransparency = 0.1
    DiscordBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    DiscordBtn.Text = "💬 Join Discord Server"
    DiscordBtn.TextSize = 14
    DiscordBtn.Font = Enum.Font.GothamBold
    DiscordBtn.Parent = PageHome

    local dCorner = Instance.new("UICorner")
    dCorner.CornerRadius = UDim.new(0, 8)
    dCorner.Parent = DiscordBtn

    DiscordBtn.MouseButton1Click:Connect(function()
        PlayClickSound()
        if setclipboard then
            setclipboard("https://discord.gg/vnTrCe2GSU")
            DiscordBtn.Text = "✅ Discord Link Copied!"
            task.wait(2)
            DiscordBtn.Text = "💬 Join Discord Server"
        end
    end)

    CreateToggle(PageHome, "Auto Reconnect Server", function(state) getgenv().AutoReconnectState = state end)

    CreateToggle(PagePlayer, "Infinite Jump", function(state)
        if state then
            getgenv().InfJumpConnection = UserInputService.JumpRequest:Connect(function()
                if not getgenv().AstroRunning then return end
                if LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
                    LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState(Enum.HumanoidStateType.Jumping)
                end
            end)
        else
            if getgenv().InfJumpConnection then getgenv().InfJumpConnection:Disconnect() end
        end
    end)

    CreateToggle(PagePlayer, "Noclip", function(state)
        if state then
            getgenv().NoclipConnection = RunService.Stepped:Connect(function()
                if not getgenv().AstroRunning then return end
                if LocalPlayer.Character then
                    for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
                        if part:IsA("BasePart") then part.CanCollide = false end
                    end
                end
            end)
        else
            if getgenv().NoclipConnection then getgenv().NoclipConnection:Disconnect() end
            if LocalPlayer.Character then
                for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
                    if part:IsA("BasePart") then part.CanCollide = true end
                end
            end
        end
    end)

    local flying = false
    local flySpeed = 50
    local bv, bg

    CreateToggle(PagePlayer, "Legendary Fly", function(state)
        flying = state
        local char = LocalPlayer.Character
        if not char or not char:FindFirstChild("HumanoidRootPart") then return end
        local hrp = char.HumanoidRootPart
        local hum = char:FindFirstChildOfClass("Humanoid")

        if flying then
            if hum then hum.PlatformStand = true end

            bv = Instance.new("BodyVelocity")
            bv.MaxForce = Vector3.new(9e9, 9e9, 9e9)
            bv.Velocity = Vector3.new(0, 0, 0)
            bv.Parent = hrp

            bg = Instance.new("BodyGyro")
            bg.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
            bg.CFrame = hrp.CFrame
            bg.Parent = hrp

            task.spawn(function()
                while flying and getgenv().AstroRunning and char and hrp.Parent do
                    RunService.RenderStepped:Wait()
                    local camCF = Camera.CFrame
                    bg.CFrame = camCF

                    if hum and hum.MoveDirection.Magnitude > 0 then
                        bv.Velocity = hum.MoveDirection * flySpeed + Vector3.new(0, camCF.LookVector.Y * hum.MoveDirection.Magnitude * flySpeed, 0)
                    elseif UserInputService:IsKeyDown(Enum.KeyCode.W) or UserInputService:IsKeyDown(Enum.KeyCode.Up) then
                        bv.Velocity = camCF.LookVector * flySpeed
                    elseif UserInputService:IsKeyDown(Enum.KeyCode.S) or UserInputService:IsKeyDown(Enum.KeyCode.Down) then
                        bv.Velocity = -camCF.LookVector * flySpeed
                    elseif UserInputService:IsKeyDown(Enum.KeyCode.D) or UserInputService:IsKeyDown(Enum.KeyCode.Right) then
                        bv.Velocity = camCF.RightVector * flySpeed
                    elseif UserInputService:IsKeyDown(Enum.KeyCode.A) or UserInputService:IsKeyDown(Enum.KeyCode.Left) then
                        bv.Velocity = -camCF.RightVector * flySpeed
                    else
                        bv.Velocity = Vector3.new(0, 0, 0)
                    end
                end
            end)
        else
            if bv then bv:Destroy() end
            if bg then bg:Destroy() end
            if hum then hum.PlatformStand = false end
        end
    end)

    local function CreateSlider(parentPage, name, minVal, maxVal, defaultVal, callback)
        local frame = Instance.new("Frame")
        frame.Size = UDim2.new(0.95, 0, 0, 50)
        frame.BackgroundColor3 = Color3.fromRGB(225, 238, 252)
        frame.BackgroundTransparency = 0.4
        frame.Parent = parentPage

        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, 8)
        corner.Parent = frame

        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(1, -20, 0, 22)
        label.Position = UDim2.new(0, 10, 0, 4)
        label.BackgroundTransparency = 1
        label.Text = name .. ": " .. tostring(defaultVal)
        label.TextColor3 = Color3.fromRGB(20, 50, 90)
        label.TextSize = 13
        label.Font = Enum.Font.GothamBold
        label.Parent = frame

        local sliderBg = Instance.new("Frame")
        sliderBg.Size = UDim2.new(0.9, 0, 0, 8)
        sliderBg.Position = UDim2.new(0.05, 0, 0.7, 0)
        sliderBg.BackgroundColor3 = Color3.fromRGB(180, 205, 230)
        sliderBg.BorderSizePixel = 0
        sliderBg.Parent = frame

        local fill = Instance.new("Frame")
        fill.Size = UDim2.new((defaultVal - minVal)/(maxVal - minVal), 0, 1, 0)
        fill.BackgroundColor3 = Color3.fromRGB(70, 160, 230)
        fill.BorderSizePixel = 0
        fill.Parent = sliderBg

        local function update(input)
            local pos = math.clamp((input.Position.X - sliderBg.AbsolutePosition.X) / sliderBg.AbsoluteSize.X, 0, 1)
            local val = math.floor(minVal + (maxVal - minVal) * pos)
            fill.Size = UDim2.new(pos, 0, 1, 0)
            label.Text = name .. ": " .. tostring(val)
            callback(val)
        end

        local draggingSlider = false
        sliderBg.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                draggingSlider = true
                PlayClickSound()
                update(input)
            end
        end)
        UserInputService.InputChanged:Connect(function(input)
            if draggingSlider and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
                update(input)
            end
        end)
        UserInputService.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                draggingSlider = false
            end
        end)
    end

    CreateSlider(PagePlayer, "WalkSpeed", 0, 2000, 16, function(val)
        if getgenv().SpeedConnection then getgenv().SpeedConnection:Disconnect() end
        getgenv().SpeedConnection = RunService.RenderStepped:Connect(function()
            if not getgenv().AstroRunning then return end
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
                LocalPlayer.Character:FindFirstChildOfClass("Humanoid").WalkSpeed = val
            end
        end)
    end)

    CreateSlider(PagePlayer, "Fly Speed", 20, 2000, 50, function(val)
        flySpeed = val
    end)

    CreateToggle(PageCombat, "Aimbot (Lock Camera)", function(state)
        if getgenv().AimbotConnection then getgenv().AimbotConnection:Disconnect() getgenv().AimbotConnection = nil end
        if state then
            getgenv().AimbotConnection = RunService.RenderStepped:Connect(function()
                if not getgenv().AstroRunning then return end
                local closest = nil
                local shortestDist = math.huge
                for _, plr in pairs(Players:GetPlayers()) do
                    if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("Head") and plr.Character:FindFirstChildOfClass("Humanoid") and plr.Character:FindFirstChildOfClass("Humanoid").Health > 0 then
                        local pos, onScreen = Camera:WorldToViewportPoint(plr.Character.Head.Position)
                        if onScreen then
                            local dist = (Vector2.new(pos.X, pos.Y) - Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)).Magnitude
                            if dist < shortestDist then
                                shortestDist = dist
                                closest = plr
                            end
                        end
                    end
                end
                if closest and closest.Character and closest.Character:FindFirstChild("Head") then
                    Camera.CFrame = CFrame.new(Camera.CFrame.Position, closest.Character.Head.Position)
                end
            end)
        end
    end)

    local eggEspActive = false
    CreateToggle(PageDetect, "Highlight Eggs & Rarities", function(state)
        eggEspActive = state
        task.spawn(function()
            while eggEspActive and getgenv().AstroRunning do
                for _, obj in pairs(Workspace:GetDescendants()) do
                    local name = string.lower(obj.Name)
                    if string.find(name, "egg") or string.find(name, "divine") or string.find(name, "secret") or string.find(name, "mythic") or string.find(name, "legendary") then
                        if obj:IsA("Model") or obj:IsA("BasePart") then
                            if not obj:FindFirstChild("AstroEggHighlight") then
                                local hl = Instance.new("Highlight")
                                hl.Name = "AstroEggHighlight"
                                hl.FillColor = Color3.fromRGB(255, 215, 0)
                                hl.OutlineColor = Color3.fromRGB(255, 255, 255)
                                hl.Parent = obj
                            end
                        end
                    end
                end
                task.wait(3)
            end
            if not eggEspActive then
                for _, obj in pairs(Workspace:GetDescendants()) do
                    if obj.Name == "AstroEggHighlight" then obj:Destroy() end
                end
            end
        end)
    end)

    local bossEspActive = false
    CreateToggle(PageBoss, "Highlight All Bosses", function(state)
        bossEspActive = state
        task.spawn(function()
            while bossEspActive and getgenv().AstroRunning do
                for _, obj in pairs(Workspace:GetDescendants()) do
                    local name = string.lower(obj.Name)
                    if string.find(name, "boss") or string.find(name, "monster") then
                        if obj:IsA("Model") and obj:FindFirstChildOfClass("Humanoid") then
                            if not obj:FindFirstChild("AstroBossHighlight") then
                                local hl = Instance.new("Highlight")
                                hl.Name = "AstroBossHighlight"
                                hl.FillColor = Color3.fromRGB(255, 50, 50)
                                hl.OutlineColor = Color3.fromRGB(255, 255, 255)
                                hl.Parent = obj

                                local bgui = Instance.new("BillboardGui")
                                bgui.Name = "AstroBossTag"
                                bgui.Size = UDim2.new(0, 150, 0, 30)
                                bgui.AlwaysOnTop = true
                                bgui.ExtentsOffset = Vector3.new(0, 3, 0)
                                bgui.Parent = obj

                                local txt = Instance.new("TextLabel")
                                txt.Size = UDim2.new(1, 0, 1, 0)
                                txt.BackgroundTransparency = 1
                                txt.Text = "👹 BOSS: " .. obj.Name
                                txt.TextColor3 = Color3.fromRGB(255, 80, 80)
                                txt.TextSize = 14
                                txt.Font = Enum.Font.GothamBold
                                txt.Parent = bgui
                            end
                        end
                    end
                end
                task.wait(3)
            end
            if not bossEspActive then
                for _, obj in pairs(Workspace:GetDescendants()) do
                    if obj.Name == "AstroBossHighlight" or obj.Name == "AstroBossTag" then obj:Destroy() end
                end
            end
        end)
    end)

    local espActive = false
    CreateToggle(PageVisual, "Player ESP (Highlight)", function(state)
        espActive = state
        for _, plr in pairs(Players:GetPlayers()) do
            if plr ~= LocalPlayer and plr.Character then
                if espActive then
                    if not plr.Character:FindFirstChild("AstroHighlight") then
                        local hl = Instance.new("Highlight")
                        hl.Name = "AstroHighlight"
                        hl.FillColor = Color3.fromRGB(100, 180, 255)
                        hl.OutlineColor = Color3.fromRGB(255, 255, 255)
                        hl.Parent = plr.Character
                    end
                else
                    if plr.Character:FindFirstChild("AstroHighlight") then
                        plr.Character.AstroHighlight:Destroy()
                    end
                end
            end
        end
    end)

    CreateToggle(PagePerf, "Potato Mode (Boost FPS)", function(state)
        if state then
            for _, v in pairs(Workspace:GetDescendants()) do
                if v:IsA("BasePart") then
                    v.Material = Enum.Material.SmoothPlastic
                    v.Reflectance = 0
                elseif v:IsA("Decal") or v:IsA("Texture") then
                    v.Transparency = 1
                end
            end
            Lighting.GlobalShadows = false
            Lighting.FogEnd = 9e9
            settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
        else
            Lighting.GlobalShadows = true
            settings().Rendering.QualityLevel = Enum.QualityLevel.Automatic
        end
    end)
end

-- دالة مساعدة لإنشاء الأزرار
local function CreateToggle(parentPage, name, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.95, 0, 0, 40)
    btn.BackgroundColor3 = Color3.fromRGB(225, 238, 252)
    btn.BackgroundTransparency = 0.4
    btn.TextColor3 = Color3.fromRGB(20, 50, 90)
    btn.Text = name .. ": OFF"
    btn.TextSize = 13
    btn.Font = Enum.Font.GothamBold
    btn.Parent = parentPage

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = btn

    local active = false
    btn.MouseButton1Click:Connect(function()
        PlayClickSound()
        active = not active
        if active then
            btn.BackgroundColor3 = Color3.fromRGB(80, 170, 245)
            btn.BackgroundTransparency = 0.1
            btn.TextColor3 = Color3.fromRGB(255, 255, 255)
            btn.Text = name .. ": ON"
        else
            btn.BackgroundColor3 = Color3.fromRGB(225, 238, 252)
            btn.BackgroundTransparency = 0.4
            btn.TextColor3 = Color3.fromRGB(20, 50, 90)
            btn.Text = name .. ": OFF"
        end
        callback(active)
    end)
end

SubmitBtn.MouseButton1Click:Connect(function()
    if KeyBox.Text == "ASTRO-2026-KEY" then
        LoadAstroHub()
    else
        PlayClickSound()
        KeyBox.Text = ""
        KeyBox.PlaceholderText = "Wrong Key! Try Again"
    end
end)
