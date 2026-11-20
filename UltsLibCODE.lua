-- ============================================================
-- ULTS LIB v2 - COMPLETA POR RCCDEV
-- ============================================================

local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local playerGui = Players.LocalPlayer:WaitForChild("PlayerGui")
local targetParent = (gethui and gethui()) or CoreGui or playerGui

if targetParent:FindFirstChild("UltsLibsTEST") then
	targetParent.UltsLibsTEST:Destroy()
end

-- ============================================================
-- LISTA DE 8 TEMAS OFICIAIS
-- ============================================================
local Themes = {
	["preto"] = {
		Main = Color3.fromRGB(25, 25, 25),
		TopBar = Color3.fromRGB(18, 18, 18),
		Accent = Color3.fromRGB(45, 45, 45),
		Text = Color3.fromRGB(255, 255, 255)
	},
	["branco"] = {
		Main = Color3.fromRGB(235, 235, 235),
		TopBar = Color3.fromRGB(215, 215, 215),
		Accent = Color3.fromRGB(255, 255, 255),
		Text = Color3.fromRGB(20, 20, 20)
	},
	["cinza"] = {
		Main = Color3.fromRGB(55, 58, 64),
		TopBar = Color3.fromRGB(42, 45, 50),
		Accent = Color3.fromRGB(85, 90, 98),
		Text = Color3.fromRGB(255, 255, 255)
	},
	["azul"] = {
		Main = Color3.fromRGB(20, 28, 45),
		TopBar = Color3.fromRGB(14, 20, 35),
		Accent = Color3.fromRGB(35, 85, 175),
		Text = Color3.fromRGB(255, 255, 255)
	},
	["vermelho"] = {
		Main = Color3.fromRGB(45, 18, 18),
		TopBar = Color3.fromRGB(32, 12, 12),
		Accent = Color3.fromRGB(190, 40, 40),
		Text = Color3.fromRGB(255, 255, 255)
	},
	["ciano"] = {
		Main = Color3.fromRGB(16, 38, 44),
		TopBar = Color3.fromRGB(11, 27, 32),
		Accent = Color3.fromRGB(25, 155, 175),
		Text = Color3.fromRGB(255, 255, 255)
	},
	["carmim"] = {
		Main = Color3.fromRGB(38, 12, 20),
		TopBar = Color3.fromRGB(26, 8, 14),
		Accent = Color3.fromRGB(140, 20, 50),
		Text = Color3.fromRGB(255, 255, 255)
	},
	["verde"] = {
		Main = Color3.fromRGB(18, 38, 24),
		TopBar = Color3.fromRGB(12, 26, 16),
		Accent = Color3.fromRGB(35, 145, 65),
		Text = Color3.fromRGB(255, 255, 255)
	}
}

local CurrentTheme = Themes["preto"]
local ThemedElements = {}

local function GetContrastText(color)
	local brightness = (color.R * 0.299) + (color.G * 0.587) + (color.B * 0.114)
	return brightness > 0.6 and Color3.fromRGB(0, 0, 0) or Color3.fromRGB(255, 255, 255)
end

local function ResolveColor(colorParam)
	if colorParam == true or colorParam == nil then
		return CurrentTheme.Accent, true
	elseif typeof(colorParam) == "Color3" then
		return colorParam, false
	elseif type(colorParam) == "table" and colorParam.CustomColor then
		return colorParam.CustomColor, false
	end
	return CurrentTheme.Accent, true
end

-- ============================================================
-- INTERFACE BASE
-- ============================================================
local UltsLibsTEST = Instance.new("ScreenGui")
UltsLibsTEST.Name = "UltsLibsTEST"
UltsLibsTEST.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
UltsLibsTEST.ResetOnSpawn = false

local Main = Instance.new("Frame")
Main.Name = "Main"
Main.BackgroundColor3 = CurrentTheme.Main
Main.BackgroundTransparency = 0.12
Main.BorderSizePixel = 0
Main.Position = UDim2.new(0.25, 0, 0.2, 0)
Main.Size = UDim2.new(0, 571, 0, 382)
Main.ClipsDescendants = true
Main.Parent = UltsLibsTEST

local UICornerMain = Instance.new("UICorner")
UICornerMain.Parent = Main

local UIDragDetector = Instance.new("UIDragDetector")
UIDragDetector.Parent = Main

-- Barra Superior
local MainTASB = Instance.new("Frame")
MainTASB.Name = "MainTASB"
MainTASB.BackgroundColor3 = CurrentTheme.TopBar
MainTASB.BackgroundTransparency = 0.05
MainTASB.BorderSizePixel = 0
MainTASB.Position = UDim2.new(0, 0, 0, 0)
MainTASB.Size = UDim2.new(0, 571, 0, 32)
MainTASB.Parent = Main

