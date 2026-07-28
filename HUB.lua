local TweenService = game:GetService("TweenService")
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

local RAW_BASE = "https://raw.githubusercontent.com/kryytoi/KrakenTeamScript/main/"
local ICONS_BASE = RAW_BASE .. "icons/"
local REPO_TREE = "https://github.com/kryytoi/KrakenTeamScript/tree/main/scripts"
local API_SCRIPTS = "https://api.github.com/repos/kryytoi/KrakenTeamScript/contents/scripts"

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
SideBarLayout.Padding = UDim.new(0, 30)

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
createNavButton("settings.png", 2, function() switchTab(SettingsTab) end)
createNavButton("exit.png", 3, function() closeHub() end)

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

loadAllScripts()

TweenService:Create(Container, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
    Size = targetSize,
    Position = targetPos
}):Play()
