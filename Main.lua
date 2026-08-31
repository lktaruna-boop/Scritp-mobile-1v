-- ============================================
-- PAINEL HACK MOBILE ULTRA PREMIUM
-- DESIGN MODERNO | JOYSTICK | ATALHOS
-- ============================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local LocalPlayer = Players.LocalPlayer
local Workspace = game:GetService("Workspace")
local TweenService = game:GetService("TweenService")
local SoundService = game:GetService("SoundService")

-- ========== CONFIGURAÇÕES ==========
local CONFIG = {
    MenuColor = Color3.fromRGB(20, 20, 40),
    AccentColor = Color3.fromRGB(255, 200, 50),
    ButtonHeight = 50,
    FlySpeed = 60,
    Sensitivity = 1.0,
    AimbotRange = 200,
}

-- ========== VARIÁVEIS GLOBAIS ==========
local aimbotActive = false
local aimbotConnection = nil
local espActive = false
local espHighlights = {}
local speedActive = false
local originalSpeed = 16
local jumpActive = false
local nvActive = false
local godModeActive = false
local infiniteAmmoActive = false
local antiKickActive = false
local flyActive = false
local noClipActive = false
local invisibleActive = false
local instantKillActive = false
local superFarActive = false
local freezeActive = false
local explodeActive = false
local silentAimActive = false
local currentSpeed = 70
local flyConnection = nil
local noClipConnection = nil
local antiKickConnection = nil

-- ========== VARIÁVEIS JOYSTICK ==========
local joystickActive = false
local joystickDirection = Vector2.new(0, 0)
local joystickPosition = Vector2.new(0, 0)

-- ========== CRIAR GUI PRINCIPAL ==========
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "HackMenuMobile"
screenGui.Parent = CoreGui
screenGui.ResetOnSpawn = false

-- ========== BOTÃO FLUTUANTE (ABRIR/FECHAR) ==========
local floatBtn = Instance.new("TextButton")
floatBtn.Size = UDim2.new(0, 55, 0, 55)
floatBtn.Position = UDim2.new(0.82, 0, 0.03, 0)
floatBtn.BackgroundColor3 = CONFIG.AccentColor
floatBtn.BackgroundTransparency = 0.1
floatBtn.Text = "🔥"
floatBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
floatBtn.Font = Enum.Font.GothamBold
floatBtn.TextSize = 24
floatBtn.BorderSizePixel = 0
floatBtn.Parent = screenGui
floatBtn.ZIndex = 999

local floatCorner = Instance.new("UICorner")
floatCorner.CornerRadius = UDim.new(1, 0)
floatCorner.Parent = floatBtn

-- Sombra do botão flutuante
local floatShadow = Instance.new("Frame")
floatShadow.Size = UDim2.new(0, 60, 0, 60)
floatShadow.Position = UDim2.new(0.818, 0, 0.025, 0)
floatShadow.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
floatShadow.BackgroundTransparency = 0.5
floatShadow.BorderSizePixel = 0
floatShadow.Parent = screenGui
floatShadow.ZIndex = 998

local shadowCorner = Instance.new("UICorner")
shadowCorner.CornerRadius = UDim.new(1, 0)
shadowCorner.Parent = floatShadow

-- ========== MENU PRINCIPAL ==========
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 320, 0, 520)
mainFrame.Position = UDim2.new(0.5, -160, 0.5, -260)
mainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 30)
mainFrame.BackgroundTransparency = 0.12
mainFrame.BorderSizePixel = 0
mainFrame.ClipsDescendants = true
mainFrame.Parent = screenGui
mainFrame.Visible = false
mainFrame.ZIndex = 100

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 16)
corner.Parent = mainFrame

-- Brilho do menu
local glow = Instance.new("Frame")
glow.Size = UDim2.new(1.05, 0, 1.05, 0)
glow.Position = UDim2.new(-0.025, 0, -0.025, 0)
glow.BackgroundColor3 = CONFIG.AccentColor
glow.BackgroundTransparency = 0.95
glow.BorderSizePixel = 0
glow.Parent = mainFrame

local glowCorner = Instance.new("UICorner")
glowCorner.CornerRadius = UDim.new(0, 20)
glowCorner.Parent = glow

-- ========== TÍTULO COM ANIMAÇÃO ==========
local titleFrame = Instance.new("Frame")
titleFrame.Size = UDim2.new(1, 0, 0, 55)
titleFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 50)
titleFrame.BackgroundTransparency = 0.3
titleFrame.BorderSizePixel = 0
titleFrame.Parent = mainFrame

local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 16)
titleCorner.Parent = titleFrame

local title = Instance.new("TextLabel")
title.Size = UDim2.new(0.7, 0, 1, 0)
title.Position = UDim2.new(0.05, 0, 0, 0)
title.BackgroundTransparency = 1
title.Text = "📱 MOBILE PRO"
title.TextColor3 = CONFIG.AccentColor
title.Font = Enum.Font.GothamBold
title.TextSize = 20
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = titleFrame

-- Subtítulo
local subTitle = Instance.new("TextLabel")
subTitle.Size = UDim2.new(0.7, 0, 0, 16)
subTitle.Position = UDim2.new(0.05, 0, 0.65, 0)
subTitle.BackgroundTransparency = 1
subTitle.Text = "Ultimate Hack"
subTitle.TextColor3 = Color3.fromRGB(180, 180, 200)
subTitle.Font = Enum.Font.Gotham
subTitle.TextSize = 11
subTitle.TextXAlignment = Enum.TextXAlignment.Left
subTitle.Parent = titleFrame

