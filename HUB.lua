local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

local RAW_BASE = "https://raw.githubusercontent.com/kryytoi/KrakenTeamScript/main/"
local ICONS_BASE = RAW_BASE .. "icons/"
local REPO_TREE = "https://github.com/kryytoi/KrakenTeamScript/tree/main/scripts"
local API_SCRIPTS = "https://api.github.com/repos/kryytoi/KrakenTeamScript/contents/scripts"

local SBORKS_RAW = RAW_BASE .. "sborks/"
local SBORKS_TREE = "https://github.com/kryytoi/KrakenTeamScript/tree/main/sborks"
local SBORKS_API = "https://api.github.com/repos/kryytoi/KrakenTeamScript/contents/sborks"

local function getOnlineImage(fileName)
    local url = ICONS_BASE .. fileName .. "?nocache=" .. tostring(tick())
    local assetPath = "kraken_v7_" .. fileName

    if isfile and isfile(assetPath) and getcustomasset then
        return getcustomasset(assetPath)
    end

    if writefile and getcustomasset then
        local success, content = pcall(function()
            return game:HttpGet(url, true)
        end)

        if success and type(content) == "string" and #content > 50 then
            pcall(writefile, assetPath, content)
            return getcustomasset(assetPath)
        end
    end

    return url
end

if PlayerGui:FindFirstChild("KrakenScriptHub") then
    PlayerGui.KrakenScriptHub:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "KrakenScriptHub"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = PlayerGui

local Container = Instance.new("Frame")
Container.Name = "Container"
Container.Size = UDim2.new(0, 0, 0, 0)
Container.Position = UDim2.new(0.5, 0, 0.5, 0)
Container.BackgroundTransparency = 1
Container.ClipsDescendants = false
Container.Parent = ScreenGui

local targetSize = UDim2.new(0, 520, 0, 270)
local targetPos = UDim2.new(0.5, -260, 0.5, -110)

local KTHubLogo = Instance.new("ImageLabel")
KTHubLogo.Name = "KTHubLogo"
KTHubLogo.Size = UDim2.new(0, 320, 0, 90)
KTHubLogo.Position = UDim2.new(0.5, -160, 0, -85)
KTHubLogo.BackgroundTransparency = 1
KTHubLogo.ScaleType = Enum.ScaleType.Fit
KTHubLogo.Image = getOnlineImage("KTHUB.png")
KTHubLogo.ZIndex = 10
KTHubLogo.Parent = Container

local SideBar = Instance.new("Frame")
SideBar.Name = "SideBar"
SideBar.Size = UDim2.new(0, 60, 1, 0)
SideBar.Position = UDim2.new(0, 0, 0, 0)
SideBar.BackgroundColor3 = Color3.fromRGB(92, 18, 148)
SideBar.BackgroundTransparency = 0.2
SideBar.BorderSizePixel = 0
SideBar.Parent = Container

local SideBarCorner = Instance.new("UICorner")
SideBarCorner.CornerRadius = UDim.new(0, 22)
SideBarCorner.Parent = SideBar

local SideBarLayout = Instance.new("UIListLayout")
SideBarLayout.Parent = SideBar
SideBarLayout.SortOrder = Enum.SortOrder.LayoutOrder
SideBarLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
SideBarLayout.VerticalAlignment = Enum.VerticalAlignment.Center
SideBarLayout.Padding = UDim.new(0, 20)

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(1, -75, 1, 0)
MainFrame.Position = UDim2.new(0, 75, 0, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 18)
MainFrame.BackgroundTransparency = 0.25
MainFrame.BorderSizePixel = 0
MainFrame.Parent = Container

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 22)
MainCorner.Parent = MainFrame

local MainPadding = Instance.new("UIPadding")
MainPadding.PaddingTop = UDim.new(0, 20)
MainPadding.PaddingLeft = UDim.new(0, 25)
MainPadding.PaddingRight = UDim.new(0, 10)
MainPadding.PaddingBottom = UDim.new(0, 20)
MainPadding.Parent = MainFrame

local HomeTab = Instance.new("CanvasGroup")
HomeTab.Name = "HomeTab"
HomeTab.Size = UDim2.new(1, 0, 1, 0)
HomeTab.BackgroundTransparency = 1
HomeTab.GroupTransparency = 0
HomeTab.Parent = MainFrame

