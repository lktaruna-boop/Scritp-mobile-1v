-- ============================================
-- 💎 PAINEL PREMIUM - VERSÃO 5.0 BRANCA 💎
-- FUNDO ESCURO | TEXTOS BRANCOS | ALTO CONTRASTE
-- ============================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local LocalPlayer = Players.LocalPlayer
local Workspace = game:GetService("Workspace")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")

-- ============================================
-- CONFIGURAÇÕES DE CORES (FUNDO ESCURO, TEXTO BRANCO)
-- ============================================
local COLORS = {
    -- Fundos (Escuros para destacar o branco)
    Background = Color3.fromRGB(15, 15, 30), -- Preto azulado
    BackgroundSecondary = Color3.fromRGB(25, 25, 45),
    Card = Color3.fromRGB(35, 35, 65), -- Cinza escuro dos botões
    CardHover = Color3.fromRGB(50, 50, 90),
    
    -- Cores principais (bordas vibrantes)
    Primary = Color3.fromRGB(0, 120, 255), -- Azul vibrante
    PrimaryLight = Color3.fromRGB(80, 160, 255),
    PrimaryDark = Color3.fromRGB(0, 80, 180),
    
    -- Status
    Success = Color3.fromRGB(0, 230, 118),
    Danger = Color3.fromRGB(255, 70, 70),
    Warning = Color3.fromRGB(255, 200, 0),
    Info = Color3.fromRGB(0, 200, 255),
    
    -- Textos (TODOS BRANCOS PARA MÁXIMA VISIBILIDADE)
    Text = Color3.fromRGB(255, 255, 255), -- Branco puro
    TextSecondary = Color3.fromRGB(220, 220, 240), -- Branco levemente acinzentado
    TextMuted = Color3.fromRGB(200, 200, 220),
    
    -- Categorias
    Combat = Color3.fromRGB(255, 70, 70),
    Visual = Color3.fromRGB(0, 200, 255),
    Movement = Color3.fromRGB(0, 230, 118),
    Power = Color3.fromRGB(255, 200, 0),
    Weapon = Color3.fromRGB(255, 150, 0),
    Extra = Color3.fromRGB(180, 80, 255),
}

-- ============================================
-- VARIÁVEIS DAS FUNÇÕES
-- ============================================
local aimbotActive = false
local aimbotConnection = nil
local espActive = false
local espHighlights = {}
local speedActive = false
local originalSpeed = 16
local jumpActive = false
local godModeActive = false
local antiKickActive = false
local flyActive = false
local noClipActive = false
local invisibleActive = false
local instantKillActive = false
local superFarActive = false
local freezeActive = false
local explodeActive = false
local silentAimActive = false
local wallbangActive = false
local noRecoilActive = false
local noSpreadActive = false
local infiniteAmmoActive = false

local currentSpeed = 70
local flySpeed = 60
local flyConnection = nil
local noClipConnection = nil
local antiKickConnection = nil

local CONFIG = {
    AimbotRange = 200,
}

-- ============================================
-- CRIAÇÃO DA GUI
-- ============================================
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "PremiumHack"
screenGui.Parent = CoreGui
screenGui.ResetOnSpawn = false

-- ========== BOTÃO FLUTUANTE PREMIUM ==========
local floatBtn = Instance.new("TextButton")
floatBtn.Size = UDim2.new(0, 60, 0, 60)
floatBtn.Position = UDim2.new(0.85, 0, 0.03, 0)
floatBtn.BackgroundColor3 = COLORS.Primary
floatBtn.BackgroundTransparency = 0.1
floatBtn.Text = "⚡"
floatBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
floatBtn.Font = Enum.Font.GothamBold
floatBtn.TextSize = 30
floatBtn.BorderSizePixel = 2
floatBtn.BorderColor3 = Color3.fromRGB(255, 255, 255)
floatBtn.Parent = screenGui
floatBtn.ZIndex = 999

local floatCorner = Instance.new("UICorner")
floatCorner.CornerRadius = UDim.new(1, 0)
floatCorner.Parent = floatBtn

-- Sombra do botão
local floatShadow = Instance.new("Frame")
floatShadow.Size = UDim2.new(0, 68, 0, 68)
floatShadow.Position = UDim2.new(0.842, 0, 0.025, 0)
floatShadow.BackgroundColor3 = COLORS.Primary
floatShadow.BackgroundTransparency = 0.6
floatShadow.BorderSizePixel = 0
floatShadow.Parent = screenGui
floatShadow.ZIndex = 998