-- Botão fechar
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 40, 0, 40)
closeBtn.Position = UDim2.new(1, -48, 0, 7)
closeBtn.BackgroundColor3 = Color3.fromRGB(200, 30, 30)
closeBtn.BackgroundTransparency = 0.2
closeBtn.Text = "✕"
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 20
closeBtn.BorderSizePixel = 0
closeBtn.Parent = titleFrame

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(1, 0)
closeCorner.Parent = closeBtn

closeBtn.MouseButton1Click:Connect(function()
    mainFrame.Visible = false
    floatBtn.Visible = true
end)

-- ========== SCROLLVIEW PRINCIPAL ==========
local scrollFrame = Instance.new("ScrollingFrame")
scrollFrame.Size = UDim2.new(1, 0, 1, -55)
scrollFrame.Position = UDim2.new(0, 0, 0, 55)
scrollFrame.BackgroundTransparency = 1
scrollFrame.BorderSizePixel = 0
scrollFrame.Parent = mainFrame
scrollFrame.CanvasSize = UDim2.new(0, 0, 0, 1300)
scrollFrame.ScrollBarThickness = 3
scrollFrame.ScrollBarImageColor3 = CONFIG.AccentColor

-- ========== FUNÇÃO CRIAR BOTÃO PREMIUM ==========
local function createPremiumButton(parent, text, yPos, color, icon)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0.92, 0, 0, CONFIG.ButtonHeight)
    frame.Position = UDim2.new(0.04, 0, yPos, 0)
    frame.BackgroundColor3 = color or Color3.fromRGB(50, 50, 80)
    frame.BackgroundTransparency = 0.15
    frame.BorderSizePixel = 0
    frame.Parent = parent
    frame.ClipsDescendants = true
    
    local frameCorner = Instance.new("UICorner")
    frameCorner.CornerRadius = UDim.new(0, 10)
    frameCorner.Parent = frame
    
    -- Ícone
    local iconLabel = Instance.new("TextLabel")
    iconLabel.Size = UDim2.new(0, 35, 1, 0)
    iconLabel.BackgroundTransparency = 1
    iconLabel.Text = icon or "🔹"
    iconLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    iconLabel.Font = Enum.Font.Gotham
    iconLabel.TextSize = 20
    iconLabel.TextXAlignment = Enum.TextXAlignment.Center
    iconLabel.Parent = frame
    
    -- Texto do botão
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 1, 0)
    btn.BackgroundTransparency = 1
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.GothamSemibold
    btn.TextSize = 14
    btn.TextXAlignment = Enum.TextXAlignment.Left
    btn.TextYAlignment = Enum.TextYAlignment.Center
    btn.Parent = frame
    
    -- Feedback touch
    btn.TouchTap:Connect(function()
        TweenService:Create(frame, TweenInfo.new(0.1), {BackgroundTransparency = 0.3}):Play()
        wait(0.1)
        TweenService:Create(frame, TweenInfo.new(0.1), {BackgroundTransparency = 0.15}):Play()
    end)
    
    return btn, frame
end

-- ========== CATEGORIAS ==========
-- Categoria: Combate
local combatLabel = Instance.new("TextLabel")
combatLabel.Size = UDim2.new(0.92, 0, 0, 25)
combatLabel.Position = UDim2.new(0.04, 0, 0.02, 0)
combatLabel.BackgroundTransparency = 1
combatLabel.Text = "⚔️ COMBATE"
combatLabel.TextColor3 = CONFIG.AccentColor
combatLabel.Font = Enum.Font.GothamBold
combatLabel.TextSize = 15
combatLabel.TextXAlignment = Enum.TextXAlignment.Left
combatLabel.Parent = scrollFrame

-- 1. AIMBOT
local aimbotBtn, aimbotFrame = createPremiumButton(scrollFrame, "🎯 AIMBOT 100% [OFF]", 0.07, Color3.fromRGB(60, 30, 40), "🎯")

aimbotBtn.MouseButton1Click:Connect(function()
    aimbotActive = not aimbotActive
    aimbotBtn.Text = aimbotActive and "🎯 AIMBOT 100% [ON]" or "🎯 AIMBOT 100% [OFF]"
    aimbotFrame.BackgroundColor3 = aimbotActive and Color3.fromRGB(30, 60, 40) or Color3.fromRGB(60, 30, 40)
    
    if aimbotActive then
        aimbotConnection = RunService.Heartbeat:Connect(function()
            if not aimbotActive then return end
            local char = LocalPlayer.Character
            if not char then return end
            local hrp = char:FindFirstChild("HumanoidRootPart")
            if not hrp then return end
            
            local closest = nil
            local closestDist = superFarActive and math.huge or CONFIG.AimbotRange
            
            for _, player in pairs(Players:GetPlayers()) do
                if player ~= LocalPlayer then
                    local targetChar = player.Character
                    if targetChar and targetChar:FindFirstChild("Humanoid") and targetChar.Humanoid.Health > 0 then
                        local targetHrp = targetChar:FindFirstChild("HumanoidRootPart")
                        if targetHrp then
                            local dist = (targetHrp.Position - hrp.Position).Magnitude
                            if dist < closestDist then
                                closestDist = dist
                                closest = targetChar
                            end
                        end
                    end
                end
            end
            
            if closest then
                local head = closest:FindFirstChild("Head")
                if head then
                    if silentAimActive then
                        local mouse = LocalPlayer:GetMouse()
                        mouse.Target = head
                    else
                        hrp.CFrame = CFrame.new(hrp.Position, head.Position)
                    end
                    
                    if instantKillActive then
                        local humanoid = closest:FindFirstChild("Humanoid")
                        if humanoid then
                            humanoid.Health = 0
                        end
                    end
                end
            end
        end)
    else
        if aimbotConnection then
            aimbotConnection:Disconnect()
            aimbotConnection = nil
        end
    end
end)