local ScriptScroll = Instance.new("ScrollingFrame")
ScriptScroll.Name = "ScriptScroll"
ScriptScroll.Size = UDim2.new(1, 0, 1, 0)
ScriptScroll.BackgroundTransparency = 1
ScriptScroll.BorderSizePixel = 0
ScriptScroll.ScrollBarThickness = 4
ScriptScroll.ScrollBarImageColor3 = Color3.fromRGB(140, 50, 200)
ScriptScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
ScriptScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
ScriptScroll.Parent = HomeTab

local ScrollLayout = Instance.new("UIListLayout")
ScrollLayout.Parent = ScriptScroll
ScrollLayout.SortOrder = Enum.SortOrder.LayoutOrder
ScrollLayout.Padding = UDim.new(0, 12)

local SborkaTab = Instance.new("CanvasGroup")
SborkaTab.Name = "SborkaTab"
SborkaTab.Size = UDim2.new(1, 0, 1, 0)
SborkaTab.BackgroundTransparency = 1
SborkaTab.GroupTransparency = 1
SborkaTab.Visible = false
SborkaTab.Parent = MainFrame

local SborkaScroll = Instance.new("ScrollingFrame")
SborkaScroll.Name = "SborkaScroll"
SborkaScroll.Size = UDim2.new(1, 0, 1, 0)
SborkaScroll.BackgroundTransparency = 1
SborkaScroll.BorderSizePixel = 0
SborkaScroll.ScrollBarThickness = 4
SborkaScroll.ScrollBarImageColor3 = Color3.fromRGB(140, 50, 200)
SborkaScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
SborkaScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
SborkaScroll.Parent = SborkaTab

local SborkaLayout = Instance.new("UIListLayout")
SborkaLayout.Parent = SborkaScroll
SborkaLayout.SortOrder = Enum.SortOrder.LayoutOrder
SborkaLayout.Padding = UDim.new(0, 12)

local SettingsTab = Instance.new("CanvasGroup")
SettingsTab.Name = "SettingsTab"
SettingsTab.Size = UDim2.new(1, 0, 1, 0)
SettingsTab.BackgroundTransparency = 1
SettingsTab.GroupTransparency = 1
SettingsTab.Visible = false
SettingsTab.Parent = MainFrame

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

local SborkaSettingsFrame = Instance.new("Frame")
SborkaSettingsFrame.Name = "SborkaSettingsFrame"
SborkaSettingsFrame.Size = UDim2.new(0, 520, 0, 270)
SborkaSettingsFrame.Position = UDim2.new(0.5, -260, 0.5, -110)
SborkaSettingsFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 18)
SborkaSettingsFrame.BackgroundTransparency = 0.15
SborkaSettingsFrame.BorderSizePixel = 0
SborkaSettingsFrame.Visible = false
SborkaSettingsFrame.Parent = ScreenGui

local SborkaSettingsCorner = Instance.new("UICorner")
SborkaSettingsCorner.CornerRadius = UDim.new(0, 22)
SborkaSettingsCorner.Parent = SborkaSettingsFrame

local SborkaSettingsPadding = Instance.new("UIPadding")
SborkaSettingsPadding.PaddingTop = UDim.new(0, 15)
SborkaSettingsPadding.PaddingLeft = UDim.new(0, 20)
SborkaSettingsPadding.PaddingRight = UDim.new(0, 20)
SborkaSettingsPadding.PaddingBottom = UDim.new(0, 15)
SborkaSettingsPadding.Parent = SborkaSettingsFrame

local SborkaSettingsTitle = Instance.new("TextLabel")
SborkaSettingsTitle.Size = UDim2.new(1, -40, 0, 30)
SborkaSettingsTitle.Position = UDim2.new(0, 0, 0, 0)
SborkaSettingsTitle.BackgroundTransparency = 1
SborkaSettingsTitle.Text = "Настройки сборки"
SborkaSettingsTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
SborkaSettingsTitle.TextSize = 20
SborkaSettingsTitle.Font = Enum.Font.SourceSansBold
SborkaSettingsTitle.TextXAlignment = Enum.TextXAlignment.Left
SborkaSettingsTitle.Parent = SborkaSettingsFrame