local shadowCorner = Instance.new("UICorner")
shadowCorner.CornerRadius = UDim.new(1, 0)
shadowCorner.Parent = floatShadow

-- ========== MENU PRINCIPAL ==========
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 400, 0, 600)
mainFrame.Position = UDim2.new(0.5, -200, 0.5, -300)
mainFrame.BackgroundColor3 = COLORS.Background
mainFrame.BackgroundTransparency = 0.05
mainFrame.BorderSizePixel = 2
mainFrame.BorderColor3 = COLORS.Primary
mainFrame.ClipsDescendants = true
mainFrame.Parent = screenGui
mainFrame.Visible = false
mainFrame.ZIndex = 100

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 20)
mainCorner.Parent = mainFrame

-- Sombra do menu
local menuShadow = Instance.new("Frame")
menuShadow.Size = UDim2.new(1.02, 0, 1.02, 0)
menuShadow.Position = UDim2.new(-0.01, 0, -0.01, 0)
menuShadow.BackgroundColor3 = COLORS.BackgroundSecondary
menuShadow.BackgroundTransparency = 0.9
menuShadow.BorderSizePixel = 0
menuShadow.Parent = mainFrame

local shadowCorner2 = Instance.new("UICorner")
shadowCorner2.CornerRadius = UDim.new(0, 22)
shadowCorner2.Parent = menuShadow

-- ========== HEADER PREMIUM ==========
local header = Instance.new("Frame")
header.Size = UDim2.new(1, 0, 0, 70)
header.BackgroundColor3 = COLORS.BackgroundSecondary
header.BackgroundTransparency = 0.1
header.BorderSizePixel = 1
header.BorderColor3 = COLORS.PrimaryDark
header.Parent = mainFrame

local headerCorner = Instance.new("UICorner")
headerCorner.CornerRadius = UDim.new(0, 20)
headerCorner.Parent = header

-- Linha de gradiente
local gradientLine = Instance.new("Frame")
gradientLine.Size = UDim2.new(1, 0, 0, 3)
gradientLine.Position = UDim2.new(0, 0, 1, 0)
gradientLine.BackgroundColor3 = COLORS.Primary
gradientLine.BackgroundTransparency = 0.1
gradientLine.BorderSizePixel = 0
gradientLine.Parent = header

-- Ícone do header
local headerIcon = Instance.new("TextLabel")
headerIcon.Size = UDim2.new(0, 40, 1, 0)
headerIcon.Position = UDim2.new(0.03, 0, 0, 0)
headerIcon.BackgroundTransparency = 1
headerIcon.Text = "◆"
headerIcon.TextColor3 = Color3.fromRGB(255, 255, 255) -- Branco
headerIcon.Font = Enum.Font.GothamBold
headerIcon.TextSize = 28
headerIcon.TextXAlignment = Enum.TextXAlignment.Center
headerIcon.Parent = header

-- Título
local title = Instance.new("TextLabel")
title.Size = UDim2.new(0.5, 0, 0.6, 0)
title.Position = UDim2.new(0.12, 0, 0.1, 0)
title.BackgroundTransparency = 1
title.Text = "PREMIUM ULTRA"
title.TextColor3 = Color3.fromRGB(255, 255, 255) -- Branco
title.Font = Enum.Font.GothamBold
title.TextSize = 20
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = header

-- Subtítulo
local subTitle = Instance.new("TextLabel")
subTitle.Size = UDim2.new(0.5, 0, 0.35, 0)
subTitle.Position = UDim2.new(0.12, 0, 0.6, 0)
subTitle.BackgroundTransparency = 1
subTitle.Text = "⚡ Ultimate Hack System"
subTitle.TextColor3 = Color3.fromRGB(220, 220, 240) -- Branco
subTitle.Font = Enum.Font.Gotham
subTitle.TextSize = 11
subTitle.TextXAlignment = Enum.TextXAlignment.Left
subTitle.Parent = header

-- Versão
local version = Instance.new("TextLabel")
version.Size = UDim2.new(0.15, 0, 0.35, 0)
version.Position = UDim2.new(0.82, 0, 0.6, 0)
version.BackgroundTransparency = 1
version.Text = "v5.0"
version.TextColor3 = COLORS.TextMuted
version.Font = Enum.Font.Gotham
version.TextSize = 10
version.TextXAlignment = Enum.TextXAlignment.Right
version.Parent = header

