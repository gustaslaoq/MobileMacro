local VirtualInputManager = game:GetService("VirtualInputManager")
local Players = game:GetService("Players")
local GuiService = game:GetService("GuiService")
local UIS = game:GetService("UserInputService")
local Player = Players.LocalPlayer
local Cam = workspace.CurrentCamera

local isMobile = UIS.TouchEnabled and not UIS.MouseEnabled

-- ============================================================
-- DETECÇÃO DE INSET: verifica se a ScreenGui pai ignora inset
-- ============================================================
local function getParentScreenGui(elemento)
    local parent = elemento
    while parent do
        if parent:IsA("ScreenGui") then
            return parent
        end
        parent = parent.Parent
    end
    return nil
end

-- ============================================================
-- CALCULO DE COORDENADAS COM MÚLTIPLAS ESTRATÉGIAS
-- ============================================================
local function getScreenCoords(elemento)
    local pos = elemento.AbsolutePosition
    local size = elemento.AbsoluteSize
    local inset = GuiService:GetGuiInset()

    local x_center = pos.X + (size.X / 2)
    local y_center = pos.Y + (size.Y / 2)

    local parentGui = getParentScreenGui(elemento)
    local ignoresInset = parentGui and parentGui.IgnoreGuiInset or false

    -- Se a GUI NÃO ignora o inset, o AbsolutePosition já começa abaixo
    -- do inset (ex: abaixo da top bar). Nesse caso NÃO somamos o inset.
    -- Se a GUI IGNORA o inset, o AbsolutePosition começa do pixel (0,0)
    -- real da tela, então SOMAMOS apenas o Y (top bar = 36px geralmente).
    local x_final = x_center
    local y_final = y_center

    if ignoresInset then
        -- A GUI vai de (0,0) até o fim da tela, sem deslocamento.
        -- Não soma nada, as coordenadas já são absolutas.
        x_final = x_center
        y_final = y_center
    else
        -- A GUI começa APÓS o inset. O AbsolutePosition já considera isso,
        -- então para coordenadas de tela reais, somamos o inset.
        x_final = x_center + inset.X
        y_final = y_center + inset.Y
    end

    print(string.format(
        "[DEBUG] Elemento: %s | AbsPos: (%.0f, %.0f) | Size: (%.0f, %.0f) | Inset: (%.0f, %.0f) | IgnoreInset: %s | Final: (%.0f, %.0f)",
        elemento.Name,
        pos.X, pos.Y,
        size.X, size.Y,
        inset.X, inset.Y,
        tostring(ignoresInset),
        x_final, y_final
    ))

    return math.floor(x_final), math.floor(y_final)
end

-- ============================================================
-- INDICADOR VISUAL (círculo vermelho no ponto clicado)
-- ============================================================
local function mostrarIndicador(x, y)
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "ClickIndicator"
    screenGui.ResetOnSpawn = false
    screenGui.IgnoreGuiInset = true -- sempre em coordenadas reais
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

    -- Label com as coordenadas para debug
    local label = Instance.new("TextLabel")
    label.Size = UDim2.fromOffset(80, 20)
    label.Position = UDim2.fromOffset(x + 18, y - 10)
    label.BackgroundTransparency = 1
    label.TextColor3 = Color3.fromRGB(255, 255, 0)
    label.TextSize = 12
    label.Text = string.format("(%d,%d)", x, y)
    label.Parent = screenGui

    return screenGui
end

-- ============================================================
-- CLICK PRINCIPAL COM FALLBACK EM CAMADAS
-- ============================================================
local function clickElement(elemento)
    if not elemento then
        warn("Elemento não encontrado!")
        return false
    end

    task.wait(0.1)

    local x, y = getScreenCoords(elemento)
    print("Clicando:", elemento.Name, "| x:", x, "y:", y, "| mobile:", isMobile)

    local indicator = mostrarIndicador(x, y)
    task.wait(0.2)

    local success = false

    if isMobile then
        -- ESTRATÉGIA 1: Touch nativo
        local ok1 = pcall(function()
            VirtualInputManager:SendTouchEvent(0, Enum.UserInputState.Begin, x, y, game)
            task.wait(0.15)
            VirtualInputManager:SendTouchEvent(0, Enum.UserInputState.End, x, y, game)
        end)

        if ok1 then
            print("Touch nativo: OK")
            success = true
        else
            warn("Touch nativo falhou, tentando mouse fallback...")

            -- ESTRATÉGIA 2: Mouse simulado (funciona em alguns mobiles)
            local ok2 = pcall(function()
                VirtualInputManager:SendMouseMoveEvent(x, y, game)
                task.wait(0.05)
                VirtualInputManager:SendMouseButtonEvent(x, y, 0, true, game, 0)
                task.wait(0.1)
                VirtualInputManager:SendMouseButtonEvent(x, y, 0, false, game, 0)
            end)

            if ok2 then
                print("Mouse fallback: OK")
                success = true
            else
                warn("Mouse fallback falhou, tentando FireButton...")

                -- ESTRATÉGIA 3: Disparo direto no botão via FireButton/Activate
                local ok3 = pcall(function()
                    -- Tenta disparar o evento de ativação diretamente no elemento
                    if elemento:IsA("GuiButton") then
                        elemento:Activate()
                    elseif elemento:FindFirstChildWhichIsA("GuiButton") then
                        elemento:FindFirstChildWhichIsA("GuiButton"):Activate()
                    end
                end)

                if ok3 then
                    print("FireButton/Activate: OK")
                    success = true
                else
                    warn("Todas as estratégias falharam para: " .. elemento.Name)
                end
            end
        end
    else
        -- PC: Mouse normal
        local ok, err = pcall(function()
            VirtualInputManager:SendMouseMoveEvent(x, y, game)
            task.wait(0.05)
            VirtualInputManager:SendMouseButtonEvent(x, y, 0, true, game, 0)
            task.wait(0.1)
            VirtualInputManager:SendMouseButtonEvent(x, y, 0, false, game, 0)
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
        task.wait(1.2) -- espera o grid filtrar

        local item = itemGrid["Item\n" .. itemName]

        if item then
            local clickedItem = clickElement(item.Button or item)
            task.wait(0.5)

            if clickedItem then
                local clickedUse = clickElement(UseButton)
                task.wait(0.5)

                if clickedUse then
                    print("Item usado com sucesso:", itemName)
                    return true
                end
            end
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

local Inventory      = MainUI:WaitForChild("Inventory", 10)
local UseButton      = Inventory.Index.ItemIndex.UseHolder.UseButton
local searchBox      = Inventory.Items.Search.Content
local itemGrid       = Inventory.Items.ItemGrid.ItemGridScrollingFrame

print("Iniciando sequencia")

Inventory.Visible = true
task.wait(1)

-- Clica na aba de items
clickElement(Inventory.Items.ItemsTab)
task.wait(0.7)

-- Usa os itens
useItem("Strange Controller", searchBox, itemGrid, UseButton)
searchBox.Text = ""
task.wait(0.3)

useItem("Biome Randomizer", searchBox, itemGrid, UseButton)
searchBox.Text = ""
task.wait(0.3)

Inventory.Visible = false
print("Finalizado")
