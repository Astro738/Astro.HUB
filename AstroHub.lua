-- [[ Astro Hub V6 - Ultimate Sidebar Edition ]]
-- [[ Key System Enabled: ASTRO-2026-KEY ]]

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
local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera

-- ميزة إعادة الاتصال التلقائي عند انقطاع السيرفر أو النت
local TeleportService = game:GetService("TeleportService")
game:GetService("CoreGui").RobloxPromptGui.promptOverlay.ChildAdded:Connect(function(child)
    if child.Name == 'ErrorPrompt' then
        task.wait(1)
        TeleportService:Teleport(game.PlaceId, LocalPlayer)
    end
end)

if CoreGui:FindFirstChild("AstroHubGui") then
    CoreGui.AstroHubGui:Destroy()
end

-- واجهة التحقق من المفتاح
local KeyGui = Instance.new("ScreenGui")
KeyGui.Name = "AstroKeyGui"
KeyGui.Parent = CoreGui
KeyGui.IgnoreGuiInset = true

local KeyMain = Instance.new("Frame")
KeyMain.Size = UDim2.new(0, 320, 0, 200)
KeyMain.Position = UDim2.new(0.5, -160, 0.5, -100)
KeyMain.BackgroundColor3 = Color3.fromRGB(15, 20, 30)
KeyMain.BackgroundTransparency = 0.1
KeyMain.BorderSizePixel = 0
KeyMain.Parent = KeyGui

local KeyCorner = Instance.new("UICorner")
KeyCorner.CornerRadius = UDim.new(0, 14)
KeyCorner.Parent = KeyMain

local KeyStroke = Instance.new("UIStroke")
KeyStroke.Color = Color3.fromRGB(100, 200, 255)
KeyStroke.Thickness = 2
KeyStroke.Transparency = 0.3
KeyStroke.Parent = KeyMain

local KeyTitle = Instance.new("TextLabel")
KeyTitle.Size = UDim2.new(1, 0, 0, 40)
KeyTitle.BackgroundTransparency = 1
KeyTitle.Text = "❄️ Astro Hub - Key System ❄️"
KeyTitle.TextColor3 = Color3.fromRGB(220, 240, 255)
KeyTitle.TextSize = 16
KeyTitle.Font = Enum.Font.GothamBold
KeyTitle.Parent = KeyMain

local KeyBox = Instance.new("TextBox")
KeyBox.Size = UDim2.new(0.8, 0, 0, 40)
KeyBox.Position = UDim2.new(0.1, 0, 0.35, 0)
KeyBox.BackgroundColor3 = Color3.fromRGB(25, 35, 50)
KeyBox.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyBox.PlaceholderText = "Enter Key (ASTRO-2026-KEY)"
KeyBox.Text = ""
KeyBox.TextSize = 14
KeyBox.Font = Enum.Font.Gotham
KeyBox.Parent = KeyMain

local BoxCorner = Instance.new("UICorner")
BoxCorner.CornerRadius = UDim.new(0, 8)
BoxCorner.Parent = KeyBox

local SubmitBtn = Instance.new("TextButton")
SubmitBtn.Size = UDim2.new(0.8, 0, 0, 40)
SubmitBtn.Position = UDim2.new(0.1, 0, 0.65, 0)
SubmitBtn.BackgroundColor3 = Color3.fromRGB(0, 140, 255)
SubmitBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SubmitBtn.Text = "Login"
SubmitBtn.TextSize = 15
SubmitBtn.Font = Enum.Font.GothamBold
SubmitBtn.Parent = KeyMain

local BtnCorner = Instance.new("UICorner")
BtnCorner.CornerRadius = UDim.new(0, 8)
BtnCorner.Parent = SubmitBtn