-- Botão fechar
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 38, 0, 38)
closeBtn.Position = UDim2.new(1, -48, 0, 16)
closeBtn.BackgroundColor3 = COLORS.Danger
closeBtn.BackgroundTransparency = 0.1
closeBtn.Text = "✕"
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 18
closeBtn.BorderSizePixel = 1
closeBtn.BorderColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.Parent = header

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(1, 0)
closeCorner.Parent = closeBtn

closeBtn.MouseButton1Click:Connect(toggleMenu)

-- ========== SCROLL PREMIUM ==========
local scrollFrame = Instance.new("ScrollingFrame")
scrollFrame.Size = UDim2.new(1, 0, 1, -70)
scrollFrame.Position = UDim2.new(0, 0, 0, 70)
scrollFrame.BackgroundTransparency = 1
scrollFrame.BorderSizePixel = 0
scrollFrame.Parent = mainFrame
scrollFrame.CanvasSize = UDim2.new(0, 0, 0, 1900)
scrollFrame.ScrollBarThickness = 4
scrollFrame.ScrollBarImageColor3 = COLORS.Primary
scrollFrame.ScrollBarImageTransparency = 0.1

-- ============================================
-- FUNÇÕES DE CRIAÇÃO DE ELEMENTOS
-- ============================================

-- ========== FUNÇÃO: CRIAR CATEGORIA ==========
local function createCategory(parent, text, yPos, icon, color)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0.94, 0, 0, 36)
    frame.Position = UDim2.new(0.03, 0, yPos, 0)
    frame.BackgroundColor3 = color or COLORS.Primary
    frame.BackgroundTransparency = 0.1
    frame.BorderSizePixel = 1
    frame.BorderColor3 = Color3.fromRGB(255, 255, 255) -- Borda branca
    frame.Parent = parent
    
    local frameCorner = Instance.new("UICorner")
    frameCorner.CornerRadius = UDim.new(0, 8)
    frameCorner.Parent = frame
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 1, 0)
    label.Position = UDim2.new(0.04, 0, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = icon .. "  " .. text
    label.TextColor3 = Color3.fromRGB(255, 255, 255) -- Texto BRANCO
    label.Font = Enum.Font.GothamBold
    label.TextSize = 15
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = frame
    
    return frame
end

-- ========== FUNÇÃO: CRIAR TOGGLE PREMIUM ==========
local function createPremiumToggle(parent, text, yPos, color, icon, callback)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0.94, 0, 0, 46)
    frame.Position = UDim2.new(0.03, 0, yPos, 0)
    frame.BackgroundColor3 = COLORS.Card -- Fundo escuro do botão
    frame.BackgroundTransparency = 0.1
    frame.BorderSizePixel = 1
    frame.BorderColor3 = color or COLORS.Primary
    frame.Parent = parent
    
    local frameCorner = Instance.new("UICorner")
    frameCorner.CornerRadius = UDim.new(0, 10)
    frameCorner.Parent = frame
    
    -- Ícone (esquerda)
    local iconLabel = Instance.new("TextLabel")
    iconLabel.Size = UDim2.new(0, 32, 1, 0)
    iconLabel.Position = UDim2.new(0.02, 0, 0, 0)
    iconLabel.BackgroundTransparency = 1
    iconLabel.Text = icon or "◆"
    iconLabel.TextColor3 = color or COLORS.Primary
    iconLabel.Font = Enum.Font.Gotham
    iconLabel.TextSize = 18
    iconLabel.TextXAlignment = Enum.TextXAlignment.Center
    iconLabel.Parent = frame
    
    -- Texto (BRANCO PURO)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.55, 0, 1, 0)
    btn.Position = UDim2.new(0.1, 0, 0, 0)
    btn.BackgroundTransparency = 1
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255) -- Branco
    btn.Font = Enum.Font.GothamSemibold
    btn.TextSize = 14
    btn.TextXAlignment = Enum.TextXAlignment.Left
    btn.TextYAlignment = Enum.TextYAlignment.Center
    btn.Parent = frame
    
    -- Status Toggle (direita)
    local status = Instance.new("Frame")
    status.Size = UDim2.new(0, 44, 0, 24)
    status.Position = UDim2.new(0.88, 0, 0.24, 0)
    status.BackgroundColor3 = COLORS.Danger
    status.BackgroundTransparency = 0.1
    status.BorderSizePixel = 1
    status.BorderColor3 = Color3.fromRGB(255, 255, 255)
    status.Parent = frame
    
    local statusCorner = Instance.new("UICorner")
    statusCorner.CornerRadius = UDim.new(1, 0)
    statusCorner.Parent = status
    
    -- Glow do status
    local statusGlow = Instance.new("Frame")
    statusGlow.Size = UDim2.new(1, 0, 1, 0)
    statusGlow.Position = UDim2.new(0, 0, 0, 0)
    statusGlow.BackgroundColor3 = COLORS.Danger
    statusGlow.BackgroundTransparency = 0.5
    statusGlow.BorderSizePixel = 0
    statusGlow.Parent = status
    
    local glowCorner2 = Instance.new("UICorner")
    glowCorner2.CornerRadius = UDim.new(1, 0)
    glowCorner2.Parent = statusGlow
    
    -- Texto do status
    local statusText = Instance.new("TextLabel")
    statusText.Size = UDim2.new(1, 0, 1, 0)
    statusText.BackgroundTransparency = 1
    statusText.Text = "OFF"
    statusText.TextColor3 = Color3.fromRGB(255, 255, 255) -- Branco
    statusText.Font = Enum.Font.GothamBold
    statusText.TextSize = 10
    statusText.Parent = status
    
    local active = false
    
    -- Clique do botão
    btn.MouseButton1Click:Connect(function()
        active = not active
        callback(active)
        
        if active then
            status.BackgroundColor3 = COLORS.Success
            statusGlow.BackgroundColor3 = COLORS.Success
            statusText.Text = "ON"
            frame.BorderColor3 = COLORS.Success
            frame.BackgroundColor3 = Color3.fromRGB(45, 65, 45) -- Fundo levemente esverdeado escuro
        else
            status.BackgroundColor3 = COLORS.Danger
            statusGlow.BackgroundColor3 = COLORS.Danger
            statusText.Text = "OFF"
            frame.BorderColor3 = color or COLORS.Primary
            frame.BackgroundColor3 = COLORS.Card -- Volta ao fundo escuro padrão
        end
    end)
    
    -- Hover effect
    btn.MouseEnter:Connect(function()
        TweenService:Create(frame, TweenInfo.new(0.15), {BackgroundColor3 = COLORS.CardHover}):Play()
    end)
    
    btn.MouseLeave:Connect(function()
        if not active then
            TweenService:Create(frame, TweenInfo.new(0.15), {BackgroundColor3 = COLORS.Card}):Play()
        end
    end)
    
    return btn, frame, status
