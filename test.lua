local VirtualInputManager = game:GetService("VirtualInputManager")
local Players = game:GetService("Players")
local GuiService = game:GetService("GuiService")
local UIS = game:GetService("UserInputService")
local Player = Players.LocalPlayer
local Cam = workspace.CurrentCamera

local isMobile = UIS.TouchEnabled and not UIS.MouseEnabled

local function getScreenCoords(elemento)
    local pos = elemento.AbsolutePosition
    local size = elemento.AbsoluteSize
    local inset = GuiService:GetGuiInset()
    
    -- Calcula o centro
    local x_center = pos.X + (size.X / 2)
    local y_center = pos.Y + (size.Y / 2)
    
    -- CORREÇÃO PARA DIFERENTES RESOLUÇÕES/SAFEAREA:
    -- Soma TANTO o X quanto o Y do inset.
    -- O inset.X considera o deslocamento lateral causado por notches/câmeras na tela
    -- ou ajustes de aspect ratio em telas estranhas.
    local x_abs = x_center + inset.X
    local y_abs = y_center + inset.Y
    
    return math.floor(x_abs), math.floor(y_abs)
end

local function mostrarIndicador(x, y)
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "ClickIndicator"
    screenGui.ResetOnSpawn = false
    screenGui.IgnoreGuiInset = true
    screenGui.Parent = game.CoreGui

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
    if not elemento then warn("Elemento não encontrado!") return end

    task.wait(0.1)

    local x, y = getScreenCoords(elemento)
    print("Clicando:", elemento.Name, "| x:", x, "y:", y, "| mobile:", isMobile)

    local indicator = mostrarIndicador(x, y)
    task.wait(0.2)

    if isMobile then
        -- Tenta Touch nativo
        local ok, err = pcall(function()
            VirtualInputManager:SendTouchEvent(0, Enum.UserInputState.Begin, x, y, game)
            task.wait(0.15)
            VirtualInputManager:SendTouchEvent(0, Enum.UserInputState.End, x, y, game)
        end)
        
        if not ok then
            warn("Touch falhou, usando Fallback Mouse: " .. tostring(err))
            -- Fallback: Tenta simular mouse
            pcall(function()
                VirtualInputManager:SendMouseButtonEvent(x, y, 0, true, game, 0)
                task.wait(0.1)
                VirtualInputManager:SendMouseButtonEvent(x, y, 0, false, game, 0)
            end)
        end
    else
        -- PC
        local ok, err = pcall(function()
            VirtualInputManager:SendMouseMoveEvent(x, y, game)
            task.wait(0.05)
            VirtualInputManager:SendMouseButtonEvent(x, y, 0, true, game, 0)
            task.wait(0.1)
            VirtualInputManager:SendMouseButtonEvent(x, y, 0, false, game, 0)
        end)
        print("Mouse click:", ok, err)
    end

    task.wait(0.3)
    indicator:Destroy()
end

local MainUI = Player.PlayerGui.MainInterface
local Inventory = MainUI.Inventory
local UseButton = Inventory.Index.ItemIndex.UseHolder.UseButton
local searchBox = Inventory.Items.Search.Content

print("Iniciando sequencia")

Inventory.Visible = true
task.wait(1)

clickElement(Inventory.Items.ItemsTab)
task.wait(0.5)

searchBox.Text = "Strange Controller"
task.wait(1)
local strangeItem = Inventory.Items.ItemGrid.ItemGridScrollingFrame["Item\nStrange Controller"]
if strangeItem then
    clickElement(strangeItem.Button)
    task.wait(0.5)
    clickElement(UseButton)
    task.wait(0.5)
else
    warn("Strange Controller não encontrado no grid")
end

searchBox.Text = "Biome Randomizer"
task.wait(1)
local biomeItem = Inventory.Items.ItemGrid.ItemGridScrollingFrame["Item\nBiome Randomizer"]
if biomeItem then
    clickElement(biomeItem.Button)
    task.wait(0.5)
    clickElement(UseButton)
    task.wait(0.5)
else
    warn("Biome Randomizer não encontrado no grid")
end

Inventory.Visible = false
searchBox.Text = ""
print("Finalizado")
