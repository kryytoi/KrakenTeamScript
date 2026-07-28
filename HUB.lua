-- 📌 Kraken Script Hub (Liquid Glass 1:1)
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- 🔗 Ссылки на GitHub
local RAW_BASE = "https://raw.githubusercontent.com/kryytoi/KrakenTeamScript/main/"
local ICONS_BASE = RAW_BASE .. "icons/"
local SCRIPTS_BASE = RAW_BASE .. "scripts/"

-- Функция загрузки картинок
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
    return url
end

-- Удаляем старый UI
if PlayerGui:FindFirstChild("KrakenScriptHub") then
    PlayerGui.KrakenScriptHub:Destroy()
end

-- 1. ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "KrakenScriptHub"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = PlayerGui

-- 2. Главный обёрточный контейнер
local Container = Instance.new("Frame")
Container.Name = "Container"
Container.Size = UDim2.new(0, 520, 0, 270)
Container.Position = UDim2.new(0.5, -260, 0.5, -135)
Container.BackgroundTransparency = 1
Container.Parent = ScreenGui

-- 3. Левая фиолетовая капсула (Sidebar)
local SideBar = Instance.new("Frame")
SideBar.Name = "SideBar"
SideBar.Size = UDim2.new(0, 60, 1, 0)
SideBar.Position = UDim2.new(0, 0, 0, 0)
SideBar.BackgroundColor3 = Color3.fromRGB(92, 18, 148)
SideBar.BorderSizePixel = 0
SideBar.Parent = Container

local SideBarCorner = Instance.new("UICorner")
SideBarCorner.CornerRadius = UDim.new(0.5, 0) -- Закругление в форму овальной капсулы
SideBarCorner.Parent = SideBar

local SideBarLayout = Instance.new("UIListLayout")
SideBarLayout.Parent = SideBar
SideBarLayout.SortOrder = Enum.SortOrder.LayoutOrder
SideBarLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
SideBarLayout.VerticalAlignment = Enum.VerticalAlignment.Center
SideBarLayout.Padding = UDim.new(0, 32)

-- 4. Правое окно (Liquid Glass Frame)
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(1, -75, 1, 0)
MainFrame.Position = UDim2.new(0, 75, 0, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 18)
MainFrame.BackgroundTransparency = 0.25 -- Полупрозрачный эффект Liquid Glass
MainFrame.BorderSizePixel = 0
MainFrame.Parent = Container

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 22)
MainCorner.Parent = MainFrame

local MainPadding = Instance.new("UIPadding")
MainPadding.PaddingTop = UDim.new(0, 20)
MainPadding.PaddingLeft = UDim.new(0, 25)
MainPadding.PaddingRight = UDim.new(0, 20)
MainPadding.PaddingBottom = UDim.new(0, 20)
MainPadding.Parent = MainFrame

-- Вкладка Home
local HomeTab = Instance.new("Frame")
HomeTab.Name = "HomeTab"
HomeTab.Size = UDim2.new(1, 0, 1, 0)
HomeTab.BackgroundTransparency = 1
HomeTab.Parent = MainFrame

-- Вкладка Settings
local SettingsTab = Instance.new("Frame")
SettingsTab.Name = "SettingsTab"
SettingsTab.Size = UDim2.new(1, 0, 1, 0)
SettingsTab.BackgroundTransparency = 1
SettingsTab.Visible = false
SettingsTab.Parent = MainFrame

-- Настройки в вкладке Settings
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
ResizeBtn.Size = UDim2.new(0, 180, 0, 36)
ResizeBtn.Position = UDim2.new(0, 0, 0, 40)
ResizeBtn.BackgroundColor3 = Color3.fromRGB(92, 18, 148)
ResizeBtn.Text = "Размер: 520x270"
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
        Container.Size = UDim2.new(0, 650, 0, 350)
        Container.Position = UDim2.new(0.5, -325, 0.5, -175)
        ResizeBtn.Text = "Размер: 650x350"
    else
        Container.Size = UDim2.new(0, 520, 0, 270)
        Container.Position = UDim2.new(0.5, -260, 0.5, -135)
        ResizeBtn.Text = "Размер: 520x270"
    end
end)

-- 5. Иконки навигации в боковой панели
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

-- Кнопка Exit (exit.png) — закрывает UI
createNavButton("exit.png", 3, function()
    ScreenGui:Destroy()
end)

-- 6. Строка со скриптом (start.png + Universal Script)
local ScriptItem = Instance.new("Frame")
ScriptItem.Size = UDim2.new(1, 0, 0, 40)
ScriptItem.Position = UDim2.new(0, 0, 0, 10)
ScriptItem.BackgroundTransparency = 1
ScriptItem.Parent = HomeTab

local StartBtn = Instance.new("ImageButton")
StartBtn.Size = UDim2.new(0, 38, 0, 38)
StartBtn.Position = UDim2.new(0, 0, 0, 0)
StartBtn.BackgroundTransparency = 1
StartBtn.Image = getOnlineImage("start.png")
StartBtn.Parent = ScriptItem

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(1, -60, 1, 0)
TitleLabel.Position = UDim2.new(0, 55, 0, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "Universal Script"
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.TextSize = 22
TitleLabel.Font = Enum.Font.SourceSans
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.Parent = ScriptItem

-- Запуск скрипта при нажатии на start.png
StartBtn.MouseButton1Click:Connect(function()
    local scriptUrl = SCRIPTS_BASE .. "Universal_script.lua"
    
    task.spawn(function()
        local success, err = pcall(function()
            local code = game:HttpGet(scriptUrl, true)
            loadstring(code)()
        end)
        
        if not success then
            warn("[Kraken Hub]: Ошибка запуска -> " .. tostring(err))
        end
    end)
    
    -- Удаляем хаб при запуске
    ScreenGui:Destroy()
end)