local UICornerTop = Instance.new("UICorner")
UICornerTop.Parent = MainTASB

local NameLabel = Instance.new("TextLabel")
NameLabel.Name = "Name"
NameLabel.BackgroundTransparency = 1
NameLabel.Font = Enum.Font.DenkOne
NameLabel.Position = UDim2.new(0.02, 0, 0, 0)
NameLabel.Size = UDim2.new(0, 240, 0, 32)
NameLabel.Text = "Ults Lib"
NameLabel.TextColor3 = CurrentTheme.Text
NameLabel.TextScaled = true
NameLabel.TextXAlignment = Enum.TextXAlignment.Left
NameLabel.Parent = MainTASB

local NameTIP = Instance.new("TextLabel")
NameTIP.Name = "NameTIP"
NameTIP.BackgroundTransparency = 1
NameTIP.Font = Enum.Font.DenkOne
NameTIP.Position = UDim2.new(0.48, 0, 0.125, 0)
NameTIP.Size = UDim2.new(0, 230, 0, 23)
NameTIP.Text = "v2"
NameTIP.TextColor3 = Color3.fromRGB(130, 130, 130)
NameTIP.TextScaled = true
NameTIP.TextXAlignment = Enum.TextXAlignment.Right
NameTIP.Parent = MainTASB

-- Botão de Minimizar (-) na barra superior
local MinBtn = Instance.new("TextButton")
MinBtn.Name = "Minimize"
MinBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
MinBtn.BackgroundTransparency = 0.5
MinBtn.Position = UDim2.new(0.925, 0, 0.125, 0)
MinBtn.Size = UDim2.new(0, 32, 0, 24)
MinBtn.Font = Enum.Font.SourceSansBold
MinBtn.Text = "-"
MinBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
MinBtn.TextSize = 20
MinBtn.Parent = MainTASB

local MinCorner = Instance.new("UICorner")
MinCorner.CornerRadius = UDim.new(0, 6)
MinCorner.Parent = MinBtn

local minimized = false
MinBtn.MouseButton1Click:Connect(function()
	minimized = not minimized
	if minimized then
		Main.Size = UDim2.new(0, 571, 0, 32)
		MinBtn.Text = "+"
	else
		Main.Size = UDim2.new(0, 571, 0, 382)
		MinBtn.Text = "-"
	end
end)

-- Menu Lateral (Tabs)
local Tabs = Instance.new("ScrollingFrame")
Tabs.Name = "Tabs"
Tabs.Active = true
Tabs.BackgroundColor3 = CurrentTheme.TopBar
Tabs.BackgroundTransparency = 0.25
Tabs.BorderSizePixel = 0
Tabs.Position = UDim2.new(0.025698, 0, 0.109631, 0)
Tabs.ScrollBarThickness = 2
Tabs.Size = UDim2.new(0, 104, 0, 315)
Tabs.AutomaticCanvasSize = Enum.AutomaticSize.Y
Tabs.CanvasSize = UDim2.new(0, 0, 0, 0)
Tabs.Parent = Main

local UICornerTabs = Instance.new("UICorner")
UICornerTabs.Parent = Tabs

local TabsPadding = Instance.new("UIPadding")
TabsPadding.PaddingTop = UDim.new(0, 6)
TabsPadding.PaddingBottom = UDim.new(0, 6)
TabsPadding.PaddingLeft = UDim.new(0, 5)
TabsPadding.PaddingRight = UDim.new(0, 5)
TabsPadding.Parent = Tabs

local TabsLayout = Instance.new("UIListLayout")
TabsLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
TabsLayout.HorizontalFlex = Enum.UIFlexAlignment.Fill
TabsLayout.Padding = UDim.new(0, 8)
TabsLayout.SortOrder = Enum.SortOrder.LayoutOrder
TabsLayout.Parent = Tabs

local PagesFolder = Instance.new("Folder")
PagesFolder.Name = "Pages"
PagesFolder.Parent = Main

UltsLibsTEST.Parent = targetParent

local function ApplyTheme(themeName)
	local selected = Themes[tostring(themeName):lower()]
	if not selected then
		warn("UltsLib: Tema '" .. tostring(themeName) .. "' não encontrado!")
		return
	end
	CurrentTheme = selected
	Main.BackgroundColor3 = CurrentTheme.Main
	MainTASB.BackgroundColor3 = CurrentTheme.TopBar
	Tabs.BackgroundColor3 = CurrentTheme.TopBar
	NameLabel.TextColor3 = CurrentTheme.Text

	for _, p in ipairs(PagesFolder:GetChildren()) do
		if p:IsA("ScrollingFrame") then
			p.BackgroundColor3 = CurrentTheme.TopBar
		end
	end

	for _, item in ipairs(ThemedElements) do
		if item and item.Parent then
			item.BackgroundColor3 = CurrentTheme.Accent
			if item:IsA("TextButton") or item:IsA("TextLabel") then
				item.TextColor3 = GetContrastText(CurrentTheme.Accent)
			end
		end
	end
