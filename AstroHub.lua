if setfpscap then pcall(function() setfpscap(240); end); end

local _0g1 = game:GetService("CoreGui")
local _0g2 = game:GetService("Players")
local _0g3 = game:GetService("RunService")
local _0g4 = game:GetService("UserInputService")
local _0g5 = game:GetService("Lighting")
local _0g6 = game:GetService("Stats")
local _0g7 = game:GetService("Workspace")
local _0g8 = game:GetService("TeleportService")
local _0g9 = game:GetService("SoundService")
local _0g10 = game:GetService("MarketplaceService")
local _0p1 = _0g2.LocalPlayer
local _0c1 = _0g7.CurrentCamera

local function _dec(_t)
    local _s = ""
    for _, _b in ipairs(_t) do
        _s = _s .. string.char(_b)
    end
    return _s
end

local _k1 = _dec({65, 115, 116, 114, 111, 72, 117, 98, 95, 75, 101, 121, 83, 97, 118, 101, 46, 116, 120, 116})
local _k2 = _dec({65, 83, 84, 82, 79, 45, 50, 48, 50, 54, 45, 75, 69, 89})
local _lnk = _dec({104, 116, 116, 112, 115, 58, 47, 47, 100, 105, 115, 99, 111, 114, 100, 46, 103, 103, 47, 118, 110, 84, 114, 67, 101, 50, 71, 83, 89})
local _dur = 86400

local function _f1(_v)
    if writefile then
        pcall(function()
            local _d = _v .. "|" .. tostring(os.time())
            writefile(_k1, _d)
        end)
    end
end

local function _f2()
    if (readfile and isfile and isfile(_k1)) then
        local _s, _c = pcall(function() return readfile(_k1) end)
        if (_s and _c) then
            local _kk, _gt = string.match(_c, "([^|]+)|(%d+)")
            if ((_kk == _k2) and _gt) then
                local _ct = os.time()
                if ((_ct - tonumber(_gt)) < _dur) then
                    return true
                end
            end
        end
    end
    return false
end

getgenv().AstroRunning = false
getgenv().SpamTPTarget = nil
getgenv().VoidTrollTarget = nil

local function _f3()
    getgenv().AstroRunning = false
    getgenv().SpamTPTarget = nil
    getgenv().VoidTrollTarget = nil
    pcall(function()
        if _0p1.Character then
            local _h = _0p1.Character:FindFirstChildOfClass("Humanoid")
            if _h then 
                _h.PlatformStand = false 
                _h:SetStateEnabled(Enum.HumanoidStateType.Seated, true)
            end
            local _r = _0p1.Character:FindFirstChild("HumanoidRootPart")
            if _r then _r.AssemblyLinearVelocity = Vector3.new(0,0,0) end
        end
        for _, _o in pairs(_0g7:GetDescendants()) do
            if ((_o.Name == "AstroHighlight") or (_o.Name == "AstroEggHighlight") or (_o.Name == "AstroBossHighlight") or (_o.Name == "AstroBossTag")) then
                _o:Destroy()
            end
        end
        if _0p1.Character then
            for _, _p in pairs(_0p1.Character:GetDescendants()) do
                if _p:IsA("BasePart") then _p.CanCollide = true end
            end
        end
    end)
end

_f3()

if _0g1:FindFirstChild("AstroHubGui") then _0g1.AstroHubGui:Destroy() end
if _0g1:FindFirstChild("AstroKeyGui") then _0g1.AstroKeyGui:Destroy() end

getgenv().AutoReconnectState = false

pcall(function()
    _0g1.RobloxPromptGui.promptOverlay.ChildAdded:Connect(function(_ch)
        if ((_ch.Name == "ErrorPrompt") and getgenv().AutoReconnectState) then
            task.wait(1)
            _0g8:Teleport(game.PlaceId, _0p1)
        end
    end)
end)

local function _snd()
    pcall(function()
        local _sd = Instance.new("Sound")
        _sd.SoundId = "rbxassetid://6042457221"
        _sd.Volume = 0.5
        _sd.Parent = _0g9
        _sd:Play()
        game:GetService("Debris"):AddItem(_sd, 1)
    end)
end

