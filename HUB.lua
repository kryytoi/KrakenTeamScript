local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- 🔗 Ссылка на ваш скрипт на GitHub
local SCRIPT_URL = "https://raw.githubusercontent.com/kryytoi/KrakenTeamScript/main/scripts/Universal_script.lua"

-- Удаляем старый хаб, если он уже создан
if PlayerGui:FindFirstChild("KrakenScriptHub") then
    PlayerGui.KrakenScriptHub:Destroy()
end

-- 1. Создание ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "KrakenScriptHub"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = PlayerGui

-- 2. Главное окно
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

-- 3. Левая боковая панель
local SideBar = Instance.new("Frame")
SideBar.Name = "SideBar"
SideBar.Size = UDim2.new(0, 60, 1, 0)
SideBar.BackgroundColor3 = Color3.fromRGB(88, 20, 138)
SideBar.BorderSizePixel = 0
SideBar.Parent = MainFrame

local SideBarCorner = Instance.new("UICorner")
SideBarCorner.CornerRadius = UDim.new(0, 16)
SideBarCorner.Parent = SideBar

-- 4. Карточка скрипта в контейнере
local ScriptCard = Instance.new("Frame")
ScriptCard.Size = UDim2.new(0, 430, 0, 50)
ScriptCard.Position = UDim2.new(0, 75, 0, 20)
ScriptCard.BackgroundTransparency = 1
ScriptCard.Parent = MainFrame

-- Кнопка запуска (Старт)
local StartBtn = Instance.new("TextButton")
StartBtn.Size = UDim2.new(0, 40, 0, 40)
StartBtn.Position = UDim2.new(0, 0, 0.5, -20)
StartBtn.BackgroundColor3 = Color3.fromRGB(88, 20, 138)
StartBtn.Text = "⏻" -- Иконка выключения/старта юникодом
StartBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
StartBtn.TextSize = 22
StartBtn.Font = Enum.Font.SourceSansBold
StartBtn.Parent = ScriptCard

local StartCorner = Instance.new("UICorner")
StartCorner.CornerRadius = UDim.new(0, 8)
StartCorner.Parent = StartBtn

-- Название скрипта
local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(1, -50, 1, 0)
TitleLabel.Position = UDim2.new(0, 50, 0, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "Universal Script"
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.TextSize = 20
TitleLabel.Font = Enum.Font.SourceSans
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.Parent = ScriptCard

-- 🚀 Правильный запуск скрипта без синтаксических ошибок
StartBtn.MouseButton1Click:Connect(function()
    local getgenv = getgenv or function() return _G end
    
    -- Проверка наличия функции загрузки кода из сети
    if typeof(game.HttpGet) == "function" and loadstring then
        local success, err = pcall(function()
            -- ВАЖНО: Вызов game:HttpGet передаётся строкой в скобках
            local scriptContent = game:HttpGet(SCRIPT_URL, true)
            local exec = loadstring(scriptContent)
            if exec then
                exec()
            end
        end)
        
        if not success then
            warn("[Kraken Hub Error]: " .. tostring(err))
        end
    else
        warn("Запуск внешних скриптов (loadstring/HttpGet) не поддерживается в стандартной среде Roblox Studio.")
    end
    
    -- Удаляем хаб после запуска
    ScreenGui:Destroy()
end)
