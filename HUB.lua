-- 📌 Kraken Script Hub
local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- 🔗 Ссылки на ресурсы на GitHub
local RAW_BASE = "https://raw.githubusercontent.com/kryytoi/KrakenTeamScript/main/"
local ICONS_BASE = RAW_BASE .. "icons/"
local SCRIPTS_BASE = RAW_BASE .. "scripts/"

-- Функция для безопасного скачивания и отображения картинок с GitHub
local function getOnlineImage(fileName)
    local url = ICONS_BASE .. fileName
    if writefile and getcustomasset then
        local success, result = pcall(function()
            local assetPath = "kraken_hub_" .. fileName
            if not isfile or not isfile(assetPath) then
                local content = game:HttpGet(url)
                writefile(assetPath, content)
            end
            return getcustomasset(assetPath)
        end)
        if success then return result end
    end
    return "" -- Фоллбек, если исполнитель не поддерживает сохранение файлов
end

-- Удаляем старую версию хаба, если она уже открыта
if PlayerGui:FindFirstChild("KrakenScriptHub") then
    PlayerGui.KrakenScriptHub:Destroy()
end

-- 1. Основной ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "KrakenScriptHub"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = PlayerGui

-- 2. Главный контейнер (Main Frame)
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 520, 0, 300)
MainFrame.Position = UDim2.new(0.5, -260, 0.5, -150)
MainFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 20)
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 16)
MainCorner.Parent = MainFrame

-- 3. Левая боковая панель (SideBar)
local SideBar = Instance.new("Frame")
SideBar.Name = "SideBar"
SideBar.Size = UDim2.new(0, 60, 1, 0)
SideBar.BackgroundColor3 = Color3.fromRGB(88, 20, 138)
SideBar.BorderSizePixel = 0
SideBar.Parent = MainFrame

local SideBarCorner = Instance.new("UICorner")
SideBarCorner.CornerRadius = UDim.new(0, 16)
SideBarCorner.Parent = SideBar

local SideBarLayout = Instance.new("UIListLayout")
SideBarLayout.Parent = SideBar
SideBarLayout.SortOrder = Enum.SortOrder.LayoutOrder
SideBarLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
SideBarLayout.VerticalAlignment = Enum.VerticalAlignment.Center
SideBarLayout.Padding = UDim.new(0, 20)

-- 4. Область содержимого (Content Area)
local ContentArea = Instance.new("Frame")
ContentArea.Name = "ContentArea"
ContentArea.Size = UDim2.new(1, -70, 1, 0)
ContentArea.Position = UDim2.new(0, 70, 0, 0)
ContentArea.BackgroundTransparency = 1
ContentArea.Parent = MainFrame

-- Вкладка Главная (HomeTab)
local HomeTab = Instance.new("Frame")
HomeTab.Name = "HomeTab"
HomeTab.Size = UDim2.new(1, -20, 1, -20)
HomeTab.Position = UDim2.new(0, 10, 0, 10)
HomeTab.BackgroundTransparency = 1
HomeTab.Parent = ContentArea

-- Вкладка Настройки (SettingsTab)
local SettingsTab = Instance.new("Frame")
SettingsTab.Name = "SettingsTab"
SettingsTab.Size = UDim2.new(1, -20, 1, -20)
SettingsTab.Position = UDim2.new(0, 10, 0, 10)
SettingsTab.BackgroundTransparency = 1
SettingsTab.Visible = false
SettingsTab.Parent = ContentArea

-- Настройки размера
local SettingsTitle = Instance.new("TextLabel")
SettingsTitle.Size = UDim2.new(1, 0, 0, 30)
SettingsTitle.BackgroundTransparency = 1
SettingsTitle.Text = "Настройки размера Хаба"
SettingsTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
SettingsTitle.TextSize = 18
SettingsTitle.Font = Enum.Font.SourceSansBold
SettingsTitle.TextXAlignment = Enum.TextXAlignment.Left
SettingsTitle.Parent = SettingsTab

