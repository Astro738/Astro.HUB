if setfpscap then
    pcall(function() setfpscap(240); end);
end

local v0 = game:GetService("CoreGui");
local v1 = game:GetService("Players");
local v2 = game:GetService("RunService");
local v3 = game:GetService("UserInputService");
local v4 = game:GetService("Lighting");
local v5 = game:GetService("Stats");
local v6 = game:GetService("Workspace");
local v7 = game:GetService("TeleportService");
local v8 = game:GetService("SoundService");
local v9 = game:GetService("MarketplaceService");
local v10 = v1.LocalPlayer;
local v11 = v6.CurrentCamera;

-- [حماية يدوية ذكية ضد البحث اليدوي والذكاء الاصطناعي]
local v12 = table.concat({"AstroHub", "_KeySave", ".txt"})
local v13 = table.concat({"ASTRO", "-2026", "-KEY"}, "")
local v14 = 86400;

local function v15(v22)
    if writefile then
        pcall(function()
            local v456 = v22 .. "|" .. tostring(os.time());
            writefile(v12, v456);
        end);
    end
end

local function v16()
    if (readfile and isfile and isfile(v12)) then
        local v438, v439 = pcall(function()
            return readfile(v12);
        end);
        if (v438 and v439) then
            local v493, v494 = string.match(v439, "([^|]+)|(%d+)");
            if ((v493 == v13) and v494) then
                local v553 = os.time();
                if ((v553 - tonumber(v494)) < v14) then
                    return true;
                end
            end
        end
    end
    return false;
end

getgenv().AstroRunning = false;

local function v18()
    getgenv().AstroRunning = false;
    pcall(function()
        if v10.Character then
            local v457 = v10.Character:FindFirstChildOfClass("Humanoid");
            if v457 then
                v457.PlatformStand = false;
            end
            local v458 = v10.Character:FindFirstChild("HumanoidRootPart");
            if v458 then
                v458.AssemblyLinearVelocity = Vector3.new(0, 0, 0);
            end
        end
        for v440, v441 in pairs(v6:GetDescendants()) do
            if ((v441.Name == "AstroHighlight") or (v441.Name == "AstroEggHighlight") or (v441.Name == "AstroBossHighlight") or (v441.Name == "AstroBossTag")) then
                v441:Destroy();
            end
        end
        if v10.Character then
            for v495, v496 in pairs(v10.Character:GetDescendants()) do
                if v496:IsA("BasePart") then
                    v496.CanCollide = true;
                end
            end
        end
    end);
end

v18();

if v0:FindFirstChild("AstroHubGui") then
    v0.AstroHubGui:Destroy();
end
if v0:FindFirstChild("AstroKeyGui") then
    v0.AstroKeyGui:Destroy();
end

getgenv().AutoReconnectState = false;

pcall(function()
    v0.RobloxPromptGui.promptOverlay.ChildAdded:Connect(function(v230)
        if ((v230.Name == "ErrorPrompt") and getgenv().AutoReconnectState) then
            task.wait(1);
            v7:Teleport(game.PlaceId, v10);
        end
    end);
end);

local function v20()
    pcall(function()
        local v231 = Instance.new("Sound");
        v231.SoundId = "rbxassetid://6042457221";
        v231.Volume = 0.5;
        v231.Parent = v8;
        v231:Play();
        game:GetService("Debris"):AddItem(v231, 1);
    end);
end