local SborkaSettingsCloseBtn = Instance.new("TextButton")
SborkaSettingsCloseBtn.Size = UDim2.new(0, 30, 0, 30)
SborkaSettingsCloseBtn.Position = UDim2.new(1, -30, 0, 0)
SborkaSettingsCloseBtn.BackgroundTransparency = 1
SborkaSettingsCloseBtn.Text = "✕"
SborkaSettingsCloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SborkaSettingsCloseBtn.TextSize = 22
SborkaSettingsCloseBtn.Font = Enum.Font.SourceSansBold
SborkaSettingsCloseBtn.Parent = SborkaSettingsFrame

local SborkaSettingsScroll = Instance.new("ScrollingFrame")
SborkaSettingsScroll.Size = UDim2.new(1, 0, 1, -40)
SborkaSettingsScroll.Position = UDim2.new(0, 0, 0, 40)
SborkaSettingsScroll.BackgroundTransparency = 1
SborkaSettingsScroll.BorderSizePixel = 0
SborkaSettingsScroll.ScrollBarThickness = 4
SborkaSettingsScroll.ScrollBarImageColor3 = Color3.fromRGB(140, 50, 200)
SborkaSettingsScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
SborkaSettingsScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
SborkaSettingsScroll.Parent = SborkaSettingsFrame

local SborkaSettingsLayout = Instance.new("UIListLayout")
SborkaSettingsLayout.Parent = SborkaSettingsScroll
SborkaSettingsLayout.SortOrder = Enum.SortOrder.LayoutOrder
SborkaSettingsLayout.Padding = UDim.new(0, 8)

SborkaSettingsCloseBtn.MouseButton1Click:Connect(function()
    SborkaSettingsFrame.Visible = false
    Container.Visible = true
end)

local function openSborkaSettings(folderName, scriptsState)
    for _, child in ipairs(SborkaSettingsScroll:GetChildren()) do
        if child:IsA("Frame") then
            child:Destroy()
        end
    end

    SborkaSettingsTitle.Text = "Настройки: " .. folderName

    for _, scriptData in ipairs(scriptsState) do
        local ItemFrame = Instance.new("Frame")
        ItemFrame.Size = UDim2.new(1, -10, 0, 36)
        ItemFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
        ItemFrame.BackgroundTransparency = 0.4
        ItemFrame.Parent = SborkaSettingsScroll

        local ItemCorner = Instance.new("UICorner")
        ItemCorner.CornerRadius = UDim.new(0, 8)
        ItemCorner.Parent = ItemFrame

        local cleanName = scriptData.name:gsub("%.lua$", ""):gsub("_", " ")

        local NameLabel = Instance.new("TextLabel")
        NameLabel.Size = UDim2.new(1, -90, 1, 0)
        NameLabel.Position = UDim2.new(0, 12, 0, 0)
        NameLabel.BackgroundTransparency = 1
        NameLabel.Text = cleanName
        NameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        NameLabel.TextSize = 16
        NameLabel.Font = Enum.Font.SourceSans
        NameLabel.TextXAlignment = Enum.TextXAlignment.Left
        NameLabel.Parent = ItemFrame

        local ToggleBtn = Instance.new("TextButton")
        ToggleBtn.Size = UDim2.new(0, 70, 0, 26)
        ToggleBtn.Position = UDim2.new(1, -78, 0.5, -13)
        ToggleBtn.Parent = ItemFrame

        local ToggleCorner = Instance.new("UICorner")
        ToggleCorner.CornerRadius = UDim.new(0, 6)
        ToggleCorner.Parent = ToggleBtn

        local function updateToggleVisual()
            if scriptData.enabled then
                ToggleBtn.BackgroundColor3 = Color3.fromRGB(92, 18, 148)
                ToggleBtn.Text = "ВКЛ"
                ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
            else
                ToggleBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 50)
                ToggleBtn.Text = "ВЫКЛ"
                ToggleBtn.TextColor3 = Color3.fromRGB(150, 150, 150)
            end
            ToggleBtn.Font = Enum.Font.SourceSansBold
            ToggleBtn.TextSize = 14
        end

        updateToggleVisual()

        ToggleBtn.MouseButton1Click:Connect(function()
            scriptData.enabled = not scriptData.enabled
            updateToggleVisual()
        end)
    end

    SborkaSettingsFrame.Size = Container.Size
    SborkaSettingsFrame.Position = Container.Position
    Container.Visible = false
    SborkaSettingsFrame.Visible = true