local ResizeBtn = Instance.new("TextButton")
ResizeBtn.Size = UDim2.new(0, 200, 0, 40)
ResizeBtn.Position = UDim2.new(0, 0, 0, 40)
ResizeBtn.BackgroundColor3 = Color3.fromRGB(88, 20, 138)
ResizeBtn.Text = "Размер: 520x300 (Нажми для 650x380)"
ResizeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ResizeBtn.Font = Enum.Font.SourceSans
ResizeBtn.TextSize = 14
ResizeBtn.Parent = SettingsTab

local ResizeCorner = Instance.new("UICorner")
ResizeCorner.CornerRadius = UDim.new(0, 8)
ResizeCorner.Parent = ResizeBtn

local isExpanded = false
ResizeBtn.MouseButton1Click:Connect(function()
    isExpanded = not isExpanded
    if isExpanded then
        MainFrame.Size = UDim2.new(0, 650, 0, 380)
        MainFrame.Position = UDim2.new(0.5, -325, 0.5, -190)
        ResizeBtn.Text = "Размер: 650x380 (Нажми для 520x300)"
    else
        MainFrame.Size = UDim2.new(0, 520, 0, 300)
        MainFrame.Position = UDim2.new(0.5, -260, 0.5, -150)
        ResizeBtn.Text = "Размер: 520x300 (Нажми для 650x380)"
    end
end)

-- 5. Функция создания кнопок в левом меню
local function createNavButton(iconFileName, layoutOrder, onClick)
    local btn = Instance.new("ImageButton")
    btn.Size = UDim2.new(0, 32, 0, 32)
    btn.BackgroundTransparency = 1
    btn.LayoutOrder = layoutOrder
    btn.Image = getOnlineImage(iconFileName)
    btn.Parent = SideBar

    btn.MouseButton1Click:Connect(onClick)
    return btn
end

-- Кнопка Home (home.png)
createNavButton("home.png", 1, function()
    HomeTab.Visible = true
    SettingsTab.Visible = false
end)

-- Кнопка Settings (settings.png)
createNavButton("settings.png", 2, function()
    HomeTab.Visible = false
    SettingsTab.Visible = true
end)

-- Кнопка Exit (exit.png)
createNavButton("exit.png", 3, function()
    ScreenGui:Destroy()
end)

-- 6. Карточка скрипта (Universal Script)
local ScriptCard = Instance.new("Frame")
ScriptCard.Size = UDim2.new(1, 0, 0, 50)
ScriptCard.Position = UDim2.new(0, 0, 0, 10)
ScriptCard.BackgroundTransparency = 1
ScriptCard.Parent = HomeTab

-- Кнопка старта с иконкой start.png
local StartBtn = Instance.new("ImageButton")
StartBtn.Size = UDim2.new(0, 36, 0, 36)
StartBtn.Position = UDim2.new(0, 0, 0.5, -18)
StartBtn.BackgroundTransparency = 1
StartBtn.Image = getOnlineImage("start.png")
StartBtn.Parent = ScriptCard

-- Текст скрипта
local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(1, -50, 1, 0)
TitleLabel.Position = UDim2.new(0, 48, 0, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "Universal Script"
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.TextSize = 20
TitleLabel.Font = Enum.Font.SourceSans
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.Parent = ScriptCard

-- 🚀 Запуск скрипта при нажатии на кнопку Старт
StartBtn.MouseButton1Click:Connect(function()
    local scriptUrl = SCRIPTS_BASE .. "Universal_script.lua"
    
    task.spawn(function()
        local success, err = pcall(function()
            local code = game:HttpGet(scriptUrl, true)
            loadstring(code)()
        end)
        
        if not success then
            warn("[Kraken Hub]: Ошибка запуска Universal_script.lua -> " .. tostring(err))
        end
    end)
    
    -- Закрываем хаб после старта
    ScreenGui:Destroy()
end)