local function _loadHub()
    _snd()
    if _0g1:FindFirstChild("AstroKeyGui") then _0g1.AstroKeyGui:Destroy() end
    getgenv().AstroRunning = true
    
    local _gui = Instance.new("ScreenGui")
    _gui.Name = "AstroHubGui"
    _gui.Parent = _0g1
    _gui.IgnoreGuiInset = true

    local _btn = Instance.new("TextButton")
    _btn.Size = UDim2.new(0, 55, 0, 55)
    _btn.Position = UDim2.new(0, 20, 0.5, -28)
    _btn.BackgroundColor3 = Color3.fromRGB(10, 15, 30)
    _btn.BackgroundTransparency = 0.1
    _btn.TextColor3 = Color3.fromRGB(0, 180, 255)
    _btn.Text = "🪐"
    _btn.TextSize = 28
    _btn.Font = Enum.Font.GothamBold
    _btn.Parent = _gui

    local _bc = Instance.new("UICorner")
    _bc.CornerRadius = UDim.new(1, 0)
    _bc.Parent = _btn

    local _bs = Instance.new("UIStroke")
    _bs.Color = Color3.fromRGB(0, 150, 255)
    _bs.Thickness = 2.5
    _bs.Parent = _btn

    local _dr, _ds, _dp
    _btn.InputBegan:Connect(function(_inp)
        if ((_inp.UserInputType == Enum.UserInputType.MouseButton1) or (_inp.UserInputType == Enum.UserInputType.Touch)) then
            _dr = true
            _ds = _inp.Position
            _dp = _btn.Position
            _inp.Changed:Connect(function()
                if (_inp.UserInputState == Enum.UserInputState.End) then _dr = false end
            end)
        end
    end)

    _0g4.InputChanged:Connect(function(_inp)
        if (_dr and ((_inp.UserInputType == Enum.UserInputType.MouseMovement) or (_inp.UserInputType == Enum.UserInputType.Touch))) then
            local _dl = _inp.Position - _ds
            _btn.Position = UDim2.new(_dp.X.Scale, _dp.X.Offset + _dl.X, _dp.Y.Scale, _dp.Y.Offset + _dl.Y)
        end
    end)

    local _mf = Instance.new("Frame")
    _mf.Size = UDim2.new(0, 540, 0, 380)
    _mf.Position = UDim2.new(0.5, -270, 0.5, -190)
    _mf.BackgroundColor3 = Color3.fromRGB(10, 14, 25)
    _mf.BackgroundTransparency = 0.08
    _mf.BorderSizePixel = 0
    _mf.Visible = true
    _mf.Parent = _gui

    local _mfc = Instance.new("UICorner")
    _mfc.CornerRadius = UDim.new(0, 14)
    _mfc.Parent = _mf

    local _mfs = Instance.new("UIStroke")
    _mfs.Color = Color3.fromRGB(0, 130, 255)
    _mfs.Thickness = 2.5
    _mfs.Parent = _mf

    local _tb = Instance.new("Frame")
    _tb.Size = UDim2.new(1, 0, 0, 42)
    _tb.BackgroundColor3 = Color3.fromRGB(15, 22, 40)
    _tb.BackgroundTransparency = 0.2
    _tb.BorderSizePixel = 0
    _tb.Parent = _mf

    local _tbc = Instance.new("UICorner")
    _tbc.CornerRadius = UDim.new(0, 14)
    _tbc.Parent = _tb

    local _ttl = Instance.new("TextLabel")
    _ttl.Size = UDim2.new(0, 300, 1, 0)
    _ttl.Position = UDim2.new(0, 15, 0, 0)
    _ttl.BackgroundTransparency = 1
    _ttl.Text = "🌌 Astro Hub | Cosmic Edition 🚀"
    _ttl.TextColor3 = Color3.fromRGB(0, 190, 255)
    _ttl.TextSize = 14
    _ttl.Font = Enum.Font.GothamBold
    _ttl.TextXAlignment = Enum.TextXAlignment.Left
    _ttl.Parent = _tb

    local _tdg, _tdi, _tds, _tdp
    _tb.InputBegan:Connect(function(_inp)
        if ((_inp.UserInputType == Enum.UserInputType.MouseButton1) or (_inp.UserInputType == Enum.UserInputType.Touch)) then
            _tdg = true
            _tds = _inp.Position
            _tdp = _mf.Position
            _inp.Changed:Connect(function()
                if (_inp.UserInputState == Enum.UserInputState.End) then _tdg = false end
            end)
        end
    end)

    _tb.InputChanged:Connect(function(_inp)
        if ((_inp.UserInputType == Enum.UserInputType.MouseMovement) or (_inp.UserInputType == Enum.UserInputType.Touch)) then
            _tdi = _inp
        end
    end)

    _0g4.InputChanged:Connect(function(_inp)
        if ((_inp == _tdi) and _tdg) then
            local _dl = _inp.Position - _tds
            _mf.Position = UDim2.new(_tdp.X.Scale, _tdp.X.Offset + _dl.X, _tdp.Y.Scale, _tdp.Y.Offset + _dl.Y)
        end
    end)

    local _cb = Instance.new("TextButton")
    _cb.Size = UDim2.new(0, 30, 0, 30)
    _cb.Position = UDim2.new(1, -35, 0, 6)
    _cb.BackgroundColor3 = Color3.fromRGB(220, 50, 50)
    _cb.Text = "X"
    _cb.TextColor3 = Color3.fromRGB(255, 255, 255)
    _cb.TextSize = 15
    _cb.Font = Enum.Font.GothamBold
    _cb.Parent = _tb

    local _cbc = Instance.new("UICorner")
    _cbc.CornerRadius = UDim.new(0, 6)
    _cbc.Parent = _cb

    local _mb = Instance.new("TextButton")
    _mb.Size = UDim2.new(0, 30, 0, 30)
    _mb.Position = UDim2.new(1, -70, 0, 6)
    _mb.BackgroundColor3 = Color3.fromRGB(35, 65, 110)
    _mb.Text = "—"
    _mb.TextColor3 = Color3.fromRGB(255, 255, 255)
    _mb.TextSize = 15
    _mb.Font = Enum.Font.GothamBold
    _mb.Parent = _tb

    local _mbc = Instance.new("UICorner")
    _mbc.CornerRadius = UDim.new(0, 6)
    _mbc.Parent = _mb

    _btn.MouseButton1Click:Connect(function()
        _snd()
        _mf.Visible = not _mf.Visible
    end)

    _cb.MouseButton1Click:Connect(function()
        _snd()
        _mf.Visible = false
    end)

    local _sb = Instance.new("ScrollingFrame")
    _sb.Size = UDim2.new(0, 150, 1, -42)
    _sb.Position = UDim2.new(0, 0, 0, 42)
    _sb.BackgroundColor3 = Color3.fromRGB(12, 18, 30)
    _sb.BackgroundTransparency = 0.3
    _sb.BorderSizePixel = 0
    _sb.CanvasSize = UDim2.new(0, 0, 0, 480)
    _sb.ScrollBarThickness = 2
    _sb.Parent = _mf

    local _sbl = Instance.new("UIListLayout")
    _sbl.Padding = UDim.new(0, 6)
    _sbl.HorizontalAlignment = Enum.HorizontalAlignment.Center
    _sbl.Parent = _sb

    local _ca = Instance.new("Frame")
    _ca.Size = UDim2.new(1, -155, 1, -45)
    _ca.Position = UDim2.new(0, 155, 0, 42)
    _ca.BackgroundTransparency = 1
    _ca.Parent = _mf

    local _isMin = false
    _mb.MouseButton1Click:Connect(function()
        _snd()
        _isMin = not _isMin
        _ca.Visible = not _isMin
        _sb.Visible = not _isMin
        if _isMin then
            _mf.Size = UDim2.new(0, 540, 0, 42)
            _mb.Text = "+"
        else
            _mf.Size = UDim2.new(0, 540, 0, 380)
            _mb.Text = "—"
        end
    end)

    local _pgs = {}
    local function _cp(_n)
        local _sc = Instance.new("ScrollingFrame")
        _sc.Size = UDim2.new(1, 0, 1, 0)
        _sc.BackgroundTransparency = 1
        _sc.CanvasSize = UDim2.new(0, 0, 0, 650)
        _sc.ScrollBarThickness = 4
        _sc.ScrollBarImageColor3 = Color3.fromRGB(0, 150, 255)
        _sc.Visible = false
        _sc.Parent = _ca

        local _ly = Instance.new("UIListLayout")
        _ly.Padding = UDim.new(0, 8)
        _ly.HorizontalAlignment = Enum.HorizontalAlignment.Center
        _ly.Parent = _sc

        local _sbtn = Instance.new("TextButton")
        _sbtn.Size = UDim2.new(0.9, 0, 0, 38)
        _sbtn.BackgroundColor3 = Color3.fromRGB(20, 30, 50)
        _sbtn.BackgroundTransparency = 0.3
        _sbtn.TextColor3 = Color3.fromRGB(100, 200, 255)
        _sbtn.Text = _n
        _sbtn.TextSize = 13
        _sbtn.Font = Enum.Font.GothamBold
        _sbtn.Parent = _sb

        local _stc = Instance.new("UICorner")
        _stc.CornerRadius = UDim.new(0, 8)
        _stc.Parent = _sbtn

        _sbtn.MouseButton1Click:Connect(function()
            _snd()
            for _, _p in pairs(_pgs) do _p.Visible = false end
            _sc.Visible = true
        end)

        table.insert(_pgs, _sc)
        if (#_pgs == 1) then _sc.Visible = true end
        return _sc
    end

    local function _ctg(_pp, _n, _cb)
        local _ct = Instance.new("Frame")
        _ct.Size = UDim2.new(0.95, 0, 0, 38)
        _ct.BackgroundColor3 = Color3.fromRGB(18, 25, 42)
        _ct.BackgroundTransparency = 0.2
        _ct.Parent = _pp

        local _cc = Instance.new("UICorner")
        _cc.CornerRadius = UDim.new(0, 8)
        _cc.Parent = _ct

        local _cstr = Instance.new("UIStroke")
        _cstr.Color = Color3.fromRGB(0, 120, 220)
        _cstr.Thickness = 1.2
        _cstr.Parent = _ct

        local _clbl = Instance.new("TextLabel")
        _clbl.Size = UDim2.new(1, -60, 1, 0)
        _clbl.Position = UDim2.new(0, 12, 0, 0)
        _clbl.BackgroundTransparency = 1
        _clbl.Text = _n
        _clbl.TextColor3 = Color3.fromRGB(180, 230, 255)
        _clbl.TextSize = 12
        _clbl.Font = Enum.Font.GothamBold
        _clbl.TextXAlignment = Enum.TextXAlignment.Left
        _clbl.Parent = _ct

        local _tgl = Instance.new("TextButton")
        _tgl.Size = UDim2.new(0, 42, 0, 22)
        _tgl.Position = UDim2.new(1, -50, 0.5, -11)
        _tgl.BackgroundColor3 = Color3.fromRGB(40, 55, 80)
        _tgl.Text = ""
        _tgl.Parent = _ct

        local _tgc = Instance.new("UICorner")
        _tgc.CornerRadius = UDim.new(1, 0)
        _tgc.Parent = _tgl

        local _ind = Instance.new("Frame")
        _ind.Size = UDim2.new(0, 18, 0, 18)
        _ind.Position = UDim2.new(0, 2, 0.5, -9)
        _ind.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
        _ind.Parent = _tgl

        local _indc = Instance.new("UICorner")
        _indc.CornerRadius = UDim.new(1, 0)
        _indc.Parent = _ind

        local _act = false
        _tgl.MouseButton1Click:Connect(function()
            _snd()
            _act = not _act
            if _act then
                _tgl.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
                _ind:TweenPosition(UDim2.new(1, -20, 0.5, -9), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.15, true)
                _ind.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            else
                _tgl.BackgroundColor3 = Color3.fromRGB(40, 55, 80)
                _ind:TweenPosition(UDim2.new(0, 2, 0.5, -9), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.15, true)
                _ind.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
            end
            _cb(_act)
        end)
    end

    local function _csld(_pp, _n, _min, _max, _def, _cb)
        local _fr = Instance.new("Frame")
        _fr.Size = UDim2.new(0.95, 0, 0, 42)
        _fr.BackgroundColor3 = Color3.fromRGB(18, 25, 42)
        _fr.BackgroundTransparency = 0.2
        _fr.Parent = _pp

        local _frc = Instance.new("UICorner")
        _frc.CornerRadius = UDim.new(0, 8)
        _frc.Parent = _fr

        local _frs = Instance.new("UIStroke")
        _frs.Color = Color3.fromRGB(0, 120, 220)
        _frs.Thickness = 1.2
        _frs.Parent = _fr

        local _lbl = Instance.new("TextLabel")
        _lbl.Size = UDim2.new(1, -20, 0, 18)
        _lbl.Position = UDim2.new(0, 10, 0, 3)
        _lbl.BackgroundTransparency = 1
        _lbl.Text = _n .. ": " .. tostring(_def)
        _lbl.TextColor3 = Color3.fromRGB(130, 210, 255)
        _lbl.TextSize = 11
        _lbl.Font = Enum.Font.GothamBold
        _lbl.TextXAlignment = Enum.TextXAlignment.Left
        _lbl.Parent = _fr

        local _sbg = Instance.new("Frame")
        _sbg.Size = UDim2.new(0.92, 0, 0, 6)
        _sbg.Position = UDim2.new(0.04, 0, 0.72, 0)
        _sbg.BackgroundColor3 = Color3.fromRGB(30, 45, 70)
        _sbg.BorderSizePixel = 0
        _sbg.Parent = _fr

        local _sbgc = Instance.new("UICorner")
        _sbgc.CornerRadius = UDim.new(1, 0)
        _sbgc.Parent = _sbg

        local _fl = Instance.new("Frame")
        _fl.Size = UDim2.new((_def - _min) / (_max - _min), 0, 1, 0)
        _fl.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
        _fl.BorderSizePixel = 0
        _fl.Parent = _sbg

        local _flc = Instance.new("UICorner")
        _flc.CornerRadius = UDim.new(1, 0)
        _flc.Parent = _fl

        local function _upd(_inp)
            local _pos = math.clamp((_inp.Position.X - _sbg.AbsolutePosition.X) / _sbg.AbsoluteSize.X, 0, 1)
            local _val = math.floor(_min + ((_max - _min) * _pos))
            _fl.Size = UDim2.new(_pos, 0, 1, 0)
            _lbl.Text = _n .. ": " .. tostring(_val)
            _cb(_val)
        end

        local _dsld = false
        _sbg.InputBegan:Connect(function(_inp)
            if ((_inp.UserInputType == Enum.UserInputType.MouseButton1) or (_inp.UserInputType == Enum.UserInputType.Touch)) then
                _dsld = true
                _snd()
                _upd(_inp)
            end
        end)

        _0g4.InputChanged:Connect(function(_inp)
            if (_dsld and ((_inp.UserInputType == Enum.UserInputType.MouseMovement) or (_inp.UserInputType == Enum.UserInputType.Touch))) then
                _upd(_inp)
            end
        end)

        _0g4.InputEnded:Connect(function(_inp)
            if ((_inp.UserInputType == Enum.UserInputType.MouseButton1) or (_inp.UserInputType == Enum.UserInputType.Touch)) then
                _dsld = false
            end
        end)
    end

    local _pHome = _cp("🛰️ Home & Stats")
    local _pPlayer = _cp("👨‍🚀 Player & Speed")
    local _pCombat = _cp("🎯 Aimbot & Combat")
    local _pTP = _cp("🌌 Player TP")
    local _pTroll = _cp("💥 Trolls & Void")
    local _pDetect = _cp("💎 Eggs & Rarities")
    local _pBoss = _cp("👾 Boss Finder")
    local _pVisual = _cp("👁️ ESP & Visuals")
    local _pPerf = _cp("⚡ Performance")

    local _sAct = false
    local _sVal = 16
    local _sConn
    local _fly = false
    local _flySpd = 50

    _ctg(_pPlayer, "⚡ Enable Custom Speed", function(_st)
        _sAct = _st
        if _sAct then
            _sConn = _0g3.RenderStepped:Connect(function()
                if not getgenv().AstroRunning then return end
                if (_0p1.Character and _0p1.Character:FindFirstChildOfClass("Humanoid")) then
                    _0p1.Character:FindFirstChildOfClass("Humanoid").WalkSpeed = _sVal
                end
            end)
        else
            if _sConn then _sConn:Disconnect() end
            if (_0p1.Character and _0p1.Character:FindFirstChildOfClass("Humanoid")) then
                _0p1.Character:FindFirstChildOfClass("Humanoid").WalkSpeed = 16
            end
        end
    end)

    _csld(_pPlayer, "👟 WalkSpeed Boost", 16, 2000, 16, function(_v) _sVal = _v end)

    _ctg(_pPlayer, "🛸 Pro Anti-Kick Fly", function(_st)
        _fly = _st
        local _ch = _0p1.Character
        if (not _ch or not _ch:FindFirstChild("HumanoidRootPart")) then return end
        local _hrp = _ch.HumanoidRootPart
        local _hum = _ch:FindFirstChildOfClass("Humanoid")
        if _fly then
            if _hum then
                _hum.PlatformStand = true
                pcall(function() _hum:ChangeState(Enum.HumanoidStateType.Swimming) end)
            end
            task.spawn(function()
                while _fly and getgenv().AstroRunning and _ch and _hrp.Parent do
                    _0g3.RenderStepped:Wait()
                    local _ccf = _0c1.CFrame
                    local _md = Vector3.new(0, 0, 0)
                    if (_hum and (_hum.MoveDirection.Magnitude > 0)) then _md = _hum.MoveDirection end
                    if (_0g4:IsKeyDown(Enum.KeyCode.W) or _0g4:IsKeyDown(Enum.KeyCode.Up)) then _md = _ccf.LookVector
                    elseif (_0g4:IsKeyDown(Enum.KeyCode.S) or _0g4:IsKeyDown(Enum.KeyCode.Down)) then _md = -_ccf.LookVector
                    elseif (_0g4:IsKeyDown(Enum.KeyCode.D) or _0g4:IsKeyDown(Enum.KeyCode.Right)) then _md = _ccf.RightVector
                    elseif (_0g4:IsKeyDown(Enum.KeyCode.A) or _0g4:IsKeyDown(Enum.KeyCode.Left)) then _md = -_ccf.RightVector end
                    if (_md.Magnitude > 0) then _hrp.AssemblyLinearVelocity = _md * _flySpd
                    else _hrp.AssemblyLinearVelocity = Vector3.new(0, 0, 0) end
                    if _hum then pcall(function() _hum:ChangeState(Enum.HumanoidStateType.Swimming) end) end
                end
                if _hrp then _hrp.AssemblyLinearVelocity = Vector3.new(0, 0, 0) end
            end)
        else
            if _hum then
                _hum.PlatformStand = false
                pcall(function() _hum:ChangeState(Enum.HumanoidStateType.GettingUp) end)
            end
            if _hrp then _hrp.AssemblyLinearVelocity = Vector3.new(0, 0, 0) end
        end
    end)

    _csld(_pPlayer, "🚀 Fly Speed Boost", 20, 2000, 50, function(_v) _flySpd = _v end)

    _ctg(_pPlayer, "🥾 Infinite Jump", function(_st)
        if _st then
            _G.InfJump = _0g4.JumpRequest:Connect(function()
                if not getgenv().AstroRunning then return end
                if (_0p1.Character and _0p1.Character:FindFirstChildOfClass("Humanoid")) then
                    _0p1.Character:FindFirstChildOfClass("Humanoid"):ChangeState(Enum.HumanoidStateType.Jumping)
                end
            end)
        elseif _G.InfJump then
            _G.InfJump:Disconnect()
        end
    end)

    _ctg(_pPlayer, "👻 Safe Noclip", function(_st)
        if _st then
            _G.NoclipConn = _0g3.Stepped:Connect(function()
                if not getgenv().AstroRunning then return end
                if _0p1.Character then
                    for _, _pt in pairs(_0p1.Character:GetDescendants()) do
                        if _pt:IsA("BasePart") then _pt.CanCollide = false end
                    end
                end
            end)
        else
            if _G.NoclipConn then _G.NoclipConn:Disconnect() end
            if _0p1.Character then
                for _, _pt in pairs(_0p1.Character:GetDescendants()) do
                    if _pt:IsA("BasePart") then _pt.CanCollide = true end
                end
            end
        end
    end)

    local _savedPos = nil
    local _wpFr = Instance.new("Frame")
    _wpFr.Size = UDim2.new(0.95, 0, 0, 42)
    _wpFr.BackgroundColor3 = Color3.fromRGB(18, 25, 42)
    _wpFr.BackgroundTransparency = 0.2
    _wpFr.Parent = _pPlayer

    local _wpCorner = Instance.new("UICorner")
    _wpCorner.CornerRadius = UDim.new(0, 8)
    _wpCorner.Parent = _wpFr

    local _wpStroke = Instance.new("UIStroke")
    _wpStroke.Color = Color3.fromRGB(0, 120, 220)
    _wpStroke.Thickness = 1.2
    _wpStroke.Parent = _wpFr

    local _btnSave = Instance.new("TextButton")
    _btnSave.Size = UDim2.new(0.46, 0, 0.8, 0)
    _btnSave.Position = UDim2.new(0.02, 0, 0.1, 0)
    _btnSave.BackgroundColor3 = Color3.fromRGB(0, 130, 255)
    _btnSave.Text = "📌 Save Position"
    _btnSave.TextColor3 = Color3.fromRGB(255, 255, 255)
    _btnSave.TextSize = 11
    _btnSave.Font = Enum.Font.GothamBold
    _btnSave.Parent = _wpFr

    local _btnSaveCorner = Instance.new("UICorner")
    _btnSaveCorner.CornerRadius = UDim.new(0, 6)
    _btnSaveCorner.Parent = _btnSave

    local _btnTPVal = Instance.new("TextButton")
    _btnTPVal.Size = UDim2.new(0.46, 0, 0.8, 0)
    _btnTPVal.Position = UDim2.new(0.52, 0, 0.1, 0)
    _btnTPVal.BackgroundColor3 = Color3.fromRGB(20, 150, 80)
    _btnTPVal.Text = "🌀 TP to Saved"
    _btnTPVal.TextColor3 = Color3.fromRGB(255, 255, 255)
    _btnTPVal.TextSize = 11
    _btnTPVal.Font = Enum.Font.GothamBold
    _btnTPVal.Parent = _wpFr

    local _btnTPValCorner = Instance.new("UICorner")
    _btnTPValCorner.CornerRadius = UDim.new(0, 6)
    _btnTPValCorner.Parent = _btnTPVal

    _btnSave.MouseButton1Click:Connect(function()
        _snd()
        if (_0p1.Character and _0p1.Character:FindFirstChild("HumanoidRootPart")) then
            _savedPos = _0p1.Character.HumanoidRootPart.CFrame
            _btnSave.Text = "✅ Position Saved!"
            task.wait(1.5)
            _btnSave.Text = "📌 Save Position"
        end
    end)

    _btnTPVal.MouseButton1Click:Connect(function()
        _snd()
        if _savedPos and _0p1.Character and _0p1.Character:FindFirstChild("HumanoidRootPart") then
            _0p1.Character.HumanoidRootPart.CFrame = _savedPos
        end
    end)

    local _stFr = Instance.new("Frame")
    _stFr.Size = UDim2.new(0.95, 0, 0, 130)
    _stFr.BackgroundColor3 = Color3.fromRGB(20, 28, 48)
    _stFr.BackgroundTransparency = 0.2
    _stFr.Parent = _pHome

    local _stfcc = Instance.new("UICorner")
    _stfcc.CornerRadius = UDim.new(0, 10)
    _stfcc.Parent = _stFr

    local _stfs = Instance.new("UIStroke")
    _stfs.Color = Color3.fromRGB(0, 140, 255)
    _stfs.Thickness = 1.5
    _stfs.Parent = _stFr

    local _stLbl = Instance.new("TextLabel")
    _stLbl.Size = UDim2.new(1, -20, 1, 0)
    _stLbl.Position = UDim2.new(0, 10, 0, 0)
    _stLbl.BackgroundTransparency = 1
    _stLbl.Text = "⚡ FPS: --\n📡 Ping: -- ms\n💻 CPU: -- ms | 🎮 GPU: -- ms\n📍 Coords: X: 0, Y: 0, Z: 0"
    _stLbl.TextColor3 = Color3.fromRGB(150, 220, 255)
    _stLbl.TextSize = 13
    _stLbl.Font = Enum.Font.GothamBold
    _stLbl.TextXAlignment = Enum.TextXAlignment.Left
    _stLbl.Parent = _stFr

    local _gmFr = Instance.new("Frame")
    _gmFr.Size = UDim2.new(0.95, 0, 0, 140)
    _gmFr.BackgroundColor3 = Color3.fromRGB(20, 28, 48)
    _gmFr.BackgroundTransparency = 0.2
    _gmFr.Parent = _pHome

    local _gmfcc = Instance.new("UICorner")
    _gmfcc.CornerRadius = UDim.new(0, 10)
    _gmfcc.Parent = _gmFr

    local _gmfs = Instance.new("UIStroke")
    _gmfs.Color = Color3.fromRGB(0, 140, 255)
    _gmfs.Thickness = 1.5
    _gmfs.Parent = _gmFr

    local _gmLbl = Instance.new("TextLabel")
    _gmLbl.Size = UDim2.new(1, -20, 1, 0)
    _gmLbl.Position = UDim2.new(0, 10, 0, 0)
    _gmLbl.BackgroundTransparency = 1
    _gmLbl.Text = "🎮 Game: Loading...\n👤 Player: " .. _0p1.DisplayName .. " (@" .. _0p1.Name .. ")\n👥 Friends Here: Checking..."
    _gmLbl.TextColor3 = Color3.fromRGB(150, 220, 255)
    _gmLbl.TextSize = 12
    _gmLbl.Font = Enum.Font.GothamBold
    _gmLbl.TextXAlignment = Enum.TextXAlignment.Left
    _gmLbl.Parent = _gmFr

    task.spawn(function()
        local _pName = "Roblox Game"
        pcall(function()
            local _info = _0g10:GetProductInfo(game.PlaceId)
            if (_info and _info.Name) then _pName = _info.Name end
        end)
        while getgenv().AstroRunning do
            local _fl = {}
            for _, _pl in pairs(_0g2:GetPlayers()) do
                if (_pl ~= _0p1) then
                    pcall(function()
                        if _0p1:IsFriendsWith(_pl.UserId) then table.insert(_fl, _pl.DisplayName) end
                    end)
                end
            end
            _gmLbl.Text = string.format("🎮 Game: %s\n👤 Player: %s (@%s)\n👥 Friends Here: %s", _pName, _0p1.DisplayName, _0p1.Name, ((#_fl > 0) and table.concat(_fl, ", ")) or "No Friends")
            task.wait(5)
        end
    end)

    local _lUpd = tick()
    local _fc = 0
    _0g3.RenderStepped:Connect(function()
        if not getgenv().AstroRunning then return end
        _fc = _fc + 1
        if ((tick() - _lUpd) >= 1) then
            local _fps = _fc
            local _pg = 0
            pcall(function() _pg = math.floor(_0g6.Network.ServerStatsItem["Data Ping"]:GetValue()) end)
            local _crds = "X: 0, Y: 0, Z: 0"
            if (_0p1.Character and _0p1.Character:FindFirstChild("HumanoidRootPart")) then
                local _ps = _0p1.Character.HumanoidRootPart.Position
                _crds = string.format("X: %d, Y: %d, Z: %d", math.floor(_ps.X), math.floor(_ps.Y), math.floor(_ps.Z))
            end
            _stLbl.Text = string.format("⚡ FPS: %d | 📡 Ping: %d ms\n💻 CPU: Active | 🎮 GPU: Stable\n📍 Coords: %s", _fps, _pg, _crds)
            _fc = 0
            _lUpd = tick()
        end
    end)

    local _dsBtn = Instance.new("TextButton")
    _dsBtn.Size = UDim2.new(0.95, 0, 0, 45)
    _dsBtn.BackgroundColor3 = Color3.fromRGB(0, 110, 220)
    _dsBtn.BackgroundTransparency = 0.1
    _dsBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    _dsBtn.Text = "🚀 Join Astro Cosmic Discord 🌌"
    _dsBtn.TextSize = 13
    _dsBtn.Font = Enum.Font.GothamBold
    _dsBtn.Parent = _pHome

    local _dsc = Instance.new("UICorner")
    _dsc.CornerRadius = UDim.new(0, 8)
    _dsc.Parent = _dsBtn

    local _dss = Instance.new("UIStroke")
    _dss.Color = Color3.fromRGB(100, 200, 255)
    _dss.Thickness = 1.5
    _dss.Parent = _dsBtn

    _dsBtn.MouseButton1Click:Connect(function()
        _snd()
        if setclipboard then
            setclipboard(_lnk)
            _dsBtn.Text = "✅ Link Copied! Welcome Aboard 🚀"
            task.wait(2.5)
            _dsBtn.Text = "🚀 Join Astro Cosmic Discord 🌌"
        end
    end)

    _ctg(_pHome, "Auto Reconnect Server", function(_st)
        getgenv().AutoReconnectState = _st
    end)

    _ctg(_pHome, "🛡️ Anti-AFK Protection", function(_st)
        if _st then
            local _vu = game:GetService("VirtualUser")
            _G.AntiAfkConn = _0p1.Idled:Connect(function()
                _vu:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
                task.wait(1)
                _vu:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
            end)
        else
            if _G.AntiAfkConn then _G.AntiAfkConn:Disconnect() end
        end
    end)

    local _tpc = Instance.new("ScrollingFrame")
    _tpc.Size = UDim2.new(0.95, 0, 1, -20)
    _tpc.BackgroundTransparency = 1
    _tpc.CanvasSize = UDim2.new(0, 0, 0, 0)
    _tpc.ScrollBarThickness = 4
    _tpc.ScrollBarImageColor3 = Color3.fromRGB(0, 150, 255)
    _tpc.Parent = _pTP

    local _tpl = Instance.new("UIListLayout")
    _tpl.Padding = UDim.new(0, 8)
    _tpl.HorizontalAlignment = Enum.HorizontalAlignment.Center
    _tpl.Parent = _tpc

    -- [حلقة Spam TP العادية]
    task.spawn(function()
        while true do
            _0g3.RenderStepped:Wait()
            if getgenv().AstroRunning and getgenv().SpamTPTarget then
                pcall(function()
                    local _tPlr = getgenv().SpamTPTarget
                    local _myChar = _0p1.Character
                    if (_tPlr and _tPlr.Character and _tPlr.Character:FindFirstChild("HumanoidRootPart") and _myChar and _myChar:FindFirstChild("HumanoidRootPart")) then
                        local _myHum = _myChar:FindFirstChildOfClass("Humanoid")
                        if _myHum then
                            _myHum.Sit = false
                            _myHum:SetStateEnabled(Enum.HumanoidStateType.Seated, false)
                            if _myHum:GetState() == Enum.HumanoidStateType.Seated then
                                _myHum:ChangeState(Enum.HumanoidStateType.RunningNoPhysics)
                            end
                        end
                        local _myHrp = _myChar.HumanoidRootPart
                        local _tHrp = _tPlr.Character.HumanoidRootPart
                        _myHrp.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
                        _myHrp.CFrame = _tHrp.CFrame + Vector3.new(0, 5.5, 0)
                    end
                end)
            end
        end
    end)

    local _trollContainer = Instance.new("ScrollingFrame")
    _trollContainer.Size = UDim2.new(0.95, 0, 1, -20)
    _trollContainer.BackgroundTransparency = 1
    _trollContainer.CanvasSize = UDim2.new(0, 0, 0, 0)
    _trollContainer.ScrollBarThickness = 4
    _trollContainer.ScrollBarImageColor3 = Color3.fromRGB(220, 50, 50)
    _trollContainer.Parent = _pTroll

    local _trollLayout = Instance.new("UIListLayout")
    _trollLayout.Padding = UDim.new(0, 8)
    _trollLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    _trollLayout.Parent = _trollContainer

    -- [🔥 الحل النهائي الأسطوري: الشقلبة والتدوير والاصطدام الفيزيائي المدمر (Chaos Collision)]
    task.spawn(function()
        while true do
            _0g3.RenderStepped:Wait()
            if getgenv().AstroRunning and getgenv().VoidTrollTarget then
                pcall(function()
                    local _tPlr = getgenv().VoidTrollTarget
                    local _myChar = _0p1.Character
                    if (_tPlr and _tPlr.Character and _tPlr.Character:FindFirstChild("HumanoidRootPart") and _myChar and _myChar:FindFirstChild("HumanoidRootPart")) then
                        local _tHrp = _tPlr.Character.HumanoidRootPart
                        local _myHrp = _myChar.HumanoidRootPart

                        -- تفعيل الاصطدام الكامل عشان شخصيتك تدفه بقوة
                        for _, _p in pairs(_myChar:GetDescendants()) do
                            if _p:IsA("BasePart") then _p.CanCollide = true end
                        end

                        -- حساب حركة شقلبانية دائرية حول الضحية (تدور بسرعة وتدخل برأسه وجوانبه بشكل جنوني)
                        local _t = tick() * 25
                        local _offsetX = math.sin(_t) * 2.5
                        local _offsetZ = math.cos(_t) * 2.5
                        local _offsetY = math.sin(_t * 2) * 2 + 15 -- تبدل الارتفاع بسرعة وتكبسه من فوق لتحت

                        -- دفرة فيزيائية مستمرة عبر تحريك الCFrame بشكل دائرى شقلباني يولد ضغط صدمات مرعب
                        _myHrp.CFrame = _tHrp.CFrame + Vector3.new(_offsetX, _offsetY, _offsetZ)
                        _myHrp.AssemblyLinearVelocity = Vector3.new(math.random(-1500, 1500), math.random(1000, 3000), math.random(-1500, 1500))
                    end
                end)
            end
        end
    end)

    -- [تعبئة قائمة TP العادية]
    task.spawn(function()
        while getgenv().AstroRunning do
            for _, _chld in pairs(_tpc:GetChildren()) do
                if _chld:IsA("Frame") then _chld:Destroy() end
            end
            for _, _pl in pairs(_0g2:GetPlayers()) do
                if (_pl ~= _0p1) then
                    local _pCard = Instance.new("Frame")
                    _pCard.Size = UDim2.new(1, 0, 0, 48)
                    _pCard.BackgroundColor3 = Color3.fromRGB(18, 25, 42)
                    _pCard.BackgroundTransparency = 0.2
                    _pCard.Parent = _tpc

                    local _pcc = Instance.new("UICorner")
                    _pcc.CornerRadius = UDim.new(0, 8)
                    _pcc.Parent = _pCard

                    local _pNameLbl = Instance.new("TextLabel")
                    _pNameLbl.Size = UDim2.new(0.48, 0, 1, 0)
                    _pNameLbl.Position = UDim2.new(0.02, 0, 0, 0)
                    _pNameLbl.BackgroundTransparency = 1
                    _pNameLbl.Text = _pl.DisplayName .. "\n(@" .. _pl.Name .. ")"
                    _pNameLbl.TextColor3 = Color3.fromRGB(150, 220, 255)
                    _pNameLbl.TextSize = 11
                    _pNameLbl.Font = Enum.Font.GothamBold
                    _pNameLbl.TextXAlignment = Enum.TextXAlignment.Left
                    _pNameLbl.Parent = _pCard

                    local _pOnceBtn = Instance.new("TextButton")
                    _pOnceBtn.Size = UDim2.new(0.23, 0, 0.7, 0)
                    _pOnceBtn.Position = UDim2.new(0.50, 0, 0.15, 0)
                    _pOnceBtn.BackgroundColor3 = Color3.fromRGB(0, 130, 255)
                    _pOnceBtn.Text = "🚀 TP Once"
                    _pOnceBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
                    _pOnceBtn.TextSize = 10
                    _pOnceBtn.Font = Enum.Font.GothamBold
                    _pOnceBtn.Parent = _pCard

                    local _pobc = Instance.new("UICorner")
                    _pobc.CornerRadius = UDim.new(0, 6)
                    _pobc.Parent = _pOnceBtn

                    local _pSpamBtn = Instance.new("TextButton")
                    _pSpamBtn.Size = UDim2.new(0.24, 0, 0.7, 0)
                    _pSpamBtn.Position = UDim2.new(0.74, 0, 0.15, 0)
                    if getgenv().SpamTPTarget == _pl then
                        _pSpamBtn.BackgroundColor3 = Color3.fromRGB(220, 50, 50)
                        _pSpamBtn.Text = "⚡ Spam: ON"
                    else
                        _pSpamBtn.BackgroundColor3 = Color3.fromRGB(40, 60, 90)
                        _pSpamBtn.Text = "⚡ Spam: OFF"
                    end
                    _pSpamBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
                    _pSpamBtn.TextSize = 10
                    _pSpamBtn.Font = Enum.Font.GothamBold
                    _pSpamBtn.Parent = _pCard

                    local _psbc = Instance.new("UICorner")
                    _psbc.CornerRadius = UDim.new(0, 6)
                    _psbc.Parent = _pSpamBtn

                    _pOnceBtn.MouseButton1Click:Connect(function()
                        _snd()
                        pcall(function()
                            if (_pl.Character and _pl.Character:FindFirstChild("HumanoidRootPart") and _0p1.Character and _0p1.Character:FindFirstChild("HumanoidRootPart")) then
                                _0p1.Character.HumanoidRootPart.CFrame = _pl.Character.HumanoidRootPart.CFrame + Vector3.new(0, 5.5, 0)
                            end
                        end)
                    end)

                    _pSpamBtn.MouseButton1Click:Connect(function()
                        _snd()
                        if getgenv().SpamTPTarget == _pl then
                            getgenv().SpamTPTarget = nil
                            _pSpamBtn.BackgroundColor3 = Color3.fromRGB(40, 60, 90)
                            _pSpamBtn.Text = "⚡ Spam: OFF"
                            pcall(function()
                                local _myHum = _0p1.Character and _0p1.Character:FindFirstChildOfClass("Humanoid")
                                if _myHum then
                                    _myHum:SetStateEnabled(Enum.HumanoidStateType.Seated, true)
                                end
                            end)
                        else
                            getgenv().SpamTPTarget = _pl
                            _pSpamBtn.BackgroundColor3 = Color3.fromRGB(220, 50, 50)
                            _pSpamBtn.Text = "⚡ Spam: ON"
                        end
                    end)
                end
            end
            _tpc.CanvasSize = UDim2.new(0, 0, 0, #_0g2:GetPlayers() * 55)
            task.wait(4)
        end
    end)

    -- [تعبئة قائمة التخريب (Trolls)]
    task.spawn(function()
        while getgenv().AstroRunning do
            for _, _chld in pairs(_trollContainer:GetChildren()) do
                if _chld:IsA("Frame") then _chld:Destroy() end
            end
            for _, _pl in pairs(_0g2:GetPlayers()) do
                if (_pl ~= _0p1) then
                    local _tCard = Instance.new("Frame")
                    _tCard.Size = UDim2.new(1, 0, 0, 48)
                    _tCard.BackgroundColor3 = Color3.fromRGB(25, 15, 25)
                    _tCard.BackgroundTransparency = 0.2
                    _tCard.Parent = _trollContainer

                    local _tcc = Instance.new("UICorner")
                    _tcc.CornerRadius = UDim.new(0, 8)
                    _tcc.Parent = _tCard

                    local _tStroke = Instance.new("UIStroke")
                    _tStroke.Color = Color3.fromRGB(200, 50, 50)
                    _tStroke.Thickness = 1.2
                    _tStroke.Parent = _tCard

                    local _tNameLbl = Instance.new("TextLabel")
                    _tNameLbl.Size = UDim2.new(0.60, 0, 1, 0)
                    _tNameLbl.Position = UDim2.new(0.02, 0, 0, 0)
                    _tNameLbl.BackgroundTransparency = 1
                    _tNameLbl.Text = "💥 " .. _pl.DisplayName .. " (@" .. _pl.Name .. ")"
                    _tNameLbl.TextColor3 = Color3.fromRGB(255, 150, 150)
                    _tNameLbl.TextSize = 11
                    _tNameLbl.Font = Enum.Font.GothamBold
                    _tNameLbl.TextXAlignment = Enum.TextXAlignment.Left
                    _tNameLbl.Parent = _tCard

                    local _tTrollBtn = Instance.new("TextButton")
                    _tTrollBtn.Size = UDim2.new(0.35, 0, 0.7, 0)
                    _tTrollBtn.Position = UDim2.new(0.63, 0, 0.15, 0)
                    if getgenv().VoidTrollTarget == _pl then
                        _tTrollBtn.BackgroundColor3 = Color3.fromRGB(220, 50, 50)
                        _tTrollBtn.Text = "🔥 Launch: ON"
                    else
                        _tTrollBtn.BackgroundColor3 = Color3.fromRGB(60, 30, 40)
                        _tTrollBtn.Text = "🌪️ Launch: OFF"
                    end
                    _tTrollBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
                    _tTrollBtn.TextSize = 10
                    _tTrollBtn.Font = Enum.Font.GothamBold
                    _tTrollBtn.Parent = _tCard

                    local _tsbc = Instance.new("UICorner")
                    _tsbc.CornerRadius = UDim.new(0, 6)
                    _tsbc.Parent = _tTrollBtn

                    _tTrollBtn.MouseButton1Click:Connect(function()
                        _snd()
                        if getgenv().VoidTrollTarget == _pl then
                            getgenv().VoidTrollTarget = nil
                            _tTrollBtn.BackgroundColor3 = Color3.fromRGB(60, 30, 40)
                            _tTrollBtn.Text = "🌪️ Launch: OFF"
                        else
                            getgenv().VoidTrollTarget = _pl
                            _tTrollBtn.BackgroundColor3 = Color3.fromRGB(220, 50, 50)
                            _tTrollBtn.Text = "🔥 Launch: ON"
                        end
                    end)
                end
            end
            _trollContainer.CanvasSize = UDim2.new(0, 0, 0, #_0g2:GetPlayers() * 55)
            task.wait(4)
        end
    end)

    local _abConn
    local _maxDst = 300
    local _abSmth = 0.35

    _ctg(_pCombat, "Aimbot (Smart Team Check)", function(_st)
        if _abConn then _abConn:Disconnect(); _abConn = nil end
        if _st then
            _abConn = _0g3.RenderStepped:Connect(function()
                if not getgenv().AstroRunning then return end
                local _clH = nil
                local _shDst = math.huge
                local _scCn = Vector2.new(_0c1.ViewportSize.X / 2, _0c1.ViewportSize.Y / 2)
                local _myCh = _0p1.Character
                local _myHrp = _myCh and _myCh:FindFirstChild("HumanoidRootPart")
                if not _myHrp then return end
                for _, _pl in pairs(_0g2:GetPlayers()) do
                    if ((_pl ~= _0p1) and _pl.Character and _pl.Character:FindFirstChild("Head") and _pl.Character:FindFirstChildOfClass("Humanoid") and (_pl.Character:FindFirstChildOfClass("Humanoid").Health > 0)) then
                        local _isTm = false
                        if (_0p1.Team and _pl.Team and (_0p1.Team == _pl.Team)) then _isTm = true end
                        if not _isTm then
                            local _tHd = _pl.Character.Head
                            local _wDst = (_myHrp.Position - _tHd.Position).Magnitude
                            if (_wDst <= _maxDst) then
                                local _hPos, _onSc = _0c1:WorldToViewportPoint(_tHd.Position)
                                if _onSc then
                                    local _sDst = (Vector2.new(_hPos.X, _hPos.Y) - _scCn).Magnitude
                                    if (_sDst < _shDst) then
                                        _shDst = _sDst
                                        _clH = _tHd
                                    end
                                end
                            end
                        end
                    end
                end
                if _clH then
                    local _tCf = CFrame.new(_0c1.CFrame.Position, _clH.Position)
                    _0c1.CFrame = _0c1.CFrame:Lerp(_tCf, _abSmth)
                end
            end)
        end
    end)

    local _mhAct = false
    _ctg(_pCombat, "Massive Giant Hitbox (Very Big)", function(_st)
        _mhAct = _st
        task.spawn(function()
            while _mhAct and getgenv().AstroRunning do
                for _, _pl in pairs(_0g2:GetPlayers()) do
                    if (_pl ~= _0p1) then
                        local _isTm = _0p1.Team and _pl.Team and (_0p1.Team == _pl.Team)
                        if (not _isTm and _pl.Character and _pl.Character:FindFirstChild("HumanoidRootPart")) then
                            pcall(function()
                                _pl.Character.HumanoidRootPart.Size = Vector3.new(40, 40, 40)
                                _pl.Character.HumanoidRootPart.Transparency = 0.85
                                _pl.Character.HumanoidRootPart.CanCollide = false
                            end)
                        end
                    end
                end
                task.wait(1)
            end
            if not _mhAct then
                for _, _pl in pairs(_0g2:GetPlayers()) do
                    if ((_pl ~= _0p1) and _pl.Character and _pl.Character:FindFirstChild("HumanoidRootPart")) then
                        pcall(function()
                            _pl.Character.HumanoidRootPart.Size = Vector3.new(2, 2, 1)
                            _pl.Character.HumanoidRootPart.Transparency = 1
                        end)
                    end
                end
            end
        end)
    end)

    _csld(_pCombat, "Aimbot Max Distance", 50, 1000, 300, function(_v) _maxDst = _v end)
    _csld(_pCombat, "Aim Smoothness %", 10, 100, 35, function(_v) _abSmth = _v / 100 end)

    local _egAct = false
    _ctg(_pDetect, "Highlight Eggs & Rarities", function(_st)
        _egAct = _st
        task.spawn(function()
            while _egAct and getgenv().AstroRunning do
                for _, _obj in pairs(_0g7:GetDescendants()) do
                    local _nm = string.lower(_obj.Name)
                    if (string.find(_nm, "egg") or string.find(_nm, "divine") or string.find(_nm, "secret") or string.find(_nm, "mythic") or string.find(_nm, "legendary")) then
                        if (_obj:IsA("Model") or _obj:IsA("BasePart")) then
                            if not _obj:FindFirstChild("AstroEggHighlight") then
                                local _hl = Instance.new("Highlight")
                                _hl.Name = "AstroEggHighlight"
                                _hl.FillColor = Color3.fromRGB(0, 150, 255)
                                _hl.OutlineColor = Color3.fromRGB(255, 255, 255)
                                _hl.Parent = _obj
                            end
                        end
                    end
                end
                task.wait(3)
            end
            if not _egAct then
                for _, _obj in pairs(_0g7:GetDescendants()) do
                    if (_obj.Name == "AstroEggHighlight") then _obj:Destroy() end
                end
            end
        end)
    end)

    local _bsAct = false
    _ctg(_pBoss, "Highlight All Bosses", function(_st)
        _bsAct = _st
        task.spawn(function()
            while _bsAct and getgenv().AstroRunning do
                for _, _obj in pairs(_0g7:GetDescendants()) do
                    local _nm = string.lower(_obj.Name)
                    if (string.find(_nm, "boss") or string.find(_nm, "monster")) then
                        if (_obj:IsA("Model") and _obj:FindFirstChildOfClass("Humanoid")) then
                            if not _obj:FindFirstChild("AstroBossHighlight") then
                                local _hl = Instance.new("Highlight")
                                _hl.Name = "AstroBossHighlight"
                                _hl.FillColor = Color3.fromRGB(0, 170, 255)
                                _hl.OutlineColor = Color3.fromRGB(255, 255, 255)
                                _hl.Parent = _obj

                                local _bg = Instance.new("BillboardGui")
                                _bg.Name = "AstroBossTag"
                                _bg.Size = UDim2.new(0, 150, 0, 30)
                                _bg.AlwaysOnTop = true
                                _bg.ExtentsOffset = Vector3.new(0, 3, 0)
                                _bg.Parent = _obj

                                local _tx = Instance.new("TextLabel")
                                _tx.Size = UDim2.new(1, 0, 1, 0)
                                _tx.BackgroundTransparency = 1
                                _tx.Text = "👹 BOSS: " .. _obj.Name
                                _tx.TextColor3 = Color3.fromRGB(0, 200, 255)
                                _tx.TextSize = 14
                                _tx.Font = Enum.Font.GothamBold
                                _tx.Parent = _bg
                            end
                        end
                    end
                end
                task.wait(3)
            end
            if not _bsAct then
                for _, _obj in pairs(_0g7:GetDescendants()) do
                    if ((_obj.Name == "AstroBossHighlight") or (_obj.Name == "AstroBossTag")) then _obj:Destroy() end
                end
            end
        end)
    end)

    local _espAct = false
    _ctg(_pVisual, "Player ESP (Smart Clean)", function(_st)
        _espAct = _st
        task.spawn(function()
            while _espAct and getgenv().AstroRunning do
                for _, _pl in pairs(_0g2:GetPlayers()) do
                    if (_pl ~= _0p1) then
                        local _ch = _pl.Character
                        local _hm = _ch and _ch:FindFirstChildOfClass("Humanoid")
                        if (_ch and _hm and (_hm.Health > 0)) then
                            if not _ch:FindFirstChild("AstroHighlight") then
                                local _hl = Instance.new("Highlight")
                                _hl.Name = "AstroHighlight"
                                _hl.FillColor = Color3.fromRGB(0, 130, 255)
                                _hl.OutlineColor = Color3.fromRGB(255, 255, 255)
                                _hl.Parent = _ch
                            end
                        elseif (_ch and _ch:FindFirstChild("AstroHighlight")) then
                            _ch.AstroHighlight:Destroy()
                        end
                    end
                end
                task.wait(0.2)
            end
            if not _espAct then
                for _, _pl in pairs(_0g2:GetPlayers()) do
                    if (_pl.Character and _pl.Character:FindFirstChild("AstroHighlight")) then
                        _pl.Character.AstroHighlight:Destroy()
                    end
                end
            end
        end)
    end)

    _ctg(_pPerf, "Potato Mode (Boost FPS)", function(_st)
        if _st then
            for _, _v in pairs(_0g7:GetDescendants()) do
                if _v:IsA("BasePart") then
                    _v.Material = Enum.Material.SmoothPlastic
                    _v.Reflectance = 0
                elseif (_v:IsA("Decal") or _v:IsA("Texture")) then
                    _v.Transparency = 1
                end
            end
            _0g5.GlobalShadows = false
            _0g5.FogEnd = 8999999488
            settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
        else
            _0g5.GlobalShadows = true
            settings().Rendering.QualityLevel = Enum.QualityLevel.Automatic
        end
    end)
end

if _f2() then
    _loadHub()
else
    local _kGui = Instance.new("ScreenGui")
    _kGui.Name = "AstroKeyGui"
    _kGui.Parent = _0g1
    _kGui.IgnoreGuiInset = true

    local _kMain = Instance.new("Frame")
    _kMain.Size = UDim2.new(0, 320, 0, 200)
    _kMain.Position = UDim2.new(0.5, -160, 0.5, -100)
    _kMain.BackgroundColor3 = Color3.fromRGB(10, 15, 30)
    _kMain.BackgroundTransparency = 0.1
    _kMain.BorderSizePixel = 0
    _kMain.Parent = _kGui

    local _kcr = Instance.new("UICorner")
    _kcr.CornerRadius = UDim.new(0, 16)
    _kcr.Parent = _kMain

    local _kst = Instance.new("UIStroke")
    _kst.Color = Color3.fromRGB(0, 140, 255)
    _kst.Thickness = 2.5
    _kst.Parent = _kMain

    local _kttl = Instance.new("TextLabel")
    _kttl.Size = UDim2.new(1, 0, 0, 40)
    _kttl.BackgroundTransparency = 1
    _kttl.Text = "🚀 Astro Cosmic System 🪐"
    _kttl.TextColor3 = Color3.fromRGB(0, 190, 255)
    _kttl.TextSize = 16
    _kttl.Font = Enum.Font.GothamBold
    _kttl.Parent = _kMain

    local _kBox = Instance.new("TextBox")
    _kBox.Size = UDim2.new(0.8, 0, 0, 40)
    _kBox.Position = UDim2.new(0.1, 0, 0.35, 0)
    _kBox.BackgroundColor3 = Color3.fromRGB(20, 30, 50)
    _kBox.BackgroundTransparency = 0.2
    _kBox.TextColor3 = Color3.fromRGB(150, 220, 255)
    _kBox.PlaceholderText = "Enter Key Here..."
    _kBox.Text = ""
    _kBox.TextSize = 14
    _kBox.Font = Enum.Font.Gotham
    _kBox.Parent = _kMain

    local _kbcr = Instance.new("UICorner")
    _kbcr.CornerRadius = UDim.new(0, 10)
    _kbcr.Parent = _kBox

    _lBtn = Instance.new("TextButton")
    _lBtn.Size = UDim2.new(0.8, 0, 0, 40)
    _lBtn.Position = UDim2.new(0.1, 0, 0.65, 0)
    _lBtn.BackgroundColor3 = Color3.fromRGB(0, 130, 255)
    _lBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    _lBtn.Text = "Launch 🚀"
    _lBtn.TextSize = 15
    _lBtn.Font = Enum.Font.GothamBold
    _lBtn.Parent = _kMain

    local _lbc = Instance.new("UICorner")
    _lbc.CornerRadius = UDim.new(0, 10)
    _lbc.Parent = _lBtn

    _lBtn.MouseButton1Click:Connect(function()
        if (_kBox.Text == _k2) then
            _f1(_k2)
            _loadHub()
        else
            _snd()
            _kBox.Text = ""
            _kBox.PlaceholderText = "Wrong Key! Try Again"
        end
    end)
end
