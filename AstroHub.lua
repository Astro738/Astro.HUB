-- [[ Astro Hub V4 - Max FPS & Full Control ]]
-- [[ Theme: Icy Glassmorphism ]]
-- [[ Key System Enabled: ASTRO-2026-KEY ]]

-- فك حد الـ FPS إلى 240 فريم فوراً
if setfpscap then
    setfpscap(240)
end

local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local Stats = game:GetService("Stats")
local LocalPlayer = Players.LocalPlayer

if CoreGui:FindFirstChild("AstroHubGui") then
    CoreGui.AstroHubGui:Destroy()
end

local KeyGui = Instance.new("ScreenGui")
KeyGui.Name = "AstroKeyGui"
KeyGui.Parent = CoreGui
KeyGui.IgnoreGuiInset = true

local KeyMain = Instance.new("Frame")
KeyMain.Size = UDim2.new(0, 320, 0, 200)
KeyMain.Position = UDim2.new(0.5, -160, 0.5, -100)
KeyMain.BackgroundColor3 = Color3.fromRGB(10, 20, 35)
KeyMain.BackgroundTransparency = 0.25
KeyMain.BorderSizePixel = 0
KeyMain.Parent = KeyGui

local KeyCorner = Instance.new("UICorner")
KeyCorner.CornerRadius = UDim.new(0, 16)
KeyCorner.Parent = KeyMain

local KeyStroke = Instance.new("UIStroke")
KeyStroke.Color = Color3.fromRGB(120, 220, 255)
KeyStroke.Thickness = 2
KeyStroke.Transparency = 0.3
KeyStroke.Parent = KeyMain

local KeyTitle = Instance.new("TextLabel")
KeyTitle.Size = UDim2.new(1, 0, 0, 40)
KeyTitle.BackgroundTransparency = 1
KeyTitle.Text = "❄️ Astro Hub - Key System ❄️"
KeyTitle.TextColor3 = Color3.fromRGB(230, 245, 255)
KeyTitle.TextSize = 16
KeyTitle.Font = Enum.Font.GothamBold
KeyTitle.Parent = KeyMain

local KeyBox = Instance.new("TextBox")
KeyBox.Size = UDim2.new(0.8, 0, 0, 40)
KeyBox.Position = UDim2.new(0.1, 0, 0.35, 0)
KeyBox.BackgroundColor3 = Color3.fromRGB(20, 35, 60)
KeyBox.BackgroundTransparency = 0.3
KeyBox.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyBox.PlaceholderText = "Enter Key (ASTRO-2026-KEY)"
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
SubmitBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
SubmitBtn.BackgroundTransparency = 0.2
SubmitBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SubmitBtn.Text = "Login"
SubmitBtn.TextSize = 15
SubmitBtn.Font = Enum.Font.GothamBold
SubmitBtn.Parent = KeyMain

local BtnCorner = Instance.new("UICorner")
BtnCorner.CornerRadius = UDim.new(0, 10)
BtnCorner.Parent = SubmitBtn

