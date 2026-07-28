local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- 🔗 Базовые URL GitHub
local GITHUB_RAW_BASE = "https://raw.githubusercontent.com/kryytoi/KrakenTeamScript/main/"
local ICONS_URL = GITHUB_RAW_BASE .. "icons/"
local SCRIPTS_URL = GITHUB_RAW_BASE .. "scripts/"

-- 🛠 Список доступных скриптов в хабе (название файла)
local scriptsList = {
    "Universal_script.lua"
}

-- 🎨 Вспомогательная функция для форматирования названий (Universal_script.lua -> Universal Script)
local function formatScriptName(fileName)
    local name = fileName:gsub("%.lua$", ""):gsub("_", " ")
    return name
end

-- 📌 Удаляем старый хаб, если он существует
if PlayerGui:FindFirstChild("KrakenScriptHub") then
    PlayerGui.KrakenScriptHub:Destroy()
end

-- 1. Создание ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "KrakenScriptHub"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = PlayerGui

-- 2. Главный контейнер (Main Frame)
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 520, 0, 300)
MainFrame.Position = UDim2.new(0.5, -260, 0.5, -150)
MainFrame.BackgroundTransparency = 1
MainFrame.Parent = ScreenGui

-- 3. Левая боковая панель навигации (Sidebar)
local SideBar = Instance.new("Frame")
SideBar.Name = "SideBar"
SideBar.Size = UDim2.new(0, 60, 1, 0)
SideBar.Position = UDim2.new(0, 0, 0, 0)
SideBar.BackgroundColor3 = Color3.fromRGB(88, 20, 138) -- Фиолетовый цвет как на скриншоте
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

-- 4. Правая область контента (Content Area)
local ContentArea = Instance.new("Frame")
ContentArea.Name = "ContentArea"
ContentArea.Size = UDim2.new(1, -70, 1, 0)
ContentArea.Position = UDim2.new(0, 70, 0, 0)
ContentArea.BackgroundColor3 = Color3.fromRGB(18, 18, 20) -- Тёмный фон
ContentArea.BackgroundTransparency = 0.15
ContentArea.BorderSizePixel = 0
ContentArea.Parent = MainFrame

local ContentCorner = Instance.new("UICorner")
ContentCorner.CornerRadius = UDim.new(0, 16)
ContentCorner.Parent = ContentArea

-- 5. Вкладки (Home и Settings)
local HomeTab = Instance.new("ScrollingFrame")
HomeTab.Name = "HomeTab"
HomeTab.Size = UDim2.new(1, -20, 1, -20)
HomeTab.Position = UDim2.new(0, 10, 0, 10)
HomeTab.BackgroundTransparency = 1
HomeTab.BorderSizePixel = 0
HomeTab.ScrollBarThickness = 4
HomeTab.Parent = ContentArea

local HomeLayout = Instance.new("UIListLayout")
HomeLayout.Parent = HomeTab
HomeLayout.SortOrder = Enum.SortOrder.LayoutOrder
HomeLayout.Padding = UDim.new(0, 12)

local SettingsTab = Instance.new("Frame")
SettingsTab.Name = "SettingsTab"
SettingsTab.Size = UDim2.new(1, -20, 1, -20)
SettingsTab.Position = UDim2.new(0, 10, 0, 10)
SettingsTab.BackgroundTransparency = 1
SettingsTab.Visible = false
SettingsTab.Parent = ContentArea

-- ⚙️ Настройки в окне Settings
local SettingsTitle = Instance.new("TextLabel")
SettingsTitle.Size = UDim2.new(1, 0, 0, 30)
SettingsTitle.BackgroundTransparency = 1
SettingsTitle.Text = "Настройки окна"
SettingsTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
SettingsTitle.TextSize = 18
SettingsTitle.Font = Enum.Font.SourceSansBold
SettingsTitle.TextXAlignment = Enum.TextXAlignment.Left
SettingsTitle.Parent = SettingsTab