-- 2. SUPER FAR
local farBtn, farFrame = createPremiumButton(scrollFrame, "🔭 SUPER FAR [OFF]", 0.14, Color3.fromRGB(30, 30, 60), "🔭")

farBtn.MouseButton1Click:Connect(function()
    superFarActive = not superFarActive
    farBtn.Text = superFarActive and "🔭 SUPER FAR [ON]" or "🔭 SUPER FAR [OFF]"
    farFrame.BackgroundColor3 = superFarActive and Color3.fromRGB(30, 60, 40) or Color3.fromRGB(30, 30, 60)
end)

-- 3. SILENT AIM
local silentBtn, silentFrame = createPremiumButton(scrollFrame, "🔇 SILENT AIM [OFF]", 0.21, Color3.fromRGB(60, 30, 60), "🔇")

silentBtn.MouseButton1Click:Connect(function()
    silentAimActive = not silentAimActive
    silentBtn.Text = silentAimActive and "🔇 SILENT AIM [ON]" or "🔇 SILENT AIM [OFF]"
    silentFrame.BackgroundColor3 = silentAimActive and Color3.fromRGB(30, 60, 40) or Color3.fromRGB(60, 30, 60)
end)

-- 4. INSTANT KILL
local killBtn, killFrame = createPremiumButton(scrollFrame, "💀 INSTANT KILL [OFF]", 0.28, Color3.fromRGB(60, 30, 30), "💀")

killBtn.MouseButton1Click:Connect(function()
    instantKillActive = not instantKillActive
    killBtn.Text = instantKillActive and "💀 INSTANT KILL [ON]" or "💀 INSTANT KILL [OFF]"
    killFrame.BackgroundColor3 = instantKillActive and Color3.fromRGB(30, 60, 40) or Color3.fromRGB(60, 30, 30)
end)

-- Categoria: Visuais
local visualLabel = Instance.new("TextLabel")
visualLabel.Size = UDim2.new(0.92, 0, 0, 25)
visualLabel.Position = UDim2.new(0.04, 0, 0.35, 0)
visualLabel.BackgroundTransparency = 1
visualLabel.Text = "👁️ VISUAIS"
visualLabel.TextColor3 = CONFIG.AccentColor
visualLabel.Font = Enum.Font.GothamBold
visualLabel.TextSize = 15
visualLabel.TextXAlignment = Enum.TextXAlignment.Left
visualLabel.Parent = scrollFrame

-- 5. ESP BOX
local espBtn, espFrame = createPremiumButton(scrollFrame, "📦 ESP BOX [OFF]", 0.40, Color3.fromRGB(30, 30, 60), "📦")

espBtn.MouseButton1Click:Connect(function()
    espActive = not espActive
    espBtn.Text = espActive and "📦 ESP BOX [ON]" or "📦 ESP BOX [OFF]"
    espFrame.BackgroundColor3 = espActive and Color3.fromRGB(30, 60, 40) or Color3.fromRGB(30, 30, 60)
    
    if espActive then
        local function addESP(player)
            if player == LocalPlayer then return end
            local char = player.Character
            if not char then return end
            
            local highlight = Instance.new("Highlight")
            highlight.Parent = char
            highlight.FillColor = Color3.fromRGB(255, 50, 50)
            highlight.FillTransparency = 0.3
            highlight.OutlineColor = Color3.fromRGB(255, 255, 0)
            highlight.OutlineTransparency = 0
            espHighlights[player] = highlight
        end
        
        local function removeESP(player)
            if espHighlights[player] then
                espHighlights[player]:Destroy()
                espHighlights[player] = nil
            end
        end
        
        for _, player in pairs(Players:GetPlayers()) do
            addESP(player)
        end
        
        Players.PlayerAdded:Connect(addESP)
        Players.PlayerRemoving:Connect(removeESP)
        
        for _, player in pairs(Players:GetPlayers()) do
            player.CharacterAdded:Connect(function()
                removeESP(player)
                addESP(player)
            end)
        end
    else
        for _, highlight in pairs(espHighlights) do
            highlight:Destroy()
        end
        espHighlights = {}
    end
end)

-- 6. INVISIBILIDADE
local invisibleBtn, invisibleFrame = createPremiumButton(scrollFrame, "👻 INVISIBILIDADE [OFF]", 0.47, Color3.fromRGB(60, 30, 60), "👻")

invisibleBtn.MouseButton1Click:Connect(function()
    invisibleActive = not invisibleActive
    invisibleBtn.Text = invisibleActive and "👻 INVISIBILIDADE [ON]" or "👻 INVISIBILIDADE [OFF]"
    invisibleFrame.BackgroundColor3 = invisibleActive and Color3.fromRGB(30, 60, 40) or Color3.fromRGB(60, 30, 60)
    
    local char = LocalPlayer.Character
    if char then
        for _, part in pairs(char:GetDescendants()) do
            if part:IsA("BasePart") then
                part.Transparency = invisibleActive and 1 or 0
            end
        end
    end
end)

-- 7. VISÃO NOTURNA
local nvBtn, nvFrame = createPremiumButton(scrollFrame, "🌙 VISÃO NOTURNA [OFF]", 0.54, Color3.fromRGB(30, 30, 60), "🌙")

nvBtn.MouseButton1Click:Connect(function()
    nvActive = not nvActive
    nvBtn.Text = nvActive and "🌙 VISÃO NOTURNA [ON]" or "🌙 VISÃO NOTURNA [OFF]"
    nvFrame.BackgroundColor3 = nvActive and Color3.fromRGB(30, 60, 40) or Color3.fromRGB(30, 30, 60)
    
    local lighting = game:GetService("Lighting")
    if nvActive then
        lighting.Ambient = Color3.fromRGB(100, 100, 150)
        lighting.Brightness = 2
    else
        lighting.Ambient = Color3.fromRGB(0, 0, 0)
        lighting.Brightness = 1
    end
end)