end

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

local function closeHub(onComplete)
    local tween = TweenService:Create(Container, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
        Size = UDim2.new(0, 0, 0, 0),
        Position = UDim2.new(0.5, 0, 0.5, 0)
    })
    tween:Play()
    tween.Completed:Connect(function()
        if onComplete then onComplete() end
        ScreenGui:Destroy()
    end)
end

local function createNavButton(iconFileName, layoutOrder, onClick)
    local btn = Instance.new("ImageButton")
    btn.Size = UDim2.new(0, 32, 0, 32)
    btn.BackgroundTransparency = 1
    btn.LayoutOrder = layoutOrder
    btn.Image = getOnlineImage(iconFileName)
    btn.Parent = SideBar

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

createNavButton("home.png", 1, function() switchTab(HomeTab) end)
createNavButton("sborka.png", 2, function() switchTab(SborkaTab) end)
createNavButton("settings.png", 3, function() switchTab(SettingsTab) end)
createNavButton("exit.png", 4, function() closeHub() end)

local loadedScripts = {}

local function createScriptCard(fileName, scriptUrl)
    if fileName:lower():find("hub") then
        return
    end

    if loadedScripts[fileName] then return end
    loadedScripts[fileName] = true

    local ScriptItem = Instance.new("Frame")
    ScriptItem.Name = fileName
    ScriptItem.Size = UDim2.new(1, -12, 0, 40)
    ScriptItem.BackgroundTransparency = 1
    ScriptItem.Parent = ScriptScroll

    local StartBtn = Instance.new("ImageButton")
    StartBtn.Size = UDim2.new(0, 38, 0, 38)
    StartBtn.Position = UDim2.new(0, 0, 0, 0)
    StartBtn.BackgroundTransparency = 1
    StartBtn.Image = getOnlineImage("start.png")
    StartBtn.Parent = ScriptItem

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

    local cleanTitle = fileName:gsub("%.lua$", ""):gsub("_", " ")

    local TitleLabel = Instance.new("TextLabel")
    TitleLabel.Size = UDim2.new(1, -60, 1, 0)
    TitleLabel.Position = UDim2.new(0, 55, 0, 0)
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Text = cleanTitle
    TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    TitleLabel.TextSize = 20
    TitleLabel.Font = Enum.Font.SourceSans
    TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    TitleLabel.Parent = ScriptItem

    StartBtn.MouseButton1Click:Connect(function()
        closeHub(function()
            task.spawn(function()
                local success, err = pcall(function()
                    local fullUrl = scriptUrl
                    if not fullUrl:find("%?") then
                        fullUrl = fullUrl .. "?nocache=" .. tostring(tick())
                    end
                    local code = game:HttpGet(fullUrl, true)
                    loadstring(code)()
                end)
                if not success then
                    warn("[Kraken Hub]: Ошибка запуска " .. fileName .. " -> " .. tostring(err))
                end
            end)
        end)
    end)
end

local loadedSborks = {}

