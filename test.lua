local VirtualInputManager = game:GetService("VirtualInputManager")
local Players = game:GetService("Players")
local GuiService = game:GetService("GuiService")
local UIS = game:GetService("UserInputService")
local Player = Players.LocalPlayer

local isMobile = UIS.TouchEnabled and not UIS.MouseEnabled

-- Função de Notificação na Tela (Debug)
local function notify(text)
    pcall(function()
        local screenGui = Instance.new("ScreenGui")
        screenGui.Name = "NotifyGui"
        screenGui.ResetOnSpawn = false
        screenGui.IgnoreGuiInset = true
        screenGui.Parent = Player:WaitForChild("PlayerGui")

        local textLabel = Instance.new("TextLabel")
        textLabel.Size = UDim2.new(0.6, 0, 0, 50)
        textLabel.Position = UDim2.new(0.2, 0, 0.1, 0)
        textLabel.BackgroundTransparency = 0.3
        textLabel.BackgroundColor3 = Color3.new(0, 0, 0)
        textLabel.TextColor3 = Color3.new(1, 0, 0) -- Vermelho para alertar
        textLabel.TextScaled = true
        textLabel.Text = text
        textLabel.Font = Enum.Font.GothamBold
        textLabel.Parent = screenGui
        
        game:GetService("Debris"):AddItem(screenGui, 3)
    end)
end

notify("Script Iniciado! Modo: " .. (isMobile and "MOBILE" or "PC"))

local function getScreenCoords(elemento)
    local pos = elemento.AbsolutePosition
    local size = elemento.AbsoluteSize
    local inset = GuiService:GetGuiInset()
    
    local x = pos.X + (size.X / 2)
    local y = pos.Y + (size.Y / 2)
    
    -- CORREÇÃO VERTICAL: Soma o Inset para coordenadas absolutas.
    -- Sem isso, o clique no celular vai "muito pra cima".
    y = y + inset.Y
    
    return math.floor(x), math.floor(y)
end

local function mostrarIndicador(x, y)
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "ClickIndicator"
    screenGui.ResetOnSpawn = false
    screenGui.IgnoreGuiInset = true
    screenGui.Parent = Player.PlayerGui

    local circle = Instance.new("Frame")
    circle.Size = UDim2.fromOffset(30, 30)
    circle.Position = UDim2.fromOffset(x, y)
    circle.AnchorPoint = Vector2.new(0.5, 0.5)
    circle.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    circle.BackgroundTransparency = 0.3
    circle.BorderSizePixel = 0
    circle.Parent = screenGui

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(1, 0)
    corner.Parent = circle

    return screenGui
end

local function clickElement(elemento)
    if not elemento then 
        notify("ERRO: Elemento nao encontrado!") 
        return 
    end

    task.wait(0.1)

    local x, y = getScreenCoords(elemento)
    
    local indicator = mostrarIndicador(x, y)
    task.wait(0.2)

    if isMobile then
        -- CORREÇÃO MOBILE:
        -- 1. Usa coordenadas absolutas (x, y com inset).
        -- 2. Passa o 'game' no final (OBRIGATÓRIO no Delta/Fluxus).
        local ok, err = pcall(function()
            VirtualInputManager:SendTouchEvent(0, Enum.UserInputState.Begin, x, y, game)
            task.wait(0.15)
            VirtualInputManager:SendTouchEvent(0, Enum.UserInputState.End, x, y, game)
        end)
        
        if not ok then
            notify("Erro no Touch: " .. tostring(err))
        end
    else
        -- PC
        pcall(function()
            VirtualInputManager:SendMouseMoveEvent(x, y, game)
            task.wait(0.05)
            VirtualInputManager:SendMouseButtonEvent(x, y, 0, true, game, 0)
            task.wait(0.1)
            VirtualInputManager:SendMouseButtonEvent(x, y, 0, false, game, 0)
        end)
    end

    task.wait(0.3)
    if indicator then indicator:Destroy() end
end

-- Encontra a Interface
notify("Procurando Interface...")
local MainUI = Player.PlayerGui:WaitForChild("MainInterface", 5)
if not MainUI then
    notify("ERRO: Interface nao encontrada!")
    return
end

local Inventory = MainUI.Inventory
local UseButton = Inventory.Index.ItemIndex.UseHolder.UseButton
local searchBox = Inventory.Items.Search.Content

notify("Abrindo Inventario...")
Inventory.Visible = true
task.wait(1)

notify("Clicando na Aba Items...")
clickElement(Inventory.Items.ItemsTab)
task.wait(0.5)

-- Função auxiliar para buscar e clicar
local function processItem(itemName, searchName)
    notify("Buscando: " .. itemName)
    searchBox.Text = searchName
    task.wait(1)
    
    -- Tenta encontrar o item
    local item = Inventory.Items.ItemGrid.ItemGridScrollingFrame:FindFirstChild("Item\n" .. itemName)
    
    if item then
        notify("Item encontrado! Clicando...")
        clickElement(item.Button)
        task.wait(0.5)
        clickElement(UseButton)
        task.wait(0.5)
    else
        notify("Item nao encontrado: " .. itemName)
    end
end

processItem("Strange Controller", "Strange Controller")
processItem("Biome Randomizer", "Biome Randomizer")

Inventory.Visible = false
searchBox.Text = ""
notify("Finalizado com Sucesso!")
