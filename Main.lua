-- ============================================================
-- 🚀 ULTRA SCRIPT PROFISSIONAL V6.0 - MODO TI SENIOR 🚀
-- ⚡ Aimbot Headshot + FOV Círculo + ESP Tracer + Health Bar
-- 🔒 Blindado contra erros e travamentos (Otimizado para FPS)
-- ============================================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local LocalPlayer = Players.LocalPlayer
local Workspace = game:GetService("Workspace")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local Camera = Workspace.CurrentCamera

-- ============================================================
-- 🔒 SISTEMA ANTI-ERRO (BLINDAGEM TOTAL)
-- ============================================================
local function SafeCall(func, ...)
    local success, result = pcall(func, ...)
    return success, result
end

-- ============================================================
-- 🎨 CONFIGURAÇÃO DE CORES (MODO ESCURO PREMIUM)
-- ============================================================
local COLORS = {
    Background = Color3.fromRGB(8, 10, 20),
    Card = Color3.fromRGB(20, 25, 35),
    CardHover = Color3.fromRGB(30, 38, 50),
    Primary = Color3.fromRGB(0, 170, 255),
    PrimaryLight = Color3.fromRGB(80, 200, 255),
    Success = Color3.fromRGB(0, 255, 100),
    Danger = Color3.fromRGB(255, 50, 50),
    TextWhite = Color3.fromRGB(255, 255, 255),
    TextGray = Color3.fromRGB(190, 195, 210),
    Combat = Color3.fromRGB(120, 30, 30),
    Visual = Color3.fromRGB(20, 80, 120),
    Movement = Color3.fromRGB(20, 90, 60),
    Power = Color3.fromRGB(110, 50, 120),
    Weapon = Color3.fromRGB(120, 80, 30),
}

-- ============================================================
-- 🎯 CONFIGURAÇÕES DAS FUNÇÕES
-- ============================================================
local config = {
    AimbotRange = 250,       -- Alcance máximo do aimbot
    AimbotFOV = 120,         -- Tamanho inicial do círculo FOV
    AimbotSpeed = 1.5,       -- Velocidade da mira (Quanto menor, mais rápido)
    HeadshotOnly = true,     -- Sempre mirar na cabeça
    HealthColor = Color3.fromRGB(0, 255, 0),
}

-- Variáveis de estado
local aimbotActive = false
local espActive = false
local espObjects = {}
local flyActive = false
local godModeActive = false
local speedActive = false
local noClipActive = false
local antiKickActive = false
local infiniteAmmoActive = false
local currentSpeed = 100
local flySpeed = 80

-- Conexões
local aimbotConnection, flyConnection, noClipConnection = nil, nil, nil
local antiKickConnection, speedConnection, godModeConnection = nil, nil, nil

-- ============================================================
-- 🛡️ SISTEMA DE RENASCIMENTO AUTOMÁTICO
-- ============================================================
local function ApplyCharacterSettings()
    SafeCall(function()
        local char = LocalPlayer.Character
        if not char then return end
        local humanoid = char:FindFirstChild("Humanoid")
        if not humanoid then return end

        if speedActive then humanoid.WalkSpeed = currentSpeed end
        if jumpActive then humanoid.JumpPower = 200 end
        if godModeActive then
            humanoid.MaxHealth = math.huge
            humanoid.Health = math.huge
            humanoid.BreakJointsOnDeath = false
        end
    end)
end

LocalPlayer.CharacterAdded:Connect(function()
    task.wait(0.5)
    ApplyCharacterSettings()
    if flyActive then StartFly() end
    if noClipActive then StartNoClip() end
end)

-- ============================================================
-- 🔴 CÍRCULO DE FOV (MIRA AJUSTÁVEL)
-- ============================================================
local fovCircle = Instance.new("Frame")
fovCircle.Size = UDim2.new(0, config.AimbotFOV * 2, 0, config.AimbotFOV * 2)
fovCircle.Position = UDim2.new(0.5, -config.AimbotFOV, 0.5, -config.AimbotFOV)
fovCircle.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
fovCircle.BackgroundTransparency = 0.7
fovCircle.BorderSizePixel = 2
fovCircle.BorderColor3 = Color3.fromRGB(255, 0, 0)
fovCircle.Parent = LocalPlayer:WaitForChild("PlayerGui")
fovCircle.Visible = true
fovCircle.ZIndex = 999

