-- [[ Astro Hub - Optimized for Delta / Low-End Devices ]]
-- [[ Theme: Icy & Snow ]]
-- [[ Key System Enabled: ASTRO-2026-KEY ]]

local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

-- حماية السكربت والتحقق من التكرار
if CoreGui:FindFirstChild("AstroHubGui") then
    CoreGui.AstroHubGui:Destroy()
end

-- واجهة التحقق من المفتاح (Key System)
local KeyGui = Instance.new("ScreenGui")
KeyGui.Name = "AstroKeyGui"
KeyGui.Parent = CoreGui
KeyGui.IgnoreGuiInset = true

local KeyMain = Instance.new("Frame")
KeyMain.Size = UDim2.new(0, 320, 0, 200)
KeyMain.Position = UDim2.new(0.5, -160, 0.5, -100)
KeyMain.BackgroundColor3 = Color3.fromRGB(15, 25, 45)
KeyMain.BorderSizePixel = 0
KeyMain.Parent = KeyGui

local KeyCorner = Instance.new("UICorner")
KeyCorner.CornerRadius = UDim.new(0, 12)
KeyCorner.Parent = KeyMain

local KeyStroke = Instance.new("UIStroke")
KeyStroke.Color = Color3.fromRGB(100, 200, 255)
KeyStroke.Thickness = 2
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
KeyBox.BackgroundColor3 = Color3.fromRGB(25, 40, 70)
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
SubmitBtn.BackgroundColor3 = Color3.fromRGB(50, 150, 255)
SubmitBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SubmitBtn.Text = "Login"
SubmitBtn.TextSize = 15
SubmitBtn.Font = Enum.Font.GothamBold
SubmitBtn.Parent = KeyMain

local BtnCorner = Instance.new("UICorner")
BtnCorner.CornerRadius = UDim.new(0, 8)
BtnCorner.Parent = SubmitBtn