local function v21()
    v20();
    if v0:FindFirstChild("AstroKeyGui") then
        v0.AstroKeyGui:Destroy();
    end
    getgenv().AstroRunning = true;
    local v25 = Instance.new("ScreenGui");
    v25.Name = "AstroHubGui";
    v25.Parent = v0;
    v25.IgnoreGuiInset = true;

    local v29 = Instance.new("TextButton");
    v29.Size = UDim2.new(0, 55, 0, 55);
    v29.Position = UDim2.new(0, 20, 0.5, -28);
    v29.BackgroundColor3 = Color3.fromRGB(10, 15, 30);
    v29.BackgroundTransparency = 0.1;
    v29.TextColor3 = Color3.fromRGB(0, 180, 255);
    v29.Text = "🪐";
    v29.TextSize = 28;
    v29.Font = Enum.Font.GothamBold;
    v29.Parent = v25;

    local v40 = Instance.new("UICorner");
    v40.CornerRadius = UDim.new(1, 0);
    v40.Parent = v29;

    local v43 = Instance.new("UIStroke");
    v43.Color = Color3.fromRGB(0, 150, 255);
    v43.Thickness = 2.5;
    v43.Parent = v29;

    local v47, v48, v49;
    v29.InputBegan:Connect(function(v235)
        if ((v235.UserInputType == Enum.UserInputType.MouseButton1) or (v235.UserInputType == Enum.UserInputType.Touch)) then
            v47 = true;
            v48 = v235.Position;
            v49 = v29.Position;
            v235.Changed:Connect(function()
                if (v235.UserInputState == Enum.UserInputState.End) then
                    v47 = false;
                end
            end);
        end
    end);

    v3.InputChanged:Connect(function(v236)
        if (v47 and ((v236.UserInputType == Enum.UserInputType.MouseMovement) or (v236.UserInputType == Enum.UserInputType.Touch))) then
            local v461 = v236.Position - v48;
            v29.Position = UDim2.new(v49.X.Scale, v49.X.Offset + v461.X, v49.Y.Scale, v49.Y.Offset + v461.Y);
        end
    end);

    local v50 = Instance.new("Frame");
    v50.Size = UDim2.new(0, 540, 0, 380);
    v50.Position = UDim2.new(0.5, -270, 0.5, -190);
    v50.BackgroundColor3 = Color3.fromRGB(10, 14, 25);
    v50.BackgroundTransparency = 0.08;
    v50.BorderSizePixel = 0;
    v50.Visible = true;
    v50.Parent = v25;

    local v58 = Instance.new("UICorner");
    v58.CornerRadius = UDim.new(0, 14);
    v58.Parent = v50;

    local v61 = Instance.new("UIStroke");
    v61.Color = Color3.fromRGB(0, 130, 255);
    v61.Thickness = 2.5;
    v61.Parent = v50;

    local v65 = Instance.new("Frame");
    v65.Size = UDim2.new(1, 0, 0, 42);
    v65.BackgroundColor3 = Color3.fromRGB(15, 22, 40);
    v65.BackgroundTransparency = 0.2;
    v65.BorderSizePixel = 0;
    v65.Parent = v50;

    local v71 = Instance.new("UICorner");
    v71.CornerRadius = UDim.new(0, 14);
    v71.Parent = v65;

    local v74 = Instance.new("TextLabel");
    v74.Size = UDim2.new(0, 300, 1, 0);
    v74.Position = UDim2.new(0, 15, 0, 0);
    v74.BackgroundTransparency = 1;
    v74.Text = "🌌 Astro Hub | Cosmic Edition 🚀";
    v74.TextColor3 = Color3.fromRGB(0, 190, 255);
    v74.TextSize = 14;
    v74.Font = Enum.Font.GothamBold;
    v74.TextXAlignment = Enum.TextXAlignment.Left;
    v74.Parent = v65;

    local v85, v86, v87, v88;
    v65.InputBegan:Connect(function(v237)
        if ((v237.UserInputType == Enum.UserInputType.MouseButton1) or (v237.UserInputType == Enum.UserInputType.Touch)) then
            v85 = true;
            v87 = v237.Position;
            v88 = v50.Position;
            v237.Changed:Connect(function()
                if (v237.UserInputState == Enum.UserInputState.End) then
                    v85 = false;
                end
            end);
        end
    end);

    v65.InputChanged:Connect(function(v238)
        if ((v238.UserInputType == Enum.UserInputType.MouseMovement) or (v238.UserInputType == Enum.UserInputType.Touch)) then
            v86 = v238;
        end
    end);

    v3.InputChanged:Connect(function(v239)
        if ((v239 == v86) and v85) then
            local v465 = v239.Position - v87;
            v50.Position = UDim2.new(v88.X.Scale, v88.X.Offset + v465.X, v88.Y.Scale, v88.Y.Offset + v465.Y);
        end
    end);

    local v89 = Instance.new("TextButton");
    v89.Size = UDim2.new(0, 30, 0, 30);
    v89.Position = UDim2.new(1, -35, 0, 6);
    v89.BackgroundColor3 = Color3.fromRGB(220, 50, 50);
    v89.Text = "X";
    v89.TextColor3 = Color3.fromRGB(255, 255, 255);
    v89.TextSize = 15;
    v89.Font = Enum.Font.GothamBold;
    v89.Parent = v65;

    local v98 = Instance.new("UICorner");
    v98.CornerRadius = UDim.new(0, 6);
    v98.Parent = v89;

    local v101 = Instance.new("TextButton");
    v101.Size = UDim2.new(0, 30, 0, 30);
    v101.Position = UDim2.new(1, -70, 0, 6);
    v101.BackgroundColor3 = Color3.fromRGB(35, 65, 110);
    v101.Text = "—";
    v101.TextColor3 = Color3.fromRGB(255, 255, 255);
    v101.TextSize = 15;
    v101.Font = Enum.Font.GothamBold;
    v101.Parent = v65;

    local v110 = Instance.new("UICorner");
    v110.CornerRadius = UDim.new(0, 6);
    v110.Parent = v101;

    v29.MouseButton1Click:Connect(function()
        v20();
        v50.Visible = not v50.Visible;
    end);

    v89.MouseButton1Click:Connect(function()
        v20();
        v50.Visible = false;
    end);

    local v113 = Instance.new("ScrollingFrame");
    v113.Size = UDim2.new(0, 150, 1, -42);
    v113.Position = UDim2.new(0, 0, 0, 42);
    v113.BackgroundColor3 = Color3.fromRGB(12, 18, 30);
    v113.BackgroundTransparency = 0.3;
    v113.BorderSizePixel = 0;
    v113.CanvasSize = UDim2.new(0, 0, 0, 450);
    v113.ScrollBarThickness = 2;
    v113.Parent = v50;

    local v122 = Instance.new("UIListLayout");
    v122.Padding = UDim.new(0, 6);
    v122.HorizontalAlignment = Enum.HorizontalAlignment.Center;
    v122.Parent = v113;

    local v127 = Instance.new("Frame");
    v127.Size = UDim2.new(1, -155, 1, -45);
    v127.Position = UDim2.new(0, 155, 0, 42);
    v127.BackgroundTransparency = 1;
    v127.Parent = v50;

    local v132 = false;
    v101.MouseButton1Click:Connect(function()
        v20();
        v132 = not v132;
        v127.Visible = not v132;
        v113.Visible = not v132;
        if v132 then
            v50.Size = UDim2.new(0, 540, 0, 42);
            v101.Text = "+";
        else
            v50.Size = UDim2.new(0, 540, 0, 380);
            v101.Text = "—";
        end
    end);

    local v133 = {};
    local function v134(v244)
        local v245 = Instance.new("ScrollingFrame");
        v245.Size = UDim2.new(1, 0, 1, 0);
        v245.BackgroundTransparency = 1;
        v245.CanvasSize = UDim2.new(0, 0, 0, 650);
        v245.ScrollBarThickness = 4;
        v245.ScrollBarImageColor3 = Color3.fromRGB(0, 150, 255);
        v245.Visible = false;
        v245.Parent = v127;

        local v253 = Instance.new("UIListLayout");
        v253.Padding = UDim.new(0, 8);
        v253.HorizontalAlignment = Enum.HorizontalAlignment.Center;
        v253.Parent = v245;

        local v258 = Instance.new("TextButton");
        v258.Size = UDim2.new(0.9, 0, 0, 38);
        v258.BackgroundColor3 = Color3.fromRGB(20, 30, 50);
        v258.BackgroundTransparency = 0.3;
        v258.TextColor3 = Color3.fromRGB(100, 200, 255);
        v258.Text = v244;
        v258.TextSize = 13;
        v258.Font = Enum.Font.GothamBold;
        v258.Parent = v113;

        local v268 = Instance.new("UICorner");
        v268.CornerRadius = UDim.new(0, 8);
        v268.Parent = v258;

        v258.MouseButton1Click:Connect(function()
            v20();
            for v471, v472 in pairs(v133) do
                v472.Visible = false;
            end
            v245.Visible = true;
        end);

        table.insert(v133, v245);
        if (#v133 == 1) then
            v245.Visible = true;
        end
        return v245;
    end

    local function v135(v271, v272, v273)
        local v274 = Instance.new("Frame");
        v274.Size = UDim2.new(0.95, 0, 0, 38);
        v274.BackgroundColor3 = Color3.fromRGB(18, 25, 42);
        v274.BackgroundTransparency = 0.2;
        v274.Parent = v271;

        local v279 = Instance.new("UICorner");
        v279.CornerRadius = UDim.new(0, 8);
        v279.Parent = v274;

        local v282 = Instance.new("UIStroke");
        v282.Color = Color3.fromRGB(0, 120, 220);
        v282.Thickness = 1.2;
        v282.Parent = v274;

        local v286 = Instance.new("TextLabel");
        v286.Size = UDim2.new(1, -60, 1, 0);
        v286.Position = UDim2.new(0, 12, 0, 0);
        v286.BackgroundTransparency = 1;
        v286.Text = v272;
        v286.TextColor3 = Color3.fromRGB(180, 230, 255);
        v286.TextSize = 12;
        v286.Font = Enum.Font.GothamBold;
        v286.TextXAlignment = Enum.TextXAlignment.Left;
        v286.Parent = v274;

        local v298 = Instance.new("TextButton");
        v298.Size = UDim2.new(0, 42, 0, 22);
        v298.Position = UDim2.new(1, -50, 0.5, -11);
        v298.BackgroundColor3 = Color3.fromRGB(40, 55, 80);
        v298.Text = "";
        v298.Parent = v274;

        local v304 = Instance.new("UICorner");
        v304.CornerRadius = UDim.new(1, 0);
        v304.Parent = v298;

        local v307 = Instance.new("Frame");
        v307.Size = UDim2.new(0, 18, 0, 18);
        v307.Position = UDim2.new(0, 2, 0.5, -9);
        v307.BackgroundColor3 = Color3.fromRGB(200, 200, 200);
        v307.Parent = v298;

        local v312 = Instance.new("UICorner");
        v312.CornerRadius = UDim.new(1, 0);
        v312.Parent = v307;

        local v315 = false;
        v298.MouseButton1Click:Connect(function()
            v20();
            v315 = not v315;
            if v315 then
                v298.BackgroundColor3 = Color3.fromRGB(0, 150, 255);
                v307:TweenPosition(UDim2.new(1, -20, 0.5, -9), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.15, true);
                v307.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
            else
                v298.BackgroundColor3 = Color3.fromRGB(40, 55, 80);
                v307:TweenPosition(UDim2.new(0, 2, 0.5, -9), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.15, true);
                v307.BackgroundColor3 = Color3.fromRGB(200, 200, 200);
            end
            v273(v315);
        end);
    end

    local function v136(v316, v317, v318, v319, v320, v321)
        local v322 = Instance.new("Frame");
        v322.Size = UDim2.new(0.95, 0, 0, 42);
        v322.BackgroundColor3 = Color3.fromRGB(18, 25, 42);
        v322.BackgroundTransparency = 0.2;
        v322.Parent = v316;

        local v327 = Instance.new("UICorner");
        v327.CornerRadius = UDim.new(0, 8);
        v327.Parent = v322;

        local v330 = Instance.new("UIStroke");
        v330.Color = Color3.fromRGB(0, 120, 220);
        v330.Thickness = 1.2;
        v330.Parent = v322;

        local v334 = Instance.new("TextLabel");
        v334.Size = UDim2.new(1, -20, 0, 18);
        v334.Position = UDim2.new(0, 10, 0, 3);
        v334.BackgroundTransparency = 1;
        v334.Text = v317 .. ": " .. tostring(v320);
        v334.TextColor3 = Color3.fromRGB(130, 210, 255);
        v334.TextSize = 11;
        v334.Font = Enum.Font.GothamBold;
        v334.TextXAlignment = Enum.TextXAlignment.Left;
        v334.Parent = v322;

        local v346 = Instance.new("Frame");
        v346.Size = UDim2.new(0.92, 0, 0, 6);
        v346.Position = UDim2.new(0.04, 0, 0.72, 0);
        v346.BackgroundColor3 = Color3.fromRGB(30, 45, 70);
        v346.BorderSizePixel = 0;
        v346.Parent = v322;

        local v352 = Instance.new("UICorner");
        v352.CornerRadius = UDim.new(1, 0);
        v352.Parent = v346;

        local v355 = Instance.new("Frame");
        v355.Size = UDim2.new((v320 - v318) / (v319 - v318), 0, 1, 0);
        v355.BackgroundColor3 = Color3.fromRGB(0, 170, 255);
        v355.BorderSizePixel = 0;
        v355.Parent = v346;

        local v360 = Instance.new("UICorner");
        v360.CornerRadius = UDim.new(1, 0);
        v360.Parent = v355;

        local function v363(v443)
            local v444 = math.clamp((v443.Position.X - v346.AbsolutePosition.X) / v346.AbsoluteSize.X, 0, 1);
            local v445 = math.floor(v318 + ((v319 - v318) * v444));
            v355.Size = UDim2.new(v444, 0, 1, 0);
            v334.Text = v317 .. ": " .. tostring(v445);
            v321(v445);
        end

        local v364 = false;
        v346.InputBegan:Connect(function(v448)
            if ((v448.UserInputType == Enum.UserInputType.MouseButton1) or (v448.UserInputType == Enum.UserInputType.Touch)) then
                v364 = true;
                v20();
                v363(v448);
            end
        end);

        v3.InputChanged:Connect(function(v449)
            if (v364 and ((v449.UserInputType == Enum.UserInputType.MouseMovement) or (v449.UserInputType == Enum.UserInputType.Touch))) then
                v363(v449);
            end
        end);

        v3.InputEnded:Connect(function(v450)
            if ((v450.UserInputType == Enum.UserInputType.MouseButton1) or (v450.UserInputType == Enum.UserInputType.Touch)) then
                v364 = false;
            end
        end);
    end

    local v137 = v134("🛰️ Home & Stats");
    local v138 = v134("👨‍🚀 Player & Speed");
    local v139 = v134("🎯 Aimbot & Combat");
    local v140 = v134("🌌 Player TP");
    local v141 = v134("💎 Eggs & Rarities");
    local v142 = v134("👾 Boss Finder");
    local v143 = v134("👁️ ESP & Visuals");
    local v144 = v134("⚡ Performance");

    local v145 = false;
    local v146 = 16;
    local v147;
    local v148 = false;
    local v149 = 50;

    v135(v138, "⚡ Enable Custom Speed", function(v365)
        v145 = v365;
        if v145 then
            v147 = v2.RenderStepped:Connect(function()
                if not getgenv().AstroRunning then
                    return;
                end
                if (v10.Character and v10.Character:FindFirstChildOfClass("Humanoid")) then
                    v10.Character:FindFirstChildOfClass("Humanoid").WalkSpeed = v146;
                end
            end);
        else
            if v147 then
                v147:Disconnect();
            end
            if (v10.Character and v10.Character:FindFirstChildOfClass("Humanoid")) then
                v10.Character:FindFirstChildOfClass("Humanoid").WalkSpeed = 16;
            end
        end
    end);

    v136(v138, "👟 WalkSpeed Boost", 16, 2000, 16, function(v366)
        v146 = v366;
    end);

    v135(v138, "🛸 Pro Anti-Kick Fly", function(v367)
        v148 = v367;
        local v368 = v10.Character;
        if (not v368 or not v368:FindFirstChild("HumanoidRootPart")) then
            return;
        end
        local v369 = v368.HumanoidRootPart;
        local v370 = v368:FindFirstChildOfClass("Humanoid");
        if v148 then
            if v370 then
                v370.PlatformStand = true;
                pcall(function()
                    v370:ChangeState(Enum.HumanoidStateType.Swimming);
                end);
            end
            task.spawn(function()
                while v148 and getgenv().AstroRunning and v368 and v369.Parent do
                    v2.RenderStepped:Wait();
                    local v525 = v11.CFrame;
                    local v526 = Vector3.new(0, 0, 0);
                    if (v370 and (v370.MoveDirection.Magnitude > 0)) then
                        v526 = v370.MoveDirection;
                    end
                    if (v3:IsKeyDown(Enum.KeyCode.W) or v3:IsKeyDown(Enum.KeyCode.Up)) then
                        v526 = v525.LookVector;
                    elseif (v3:IsKeyDown(Enum.KeyCode.S) or v3:IsKeyDown(Enum.KeyCode.Down)) then
                        v526 = -v525.LookVector;
                    elseif (v3:IsKeyDown(Enum.KeyCode.D) or v3:IsKeyDown(Enum.KeyCode.Right)) then
                        v526 = v525.RightVector;
                    elseif (v3:IsKeyDown(Enum.KeyCode.A) or v3:IsKeyDown(Enum.KeyCode.Left)) then
                        v526 = -v525.RightVector;
                    end
                    if (v526.Magnitude > 0) then
                        v369.AssemblyLinearVelocity = v526 * v149;
                    else
                        v369.AssemblyLinearVelocity = Vector3.new(0, 0, 0);
                    end
                    if v370 then
                        pcall(function()
                            v370:ChangeState(Enum.HumanoidStateType.Swimming);
                        end);
                    end
                end
                if v369 then
                    v369.AssemblyLinearVelocity = Vector3.new(0, 0, 0);
                end
            end);
        else
            if v370 then
                v370.PlatformStand = false;
                pcall(function()
                    v370:ChangeState(Enum.HumanoidStateType.GettingUp);
                end);
            end
            if v369 then
                v369.AssemblyLinearVelocity = Vector3.new(0, 0, 0);
            end
        end
    end);

    v136(v138, "🚀 Fly Speed Boost", 20, 2000, 50, function(v371)
        v149 = v371;
    end);

    v135(v138, "🥾 Infinite Jump", function(v372)
        if v372 then
            _G.InfJump = v3.JumpRequest:Connect(function()
                if not getgenv().AstroRunning then
                    return;
                end
                if (v10.Character and v10.Character:FindFirstChildOfClass("Humanoid")) then
                    v10.Character:FindFirstChildOfClass("Humanoid"):ChangeState(Enum.HumanoidStateType.Jumping);
                end
            end);
        elseif _G.InfJump then
            _G.InfJump:Disconnect();
        end
    end);

    v135(v138, "👻 Safe Noclip", function(v373)
        if v373 then
            _G.NoclipConn = v2.Stepped:Connect(function()
                if not getgenv().AstroRunning then
                    return;
                end
                if v10.Character then
                    for v571, v572 in pairs(v10.Character:GetDescendants()) do
                        if v572:IsA("BasePart") then
                            v572.CanCollide = false;
                        end
                    end
                end
            end);
        else
            if _G.NoclipConn then
                _G.NoclipConn:Disconnect();
            end
            if v10.Character then
                for v557, v558 in pairs(v10.Character:GetDescendants()) do
                    if v558:IsA("BasePart") then
                        v558.CanCollide = true;
                    end
                end
            end
        end
    end);

    local v150 = Instance.new("Frame");
    v150.Size = UDim2.new(0.95, 0, 0, 130);
    v150.BackgroundColor3 = Color3.fromRGB(20, 28, 48);
    v150.BackgroundTransparency = 0.2;
    v150.Parent = v137;

    local v155 = Instance.new("UICorner");
    v155.CornerRadius = UDim.new(0, 10);
    v155.Parent = v150;

    local v158 = Instance.new("UIStroke");
    v158.Color = Color3.fromRGB(0, 140, 255);
    v158.Thickness = 1.5;
    v158.Parent = v150;

    local v162 = Instance.new("TextLabel");
    v162.Size = UDim2.new(1, -20, 1, 0);
    v162.Position = UDim2.new(0, 10, 0, 0);
    v162.BackgroundTransparency = 1;
    v162.Text = "⚡ FPS: --\n📡 Ping: -- ms\n💻 CPU: -- ms | 🎮 GPU: -- ms\n📍 Coords: X: 0, Y: 0, Z: 0";
    v162.TextColor3 = Color3.fromRGB(150, 220, 255);
    v162.TextSize = 13;
    v162.Font = Enum.Font.GothamBold;
    v162.TextXAlignment = Enum.TextXAlignment.Left;
    v162.Parent = v150;

    local v172 = Instance.new("Frame");
    v172.Size = UDim2.new(0.95, 0, 0, 140);
    v172.BackgroundColor3 = Color3.fromRGB(20, 28, 48);
    v172.BackgroundTransparency = 0.2;
    v172.Parent = v137;

    local v177 = Instance.new("UICorner");
    v177.CornerRadius = UDim.new(0, 10);
    v177.Parent = v172;

    local v180 = Instance.new("UIStroke");
    v180.Color = Color3.fromRGB(0, 140, 255);
    v180.Thickness = 1.5;
    v180.Parent = v172;

    local v184 = Instance.new("TextLabel");
    v184.Size = UDim2.new(1, -20, 1, 0);
    v184.Position = UDim2.new(0, 10, 0, 0);
    v184.BackgroundTransparency = 1;
    v184.Text = "🎮 Game: Loading...\n👤 Player: " .. v10.DisplayName .. " (@" .. v10.Name .. ")\n👥 Friends Here: Checking...";
    v184.TextColor3 = Color3.fromRGB(150, 220, 255);
    v184.TextSize = 12;
    v184.Font = Enum.Font.GothamBold;
    v184.TextXAlignment = Enum.TextXAlignment.Left;
    v184.Parent = v172;

    task.spawn(function()
        local v374 = "Roblox Game";
        pcall(function()
            local v451 = v9:GetProductInfo(game.PlaceId);
            if (v451 and v451.Name) then
                v374 = v451.Name;
            end
        end);
        while getgenv().AstroRunning do
            local v452 = {};
            for v475, v476 in pairs(v1:GetPlayers()) do
                if (v476 ~= v10) then
                    pcall(function()
                        if v10:IsFriendsWith(v476.UserId) then
                            table.insert(v452, v476.DisplayName);
                        end
                    end);
                end
            end
            local v453 = ((#v452 > 0) and table.concat(v452, ", ")) or "No Friends In Server";
            v184.Text = string.format("🎮 Game: %s\n👤 Player: %s (@%s)\n👥 Friends Here: %s", v374, v10.DisplayName, v10.Name, v453);
            task.wait(5);
        end
    end);

    local v194 = tick();
    v195 = 0;
    v2.RenderStepped:Connect(function()
        if not getgenv().AstroRunning then
            return;
        end
        v195 = v195 + 1;
        if ((tick() - v194) >= 1) then
            local v477 = v195;
            local v478 = 0;
            pcall(function()
                v478 = math.floor(v5.Network.ServerStatsItem["Data Ping"]:GetValue());
            end);
            local v479 = "X: 0, Y: 0, Z: 0";
            if (v10.Character and v10.Character:FindFirstChild("HumanoidRootPart")) then
                local v529 = v10.Character.HumanoidRootPart.Position;
                v479 = string.format("X: %d, Y: %d, Z: %d", math.floor(v529.X), math.floor(v529.Y), math.floor(v529.Z));
            end
            v162.Text = string.format("⚡ FPS: %d | 📡 Ping: %d ms\n💻 CPU: Active | 🎮 GPU: Stable\n📍 Coords: %s", v477, v478, v479);
            v195 = 0;
            v194 = tick();
        end
    end);

    local v196 = Instance.new("TextButton");
    v196.Size = UDim2.new(0.95, 0, 0, 45);
    v196.BackgroundColor3 = Color3.fromRGB(0, 110, 220);
    v196.BackgroundTransparency = 0.1;
    v196.TextColor3 = Color3.fromRGB(255, 255, 255);
    v196.Text = "🚀 Join Astro Cosmic Discord 🌌";
    v196.TextSize = 13;
    v196.Font = Enum.Font.GothamBold;
    v196.Parent = v137;

    local v205 = Instance.new("UICorner");
    v205.CornerRadius = UDim.new(0, 8);
    v205.Parent = v196;

    local v208 = Instance.new("UIStroke");
    v208.Color = Color3.fromRGB(100, 200, 255);
    v208.Thickness = 1.5;
    v208.Parent = v196;

    v196.MouseButton1Click:Connect(function()
        v20();
        if setclipboard then
            -- [حماية رابط الديسكورد يدوياً أيضاً]
            setclipboard("https://discord.gg/" .. "vnTrCe2GSU");
            v196.Text = "✅ Link Copied! Welcome Aboard 🚀";
            task.wait(2.5);
            v196.Text = "🚀 Join Astro Cosmic Discord 🌌";
        end
    end);

    v135(v137, "Auto Reconnect Server", function(v375)
        getgenv().AutoReconnectState = v375;
    end);

    local v212 = Instance.new("ScrollingFrame");
    v212.Size = UDim2.new(0.95, 0, 1, -20);
    v212.BackgroundTransparency = 1;
    v212.CanvasSize = UDim2.new(0, 0, 0, 0);
    v212.ScrollBarThickness = 4;
    v212.ScrollBarImageColor3 = Color3.fromRGB(0, 150, 255);
    v212.Parent = v140;

    local v219 = Instance.new("UIListLayout");
    v219.Padding = UDim.new(0, 8);
    v219.HorizontalAlignment = Enum.HorizontalAlignment.Center;
    v219.Parent = v212;

    task.spawn(function()
        while getgenv().AstroRunning do
            for v482, v483 in pairs(v212:GetChildren()) do
                if v483:IsA("TextButton") then
                    v483:Destroy();
                end
            end
            for v484, v485 in pairs(v1:GetPlayers()) do
                if (v485 ~= v10) then
                    local v530 = Instance.new("TextButton");
                    v530.Size = UDim2.new(1, 0, 0, 38);
                    v530.BackgroundColor3 = Color3.fromRGB(18, 25, 42);
                    v530.BackgroundTransparency = 0.2;
                    v530.TextColor3 = Color3.fromRGB(150, 220, 255);
                    v530.Text = "🚀 TP to: " .. v485.DisplayName .. " (@" .. v485.Name .. ")";
                    v530.TextSize = 12;
                    v530.Font = Enum.Font.GothamBold;
                    v530.Parent = v212;

                    local v540 = Instance.new("UICorner");
                    v540.CornerRadius = UDim.new(0, 8);
                    v540.Parent = v530;

                    v530.MouseButton1Click:Connect(function()
                        v20();
                        pcall(function()
                            if (v485.Character and v485.Character:FindFirstChild("HumanoidRootPart") and v10.Character and v10.Character:FindFirstChild("HumanoidRootPart")) then
                                local v579 = v485.Character.HumanoidRootPart;
                                local v580 = v10.Character.HumanoidRootPart;
                                for v586 = 0, 1, 0.1 do
                                    v580.CFrame = v580.CFrame:Lerp(v579.CFrame + Vector3.new(0, 3, 0), v586);
                                    task.wait(0.02);
                                end
                            end
                        end);
                    end);
                end
            end
            v212.CanvasSize = UDim2.new(0, 0, 0, #v1:GetPlayers() * 45);
            task.wait(4);
        end
    end);

    local v223;
    local v224 = 300;
    local v225 = 0.35;

    v135(v139, "Aimbot (Smart Team Check)", function(v377)
        if v223 then
            v223:Disconnect();
            v223 = nil;
        end
        if v377 then
            v223 = v2.RenderStepped:Connect(function()
                if not getgenv().AstroRunning then
                    return;
                end
                local v502 = nil;
                local v503 = math.huge;
                local v504 = Vector2.new(v11.ViewportSize.X / 2, v11.ViewportSize.Y / 2);
                local v505 = v10.Character;
                local v506 = v505 and v505:FindFirstChild("HumanoidRootPart");
                if not v506 then
                    return;
                end
                for v543, v544 in pairs(v1:GetPlayers()) do
                    if ((v544 ~= v10) and v544.Character and v544.Character:FindFirstChild("Head") and v544.Character:FindFirstChildOfClass("Humanoid") and (v544.Character:FindFirstChildOfClass("Humanoid").Health > 0)) then
                        local v573 = false;
                        if (v10.Team and v544.Team and (v10.Team == v544.Team)) then
                            v573 = true;
                        end
                        if not v573 then
                            local v581 = v544.Character.Head;
                            local v582 = (v506.Position - v581.Position).Magnitude;
                            if (v582 <= v224) then
                                local v619, v620 = v11:WorldToViewportPoint(v581.Position);
                                if v620 then
                                    local v621 = (Vector2.new(v619.X, v619.Y) - v504).Magnitude;
                                    if (v621 < v503) then
                                        v503 = v621;
                                        v502 = v581;
                                    end
                                end
                            end
                        end
                    end
                end
                if v502 then
                    local v559 = CFrame.new(v11.CFrame.Position, v502.Position);
                    v11.CFrame = v11.CFrame:Lerp(v559, v225);
                end
            end);
        end
    end);

    local v226 = false;
    v135(v139, "Massive Giant Hitbox (Very Big)", function(v378)
        v226 = v378;
        task.spawn(function()
            while v226 and getgenv().AstroRunning do
                for v507, v508 in pairs(v1:GetPlayers()) do
                    if (v508 ~= v10) then
                        local v561 = v10.Team and v508.Team and (v10.Team == v508.Team);
                        if (not v561 and v508.Character and v508.Character:FindFirstChild("HumanoidRootPart")) then
                            pcall(function()
                                v508.Character.HumanoidRootPart.Size = Vector3.new(40, 40, 40);
                                v508.Character.HumanoidRootPart.Transparency = 0.85;
                                v508.Character.HumanoidRootPart.CanCollide = false;
                            end);
                        end
                    end
                end
                task.wait(1);
            end
            if not v226 then
                for v545, v546 in pairs(v1:GetPlayers()) do
                    if ((v546 ~= v10) and v546.Character and v546.Character:FindFirstChild("HumanoidRootPart")) then
                        pcall(function()
                            v546.Character.HumanoidRootPart.Size = Vector3.new(2, 2, 1);
                            v546.Character.HumanoidRootPart.Transparency = 1;
                        end);
                    end
                end
            end
        end);
    end);

    v136(v139, "Aimbot Max Distance", 50, 1000, 300, function(v379)
        v224 = v379;
    end);
    v136(v139, "Aim Smoothness %", 10, 100, 35, function(v380)
        v225 = v380 / 100;
    end);

    local v227 = false;
    v135(v141, "Highlight Eggs & Rarities", function(v381)
        v227 = v381;
        task.spawn(function()
            while v227 and getgenv().AstroRunning do
                for v509, v510 in pairs(v6:GetDescendants()) do
                    local v511 = string.lower(v510.Name);
                    if (string.find(v511, "egg") or string.find(v511, "divine") or string.find(v511, "secret") or string.find(v511, "mythic") or string.find(v511, "legendary")) then
                        if (v510:IsA("Model") or v510:IsA("BasePart")) then
                            if not v510:FindFirstChild("AstroEggHighlight") then
                                local v588 = Instance.new("Highlight");
                                v588.Name = "AstroEggHighlight";
                                v588.FillColor = Color3.fromRGB(0, 150, 255);
                                v588.OutlineColor = Color3.fromRGB(255, 255, 255);
                                v588.Parent = v510;
                            end
                        end
                    end
                end
                task.wait(3);
            end
            if not v227 then
                for v547, v548 in pairs(v6:GetDescendants()) do
                    if (v548.Name == "AstroEggHighlight") then
                        v548:Destroy();
                    end
                end
            end
        end);
    end);

    local v228 = false;
    v135(v142, "Highlight All Bosses", function(v382)
        v228 = v382;
        task.spawn(function()
            while v228 and getgenv().AstroRunning do
                for v512, v513 in pairs(v6:GetDescendants()) do
                    local v514 = string.lower(v513.Name);
                    if (string.find(v514, "boss") or string.find(v514, "monster")) then
                        if (v513:IsA("Model") and v513:FindFirstChildOfClass("Humanoid")) then
                            if not v513:FindFirstChild("AstroBossHighlight") then
                                local v593 = Instance.new("Highlight");
                                v593.Name = "AstroBossHighlight";
                                v593.FillColor = Color3.fromRGB(0, 170, 255);
                                v593.OutlineColor = Color3.fromRGB(255, 255, 255);
                                v593.Parent = v513;

                                local v598 = Instance.new("BillboardGui");
                                v598.Name = "AstroBossTag";
                                v598.Size = UDim2.new(0, 150, 0, 30);
                                v598.AlwaysOnTop = true;
                                v598.ExtentsOffset = Vector3.new(0, 3, 0);
                                v598.Parent = v513;

                                local v604 = Instance.new("TextLabel");
                                v604.Size = UDim2.new(1, 0, 1, 0);
                                v604.BackgroundTransparency = 1;
                                v604.Text = "👹 BOSS: " .. v513.Name;
                                v604.TextColor3 = Color3.fromRGB(0, 200, 255);
                                v604.TextSize = 14;
                                v604.Font = Enum.Font.GothamBold;
                                v604.Parent = v598;
                            end
                        end
                    end
                end
                task.wait(3);
            end
            if not v228 then
                for v549, v550 in pairs(v6:GetDescendants()) do
                    if ((v550.Name == "AstroBossHighlight") or (v550.Name == "AstroBossTag")) then
                        v550:Destroy();
                    end
                end
            end
        end);
    end);

    local v229 = false;
    v135(v143, "Player ESP (Smart Clean)", function(v383)
        v229 = v383;
        task.spawn(function()
            while v229 and getgenv().AstroRunning do
                for v515, v516 in pairs(v1:GetPlayers()) do
                    if (v516 ~= v10) then
                        local v562 = v516.Character;
                        local v563 = v562 and v562:FindFirstChildOfClass("Humanoid");
                        if (v562 and v563 and (v563.Health > 0)) then
                            if not v562:FindFirstChild("AstroHighlight") then
                                local v613 = Instance.new("Highlight");
                                v613.Name = "AstroHighlight";
                                v613.FillColor = Color3.fromRGB(0, 130, 255);
                                v613.OutlineColor = Color3.fromRGB(255, 255, 255);
                                v613.Parent = v562;
                            end
                        elseif (v562 and v562:FindFirstChild("AstroHighlight")) then
                            v562.AstroHighlight:Destroy();
                        end
                    end
                end
                task.wait(0.2);
            end
            if not v229 then
                for v551, v552 in pairs(v1:GetPlayers()) do
                    if (v552.Character and v552.Character:FindFirstChild("AstroHighlight")) then
                        v552.Character.AstroHighlight:Destroy();
                    end
                end
            end
        end);
    end);

    v135(v144, "Potato Mode (Boost FPS)", function(v384)
        if v384 then
            for v517, v518 in pairs(v6:GetDescendants()) do
                if v518:IsA("BasePart") then
                    v518.Material = Enum.Material.SmoothPlastic;
                    v518.Reflectance = 0;
                elseif (v518:IsA("Decal") or v518:IsA("Texture")) then
                    v518.Transparency = 1;
                end
            end
            v4.GlobalShadows = false;
            v4.FogEnd = 8999999488;
            settings().Rendering.QualityLevel = Enum.QualityLevel.Level01;
        else
            v4.GlobalShadows = true;
            settings().Rendering.QualityLevel = Enum.QualityLevel.Automatic;
        end
    end);
end

if v16() then
    v21();
else
    local v385 = Instance.new("ScreenGui");
    v385.Name = "AstroKeyGui";
    v385.Parent = v0;
    v385.IgnoreGuiInset = true;

    local v389 = Instance.new("Frame");
    v389.Size = UDim2.new(0, 320, 0, 200);
    v389.Position = UDim2.new(0.5, -160, 0.5, -100);
    v389.BackgroundColor3 = Color3.fromRGB(10, 15, 30);
    v389.BackgroundTransparency = 0.1;
    v389.BorderSizePixel = 0;
    v389.Parent = v385;

    local v396 = Instance.new("UICorner");
    v396.CornerRadius = UDim.new(0, 16);
    v396.Parent = v389;

    local v399 = Instance.new("UIStroke");
    v399.Color = Color3.fromRGB(0, 140, 255);
    v399.Thickness = 2.5;
    v399.Parent = v389;

    local v403 = Instance.new("TextLabel");
    v403.Size = UDim2.new(1, 0, 0, 40);
    v403.BackgroundTransparency = 1;
    v403.Text = "🚀 Astro Cosmic System 🪐";
    v403.TextColor3 = Color3.fromRGB(0, 190, 255);
    v403.TextSize = 16;
    v403.Font = Enum.Font.GothamBold;
    v403.Parent = v389;

    local v412 = Instance.new("TextBox");
    v412.Size = UDim2.new(0.8, 0, 0, 40);
    v412.Position = UDim2.new(0.1, 0, 0.35, 0);
    v412.BackgroundColor3 = Color3.fromRGB(20, 30, 50);
    v412.BackgroundTransparency = 0.2;
    v412.TextColor3 = Color3.fromRGB(150, 220, 255);
    v412.PlaceholderText = "Enter Key Here...";
    v412.Text = "";
    v412.TextSize = 14;
    v412.Font = Enum.Font.Gotham;
    v412.Parent = v389;

    local v424 = Instance.new("UICorner");
    v424.CornerRadius = UDim.new(0, 10);
    v424.Parent = v412;

    LaunchBtn = Instance.new("TextButton");
    LaunchBtn.Size = UDim2.new(0.8, 0, 0, 40);
    LaunchBtn.Position = UDim2.new(0.1, 0, 0.65, 0);
    LaunchBtn.BackgroundColor3 = Color3.fromRGB(0, 130, 255);
    LaunchBtn.TextColor3 = Color3.fromRGB(255, 255, 255);
    LaunchBtn.Text = "Launch 🚀";
    LaunchBtn.TextSize = 15;
    LaunchBtn.Font = Enum.Font.GothamBold;
    LaunchBtn.Parent = v389;

    local v435 = Instance.new("UICorner");
    v435.CornerRadius = UDim.new(0, 10);
    v435.Parent = LaunchBtn;

    LaunchBtn.MouseButton1Click:Connect(function()
        if (v412.Text == v13) then
            v15(v13);
            v21();
        else
            v20();
            v412.Text = "";
            v412.PlaceholderText = "Wrong Key! Try Again";
        end
    end);
end
