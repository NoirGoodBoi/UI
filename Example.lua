-- ========== LOAD NOIRUI ==========
local NoirUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/NoirGoodBoi/UI/refs/heads/main/Main.lua"))()

-- ========== TẠO CỬA SỔ CHÍNH ==========
local Window = NoirUI:CreateWindow({
    Name = "🔥 GOD MODE HUB 🔥",
    Accent = Color3.fromRGB(255, 50, 100),
    LogoID = nil,
    Icon = "👑",  -- Emoji hoặc Image ID
    DefaultPosition = UDim2.new(0.5, -210, 0.5, -150),
    FloatDefaultPosition = UDim2.new(0, 15, 0.5, -22),
    
    -- BẬT KEY SYSTEM (tùy chọn)
    KeySystem = true,
    KeySettings = {
        Key = {"free123", "vip2024", "admin"},  -- Nhiều key
        SaveKey = true,
        FileName = "GodModeKey",
        Title = "🔐 GOD MODE HUB",
        Subtitle = "Nhập key để vào hub",
        Note = "Key: free123 | Mua key VIP tại discord.gg/xxx"
    }
})

-- ========== ĐĂNG KÝ CUSTOM COMMAND (Dùng trong RunBox) ==========
-- Lệnh .heal - Hồi máu
NoirUI:RegisterCommand("heal", function(args)
    local player = game.Players.LocalPlayer
    if player.Character and player.Character:FindFirstChild("Humanoid") then
        player.Character.Humanoid.Health = 100
        NoirUI:Notify("💚 Heal", "Đã hồi 100 máu!")
    end
end)

-- Lệnh .speed - Thay đổi tốc độ
NoirUI:RegisterCommand("speed", function(args)
    local speed = tonumber(args[1]) or 16
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = speed
    NoirUI:Notify("⚡ Speed", "Tốc độ: " .. speed)
end)

-- Lệnh .fly - Bật/tắt bay
local isFlying = false
local bodyVel = nil
NoirUI:RegisterCommand("fly", function(args)
    local player = game.Players.LocalPlayer
    local char = player.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    
    if not isFlying then
        if hrp then
            isFlying = true
            bodyVel = Instance.new("BodyVelocity")
            bodyVel.MaxForce = Vector3.new(10000, 10000, 10000)
            bodyVel.Velocity = Vector3.new(0, 0, 0)
            bodyVel.Parent = hrp
            NoirUI:Notify("🕊️ Fly", "Đã bật bay!")
        end
    else
        if bodyVel then bodyVel:Destroy() end
        isFlying = false
        NoirUI:Notify("🕊️ Fly", "Đã tắt bay!")
    end
end)

-- Lệnh .tp - Teleport theo tọa độ hoặc đến player
NoirUI:RegisterCommand("tp", function(args)
    local player = game.Players.LocalPlayer
    local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    
    if #args >= 3 then
        local x, y, z = tonumber(args[1]), tonumber(args[2]), tonumber(args[3])
        hrp.CFrame = CFrame.new(x, y, z)
        NoirUI:Notify("🌍 Teleport", string.format("Đã dịch đến (%.0f, %.0f, %.0f)", x, y, z))
    elseif #args == 1 then
        local target = game:GetService("Players"):FindFirstChild(args[1])
        if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
            hrp.CFrame = target.Character.HumanoidRootPart.CFrame
            NoirUI:Notify("🌍 Teleport", "Đã dịch đến " .. target.Name)
        end
    end
end)

-- Lệnh .god - Bật bất tử
NoirUI:RegisterCommand("god", function(args)
    local player = game.Players.LocalPlayer
    local humanoid = player.Character and player.Character:FindFirstChild("Humanoid")
    if humanoid then
        humanoid:GetPropertyChangedSignal("Health"):Connect(function()
            if humanoid.Health <= 0 then
                humanoid.Health = 100
            end
        end)
        NoirUI:Notify("👑 God Mode", "Đã bật bất tử!")
    end
end)

-- Lệnh .unload - Tắt UI
NoirUI:RegisterCommand("unload", function(args)
    local gui = game.CoreGui:FindFirstChild("NoirUI_V3_Ultimate")
    if gui then gui:Destroy() end
end)

-- ========== TẠO CÁC TAB ==========
local PlayerTab = Window:CreateTab("👤 Player")
local CombatTab = Window:CreateTab("⚔️ Combat")
local VisualTab = Window:CreateTab("👁️ Visual")
local TeleportTab = Window:CreateTab("🌍 Teleport")
local ScriptTab = Window:CreateTab("💻 Script")
local ConsoleTab = Window:CreateTab("⌨️ Console")

-- ========== TAB PLAYER ==========
PlayerTab:CreateSection("🎮 THÔNG TIN")
PlayerTab:CreateLabel("Username: " .. game.Players.LocalPlayer.Name)
PlayerTab:CreateLabel("User ID: " .. game.Players.LocalPlayer.UserId)

PlayerTab:CreateSection("💪 TÙY CHỈNH")
PlayerTab:CreateSlider({
    Name = "WalkSpeed",
    Min = 16,
    Max = 250,
    Default = 16,
    Callback = function(value)
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = value
        NoirUI:Notify("Speed", "Đã set: " .. value)
    end
})

PlayerTab:CreateSlider({
    Name = "JumpPower",
    Min = 50,
    Max = 300,
    Default = 50,
    Callback = function(value)
        game.Players.LocalPlayer.Character.Humanoid.JumpPower = value
    end
})