local fovCorner = Instance.new("UICorner")
fovCorner.CornerRadius = UDim.new(1, 0)
fovCorner.Parent = fovCircle

-- ============================================================
-- 🛰️ ESP PROFISSIONAL (TRACER LINE + HEALTH BAR)
-- ============================================================
local function UpdateESP()
    if not espActive then return end
    
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local char = player.Character
            local hrp = char:FindFirstChild("HumanoidRootPart")
            local humanoid = char:FindFirstChild("Humanoid")
            if hrp and humanoid then
                if not espObjects[player] then
                    local espObj = {}
                    
                    -- Linha Tracer
                    local line = Instance.new("Frame")
                    line.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
                    line.BorderSizePixel = 0
                    line.Size = UDim2.new(0, 2, 0, 2)
                    line.Parent = LocalPlayer:WaitForChild("PlayerGui")
                    espObj.line = line
                    
                    -- Barra de Vida
                    local healthBar = Instance.new("Frame")
                    healthBar.Size = UDim2.new(0, 4, 0, 40)
                    healthBar.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
                    healthBar.BorderSizePixel = 0
                    healthBar.Parent = LocalPlayer:WaitForChild("PlayerGui")
                    espObj.healthBar = healthBar
                    
                    -- Texto com Nome e HP
                    local nameLabel = Instance.new("TextLabel")
                    nameLabel.Size = UDim2.new(0, 100, 0, 20)
                    nameLabel.BackgroundTransparency = 1
                    nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                    nameLabel.Font = Enum.Font.GothamBold
                    nameLabel.TextSize = 12
                    nameLabel.TextStrokeTransparency = 0.5
                    nameLabel.Parent = LocalPlayer:WaitForChild("PlayerGui")
                    espObj.nameLabel = nameLabel
                    
                    espObjects[player] = espObj
                end
                
                local esp = espObjects[player]
                local hp = math.clamp(humanoid.Health / humanoid.MaxHealth, 0, 1)
                
                -- Atualizar Barra de Vida
                esp.healthBar.Size = UDim2.new(0, 4, 0, 40 * hp)
                esp.healthBar.Position = UDim2.new(0.5, -2, 0.3, -20 * hp)
                esp.healthBar.BackgroundColor3 = config.HealthColor
                
                -- Atualizar Linha Tracer
                local screenPos, onScreen = Camera:WorldToViewportPoint(hrp.Position)
                if onScreen then
                    esp.line.Visible = true
                    esp.healthBar.Visible = true
                    esp.nameLabel.Visible = true
                    
                    -- Posição da linha
                    local screenCenter = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y)
                    local targetPos = Vector2.new(screenPos.X, screenPos.Y)
                    esp.line.Position = UDim2.new(0, screenCenter.X, 0, screenCenter.Y)
                    esp.line.Size = UDim2.new(0, targetPos.X - screenCenter.X, 0, targetPos.Y - screenCenter.Y)
                    esp.line.Rotation = math.deg(math.atan2(targetPos.Y - screenCenter.Y, targetPos.X - screenCenter.X))
                    
                    -- Nome e vida
                    esp.nameLabel.Position = UDim2.new(0, screenPos.X + 10, 0, screenPos.Y - 20)
                    esp.nameLabel.Text = player.Name .. " | " .. math.floor(humanoid.Health) .. " HP"
                else
                    esp.line.Visible = false
                    esp.healthBar.Visible = false
                    esp.nameLabel.Visible = false
                end
            end
        end
    end
end

-- Loop do ESP (Otimizado com Heartbeat)
RunService.Heartbeat:Connect(UpdateESP)