local ResizeBtn = Instance.new("TextButton")
ResizeBtn.Size = UDim2.new(0, 180, 0, 35)
ResizeBtn.Position = UDim2.new(0, 0, 0, 40)
ResizeBtn.BackgroundColor3 = Color3.fromRGB(88, 20, 138)
ResizeBtn.Text = "Изменить размер: 600x350"
ResizeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ResizeBtn.Font = Enum.Font.SourceSans
ResizeBtn.TextSize = 14
ResizeBtn.Parent = SettingsTab

local ResizeCorner = Instance.new("UICorner")
ResizeCorner.CornerRadius = UDim.new(0, 8)
ResizeCorner.Parent = ResizeBtn

local isBigSize = false
ResizeBtn.MouseButton1Click:Connect(function()
    isBigSize = not isBigSize
    if isBigSize then
        MainFrame.Size = UDim2.new(0, 650, 0, 380)
        MainFrame.Position = UDim2.new(0.5, -325, 0.5, -190)
        ResizeBtn.Text = "Изменить размер: 520x300"
    else
        MainFrame.Size = UDim2.new(0, 520, 0, 300)
        MainFrame.Position = UDim2.new(0.5, -260, 0.5, -150)
        ResizeBtn.Text = "Изменить размер: 650x380"
    end
end)

-- 🔘 Функция создания кнопок в левом меню
local function createNavButton(iconName, layoutOrder, callback)
    local btn = Instance.new("ImageButton")
    btn.Size = UDim2.new(0, 36, 0, 36)
    btn.BackgroundTransparency = 1
    btn.Image = ICONS_URL .. iconName
    btn.LayoutOrder = layoutOrder
    btn.Parent = SideBar
    
    btn.MouseButton1Click:Connect(callback)
    return btn
end

-- Кнопка HOME
createNavButton("home.png", 1, function()
    HomeTab.Visible = true
    SettingsTab.Visible = false
end)

-- Кнопка SETTINGS
createNavButton("settings.png", 2, function()
    HomeTab.Visible = false
    SettingsTab.Visible = true
end)

-- Кнопка EXIT (Удаляет весь хаб)
createNavButton("exit.png", 3, function()
    ScreenGui:Destroy()
end)

-- 🚀 Заполнение списка скриптов в HomeTab
for _, scriptFileName in ipairs(scriptsList) do
    local ScriptCard = Instance.new("Frame")
    ScriptCard.Size = UDim2.new(1, -10, 0, 55)
    ScriptCard.BackgroundTransparency = 1
    ScriptCard.Parent = HomeTab

    -- Кнопка СТАРТ (start.png)
    local StartBtn = Instance.new("ImageButton")
    StartBtn.Size = UDim2.new(0, 40, 0, 40)
    StartBtn.Position = UDim2.new(0, 5, 0.5, -20)
    StartBtn.BackgroundTransparency = 1
    StartBtn.Image = ICONS_URL .. "start.png"
    StartBtn.Parent = ScriptCard

    -- Название скрипта
    local TitleLabel = Instance.new("TextLabel")
    TitleLabel.Size = UDim2.new(1, -60, 1, 0)
    TitleLabel.Position = UDim2.new(0, 55, 0, 0)
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Text = formatScriptName(scriptFileName)
    TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    TitleLabel.TextSize = 20
    TitleLabel.Font = Enum.Font.SourceSans
    TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    TitleLabel.Parent = ScriptCard

    -- Логика нажатия на кнопка старта
    StartBtn.MouseButton1Click:Connect(function()
        local scriptUrl = SCRIPTS_URL .. scriptFileName
        
        -- Выполнение скрипта
        task.spawn(function()
            local success, err = pcall(function()
                if loadstring then
                    loadstring(game:HttpGet(scriptUrl))()
                else
                    warn("loadstring не поддерживается в стандартной среде Roblox Studio без исполнителя!")
                end
            end)
            
            if not success then
                warn("Ошибка при запуске скрипта: " .. tostring(err))
            end
        end)
        
        -- Удаление / закрытие хаба при запуске
        ScreenGui:Destroy()
    end)
end