PlayerTab:CreateTextBox({
    Name = "🏷️ Đổi tên (fake)",
    Callback = function(text)
        if text ~= "" then
            game.Players.LocalPlayer.DisplayName = text
            NoirUI:Notify("Name", "Đã đổi tên thành: " .. text)
        end
    end
})

-- ========== TAB COMBAT ==========
CombatTab:CreateSection("⚔️ CHIẾN ĐẤU")

local autoFarm = false
local farmConnection = nil

CombatTab:CreateToggle({
    Name = "🤖 Auto Farm",
    Default = false,
    Callback = function(state)
        autoFarm = state
        if state then
            NoirUI:Notify("Auto Farm", "Đã bắt đầu farm!")
            -- Code auto farm ở đây
        else
            NoirUI:Notify("Auto Farm", "Đã dừng farm!")
            if farmConnection then farmConnection:Disconnect() end
        end
    end
})

CombatTab:CreateButton({
    Name = "💥 Tấn công",
    Callback = function()
        NoirUI:Notify("Combat", "Đã tấn công!")
        print("Attacked!")
    end
})

CombatTab:CreateButton({
    Name = "🔄 Reset Character",
    Callback = function()
        game.Players.LocalPlayer.Character.Humanoid.Health = 0
        NoirUI:Notify("Reset", "Đã reset nhân vật!")
    end
})

-- ========== TAB VISUAL ==========
VisualTab:CreateSection("🎨 ESP SETTINGS")

local espEnabled = false
VisualTab:CreateToggle({
    Name = "🔴 Bật ESP",
    Default = false,
    Callback = function(state)
        espEnabled = state
        NoirUI:Notify("ESP", state and "Đã bật" or "Đã tắt")
        -- Code ESP ở đây
    end
})

VisualTab:CreateColorPicker({
    Name = "🌈 Màu ESP",
    Default = Color3.fromRGB(255, 0, 0),
    Callback = function(color)
        print("ESP Color:", color)
        NoirUI:Notify("Color", "Đã đổi màu ESP!")
    end
})

VisualTab:CreateSlider({
    Name = "🎯 Độ nhạy Aimbot",
    Min = 1,
    Max = 20,
    Default = 10,
    Callback = function(value)
        print("Aimbot sensitivity:", value)
    end
})

VisualTab:CreateDropdown({
    Name = "🎯 Chọn bộ phận",
    Options = {"Head", "Chest", "Legs"},
    Default = "Head",
    Callback = function(selected)
        NoirUI:Notify("Target", "Đã chọn: " .. selected)
    end
})

-- ========== TAB TELEPORT ==========
TeleportTab:CreateSection("📍 TELEPORT")
TeleportTab:CreateParagraph({
    Title = "📖 Hướng dẫn",
    Content = "Dùng lệnh .tp x y z trong Console tab\nVí dụ: .tp 0 50 0"
})

TeleportTab:CreateButton({
    Name = "🌍 TP về Spawn",
    Callback = function()
        local hrp = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if hrp then
            hrp.CFrame = CFrame.new(0, 50, 0)
            NoirUI:Notify("Teleport", "Đã về spawn!")
        end
    end
})

-- Lấy danh sách player cho dropdown
local playerList = {}
for _, v in pairs(game:GetService("Players"):GetPlayers()) do
    table.insert(playerList, v.Name)
end

TeleportTab:CreateDropdown({
    Name = "👥 Teleport đến player",
    Options = playerList,
    Default = game.Players.LocalPlayer.Name,
    Callback = function(selected)
        local target = game:GetService("Players"):FindFirstChild(selected)
        if target and target.Character then
            local hrp = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            if hrp then
                hrp.CFrame = target.Character.HumanoidRootPart.CFrame
                NoirUI:Notify("Teleport", "Đã dịch đến " .. selected)
            end
        end
    end
})

-- ========== TAB SCRIPT ==========
ScriptTab:CreateSection("📜 SCRIPT LOADER")
ScriptTab:CreateTextBox({
    Name = "🔗 URL Script",
    Callback = function(url)
        if url ~= "" then
            local success, err = pcall(function()
                loadstring(game:HttpGet(url))()
            end)
            if success then
                NoirUI:Notify("Script", "Đã load script thành công!")
            else
                NoirUI:Notify("Error", "Lỗi: " .. err)
            end
        end
    end
})

ScriptTab:CreateButton({
    Name = "🌟 Load Example Script",
    Callback = function()
        NoirUI:Notify("Script", "Đang load example...")
        -- loadstring(game:HttpGet("https://example.com/script.lua"))()
    end
})

-- ========== TAB CONSOLE (RunBox) ==========
ConsoleTab:CreateRunBox({
    Placeholder = "Nhập lệnh: .heal, .speed 50, .fly, .tp 0 50 0, loadstring('url'), hoặc lua code...",
    ClearOnExecute = true
})

ConsoleTab:CreateSection("📋 DANH SÁCH LỆNH")
ConsoleTab:CreateParagraph({
    Title = "Custom Commands",
    Content = [[
.heal      - Hồi máu 100 HP
.speed 50  - Đổi tốc độ
.fly       - Bật/tắt bay
.tp x y z  - Teleport
.tp Player - Teleport đến player
.god       - Bật bất tử
.unload    - Tắt UI
]]
})

-- ========== THÔNG BÁO KHỞI TẠO ==========
task.wait(2)  -- Chờ loading xong
NoirUI:Notify("🔥 GOD MODE HUB", "Đã tải thành công! Dùng .heal để test lệnh.")