-- ============================================================
-- 🎯 AIMBOT HEADSHOT ULTRA RÁPIDO + FOV
-- ============================================================
local function StartAimbot()
    if aimbotConnection then aimbotConnection:Disconnect() end
    aimbotConnection = RunService.RenderStepped:Connect(function()
        if not aimbotActive then return end
        
        local char = LocalPlayer.Character
        if not char or not char:FindFirstChild("HumanoidRootPart") then return end
        local mouse = LocalPlayer:GetMouse()
        local hrp = char:FindFirstChild("HumanoidRootPart")
        
        local closestPlayer, closestDist = nil, config.AimbotFOV
        
        -- Encontrar inimigo mais próximo do centro da tela (dentro do FOV)
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character then
                local targetHrp = player.Character:FindFirstChild("HumanoidRootPart")
                local humanoid = player.Character:FindFirstChild("Humanoid")
                if targetHrp and humanoid and humanoid.Health > 0 then
                    local screenPos, onScreen = Camera:WorldToViewportPoint(targetHrp.Position)
                    if onScreen then
                        local dist = (Vector2.new(screenPos.X, screenPos.Y) - Vector2.new(mouse.X, mouse.Y)).Magnitude
                        if dist < closestDist then
                            closestDist = dist
                            closestPlayer = player
                        end
                    end
                end
            end
        end
        
        if closestPlayer then
            local targetHead = closestPlayer.Character:FindFirstChild("Head")
            if targetHead then
                -- Movimento Instantâneo para a Cabeça
                local lookAt = CFrame.new(hrp.Position, targetHead.Position)
                hrp.CFrame = lookAt
                
                -- "Matar" instantaneamente se desejar (Headshot Kill)
                if config.HeadshotOnly then
                    SafeCall(function()
                        closestPlayer.Character.Humanoid.Health = 0
                    end)
                end
            end
        end
    end)
end

-- ============================================================
-- 🛠️ OUTRAS FUNÇÕES PROTEGIDAS
-- ============================================================
local function StartFly()
    if flyConnection then flyConnection:Disconnect() end
    flyConnection = RunService.RenderStepped:Connect(function()
        if not flyActive then return end
        local char = LocalPlayer.Character
        if not char then return end
        local hrp = char:FindFirstChild("HumanoidRootPart")
        local humanoid = char:FindFirstChild("Humanoid")
        if not hrp or not humanoid then return end
        
        humanoid.PlatformStand = true
        local moveDir = Vector3.new()
        local cam = Workspace.CurrentCamera
        
        if UserInputService:IsKeyDown(Enum.KeyCode.W) then moveDir += cam.CFrame.LookVector * Vector3.new(1,0,1) end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then moveDir -= cam.CFrame.LookVector * Vector3.new(1,0,1) end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then moveDir -= cam.CFrame.RightVector * Vector3.new(1,0,1) end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then moveDir += cam.CFrame.RightVector * Vector3.new(1,0,1) end
        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then moveDir += Vector3.new(0,1,0) end
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then moveDir -= Vector3.new(0,1,0) end
        
        hrp.Velocity = moveDir.Magnitude > 0 and moveDir.Unit * flySpeed or Vector3.new(0,0,0)
    end)
end

local function StartNoClip()
    if noClipConnection then noClipConnection:Disconnect() end
    noClipConnection = RunService.RenderStepped:Connect(function()
        if not noClipActive then return end
        local char = LocalPlayer.Character
        if char then
            for _, part in pairs(char:GetDescendants()) do
                if part:IsA("BasePart") then part.CanCollide = false end
            end
        end
    end)
end

-- ============================================================
-- 🎨 CONSTRUÇÃO DA INTERFACE PREMIUM
-- ============================================================
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "UltraPremiumHack"
screenGui.Parent = CoreGui
screenGui.ResetOnSpawn = false

-- Botão Flutuante
local floatBtn = Instance.new("TextButton")
floatBtn.Size = UDim2.new(0, 50, 0, 50)
floatBtn.Position = UDim2.new(0.85, 0, 0.03, 0)
floatBtn.BackgroundColor3 = COLORS.Primary
floatBtn.Text = "⚡"
floatBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
floatBtn.Font = Enum.Font.GothamBold
floatBtn.TextSize = 25
floatBtn.Parent = screenGui

local floatCorner = Instance.new("UICorner")
floatCorner.CornerRadius = UDim.new(1, 0)
floatCorner.Parent = floatBtn

-- Menu Principal
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 380, 0, 550)
mainFrame.Position = UDim2.new(0.5, -190, 0.5, -275)
mainFrame.BackgroundColor3 = COLORS.Background
mainFrame.BackgroundTransparency = 0.05
mainFrame.BorderSizePixel = 1
mainFrame.BorderColor3 = COLORS.PrimaryLight
mainFrame.ClipsDescendants = true
mainFrame.Parent = screenGui
mainFrame.Visible = false

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 15)
mainCorner.Parent = mainFrame