end

-- ============================================================
-- AMBIENTE GLOBAL E PALAVRAS-CHAVE
-- ============================================================
local CreatedTabs = {}
local firstTab = true

local env = getgenv and getgenv() or _G
env.Title = "title"
env.SubTitle = "subtitle"
env.Theme = "theme"
env.Tab = "tab"
env.Button = "button"
env.Toggle = "toggle"
env.TextBox = "textbox"
env.Label = "label"

env.False = function(r, g, b)
	return { CustomColor = Color3.fromRGB(r or 255, g or 255, b or 255) }
end
env.Custom = env.False

local UltsLib = {}

setmetatable(UltsLib, {
	__call = function(self, tipo, arg1, arg2, arg3, arg4, arg5)
		local cmd = tostring(tipo):lower()

		-- 1. TÍTULO
		if cmd == "title" then
			NameLabel.Text = tostring(arg1)

		-- 2. SUBTÍTULO
		elseif cmd == "subtitle" then
			NameTIP.Text = tostring(arg1)

		-- 3. TEMA
		elseif cmd == "theme" then
			ApplyTheme(arg1)

		-- 4. CRIAR TAB: UltsLib(Tab, "Main", true)
		elseif cmd == "tab" then
			local tabName = tostring(arg1)
			local btnColor, followTheme = ResolveColor(arg2)

			local TabBtn = Instance.new("TextButton")
			TabBtn.Name = tabName
			TabBtn.BackgroundColor3 = btnColor
			TabBtn.BorderSizePixel = 0
			TabBtn.Font = Enum.Font.SourceSansBold
			TabBtn.Size = UDim2.new(0, 94, 0, 38)
			TabBtn.Text = tabName
			TabBtn.TextColor3 = GetContrastText(btnColor)
			TabBtn.TextSize = 14
			TabBtn.Parent = Tabs

			if followTheme then table.insert(ThemedElements, TabBtn) end

			local BtnCorner = Instance.new("UICorner")
			BtnCorner.Parent = TabBtn

			local Page = Instance.new("ScrollingFrame")
			Page.Name = tabName .. "_Page"
			Page.Active = true
			Page.BackgroundColor3 = CurrentTheme.TopBar
			Page.BackgroundTransparency = 0.25
			Page.BorderSizePixel = 0
			Page.Position = UDim2.new(0.239359, 0, 0.109631, 0)
			Page.ScrollBarThickness = 4
			Page.Size = UDim2.new(0, 416, 0, 315)
			Page.AutomaticCanvasSize = Enum.AutomaticSize.Y
			Page.CanvasSize = UDim2.new(0, 0, 0, 0)
			Page.Visible = firstTab
			Page.Parent = PagesFolder

			local PageCorner = Instance.new("UICorner")
			PageCorner.Parent = Page

			-- Margem interna para os botões não encostarem na borda
			local PagePadding = Instance.new("UIPadding")
			PagePadding.PaddingTop = UDim.new(0, 8)
			PagePadding.PaddingBottom = UDim.new(0, 8)
			PagePadding.PaddingLeft = UDim.new(0, 8)
			PagePadding.PaddingRight = UDim.new(0, 8)
			PagePadding.Parent = Page

			local PageLayout = Instance.new("UIListPageLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
PageLayout.HorizontalFlex = Enum.UIFlexAlignment.Fill
PageLayout.Padding = UDim.new(0, 8)
PageLayout.SortOrder = Enum.SortOrder.LayoutOrder
PageLayout.Parent = Page
if firstTab then firstTab = false end
TabBtn.MouseButton1Click:Connect(function()
for _, p in ipairs(PagesFolder:GetChildren()) do
if p:IsA("ScrollingFrame") then p.Visible = false end
end
Page.Visible = true
end)
CreatedTabs[tabName] = Page
-- 5. CRIAR BUTTON: UltsLib(Button, "Nome", "Tab", true, function() end)
elseif cmd == "button" then
local targetPage = CreatedTabs[tostring(arg2)]
if not targetPage then return warn("UltsLib: Tab '" .. tostring(arg2) .. "' não encontrada!") end
local btnColor, followTheme = ResolveColor(arg3)
local callback = type(arg4) == "function" and arg4 or (type(arg4) == "table" and arg4.Callback) or function() end
local Button = Instance.new("TextButton")
Button.Name = tostring(arg1)
Button.BackgroundColor3 = btnColor
Button.BorderSizePixel = 0
Button.Font = Enum.Font.SourceSansBold
Button.Size = UDim2.new(0, 400, 0, 42)
Button.Text = tostring(arg1)
Button.TextColor3 = GetContrastText(btnColor)
Button.TextSize = 15
Button.Parent = targetPage
if followTheme then table.insert(ThemedElements, Button) end
local UICorner = Instance.new("UICorner")
UICorner.Parent = Button
Button.MouseButton1Click:Connect(callback)
-- 6. CRIAR TOGGLE: UltsLib(Toggle, "Nome", "Tab", true, function(estado) end)
elseif cmd == "toggle" then
local targetPage = CreatedTabs[tostring(arg2)]
if not targetPage then return warn("UltsLib: Tab '" .. tostring(arg2) .. "' não encontrada!") end
local btnColor, followTheme = ResolveColor(arg3)
local callback = type(arg4) == "function" and arg4 or (type(arg4) == "table" and arg4.Callback) or function() end
local state = false
local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Name = tostring(arg1)
ToggleBtn.BackgroundColor3 = btnColor
ToggleBtn.BorderSizePixel = 0
ToggleBtn.Font = Enum.Font.SourceSansBold
ToggleBtn.Size = UDim2.new(0, 400, 0, 42)
ToggleBtn.Text = "  " .. tostring(arg1)
ToggleBtn.TextColor3 = GetContrastText(btnColor)
ToggleBtn.TextSize = 15
ToggleBtn.TextXAlignment = Enum.TextXAlignment.Left
ToggleBtn.Parent = targetPage
if followTheme then table.insert(ThemedElements, ToggleBtn) end
local UICorner = Instance.new("UICorner")
UICorner.Parent = ToggleBtn
-- Quadradinho indicador (Vermelho = OFF, Verde = ON)
local Indicator = Instance.new("Frame")
Indicator.Name = "Status"
Indicator.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
Indicator.Position = UDim2.new(0.89, 0, 0.2, 0)
Indicator.Size = UDim2.new(0, 32, 0, 25)
Indicator.Parent = ToggleBtn
local IndCorner = Instance.new("UICorner")
IndCorner.CornerRadius = UDim.new(0, 6)
IndCorner.Parent = Indicator
ToggleBtn.MouseButton1Click:Connect(function()
state = not state
Indicator.BackgroundColor3 = state and Color3.fromRGB(50, 200, 80) or Color3.fromRGB(200, 50, 50)
callback(state)
end)
-- 7. CRIAR TEXTBOX: UltsLib(TextBox, "Placeholder", "Tab", true, function(texto) end)
elseif cmd == "textbox" then
local targetPage = CreatedTabs[tostring(arg2)]
if not targetPage then return warn("UltsLib: Tab '" .. tostring(arg2) .. "' não encontrada!") end
local boxColor, followTheme = ResolveColor(arg3)
local callback = type(arg4) == "function" and arg4 or (type(arg4) == "table" and arg4.Callback) or function() end
local Box = Instance.new("TextBox")
Box.Name = tostring(arg1)
Box.BackgroundColor3 = boxColor
Box.BorderSizePixel = 0
Box.Font = Enum.Font.SourceSansBold
Box.Size = UDim2.new(0, 400, 0, 42)
Box.PlaceholderText = tostring(arg1)
Box.Text = ""
Box.TextColor3 = GetContrastText(boxColor)
Box.PlaceholderColor3 = Color3.fromRGB(160, 160, 160)
Box.TextSize = 15
Box.ClearTextOnFocus = false
Box.Parent = targetPage
if followTheme then table.insert(ThemedElements, Box) end
local UICorner = Instance.new("UICorner")
UICorner.Parent = Box
Box.FocusLost:Connect(function(enterPressed)
if enterPressed then
callback(Box.Text)
end
end)
-- 8. CRIAR LABEL (TEXTO/TÍTULO DE SEÇÃO): UltsLib(Label, "Texto", "Tab", true)
elseif cmd == "label" then
local targetPage = CreatedTabs[tostring(arg2)]
if not targetPage then return warn("UltsLib: Tab '" .. tostring(arg2) .. "' não encontrada!") end
local lblColor, followTheme = ResolveColor(arg3)
local Lbl = Instance.new("TextLabel")
Lbl.Name = tostring(arg1)
Lbl.BackgroundColor3 = lblColor
Lbl.BackgroundTransparency = 0.5
Lbl.BorderSizePixel = 0
Lbl.Font = Enum.Font.DenkOne
Lbl.Size = UDim2.new(0, 400, 0, 30)
Lbl.Text = tostring(arg1)
Lbl.TextColor3 = GetContrastText(lblColor)
Lbl.TextSize = 15
Lbl.Parent = targetPage
if followTheme then table.insert(ThemedElements, Lbl) end
local UICorner = Instance.new("UICorner")
UICorner.Parent = Lbl
end
end
})
return UltsLibLayout")