end

-- ========== FUNÇÃO: CRIAR SLIDER ==========
local function createPremiumSlider(parent, text, yPos, icon, minVal, maxVal, defaultVal, callback)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0.94, 0, 0, 48)
    frame.Position = UDim2.new(0.03, 0, yPos, 0)
    frame.BackgroundColor3 = COLORS.Card
    frame.BackgroundTransparency = 0.1
    frame.BorderSizePixel = 1
    frame.BorderColor3 = COLORS.Primary
    frame.Parent = parent
    
    local frameCorner = Instance.new("UICorner")
    frameCorner.CornerRadius = UDim.new(0, 10)
    frameCorner.Parent = frame
    
    -- Ícone
    local iconLabel = Instance.new("TextLabel")
    iconLabel.Size = UDim2.new(0, 30, 1, 0)
    iconLabel.Position = UDim2.new(0.02, 0, 0, 0)
    iconLabel.BackgroundTransparency = 1
    iconLabel.Text = icon or "◆"
    iconLabel.TextColor3 = COLORS.PrimaryLight
    iconLabel.Font = Enum.Font.Gotham
    iconLabel.TextSize = 16
    iconLabel.TextXAlignment = Enum.TextXAlignment.Center
    iconLabel.Parent = frame
    
    -- Texto (BRANCO)
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0.38, 0, 1, 0)
    label.Position = UDim2.new(0.1, 0, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = Color3.fromRGB(255, 255, 255) -- Branco
    label.Font = Enum.Font.Gotham
    label.TextSize = 13
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = frame
    
    -- Valor
    local valueLabel = Instance.new("TextLabel")
    valueLabel.Size = UDim2.new(0.12, 0, 1, 0)
    valueLabel.Position = UDim2.new(0.52, 0, 0, 0)
    valueLabel.BackgroundTransparency = 1
    valueLabel.Text = tostring(defaultVal)
    valueLabel.TextColor3 = COLORS.PrimaryLight
    valueLabel.Font = Enum.Font.GothamBold
    valueLabel.TextSize = 16
    valueLabel.TextXAlignment = Enum.TextXAlignment.Center
    valueLabel.Parent = frame
    
    -- Botão MENOS
    local minusBtn = Instance.new("TextButton")
    minusBtn.Size = UDim2.new(0, 28, 0, 28)
    minusBtn.Position = UDim2.new(0.72, 0, 0.21, 0)
    minusBtn.BackgroundColor3 = COLORS.Danger
    minusBtn.BackgroundTransparency = 0.2
    minusBtn.Text = "−"
    minusBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    minusBtn.Font = Enum.Font.GothamBold
    minusBtn.TextSize = 16
    minusBtn.BorderSizePixel = 1
    minusBtn.BorderColor3 = Color3.fromRGB(255, 255, 255)
    minusBtn.Parent = frame
    
    local minusCorner = Instance.new("UICorner")
    minusCorner.CornerRadius = UDim.new(1, 0)
    minusCorner.Parent = minusBtn
    
    -- Botão MAIS
    local plusBtn = Instance.new("TextButton")
    plusBtn.Size = UDim2.new(0, 28, 0, 28)
    plusBtn.Position = UDim2.new(0.85, 0, 0.21, 0)
    plusBtn.BackgroundColor3 = COLORS.Success
    plusBtn.BackgroundTransparency = 0.2
    plusBtn.Text = "+"
    plusBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    plusBtn.Font = Enum.Font.GothamBold
    plusBtn.TextSize = 16
    plusBtn.BorderSizePixel = 1
    plusBtn.BorderColor3 = Color3.fromRGB(255, 255, 255)
    plusBtn.Parent = frame
    
    local plusCorner = Instance.new("UICorner")
    plusCorner.CornerRadius = UDim.new(1, 0)
    plusCorner.Parent = plusBtn
    
    local currentVal = defaultVal
    
    minusBtn.MouseButton1Click:Connect(function()
        currentVal = math.max(minVal, currentVal - 10)
        valueLabel.Text = tostring(currentVal)
        callback(currentVal)
    end)
    
    plusBtn.MouseButton1Click:Connect(function()
        currentVal = math.min(maxVal, currentVal + 10)
        valueLabel.Text = tostring(currentVal)
        callback(currentVal)
    end)
    
    return frame
end

-- ============================================
-- CONSTRUÇÃO DO PAINEL
-- ============================================

local yPos = 0.01

-- ============================================
-- CATEGORIA 1: ⚔️ COMBATE
-- ============================================
createCategory(scrollFrame, "COMBATE", yPos, "⚔️", COLORS.Combat)
yPos = yPos + 0.065

local aimbotBtn, aimbotFrame, aimbotStatus = createPremiumToggle(
    scrollFrame, "AIMBOT 100%", yPos, COLORS.Combat, "🎯",
    function(active)
        aimbotActive = active
        if active then
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
    end
)
yPos = yPos + 0.075

local farBtn, farFrame, farStatus = createPremiumToggle(
    scrollFrame, "SUPER FAR", yPos, COLORS.Combat, "🔭",
    function(active)
        superFarActive = active
    end
)
yPos = yPos + 0.075

local silentBtn, silentFrame, silentStatus = createPremiumToggle(
    scrollFrame, "SILENT AIM", yPos, COLORS.Combat, "🔇",
    function(active)
        silentAimActive = active
    end
)
yPos = yPos + 0.075

local killBtn, killFrame, killStatus = createPremiumToggle(
    scrollFrame, "INSTANT KILL", yPos, COLORS.Combat, "💀",
    function(active)
        instantKillActive = active
    end
)
yPos = yPos + 0.085

-- ============================================
-- CATEGORIA 2: 🔫 ARMAS
-- ============================================
createCategory(scrollFrame, "ARMAS", yPos, "🔫", COLORS.Weapon)
yPos = yPos + 0.065

local wallbangBtn, wallbangFrame, wallbangStatus = createPremiumToggle(
    scrollFrame, "WALLBANG", yPos, COLORS.Weapon, "🧱",
    function(active)
        wallbangActive = active
        if active then
            for _, obj in pairs(Workspace:GetDescendants()) do
                if obj:IsA("Part") or obj:IsA("BasePart") then
                    pcall(function()
                        obj.CanQuery = false
                        obj.CanTouch = false
                    end)
                end
            end
            print("🧱 WALLBANG ATIVADO!")
        else
            for _, obj in pairs(Workspace:GetDescendants()) do
                if obj:IsA("Part") or obj:IsA("BasePart") then
                    pcall(function()
                        obj.CanQuery = true
                        obj.CanTouch = true
                    end)
                end
            end
            print("🧱 WALLBANG DESATIVADO!")
        end
    end
)
yPos = yPos + 0.075

local noRecoilBtn, noRecoilFrame, noRecoilStatus = createPremiumToggle(
    scrollFrame, "NO RECOIL", yPos, COLORS.Weapon, "🔫",
    function(active)
        noRecoilActive = active
        if active then
            print("🔫 NO RECOIL ATIVADO!")
        else
            print("🔫 NO RECOIL DESATIVADO!")
        end
    end
)
yPos = yPos + 0.075

local noSpreadBtn, noSpreadFrame, noSpreadStatus = createPremiumToggle(
    scrollFrame, "NO SPREAD", yPos, COLORS.Weapon, "🎯",
    function(active)
        noSpreadActive = active
        if active then
            print("🎯 NO SPREAD ATIVADO!")
        else
            print("🎯 NO SPREAD DESATIVADO!")
        end
    end
)
yPos = yPos + 0.075

local infiniteAmmoBtn, infiniteAmmoFrame, infiniteAmmoStatus = createPremiumToggle(
    scrollFrame, "MUNIÇÃO INFINITA", yPos, COLORS.Weapon, "🔫",
    function(active)
        infiniteAmmoActive = active
        if active then
            print("🔫 MUNIÇÃO INFINITA ATIVADA!")
            game:GetService("RunService").Heartbeat:Connect(function()
                if not infiniteAmmoActive then return end
                local backpack = LocalPlayer.Backpack
                for _, tool in pairs(backpack:GetChildren()) do
                    if tool:IsA("Tool") then
                        for _, child in pairs(tool:GetDescendants()) do
                            if child:IsA("NumberValue") and child.Name:lower():find("ammo") then
                                child.Value = 999
                            end
                            if child:IsA("IntValue") and child.Name:lower():find("ammo") then
                                child.Value = 999
                            end
                        end
                    end
                end
            end)
        else
            print("🔫 MUNIÇÃO INFINITA DESATIVADA!")
        end
    end
)
yPos = yPos + 0.085

-- ============================================
-- CATEGORIA 3: 👁️ VISUAIS
-- ============================================
createCategory(scrollFrame, "VISUAIS", yPos, "👁️", COLORS.Visual)
yPos = yPos + 0.065

local espBtn, espFrame, espStatus = createPremiumToggle(
    scrollFrame, "ESP BOX", yPos, COLORS.Visual, "📦",
    function(active)
        espActive = active
        if active then
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
    end
)
yPos = yPos + 0.075

local invisibleBtn, invisibleFrame, invisibleStatus = createPremiumToggle(
    scrollFrame, "INVISIBILIDADE", yPos, COLORS.Visual, "👻",
    function(active)
        invisibleActive = active
        local char = LocalPlayer.Character
        if char then
            for _, part in pairs(char:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.Transparency = active and 1 or 0
                end
            end
        end
    end
)
yPos = yPos + 0.075

local nvBtn, nvFrame, nvStatus = createPremiumToggle(
    scrollFrame, "VISÃO NOTURNA", yPos, COLORS.Visual, "🌙",
    function(active)
        if active then
            Lighting.Ambient = Color3.fromRGB(100, 100, 150)
            Lighting.Brightness = 2
        else
            Lighting.Ambient = Color3.fromRGB(0, 0, 0)
            Lighting.Brightness = 1
        end
    end
)
yPos = yPos + 0.085

-- ============================================
-- CATEGORIA 4: 🏃 MOVIMENTO
-- ============================================
createCategory(scrollFrame, "MOVIMENTO", yPos, "🏃", COLORS.Movement)
yPos = yPos + 0.065

local speedBtn, speedFrame, speedStatus = createPremiumToggle(
    scrollFrame, "VELOCIDADE", yPos, COLORS.Movement, "💨",
    function(active)
        speedActive = active
        local char = LocalPlayer.Character
        if char and char:FindFirstChild("Humanoid") then
            if active then
                char.Humanoid.WalkSpeed = currentSpeed
            else
                char.Humanoid.WalkSpeed = originalSpeed
            end
        end
    end
)
yPos = yPos + 0.075

local jumpBtn, jumpFrame, jumpStatus = createPremiumToggle(
    scrollFrame, "SUPER JUMP", yPos, COLORS.Movement, "⚡",
    function(active)
        jumpActive = active
        local char = LocalPlayer.Character
        if char and char:FindFirstChild("Humanoid") then
            char.Humanoid.JumpPower = active and 200 or 50
        end
    end
)
yPos = yPos + 0.075

local flyBtn, flyFrame, flyStatus = createPremiumToggle(
    scrollFrame, "FLY", yPos, COLORS.Movement, "🌊",
    function(active)
        flyActive = active
        local char = LocalPlayer.Character
        if not char then return end
        local humanoid = char:FindFirstChild("Humanoid")
        if not humanoid then return end
        
        if active then
            humanoid.PlatformStand = true
            flyConnection = RunService.Heartbeat:Connect(function()
                if not flyActive then return end
                local hrp = char:FindFirstChild("HumanoidRootPart")
                if not hrp then return end
                local moveDirection = Vector3.new()
                local camera = Workspace.CurrentCamera
                if UserInputService:IsKeyDown(Enum.KeyCode.W) then
                    moveDirection = moveDirection + camera.CFrame.LookVector * Vector3.new(1, 0, 1)
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.S) then
                    moveDirection = moveDirection - camera.CFrame.LookVector * Vector3.new(1, 0, 1)
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.A) then
                    moveDirection = moveDirection - camera.CFrame.RightVector * Vector3.new(1, 0, 1)
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.D) then
                    moveDirection = moveDirection + camera.CFrame.RightVector * Vector3.new(1, 0, 1)
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
                    moveDirection = moveDirection + Vector3.new(0, 1, 0)
                end
                if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
                    moveDirection = moveDirection - Vector3.new(0, 1, 0)
                end
                if moveDirection.Magnitude > 0 then
                    moveDirection = moveDirection.Unit * flySpeed
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
            local hrp = char:FindFirstChild("HumanoidRootPart")
            if hrp then
                hrp.Velocity = Vector3.new(0, 0, 0)
            end
        end
    end
)
yPos = yPos + 0.075