-- Header
local header = Instance.new("Frame")
header.Size = UDim2.new(1, 0, 0, 60)
header.BackgroundColor3 = COLORS.Card
header.Parent = mainFrame

local headerCorner = Instance.new("UICorner")
headerCorner.CornerRadius = UDim.new(0, 15)
headerCorner.Parent = header

local title = Instance.new("TextLabel")
title.Size = UDim2.new(0.8, 0, 0.5, 0)
title.Position = UDim2.new(0.05, 0, 0.1, 0)
title.BackgroundTransparency = 1
title.Text = "ULTRA PREMIUM"
title.TextColor3 = COLORS.TextWhite
title.Font = Enum.Font.GothamBold
title.TextSize = 18
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = header

local subTitle = Instance.new("TextLabel")
subTitle.Size = UDim2.new(0.8, 0, 0.3, 0)
subTitle.Position = UDim2.new(0.05, 0, 0.55, 0)
subTitle.BackgroundTransparency = 1
subTitle.Text = "Feito por: TI Programador"
subTitle.TextColor3 = COLORS.TextGray
subTitle.Font = Enum.Font.Gotham
subTitle.TextSize = 11
subTitle.TextXAlignment = Enum.TextXAlignment.Left
subTitle.Parent = header

-- Botão Fechar
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(1, -45, 0, 15)
closeBtn.BackgroundColor3 = COLORS.Danger
closeBtn.Text = "✕"
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 16
closeBtn.Parent = header

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(1, 0)
closeCorner.Parent = closeBtn
closeBtn.MouseButton1Click:Connect(toggleMenu)

-- Scroll
local scrollFrame = Instance.new("ScrollingFrame")
scrollFrame.Size = UDim2.new(1, 0, 1, -60)
scrollFrame.Position = UDim2.new(0, 0, 0, 60)
scrollFrame.BackgroundTransparency = 1
scrollFrame.Parent = mainFrame
scrollFrame.CanvasSize = UDim2.new(0, 0, 0, 1600)
scrollFrame.ScrollBarThickness = 4
scrollFrame.ScrollBarImageColor3 = COLORS.Primary

-- Função para criar botões
local function createPremiumButton(parent, text, desc, yPos, color, icon, callback)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0.94, 0, 0, 48)
    frame.Position = UDim2.new(0.03, 0, yPos, 0)
    frame.BackgroundColor3 = color
    frame.BackgroundTransparency = 0.2
    frame.BorderSizePixel = 1
    frame.BorderColor3 = Color3.fromRGB(255, 255, 255)
    frame.Parent = parent
    
    local frameCorner = Instance.new("UICorner")
    frameCorner.CornerRadius = UDim.new(0, 10)
    frameCorner.Parent = frame
    
    local iconLabel = Instance.new("TextLabel")
    iconLabel.Size = UDim2.new(0, 30, 1, 0)
    iconLabel.Position = UDim2.new(0.02, 0, 0, 0)
    iconLabel.BackgroundTransparency = 1
    iconLabel.Text = icon
    iconLabel.TextColor3 = COLORS.TextWhite
    iconLabel.Font = Enum.Font.Gotham
    iconLabel.TextSize = 18
    iconLabel.TextXAlignment = Enum.TextXAlignment.Center
    iconLabel.Parent = frame
    
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.6, 0, 1, 0)
    btn.Position = UDim2.new(0.1, 0, 0, 0)
    btn.BackgroundTransparency = 1
    btn.Text = text
    btn.TextColor3 = COLORS.TextWhite
    btn.Font = Enum.Font.GothamSemibold
    btn.TextSize = 14
    btn.TextXAlignment = Enum.TextXAlignment.Left
    btn.Parent = frame
    
    local descLabel = Instance.new("TextLabel")
    descLabel.Size = UDim2.new(0.7, 0, 0.5, 0)
    descLabel.Position = UDim2.new(0.1, 0, 0.5, 0)
    descLabel.BackgroundTransparency = 1
    descLabel.Text = desc
    descLabel.TextColor3 = COLORS.TextGray
    descLabel.Font = Enum.Font.Gotham
    descLabel.TextSize = 10
    descLabel.TextXAlignment = Enum.TextXAlignment.Left
    descLabel.Parent = frame
    
    local status = Instance.new("TextButton")
    status.Size = UDim2.new(0, 45, 0, 22)
    status.Position = UDim2.new(0.86, 0, 0.25, 0)
    status.BackgroundColor3 = COLORS.Danger
    status.Text = "OFF"
    status.TextColor3 = Color3.fromRGB(255, 255, 255)
    status.Font = Enum.Font.GothamBold
    status.TextSize = 11
    status.Parent = frame
    
    local statusCorner = Instance.new("UICorner")
    statusCorner.CornerRadius = UDim.new(1, 0)
    statusCorner.Parent = status
    
    local active = false
    status.MouseButton1Click:Connect(function()
        active = not active
        callback(active)
        if active then
            status.BackgroundColor3 = COLORS.Success
            status.Text = "ON"
        else
            status.BackgroundColor3 = COLORS.Danger
            status.Text = "OFF"
        end
    end)
    
    return status
