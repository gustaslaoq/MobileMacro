local VirtualInputManager = game:GetService("VirtualInputManager")
local Players = game:GetService("Players")
local GuiService = game:GetService("GuiService")
local UIS = game:GetService("UserInputService")
local Player = Players.LocalPlayer

local isMobile = UIS.TouchEnabled and not UIS.MouseEnabled

-- ============================================================
-- CALCULO DE COORDENADAS
-- Retorna DUAS coordenadas:
--   indicatorX/Y = AbsolutePosition puro (para desenhar o indicador visual)
--   clickX/Y     = AbsolutePosition + inset (para o VirtualInputManager)
--
-- Motivo: AbsolutePosition começa APÓS o inset (top bar do Roblox ~58px).
-- O VIM trabalha em coordenadas reais da tela (começa do pixel 0,0),
-- então precisamos somar o inset para que o click caia no lugar certo.
-- O indicador usa IgnoreGuiInset=false, então usa o mesmo sistema do
-- AbsolutePosition e não precisa de ajuste.
-- ============================================================
local function getCoords(elemento)
    local pos = elemento.AbsolutePosition
    local size = elemento.AbsoluteSize
    local inset = GuiService:GetGuiInset()

    -- Centro do elemento em coordenadas GUI (AbsolutePosition)
    local cx = math.floor(pos.X + (size.X / 2))
    local cy = math.floor(pos.Y + (size.Y / 2))

    -- Coordenadas reais para o VIM (soma o inset)
    local vx = cx + inset.X
    local vy = cy + inset.Y

    print(string.format(
        "[DEBUG] %s | AbsPos:(%.0f,%.0f) Size:(%.0f,%.0f) Inset:(%.0f,%.0f) | Indicador:(%d,%d) | VIM:(%d,%d)",
        elemento.Name,
        pos.X, pos.Y, size.X, size.Y,
        inset.X, inset.Y,
        cx, cy,
        vx, vy
    ))

    return cx, cy, vx, vy
end

-- ============================================================
-- INDICADOR VISUAL
-- IgnoreGuiInset=false para bater com o AbsolutePosition dos elementos
-- ============================================================
local function mostrarIndicador(ix, iy, vx, vy)
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "ClickIndicator"
    screenGui.ResetOnSpawn = false
    screenGui.IgnoreGuiInset = false
    screenGui.Parent = game.CoreGui

    -- Círculo vermelho = onde o indicador visual está (AbsolutePosition)
    local circle = Instance.new("Frame")
    circle.Size = UDim2.fromOffset(30, 30)
    circle.Position = UDim2.fromOffset(ix, iy)
    circle.AnchorPoint = Vector2.new(0.5, 0.5)
    circle.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    circle.BackgroundTransparency = 0.3
    circle.BorderSizePixel = 0
    circle.Parent = screenGui

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(1, 0)
    corner.Parent = circle

    local label = Instance.new("TextLabel")
    label.Size = UDim2.fromOffset(120, 36)
    label.Position = UDim2.fromOffset(ix + 18, iy - 10)
    label.BackgroundTransparency = 1
    label.TextColor3 = Color3.fromRGB(255, 255, 0)
    label.TextSize = 11
    label.Text = string.format("GUI:(%d,%d)\nVIM:(%d,%d)", ix, iy, vx, vy)
    label.Parent = screenGui

    return screenGui
end