-- Categoria: Movimento
local moveLabel = Instance.new("TextLabel")
moveLabel.Size = UDim2.new(0.92, 0, 0, 25)
moveLabel.Position = UDim2.new(0.04, 0, 0.62, 0)
moveLabel.BackgroundTransparency = 1
moveLabel.Text = "🏃 MOVIMENTO"
moveLabel.TextColor3 = CONFIG.AccentColor
moveLabel.Font = Enum.Font.GothamBold
moveLabel.TextSize = 15
moveLabel.TextXAlignment = Enum.TextXAlignment.Left
moveLabel.Parent = scrollFrame

-- 8. VELOCIDADE
local speedBtn, speedFrame = createPremiumButton(scrollFrame, "💨 VELOCIDADE [OFF]", 0.67, Color3.fromRGB(30, 60, 30), "💨")

speedBtn.MouseButton1Click:Connect(function()
    speedActive = not speedActive
    speedBtn.Text = speedActive and "💨 VELOCIDADE [ON]" or "💨 VELOCIDADE [OFF]"
    speedFrame.BackgroundColor3 = speedActive and Color3.fromRGB(30, 60, 40) or Color3.fromRGB(30, 60, 30)
    
    local char = LocalPlayer.Character
    if char and char:FindFirstChild("Humanoid") then
        if speedActive then
            char.Humanoid.WalkSpeed = currentSpeed
        else
            char.Humanoid.WalkSpeed = originalSpeed
        end
    end
end)

-- 9. SUPER JUMP
local jumpBtn, jumpFrame = createPremiumButton(scrollFrame, "⚡ SUPER JUMP [OFF]", 0.74, Color3.fromRGB(60, 30, 60), "⚡")

jumpBtn.MouseButton1Click:Connect(function()
    jumpActive = not jumpActive
    jumpBtn.Text = jumpActive and "⚡ SUPER JUMP [ON]" or "⚡ SUPER JUMP [OFF]"
    jumpFrame.BackgroundColor3 = jumpActive and Color3.fromRGB(30, 60, 40) or Color3.fromRGB(60, 30, 60)
    
    local char = LocalPlayer.Character
    if char and char:FindFirstChild("Humanoid") then
        char.Humanoid.JumpPower = jumpActive and 200 or 50
    end
end)

-- 10. FLY (VOAR) COM JOYSTICK
local flyBtn, flyFrame = createPremiumButton(scrollFrame, "🌊 FLY [OFF]", 0.81, Color3.fromRGB(30, 60, 60), "🌊")

flyBtn.MouseButton1Click:Connect(function()
    flyActive = not flyActive
    flyBtn.Text = flyActive and "🌊 FLY [ON]" or "🌊 FLY [OFF]"
    flyFrame.BackgroundColor3 = flyActive and Color3.fromRGB(30, 60, 40) or Color3.fromRGB(30, 60, 60)
    
    local char = LocalPlayer.Character
    if not char then return end
    local humanoid = char:FindFirstChild("Humanoid")
    if not humanoid then return end
    
    if flyActive then
        humanoid.PlatformStand = true
        criarJoystickVoo()
        
        flyConnection = RunService.Heartbeat:Connect(function()
            if not flyActive then return end
            local hrp = char:FindFirstChild("HumanoidRootPart")
            if not hrp then return end
            
            local moveDirection = Vector3.new()
            local camera = Workspace.CurrentCamera
            
            -- Movimento do joystick
            if joystickActive then
                local dir = joystickDirection
                local lookVector = camera.CFrame.LookVector * Vector3.new(1, 0, 1)
                local rightVector = camera.CFrame.RightVector * Vector3.new(1, 0, 1)
                
                moveDirection = moveDirection + (lookVector * -dir.Y + rightVector * dir.X) * CONFIG.FlySpeed
            end
            
            -- Teclas virtuais (para teste)
            if UserInputService:IsKeyDown(Enum.KeyCode.W) then
                moveDirection = moveDirection + camera.CFrame.LookVector * Vector3.new(1, 0, 1) * CONFIG.FlySpeed
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.S) then
                moveDirection = moveDirection - camera.CFrame.LookVector * Vector3.new(1, 0, 1) * CONFIG.FlySpeed
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.A) then
                moveDirection = moveDirection - camera.CFrame.RightVector * Vector3.new(1, 0, 1) * CONFIG.FlySpeed
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.D) then
                moveDirection = moveDirection + camera.CFrame.RightVector * Vector3.new(1, 0, 1) * CONFIG.FlySpeed
            end
            
            if moveDirection.Magnitude > 0 then
                moveDirection = moveDirection.Unit * CONFIG.FlySpeed * 1.5
                hrp.Velocity = moveDirection
            else
                hrp.Velocity = Vector3.new(0, 0, 0)
            end
        end)
    else
        humanoid.PlatformStand = false
        if flyConnection then
            flyConnection:Disconnect()
            flyConnection = nil
        end
        destruirJoystick()
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if hrp then
            hrp.Velocity = Vector3.new(0, 0, 0)
        end
    end
end)

-- 11. NO CLIP
local noClipBtn, noClipFrame = createPremiumButton(scrollFrame, "🧱 NO CLIP [OFF]", 0.88, Color3.fromRGB(60, 30, 30), "🧱")