-- دالة تشغيل السكربت الرئيسي بعد تخطي المفتاح
local function LoadAstroHub()
    KeyGui:Destroy()

    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "AstroHubGui"
    ScreenGui.Parent = CoreGui
    ScreenGui.IgnoreGuiInset = true

    -- زر فتح وإغلاق القائمة العائم (Floating Button)
    local OpenBtn = Instance.new("TextButton")
    OpenBtn.Size = UDim2.new(0, 50, 0, 50)
    OpenBtn.Position = UDim2.new(0, 20, 0.5, -25)
    OpenBtn.BackgroundColor3 = Color3.fromRGB(20, 35, 60)
    OpenBtn.TextColor3 = Color3.fromRGB(150, 220, 255)
    OpenBtn.Text = "❄️"
    OpenBtn.TextSize = 22
    OpenBtn.Font = Enum.Font.GothamBold
    OpenBtn.Parent = ScreenGui

    local OpenCorner = Instance.new("UICorner")
    OpenCorner.CornerRadius = UDim.new(1, 0)
    OpenCorner.Parent = OpenBtn

    local OpenStroke = Instance.new("UIStroke")
    OpenStroke.Color = Color3.fromRGB(100, 200, 255)
    OpenStroke.Thickness = 2
    OpenStroke.Parent = OpenBtn

    -- اللوحة الرئيسية
    local MainFrame = Instance.new("Frame")
    MainFrame.Size = UDim2.new(0, 420, 0, 320)
    MainFrame.Position = UDim2.new(0.5, -210, 0.5, -160)
    MainFrame.BackgroundColor3 = Color3.fromRGB(15, 25, 45)
    MainFrame.BorderSizePixel = 0
    MainFrame.Visible = false
    MainFrame.Parent = ScreenGui

    local MainCorner = Instance.new("UICorner")
    MainCorner.CornerRadius = UDim.new(0, 14)
    MainCorner.Parent = MainFrame

    local MainStroke = Instance.new("UIStroke")
    MainStroke.Color = Color3.fromRGB(100, 200, 255)
    MainStroke.Thickness = 2
    MainStroke.Parent = MainFrame

    -- العنوان
    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, 0, 0, 45)
    Title.BackgroundTransparency = 1
    Title.Text = "❄️ Astro Hub | Low-End Optimizer ❄️"
    Title.TextColor3 = Color3.fromRGB(220, 240, 255)
    Title.TextSize = 16
    Title.Font = Enum.Font.GothamBold
    Title.Parent = MainFrame

    -- زر الإغلاق (X)
    local CloseBtn = Instance.new("TextButton")
    CloseBtn.Size = UDim2.new(0, 30, 0, 30)
    CloseBtn.Position = UDim2.new(1, -35, 0, 8)
    CloseBtn.BackgroundTransparency = 1
    CloseBtn.Text = "✕"
    CloseBtn.TextColor3 = Color3.fromRGB(200, 50, 50)
    CloseBtn.TextSize = 18
    CloseBtn.Font = Enum.Font.GothamBold
    CloseBtn.Parent = MainFrame

    -- سحب القائمة عبر اللمس
    local dragging, dragInput, dragStart, startPos
    MainFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
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
    MainFrame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)

    OpenBtn.MouseButton1Click:Connect(function()
        MainFrame.Visible = not MainFrame.Visible
    end)
    CloseBtn.MouseButton1Click:Connect(function()
        MainFrame.Visible = false
    end)

    -- حاوية الأزرار
    local Container = Instance.new("ScrollingFrame")
    Container.Size = UDim2.new(1, -20, 1, -60)
    Container.Position = UDim2.new(0, 10, 0, 50)
    Container.BackgroundTransparency = 1
    Container.CanvasSize = UDim2.new(0, 0, 0, 400)
    Container.ScrollBarThickness = 4
    Container.Parent = MainFrame

    local UIList = Instance.new("UIListLayout")
    UIList.Padding = UDim.new(0, 10)
    UIList.HorizontalAlignment = Enum.HorizontalAlignment.Center
    UIList.Parent = Container

    -- دالة إنشاء أزرار التبديل
    local function CreateToggle(name, callback)
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(0.95, 0, 0, 42)
        btn.BackgroundColor3 = Color3.fromRGB(25, 40, 70)
        btn.TextColor3 = Color3.fromRGB(200, 230, 255)
        btn.Text = name .. ": OFF"
        btn.TextSize = 14
        btn.Font = Enum.Font.GothamBold
        btn.Parent = Container

        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, 8)
        corner.Parent = btn

        local active = false
        btn.MouseButton1Click:Connect(function()
            active = not active
            if active then
                btn.BackgroundColor3 = Color3.fromRGB(40, 100, 160)
                btn.Text = name .. ": ON"
            else
                btn.BackgroundColor3 = Color3.fromRGB(25, 40, 70)
                btn.Text = name .. ": OFF"
            end
            callback(active)
        end)
    end

    -- 1. Potato Mode (تحسين الأداء وإزالة القواميس)
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
        if state and lighting then
            settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
        end
    end)

    -- 2. Infinite Jump (قفز لا نهائي)
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

    -- 3. Noclip (اختراق الجدران)
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

    -- 4. Speed Up (تعديل السرعة حتى 500)
    local speedConn
    CreateToggle("Speed Boost (500)", function(state)
        if state then
            speedConn = RunService.RenderStepped:Connect(function()
                if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    local hum = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
                    if hum and hum.MoveDirection.Magnitude > 0 then
                        LocalPlayer.Character.HumanoidRootPart.CFrame = LocalPlayer.Character.HumanoidRootPart.CFrame + (hum.MoveDirection * 2)
                    end
                end
            end)
        else
            if speedConn then speedConn:Disconnect() end
        end
    end)
end

-- التحقق من المفتاح عند الضغط
SubmitBtn.MouseButton1Click:Connect(function()
    if KeyBox.Text == "ASTRO-2026-KEY" then
        LoadAstroHub()
    else
        KeyBox.Text = ""
        KeyBox.PlaceholderText = "Wrong Key! Try Again"
    end
end)
