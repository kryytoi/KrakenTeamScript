
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- 🔗 Ссылки на GitHub
local RAW_BASE = "https://raw.githubusercontent.com/kryytoi/KrakenTeamScript/main/"
local ICONS_BASE = RAW_BASE .. "icons/"
local SCRIPTS_BASE = RAW_BASE .. "scripts/"

-- Функция для загрузки онлайн-картинок с кэшированием
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

-- Удаляем предыдущий GUI, если он открыт
if PlayerGui:FindFirstChild("KrakenScriptHub") then
    PlayerGui.KrakenScriptHub:Destroy()
end

-- 1. ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "KrakenScriptHub"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = PlayerGui

-- 2. Текст/Логотип KTHUB над хабом
local Logo = Instance.new("ImageLabel")
Logo.Name = "KTHubLogo"
Logo.Size = UDim2.new(0, 240, 0, 80)
Logo.Position = UDim2.new(0.5, -120, 0.5, -230)
Logo.BackgroundTransparency = 1
Logo.Image = getOnlineImage("KTHUB.png")
Logo.ImageTransparency = 1
Logo.Parent = ScreenGui

-- 3. Главный контейнер (Окно Хаба)
local Container = Instance.new("Frame")
Container.Name = "Container"
Container.Size = UDim2.new(0, 0, 0, 0) -- Старт с 0 размера для анимации открытия
Container.Position = UDim2.new(0.5, 0, 0.5, 0)
Container.BackgroundTransparency = 1
Container.ClipsDescendants = false
Container.Parent = ScreenGui

local targetSize = UDim2.new(0, 520, 0, 270)
local targetPos = UDim2.new(0.5, -260, 0.5, -110)

-- 4. Левая панель (Sidebar)
local SideBar = Instance.new("Frame")
SideBar.Name = "SideBar"
SideBar.Size = UDim2.new(0, 60, 1, 0)
SideBar.Position = UDim2.new(0, 0, 0, 0)
SideBar.BackgroundColor3 = Color3.fromRGB(92, 18, 148)
SideBar.BackgroundTransparency = 0.2 -- Liquid Glass прозрачность
SideBar.BorderSizePixel = 0
SideBar.Parent = Container

local SideBarCorner = Instance.new("UICorner")
SideBarCorner.CornerRadius = UDim.new(0, 22) -- Закругление 1 в 1 как у правого окна
SideBarCorner.Parent = SideBar

local SideBarLayout = Instance.new("UIListLayout")
SideBarLayout.Parent = SideBar
SideBarLayout.SortOrder = Enum.SortOrder.LayoutOrder
SideBarLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
SideBarLayout.VerticalAlignment = Enum.VerticalAlignment.Center
SideBarLayout.Padding = UDim.new(0, 30)

-- 5. Правое окно контента (MainFrame)
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(1, -75, 1, 0)
MainFrame.Position = UDim2.new(0, 75, 0, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 18)
MainFrame.BackgroundTransparency = 0.25 -- Liquid Glass прозрачность
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

-- 6. Вкладки (CanvasGroup для поддержки прозрачности при анимациях)
local HomeTab = Instance.new("CanvasGroup")
HomeTab.Name = "HomeTab"
HomeTab.Size = UDim2.new(1, 0, 1, 0)
HomeTab.BackgroundTransparency = 1
HomeTab.GroupTransparency = 0
HomeTab.Parent = MainFrame

local SettingsTab = Instance.new("CanvasGroup")
SettingsTab.Name = "SettingsTab"
SettingsTab.Size = UDim2.new(1, 0, 1, 0)
SettingsTab.BackgroundTransparency = 1
SettingsTab.GroupTransparency = 1
SettingsTab.Visible = false
SettingsTab.Parent = MainFrame

-- Вкладка Настроек
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
    local newSize = isExpanded and UDim2.new(0, 650, 0, 350) or UDim2.new(0, 520, 0, 270)
    local newPos = isExpanded and UDim2.new(0.5, -325, 0.5, -150) or UDim2.new(0.5, -260, 0.5, -110)
    ResizeBtn.Text = isExpanded and "Размер: 650x350" or "Размер: 520x270"

    TweenService:Create(Container, TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
        Size = newSize,
        Position = newPos
    }):Play()
end)

-- Анимация переключения вкладок
local currentTab = HomeTab
local function switchTab(toTab)
    if currentTab == toTab then return end
    
    local fadeOut = TweenService:Create(currentTab, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {GroupTransparency = 1})
    fadeOut:Play()
    fadeOut.Completed:Connect(function()
        currentTab.Visible = false
        toTab.Visible = true
        toTab.GroupTransparency = 1
        TweenService:Create(toTab, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {GroupTransparency = 0}):Play()
        currentTab = toTab
    end)
end

-- Анимация закрытия Хаба
local function closeHub(onComplete)
    local tween1 = TweenService:Create(Container, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
        Size = UDim2.new(0, 0, 0, 0),
        Position = UDim2.new(0.5, 0, 0.5, 0)
    })
    local tween2 = TweenService:Create(Logo, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        ImageTransparency = 1,
        Position = UDim2.new(0.5, -120, 0.5, -250)
    })
    tween1:Play()
    tween2:Play()
    tween1.Completed:Connect(function()
        if onComplete then onComplete() end
        ScreenGui:Destroy()
    end)
end

-- Функция создания кнопок в левом меню с анимациями наведения
local function createNavButton(iconFileName, layoutOrder, onClick)
    local btn = Instance.new("ImageButton")
    btn.Size = UDim2.new(0, 32, 0, 32)
    btn.BackgroundTransparency = 1
    btn.LayoutOrder = layoutOrder
    btn.Image = getOnlineImage(iconFileName)
    btn.Parent = SideBar

    -- Анимация при наведении мыши
    btn.MouseEnter:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Size = UDim2.new(0, 38, 0, 38)
        }):Play()
    end)
    btn.MouseLeave:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Size = UDim2.new(0, 32, 0, 32)
        }):Play()
    end)

    btn.MouseButton1Click:Connect(onClick)
    return btn
end

-- Кнопки боковой панели
createNavButton("home.png", 1, function() switchTab(HomeTab) end)
createNavButton("settings.png", 2, function() switchTab(SettingsTab) end)
createNavButton("exit.png", 3, function() closeHub() end)

-- Элемент списка (Universal Script)
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

-- Анимация наведения для кнопки Старт
StartBtn.MouseEnter:Connect(function()
    TweenService:Create(StartBtn, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Size = UDim2.new(0, 44, 0, 44),
        Position = UDim2.new(0, -3, 0, -3)
    }):Play()
end)
StartBtn.MouseLeave:Connect(function()
    TweenService:Create(StartBtn, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Size = UDim2.new(0, 38, 0, 38),
        Position = UDim2.new(0, 0, 0, 0)
    }):Play()
end)

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

-- Запуск скрипта с анимацией закрытия
StartBtn.MouseButton1Click:Connect(function()
    local scriptUrl = SCRIPTS_BASE .. "Universal_script.lua"
    
    closeHub(function()
        task.spawn(function()
            local success, err = pcall(function()
                local code = game:HttpGet(scriptUrl, true)
                loadstring(code)()
            end)
            if not success then
                warn("[Kraken Hub]: Ошибка запуска -> " .. tostring(err))
            end
        end)
    end)
end)

-- 🚀 Запуск анимации открытия при старте
TweenService:Create(Container, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
    Size = targetSize,
    Position = targetPos
}):Play()

TweenService:Create(Logo, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
    ImageTransparency = 0,
    Position = UDim2.new(0.5, -120, 0.5, -210)
}):Play()