noClipBtn.MouseButton1Click:Connect(function()
    noClipActive = not noClipActive
    noClipBtn.Text = noClipActive and "🧱 NO CLIP [ON]" or "🧱 NO CLIP [OFF]"
    noClipFrame.BackgroundColor3 = noClipActive and Color3.fromRGB(30, 60, 40) or Color3.fromRGB(60, 30, 30)
    
    if noClipActive then
        noClipConnection = RunService.Heartbeat:Connect(function()
            if not noClipActive then return end
            local char = LocalPlayer.Character
            if char then
                for _, part in pairs(char:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            end
        end)
    else
        if noClipConnection then
            noClipConnection:Disconnect()
            noClipConnection = nil
        end
        local char = LocalPlayer.Character
        if char then
            for _, part in pairs(char:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = true
                end
            end
        end
    end
end)

-- Categoria: Poderes
local powerLabel = Instance.new("TextLabel")
powerLabel.Size = UDim2.new(0.92, 0, 0, 25)
powerLabel.Position = UDim2.new(0.04, 0, 0.96, 0)
powerLabel.BackgroundTransparency = 1
powerLabel.Text = "💥 PODERES"
powerLabel.TextColor3 = CONFIG.AccentColor
powerLabel.Font = Enum.Font.GothamBold
powerLabel.TextSize = 15
powerLabel.TextXAlignment = Enum.TextXAlignment.Left
powerLabel.Parent = scrollFrame

-- 12. GOD MODE
local godBtn, godFrame = createPremiumButton(scrollFrame, "🛡️ GOD MODE [OFF]", 1.01, Color3.fromRGB(30, 30, 60), "🛡️")

godBtn.MouseButton1Click:Connect(function()
    godModeActive = not godModeActive
    godBtn.Text = godModeActive and "🛡️ GOD MODE [ON]" or "🛡️ GOD MODE [OFF]"
    godFrame.BackgroundColor3 = godModeActive and Color3.fromRGB(30, 60, 40) or Color3.fromRGB(30, 30, 60)
    
    local char = LocalPlayer.Character
    if char then
        local humanoid = char:FindFirstChild("Humanoid")
        if humanoid then
            if godModeActive then
                humanoid.MaxHealth = math.huge
                humanoid.Health = math.huge
                humanoid.BreakJointsOnDeath = false
            else
                humanoid.MaxHealth = 100
                humanoid.Health = 100
                humanoid.BreakJointsOnDeath = true
            end
        end
    end
end)

-- 13. ANTI-KICK
local antiKickBtn, antiKickFrame = createPremiumButton(scrollFrame, "🛡️ ANTI-KICK [OFF]", 1.08, Color3.fromRGB(60, 30, 60), "🛡️")

antiKickBtn.MouseButton1Click:Connect(function()
    antiKickActive = not antiKickActive
    antiKickBtn.Text = antiKickActive and "🛡️ ANTI-KICK [ON]" or "🛡️ ANTI-KICK [OFF]"
    antiKickFrame.BackgroundColor3 = antiKickActive and Color3.fromRGB(30, 60, 40) or Color3.fromRGB(60, 30, 60)
    
    if antiKickActive then
        print("🛡️ ANTI-KICK ATIVADO!")
        
        LocalPlayer:GetPropertyChangedSignal("Parent"):Connect(function()
            if antiKickActive and LocalPlayer.Parent == nil then
                wait(0.1)
                LocalPlayer.Parent = Players
                print("🛡️ ANTI-KICK: Tentativa de kick bloqueada!")
            end
        end)
        
        antiKickConnection = RunService.Heartbeat:Connect(function()
            if antiKickActive then
                for _, gui in pairs(CoreGui:GetChildren()) do
                    if gui:IsA("ScreenGui") and (gui.Name:lower():find("kick") or gui.Name:lower():find("ban")) then
                        gui:Destroy()
                    end
                end
            end
        end)
    else
        if antiKickConnection then
            antiKickConnection:Disconnect()
            antiKickConnection = nil
        end
    end
end)

-- 14. FREEZE PLAYERS
local freezeBtn, freezeFrame = createPremiumButton(scrollFrame, "🌀 FREEZE PLAYERS [OFF]", 1.15, Color3.fromRGB(30, 60, 60), "🌀")

freezeBtn.MouseButton1Click:Connect(function()
    freezeActive = not freezeActive
    freezeBtn.Text = freezeActive and "🌀 FREEZE PLAYERS [ON]" or "🌀 FREEZE PLAYERS [OFF]"
    freezeFrame.BackgroundColor3 = freezeActive and Color3.fromRGB(30, 60, 40) or Color3.fromRGB(30, 60, 60)
    
    if freezeActive then
        RunService.Heartbeat:Connect(function()
            if not freezeActive then return end
            for _, player in pairs(Players:GetPlayers()) do
                if player ~= LocalPlayer then
                    local char = player.Character
                    if char and char:FindFirstChild("HumanoidRootPart") then
                        char.HumanoidRootPart.Velocity = Vector3.new(0, 0, 0)
                    end
                end
            end
        end)
    end
end)

-- 15. EXPLODE PLAYERS
local explodeBtn, explodeFrame = createPremiumButton(scrollFrame, "💣 EXPLODE PLAYERS", 1.22, Color3.fromRGB(60, 30, 30), "💣")

explodeBtn.MouseButton1Click:Connect(function()
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            local char = player.Character
            if char and char:FindFirstChild("HumanoidRootPart") then
                local explosion = Instance.new("Explosion")
                explosion.Position = char.HumanoidRootPart.Position
                explosion.BlastRadius = 15
                explosion.BlastPressure = 2000
                explosion.Parent = Workspace
                
                local humanoid = char:FindFirstChild("Humanoid")
                if humanoid then
                    humanoid.Health = 0
                end
            end
        end
    end
end)

-- 16. TELEPORT TO PLAYER
local teleportBtn, teleportFrame = createPremiumButton(scrollFrame, "📌 TELEPORT TO PLAYER", 1.29, Color3.fromRGB(30, 30, 60), "📌")

teleportBtn.MouseButton1Click:Connect(function()
    local players = {}
    for i, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            table.insert(players, player.Name)
        end
    end
    
    if #players == 0 then
        print("❌ Nenhum jogador disponível!")
        return
    end
    
    -- Menu de seleção mobile premium
    local selectFrame = Instance.new("Frame")
    selectFrame.Size = UDim2.new(0, 280, 0, 350)
    selectFrame.Position = UDim2.new(0.5, -140, 0.5, -175)
    selectFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 30)
    selectFrame.BackgroundTransparency = 0.1
    selectFrame.BorderSizePixel = 0
    selectFrame.Parent = screenGui
    selectFrame.ZIndex = 200
    
    local selectCorner = Instance.new("UICorner")
    selectCorner.CornerRadius = UDim.new(0, 16)
    selectCorner.Parent = selectFrame
    
    local selectTitle = Instance.new("TextLabel")
    selectTitle.Size = UDim2.new(1, 0, 0, 45)
    selectTitle.BackgroundColor3 = Color3.fromRGB(30, 30, 50)
    selectTitle.BackgroundTransparency = 0.2
    selectTitle.Text = "👆 Selecione o Jogador"
    selectTitle.TextColor3 = CONFIG.AccentColor
    selectTitle.Font = Enum.Font.GothamBold
    selectTitle.TextSize = 16
    selectTitle.Parent = selectFrame
    
    local selectList = Instance.new("ScrollingFrame")
    selectList.Size = UDim2.new(1, 0, 1, -45)
    selectList.Position = UDim2.new(0, 0, 0, 45)
    selectList.BackgroundTransparency = 1
    selectList.BorderSizePixel = 0
    selectList.Parent = selectFrame
    selectList.CanvasSize = UDim2.new(0, 0, 0, #players * 55)
    selectList.ScrollBarThickness = 3
    
    for i, name in pairs(players) do
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(0.9, 0, 0, 48)
        btn.Position = UDim2.new(0.05, 0, 0, (i-1) * 55)
        btn.BackgroundColor3 = Color3.fromRGB(50, 50, 80)
        btn.BackgroundTransparency = 0.2
        btn.Text = name
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        btn.Font = Enum.Font.GothamSemibold
        btn.TextSize = 16
        btn.BorderSizePixel = 0
        btn.Parent = selectList
        
        local btnCorner = Instance.new("UICorner")
        btnCorner.CornerRadius = UDim.new(0, 10)
        btnCorner.Parent = btn
        
        btn.MouseButton1Click:Connect(function()
            for _, player in pairs(Players:GetPlayers()) do
                if player.Name == name then
                    local targetChar = player.Character
                    if targetChar and targetChar:FindFirstChild("HumanoidRootPart") then
                        local char = LocalPlayer.Character
                        if char and char:FindFirstChild("HumanoidRootPart") then
                            char.HumanoidRootPart.CFrame = targetChar.HumanoidRootPart.CFrame * CFrame.new(0, 0, 3)
                            print("✅ Teleportado até: " .. name)
                        end
                    end
                end
            end
            selectFrame:Destroy()
        end)
    end
    
    local closeSelect = Instance.new("TextButton")
    closeSelect.Size = UDim2.new(0, 35, 0, 35)
    closeSelect.Position = UDim2.new(1, -42, 0, 5)
    closeSelect.BackgroundColor3 = Color3.fromRGB(200, 30, 30)
    closeSelect.BackgroundTransparency = 0.1
    closeSelect.Text = "✕"
    closeSelect.TextColor3 = Color3.fromRGB(255, 255, 255)
    closeSelect.Font = Enum.Font.GothamBold
    closeSelect.TextSize = 18
    closeSelect.BorderSizePixel = 0
    closeSelect.Parent = selectFrame
    
    local closeCorner2 = Instance.new("UICorner")
    closeCorner2.CornerRadius = UDim.new(1, 0)
    closeCorner2.Parent = closeSelect
    
    closeSelect.MouseButton1Click:Connect(function()
        selectFrame:Destroy()
    end)
end)

-- ========== SLIDER DE VELOCIDADE PREMIUM ==========
local sliderFrame = Instance.new("Frame")
sliderFrame.Size = UDim2.new(0.92, 0, 0, 50)
sliderFrame.Position = UDim2.new(0.04, 0, 1.37, 0)
sliderFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 70)
sliderFrame.BackgroundTransparency = 0.15
sliderFrame.BorderSizePixel = 0
sliderFrame.Parent = scrollFrame

local sliderCorner = Instance.new("UICorner")
sliderCorner.CornerRadius = UDim.new(0, 10)
sliderCorner.Parent = sliderFrame

local speedLabel = Instance.new("TextLabel")
speedLabel.Size = UDim2.new(0.5, 0, 1, 0)
speedLabel.BackgroundTransparency = 1
speedLabel.Text = "⚡ Velocidade: 70"
speedLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
speedLabel.Font = Enum.Font.Gotham
speedLabel.TextSize = 14
speedLabel.TextXAlignment = Enum.TextXAlignment.Left
speedLabel.Parent = sliderFrame

local speedSlider = Instance.new("TextButton")
speedSlider.Size = UDim2.new(0.35, 0, 1, 0)
speedSlider.Position = UDim2.new(0.63, 0, 0, 0)
speedSlider.BackgroundColor3 = Color3.fromRGB(80, 80, 130)
speedSlider.BackgroundTransparency = 0.2
speedSlider.Text = "70"
speedSlider.TextColor3 = Color3.fromRGB(255, 255, 255)
speedSlider.Font = Enum.Font.GothamBold
speedSlider.TextSize = 16
speedSlider.BorderSizePixel = 0
speedSlider.Parent = sliderFrame

local sliderCorner2 = Instance.new("UICorner")
sliderCorner2.CornerRadius = UDim.new(0, 8)
sliderCorner2.Parent = speedSlider

speedSlider.MouseButton1Click:Connect(function()
    local speeds = {50, 70, 90, 120, 150, 200, 300, 500}
    local idx = 0
    for i, v in pairs(speeds) do
        if v == currentSpeed then idx = i break end
    end
    idx = idx % #speeds + 1
    currentSpeed = speeds[idx]
    speedSlider.Text = tostring(currentSpeed)
    speedLabel.Text = "⚡ Velocidade: " .. currentSpeed
    
    if speedActive then
        local char = LocalPlayer.Character
        if char and char:FindFirstChild("Humanoid") then
            char.Humanoid.WalkSpeed = currentSpeed
        end
    end
end)

-- ========== SLIDER DE SENSIBILIDADE ==========
local sensFrame = Instance.new("Frame")
sensFrame.Size = UDim2.new(0.92, 0, 0, 50)
sensFrame.Position = UDim2.new(0.04, 0, 1.47, 0)
sensFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 70)
sensFrame.BackgroundTransparency = 0.15
sensFrame.BorderSizePixel = 0
sensFrame.Parent = scrollFrame

