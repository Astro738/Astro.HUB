-- [[ Astro Hub V25.1 - Ultimate Cosmic Edition (Fly Speed Fixed) ]] --
-- [[ Auto Game Info & Live Friends Detection Included ]] --

if setfpscap then
    pcall(function() setfpscap(240) end)
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
local MarketplaceService = game:GetService("MarketplaceService")
local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera

-- 🔑 نظام حفظ المفتاح لمدة 24 ساعة
local KeyFileName = "AstroHub_KeySave.txt"
local ValidKey = "ASTRO-2026-KEY"
local KeyDuration = 86400

local function SaveKeyData(key)
    if writefile then
        pcall(function()
            local data = key .. "|" .. tostring(os.time())
            writefile(KeyFileName, data)
        end)
    end
end

local function IsSavedKeyValid()
    if readfile and isfile and isfile(KeyFileName) then
        local success, content = pcall(function() return readfile(KeyFileName) end)
        if success and content then
            local key, savedTime = string.match(content, "([^|]+)|(%d+)")
            if key == ValidKey and savedTime then
                local currentTime = os.time()
                if (currentTime - tonumber(savedTime)) < KeyDuration then
                    return true
                end
            end
        end
    end
    return false
end

-- 🛡️ تصفير العمليات في الخلفية
getgenv().AstroRunning = false

local function KillAllConnections()
    getgenv().AstroRunning = false
    pcall(function()
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
    end)
end

KillAllConnections()

if CoreGui:FindFirstChild("AstroHubGui") then
    CoreGui.AstroHubGui:Destroy()
end
if CoreGui:FindFirstChild("AstroKeyGui") then
    CoreGui.AstroKeyGui:Destroy()
end

getgenv().AutoReconnectState = false
pcall(function()
    CoreGui.RobloxPromptGui.promptOverlay.ChildAdded:Connect(function(child)
        if child.Name == 'ErrorPrompt' and getgenv().AutoReconnectState then
            task.wait(1)
            TeleportService:Teleport(game.PlaceId, LocalPlayer)
        end
    end)
end)

local function PlayClickSound()
    pcall(function()
        local sound = Instance.new("Sound")
        sound.SoundId = "rbxassetid://6042457221"
        sound.Volume = 0.5
        sound.Parent = SoundService
        sound:Play()
        game:GetService("Debris"):AddItem(sound, 1)
    end)
end