local function createSborkaCard(folderName, luaFiles, descUrl)
    if loadedSborks[folderName] then return end
    loadedSborks[folderName] = true

    local scriptsState = {}
    for _, item in ipairs(luaFiles) do
        if type(item) == "string" then
            local fname = item:match("([^/]+)$") or item
            table.insert(scriptsState, { name = fname, url = item, enabled = true })
        elseif type(item) == "table" then
            table.insert(scriptsState, { name = item.name or "Script.lua", url = item.url or item[1], enabled = item.enabled ~= false })
        end
    end

    local SborkaItem = Instance.new("Frame")
    SborkaItem.Name = folderName
    SborkaItem.Size = UDim2.new(1, -12, 0, 65)
    SborkaItem.BackgroundColor3 = Color3.fromRGB(10, 10, 12)
    SborkaItem.BackgroundTransparency = 0.3
    SborkaItem.Parent = SborkaScroll

    local ItemCorner = Instance.new("UICorner")
    ItemCorner.CornerRadius = UDim.new(0, 14)
    ItemCorner.Parent = SborkaItem

    local ItemPadding = Instance.new("UIPadding")
    ItemPadding.PaddingTop = UDim.new(0, 10)
    ItemPadding.PaddingBottom = UDim.new(0, 10)
    ItemPadding.PaddingLeft = UDim.new(0, 15)
    ItemPadding.PaddingRight = UDim.new(0, 15)
    ItemPadding.Parent = SborkaItem

    local TitleLabel = Instance.new("TextLabel")
    TitleLabel.Size = UDim2.new(1, -95, 0, 22)
    TitleLabel.Position = UDim2.new(0, 0, 0, 0)
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Text = folderName
    TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    TitleLabel.TextSize = 20
    TitleLabel.Font = Enum.Font.SourceSansBold
    TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
    TitleLabel.Parent = SborkaItem

    local DescLabel = Instance.new("TextLabel")
    DescLabel.Size = UDim2.new(1, -95, 0, 20)
    DescLabel.Position = UDim2.new(0, 0, 0, 24)
    DescLabel.BackgroundTransparency = 1
    DescLabel.Text = "Загрузка..."
    DescLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
    DescLabel.TextSize = 14
    DescLabel.Font = Enum.Font.SourceSans
    DescLabel.TextXAlignment = Enum.TextXAlignment.Left
    DescLabel.TextTruncate = Enum.TextTruncate.AtEnd
    DescLabel.Parent = SborkaItem

    task.spawn(function()
        local success, content = pcall(function()
            return game:HttpGet(descUrl .. "?nocache=" .. tostring(tick()), true)
        end)
        if success and content and #content > 0 then
            DescLabel.Text = content
        else
            DescLabel.Text = "Описание отсутствует"
        end
    end)

    local SettingsBtn = Instance.new("ImageButton")
    SettingsBtn.Size = UDim2.new(0, 32, 0, 32)
    SettingsBtn.Position = UDim2.new(1, -82, 0.5, -16)
    SettingsBtn.BackgroundTransparency = 1
    SettingsBtn.Image = getOnlineImage("settings.png")
    SettingsBtn.Parent = SborkaItem

    SettingsBtn.MouseEnter:Connect(function()
        TweenService:Create(SettingsBtn, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Size = UDim2.new(0, 36, 0, 36),
            Position = UDim2.new(1, -84, 0.5, -18)
        }):Play()
    end)
    SettingsBtn.MouseLeave:Connect(function()
        TweenService:Create(SettingsBtn, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Size = UDim2.new(0, 32, 0, 32),
            Position = UDim2.new(1, -82, 0.5, -16)
        }):Play()
    end)

    SettingsBtn.MouseButton1Click:Connect(function()
        openSborkaSettings(folderName, scriptsState)
    end)

    local StartBtn = Instance.new("ImageButton")
    StartBtn.Size = UDim2.new(0, 38, 0, 38)
    StartBtn.Position = UDim2.new(1, -40, 0.5, -19)
    StartBtn.BackgroundTransparency = 1
    StartBtn.Image = getOnlineImage("start.png")
    StartBtn.Parent = SborkaItem

    StartBtn.MouseEnter:Connect(function()
        TweenService:Create(StartBtn, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Size = UDim2.new(0, 44, 0, 44),
            Position = UDim2.new(1, -43, 0.5, -22)
        }):Play()
    end)
    StartBtn.MouseLeave:Connect(function()
        TweenService:Create(StartBtn, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Size = UDim2.new(0, 38, 0, 38),
            Position = UDim2.new(1, -40, 0.5, -19)
        }):Play()
    end)

    StartBtn.MouseButton1Click:Connect(function()
        closeHub(function()
            task.spawn(function()
                for _, scriptData in ipairs(scriptsState) do
                    if scriptData.enabled then
                        pcall(function()
                            local fullUrl = scriptData.url
                            if not fullUrl:find("%?") then
                                fullUrl = fullUrl .. "?nocache=" .. tostring(tick())
                            end
                            local code = game:HttpGet(fullUrl, true)
                            loadstring(code)()
                        end)
                    end
                end
            end)
        end)
    end)
end