local sensCorner = Instance.new("UICorner")
sensCorner.CornerRadius = UDim.new(0, 10)
sensCorner.Parent = sensFrame

local sensLabel = Instance.new("TextLabel")
sensLabel.Size = UDim2.new(0.5, 0, 1, 0)
sensLabel.BackgroundTransparency = 1
sensLabel.Text = "🎮 Sensibilidade: 1.0x"
sensLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
sensLabel.Font = Enum.Font.Gotham
sensLabel.TextSize = 14
sensLabel.TextXAlignment = Enum.TextXAlignment.Left
sensLabel.Parent = sensFrame

local sensSlider = Instance.new("TextButton")
sensSlider.Size = UDim2.new(0.35, 0, 1, 0)
sensSlider.Position = UDim2.new(0.63, 0, 0, 0)
sensSlider.BackgroundColor3 = Color3.fromRGB(80, 80, 130)
sensSlider.BackgroundTransparency = 0.2
sensSlider.Text = "1.0"
sensSlider.TextColor3 = Color3.fromRGB(255, 255, 255)
sensSlider.Font = Enum.Font.GothamBold
sensSlider.TextSize = 16
sensSlider.BorderSizePixel = 0
sensSlider.Parent = sensFrame

local sensCorner2 = Instance.new("UICorner")
sensCorner2.CornerRadius = UDim.new(0, 8)
sensCorner2.Parent = sensSlider