local noClipBtn, noClipFrame, noClipStatus = createPremiumToggle(
    scrollFrame, "NO CLIP", yPos, COLORS.Movement, "🧱",
    function(active)
        noClipActive = active
        if active then
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
    end
)
yPos = yPos + 0.085

-- ============================================
-- CATEGORIA 5: 💥 PODERES
-- ============================================
createCategory(scrollFrame, "PODERES", yPos, "💥", COLORS.Power)
yPos = yPos + 0.065

local godBtn, godFrame, godStatus = createPremiumToggle(
    scrollFrame, "GOD MODE", yPos, COLORS.Power, "🛡️",
    function(active)
        godModeActive = active
        local char = LocalPlayer.Character
        if char then
            local humanoid = char:FindFirstChild("Humanoid")
            if humanoid then
                if active then
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
    end
)
yPos = yPos + 0.075

local antiKickBtn, antiKickFrame, antiKickStatus = createPremiumToggle(
    scrollFrame, "ANTI-KICK", yPos, COLORS.Power, "🛡️",
    function(active)
        antiKickActive = active
        if active then
            LocalPlayer:GetPropertyChangedSignal("Parent"):Connect(function()
                if antiKickActive and LocalPlayer.Parent == nil then
                    wait(0.1)
                    LocalPlayer.Parent = Players
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
    end
)
yPos = yPos + 0.075

local freezeBtn, freezeFrame, freezeStatus = createPremiumToggle(
    scrollFrame, "FREEZE PLAYERS", yPos, COLORS.Power, "🌀",
    function(active)
        freezeActive = active
        if active then
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
    end
)
yPos = yPos + 0.075

local explodeBtn, explodeFrame, explodeStatus = createPremiumToggle(
    scrollFrame, "EXPLODE PLAYERS", yPos, COLORS.Power, "💣",
    function(active)
        if active then
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
        end
    end
)
yPos = yPos + 0.085

-- ============================================
-- SLIDERS
-- ============================================

local speedSlider = createPremiumSlider(
    scrollFrame, "VELOCIDADE", yPos, "⚡", 50, 500, 70,
    function(val)
        currentSpeed = val
        if speedActive then
            local char = LocalPlayer.Character
            if char and char:FindFirstChild("Humanoid") then
                char.Humanoid.WalkSpeed = val
            end
        end
    end
)
yPos = yPos + 0.08

local flySpeedSlider = createPremiumSlider(
    scrollFrame, "FLY SPEED", yPos, "🚀", 30, 300, 60,
    function(val)
        flySpeed = val
    end
)
yPos = yPos + 0.08

local rangeSlider = createPremiumSlider(
    scrollFrame, "AIMBOT RANGE", yPos, "📏", 50, 500, 200,
    function(val)
        CONFIG.AimbotRange = val
    end
)
yPos = yPos + 0.08

-- ============================================
-- STATUS BAR PREMIUM
-- ============================================
local statusBar = Instance.new("Frame")
statusBar.Size = UDim2.new(0.35, 0, 0, 30)
statusBar.Position = UDim2.new(0.325, 0, 0.01, 0)
statusBar.BackgroundColor3 = COLORS.Background
statusBar.BackgroundTransparency = 0.1
statusBar.BorderSizePixel = 1
statusBar.BorderColor3 = COLORS.Primary
statusBar.Parent = screenGui
statusBar.ZIndex = 998

local statusCorner = Instance.new("UICorner")
statusCorner.CornerRadius = UDim.new(0, 10)
statusCorner.Parent = statusBar

local statusText = Instance.new("TextLabel")
statusText.Size = UDim2.new(1, 0, 1, 0)
statusText.BackgroundTransparency = 1
statusText.Text = "◆ SYSTEM READY"
statusText.TextColor3 = Color3.fromRGB(255, 255, 255) -- Branco
statusText.Font = Enum.Font.GothamBold
statusText.TextSize = 13
statusText.Parent = statusBar

-- ============================================
-- FUNÇÃO TOGGLE MENU
-- ============================================
local menuOpen = false

function toggleMenu()
    menuOpen = not menuOpen
    mainFrame.Visible = menuOpen
    floatBtn.Visible = not menuOpen
    
    if menuOpen then
        mainFrame.Size = UDim2.new(0, 400, 0, 0)
        TweenService:Create(mainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {
            Size = UDim2.new(0, 400, 0, 600)
        }):Play()
    end
end

floatBtn.MouseButton1Click:Connect(toggleMenu)

-- ============================================
-- KEYBINDS
-- ============================================
UserInputService.InputBegan:Connect(function(input, processed)
    if processed then return end
    if input.KeyCode == Enum.KeyCode.Escape and menuOpen then
        toggleMenu()
    end
    if input.KeyCode == Enum.KeyCode.F5 then
        toggleMenu()
    end
end)

-- ============================================
-- ARRASTAR MENU
-- ============================================
local dragging = false
local dragStart, startPos

mainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or 
       input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = mainFrame.Position
    end
end)