local function LoadAstroHub()
    KeyGui:Destroy()

    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "AstroHubGui"
    ScreenGui.Parent = CoreGui
    ScreenGui.IgnoreGuiInset = true

    -- زر الفتح والإغلاق العائم
    local OpenBtn = Instance.new("TextButton")
    OpenBtn.Size = UDim2.new(0, 45, 0, 45)
    OpenBtn.Position = UDim2.new(0, 20, 0.5, -22)
    OpenBtn.BackgroundColor3 = Color3.fromRGB(15, 20, 30)
    OpenBtn.TextColor3 = Color3.fromRGB(120, 220, 255)
    OpenBtn.Text = "❄️"
    OpenBtn.TextSize = 20
    OpenBtn.Font = Enum.Font.GothamBold
    OpenBtn.Parent = ScreenGui

    local OpenCorner = Instance.new("UICorner")
    OpenCorner.CornerRadius = UDim.new(1, 0)
    OpenCorner.Parent = OpenBtn

    local OpenStroke = Instance.new("UIStroke")
    OpenStroke.Color = Color3.fromRGB(100, 200, 255)
    OpenStroke.Thickness = 2
    OpenStroke.Parent = OpenBtn

    -- اللوحة الرئيسية بتصميم القائمة الجانبية (Sidebar)
    local MainFrame = Instance.new("Frame")
    MainFrame.Size = UDim2.new(0, 540, 0, 360)
    MainFrame.Position = UDim2.new(0.5, -270, 0.5, -180)
    MainFrame.BackgroundColor3 = Color3.fromRGB(18, 22, 30)
    MainFrame.BorderSizePixel = 0
    MainFrame.Visible = true
    MainFrame.Parent = ScreenGui

    local MainCorner = Instance.new("UICorner")
    MainCorner.CornerRadius = UDim.new(0, 10)
    MainCorner.Parent = MainFrame

    local MainStroke = Instance.new("UIStroke")
    MainStroke.Color = Color3.fromRGB(60, 75, 100)
    MainStroke.Thickness = 1.5
    MainStroke.Parent = MainFrame

    -- شريط العنوان العلوي
    local TopBar = Instance.new("Frame")
    TopBar.Size = UDim2.new(1, 0, 0, 35)
    TopBar.BackgroundColor3 = Color3.fromRGB(12, 15, 22)
    TopBar.BorderSizePixel = 0
    TopBar.Parent = MainFrame

    local TopCorner = Instance.new("UICorner")
    TopCorner.CornerRadius = UDim.new(0, 10)
    TopCorner.Parent = TopBar

    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(0, 200, 1, 0)
    Title.Position = UDim2.new(0, 15, 0, 0)
    Title.BackgroundTransparency = 1
    Title.Text = "AstroHub"
    Title.TextColor3 = Color3.fromRGB(220, 230, 245)
    Title.TextSize = 15
    Title.Font = Enum.Font.GothamBold
    Title.Parent = TopBar

    local CloseBtn = Instance.new("TextButton")
    CloseBtn.Size = UDim2.new(0, 30, 0, 30)
    CloseBtn.Position = UDim2.new(1, -35, 0, 2)
    CloseBtn.BackgroundTransparency = 1
    CloseBtn.Text = "✕"
    CloseBtn.TextColor3 = Color3.fromRGB(200, 60, 60)
    CloseBtn.TextSize = 16
    CloseBtn.Font = Enum.Font.GothamBold
    CloseBtn.Parent = TopBar

    OpenBtn.MouseButton1Click:Connect(function()
        MainFrame.Visible = not MainFrame.Visible
    end)
    CloseBtn.MouseButton1Click:Connect(function()
        MainFrame.Visible = false
    end)

    -- القائمة الجانبية (Sidebar)
    local Sidebar = Instance.new("ScrollingFrame")
    Sidebar.Size = UDim2.new(0, 150, 1, -35)
    Sidebar.Position = UDim2.new(0, 0, 0, 35)
    Sidebar.BackgroundColor3 = Color3.fromRGB(14, 18, 25)
    Sidebar.BorderSizePixel = 0
    Sidebar.CanvasSize = UDim2.new(0, 0, 0, 300)
    Sidebar.ScrollBarThickness = 2
    Sidebar.Parent = MainFrame

    local SideLayout = Instance.new("UIListLayout")
    SideLayout.Padding = UDim.new(0, 5)
    SideLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    SideLayout.Parent = Sidebar

    -- حاوية المحتوى الرئيسي (Content Area)
    local ContentArea = Instance.new("Frame")
    ContentArea.Size = UDim2.new(1, -155, 1, -45)
    ContentArea.Position = UDim2.new(0, 155, 0, 40)
    ContentArea.BackgroundTransparency = 1
    ContentArea.Parent = MainFrame

    -- دالة لإنشاء صفحات متعددة
    local pages = {}
    local function CreatePage(name)
        local scrolling = Instance.new("ScrollingFrame")
        scrolling.Size = UDim2.new(1, 0, 1, 0)
        scrolling.BackgroundTransparency = 1
        scrolling.CanvasSize = UDim2.new(0, 0, 0, 450)
        scrolling.ScrollBarThickness = 4
        scrolling.ScrollBarImageColor3 = Color3.fromRGB(100, 180, 255)
        scrolling.Visible = false
        scrolling.Parent = ContentArea

        local layout = Instance.new("UIListLayout")
        layout.Padding = UDim.new(0, 8)
        layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
        layout.Parent = scrolling

        -- زر في القائمة الجانبية
        local sideBtn = Instance.new("TextButton")
        sideBtn.Size = UDim2.new(0.9, 0, 0, 35)
        sideBtn.BackgroundColor3 = Color3.fromRGB(20, 26, 36)
        sideBtn.TextColor3 = Color3.fromRGB(180, 200, 225)
        sideBtn.Text = name
        sideBtn.TextSize = 13
        sideBtn.Font = Enum.Font.GothamBold
        sideBtn.Parent = Sidebar

        local sCorner = Instance.new("UICorner")
        sCorner.CornerRadius = UDim.new(0, 6)
        sCorner.Parent = sideBtn

        sideBtn.MouseButton1Click:Connect(function()
            for _, p in pairs(pages) do p.Visible = false end
            scrolling.Visible = true
        end)

        table.insert(pages, scrolling)
        if #pages == 1 then scrolling.Visible = true end
        return scrolling
    end

    -- صفحات الهب
    local PageHome = CreatePage("🏠 Home / Stats")
    local PagePlayer = CreatePage("⚡ Player & Fly")
    local PageVisual = CreatePage("🎮 Performance")

    -- 1. صفحة الإحصائيات (Home / Stats)
    local StatsCard = Instance.new("Frame")
    StatsCard.Size = UDim2.new(0.95, 0, 0, 120)
    StatsCard.BackgroundColor3 = Color3.fromRGB(22, 28, 40)
    StatsCard.Parent = PageHome

    local scCorner = Instance.new("UICorner")
    scCorner.CornerRadius = UDim.new(0, 8)
    scCorner.Parent = StatsCard

    local StatsText = Instance.new("TextLabel")
    StatsText.Size = UDim2.new(1, -20, 1, 0)
    StatsText.Position = UDim2.new(0, 10, 0, 0)
    StatsText.BackgroundTransparency = 1
    StatsText.Text = "⚡ FPS: --\n📡 Ping: -- ms\n💻 CPU Usage: -- ms\n🎮 GPU Usage: -- ms"
    StatsText.TextColor3 = Color3.fromRGB(100, 220, 255)
    StatsText.TextSize = 14
    StatsText.Font = Enum.Font.GothamBold
    StatsText.TextXAlignment = Enum.TextXAlignment.Left
    StatsText.Parent = StatsCard

    local lastUpdate = tick()
    local frameCount = 0
    RunService.RenderStepped:Connect(function()
        frameCount = frameCount + 1
        if tick() - lastUpdate >= 1 then
            local fps = frameCount
            local ping = math.floor(Stats.Network.ServerStatsItem["Data Ping"]:GetValue())
            local cpu = string.format("%.1f", Stats.PerformanceStats.CPU:GetValue())
            local gpu = string.format("%.1f", Stats.PerformanceStats.GPU:GetValue())
            StatsText.Text = string.format("⚡ FPS: %d\n📡 Ping: %d ms\n💻 CPU Usage: %s ms\n🎮 GPU Usage: %s ms", fps, ping, cpu, gpu)
            frameCount = 0
            lastUpdate = tick()
        end
    end)

    -- دالة الأزرار
    local function CreateToggle(parentPage, name, callback)
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(0.95, 0, 0, 38)
        btn.BackgroundColor3 = Color3.fromRGB(25, 32, 45)
        btn.TextColor3 = Color3.fromRGB(210, 225, 245)
        btn.Text = name .. ": OFF"
        btn.TextSize = 13
        btn.Font = Enum.Font.GothamBold
        btn.Parent = parentPage

        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, 6)
        corner.Parent = btn

        local active = false
        btn.MouseButton1Click:Connect(function()
            active = not active
            if active then
                btn.BackgroundColor3 = Color3.fromRGB(0, 120, 220)
                btn.Text = name .. ": ON"
            else
                btn.BackgroundColor3 = Color3.fromRGB(25, 32, 45)
                btn.Text = name .. ": OFF"
            end
            callback(active)
        end)
    end

    -- دالة السلايدر المتطور
    local function CreateSlider(parentPage, name, minVal, maxVal, defaultVal, callback)
        local frame = Instance.new("Frame")
        frame.Size = UDim2.new(0.95, 0, 0, 48)
        frame.BackgroundColor3 = Color3.fromRGB(25, 32, 45)
        frame.Parent = parentPage

        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, 6)
        corner.Parent = frame

        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(1, -20, 0, 20)
        label.Position = UDim2.new(0, 10, 0, 4)
        label.BackgroundTransparency = 1
        label.Text = name .. ": " .. tostring(defaultVal)
        label.TextColor3 = Color3.fromRGB(210, 225, 245)
        label.TextSize = 12
        label.Font = Enum.Font.GothamBold
        label.Parent = frame

        local sliderBg = Instance.new("Frame")
        sliderBg.Size = UDim2.new(0.9, 0, 0, 6)
        sliderBg.Position = UDim2.new(0.05, 0, 0.7, 0)
        sliderBg.BackgroundColor3 = Color3.fromRGB(15, 20, 28)
        sliderBg.BorderSizePixel = 0
        sliderBg.Parent = frame

        local fill = Instance.new("Frame")
        fill.Size = UDim2.new((defaultVal - minVal)/(maxVal - minVal), 0, 1, 0)
        fill.BackgroundColor3 = Color3.fromRGB(0, 140, 255)
        fill.BorderSizePixel = 0
        fill.Parent = sliderBg

        local function update(input)
            local pos = math.clamp((input.Position.X - sliderBg.AbsolutePosition.X) / sliderBg.AbsoluteSize.X, 0, 1)
            local val = math.floor(minVal + (maxVal - minVal) * pos)
            fill.Size = UDim2.new(pos, 0, 1, 0)
            label.Text = name .. ": " .. tostring(val)
            callback(val)
        end

        local dragging = false
        sliderBg.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                dragging = true
                update(input)
            end
        end)
        UserInputService.InputChanged:Connect(function(input)
            if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
                update(input)
            end
        end)
        UserInputService.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                dragging = false
            end
        end)
    end

    -- 2. صفحة اللاعب والطيران (Player & Fly)
    CreateToggle(PagePlayer, "Infinite Jump", function(state)
        if state then
            _G.InfJump = UserInputService.JumpRequest:Connect(function()
                if LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
                    LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState(Enum.HumanoidStateType.Jumping)
                end
            end)
        else
            if _G.InfJump then _G.InfJump:Disconnect() end
        end
    end)

    CreateToggle(PagePlayer, "Noclip", function(state)
        if state then
            _G.Noclip = RunService.Stepped:Connect(function()
                if LocalPlayer.Character then
                    for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
                        if part:IsA("BasePart") then part.CanCollide = false end
                    end
                end
            end)
        else
            if _G.Noclip then _G.Noclip:Disconnect() end
        end
    end)

    -- نظام الطيران الأسطوري (Legendary Fly)
    local flyConn
    local flySpeed = 50
    CreateToggle(PagePlayer, "Legendary Fly", function(state)
        if state then
            local char = LocalPlayer.Character
            if not char or not char:FindFirstChild("HumanoidRootPart") then return end
            local hrp = char.HumanoidRootPart
            local hum = char:FindFirstChildOfClass("Humanoid")

            local bv = Instance.new("BodyVelocity")
            bv.Name = "AstroFlyVel"
            bv.MaxForce = Vector3.new(9e9, 9e9, 9e9)
            bv.Velocity = Vector3.new(0, 0, 0)
            bv.Parent = hrp

            local bg = Instance.new("BodyGyro")
            bg.Name = "AstroFlyGyro"
            bg.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
            bg.CFrame = hrp.CFrame
            bg.Parent = hrp

            if hum then hum.PlatformStand = true end

            flyConn = RunService.RenderStepped:Connect(function()
                if char and hrp and bv and bg then
                    local camCF = Camera.CFrame
                    local moveDir = Vector3.new(0, 0, 0)
                    if UserInputService:IsKeyDown(Enum.KeyCode.W) then moveDir = moveDir + camCF.LookVector end
                    if UserInputService:IsKeyDown(Enum.KeyCode.S) then moveDir = moveDir - camCF.LookVector end
                    if UserInputService:IsKeyDown(Enum.KeyCode.D) then moveDir = moveDir + camCF.RightVector end
                    if UserInputService:IsKeyDown(Enum.KeyCode.A) then moveDir = moveDir - camCF.RightVector end
                    bv.Velocity = moveDir * flySpeed
                    bg.CFrame = camCF
                end
            end)
        else
            if flyConn then flyConn:Disconnect() end
            local char = LocalPlayer.Character
            if char and char:FindFirstChild("HumanoidRootPart") then
                if char.HumanoidRootPart:FindFirstChild("AstroFlyVel") then char.HumanoidRootPart.AstroFlyVel:Destroy() end
                if char.HumanoidRootPart:FindFirstChild("AstroFlyGyro") then char.HumanoidRootPart.AstroFlyGyro:Destroy() end
                local hum = char:FindFirstChildOfClass("Humanoid")
                if hum then hum.PlatformStand = false end
            end
        end
    end)

    CreateSlider(PagePlayer, "WalkSpeed", 0, 1000, 16, function(val)
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
            LocalPlayer.Character:FindFirstChildOfClass("Humanoid").WalkSpeed = val
        end
    end)

    CreateSlider(PagePlayer, "Fly Speed", 20, 300, 50, function(val)
        flySpeed = val
    end)

    -- 3. صفحة الأداء (Performance / Potato Mode)
    CreateToggle(PageVisual, "Potato Mode (Boost FPS)", function(state)
        for _, v in pairs(Workspace:GetDescendants()) do
            if state then
                if v:IsA("BasePart") then
                    v.Material = Enum.Material.SmoothPlastic
                    v.Reflectance = 0
                elseif v:IsA("Decal") or v:IsA("Texture") then
                    v.Transparency = 1
                end
            end
        end
        if state then
            Lighting.GlobalShadows = false
            Lighting.FogEnd = 9e9
            settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
        end
    end)
end

SubmitBtn.MouseButton1Click:Connect(function()
    if KeyBox.Text == "ASTRO-2026-KEY" then
        LoadAstroHub()
    else
        KeyBox.Text = ""
        KeyBox.PlaceholderText = "Wrong Key! Try Again"
    end
end)