local function LoadAstroHub()
    PlayClickSound()
    if CoreGui:FindFirstChild("AstroKeyGui") then
        CoreGui.AstroKeyGui:Destroy()
    end
    getgenv().AstroRunning = true

    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "AstroHubGui"
    ScreenGui.Parent = CoreGui
    ScreenGui.IgnoreGuiInset = true

    -- زر الكوكب الفضائي العائم 🪐
    local OpenBtn = Instance.new("TextButton")
    OpenBtn.Size = UDim2.new(0, 55, 0, 55)
    OpenBtn.Position = UDim2.new(0, 20, 0.5, -28)
    OpenBtn.BackgroundColor3 = Color3.fromRGB(10, 15, 30)
    OpenBtn.BackgroundTransparency = 0.1
    OpenBtn.TextColor3 = Color3.fromRGB(0, 180, 255)
    OpenBtn.Text = "🪐"
    OpenBtn.TextSize = 28
    OpenBtn.Font = Enum.Font.GothamBold
    OpenBtn.Parent = ScreenGui

    local OpenCorner = Instance.new("UICorner")
    OpenCorner.CornerRadius = UDim.new(1, 0)
    OpenCorner.Parent = OpenBtn

    local OpenStroke = Instance.new("UIStroke")
    OpenStroke.Color = Color3.fromRGB(0, 150, 255)
    OpenStroke.Thickness = 2.5
    OpenStroke.Parent = OpenBtn

    -- تحريك زر الكوكب العائم
    local dragOpen, dragStartOpen, startPosOpen
    OpenBtn.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragOpen = true
            dragStartOpen = input.Position
            startPosOpen = OpenBtn.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragOpen = false
                end
            end)
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if dragOpen and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStartOpen
            OpenBtn.Position = UDim2.new(startPosOpen.X.Scale, startPosOpen.X.Offset + delta.X, startPosOpen.Y.Scale, startPosOpen.Y.Offset + delta.Y)
        end
    end)

    -- الواجهة الرئيسية الفضائية 🌌
    local MainFrame = Instance.new("Frame")
    MainFrame.Size = UDim2.new(0, 540, 0, 380)
    MainFrame.Position = UDim2.new(0.5, -270, 0.5, -190)
    MainFrame.BackgroundColor3 = Color3.fromRGB(10, 14, 25)
    MainFrame.BackgroundTransparency = 0.08
    MainFrame.BorderSizePixel = 0
    MainFrame.Visible = true
    MainFrame.Parent = ScreenGui

    local MainCorner = Instance.new("UICorner")
    MainCorner.CornerRadius = UDim.new(0, 14)
    MainCorner.Parent = MainFrame

    local MainStroke = Instance.new("UIStroke")
    MainStroke.Color = Color3.fromRGB(0, 130, 255)
    MainStroke.Thickness = 2.5
    MainStroke.Parent = MainFrame

    local TopBar = Instance.new("Frame")
    TopBar.Size = UDim2.new(1, 0, 0, 42)
    TopBar.BackgroundColor3 = Color3.fromRGB(15, 22, 40)
    TopBar.BackgroundTransparency = 0.2
    TopBar.BorderSizePixel = 0
    TopBar.Parent = MainFrame

    local TopCorner = Instance.new("UICorner")
    TopCorner.CornerRadius = UDim.new(0, 14)
    TopCorner.Parent = TopBar

    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(0, 300, 1, 0)
    Title.Position = UDim2.new(0, 15, 0, 0)
    Title.BackgroundTransparency = 1
    Title.Text = "🌌 Astro Hub | Cosmic Edition 🚀"
    Title.TextColor3 = Color3.fromRGB(0, 190, 255)
    Title.TextSize = 14
    Title.Font = Enum.Font.GothamBold
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.Parent = TopBar

    -- 🖱️ سحب وتحريك اللوحة عبر الشريط العلوي
    local dragging, dragInput, dragStart, startPos
    TopBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = MainFrame.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    TopBar.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)

    -- زر الإغلاق حرف X
    local CloseBtn = Instance.new("TextButton")
    CloseBtn.Size = UDim2.new(0, 30, 0, 30)
    CloseBtn.Position = UDim2.new(1, -35, 0, 6)
    CloseBtn.BackgroundColor3 = Color3.fromRGB(220, 50, 50)
    CloseBtn.Text = "X"
    CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    CloseBtn.TextSize = 15
    CloseBtn.Font = Enum.Font.GothamBold
    CloseBtn.Parent = TopBar

    local CloseCorner = Instance.new("UICorner")
    CloseCorner.CornerRadius = UDim.new(0, 6)
    CloseCorner.Parent = CloseBtn

    -- زر التصغير/التكبير حرف —
    local MinimizeBtn = Instance.new("TextButton")
    MinimizeBtn.Size = UDim2.new(0, 30, 0, 30)
    MinimizeBtn.Position = UDim2.new(1, -70, 0, 6)
    MinimizeBtn.BackgroundColor3 = Color3.fromRGB(35, 65, 110)
    MinimizeBtn.Text = "—"
    MinimizeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    MinimizeBtn.TextSize = 15
    MinimizeBtn.Font = Enum.Font.GothamBold
    MinimizeBtn.Parent = TopBar

    local MinCorner = Instance.new("UICorner")
    MinCorner.CornerRadius = UDim.new(0, 6)
    MinCorner.Parent = MinimizeBtn

    OpenBtn.MouseButton1Click:Connect(function() PlayClickSound() MainFrame.Visible = not MainFrame.Visible end)
    CloseBtn.MouseButton1Click:Connect(function() PlayClickSound() MainFrame.Visible = false end)

    local Sidebar = Instance.new("ScrollingFrame")
    Sidebar.Size = UDim2.new(0, 150, 1, -42)
    Sidebar.Position = UDim2.new(0, 0, 0, 42)
    Sidebar.BackgroundColor3 = Color3.fromRGB(12, 18, 30)
    Sidebar.BackgroundTransparency = 0.3
    Sidebar.BorderSizePixel = 0
    Sidebar.CanvasSize = UDim2.new(0, 0, 0, 450)
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

    local minimized = false
    MinimizeBtn.MouseButton1Click:Connect(function()
        PlayClickSound()
        minimized = not minimized
        ContentArea.Visible = not minimized
        Sidebar.Visible = not minimized
        if minimized then
            MainFrame.Size = UDim2.new(0, 540, 0, 42)
            MinimizeBtn.Text = "+"
        else
            MainFrame.Size = UDim2.new(0, 540, 0, 380)
            MinimizeBtn.Text = "—"
        end
    end)

    local pages = {}
    local function CreatePage(name)
        local scrolling = Instance.new("ScrollingFrame")
        scrolling.Size = UDim2.new(1, 0, 1, 0)
        scrolling.BackgroundTransparency = 1
        scrolling.CanvasSize = UDim2.new(0, 0, 0, 650)
        scrolling.ScrollBarThickness = 4
        scrolling.ScrollBarImageColor3 = Color3.fromRGB(0, 150, 255)
        scrolling.Visible = false
        scrolling.Parent = ContentArea

        local layout = Instance.new("UIListLayout")
        layout.Padding = UDim.new(0, 8)
        layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
        layout.Parent = scrolling

        local sideBtn = Instance.new("TextButton")
        sideBtn.Size = UDim2.new(0.9, 0, 0, 38)
        sideBtn.BackgroundColor3 = Color3.fromRGB(20, 30, 50)
        sideBtn.BackgroundTransparency = 0.3
        sideBtn.TextColor3 = Color3.fromRGB(100, 200, 255)
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

    -- 🔘 دالة إنشاء الأزرار بتصميم "دقمة" (Switch Toggle)
    local function CreateToggle(parentPage, name, callback)
        local container = Instance.new("Frame")
        container.Size = UDim2.new(0.95, 0, 0, 38)
        container.BackgroundColor3 = Color3.fromRGB(18, 25, 42)
        container.BackgroundTransparency = 0.2
        container.Parent = parentPage

        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, 8)
        corner.Parent = container

        local stroke = Instance.new("UIStroke")
        stroke.Color = Color3.fromRGB(0, 120, 220)
        stroke.Thickness = 1.2
        stroke.Parent = container

        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(1, -60, 1, 0)
        label.Position = UDim2.new(0, 12, 0, 0)
        label.BackgroundTransparency = 1
        label.Text = name
        label.TextColor3 = Color3.fromRGB(180, 230, 255)
        label.TextSize = 12
        label.Font = Enum.Font.GothamBold
        label.TextXAlignment = Enum.TextXAlignment.Left
        label.Parent = container

        local toggleBtn = Instance.new("TextButton")
        toggleBtn.Size = UDim2.new(0, 42, 0, 22)
        toggleBtn.Position = UDim2.new(1, -50, 0.5, -11)
        toggleBtn.BackgroundColor3 = Color3.fromRGB(40, 55, 80)
        toggleBtn.Text = ""
        toggleBtn.Parent = container

        local tCorner = Instance.new("UICorner")
        tCorner.CornerRadius = UDim.new(1, 0)
        tCorner.Parent = toggleBtn

        local indicator = Instance.new("Frame")
        indicator.Size = UDim2.new(0, 18, 0, 18)
        indicator.Position = UDim2.new(0, 2, 0.5, -9)
        indicator.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
        indicator.Parent = toggleBtn

        local iCorner = Instance.new("UICorner")
        iCorner.CornerRadius = UDim.new(1, 0)
        iCorner.Parent = indicator

        local active = false
        toggleBtn.MouseButton1Click:Connect(function()
            PlayClickSound()
            active = not active
            if active then
                toggleBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
                indicator:TweenPosition(UDim2.new(1, -20, 0.5, -9), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.15, true)
                indicator.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            else
                toggleBtn.BackgroundColor3 = Color3.fromRGB(40, 55, 80)
                indicator:TweenPosition(UDim2.new(0, 2, 0.5, -9), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.15, true)
                indicator.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
            end
            callback(active)
        end)
    end

    -- 🎚️ دالة إنشاء السلايدر المصغر والأنيق (Compact Slider)
    local function CreateSlider(parentPage, name, minVal, maxVal, defaultVal, callback)
        local frame = Instance.new("Frame")
        frame.Size = UDim2.new(0.95, 0, 0, 42)
        frame.BackgroundColor3 = Color3.fromRGB(18, 25, 42)
        frame.BackgroundTransparency = 0.2
        frame.Parent = parentPage

        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, 8)
        corner.Parent = frame

        local stroke = Instance.new("UIStroke")
        stroke.Color = Color3.fromRGB(0, 120, 220)
        stroke.Thickness = 1.2
        stroke.Parent = frame

        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(1, -20, 0, 18)
        label.Position = UDim2.new(0, 10, 0, 3)
        label.BackgroundTransparency = 1
        label.Text = name .. ": " .. tostring(defaultVal)
        label.TextColor3 = Color3.fromRGB(130, 210, 255)
        label.TextSize = 11
        label.Font = Enum.Font.GothamBold
        label.TextXAlignment = Enum.TextXAlignment.Left
        label.Parent = frame

        local sliderBg = Instance.new("Frame")
        sliderBg.Size = UDim2.new(0.92, 0, 0, 6)
        sliderBg.Position = UDim2.new(0.04, 0, 0.72, 0)
        sliderBg.BackgroundColor3 = Color3.fromRGB(30, 45, 70)
        sliderBg.BorderSizePixel = 0
        sliderBg.Parent = frame

        local sliderCorner = Instance.new("UICorner")
        sliderCorner.CornerRadius = UDim.new(1, 0)
        sliderCorner.Parent = sliderBg

        local fill = Instance.new("Frame")
        fill.Size = UDim2.new((defaultVal - minVal)/(maxVal - minVal), 0, 1, 0)
        fill.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
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

    local PageHome = CreatePage("🛰️ Home & Stats")
    local PagePlayer = CreatePage("👨‍🚀 Player & Speed")
    local PageCombat = CreatePage("🎯 Aimbot & Combat")
    local PageTeleport = CreatePage("🌌 Player TP")
    local PageDetect = CreatePage("💎 Eggs & Rarities")
    local PageBoss = CreatePage("👾 Boss Finder")
    local PageVisual = CreatePage("👁️ ESP & Visuals")
    local PagePerf = CreatePage("⚡ Performance")

    -- ⚡ متغيرات التحكم بالسرعة والطيران (معرفة بالأعلى)
    local speedActive = false
    local speedVal = 16
    local speedConn
    local flying = false
    local flySpeed = 50
    local bv, bg

    -- ⚡ قسم السرعة المصغر في بداية القائمة
    CreateToggle(PagePlayer, "⚡ Enable Custom Speed", function(state)
        speedActive = state
        if speedActive then
            speedConn = RunService.RenderStepped:Connect(function()
                if not getgenv().AstroRunning then return end
                if LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
                    LocalPlayer.Character:FindFirstChildOfClass("Humanoid").WalkSpeed = speedVal
                end
            end)
        else
            if speedConn then speedConn:Disconnect() end
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
                LocalPlayer.Character:FindFirstChildOfClass("Humanoid").WalkSpeed = 16
            end
        end
    end)

    CreateSlider(PagePlayer, "👟 WalkSpeed Boost", 16, 2000, 16, function(val)
        speedVal = val
    end)

    -- 🛸 زر وسلايدر سرعة الطيران (مضبوط ومربوط 100%)
    CreateToggle(PagePlayer, "🛸 Legendary Fly", function(state)
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

    CreateSlider(PagePlayer, "🚀 Fly Speed Boost", 20, 2000, 50, function(val)
        flySpeed = val
    end)

    CreateToggle(PagePlayer, "🥾 Infinite Jump", function(state)
        if state then
            _G.InfJump = UserInputService.JumpRequest:Connect(function()
                if not getgenv().AstroRunning then return end
                if LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
                    LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState(Enum.HumanoidStateType.Jumping)
                end
            end)
        else
            if _G.InfJump then _G.InfJump:Disconnect() end
        end
    end)

    CreateToggle(PagePlayer, "👻 Safe Noclip", function(state)
        if state then
            _G.NoclipConn = RunService.Stepped:Connect(function()
                if not getgenv().AstroRunning then return end
                if LocalPlayer.Character then
                    for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
                        if part:IsA("BasePart") then part.CanCollide = false end
                    end
                end
            end)
        else
            if _G.NoclipConn then _G.NoclipConn:Disconnect() end
            if LocalPlayer.Character then
                for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
                    if part:IsA("BasePart") then part.CanCollide = true end
                end
            end
        end
    end)

    -- 1️⃣ بطاقة الإحصائيات الفضائية
    local StatsCard = Instance.new("Frame")
    StatsCard.Size = UDim2.new(0.95, 0, 0, 130)
    StatsCard.BackgroundColor3 = Color3.fromRGB(20, 28, 48)
    StatsCard.BackgroundTransparency = 0.2
    StatsCard.Parent = PageHome

    local scCorner = Instance.new("UICorner")
    scCorner.CornerRadius = UDim.new(0, 10)
    scCorner.Parent = StatsCard

    local scStroke = Instance.new("UIStroke")
    scStroke.Color = Color3.fromRGB(0, 140, 255)
    scStroke.Thickness = 1.5
    scStroke.Parent = StatsCard

    local StatsText = Instance.new("TextLabel")
    StatsText.Size = UDim2.new(1, -20, 1, 0)
    StatsText.Position = UDim2.new(0, 10, 0, 0)
    StatsText.BackgroundTransparency = 1
    StatsText.Text = "⚡ FPS: --\n📡 Ping: -- ms\n💻 CPU: -- ms | 🎮 GPU: -- ms\n📍 Coords: X: 0, Y: 0, Z: 0"
    StatsText.TextColor3 = Color3.fromRGB(150, 220, 255)
    StatsText.TextSize = 13
    StatsText.Font = Enum.Font.GothamBold
    StatsText.TextXAlignment = Enum.TextXAlignment.Left
    StatsText.Parent = StatsCard

    -- 2️⃣ بطاقة تفاصيل الماب والأصدقاء الفضائية
    local GameCard = Instance.new("Frame")
    GameCard.Size = UDim2.new(0.95, 0, 0, 140)
    GameCard.BackgroundColor3 = Color3.fromRGB(20, 28, 48)
    GameCard.BackgroundTransparency = 0.2
    GameCard.Parent = PageHome

    local gcCorner = Instance.new("UICorner")
    gcCorner.CornerRadius = UDim.new(0, 10)
    gcCorner.Parent = GameCard

    local gcStroke = Instance.new("UIStroke")
    gcStroke.Color = Color3.fromRGB(0, 140, 255)
    gcStroke.Thickness = 1.5
    gcStroke.Parent = GameCard

    local GameText = Instance.new("TextLabel")
    GameText.Size = UDim2.new(1, -20, 1, 0)
    GameText.Position = UDim2.new(0, 10, 0, 0)
    GameText.BackgroundTransparency = 1
    GameText.Text = "🎮 Game: Loading...\n👤 Player: " .. LocalPlayer.DisplayName .. " (@" .. LocalPlayer.Name .. ")\n👥 Friends Here: Checking..."
    GameText.TextColor3 = Color3.fromRGB(150, 220, 255)
    GameText.TextSize = 12
    GameText.Font = Enum.Font.GothamBold
    GameText.TextXAlignment = Enum.TextXAlignment.Left
    GameText.Parent = GameCard

    task.spawn(function()
        local placeName = "Roblox Game"
        pcall(function()
            local info = MarketplaceService:GetProductInfo(game.PlaceId)
            if info and info.Name then placeName = info.Name end
        end)
        
        while getgenv().AstroRunning do
            local friendsList = {}
            for _, plr in pairs(Players:GetPlayers()) do
                if plr ~= LocalPlayer then
                    pcall(function()
                        if LocalPlayer:IsFriendsWith(plr.UserId) then
                            table.insert(friendsList, plr.DisplayName)
                        end
                    end)
                end
            end

            local friendsStr = #friendsList > 0 and table.concat(friendsList, ", ") or "No Friends In Server"
            GameText.Text = string.format("🎮 Game: %s\n👤 Player: %s (@%s)\n👥 Friends Here: %s", placeName, LocalPlayer.DisplayName, LocalPlayer.Name, friendsStr)
            task.wait(5)
        end
    end)

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

    -- زر ديسكورد فضائي فخم 🌌💬
    local DiscordBtn = Instance.new("TextButton")
    DiscordBtn.Size = UDim2.new(0.95, 0, 0, 45)
    DiscordBtn.BackgroundColor3 = Color3.fromRGB(0, 110, 220)
    DiscordBtn.BackgroundTransparency = 0.1
    DiscordBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    DiscordBtn.Text = "🚀 Join Astro Cosmic Discord 🌌"
    DiscordBtn.TextSize = 13
    DiscordBtn.Font = Enum.Font.GothamBold
    DiscordBtn.Parent = PageHome

    local dCorner = Instance.new("UICorner")
    dCorner.CornerRadius = UDim.new(0, 8)
    dCorner.Parent = DiscordBtn

    local dStroke = Instance.new("UIStroke")
    dStroke.Color = Color3.fromRGB(100, 200, 255)
    dStroke.Thickness = 1.5
    dStroke.Parent = DiscordBtn

    DiscordBtn.MouseButton1Click:Connect(function()
        PlayClickSound()
        if setclipboard then
            setclipboard("https://discord.gg/vnTrCe2GSU")
            DiscordBtn.Text = "✅ Link Copied! Welcome Aboard 🚀"
            task.wait(2.5)
            DiscordBtn.Text = "🚀 Join Astro Cosmic Discord 🌌"
        end
    end)

    CreateToggle(PageHome, "Auto Reconnect Server", function(state) getgenv().AutoReconnectState = state end)

    -- 🌌 ميزة الانتقال السلس للاعبين (Player Teleport List)
    local tpContainer = Instance.new("ScrollingFrame")
    tpContainer.Size = UDim2.new(0.95, 0, 1, -20)
    tpContainer.BackgroundTransparency = 1
    tpContainer.CanvasSize = UDim2.new(0, 0, 0, 0)
    tpContainer.ScrollBarThickness = 4
    tpContainer.ScrollBarImageColor3 = Color3.fromRGB(0, 150, 255)
    tpContainer.Parent = PageTeleport

    local tpLayout = Instance.new("UIListLayout")
    tpLayout.Padding = UDim.new(0, 8)
    tpLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    tpLayout.Parent = tpContainer

    task.spawn(function()
        while getgenv().AstroRunning do
            for _, child in pairs(tpContainer:GetChildren()) do
                if child:IsA("TextButton") then child:Destroy() end
            end

            for _, plr in pairs(Players:GetPlayers()) do
                if plr ~= LocalPlayer then
                    local pBtn = Instance.new("TextButton")
                    pBtn.Size = UDim2.new(1, 0, 0, 38)
                    pBtn.BackgroundColor3 = Color3.fromRGB(18, 25, 42)
                    pBtn.BackgroundTransparency = 0.2
                    pBtn.TextColor3 = Color3.fromRGB(150, 220, 255)
                    pBtn.Text = "🚀 TP to: " .. plr.DisplayName .. " (@" .. plr.Name .. ")"
                    pBtn.TextSize = 12
                    pBtn.Font = Enum.Font.GothamBold
                    pBtn.Parent = tpContainer

                    local pCorner = Instance.new("UICorner")
                    pCorner.CornerRadius = UDim.new(0, 8)
                    pCorner.Parent = pBtn

                    pBtn.MouseButton1Click:Connect(function()
                        PlayClickSound()
                        pcall(function()
                            if plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                                local targetHRP = plr.Character.HumanoidRootPart
                                local myHRP = LocalPlayer.Character.HumanoidRootPart
                                
                                for i = 0, 1, 0.1 do
                                    myHRP.CFrame = myHRP.CFrame:Lerp(targetHRP.CFrame + Vector3.new(0, 3, 0), i)
                                    task.wait(0.02)
                                end
                            end
                        end)
                    end)
                end
            end
            tpContainer.CanvasSize = UDim2.new(0, 0, 0, #Players:GetPlayers() * 45)
            task.wait(4)
        end
    end)

    local aimbotConn
    local maxAimbotDistance = 300
    local aimbotSmoothness = 0.35

    CreateToggle(PageCombat, "Aimbot (Smart Team Check)", function(state)
        if aimbotConn then aimbotConn:Disconnect() aimbotConn = nil end
        if state then
            aimbotConn = RunService.RenderStepped:Connect(function()
                if not getgenv().AstroRunning then return end
                
                local closestHead = nil
                local shortestDist = math.huge
                local screenCenter = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
                local myChar = LocalPlayer.Character
                local myHrp = myChar and myChar:FindFirstChild("HumanoidRootPart")

                if not myHrp then return end

                for _, plr in pairs(Players:GetPlayers()) do
                    if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("Head") and plr.Character:FindFirstChildOfClass("Humanoid") and plr.Character:FindFirstChildOfClass("Humanoid").Health > 0 then
                        
                        local isTeamMate = false
                        if LocalPlayer.Team and plr.Team and LocalPlayer.Team == plr.Team then
                            isTeamMate = true
                        end

                        if not isTeamMate then
                            local targetHead = plr.Character.Head
                            local worldDist = (myHrp.Position - targetHead.Position).Magnitude
                            if worldDist <= maxAimbotDistance then
                                local headPos, onScreen = Camera:WorldToViewportPoint(targetHead.Position)
                                if onScreen then
                                    local screenDist = (Vector2.new(headPos.X, headPos.Y) - screenCenter).Magnitude
                                    if screenDist < shortestDist then
                                        shortestDist = screenDist
                                        closestHead = targetHead
                                    end
                                end
                            end
                        end
                    end
                end

                if closestHead then
                    local targetCFrame = CFrame.new(Camera.CFrame.Position, closestHead.Position)
                    Camera.CFrame = Camera.CFrame:Lerp(targetCFrame, aimbotSmoothness)
                end
            end)
        end
    end)

    local massiveHitboxActive = false
    CreateToggle(PageCombat, "Massive Giant Hitbox (Very Big)", function(state)
        massiveHitboxActive = state
        task.spawn(function()
            while massiveHitboxActive and getgenv().AstroRunning do
                for _, plr in pairs(Players:GetPlayers()) do
                    if plr ~= LocalPlayer then
                        local isTeamMate = (LocalPlayer.Team and plr.Team and LocalPlayer.Team == plr.Team)
                        if not isTeamMate and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                            pcall(function()
                                plr.Character.HumanoidRootPart.Size = Vector3.new(40, 40, 40)
                                plr.Character.HumanoidRootPart.Transparency = 0.85
                                plr.Character.HumanoidRootPart.CanCollide = false
                            end)
                        end
                    end
                end
                task.wait(1)
            end
            if not massiveHitboxActive then
                for _, plr in pairs(Players:GetPlayers()) do
                    if plr ~= LocalPlayer and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                        pcall(function()
                            plr.Character.HumanoidRootPart.Size = Vector3.new(2, 2, 1)
                            plr.Character.HumanoidRootPart.Transparency = 1
                        end)
                    end
                end
            end
        end)
    end)

    CreateSlider(PageCombat, "Aimbot Max Distance", 50, 1000, 300, function(val)
        maxAimbotDistance = val
    end)

    CreateSlider(PageCombat, "Aim Smoothness %", 10, 100, 35, function(val)
        aimbotSmoothness = val / 100
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
                                hl.FillColor = Color3.fromRGB(0, 150, 255)
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
                                hl.FillColor = Color3.fromRGB(0, 170, 255)
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
                                txt.TextColor3 = Color3.fromRGB(0, 200, 255)
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
    CreateToggle(PageVisual, "Player ESP (Smart Clean)", function(state)
        espActive = state
        task.spawn(function()
            while espActive and getgenv().AstroRunning do
                for _, plr in pairs(Players:GetPlayers()) do
                    if plr ~= LocalPlayer then
                        local char = plr.Character
                        local hum = char and char:FindFirstChildOfClass("Humanoid")
                        
                        if char and hum and hum.Health > 0 then
                            if not char:FindFirstChild("AstroHighlight") then
                                local hl = Instance.new("Highlight")
                                hl.Name = "AstroHighlight"
                                hl.FillColor = Color3.fromRGB(0, 130, 255)
                                hl.OutlineColor = Color3.fromRGB(255, 255, 255)
                                hl.Parent = char
                            end
                        else
                            if char and char:FindFirstChild("AstroHighlight") then
                                char.AstroHighlight:Destroy()
                            end
                        end
                    end
                end
                task.wait(0.2)
            end
            
            if not espActive then
                for _, plr in pairs(Players:GetPlayers()) do
                    if plr.Character and plr.Character:FindFirstChild("AstroHighlight") then
                        plr.Character.AstroHighlight:Destroy()
                    end
                end
            end
        end)
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

if IsSavedKeyValid() then
    LoadAstroHub()
else
    local KeyGui = Instance.new("ScreenGui")
    KeyGui.Name = "AstroKeyGui"
    KeyGui.Parent = CoreGui
    KeyGui.IgnoreGuiInset = true

    local KeyMain = Instance.new("Frame")
    KeyMain.Size = UDim2.new(0, 320, 0, 200)
    KeyMain.Position = UDim2.new(0.5, -160, 0.5, -100)
    KeyMain.BackgroundColor3 = Color3.fromRGB(10, 15, 30)
    KeyMain.BackgroundTransparency = 0.1
    KeyMain.BorderSizePixel = 0
    KeyMain.Parent = KeyGui

    local KeyCorner = Instance.new("UICorner")
    KeyCorner.CornerRadius = UDim.new(0, 16)
    KeyCorner.Parent = KeyMain

    local KeyStroke = Instance.new("UIStroke")
    KeyStroke.Color = Color3.fromRGB(0, 140, 255)
    KeyStroke.Thickness = 2.5
    KeyStroke.Parent = KeyMain

    local KeyTitle = Instance.new("TextLabel")
    KeyTitle.Size = UDim2.new(1, 0, 0, 40)
    KeyTitle.BackgroundTransparency = 1
    KeyTitle.Text = "🚀 Astro Cosmic System 🪐"
    KeyTitle.TextColor3 = Color3.fromRGB(0, 190, 255)
    KeyTitle.TextSize = 16
    KeyTitle.Font = Enum.Font.GothamBold
    KeyTitle.Parent = KeyMain

    local KeyBox = Instance.new("TextBox")
    KeyBox.Size = UDim2.new(0.8, 0, 0, 40)
    KeyBox.Position = UDim2.new(0.1, 0, 0.35, 0)
    KeyBox.BackgroundColor3 = Color3.fromRGB(20, 30, 50)
    KeyBox.BackgroundTransparency = 0.2
    KeyBox.TextColor3 = Color3.fromRGB(150, 220, 255)
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
    SubmitBtn.BackgroundColor3 = Color3.fromRGB(0, 130, 255)
    SubmitBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    SubmitBtn.Text = "Launch 🚀"
    SubmitBtn.TextSize = 15
    SubmitBtn.Font = Enum.Font.GothamBold
    SubmitBtn.Parent = KeyMain

    local BtnCorner = Instance.new("UICorner")
    BtnCorner.CornerRadius = UDim.new(0, 10)
    BtnCorner.Parent = SubmitBtn

    SubmitBtn.MouseButton1Click:Connect(function()
        if KeyBox.Text == ValidKey then
            SaveKeyData(ValidKey)
            LoadAstroHub()
        else
            PlayClickSound()
            KeyBox.Text = ""
            KeyBox.PlaceholderText = "Wrong Key! Try Again"
        end
    end)
end