sensSlider.MouseButton1Click:Connect(function()
    local sensitivities = {0.5, 0.7, 1.0, 1.3, 1.5, 2.0}
    local idx = 0
    for i, v in pairs(sensitivities) do
        if v == CONFIG.Sensitivity then idx = i break end
    end
    idx = idx % #sensitivities + 1
    CONFIG.Sensitivity = sensitivities[idx]
    sensSlider.Text = tostring(CONFIG.Sensitivity)
    sensLabel.Text = "🎮 Sensibilidade: " .. CONFIG.Sensitivity .. "x"
end)

-- ========== FUNÇÕES DO JOYSTICK DE VOO ==========
local joystickGui = nil
local joystickBase = nil
local joystickKnob = nil

function criarJoystickVoo()
    -- Destruir joystick antigo se existir
    destruirJoystick()
    
    joystickGui = Instance.new("Frame")
    joystickGui.Size = UDim2.new(0, 140, 0, 140)
    joystickGui.Position = UDim2.new(0.05, 0, 0.5, -70)
    joystickGui.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    joystickGui.BackgroundTransparency = 0.85
    joystickGui.BorderSizePixel = 0
    joystickGui.Parent = screenGui
    joystickGui.ZIndex = 500
    joystickGui.Visible = flyActive
    
    local joystickCorner = Instance.new("UICorner")
    joystickCorner.CornerRadius = UDim.new(1, 0)
    joystickCorner.Parent = joystickGui
    
    -- Base do joystick
    joystickBase = Instance.new("Frame")
    joystickBase.Size = UDim2.new(0.8, 0, 0.8, 0)
    joystickBase.Position = UDim2.new(0.1, 0, 0.1, 0)
    joystickBase.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    joystickBase.BackgroundTransparency = 0.9
    joystickBase.BorderSizePixel = 2
    joystickBase.BorderColor3 = CONFIG.AccentColor
    joystickBase.Parent = joystickGui
    
    local baseCorner = Instance.new("UICorner")
    baseCorner.CornerRadius = UDim.new(1, 0)
    baseCorner.Parent = joystickBase
    
    -- Botão do joystick (knob)
    joystickKnob = Instance.new("Frame")
    joystickKnob.Size = UDim2.new(0.3, 0, 0.3, 0)
    joystickKnob.Position = UDim2.new(0.35, 0, 0.35, 0)
    joystickKnob.BackgroundColor3 = CONFIG.AccentColor
    joystickKnob.BackgroundTransparency = 0.2
    joystickKnob.BorderSizePixel = 0
    joystickKnob.Parent = joystickBase
    
    local knobCorner = Instance.new("UICorner")
    knobCorner.CornerRadius = UDim.new(1, 0)
    knobCorner.Parent = joystickKnob
    
    -- Texto do joystick
    local joystickText = Instance.new("TextLabel")
    joystickText.Size = UDim2.new(1, 0, 0.2, 0)
    joystickText.Position = UDim2.new(0, 0, 1, 5)
    joystickText.BackgroundTransparency = 1
    joystickText.Text = "🕹️ VOO"
    joystickText.TextColor3 = CONFIG.AccentColor
    joystickText.Font = Enum.Font.GothamBold
    joystickText.TextSize = 12
    joystickText.Parent = joystickGui
    
    -- Eventos de toque do joystick
    joystickGui.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch then
            joystickActive = true
            atualizarJoystick(input)
        end
    end)
    
    joystickGui.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch then
            joystickActive = false
            joystickDirection = Vector2.new(0, 0)
            joystickKnob.Position = UDim2.new(0.35, 0, 0.35, 0)
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if joystickActive and input.UserInputType == Enum.UserInputType.Touch then
            atualizarJoystick(input)
        end
    end)