mainFrame.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or 
       input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or 
                     input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, 
                                      startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

-- ============================================
-- UPDATE STATUS
-- ============================================
local function updateStatus()
    local active = {}
    if aimbotActive then table.insert(active, "🎯") end
    if espActive then table.insert(active, "📦") end
    if flyActive then table.insert(active, "🌊") end
    if godModeActive then table.insert(active, "🛡️") end
    if speedActive then table.insert(active, "💨") end
    if wallbangActive then table.insert(active, "🧱") end
    if infiniteAmmoActive then table.insert(active, "🔫") end
    
    if #active > 0 then
        statusText.Text = "◆ " .. table.concat(active, " ")
        statusText.TextColor3 = COLORS.Success
    else
        statusText.Text = "◆ SYSTEM READY"
        statusText.TextColor3 = Color3.fromRGB(255, 255, 255) -- Branco
    end
end

game:GetService("RunService").Heartbeat:Connect(function()
    if math.random(1, 30) == 1 then
        updateStatus()
    end
end)

-- ============================================
-- INSTRUÇÕES
-- ============================================
print("========================================")
print("💎 PAINEL PREMIUM V5.0 - TEXTO BRANCO!")
print("========================================")
print("◆ Design de alto contraste")
print("◆ 5 categorias organizadas")
print("◆ 19 funções premium")
print("◆ Sliders ajustáveis")
print("◆ Status bar em tempo real")
print("========================================")
print("⚡ Clique em ⚡ para abrir/fechar")
print("⌨️ F5 ou ESC para abrir/fechar")
print("========================================")