local function LoadAstroHub()
    KeyGui:Destroy()

    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "AstroHubGui"
    ScreenGui.Parent = CoreGui
    ScreenGui.IgnoreGuiInset = true

    -- شريط الإحصائيات (FPS | Ping | CPU | GPU)
    local StatsBar = Instance.new("Frame")
    StatsBar.Size = UDim2.new(0, 380, 0, 32)
    StatsBar.Position = UDim2.new(0.5, -190, 0, 12)
    StatsBar.BackgroundColor3 = Color3.fromRGB(10, 20, 35)
    StatsBar.BackgroundTransparency = 0.25
    StatsBar.BorderSizePixel = 0
    StatsBar.Parent = ScreenGui

    local StatsCorner = Instance.new("UICorner")
    StatsCorner.CornerRadius = UDim.new(0, 10)
    StatsCorner.Parent = StatsBar

    local StatsStroke = Instance.new("UIStroke")
    StatsStroke.Color = Color3.fromRGB(120, 220, 255)
    StatsStroke.Thickness = 1.5
    StatsStroke.Transparency = 0.3
    StatsStroke.Parent = StatsBar

    local StatsText = Instance.new("TextLabel")
    StatsText.Size = UDim2.new(1, 0, 1, 0)
    StatsText.BackgroundTransparency = 1
    StatsText.Text = "⚡ FPS: -- | 📡 Ping: --ms | 💻 CPU: --ms | 🎮 GPU: --ms"
    StatsText.TextColor3 = Color3.fromRGB(180, 235, 255)
    StatsText.TextSize = 12
    StatsText.Font = Enum.Font.GothamBold
    StatsText.Parent = StatsBar

    local lastUpdate = tick()
    local frameCount = 0
    RunService.RenderStepped:Connect(function()
        frameCount = frameCount + 1
        if tick() - lastUpdate >= 1 then
            local fps = frameCount
            local ping = math.floor(Stats.Network.ServerStatsItem["Data Ping"]:GetValue())
            local cpu = string.format("%.1f", Stats.PerformanceStats.CPU:GetValue())
            local gpu = string.format("%.1f", Stats.PerformanceStats.GPU:GetValue())
            
            StatsText.Text = string.format("⚡ FPS: %d  |  📡 Ping: %dms  |  💻 CPU: %sms  |  🎮 GPU: %sms", fps, ping, cpu, gpu)
            frameCount = 0
            lastUpdate = tick()
        end
    end)

    -- زر الفتح والإغلاق
    local OpenBtn = Instance.new("TextButton")
    OpenBtn.Size = UDim2.new(0, 50, 0, 50)
    OpenBtn.Position = UDim2.new(0, 20, 0.5, -25)
    OpenBtn.BackgroundColor3 = Color3.fromRGB(10, 20, 35)
    OpenBtn.BackgroundTransparency = 0.25
    OpenBtn.TextColor3 = Color3.fromRGB(150, 225, 255)
    OpenBtn.Text = "❄️"
    OpenBtn.TextSize = 22
    OpenBtn.Font = Enum.Font.GothamBold
    OpenBtn.Parent = ScreenGui

    local OpenCorner = Instance.new("UICorner")
    OpenCorner.CornerRadius = UDim.new(1, 0)
    OpenCorner.Parent = OpenBtn

    local OpenStroke = Instance.new("UIStroke")
    OpenStroke.Color = Color3.fromRGB(120, 220, 255)
    OpenStroke.Thickness = 1.5
    OpenStroke.Transparency = 0.3
    OpenStroke.Parent = OpenBtn

    -- اللوحة الرئيسية
    local MainFrame = Instance.new("Frame")
    MainFrame.Size = UDim2.new(0, 420, 0, 360)
    MainFrame.Position = UDim2.new(0.5, -210, 0.5, -180)
    MainFrame.BackgroundColor3 = Color3.fromRGB(10, 20, 35)
    MainFrame.BackgroundTransparency = 0.25
    MainFrame.BorderSizePixel = 0
    MainFrame.Visible = true
    MainFrame.Parent = ScreenGui

    local MainCorner = Instance.new("UICorner")
    MainCorner.CornerRadius = UDim.new(0, 16)
    MainCorner.Parent = MainFrame

    local MainStroke = Instance.new("UIStroke")
    MainStroke.Color = Color3.fromRGB(120, 220, 255)
    MainStroke.Thickness = 2
    MainStroke.Transparency = 0.3
    MainStroke.Parent = MainFrame

    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, 0, 0, 45)
    Title.BackgroundTransparency = 1
    Title.Text = "✨ Astro Hub | Glass Edition ✨"
    Title.TextColor3 = Color3.fromRGB(230, 245, 255)
    Title.TextSize = 16
    Title.Font = Enum.Font.GothamBold
    Title.Parent = MainFrame

    local CloseBtn = Instance.new("TextButton")
    CloseBtn.Size = UDim2.new(0, 30, 0, 30)
    CloseBtn.Position = UDim2.new(1, -35, 0, 8)
    CloseBtn.BackgroundTransparency = 1
    CloseBtn.Text = "✕"
    CloseBtn.TextColor3 = Color3.fromRGB(255, 80, 80)
    CloseBtn.TextSize = 18
    CloseBtn.Font = Enum.Font.GothamBold
    CloseBtn.Parent = MainFrame

    OpenBtn.MouseButton1Click:Connect(function()
        MainFrame.Visible = not MainFrame.Visible
    end)
    CloseBtn.MouseButton1Click:Connect(function()
        MainFrame.Visible = false
    end)

    local Container = Instance.new("ScrollingFrame")
    Container.Size = UDim2.new(1, -20, 1, -55)
    Container.Position = UDim2.new(0, 10, 0, 50)
    Container.BackgroundTransparency = 1
    Container.CanvasSize = UDim2.new(0, 0, 0, 420)
    Container.ScrollBarThickness = 5
    Container.ScrollBarImageColor3 = Color3.fromRGB(120, 220, 255)
    Container.Parent = MainFrame

    local UIList = Instance.new("UIListLayout")
    UIList.Padding = UDim.new(0, 10)
    UIList.HorizontalAlignment = Enum.HorizontalAlignment.Center
    UIList.Parent = Container

    local function CreateToggle(name, callback)
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(0.95, 0, 0, 40)
        btn.BackgroundColor3 = Color3.fromRGB(20, 35, 60)
        btn.BackgroundTransparency = 0.4
        btn.TextColor3 = Color3.fromRGB(210, 235, 255)
        btn.Text = name .. ": OFF"
        btn.TextSize = 14
        btn.Font = Enum.Font.GothamBold
        btn.Parent = Container

        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, 10)
        corner.Parent = btn

        local stroke = Instance.new("UIStroke")
        stroke.Color = Color3.fromRGB(100, 180, 255)
        stroke.Thickness = 1
        stroke.Transparency = 0.5
        stroke.Parent = btn

        local active = false
        btn.MouseButton1Click:Connect(function()
            active = not active
            if active then
                btn.BackgroundColor3 = Color3.fromRGB(0, 120, 220)
                btn.BackgroundTransparency = 0.2
                btn.Text = name .. ": ON"
            else
                btn.BackgroundColor3 = Color3.fromRGB(20, 35, 60)
                btn.BackgroundTransparency = 0.4
                btn.Text = name .. ": OFF"
            end
            callback(active)
        end)
    end

    -- دالة إنشاء سلايدر التحكم باللمس
    local function CreateSlider(name, minVal, maxVal, defaultVal, callback)
        local frame = Instance.new("Frame")
        frame.Size = UDim2.new(0.95, 0, 0, 50)
        frame.BackgroundColor3 = Color3.fromRGB(20, 35, 60)
        frame.BackgroundTransparency = 0.4
        frame.Parent = Container

        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, 10)
        corner.Parent = frame

        local stroke = Instance.new("UIStroke")
        stroke.Color = Color3.fromRGB(100, 180, 255)
        stroke.Thickness = 1
        stroke.Transparency = 0.5
        stroke.Parent = frame

        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(1, -20, 0, 22)
        label.Position = UDim2.new(0, 10, 0, 4)
        label.BackgroundTransparency = 1
        label.Text = name .. ": " .. tostring(defaultVal)
        label.TextColor3 = Color3.fromRGB(210, 235, 255)
        label.TextSize = 13
        label.Font = Enum.Font.GothamBold
        label.Parent = frame

        local sliderBg = Instance.new("Frame")
        sliderBg.Size = UDim2.new(0.9, 0, 0, 8)
        sliderBg.Position = UDim2.new(0.05, 0, 0.7, 0)
        sliderBg.BackgroundColor3 = Color3.fromRGB(10, 20, 35)
        sliderBg.BorderSizePixel = 0
        sliderBg.Parent = frame

        local bgCorner = Instance.new("UICorner")
        bgCorner.CornerRadius = UDim.new(1, 0)
        bgCorner.Parent = sliderBg

        local fill = Instance.new("Frame")
        fill.Size = UDim2.new((defaultVal - minVal)/(maxVal - minVal), 0, 1, 0)
        fill.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
        fill.BorderSizePixel = 0
        fill.Parent = sliderBg

        local fillCorner = Instance.new("UICorner")
        fillCorner.CornerRadius = UDim.new(1, 0)
        fillCorner.Parent = fill

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

    -- 1. Potato Mode (Boost FPS)
    CreateToggle("Potato Mode (Boost FPS)", function(state)
        for _, v in pairs(workspace:GetDescendants()) do
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

    -- 2. Infinite Jump
    local infJumpConn
    CreateToggle("Infinite Jump", function(state)
        if state then
            infJumpConn = UserInputService.JumpRequest:Connect(function()
                if LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
                    LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState(Enum.HumanoidStateType.Jumping)
                end
            end)
        else
            if infJumpConn then infJumpConn:Disconnect() end
        end
    end)

    -- 3. Noclip
    local noclipConn
    CreateToggle("Noclip", function(state)
        if state then
            noclipConn = RunService.Stepped:Connect(function()
                if LocalPlayer.Character then
                    for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
                        if part:IsA("BasePart") then
                            part.CanCollide = false
                        end
                    end
                end
            end)
        else
            if noclipConn then noclipConn:Disconnect() end
        end
    end)

    -- 4. WalkSpeed Slider (تحكم السرعة)
    CreateSlider("Walk Speed", 16, 500, 16, function(val)
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
            LocalPlayer.Character:FindFirstChildOfClass("Humanoid").WalkSpeed = val
        end
    end)

    -- 5. JumpPower Slider (تحكم القفز)
    CreateSlider("Jump Power", 50, 300, 50, function(val)
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
            LocalPlayer.Character:FindFirstChildOfClass("Humanoid").JumpPower = val
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