end

function atualizarJoystick(input)
    local basePos = joystickBase.AbsolutePosition
    local baseSize = joystickBase.AbsoluteSize
    local center = basePos + baseSize / 2
    
    local touchPos = input.Position
    local delta = touchPos - center
    local maxRadius = baseSize.X / 2.5
    
    local distance = delta.Magnitude
    if distance > maxRadius then
        delta = delta.Unit * maxRadius
        distance = maxRadius
    end
    
    -- Atualizar posição do knob
    local knobSize = joystickKnob.AbsoluteSize
    local knobPos = delta / baseSize
    joystickKnob.Position = UDim2.new(0.5 + knobPos.X - 0.15, 0, 0.5 + knobPos.Y - 0.15, 0)
    
    -- Direção normalizada
    local normalized = delta / maxRadius
    joystickDirection = Vector2.new(normalized.X, -normalized.Y)
end

function destruirJoystick()
    if joystickGui then
        joystickGui:Destroy()
        joystickGui = nil
        joystickBase = nil
        joystickKnob = nil
    end
    joystickActive = false
    joystickDirection = Vector2.new(0, 0)
end

-- ========== ARRASTAR MENU MOBILE ==========
local dragging = false
local dragStart, startPos

mainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = mainFrame.Position
    end
end)

mainFrame.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.Touch then
        local delta = input.Position - dragStart
        mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

-- ========== ABRIR/FECHAR MENU ==========
local menuOpen = false

floatBtn.MouseButton1Click:Connect(function()
    menuOpen = not menuOpen
    mainFrame.Visible = menuOpen
    floatBtn.Visible = not menuOpen
    floatBtn.Text = menuOpen and "🔒" or "🔥"
    
    -- Animar o botão
    TweenService:Create(floatBtn, TweenInfo.new(0.2), {Size = UDim2.new(0, 60, 0, 60)}):Play()
    wait(0.2)
    TweenService:Create(floatBtn, TweenInfo.new(0.2), {Size = UDim2.new(0, 55, 0, 55)}):Play()
end)

-- Fechar menu quando tocar fora
mainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch then
        local pos = input.Position
        local framePos = mainFrame.AbsolutePosition
        local frameSize = mainFrame.AbsoluteSize
        
        if pos.X < framePos.X or pos.X > framePos.X + frameSize.X or
           pos.Y < framePos.Y or pos.Y > framePos.Y + frameSize.Y then
            mainFrame.Visible = false
            floatBtn.Visible = true
        end
    end
end)

-- ========== STATUS BAR ==========
local statusBar = Instance.new("Frame")
statusBar.Size = UDim2.new(0.3, 0, 0, 25)
statusBar.Position = UDim2.new(0.35, 0, 0.01, 0)
statusBar.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
statusBar.BackgroundTransparency = 0.5
statusBar.BorderSizePixel = 0
statusBar.Parent = screenGui
statusBar.ZIndex = 998

local statusCorner = Instance.new("UICorner")
statusCorner.CornerRadius = UDim.new(0, 8)
statusCorner.Parent = statusBar

local statusText = Instance.new("TextLabel")
statusText.Size = UDim2.new(1, 0, 1, 0)
statusText.BackgroundTransparency = 1
statusText.Text = "🔥 HACK ATIVO"
statusText.TextColor3 = Color3.fromRGB(0, 255, 100)
statusText.Font = Enum.Font.GothamBold
statusText.TextSize = 12
statusText.Parent = statusBar

-- Atualizar status quando funções mudam
local function updateStatus()
    local active = ""
    if aimbotActive then active = active .. "🎯 " end
    if espActive then active = active .. "📦 " end
    if flyActive then active = active .. "🌊 " end
    if godModeActive then active = active .. "🛡️ " end
    
    if active == "" then
        statusText.Text = "⏸️ HACK INATIVO"
        statusText.TextColor3 = Color3.fromRGB(255, 200, 50)
    else
        statusText.Text = "🔥 " .. active
        statusText.TextColor3 = Color3.fromRGB(0, 255, 100)
    end
end

-- Monitorar mudanças
local function monitorStatus()
    while wait(0.5) do
        updateStatus()
    end
end
coroutine.wrap(monitorStatus)()

-- ========== INSTRUÇÕES ==========
print("========================================")
print("📱 PAINEL MOBILE ULTRA CARREGADO!")
print("========================================")
print("🔥 Clique no 🔥 para abrir o menu")
print("🕹️ Joystick de voo no canto inferior")
print("⚡ Controle deslizante de velocidade")
print("🎮 Sensibilidade ajustável")
print("========================================")
print("✅ DIVIRTA-SE!")
