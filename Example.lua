-- ========== LOAD NOIRUI ==========
local NoirUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/NoirGoodBoi/UI/refs/heads/main/Main.lua"))()

-- ========== CÀI ĐẶT BACKGROUND ==========
local bgID = 1234567890  -- Thay ID ảnh của bạn

-- ========== TẠO CỬA SỔ ==========
local Window = NoirUI:CreateWindow({
    Name = "🔥 ADMIN HUB PRO 🔥",
    Accent = Color3.fromRGB(255, 50, 100),
    Icon = "👑",
    
    Background = {
        Image = bgID,
        Transparency = 0.4
    },
    
    MainBgColor = Color3.fromRGB(0, 0, 0),
    MainBgTransparency = 0.3,
    SidebarTransparency = 0.5,
    ContentTransparency = 0.2,
    
    KeySystem = true,
    KeySettings = {
        Key = {"free123", "vip456"},
        SaveKey = true,
        FileName = "AdminHubKey",
        Title = "🔐 ADMIN HUB",
        Subtitle = "Nhập key để tiếp tục",
        Note = "Mua key VIP tại discord.gg/adminhub"
    }
})

-- ========== ĐĂNG KÝ COMMAND ==========
NoirUI:RegisterCommand("heal", function(args)
    local char = game.Players.LocalPlayer.Character
    if char and char:FindFirstChild("Humanoid") then
        char.Humanoid.Health = 100
        NoirUI:Notify("💚 Heal", "Đã hồi 100 máu!")
    end
end)

NoirUI:RegisterCommand("speed", function(args)
    local speed = tonumber(args[1]) or 16
    local char = game.Players.LocalPlayer.Character
    if char and char:FindFirstChild("Humanoid") then
        char.Humanoid.WalkSpeed = speed
        NoirUI:Notify("⚡ Speed", "Tốc độ: " .. speed)
    end
end)

NoirUI:RegisterCommand("tp", function(args)
    local hrp = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    
    if #args >= 3 then
        local x, y, z = tonumber(args[1]), tonumber(args[2]), tonumber(args[3])
        hrp.CFrame = CFrame.new(x, y, z)
        NoirUI:Notify("🌍 Teleport", string.format("Đã dịch đến (%.0f, %.0f, %.0f)", x, y, z))
    elseif #args == 1 then
        local target = game:GetService("Players"):FindFirstChild(args[1])
        if target and target.Character then
            hrp.CFrame = target.Character.HumanoidRootPart.CFrame
            NoirUI:Notify("🌍 Teleport", "Đã dịch đến " .. target.Name)
        end
    end
end)

local isFlying = false
local bodyVel = nil

NoirUI:RegisterCommand("fly", function(args)
    local hrp = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    
    if not isFlying and hrp then
        isFlying = true
        bodyVel = Instance.new("BodyVelocity")
        bodyVel.MaxForce = Vector3.new(10000, 10000, 10000)
        bodyVel.Velocity = Vector3.new(0, 0, 0)
        bodyVel.Parent = hrp
        NoirUI:Notify("🕊️ Fly", "Đã bật bay!")
    elseif isFlying then
        if bodyVel then bodyVel:Destroy() end
        isFlying = false
        NoirUI:Notify("🕊️ Fly", "Đã tắt bay!")
    end
end)

NoirUI:RegisterCommand("unload", function(args)
    local gui = game.CoreGui:FindFirstChild("NoirUI_V3_Ultimate")
    if gui then gui:Destroy() end
end)

-- ========== TẠO TAB ==========
local PlayerTab = Window:CreateTab("👤 Player", "user")
local CombatTab = Window:CreateTab("⚔️ Combat", "sword")
local VisualTab = Window:CreateTab("👁️ Visual", "eye")
local TeleportTab = Window:CreateTab("🌍 Teleport", "map-pin")
local ConsoleTab = Window:CreateTab("⌨️ Console", "terminal")

-- ========== TAB PLAYER ==========
PlayerTab:CreateSection("🎮 THÔNG TIN")
PlayerTab:CreateLabel("Username: " .. game.Players.LocalPlayer.Name)
PlayerTab:CreateLabel("User ID: " .. game.Players.LocalPlayer.UserId)

local pingLabel = PlayerTab:CreateLabel("Ping: Đang đo...")
task.spawn(function()
    while true do
        local ping = game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValue()
        pingLabel:Set("📡 Ping: " .. math.floor(ping) .. " ms")
        task.wait(1)
    end
end)

PlayerTab:CreateSection("💪 TÙY CHỈNH")
PlayerTab:CreateSlider({
    Name = "WalkSpeed",
    Min = 16,
    Max = 250,
    Default = 16,
    Callback = function(v)
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = v
    end
})

PlayerTab:CreateSlider({
    Name = "JumpPower",
    Min = 50,
    Max = 300,
    Default = 50,
    Callback = function(v)
        game.Players.LocalPlayer.Character.Humanoid.JumpPower = v
    end
})

-- ========== TAB COMBAT ==========
CombatTab:CreateSection("⚔️ CHIẾN ĐẤU")

local autoFarm = false
CombatTab:CreateToggle({
    Name = "🤖 Auto Farm",
    Default = false,
    Callback = function(state)
        autoFarm = state
        NoirUI:Notify("Auto Farm", state and "Đã bật" or "Đã tắt")
    end
})

CombatTab:CreateButton({
    Name = "💥 Tấn công",
    Callback = function()
        NoirUI:Notify("Combat", "Đã tấn công!")
    end
})

CombatTab:CreateButton({
    Name = "🔄 Reset Character",
    Align = false,
    Callback = function()
        game.Players.LocalPlayer.Character.Humanoid.Health = 0
        NoirUI:Notify("🔄 Reset", "Đã reset nhân vật!")
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
    end
})

VisualTab:CreateColorPicker({
    Name = "🌈 Màu ESP",
    Default = Color3.fromRGB(255, 0, 0),
    Callback = function(color)
        print("ESP Color changed to:", color)
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

local function getPlayerList()
    local players = {}
    for _, v in pairs(game:GetService("Players"):GetPlayers()) do
        table.insert(players, v.Name)
    end
    return players
end

TeleportTab:CreateDropdown({
    Name = "👥 TP đến player",
    GetOptions = getPlayerList,
    RefreshOnOpen = true,
    Callback = function(selected)
        local target = game:GetService("Players"):FindFirstChild(selected)
        if target and target.Character then
            local hrp = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            if hrp then
                hrp.CFrame = target.Character.HumanoidRootPart.CFrame
                NoirUI:Notify("Teleport", "Đã đến " .. selected)
            end
        end
    end
})

-- ========== TAB CONSOLE ==========
ConsoleTab:CreateRunBox({
    Placeholder = "Nhập lệnh: .heal, .speed 100, .fly, .tp 0 100 0, loadstring('url')...",
    ClearOnExecute = true
})

ConsoleTab:CreateSection("📋 DANH SÁCH LỆNH")
ConsoleTab:CreateParagraph({
    Title = "Các lệnh có sẵn",
    Content = [[
.heal        - Hồi 100 máu
.speed 50    - Đổi tốc độ
.fly         - Bật/tắt bay
.tp x y z    - Teleport theo tọa độ
.tp Tên      - Teleport đến người chơi
.unload      - Tắt UI
]]
})

-- ========== THÔNG BÁO KHỞI TẠO ==========
task.wait(2)
NoirUI:Notify("🔥 ADMIN HUB PRO", "Đã tải thành công! Dùng .heal để test lệnh.")
