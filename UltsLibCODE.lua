-- ============================================================
-- ULTS LIB v0 - POR RCCDEV
-- ============================================================

local Players = game:GetService("Players")
local playerGui = Players.LocalPlayer:WaitForChild("PlayerGui")

if playerGui:FindFirstChild("UltsLibsTEST") then
	playerGui.UltsLibsTEST:Destroy()
end

-- Interface Base
local UltsLibsTEST = Instance.new("ScreenGui")
UltsLibsTEST.Name = "UltsLibsTEST"
UltsLibsTEST.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
UltsLibsTEST.ResetOnSpawn = false

local Main = Instance.new("Frame")
Main.Name = "Main"
Main.BackgroundColor3 = Color3.fromRGB(31, 31, 31)
Main.BackgroundTransparency = 0.2
Main.BorderSizePixel = 0
Main.Position = UDim2.new(0.25, 0, 0.2, 0)
Main.Size = UDim2.new(0, 571, 0, 382)
Main.Parent = UltsLibsTEST

local UICornerMain = Instance.new("UICorner")
UICornerMain.Parent = Main

local UIDragDetector = Instance.new("UIDragDetector")
UIDragDetector.Parent = Main

-- Barra Superior
local MainTASB = Instance.new("Frame")
MainTASB.Name = "MainTASB"
MainTASB.BackgroundColor3 = Color3.fromRGB(31, 31, 31)
MainTASB.BackgroundTransparency = 0.2
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
NameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
NameLabel.TextScaled = true
NameLabel.Parent = MainTASB

local NameTIP = Instance.new("TextLabel")
NameTIP.Name = "NameTIP"
NameTIP.BackgroundTransparency = 1
NameTIP.Font = Enum.Font.DenkOne
NameTIP.Position = UDim2.new(0.548161, 0, 0.125, 0)
NameTIP.Size = UDim2.new(0, 240, 0, 23)
NameTIP.Text = "v0"
NameTIP.TextColor3 = Color3.fromRGB(67, 67, 67)
NameTIP.TextScaled = true
NameTIP.Parent = MainTASB

-- Menu Lateral (Tabs)
local Tabs = Instance.new("ScrollingFrame")
Tabs.Name = "Tabs"
Tabs.Active = true
Tabs.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Tabs.BackgroundTransparency = 0.2
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

UltsLibsTEST.Parent = playerGui

-- ============================================================
-- DICIONÁRIO DE ABAS E PALAVRAS-CHAVE SEM ASPAS
-- ============================================================
local CreatedTabs = {} -- Guarda todas as abas pelo nome: CreatedTabs["Main"] = Page
local firstTab = true

-- Registra as palavras-chave no ambiente global (para funcionar sem aspas)
local env = getgenv and getgenv() or _G
env.Title = "title"
env.SubTitle = "subtitle"
env.Tab = "tab"
env.Button = "button"
env.Toggle = "toggle"

local UltsLib = {}

setmetatable(UltsLib, {
	-- Agora aceita: (Tipo, Nome/Texto, NomeDaTab, Callback/Config)
	__call = function(self, tipo, arg1, arg2, arg3)
		local cmd = tostring(tipo):lower()

		-- 1. TÍTULO
		if cmd == "title" then
			NameLabel.Text = tostring(arg1)

		-- 2. SUBTÍTULO
		elseif cmd == "subtitle" then
			NameTIP.Text = tostring(arg1)

		-- 3. CRIAR ABA: UltsLib(Tab, "Main")
		elseif cmd == "tab" then
			local tabName = tostring(arg1)

			local TabBtn = Instance.new("TextButton")
			TabBtn.Name = tabName
			TabBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			TabBtn.BorderSizePixel = 0
			TabBtn.Font = Enum.Font.SourceSansBold
			TabBtn.Size = UDim2.new(0, 100, 0, 40)
			TabBtn.Text = tabName
			TabBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
			TabBtn.TextSize = 14
			TabBtn.Parent = Tabs

			local BtnCorner = Instance.new("UICorner")
			BtnCorner.Parent = TabBtn

			local Page = Instance.new("ScrollingFrame")
			Page.Name = tabName .. "_Page"
			Page.Active = true
			Page.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
			Page.BackgroundTransparency = 0.2
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
				TabBtn.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
				firstTab = false
			end

			TabBtn.MouseButton1Click:Connect(function()
				for _, p in ipairs(PagesFolder:GetChildren()) do
					if p:IsA("ScrollingFrame") then p.Visible = false end
				end
				for _, b in ipairs(Tabs:GetChildren()) do
					if b:IsA("TextButton") then b.BackgroundColor3 = Color3.fromRGB(255, 255, 255) end
				end
				Page.Visible = true
				TabBtn.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
			end)

			-- Salva a página pelo nome para achar depois
			CreatedTabs[tabName] = Page

		-- 4. CRIAR BOTÃO: UltsLib(Button, "Super velocidade", "Main", function() ... end)
		elseif cmd == "button" then
			local btnText = tostring(arg1)
			local targetTabName = tostring(arg2)
			local targetPage = CreatedTabs[targetTabName]

			if not targetPage then
				warn("UltsLib Erro: A Tab '" .. targetTabName .. "' não existe! Crie ela antes.")
				return
			end

			local callback = type(arg3) == "function" and arg3 or (type(arg3) == "table" and arg3.Callback) or function() end

			local Button = Instance.new("TextButton")
			Button.Name = btnText
			Button.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Button.BorderSizePixel = 0
			Button.Font = Enum.Font.SourceSansBold
			Button.Size = UDim2.new(0, 416, 0, 45)
			Button.Text = btnText
			Button.TextColor3 = Color3.fromRGB(0, 0, 0)
			Button.TextSize = 15
			Button.Parent = targetPage -- Vai direto para a Tab escolhida!

			local UICorner = Instance.new("UICorner")
			UICorner.Parent = Button

			Button.MouseButton1Click:Connect(function()
				callback()
			end)
		end
	end
})

return UltsLib