end

-- Função para criar Slider (FOV)
local function createSlider(parent, text, yPos, min, max, default, callback)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0.94, 0, 0, 60)
    frame.Position = UDim2.new(0.03, 0, yPos, 0)
    frame.BackgroundColor3 = COLORS.Visual
    frame.BackgroundTransparency = 0.2
    frame.BorderSizePixel = 1
    frame.BorderColor3 = Color3.fromRGB(255, 255, 255)
    frame.Parent = parent
    
    local frameCorner = Instance.new("UICorner")
    frameCorner.CornerRadius = UDim.new(0, 10)
    frameCorner.Parent = frame
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0.6, 0, 0.4, 0)
    label.Position = UDim2.new(0.05, 0, 0.1, 0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = COLORS.TextWhite
    label.Font = Enum.Font.GothamBold
    label.TextSize = 14
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = frame
    
    local valueLabel = Instance.new("TextLabel")
    valueLabel.Size = UDim2.new(0.2, 0, 0.4, 0)
    valueLabel.Position = UDim2.new(0.7, 0, 0.1, 0)
    valueLabel.BackgroundTransparency = 1
    valueLabel.Text = tostring(default)
    valueLabel.TextColor3 = COLORS.TextWhite
    valueLabel.Font = Enum.Font.GothamBold
    valueLabel.TextSize = 14
    valueLabel.TextXAlignment = Enum.TextXAlignment.Center
    valueLabel.Parent = frame
    
    local minusBtn = Instance.new("TextButton")
    minusBtn.Size = UDim2.new(0, 25, 0, 25)
    minusBtn.Position = UDim2.new(0.05, 0, 0.55, 0)
    minusBtn.BackgroundColor3 = COLORS.Danger
    minusBtn.Text = "-"
    minusBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    minusBtn.Font = Enum.Font.GothamBold
    minusBtn.TextSize = 15
    minusBtn.Parent = frame
    local minusCorner = Instance.new("UICorner")
    minusCorner.CornerRadius = UDim.new(1, 0)
    minusCorner.Parent = minusBtn
    
    local plusBtn = Instance.new("TextButton")
    plusBtn.Size = UDim2.new(0, 25, 0, 25)
    plusBtn.Position = UDim2.new(0.1, 0, 0.55, 0)
    plusBtn.BackgroundColor3 = COLORS.Success
    plusBtn.Text = "+"
    plusBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    plusBtn.Font = Enum.Font.GothamBold
    plusBtn.TextSize = 15
    plusBtn.Parent = frame
    local plusCorner = Instance.new("UICorner")
    plusCorner.CornerRadius = UDim.new(1, 0)
    plusCorner.Parent = plusBtn
    
    local currentVal = default
    minusBtn.MouseButton1Click:Connect(function()
        currentVal = math.max(min, currentVal - 5)
        valueLabel.Text = tostring(currentVal)
        callback(currentVal)
    end)
    plusBtn.MouseButton1Click:Connect(function()
        currentVal = math.min(max, currentVal + 5)
        valueLabel.Text = tostring(currentVal)
        callback(currentVal)
    end)
end

-- ============================================================
-- CONSTRUINDO O MENU
-- ============================================================
local yPos = 0.01

createCategory(scrollFrame, "COMBATE", yPos, "⚔️")
yPos = yPos + 0.06

-- Aimbot
createPremiumButton(scrollFrame, "AIMBOT", "Mira na cabeça com FOV", yPos, COLORS.Combat, "🎯",
    function(active)
        aimbotActive = active
        if active then StartAimbot() else if aimbotConnection then aimbotConnection:Disconnect() end end
    end)
yPos = yPos + 0.075

-- ESP
createPremiumButton(scrollFrame, "ESP TRACER", "Linhas + Vida + Nome", yPos, COLORS.Visual, "📡",
    function(active)
        espActive = active
        if not active then
            for _, esp in pairs(espObjects) do
                SafeCall(function()
                    esp.line:Destroy()
                    esp.healthBar:Destroy()
                    esp.nameLabel:Destroy()
                end)
            end
            espObjects = {}
        end
    end)
yPos = yPos + 0.075

-- Slider FOV
createSlider(scrollFrame, "FOV TAMANHO", yPos, 50, 500, config.AimbotFOV, function(val)
    config.AimbotFOV = val
    fovCircle.Size = UDim2.new(0, val * 2, 0, val * 2)
    fovCircle.Position = UDim2.new(0.5, -val, 0.5, -val)
end)
yPos = yPos + 0.09

-- Fly
createPremiumButton(scrollFrame, "FLY", "Voar pelo mapa", yPos, COLORS.Movement, "🌊",
    function(active)
        flyActive = active
        if active then StartFly() end
    end)
yPos = yPos + 0.075

-- Speed
createPremiumButton(scrollFrame, "SPEED HACK", "Velocidade máxima", yPos, COLORS.Movement, "💨",
    function(active)
        speedActive = active
        SafeCall(function()
            local humanoid = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid")
            if humanoid then humanoid.WalkSpeed = active and 150 or 16 end
        end)
    end)
yPos = yPos + 0.075

-- God Mode
createPremiumButton(scrollFrame, "GOD MODE", "Imune a dano", yPos, COLORS.Power, "🛡️",
    function(active)
        godModeActive = active
        SafeCall(function()
            local humanoid = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid")
            if humanoid then humanoid.Health = active and math.huge or 100 end
        end)
    end)
yPos = yPos + 0.075

-- Antikick
createPremiumButton(scrollFrame, "ANTI-KICK", "Não ser expulso", yPos, COLORS.Power, "🔒",
    function(active)
        antiKickActive = active
        if active then
            LocalPlayer:GetPropertyChangedSignal("Parent"):Connect(function()
                if antiKickActive and LocalPlayer.Parent == nil then
                    task.wait(0.1)
                    SafeCall(function() LocalPlayer.Parent = Players end)
                end
            end)
        end
    end)
yPos = yPos + 0.075

-- Munição Infinita
createPremiumButton(scrollFrame, "MUNIÇÃO INFINITA", "Balas infinitas", yPos, COLORS.Weapon, "🔫",
    function(active)
        infiniteAmmoActive = active
        if active then
            task.spawn(function()
                while infiniteAmmoActive do
                    SafeCall(function()
                        for _, tool in pairs(LocalPlayer.Backpack:GetChildren()) do
                            if tool:IsA("Tool") then
                                for _, v in pairs(tool:GetDescendants()) do
                                    if v:IsA("IntValue") and string.lower(v.Name):find("ammo") then v.Value = 999 end
                                end
                            end
                        end
                    end)
                    task.wait(0.1)
                end
            end)
        end
    end)
yPos = yPos + 0.075

-- ============================================================
-- TOGGLE MENU
-- ============================================================
local menuOpen = false
function toggleMenu()
    menuOpen = not menuOpen
    mainFrame.Visible = menuOpen
    floatBtn.Visible = not menuOpen
end
floatBtn.MouseButton1Click:Connect(toggleMenu)

UserInputService.InputBegan:Connect(function(input, processed)
    if processed then return end
    if input.KeyCode == Enum.KeyCode.F5 then toggleMenu() end
    if input.KeyCode == Enum.KeyCode.Escape and menuOpen then toggleMenu() end
end)

-- Arrastar Menu
local dragging = false
local dragStart, startPos
mainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = mainFrame.Position
    end
end)
mainFrame.InputEnded:Connect(function()
    dragging = false
end)
UserInputService.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

-- Aviso Legal
print("🚀 Script Ultra Premium carregado. Use com moderação!")
