local VirtualInputManager = game:GetService("VirtualInputManager")
local Players = game:GetService("Players")
local GuiService = game:GetService("GuiService")
local UIS = game:GetService("UserInputService")
local Player = Players.LocalPlayer
local Cam = workspace.CurrentCamera

local isMobile = UIS.TouchEnabled and not UIS.MouseEnabled

-- ============================================================
-- ESTRATÉGIA DEFINITIVA:
-- Tanto o indicador quanto o VIM usam coordenadas de viewport (pixel 0,0 real).
-- Para isso:
--   1. Pegamos AbsolutePosition (coordenadas lógicas, após inset)
--   2. Somamos o inset para ter coordenadas reais da tela
--   3. Aplicamos a escala viewport/logical para converter pra pixels físicos
--   4. O indicador usa IgnoreGuiInset=true com essas mesmas coordenadas físicas
--   5. O VIM recebe essas mesmas coordenadas físicas
-- Resultado: indicador e click vão pro MESMO pixel.
-- ============================================================

-- Calcula escala uma vez só na inicialização
local function calcScale()
    local viewport = Cam.ViewportSize

    -- Cria ScreenGui temporária com IgnoreGuiInset=true para medir o tamanho lógico real
    local sg = Instance.new("ScreenGui")
    sg.IgnoreGuiInset = true
    sg.Parent = game.CoreGui
    local f = Instance.new("Frame")
    f.Size = UDim2.fromScale(1, 1)
    f.Parent = sg
    local logical = f.AbsoluteSize
    sg:Destroy()

    local sx = viewport.X / logical.X
    local sy = viewport.Y / logical.Y

    print(string.format("[INIT] Viewport:(%.0f,%.0f) Logical:(%.0f,%.0f) Scale:(%.4f,%.4f)",
        viewport.X, viewport.Y, logical.X, logical.Y, sx, sy))

    return sx, sy
end

local SCALE_X, SCALE_Y = calcScale()
local INSET = GuiService:GetGuiInset()

-- ============================================================
-- Converte AbsolutePosition para coordenadas físicas do viewport
-- (o que tanto o indicador IgnoreGuiInset=true quanto o VIM entendem)
-- ============================================================
local function toPhysical(ax, ay)
    -- AbsolutePosition já inclui o inset internamente quando IgnoreGuiInset=false
    -- Mas para coordenadas físicas reais precisamos somar o inset e escalar
    local px = math.floor((ax + INSET.X) * SCALE_X)
    local py = math.floor((ay + INSET.Y) * SCALE_Y)
    return px, py
end

-- ============================================================
-- INDICADOR VISUAL
-- USA IgnoreGuiInset=true e coordenadas físicas — igual ao VIM
-- ============================================================
local function mostrarIndicador(px, py)
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "ClickIndicator"
    screenGui.ResetOnSpawn = false
    screenGui.IgnoreGuiInset = true  -- coordenadas físicas do pixel 0,0
    screenGui.Parent = game.CoreGui

    -- Como o indicador usa IgnoreGuiInset=true mas a posição está em pixels físicos,
    -- precisamos dividir pela escala para posicionar corretamente em pixels lógicos
    local lx = px / SCALE_X
    local ly = py / SCALE_Y

    local circle = Instance.new("Frame")
    circle.Size = UDim2.fromOffset(30, 30)
    circle.Position = UDim2.fromOffset(lx, ly)
    circle.AnchorPoint = Vector2.new(0.5, 0.5)
    circle.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    circle.BackgroundTransparency = 0.3
    circle.BorderSizePixel = 0
    circle.Parent = screenGui

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(1, 0)
    corner.Parent = circle

    local label = Instance.new("TextLabel")
    label.Size = UDim2.fromOffset(100, 20)
    label.Position = UDim2.fromOffset(lx + 18, ly - 10)
    label.BackgroundTransparency = 1
    label.TextColor3 = Color3.fromRGB(255, 255, 0)
    label.TextSize = 11
    label.Text = string.format("(%d,%d)", px, py)
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

    local pos  = elemento.AbsolutePosition
    local size = elemento.AbsoluteSize
    local cx   = pos.X + (size.X / 2)
    local cy   = pos.Y + (size.Y / 2)

    -- Converte para físico (mesmo sistema do VIM e do indicador)
    local px, py = toPhysical(cx, cy)

    print(string.format("Clicando: %s | Logico:(%.0f,%.0f) Fisico:(%d,%d) | mobile:%s",
        elemento.Name, cx, cy, px, py, tostring(isMobile)))

    local indicator = mostrarIndicador(px, py)
    task.wait(0.2)

    local success = false

    if isMobile then
        -- ESTRATÉGIA 1: Touch nativo
        local ok1 = pcall(function()
            VirtualInputManager:SendTouchEvent(0, Enum.UserInputState.Begin, px, py, game)
            task.wait(0.15)
            VirtualInputManager:SendTouchEvent(0, Enum.UserInputState.End, px, py, game)
        end)

        if ok1 then
            print("Touch: OK")
            success = true
        else
            -- ESTRATÉGIA 2: Mouse simulado
            local ok2 = pcall(function()
                VirtualInputManager:SendMouseMoveEvent(px, py, game)
                task.wait(0.05)
                VirtualInputManager:SendMouseButtonEvent(px, py, 0, true, game, 0)
                task.wait(0.1)
                VirtualInputManager:SendMouseButtonEvent(px, py, 0, false, game, 0)
            end)

            if ok2 then
                print("Mouse fallback: OK")
                success = true
            else
                -- ESTRATÉGIA 3: Activate direto
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
                    warn("Todas as estratégias falharam: " .. elemento.Name)
                end
            end
        end
    else
        -- PC
        local ok, err = pcall(function()
            VirtualInputManager:SendMouseMoveEvent(px, py, game)
            task.wait(0.05)
            VirtualInputManager:SendMouseButtonEvent(px, py, 0, true, game, 0)
            task.wait(0.1)
            VirtualInputManager:SendMouseButtonEvent(px, py, 0, false, game, 0)
        end)
        print("Mouse PC:", ok, err)
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
        print(string.format("Tentativa %d/%d: %s", tentativa, maxRetries, itemName))

        searchBox.Text = itemName
        task.wait(1.2)

        local item = itemGrid["Item\n" .. itemName]

        if item then
            clickElement(item.Button or item)
            task.wait(0.5)
            clickElement(UseButton)
            task.wait(0.5)
            print("Usado:", itemName)
            return true
        else
            warn("Nao encontrado: " .. itemName .. " (tentativa " .. tentativa .. ")")
        end

        if tentativa < maxRetries then
            task.wait(0.5)
        end
    end

    warn("Falhou apos " .. maxRetries .. " tentativas: " .. itemName)
    return false
end

-- ============================================================
-- MAIN
-- ============================================================
local MainUI = Player.PlayerGui:WaitForChild("MainInterface", 10)
if not MainUI then warn("MainInterface nao encontrada!") return end

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
