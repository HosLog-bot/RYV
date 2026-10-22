
-- KopoLib Update Required
-- LocalScript

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")

local Player = Players.LocalPlayer
local DiscordURL = "https://discord.gg/fuyBwjdZQv"
local CountdownTime = 20

local gui = Instance.new("ScreenGui")
gui.Name = "KopoLibUpdate"
gui.IgnoreGuiInset = true
gui.ResetOnSpawn = false
gui.DisplayOrder = 999999
gui.Parent = Player:WaitForChild("PlayerGui")

local overlay = Instance.new("Frame")
overlay.Size = UDim2.fromScale(1, 1)
overlay.BackgroundColor3 = Color3.fromRGB(22, 18, 14)
overlay.BackgroundTransparency = 1
overlay.Parent = gui

local card = Instance.new("Frame")
card.AnchorPoint = Vector2.new(0.5, 0.5)
card.Position = UDim2.fromScale(0.5, 0.55)
card.Size = UDim2.fromOffset(400, 280)
card.BackgroundColor3 = Color3.fromRGB(43, 36, 29)
card.BorderSizePixel = 0
card.Parent = overlay

Instance.new("UICorner", card).CornerRadius = UDim.new(0, 14)

local border = Instance.new("UIStroke")
border.Color = Color3.fromRGB(158, 108, 62)
border.Thickness = 1.5
border.Parent = card

local function makeLabel(text, size, pos, dimensions, color, font)
    local label = Instance.new("TextLabel")
    label.BackgroundTransparency = 1
    label.Position = pos
    label.Size = dimensions
    label.Text = text
    label.TextSize = size
    label.TextColor3 = color
    label.Font = font or Enum.Font.Gotham
    label.TextWrapped = true
    label.Parent = card
    return label
end

makeLabel(
    "RYV Client",
    12,
    UDim2.new(0, 25, 0, 17),
    UDim2.new(1, -50, 0, 20),
    Color3.fromRGB(197, 159, 112),
    Enum.Font.GothamBold
)

makeLabel(
    "Atualização obrigatória",
    23,
    UDim2.new(0, 20, 0, 44),
    UDim2.new(1, -40, 0, 38),
    Color3.fromRGB(250, 241, 225),
    Enum.Font.GothamBold
)

makeLabel(
    "Esta versão da RYV Client está desatualizada. Entre na comunidade para obter a versão atual.",
    13,
    UDim2.new(0, 30, 0, 91),
    UDim2.new(1, -60, 0, 48),
    Color3.fromRGB(211, 198, 179)
)

local link = Instance.new("TextButton")
link.Position = UDim2.new(0, 28, 0, 153)
link.Size = UDim2.new(1, -56, 0, 43)
link.BackgroundColor3 = Color3.fromRGB(158, 108, 62)
link.Text = "Copiar link do Discord"
link.TextColor3 = Color3.fromRGB(255, 248, 236)
link.Font = Enum.Font.GothamBold
link.TextSize = 14
link.Parent = card

Instance.new("UICorner", link).CornerRadius = UDim.new(0, 8)

link.Activated:Connect(function()
    -- Clipboard só funciona em alguns ambientes de execução.
    local copied = false

    if type(setclipboard) == "function" then
        copied = pcall(setclipboard, DiscordURL)
    end

    if copied then
        link.Text = "Link copiado!"
    else
        link.Text = DiscordURL
    end
end)

local timer = makeLabel(
    "",
    13,
    UDim2.new(0, 20, 0, 211),
    UDim2.new(1, -40, 0, 25),
    Color3.fromRGB(197, 159, 112),
    Enum.Font.GothamMedium
)

TweenService:Create(
    overlay,
    TweenInfo.new(0.3),
    {BackgroundTransparency = 0.12}
):Play()

TweenService:Create(
    card,
    TweenInfo.new(0.35, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
    {Position = UDim2.fromScale(0.5, 0.5)}
):Play()

for seconds = CountdownTime, 1, -1 do
    timer.Text = ("Desconectando em %ds..."):format(seconds)
    task.wait(1)
end

Player:Kick(
    "KopoLib desatualizada!\nEntre no Discord para obter a versão atual:\n"
    .. DiscordURL
)