-- ============================================================
-- CLICK PRINCIPAL
-- ============================================================
local function clickElement(elemento)
    if not elemento then
        warn("Elemento não encontrado!")
        return false
    end

    task.wait(0.1)

    local ix, iy, vx, vy = getCoords(elemento)
    print("Clicando:", elemento.Name, "| GUI:("..ix..","..iy..") VIM:("..vx..","..vy..") | mobile:", isMobile)

    local indicator = mostrarIndicador(ix, iy, vx, vy)
    task.wait(0.2)

    local success = false

    if isMobile then
        -- ESTRATÉGIA 1: Touch nativo com coordenadas VIM
        local ok1 = pcall(function()
            VirtualInputManager:SendTouchEvent(0, Enum.UserInputState.Begin, vx, vy, game)
            task.wait(0.15)
            VirtualInputManager:SendTouchEvent(0, Enum.UserInputState.End, vx, vy, game)
        end)

        if ok1 then
            print("Touch nativo: OK")
            success = true
        else
            warn("Touch nativo falhou, tentando mouse fallback...")

            -- ESTRATÉGIA 2: Mouse simulado
            local ok2 = pcall(function()
                VirtualInputManager:SendMouseMoveEvent(vx, vy, game)
                task.wait(0.05)
                VirtualInputManager:SendMouseButtonEvent(vx, vy, 0, true, game, 0)
                task.wait(0.1)
                VirtualInputManager:SendMouseButtonEvent(vx, vy, 0, false, game, 0)
            end)

            if ok2 then
                print("Mouse fallback: OK")
                success = true
            else
                warn("Mouse fallback falhou, tentando Activate direto...")

                -- ESTRATÉGIA 3: Activate direto no botão
                local ok3 = pcall(function()
                    if elemento:IsA("GuiButton") then
                        elemento:Activate()
                    elseif elemento:FindFirstChildWhichIsA("GuiButton") then
                        elemento:FindFirstChildWhichIsA("GuiButton"):Activate()
                    end
                end)

                if ok3 then
                    print("Activate: OK")
                    success = true
                else
                    warn("Todas as estratégias falharam para: " .. elemento.Name)
                end
            end
        end
    else
        -- PC: Mouse normal com coordenadas VIM
        local ok, err = pcall(function()
            VirtualInputManager:SendMouseMoveEvent(vx, vy, game)
            task.wait(0.05)
            VirtualInputManager:SendMouseButtonEvent(vx, vy, 0, true, game, 0)
            task.wait(0.1)
            VirtualInputManager:SendMouseButtonEvent(vx, vy, 0, false, game, 0)
        end)
        print("Mouse click PC:", ok, err)
        success = ok
    end

    task.wait(0.3)
    indicator:Destroy()

    return success
end

-- ============================================================
-- FUNÇÃO DE BUSCA E USO DE ITEM (com retry)
-- ============================================================
local function useItem(itemName, searchBox, itemGrid, UseButton, maxRetries)
    maxRetries = maxRetries or 3

    for tentativa = 1, maxRetries do
        print(string.format("Tentativa %d/%d para: %s", tentativa, maxRetries, itemName))

        searchBox.Text = itemName
        task.wait(1.2)

        local item = itemGrid["Item\n" .. itemName]

        if item then
            clickElement(item.Button or item)
            task.wait(0.5)
            clickElement(UseButton)
            task.wait(0.5)
            print("Item usado com sucesso:", itemName)
            return true
        else
            warn(string.format("'%s' não encontrado no grid (tentativa %d)", itemName, tentativa))
        end

        if tentativa < maxRetries then
            task.wait(0.5)
        end
    end

    warn("Falhou após " .. maxRetries .. " tentativas: " .. itemName)
    return false
end

-- ============================================================
-- MAIN
-- ============================================================
local MainUI = Player.PlayerGui:WaitForChild("MainInterface", 10)
if not MainUI then
    warn("MainInterface não encontrada!")
    return
end

local Inventory = MainUI:WaitForChild("Inventory", 10)
local UseButton  = Inventory.Index.ItemIndex.UseHolder.UseButton
local searchBox  = Inventory.Items.Search.Content
local itemGrid   = Inventory.Items.ItemGrid.ItemGridScrollingFrame

print("Iniciando sequencia")

Inventory.Visible = true
task.wait(1)

clickElement(Inventory.Items.ItemsTab)
task.wait(0.7)

useItem("Strange Controller", searchBox, itemGrid, UseButton)
searchBox.Text = ""
task.wait(0.3)

useItem("Biome Randomizer", searchBox, itemGrid, UseButton)
searchBox.Text = ""
task.wait(0.3)

Inventory.Visible = false
print("Finalizado")