local function loadAllScripts()
    local defaultScripts = {
        "Universal_script.lua",
        "Fly_KT.lua"
    }

    task.spawn(function()
        local htmlSuccess, htmlContent = pcall(function()
            return game:HttpGet(REPO_TREE .. "?t=" .. tostring(tick()), true)
        end)

        if htmlSuccess and type(htmlContent) == "string" then
            for file in string.gmatch(htmlContent, 'scripts/([%w_%-%.]+%.lua)') do
                createScriptCard(file, RAW_BASE .. "scripts/" .. file)
            end
            for file in string.gmatch(htmlContent, '"name":"([%w_%-%.]+%.lua)"') do
                createScriptCard(file, RAW_BASE .. "scripts/" .. file)
            end
        end

        local apiSuccess, apiContent = pcall(function()
            return game:HttpGet(API_SCRIPTS .. "?t=" .. tostring(tick()), true)
        end)

        if apiSuccess and type(apiContent) == "string" then
            local decodeOk, items = pcall(function() return HttpService:JSONDecode(apiContent) end)
            if decodeOk and type(items) == "table" then
                for _, item in ipairs(items) do
                    if item.type == "file" and string.sub(item.name:lower(), -4) == ".lua" then
                        createScriptCard(item.name, item.download_url or (RAW_BASE .. "scripts/" .. item.name))
                    end
                end
            end
        end

        for _, fileName in ipairs(defaultScripts) do
            createScriptCard(fileName, RAW_BASE .. "scripts/" .. fileName)
        end
    end)
end

local function loadAllSborks()
    local defaultSborks = {
        {
            name = "Brookhaven",
            descUrl = SBORKS_RAW .. "Brookhaven/description.txt",
            files = {
                { name = "main.lua", url = SBORKS_RAW .. "Brookhaven/main.lua" },
                { name = "script.lua", url = SBORKS_RAW .. "Brookhaven/script.lua" }
            }
        }
    }

    task.spawn(function()
        local apiSuccess, apiContent = pcall(function()
            return game:HttpGet(SBORKS_API .. "?t=" .. tostring(tick()), true)
        end)

        if apiSuccess and type(apiContent) == "string" then
            local decodeOk, items = pcall(function() return HttpService:JSONDecode(apiContent) end)
            if decodeOk and type(items) == "table" then
                for _, item in ipairs(items) do
                    if item.type == "dir" then
                        local folderName = item.name
                        local subApi = SBORKS_API .. "/" .. folderName
                        local luaFiles = {}
                        local descUrl = SBORKS_RAW .. folderName .. "/description.txt"

                        local subSuccess, subContent = pcall(function()
                            return game:HttpGet(subApi .. "?t=" .. tostring(tick()), true)
                        end)

                        if subSuccess and type(subContent) == "string" then
                            local subDecodeOk, subItems = pcall(function() return HttpService:JSONDecode(subContent) end)
                            if subDecodeOk and type(subItems) == "table" then
                                for _, subFile in ipairs(subItems) do
                                    if subFile.type == "file" and string.sub(subFile.name:lower(), -4) == ".lua" then
                                        table.insert(luaFiles, { name = subFile.name, url = subFile.download_url or (SBORKS_RAW .. folderName .. "/" .. subFile.name) })
                                    end
                                end
                            end
                        end

                        if #luaFiles == 0 then
                            table.insert(luaFiles, { name = "main.lua", url = SBORKS_RAW .. folderName .. "/main.lua" })
                            table.insert(luaFiles, { name = "script.lua", url = SBORKS_RAW .. folderName .. "/script.lua" })
                        end

                        createSborkaCard(folderName, luaFiles, descUrl)
                    end
                end
            end
        end

        local htmlSuccess, htmlContent = pcall(function()
            return game:HttpGet(SBORKS_TREE .. "?t=" .. tostring(tick()), true)
        end)

        if htmlSuccess and type(htmlContent) == "string" then
            for folderName in string.gmatch(htmlContent, 'sborks/([%w_%-]+)"') do
                local luaFiles = {
                    { name = "main.lua", url = SBORKS_RAW .. folderName .. "/main.lua" },
                    { name = "script.lua", url = SBORKS_RAW .. folderName .. "/script.lua" }
                }
                local descUrl = SBORKS_RAW .. folderName .. "/description.txt"
                createSborkaCard(folderName, luaFiles, descUrl)
            end
        end

        for _, sb in ipairs(defaultSborks) do
            createSborkaCard(sb.name, sb.files, sb.descUrl)
        end
    end)
end

loadAllScripts()
loadAllSborks()

TweenService:Create(Container, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
    Size = targetSize,
    Position = targetPos
}):Play()
