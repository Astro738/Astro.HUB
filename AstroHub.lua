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
getgenv().UndergroundKillTarget = nil
getgenv().BackstabTarget = nil
getgenv().LoopTPTarget = nil
getgenv().LoopAllWaypoints = false
getgenv().WaypointDelay = 0.5
getgenv().WaypointStartPoint = 1

local function _f3()
    getgenv().SpamTPTarget = nil
    getgenv().VoidTrollTarget = nil
    getgenv().UndergroundKillTarget = nil
    getgenv().BackstabTarget = nil
    getgenv().LoopTPTarget = nil
    getgenv().LoopAllWaypoints = false
    pcall(function()
        if _0p1.Character then
            local _h = _0p1.Character:FindFirstChildOfClass("Humanoid")
            if _h then 
                _h.PlatformStand = false 
                _h:SetStateEnabled(Enum.HumanoidStateType.Seated, true)
                pcall(function() _h:ChangeState(Enum.HumanoidStateType.GettingUp) end)
            end
            local _r = _0p1.Character:FindFirstChild("HumanoidRootPart")
            if _r then 
                _r.AssemblyLinearVelocity = Vector3.new(0,0,0) 
                _r.CFrame = _r.CFrame + Vector3.new(0, 4, 0)
            end
        end
        for _, _o in pairs(_0g7:GetDescendants()) do
            if ((_o.Name == "AstroHighlight") or (_o.Name == "AstroBossHighlight") or (_o.Name == "AstroBossTag") or (_o.Name == "AstroBotHighlight")) then
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

pcall(function()
    if _0g1:FindFirstChild("AstroHubGui") then _0g1.AstroHubGui:Destroy() end
    if _0g1:FindFirstChild("AstroKeyGui") then _0g1.AstroKeyGui:Destroy() end
end)

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

local function _stealthTP(_targetCFrame)
    pcall(function()
        local _myChar = _0p1.Character
        if _myChar and _myChar:FindFirstChild("HumanoidRootPart") then
            local _hrp = _myChar.HumanoidRootPart
            local _hum = _myChar:FindFirstChildOfClass("Humanoid")
            if _hum then 
                _hum.PlatformStand = true 
                pcall(function() _hum:ChangeState(Enum.HumanoidStateType.Swimming) end)
            end
            for _, _p in pairs(_myChar:GetDescendants()) do
                if _p:IsA("BasePart") then _p.CanCollide = false end
            end
            
            local _startPos = _hrp.Position
            local _targetPos = _targetCFrame.Position
            local _dist = (_startPos - _targetPos).Magnitude
            
            if _dist <= 30 then
                _hrp.CFrame = _targetCFrame
            else
                local _speed = 280
                local _duration = _dist / _speed
                local _startTime = tick()
                
                while (tick() - _startTime) < _duration do
                    if not getgenv().AstroRunning then break end
                    local _alpha = math.clamp((tick() - _startTime) / _duration, 0, 1)
                    _alpha = _alpha * _alpha * (3 - 2 * _alpha)
                    
                    local _currentPos = _startPos:Lerp(_targetPos, _alpha)
                    _hrp.CFrame = CFrame.new(_currentPos, _targetPos)
                    
                    local _dir = (_targetPos - _startPos).Unit
                    _hrp.AssemblyLinearVelocity = _dir * _speed
                    _0g3.RenderStepped:Wait()
                end
            end
            
            _hrp.CFrame = _targetCFrame
            _hrp.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
            _hrp.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
            
            task.wait(0.03)
            if _hum then _hum.PlatformStand = false end
            for _, _p in pairs(_myChar:GetDescendants()) do
                if _p:IsA("BasePart") then _p.CanCollide = true end
            end
        end
    end)
end

local function _loadHub()
    _snd()
    pcall(function()
        if _0g1:FindFirstChild("AstroKeyGui") then _0g1.AstroKeyGui:Destroy() end
    end)
    getgenv().AstroRunning = true
    
    local _gui = Instance.new("ScreenGui")
    _gui.Name = "AstroHubGui"
    _gui.Parent = _0g1
    _gui.IgnoreGuiInset = true
    _gui.ResetOnSpawn = false

    local _btn = Instance.new("TextButton")
    _btn.Size = UDim2.new(0, 50, 0, 50)
    _btn.Position = UDim2.new(0, 20, 0.5, -25)
    _btn.BackgroundColor3 = Color3.fromRGB(10, 15, 30)
    _btn.BackgroundTransparency = 0.1
    _btn.TextColor3 = Color3.fromRGB(0, 180, 255)
    _btn.Text = "🪐"
    _btn.TextSize = 26
    _btn.Font = Enum.Font.GothamBold
    _btn.Parent = _gui

    local _bc = Instance.new("UICorner")
    _bc.CornerRadius = UDim.new(1, 0)
    _bc.Parent = _btn

    local _bs = Instance.new("UIStroke")
    _bs.Color = Color3.fromRGB(0, 150, 255)
    _bs.Thickness = 2
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
    _mf.Size = UDim2.new(0, 520, 0, 360)
    _mf.Position = UDim2.new(0.5, -260, 0.5, -180)
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
    _mfs.Thickness = 2
    _mfs.Parent = _mf

    local _tb = Instance.new("Frame")
    _tb.Size = UDim2.new(1, 0, 0, 40)
    _tb.BackgroundColor3 = Color3.fromRGB(15, 22, 40)
    _tb.BackgroundTransparency = 0.2
    _tb.BorderSizePixel = 0
    _tb.Parent = _mf

    local _tbc = Instance.new("UICorner")
    _tbc.CornerRadius = UDim.new(0, 14)
    _tbc.Parent = _tb

    local _ttl = Instance.new("TextLabel")
    _ttl.Size = UDim2.new(0, 280, 1, 0)
    _ttl.Position = UDim2.new(0, 15, 0, 0)
    _ttl.BackgroundTransparency = 1
    _ttl.Text = "🌌 Astro Hub | Cosmic Edition 🚀"
    _ttl.TextColor3 = Color3.fromRGB(0, 190, 255)
    _ttl.TextSize = 13
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
    _cb.Size = UDim2.new(0, 28, 0, 28)
    _cb.Position = UDim2.new(1, -34, 0, 6)
    _cb.BackgroundColor3 = Color3.fromRGB(220, 50, 50)
    _cb.Text = "X"
    _cb.TextColor3 = Color3.fromRGB(255, 255, 255)
    _cb.TextSize = 14
    _cb.Font = Enum.Font.GothamBold
    _cb.Parent = _tb

    local _cbc = Instance.new("UICorner")
    _cbc.CornerRadius = UDim.new(0, 6)
    _cbc.Parent = _cb

    local _mb = Instance.new("TextButton")
    _mb.Size = UDim2.new(0, 28, 0, 28)
    _mb.Position = UDim2.new(1, -66, 0, 6)
    _mb.BackgroundColor3 = Color3.fromRGB(35, 65, 110)
    _mb.Text = "—"
    _mb.TextColor3 = Color3.fromRGB(255, 255, 255)
    _mb.TextSize = 14
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
    _sb.Size = UDim2.new(0, 140, 1, -40)
    _sb.Position = UDim2.new(0, 0, 0, 40)
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
    _ca.Size = UDim2.new(1, -140, 1, -40)
    _ca.Position = UDim2.new(0, 140, 0, 40)
    _ca.BackgroundTransparency = 1
    _ca.Parent = _mf

    local _isMin = false
    _mb.MouseButton1Click:Connect(function()
        _snd()
        _isMin = not _isMin
        _ca.Visible = not _isMin
        _sb.Visible = not _isMin
        if _isMin then
            _mf.Size = UDim2.new(0, 520, 0, 40)
            _mb.Text = "+"
        else
            _mf.Size = UDim2.new(0, 520, 0, 360)
            _mb.Text = "—"
        end
    end)

    local _pgs = {}
    local function _cp(_n, _customScroll)
        local _sc
        if _customScroll then
            _sc = Instance.new("Frame")
            _sc.Size = UDim2.new(1, 0, 1, 0)
            _sc.BackgroundTransparency = 1
            _sc.Visible = false
            _sc.Parent = _ca
        else
            _sc = Instance.new("ScrollingFrame")
            _sc.Size = UDim2.new(1, 0, 1, 0)
            _sc.BackgroundTransparency = 1
            _sc.CanvasSize = UDim2.new(0, 0, 0, 900)
            _sc.ScrollBarThickness = 4
            _sc.ScrollBarImageColor3 = Color3.fromRGB(0, 150, 255)
            _sc.Visible = false
            _sc.Parent = _ca

            local _ly = Instance.new("UIListLayout")
            _ly.Padding = UDim.new(0, 8)
            _ly.HorizontalAlignment = Enum.HorizontalAlignment.Center
            _ly.Parent = _sc
        end

        local _sbtn = Instance.new("TextButton")
        _sbtn.Size = UDim2.new(0.9, 0, 0, 36)
        _sbtn.BackgroundColor3 = Color3.fromRGB(20, 30, 50)
        _sbtn.BackgroundTransparency = 0.3
        _sbtn.TextColor3 = Color3.fromRGB(100, 200, 255)
        _sbtn.Text = _n
        _sbtn.TextSize = 12
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
        _clbl.Size = UDim2.new(1, -65, 1, 0)
        _clbl.Position = UDim2.new(0, 12, 0, 0)
        _clbl.BackgroundTransparency = 1
        _clbl.Text = _n
        _clbl.TextColor3 = Color3.fromRGB(180, 230, 255)
        _clbl.TextSize = 11
        _clbl.Font = Enum.Font.GothamBold
        _clbl.TextXAlignment = Enum.TextXAlignment.Left
        _clbl.Parent = _ct

        local _tgl = Instance.new("TextButton")
        _tgl.Size = UDim2.new(0, 44, 0, 22)
        _tgl.Position = UDim2.new(1, -52, 0.5, -11)
        _tgl.BackgroundColor3 = Color3.fromRGB(35, 45, 65)
        _tgl.Text = ""
        _tgl.Parent = _ct

        local _tgc = Instance.new("UICorner")
        _tgc.CornerRadius = UDim.new(1, 0)
        _tgc.Parent = _tgl

        local _ind = Instance.new("Frame")
        _ind.Size = UDim2.new(0, 18, 0, 18)
        _ind.Position = UDim2.new(0, 2, 0.5, -9)
        _ind.BackgroundColor3 = Color3.fromRGB(210, 210, 210)
        _ind.Parent = _tgl

        local _indc = Instance.new("UICorner")
        _indc.CornerRadius = UDim.new(1, 0)
        _indc.Parent = _ind

        local _act = false
        _tgl.MouseButton1Click:Connect(function()
            _snd()
            _act = not _act
            if _act then
                _tgl.BackgroundColor3 = Color3.fromRGB(0, 130, 255)
                _ind:TweenPosition(UDim2.new(1, -20, 0.5, -9), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.15, true)
                _ind.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            else
                _tgl.BackgroundColor3 = Color3.fromRGB(35, 45, 65)
                _ind:TweenPosition(UDim2.new(0, 2, 0.5, -9), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.15, true)
                _ind.BackgroundColor3 = Color3.fromRGB(210, 210, 210)
            end
            _cb(_act)
        end)
    end

    local function _csld(_pp, _n, _min, _max, _def, _isDecimal, _cb)
        local _fr = Instance.new("Frame")
        _fr.Size = UDim2.new(0.95, 0, 0, 40)
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
        _lbl.Size = UDim2.new(1, -20, 0, 16)
        _lbl.Position = UDim2.new(0, 10, 0, 3)
        _lbl.BackgroundTransparency = 1
        _lbl.Text = _n .. ": " .. tostring(_def) .. (_isDecimal and "s" or "")
        _lbl.TextColor3 = Color3.fromRGB(130, 210, 255)
        _lbl.TextSize = 10
        _lbl.Font = Enum.Font.GothamBold
        _lbl.TextXAlignment = Enum.TextXAlignment.Left
        _lbl.Parent = _fr

        local _sbg = Instance.new("Frame")
        _sbg.Size = UDim2.new(0.92, 0, 0, 5)
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
            local _val = _min + ((_max - _min) * _pos)
            if _isDecimal then
                _val = math.floor(_val * 100 + 0.5) / 100
                _lbl.Text = _n .. ": " .. tostring(_val) .. "s"
            else
                _val = math.floor(_val + 0.5)
                _lbl.Text = _n .. ": " .. tostring(_val)
            end
            _fl.Size = UDim2.new(_pos, 0, 1, 0)
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

    local _pHome = _cp("🛰️ Home & Stats", false)
    local _pPlayer = _cp("👨‍🚀 Player & Speed", false)
    local _pCombat = _cp("🎯 Aimbot & Combat", false)
    local _pTP = _cp("🌌 Player TP", false)
    local _pWaypoints = _cp("📌 Waypoints Hub", true)
    local _pTroll = _cp("💥 Trolls & Void", false)
    local _pBoss = _cp("👾 Boss & Chasers ESP", false)
    local _pVisual = _cp("👁️ ESP & Visuals", false)
    local _pPerf = _cp("⚡ Performance", false)

    getgenv().SpeedActive = false
    getgenv().SpeedVal = 16

    _ctg(_pPlayer, "⚡ Enable Custom Speed", function(_st)
        getgenv().SpeedActive = _st
    end)

    _csld(_pPlayer, "👟 WalkSpeed Boost", 16, 2000, 16, false, function(_v)
        getgenv().SpeedVal = _v
    end)

    task.spawn(function()
        while true do
            _0g3.RenderStepped:Wait()
            if getgenv().AstroRunning and getgenv().SpeedActive then
                pcall(function()
                    if _0p1.Character then
                        local _hum = _0p1.Character:FindFirstChildOfClass("Humanoid")
                        if _hum then
                            _hum.WalkSpeed = getgenv().SpeedVal
                        end
                    end
                end)
            end
        end
    end)

    local _fly = false
    local _flySpd = 50

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

    _csld(_pPlayer, "🚀 Fly Speed Boost", 20, 2000, 50, false, function(_v) _flySpd = _v end)

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

    local _savedWaypoints = {}

    local _wpFixedTop = Instance.new("Frame")
    _wpFixedTop.Size = UDim2.new(1, 0, 0, 220)
    _wpFixedTop.Position = UDim2.new(0, 0, 0, 0)
    _wpFixedTop.BackgroundTransparency = 1
    _wpFixedTop.Parent = _pWaypoints

    local _wpTopLayout = Instance.new("UIListLayout")
    _wpTopLayout.Padding = UDim.new(0, 5)
    _wpTopLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    _wpTopLayout.Parent = _wpFixedTop

    local _wpTopFr = Instance.new("Frame")
    _wpTopFr.Size = UDim2.new(0.95, 0, 0, 38)
    _wpTopFr.BackgroundColor3 = Color3.fromRGB(18, 25, 42)
    _wpTopFr.BackgroundTransparency = 0.2
    _wpTopFr.Parent = _wpFixedTop

    local _wptcc = Instance.new("UICorner")
    _wptcc.CornerRadius = UDim.new(0, 8)
    _wptcc.Parent = _wpTopFr

    local _wptstr = Instance.new("UIStroke")
    _wptstr.Color = Color3.fromRGB(0, 120, 220)
    _wptstr.Thickness = 1.2
    _wptstr.Parent = _wpTopFr

    local _wpBox = Instance.new("TextBox")
    _wpBox.Size = UDim2.new(0.58, 0, 0.8, 0)
    _wpBox.Position = UDim2.new(0.02, 0, 0.1, 0)
    _wpBox.BackgroundColor3 = Color3.fromRGB(20, 30, 50)
    _wpBox.BackgroundTransparency = 0.2
    _wpBox.TextColor3 = Color3.fromRGB(150, 220, 255)
    _wpBox.PlaceholderText = "Waypoint Name..."
    _wpBox.Text = ""
    _wpBox.TextSize = 11
    _wpBox.Font = Enum.Font.GothamBold
    _wpBox.Parent = _wpTopFr

    local _bxc = Instance.new("UICorner")
    _bxc.CornerRadius = UDim.new(0, 6)
    _bxc.Parent = _wpBox

    local _btnSaveWP = Instance.new("TextButton")
    _btnSaveWP.Size = UDim2.new(0.36, 0, 0.8, 0)
    _btnSaveWP.Position = UDim2.new(0.62, 0, 0.1, 0)
    _btnSaveWP.BackgroundColor3 = Color3.fromRGB(0, 130, 255)
    _btnSaveWP.Text = "📌 Save Position"
    _btnSaveWP.TextColor3 = Color3.fromRGB(255, 255, 255)
    _btnSaveWP.TextSize = 10
    _btnSaveWP.Font = Enum.Font.GothamBold
    _btnSaveWP.Parent = _wpTopFr

    local _bswc = Instance.new("UICorner")
    _bswc.CornerRadius = UDim.new(0, 6)
    _bswc.Parent = _btnSaveWP

    _csld(_wpFixedTop, "⏱️ Delay For All (0.01s - 60s)", 0.01, 60, 0.5, true, function(_v)
        getgenv().WaypointDelay = _v
    end)

    _csld(_wpFixedTop, "🎯 Start From Point", 1, 20, 1, false, function(_v)
        getgenv().WaypointStartPoint = _v
    end)

    local _btnLoopAll = Instance.new("TextButton")
    _btnLoopAll.Size = UDim2.new(0.95, 0, 0, 36)
    _btnLoopAll.BackgroundColor3 = Color3.fromRGB(15, 25, 45)
    _btnLoopAll.BackgroundTransparency = 0.1
    _btnLoopAll.Text = "⚡ Start Auto Loop"
    _btnLoopAll.TextColor3 = Color3.fromRGB(0, 190, 255)
    _btnLoopAll.TextSize = 11
    _btnLoopAll.Font = Enum.Font.GothamBold
    _btnLoopAll.Parent = _wpFixedTop

    local _blac = Instance.new("UICorner")
    _blac.CornerRadius = UDim.new(0, 8)
    _blac.Parent = _btnLoopAll

    local _blas = Instance.new("UIStroke")
    _blas.Color = Color3.fromRGB(0, 140, 255)
    _blas.Thickness = 1.5
    _blas.Parent = _btnLoopAll

    local _btnDeleteAll = Instance.new("TextButton")
    _btnDeleteAll.Size = UDim2.new(0.95, 0, 0, 32)
    _btnDeleteAll.BackgroundColor3 = Color3.fromRGB(45, 15, 25)
    _btnDeleteAll.BackgroundTransparency = 0.2
    _btnDeleteAll.Text = "🗑️ Delete All Waypoints"
    _btnDeleteAll.TextColor3 = Color3.fromRGB(255, 130, 130)
    _btnDeleteAll.TextSize = 10
    _btnDeleteAll.Font = Enum.Font.GothamBold
    _btnDeleteAll.Parent = _wpFixedTop

    local _bdac = Instance.new("UICorner")
    _bdac.CornerRadius = UDim.new(0, 8)
    _bdac.Parent = _btnDeleteAll

    local _bdastr = Instance.new("UIStroke")
    _bdastr.Color = Color3.fromRGB(150, 40, 50)
    _bdastr.Thickness = 1.2
    _bdastr.Parent = _btnDeleteAll

    local _wpScrollFrame = Instance.new("ScrollingFrame")
    _wpScrollFrame.Size = UDim2.new(1, 0, 1, -225)
    _wpScrollFrame.Position = UDim2.new(0, 0, 0, 225)
    _wpScrollFrame.BackgroundTransparency = 1
    _wpScrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
    _wpScrollFrame.ScrollBarThickness = 4
    _wpScrollFrame.ScrollBarImageColor3 = Color3.fromRGB(0, 150, 255)
    _wpScrollFrame.Parent = _pWaypoints

    local _wplLayout = Instance.new("UIListLayout")
    _wplLayout.Padding = UDim.new(0, 8)
    _wplLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    _wplLayout.Parent = _wpScrollFrame

    task.spawn(function()
        while true do
            _0g3.RenderStepped:Wait()
            if getgenv().AstroRunning and getgenv().LoopTPTarget then
                _stealthTP(getgenv().LoopTPTarget)
            end
        end
    end)

    task.spawn(function()
        local _currentIdx = 1
        while true do
            if getgenv().AstroRunning and getgenv().LoopAllWaypoints then
                if (#_savedWaypoints >= 1) then
                    local _startIdx = math.clamp(getgenv().WaypointStartPoint, 1, #_savedWaypoints)
                    if (_currentIdx < _startIdx or _currentIdx > #_savedWaypoints) then
                        _currentIdx = _startIdx
                    end
                    
                    local _wp = _savedWaypoints[_currentIdx]
                    pcall(function()
                        _stealthTP(_wp.CFrame)
                        _btnLoopAll.Text = "🔄 Moving To: [" .. _currentIdx .. "/" .. #_savedWaypoints .. "] " .. _wp.Name
                    end)
                    
                    local _delayNeeded = math.max(0.01, getgenv().WaypointDelay)
                    task.wait(_delayNeeded)

                    if getgenv().LoopAllWaypoints then
                        _currentIdx = _currentIdx + 1
                        if (_currentIdx > #_savedWaypoints) then
                            _currentIdx = 1
                        end
                    end
                else
                    _btnLoopAll.Text = "⚠️ Need At Least 1 Waypoint!"
                    getgenv().LoopAllWaypoints = false
                    _btnLoopAll.BackgroundColor3 = Color3.fromRGB(15, 25, 45)
                    _btnLoopAll.TextColor3 = Color3.fromRGB(220, 50, 50)
                    _blas.Color = Color3.fromRGB(220, 50, 50)
                    task.wait(2)
                    _btnLoopAll.Text = "⚡ Start Auto Loop"
                    _btnLoopAll.TextColor3 = Color3.fromRGB(0, 190, 255)
                    _blas.Color = Color3.fromRGB(0, 140, 255)
                end
            else
                _currentIdx = math.clamp(getgenv().WaypointStartPoint, 1, math.max(1, #_savedWaypoints))
                task.wait(0.1)
            end
        end
    end)

    _btnLoopAll.MouseButton1Click:Connect(function()
        _snd()
        getgenv().LoopAllWaypoints = not getgenv().LoopAllWaypoints
        if getgenv().LoopAllWaypoints then
            getgenv().LoopTPTarget = nil
            _btnLoopAll.BackgroundColor3 = Color3.fromRGB(0, 100, 200)
            _btnLoopAll.TextColor3 = Color3.fromRGB(255, 255, 255)
            _blas.Color = Color3.fromRGB(0, 190, 255)
            _btnLoopAll.Text = "🛑 Stop Auto Loop"
        else
            _btnLoopAll.BackgroundColor3 = Color3.fromRGB(15, 25, 45)
            _btnLoopAll.TextColor3 = Color3.fromRGB(0, 190, 255)
            _blas.Color = Color3.fromRGB(0, 140, 255)
            _btnLoopAll.Text = "⚡ Start Auto Loop"
        end
    end)

    local refreshWaypointsUI
    refreshWaypointsUI = function()
        for _, _chld in pairs(_wpScrollFrame:GetChildren()) do
            if _chld:IsA("Frame") then _chld:Destroy() end
        end

        for _idx, _wpData in ipairs(_savedWaypoints) do
            local _card = Instance.new("Frame")
            _card.Size = UDim2.new(0.95, 0, 0, 46)
            _card.BackgroundColor3 = Color3.fromRGB(18, 25, 42)
            _card.BackgroundTransparency = 0.2
            _card.Parent = _wpScrollFrame

            local _cc = Instance.new("UICorner")
            _cc.CornerRadius = UDim.new(0, 8)
            _cc.Parent = _card

            local _str = Instance.new("UIStroke")
            _str.Color = Color3.fromRGB(0, 120, 220)
            _str.Thickness = 1.2
            _str.Parent = _card

            local _nLbl = Instance.new("TextLabel")
            _nLbl.Size = UDim2.new(0.38, 0, 1, 0)
            _nLbl.Position = UDim2.new(0.02, 0, 0, 0)
            _nLbl.BackgroundTransparency = 1
            _nLbl.Text = _idx .. ". 📌 " .. _wpData.Name
            _nLbl.TextColor3 = Color3.fromRGB(150, 220, 255)
            _nLbl.TextSize = 11
            _nLbl.Font = Enum.Font.GothamBold
            _nLbl.TextXAlignment = Enum.TextXAlignment.Left
            _nLbl.Parent = _card

            local _tpBtn = Instance.new("TextButton")
            _tpBtn.Size = UDim2.new(0.18, 0, 0.7, 0)
            _tpBtn.Position = UDim2.new(0.41, 0, 0.15, 0)
            _tpBtn.BackgroundColor3 = Color3.fromRGB(0, 130, 255)
            _tpBtn.Text = "🚀 TP Once"
            _tpBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
            _tpBtn.TextSize = 10
            _tpBtn.Font = Enum.Font.GothamBold
            _tpBtn.Parent = _card

            local _tbc = Instance.new("UICorner")
            _tbc.CornerRadius = UDim.new(0, 6)
            _tbc.Parent = _tpBtn

            local _loopBtn = Instance.new("TextButton")
            _loopBtn.Size = UDim2.new(0.24, 0, 0.7, 0)
            _loopBtn.Position = UDim2.new(0.60, 0, 0.15, 0)
            if getgenv().LoopTPTarget == _wpData.CFrame then
                _loopBtn.BackgroundColor3 = Color3.fromRGB(180, 40, 70)
                _loopBtn.Text = "⚡ Spam: ON"
            else
                _loopBtn.BackgroundColor3 = Color3.fromRGB(30, 45, 75)
                _loopBtn.Text = "⚡ Spam: OFF"
            end
            _loopBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
            _loopBtn.TextSize = 10
            _loopBtn.Font = Enum.Font.GothamBold
            _loopBtn.Parent = _card

            local _lbc = Instance.new("UICorner")
            _lbc.CornerRadius = UDim.new(0, 6)
            _lbc.Parent = _loopBtn

            local _delBtn = Instance.new("TextButton")
            _delBtn.Size = UDim2.new(0.13, 0, 0.7, 0)
            _delBtn.Position = UDim2.new(0.85, 0, 0.15, 0)
            _delBtn.BackgroundColor3 = Color3.fromRGB(50, 20, 30)
            _delBtn.Text = "❌"
            _delBtn.TextColor3 = Color3.fromRGB(255, 140, 140)
            _delBtn.TextSize = 10
            _delBtn.Font = Enum.Font.GothamBold
            _delBtn.Parent = _card

            local _dbc = Instance.new("UICorner")
            _dbc.CornerRadius = UDim.new(0, 6)
            _dbc.Parent = _delBtn

            local _dbstr = Instance.new("UIStroke")
            _dbstr.Color = Color3.fromRGB(120, 35, 45)
            _dbstr.Thickness = 1
            _dbstr.Parent = _delBtn

            _tpBtn.MouseButton1Click:Connect(function()
                _snd()
                _stealthTP(_wpData.CFrame)
            end)

            _loopBtn.MouseButton1Click:Connect(function()
                _snd()
                getgenv().LoopAllWaypoints = false
                _btnLoopAll.BackgroundColor3 = Color3.fromRGB(15, 25, 45)
                _btnLoopAll.TextColor3 = Color3.fromRGB(0, 190, 255)
                _blas.Color = Color3.fromRGB(0, 140, 255)
                _btnLoopAll.Text = "⚡ Start Auto Loop"

                if getgenv().LoopTPTarget == _wpData.CFrame then
                    getgenv().LoopTPTarget = nil
                else
                    getgenv().LoopTPTarget = _wpData.CFrame
                end
                refreshWaypointsUI()
            end)

            _delBtn.MouseButton1Click:Connect(function()
                _snd()
                if getgenv().LoopTPTarget == _wpData.CFrame then
                    getgenv().LoopTPTarget = nil
                end
                table.remove(_savedWaypoints, _idx)
                refreshWaypointsUI()
            end)
        end
        _wpScrollFrame.CanvasSize = UDim2.new(0, 0, 0, #_savedWaypoints * 54)
    end

    _btnDeleteAll.MouseButton1Click:Connect(function()
        _snd()
        getgenv().LoopAllWaypoints = false
        getgenv().LoopTPTarget = nil
        _savedWaypoints = {}
        _btnLoopAll.BackgroundColor3 = Color3.fromRGB(15, 25, 45)
        _btnLoopAll.TextColor3 = Color3.fromRGB(0, 190, 255)
        _blas.Color = Color3.fromRGB(0, 140, 255)
        _btnLoopAll.Text = "⚡ Start Auto Loop"
        refreshWaypointsUI()
    end)

    _btnSaveWP.MouseButton1Click:Connect(function()
        _snd()
        if _0p1.Character and _0p1.Character:FindFirstChild("HumanoidRootPart") then
            local _wpName = _wpBox.Text
            if (_wpName == "") then
                _wpName = "Place " .. (#_savedWaypoints + 1)
            end
            table.insert(_savedWaypoints, {
                Name = _wpName,
                CFrame = _0p1.Character.HumanoidRootPart.CFrame
            })
            _wpBox.Text = ""
            refreshWaypointsUI()
        end
    end)

    local _stFr = Instance.new("Frame")
    _stFr.Size = UDim2.new(0.95, 0, 0, 120)
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
    _stLbl.Text = "⚡ FPS: --\n📡 Ping: -- ms\n💻 CPU: Active | 🎮 GPU: Stable\n📍 Coords: X: 0, Y: 0, Z: 0"
    _stLbl.TextColor3 = Color3.fromRGB(150, 220, 255)
    _stLbl.TextSize = 12
    _stLbl.Font = Enum.Font.GothamBold
    _stLbl.TextXAlignment = Enum.TextXAlignment.Left
    _stLbl.Parent = _stFr

    local _gmFr = Instance.new("Frame")
    _gmFr.Size = UDim2.new(0.95, 0, 0, 130)
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
    _gmLbl.TextSize = 11
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
    _dsBtn.Size = UDim2.new(0.95, 0, 0, 42)
    _dsBtn.BackgroundColor3 = Color3.fromRGB(0, 110, 220)
    _dsBtn.BackgroundTransparency = 0.1
    _dsBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    _dsBtn.Text = "🚀 Join Astro Cosmic Discord 🌌"
    _dsBtn.TextSize = 12
    _dsBtn.Font = Enum.Font.GothamBold
    _dsBtn.Parent = _pHome

    local _dsc = Instance.new("UICorner")
    _dsc.CornerRadius = UDim.new(0, 8)
    _dsc.Parent = _dsBtn

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

    task.spawn(function()
        while true do
            _0g3.RenderStepped:Wait()
            if getgenv().AstroRunning and getgenv().SpamTPTarget then
                pcall(function()
                    local _tPlr = getgenv().SpamTPTarget
                    local _myChar = _0p1.Character
                    if (_tPlr and _tPlr.Character and _tPlr.Character:FindFirstChild("HumanoidRootPart") and _myChar and _myChar:FindFirstChild("HumanoidRootPart")) then
                        local _myHum = _myChar:FindFirstChildOfClass("Humanoid")
                        local _targetHrp = _tPlr.Character.HumanoidRootPart
                        local _myHrp = _myChar.HumanoidRootPart
                        local _tHum = _tPlr.Character:FindFirstChildOfClass("Humanoid")

                        if _myHum then
                            _myHum.PlatformStand = true
                            pcall(function()
                                _myHum:ChangeState(Enum.HumanoidStateType.Swimming)
                            end)
                            if _tHum then
                                _myHum.WalkSpeed = _tHum.WalkSpeed
                            end
                        end

                        for _, _p in pairs(_myChar:GetDescendants()) do
                            if _p:IsA("BasePart") then _p.CanCollide = false end
                        end

                        local _targetOverhead = _targetHrp.CFrame * CFrame.new(0, 3.0, 0)
                        local _distance = (_myHrp.Position - _targetHrp.Position).Magnitude
                        
                        if _distance > 50 then
                            _myHrp.CFrame = _myHrp.CFrame:Lerp(_targetOverhead, 0.25)
                        else
                            _myHrp.CFrame = _targetOverhead
                        end
                        
                        if _tHum and (_tHum.MoveDirection.Magnitude > 0) then
                            _myHrp.AssemblyLinearVelocity = _targetHrp.AssemblyLinearVelocity
                        else
                            _myHrp.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
                        end
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
    _trollContainer.ScrollBarImageColor3 = Color3.fromRGB(0, 150, 255)
    _trollContainer.Parent = _pTroll

    local _trollLayout = Instance.new("UIListLayout")
    _trollLayout.Padding = UDim.new(0, 8)
    _trollLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    _trollLayout.Parent = _trollContainer

    task.spawn(function()
        while true do
            _0g3.RenderStepped:Wait()
            if getgenv().AstroRunning and getgenv().UndergroundKillTarget then
                pcall(function()
                    local _tPlr = getgenv().UndergroundKillTarget
                    local _myChar = _0p1.Character
                    if (_tPlr and _tPlr.Character and _tPlr.Character:FindFirstChild("HumanoidRootPart") and _myChar and _myChar:FindFirstChild("HumanoidRootPart")) then
                        local _tHrp = _tPlr.Character.HumanoidRootPart
                        local _myHrp = _myChar.HumanoidRootPart
                        local _myHum = _myChar:FindFirstChildOfClass("Humanoid")
                        local _tHum = _tPlr.Character:FindFirstChildOfClass("Humanoid")

                        if _myHum then
                            _myHum.PlatformStand = true
                            pcall(function()
                                _myHum:ChangeState(Enum.HumanoidStateType.Swimming)
                            end)
                            if _tHum then
                                _myHum.WalkSpeed = _tHum.WalkSpeed
                            end
                        end

                        for _, _p in pairs(_myChar:GetDescendants()) do
                            if _p:IsA("BasePart") then _p.CanCollide = false end
                        end

                        local _glueBackPose = _tHrp.CFrame * CFrame.new(0, 0.2, 1.2)
                        local _distance = (_myHrp.Position - _tHrp.Position).Magnitude
                        
                        if _distance > 50 then
                            _myHrp.CFrame = _myHrp.CFrame:Lerp(_glueBackPose, 0.25)
                        else
                            _myHrp.CFrame = _glueBackPose
                        end
                        
                        if _tHum and (_tHum.MoveDirection.Magnitude > 0) then
                            _myHrp.AssemblyLinearVelocity = _tHrp.AssemblyLinearVelocity
                        else
                            _myHrp.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
                        end
                    end
                end)
            end
        end
    end)

    task.spawn(function()
        while true do
            _0g3.RenderStepped:Wait()
            if getgenv().AstroRunning and getgenv().BackstabTarget then
                pcall(function()
                    local _tPlr = getgenv().BackstabTarget
                    local _myChar = _0p1.Character
                    if (_tPlr and _tPlr.Character and _tPlr.Character:FindFirstChild("HumanoidRootPart") and _myChar and _myChar:FindFirstChild("HumanoidRootPart")) then
                        local _tHrp = _tPlr.Character.HumanoidRootPart
                        local _myHrp = _myChar.HumanoidRootPart
                        local _myHum = _myChar:FindFirstChildOfClass("Humanoid")
                        local _tHum = _tPlr.Character:FindFirstChildOfClass("Humanoid")

                        if _myHum then
                            _myHum.PlatformStand = true
                            pcall(function()
                                _myHum:ChangeState(Enum.HumanoidStateType.Swimming)
                            end)
                            if _tHum then
                                _myHum.WalkSpeed = _tHum.WalkSpeed
                            end
                        end

                        for _, _p in pairs(_myChar:GetDescendants()) do
                            if _p:IsA("BasePart") then _p.CanCollide = false end
                        end

                        local _bellyPose = _tHrp.CFrame * CFrame.new(0, 0, 0.5) * CFrame.Angles(math.rad(90), 0, 0)
                        local _distance = (_myHrp.Position - _tHrp.Position).Magnitude
                        
                        if _distance > 50 then
                            _myHrp.CFrame = _myHrp.CFrame:Lerp(_bellyPose, 0.25)
                        else
                            _myHrp.CFrame = _bellyPose
                        end
                        
                        if _tHum and (_tHum.MoveDirection.Magnitude > 0) then
                            _myHrp.AssemblyLinearVelocity = _tHrp.AssemblyLinearVelocity
                        else
                            _myHrp.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
                        end
                    end
                end)
            end
        end
    end)

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

                        for _, _p in pairs(_myChar:GetDescendants()) do
                            if _p:IsA("BasePart") then _p.CanCollide = true end
                        end

                        local _t = tick() * 25
                        local _offsetX = math.sin(_t) * 2.5
                        local _offsetZ = math.cos(_t) * 2.5
                        local _offsetY = math.sin(_t * 2) * 2 + 15

                        _myHrp.CFrame = _tHrp.CFrame + Vector3.new(_offsetX, _offsetY, _offsetZ)
                        _myHrp.AssemblyLinearVelocity = Vector3.new(math.random(-1500, 1500), math.random(1000, 3000), math.random(-1500, 1500))
                    end
                end)
            end
        end
    end)

    task.spawn(function()
        while getgenv().AstroRunning do
            for _, _chld in pairs(_tpc:GetChildren()) do
                if _chld:IsA("Frame") then _chld:Destroy() end
            end
            for _, _pl in pairs(_0g2:GetPlayers()) do
                if (_pl ~= _0p1) then
                    local _pCard = Instance.new("Frame")
                    _pCard.Size = UDim2.new(1, 0, 0, 46)
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
                    _pNameLbl.TextSize = 10
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
                        _pSpamBtn.BackgroundColor3 = Color3.fromRGB(180, 40, 70)
                        _pSpamBtn.Text = "⚡ Spam: ON"
                    else
                        _pSpamBtn.BackgroundColor3 = Color3.fromRGB(30, 45, 75)
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
                            if (_pl.Character and _pl.Character:FindFirstChild("HumanoidRootPart")) then
                                _stealthTP(_pl.Character.HumanoidRootPart.CFrame + Vector3.new(0, 3.2, 0))
                            end
                        end)
                    end)

                    _pSpamBtn.MouseButton1Click:Connect(function()
                        _snd()
                        if getgenv().SpamTPTarget == _pl then
                            getgenv().SpamTPTarget = nil
                            _pSpamBtn.BackgroundColor3 = Color3.fromRGB(30, 45, 75)
                            _pSpamBtn.Text = "⚡ Spam: OFF"
                            _f3()
                        else
                            getgenv().SpamTPTarget = _pl
                            _pSpamBtn.BackgroundColor3 = Color3.fromRGB(180, 40, 70)
                            _pSpamBtn.Text = "⚡ Spam: ON"
                        end
                    end)
                end
            end
            _tpc.CanvasSize = UDim2.new(0, 0, 0, #_0g2:GetPlayers() * 54)
            task.wait(4)
        end
    end)

    task.spawn(function()
        while getgenv().AstroRunning do
            for _, _chld in pairs(_trollContainer:GetChildren()) do
                if _chld:IsA("Frame") then _chld:Destroy() end
            end
            for _, _pl in pairs(_0g2:GetPlayers()) do
                if (_pl ~= _0p1) then
                    local _tCard = Instance.new("Frame")
                    _tCard.Size = UDim2.new(1, 0, 0, 48)
                    _tCard.BackgroundColor3 = Color3.fromRGB(18, 25, 42)
                    _tCard.BackgroundTransparency = 0.2
                    _tCard.Parent = _trollContainer

                    local _tcc = Instance.new("UICorner")
                    _tcc.CornerRadius = UDim.new(0, 8)
                    _tcc.Parent = _tCard

                    local _tStroke = Instance.new("UIStroke")
                    _tStroke.Color = Color3.fromRGB(0, 120, 220)
                    _tStroke.Thickness = 1.2
                    _tStroke.Parent = _tCard

                    local _tNameLbl = Instance.new("TextLabel")
                    _tNameLbl.Size = UDim2.new(0.32, 0, 1, 0)
                    _tNameLbl.Position = UDim2.new(0.02, 0, 0, 0)
                    _tNameLbl.BackgroundTransparency = 1
                    _tNameLbl.Text = "🗡️ " .. _pl.DisplayName
                    _tNameLbl.TextColor3 = Color3.fromRGB(150, 220, 255)
                    _tNameLbl.TextSize = 10
                    _tNameLbl.Font = Enum.Font.GothamBold
                    _tNameLbl.TextXAlignment = Enum.TextXAlignment.Left
                    _tNameLbl.Parent = _tCard

                    local _vLaunchBtn = Instance.new("TextButton")
                    _vLaunchBtn.Size = UDim2.new(0.21, 0, 0.7, 0)
                    _vLaunchBtn.Position = UDim2.new(0.34, 0, 0.15, 0)
                    if getgenv().VoidTrollTarget == _pl then
                        _vLaunchBtn.BackgroundColor3 = Color3.fromRGB(180, 40, 70)
                        _vLaunchBtn.Text = "🚀 Void: ON"
                    else
                        _vLaunchBtn.BackgroundColor3 = Color3.fromRGB(30, 45, 75)
                        _vLaunchBtn.Text = "🚀 Launch"
                    end
                    _vLaunchBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
                    _vLaunchBtn.TextSize = 9
                    _vLaunchBtn.Font = Enum.Font.GothamBold
                    _vLaunchBtn.Parent = _tCard

                    local _vlc = Instance.new("UICorner")
                    _vlc.CornerRadius = UDim.new(0, 6)
                    _vlc.Parent = _vLaunchBtn

                    local _uKillBtn = Instance.new("TextButton")
                    _uKillBtn.Size = UDim2.new(0.22, 0, 0.7, 0)
                    _uKillBtn.Position = UDim2.new(0.56, 0, 0.15, 0)
                    if getgenv().UndergroundKillTarget == _pl then
                        _uKillBtn.BackgroundColor3 = Color3.fromRGB(180, 40, 70)
                        _uKillBtn.Text = "🩹 Glue: ON"
                    else
                        _uKillBtn.BackgroundColor3 = Color3.fromRGB(30, 50, 80)
                        _uKillBtn.Text = "🩹 Glue Back"
                    end
                    _uKillBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
                    _uKillBtn.TextSize = 9
                    _uKillBtn.Font = Enum.Font.GothamBold
                    _uKillBtn.Parent = _tCard

                    local _ukc = Instance.new("UICorner")
                    _ukc.CornerRadius = UDim.new(0, 6)
                    _ukc.Parent = _uKillBtn

                    local _bstabBtn = Instance.new("TextButton")
                    _bstabBtn.Size = UDim2.new(0.20, 0, 0.7, 0)
                    _bstabBtn.Position = UDim2.new(0.79, 0, 0.15, 0)
                    if getgenv().BackstabTarget == _pl then
                        _bstabBtn.BackgroundColor3 = Color3.fromRGB(180, 40, 70)
                        _bstabBtn.Text = "🥷 Belly: ON"
                    else
                        _bstabBtn.BackgroundColor3 = Color3.fromRGB(50, 30, 60)
                        _bstabBtn.Text = "🥷 Belly Lay"
                    end
                    _bstabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
                    _bstabBtn.TextSize = 9
                    _bstabBtn.Font = Enum.Font.GothamBold
                    _bstabBtn.Parent = _tCard

                    local _bsc = Instance.new("UICorner")
                    _bsc.CornerRadius = UDim.new(0, 6)
                    _bsc.Parent = _bstabBtn

                    _vLaunchBtn.MouseButton1Click:Connect(function()
                        _snd()
                        getgenv().UndergroundKillTarget = nil
                        getgenv().BackstabTarget = nil
                        if getgenv().VoidTrollTarget == _pl then
                            getgenv().VoidTrollTarget = nil
                            _f3()
                        else
                            getgenv().VoidTrollTarget = _pl
                        end
                    end)

                    _uKillBtn.MouseButton1Click:Connect(function()
                        _snd()
                        getgenv().BackstabTarget = nil
                        getgenv().VoidTrollTarget = nil
                        if getgenv().UndergroundKillTarget == _pl then
                            getgenv().UndergroundKillTarget = nil
                            _f3()
                        else
                            getgenv().UndergroundKillTarget = _pl
                        end
                    end)

                    _bstabBtn.MouseButton1Click:Connect(function()
                        _snd()
                        getgenv().UndergroundKillTarget = nil
                        getgenv().VoidTrollTarget = nil
                        if getgenv().BackstabTarget == _pl then
                            getgenv().BackstabTarget = nil
                            _f3()
                        else
                            getgenv().BackstabTarget = _pl
                        end
                    end)
                end
            end
            _trollContainer.CanvasSize = UDim2.new(0, 0, 0, #_0g2:GetPlayers() * 54)
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

    _csld(_pCombat, "Aimbot Max Distance", 50, 1000, 300, false, function(_v) _maxDst = _v end)
    _csld(_pCombat, "Aim Smoothness %", 10, 100, 35, false, function(_v) _abSmth = _v / 100 end)

    local _botEspAct = false
    _ctg(_pBoss, "Highlight All Bots / NPCs", function(_st)
        _botEspAct = _st
        task.spawn(function()
            while _botEspAct and getgenv().AstroRunning do
                for _, _obj in pairs(_0g7:GetDescendants()) do
                    if (_obj:IsA("Model") and _obj:FindFirstChildOfClass("Humanoid") and not _0g2:GetPlayerFromCharacter(_obj)) then
                        if (_obj ~= _0p1.Character) then
                            if not _obj:FindFirstChild("AstroBotHighlight") then
                                local _hl = Instance.new("Highlight")
                                _hl.Name = "AstroBotHighlight"
                                _hl.FillColor = Color3.fromRGB(0, 255, 120)
                                _hl.OutlineColor = Color3.fromRGB(255, 255, 255)
                                _hl.Parent = _obj

                                local _bg = Instance.new("BillboardGui")
                                _bg.Name = "AstroBotTag"
                                _bg.Size = UDim2.new(0, 150, 0, 30)
                                _bg.AlwaysOnTop = true
                                _bg.ExtentsOffset = Vector3.new(0, 3, 0)
                                _bg.Parent = _obj

                                local _tx = Instance.new("TextLabel")
                                _tx.Size = UDim2.new(1, 0, 1, 0)
                                _tx.BackgroundTransparency = 1
                                _tx.Text = "🤖 BOT: " .. _obj.Name
                                _tx.TextColor3 = Color3.fromRGB(0, 255, 120)
                                _tx.TextSize = 12
                                _tx.Font = Enum.Font.GothamBold
                                _tx.Parent = _bg
                            end
                        end
                    end
                end
                task.wait(2)
            end
            if not _botEspAct then
                for _, _obj in pairs(_0g7:GetDescendants()) do
                    if ((_obj.Name == "AstroBotHighlight") or (_obj.Name == "AstroBotTag")) then _obj:Destroy() end
                end
            end
        end)
    end)

    local _bsAct = false
    _ctg(_pBoss, "Highlight All Monsters & Chasers", function(_st)
        _bsAct = _st
        task.spawn(function()
            while _bsAct and getgenv().AstroRunning do
                for _, _obj in pairs(_0g7:GetDescendants()) do
                    if (_obj:IsA("Model") and _obj:FindFirstChildOfClass("Humanoid") and not _0g2:GetPlayerFromCharacter(_obj)) then
                        if (_obj ~= _0p1.Character) then
                            if not _obj:FindFirstChild("AstroBossHighlight") then
                                local _hl = Instance.new("Highlight")
                                _hl.Name = "AstroBossHighlight"
                                _hl.FillColor = Color3.fromRGB(255, 50, 50)
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
                                _tx.Text = "🚨 CHASER/MONSTER: " .. _obj.Name
                                _tx.TextColor3 = Color3.fromRGB(255, 80, 80)
                                _tx.TextSize = 12
                                _tx.Font = Enum.Font.GothamBold
                                _tx.Parent = _bg
                            end
                        end
                    end
                end
                task.wait(2)
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
    _kGui.ResetOnSpawn = false

    local _kMain = Instance.new("Frame")
    _kMain.Size = UDim2.new(0, 320, 0, 210)
    _kMain.Position = UDim2.new(0.5, -160, 0.5, -105)
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
    _kttl.Size = UDim2.new(1, 0, 0, 45)
    _kttl.BackgroundTransparency = 1
    _kttl.Text = "🚀 Astro Cosmic System 🪐"
    _kttl.TextColor3 = Color3.fromRGB(0, 190, 255)
    _kttl.TextSize = 15
    _kttl.Font = Enum.Font.GothamBold
    _kttl.Parent = _kMain

    local _kBox = Instance.new("TextBox")
    _kBox.Size = UDim2.new(0.85, 0, 0, 40)
    _kBox.Position = UDim2.new(0.075, 0, 0.30, 0)
    _kBox.BackgroundColor3 = Color3.fromRGB(20, 30, 50)
    _kBox.BackgroundTransparency = 0.2
    _kBox.TextColor3 = Color3.fromRGB(150, 220, 255)
    _kBox.PlaceholderText = "Enter Key Here..."
    _kBox.Text = ""
    _kBox.TextSize = 13
    _kBox.Font = Enum.Font.Gotham
    _kBox.Parent = _kMain

    local _kbcr = Instance.new("UICorner")
    _kbcr.CornerRadius = UDim.new(0, 10)
    _kbcr.Parent = _kBox

    local _lBtn = Instance.new("TextButton")
    _lBtn.Size = UDim2.new(0.85, 0, 0, 42)
    _lBtn.Position = UDim2.new(0.075, 0, 0.60, 0)
    _lBtn.BackgroundColor3 = Color3.fromRGB(0, 130, 255)
    _lBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    _lBtn.Text = "Launch 🚀"
    _lBtn.TextSize = 14
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
