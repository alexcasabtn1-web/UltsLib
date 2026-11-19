-- ============================================================
-- ULTS LIB v1 - SISTEMA DE TEMAS E CORES POR RCCDEV
-- ============================================================

local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local playerGui = Players.LocalPlayer:WaitForChild("PlayerGui")
local targetParent = (gethui and gethui()) or CoreGui or playerGui

if targetParent:FindFirstChild("UltsLibsTEST") then
	targetParent.UltsLibsTEST:Destroy()
end

-- ============================================================
-- LISTA DE TEMAS (Adicione quantas cores quiser aqui!)
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
	["azul"] = {
		Main = Color3.fromRGB(20, 28, 45),
		TopBar = Color3.fromRGB(14, 20, 35),
		Accent = Color3.fromRGB(35, 85, 175),
		Text = Color3.fromRGB(255, 255, 255)
	},
	["vermelho"] = {
		Main = Color3.fromRGB(40, 18, 18),
		TopBar = Color3.fromRGB(28, 12, 12),
		Accent = Color3.fromRGB(165, 35, 35),
		Text = Color3.fromRGB(255, 255, 255)
	},
	["roxo"] = {
		Main = Color3.fromRGB(32, 20, 45),
		TopBar = Color3.fromRGB(22, 14, 32),
		Accent = Color3.fromRGB(115, 45, 180),
		Text = Color3.fromRGB(255, 255, 255)
	},
	["verde"] = {
		Main = Color3.fromRGB(18, 38, 24),
		TopBar = Color3.fromRGB(12, 26, 16),
		Accent = Color3.fromRGB(35, 145, 65),
		Text = Color3.fromRGB(255, 255, 255)
	}
}

local CurrentTheme = Themes["preto"] -- Tema padrão inicial
local ThemedElements = {} -- Guarda elementos que usam 'true' para atualizar se o tema mudar

-- Função inteligente que calcula se o texto deve ser branco ou preto baseado na cor de fundo
local function GetContrastText(color)
	local brightness = (color.R * 0.299) + (color.G * 0.587) + (color.B * 0.114)
	return brightness > 0.6 and Color3.fromRGB(0, 0, 0) or Color3.fromRGB(255, 255, 255)
end

-- Resolve a cor passada pelo usuário: true -> Tema | Custom(r,g,b) -> Cor personalizada
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
Main.BackgroundTransparency = 0.15
Main.BorderSizePixel = 0
Main.Position = UDim2.new(0.25, 0, 0.2, 0)
Main.Size = UDim2.new(0, 571, 0, 382)
Main.Parent = UltsLibsTEST

local UICornerMain = Instance.new("UICorner")
UICornerMain.Parent = Main

local UIDragDetector = Instance.new("UIDragDetector")
UIDragDetector.Parent = Main

local MainTASB = Instance.new("Frame")
MainTASB.Name = "MainTASB"
MainTASB.BackgroundColor3 = CurrentTheme.TopBar
MainTASB.BackgroundTransparency = 0.1
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
NameLabel.Size = UDim2.new(0, 255, 0, 32)
NameLabel.Text = "Ults Lib"
NameLabel.TextColor3 = CurrentTheme.Text
NameLabel.TextScaled = true
NameLabel.Parent = MainTASB

local NameTIP = Instance.new("TextLabel")
NameTIP.Name = "NameTIP"
NameTIP.BackgroundTransparency = 1
NameTIP.Font = Enum.Font.DenkOne
NameTIP.Position = UDim2.new(0.548161, 0, 0.125, 0)
NameTIP.Size = UDim2.new(0, 240, 0, 23)
NameTIP.Text = "v1"
NameTIP.TextColor3 = Color3.fromRGB(120, 120, 120)
NameTIP.TextScaled = true
NameTIP.Parent = MainTASB

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

local TabsLayout = Instance.new("UIListLayout")
TabsLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
TabsLayout.HorizontalFlex = Enum.UIFlexAlignment.Fill
TabsLayout.Padding = UDim.new(0, 9)
TabsLayout.SortOrder = Enum.SortOrder.LayoutOrder
TabsLayout.Parent = Tabs

local PagesFolder = Instance.new("Folder")
PagesFolder.Name = "Pages"
PagesFolder.Parent = Main

UltsLibsTEST.Parent = targetParent

-- Função para aplicar tema em tudo que estiver marcado com 'true'
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

	for _, item in ipairs(ThemedElements) do
		if item and item.Parent then
			item.BackgroundColor3 = CurrentTheme.Accent
			if item:IsA("TextButton") then
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

-- Permite escrever False(255, 255, 255) ou Custom(255, 255, 255) sem erro de sintaxe!
env.False = function(r, g, b)
	return { CustomColor = Color3.fromRGB(r or 255, g or 255, b or 255) }
end
env.Custom = env.False

local UltsLib = {}

setmetatable(UltsLib, {
	__call = function(self, tipo, arg1, arg2, arg3, arg4)
		local cmd = tostring(tipo):lower()

		-- 1. TÍTULO: UltsLib(Title, "Meu Hub")
		if cmd == "title" then
			NameLabel.Text = tostring(arg1)

		-- 2. SUBTÍTULO: UltsLib(SubTitle, "v1.0")
		elseif cmd == "subtitle" then
			NameTIP.Text = tostring(arg1)

		-- 3. TEMA DO HUB: UltsLib(Theme, "azul")
		elseif cmd == "theme" then
			ApplyTheme(arg1)

		-- 4. CRIAR TAB: UltsLib(Tab, "Main", true) ou UltsLib(Tab, "Main", False(255, 0, 0))
		elseif cmd == "tab" then
			local tabName = tostring(arg1)
			local btnColor, followTheme = ResolveColor(arg2)

			local TabBtn = Instance.new("TextButton")
			TabBtn.Name = tabName
			TabBtn.BackgroundColor3 = btnColor
			TabBtn.BorderSizePixel = 0
			TabBtn.Font = Enum.Font.SourceSansBold
			TabBtn.Size = UDim2.new(0, 100, 0, 40)
			TabBtn.Text = tabName
			TabBtn.TextColor3 = GetContrastText(btnColor)
			TabBtn.TextSize = 14
			TabBtn.Parent = Tabs

			if followTheme then
				table.insert(ThemedElements, TabBtn)
			end

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

			local PageLayout = Instance.new("UIListLayout")
			PageLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
			PageLayout.HorizontalFlex = Enum.UIFlexAlignment.Fill
			PageLayout.Padding = UDim.new(0, 9)
			PageLayout.SortOrder = Enum.SortOrder.LayoutOrder
			PageLayout.Parent = Page

			if firstTab then
				firstTab = false
			end

			TabBtn.MouseButton1Click:Connect(function()
				for _, p in ipairs(PagesFolder:GetChildren()) do
					if p:IsA("ScrollingFrame") then p.Visible = false end
				end
				Page.Visible = true
			end)

			CreatedTabs[tabName] = Page

		-- 5. CRIAR BOTÃO: UltsLib(Button, "Velocidade", "Main", true, function() ... end)
		elseif cmd == "button" then
			local btnText = tostring(arg1)
			local targetTabName = tostring(arg2)
			local targetPage = CreatedTabs[targetTabName]

			if not targetPage then
				warn("UltsLib Erro: A Tab '" .. targetTabName .. "' não existe!")
				return
			end

			local btnColor, followTheme = ResolveColor(arg3)
			local callback = type(arg4) == "function" and arg4 or (type(arg4) == "table" and arg4.Callback) or function() end

			local Button = Instance.new("TextButton")
			Button.Name = btnText
			Button.BackgroundColor3 = btnColor
			Button.BorderSizePixel = 0
			Button.Font = Enum.Font.SourceSansBold
			Button.Size = UDim2.new(0, 416, 0, 45)
			Button.Text = btnText
			Button.TextColor3 = GetContrastText(btnColor)
			Button.TextSize = 15
			Button.Parent = targetPage

			if followTheme then
				table.insert(ThemedElements, Button)
			end

			local UICorner = Instance.new("UICorner")
			UICorner.Parent = Button

			Button.MouseButton1Click:Connect(function()
callback()
end)
end
end
})

return UltsLib
