📘 NOIRUI - HƯỚNG DẪN SỬ DỤNG A-Z (SIÊU CHI TIẾT)

---

MỤC LỤC

1. Giới thiệu
2. Tải và khởi tạo
3. Cấu hình cửa sổ & Background
4. Hệ thống Key
5. Tạo Tab
6. Các thành phần UI
7. Custom Commands
8. RunBox - Thực thi lệnh
9. Notifications
10. Ví dụ hoàn chỉnh
11. Mẹo & Thủ thuật

---

1. GIỚI THIỆU

NoirUI là thư viện giao diện người dùng (UI Library) cho Roblox Executor, với các tính năng:

Tính năng Mô tả
🎨 Custom Background Hỗ trợ ảnh nền từ ID Roblox, URL, rbxasset
🖱️ Kéo thả Cửa sổ chính và nút float kéo thả độc lập
🔐 Key System Bảo vệ UI bằng key, lưu key vào file
🌈 Hiệu ứng cầu vồng Viền UI chuyển màu liên tục
📱 Hỗ trợ Mobile Touch-friendly, kéo thả bằng tay
🔍 Search Bar Tìm kiếm nội dung trong từng tab
⌨️ RunBox đa năng Custom command, loadstring, required, lua code
💬 Notifications Thông báo đẹp mắt, tự động biến mất

---

2. TẢI VÀ KHỞI TẠO

```lua
-- Cách 1: Load từ URL (khuyến nghị)
local NoirUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/NoirGoodBoi/UI/refs/heads/main/Main.lua"))()

-- Cách 2: Nếu file đã được lưu local (ko nên dùng lắm)
-- local NoirUI = loadstring(readfile("NoirUI.lua"))()
```

---

3. CẤU HÌNH CỬA SỔ & BACKGROUND

Cấu trúc đầy đủ:

```lua
local Window = NoirUI:CreateWindow({
    -- === CƠ BẢN ===
    Name = "Tên UI",                          -- Tiêu đề header
    Accent = Color3.fromRGB(170, 85, 255),    -- Màu chủ đạo
    Icon = "🚀",                               -- Icon nút float (emoji hoặc ID)
    LogoID = 1234567890,                      -- Logo header (Image ID)
    
    -- === VỊ TRÍ ===
    DefaultPosition = UDim2.new(0.5, -210, 0.5, -150),  -- Vị trí main UI
    FloatDefaultPosition = UDim2.new(0, 15, 0.5, -22),   -- Vị trí nút float
    
    -- === BACKGROUND CHO MAIN UI ===
    Background = {
        Image = 1234567890,          -- ID Roblox (number)
        -- Hoặc: Image = "rbxassetid://1234567890"
        -- Hoặc: Image = "https://example.com/bg.png"
        -- Hoặc: Image = "rbxasset://textures/ui/Gradient.png"
        Transparency = 0.5           -- Độ mờ (0-1)
    },
    
    -- === BACKGROUND CHO LOADING ===
    LoadingBackground = {
        Image = 1234567890,
        Transparency = 0.3
    },
    
    -- === BACKGROUND CHO KEY UI ===
    KeyBackground = {
        Image = 1234567890,
        Transparency = 0.4
    },
    
    -- === BACKGROUND CHO NOTIFICATION ===
    NotificationBackground = {
        Image = 1234567890,
        Transparency = 0.2
    },
    
    -- === BACKGROUND CHO FLOAT BUTTON ===
    FloatBackground = {
        Image = 1234567890,
        Transparency = 0.3
    },
    
    -- === ĐỘ TRONG SUỐT CÁC THÀNH PHẦN ===
    MainBgColor = Color3.fromRGB(10, 10, 10),  -- Màu nền main
    MainBgTransparency = 0,                    -- Độ mờ nền main
    SidebarTransparency = 0.5,                -- Độ mờ sidebar 
    ContentTransparency = 0.3,                -- Độ mờ vùng nội dung
    
    -- === HỆ THỐNG KEY ===
    KeySystem = true,                          -- Bật/tắt key system
    KeySettings = {
        Key = {"key1", "key2"},                -- Một hoặc nhiều key
        SaveKey = true,                        -- Lưu key vào file
        FileName = "MyHubKey",                 -- Tên file lưu key
        Title = "🔐 WELCOME",                  -- Tiêu đề key window
        Subtitle = "Nhập key để tiếp tục",     -- Subtitle
        Note = "Mua key tại discord.gg/xxx"    -- Ghi chú
    }
})
```

Ví dụ background đẹp:

```lua
local Window = NoirUI:CreateWindow({
    Name = "✨ ANIME HUB ✨",
    Accent = Color3.fromRGB(255, 100, 150),
    Icon = "🌸",
    
    -- Background anime cho main UI
    Background = {
        Image = "rbxassetid://1234567890",  -- Thay ID của bạn
        Transparency = 0.4
    },
    
    -- Main UI màu đen mờ
    MainBgColor = Color3.fromRGB(0, 0, 0),
    MainBgTransparency = 0.3,
    SidebarTransparency = 0.6,
    ContentTransparency = 0.2,
    
    KeySystem = false
})
```

---

4. HỆ THỐNG KEY

Bật Key System:

```lua
KeySystem = true,
KeySettings = {
    Key = "free123",                    -- Một key
    -- Hoặc nhiều key: Key = {"free123", "vip456", "admin789"},
    SaveKey = true,                     -- Lưu key (không cần nhập lại)
    FileName = "MyKey",                 -- Tên file lưu
    Title = "🔐 KEY SYSTEM",            -- Tiêu đề
    Subtitle = "Nhập key để tiếp tục",  -- Phụ đề
    Note = "Liên hệ admin để lấy key"   -- Ghi chú
}
```

Tắt Key System:

```lua
KeySystem = false   -- UI hiện loading ngay lập tức
```

Luồng hoạt động Key:

```
Chạy script → Kiểm tra file key đã lưu chưa?
                ↓
         Đã lưu → So khớp → Đúng → Hiện loading → UI chính
                ↓
         Chưa lưu → Hiện bảng key → Nhập key → Đúng → Lưu → Loading → UI
                                                ↓
                                          Sai → Báo lỗi, nhập lại
```

---

5. TẠO TAB

```lua
-- Có icon (Image ID)
local CombatTab = Window:CreateTab("⚔️ Combat", 1234567890)

-- Không icon
local VisualTab = Window:CreateTab("👁️ Visual")

-- Chỉ emoji
local PlayerTab = Window:CreateTab("👤 Player")
```

---

6. CÁC THÀNH PHẦN UI

6.1 CreateLabel - Nhãn văn bản

```lua
CombatTab:CreateLabel("Thông tin người chơi")
CombatTab:CreateLabel("Username: " .. game.Players.LocalPlayer.Name)
```

Công dụng: Hiển thị văn bản đơn giản, không tương tác.

---

6.2 CreateParagraph - Đoạn văn dài

```lua
VisualTab:CreateParagraph({
    Title = "🎨 Hướng dẫn sử dụng",
    Content = "Đây là nội dung hướng dẫn chi tiết.\nBạn có thể xuống dòng bằng \\n."
})
```

Công dụng: Hiển thị đoạn văn bản có tiêu đề và nội dung.

---

6.3 CreateButton - Nút bấm

```lua
CombatTab:CreateButton({
    Name = "💥 Tấn công",
    Callback = function()
        print("Đã tấn công!")
        NoirUI:Notify("Combat", "Bạn đã tấn công!")
    end
})
```

Công dụng: Tạo nút có thể click, thực thi callback.

---

6.4 CreateToggle - Công tắc bật/tắt

```lua
local autoFarm = false
CombatTab:CreateToggle({
    Name = "🤖 Auto Farm",
    Default = false,      -- Trạng thái ban đầu
    Callback = function(state)
        autoFarm = state
        NoirUI:Notify("Auto Farm", state and "Đã bật" or "Đã tắt")
    end
})
```

Công dụng: Tạo switch bật/tắt, trả về trạng thái boolean.

---

6.5 CreateSlider - Thanh trượt

```lua
VisualTab:CreateSlider({
    Name = "🎯 WalkSpeed",
    Min = 16,
    Max = 250,
    Default = 16,
    Callback = function(value)
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = value
        NoirUI:Notify("Speed", "Đã set: " .. value)
    end
})
```

Công dụng: Điều chỉnh giá trị số trong khoảng min-max.

---

6.6 CreateTextBox - Ô nhập văn bản

```lua
PlayerTab:CreateTextBox({
    Name = "💬 Nhập tin nhắn",
    Callback = function(text)
        if text ~= "" then
            game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(text, "All")
        end
    end
})
```

Công dụng: Nhập văn bản, callback khi mất focus.

---

6.7 CreateDropdown - Danh sách chọn

```lua
VisualTab:CreateDropdown({
    Name = "🎒 Chọn vũ khí",
    Options = {"🔫 AK-47", "🔪 Knife", "💣 Grenade"},
    Default = "🔫 AK-47",
    Callback = function(selected)
        NoirUI:Notify("Weapon", "Đã trang bị: " .. selected)
    end
})
```

Đặc điểm: Có mũi tên xoay khi mở/đóng.

---

6.8 CreateColorPicker - Bảng chọn màu

```lua
VisualTab:CreateColorPicker({
    Name = "🎨 Màu chữ",
    Default = Color3.fromRGB(255, 255, 255),
    Callback = function(color)
        print("Màu đã chọn:", color)
        NoirUI:Notify("Color", "Đã đổi màu!")
    end
})
```

Đặc điểm: Bảng màu HSV đầy đủ, có thể kéo thả chọn màu.

---

6.9 CreateRunBox - Ô thực thi lệnh

```lua
local ConsoleTab = Window:CreateTab("💻 Console")
ConsoleTab:CreateRunBox({
    Placeholder = "Nhập lệnh: .heal, loadstring('url'), hoặc Lua code...",
    ClearOnExecute = true   -- Xóa text sau khi chạy
})
```

Xem chi tiết ở mục 8.

---

6.10 CreateSection - Dòng phân cách

```lua
CombatTab:CreateSection("⚔️ CHIẾN ĐẤU")
CombatTab:CreateButton({ Name = "Tấn công", ... })
CombatTab:CreateSection("🛡️ PHÒNG THỦ")
```

Công dụng: Phân nhóm các thành phần trong tab.

---

7. CUSTOM COMMANDS

Cú pháp đăng ký:

```lua
NoirUI:RegisterCommand("tên_lệnh", function(args)
    -- Xử lý lệnh
    -- args là table chứa các tham số
end)
```

Ví dụ các lệnh cơ bản:

```lua
-- Lệnh .heal
NoirUI:RegisterCommand("heal", function(args)
    game.Players.LocalPlayer.Character.Humanoid.Health = 100
    NoirUI:Notify("💚 Heal", "Đã hồi 100 máu!")
end)

-- Lệnh .speed [tốc độ]
NoirUI:RegisterCommand("speed", function(args)
    local speed = tonumber(args[1]) or 16
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = speed
    NoirUI:Notify("⚡ Speed", "Speed: " .. speed)
end)

-- Lệnh .tp [x] [y] [z] hoặc .tp [tên]
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

-- Lệnh .fly (bật/tắt bay)
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
        NoirUI:Notify("🕊️ Fly", "Đã bật bay! Dùng WASD + Space/Ctrl")
    elseif isFlying then
        if bodyVel then bodyVel:Destroy() end
        isFlying = false
        NoirUI:Notify("🕊️ Fly", "Đã tắt bay!")
    end
end)

-- Lệnh .god (bật/tắt bất tử)
local godMode = false
NoirUI:RegisterCommand("god", function(args)
    local humanoid = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")
    if humanoid then
        godMode = not godMode
        if godMode then
            humanoid:GetPropertyChangedSignal("Health"):Connect(function()
                if humanoid.Health <= 0 and godMode then
                    humanoid.Health = 100
                end
            end)
            NoirUI:Notify("👑 God Mode", "Đã bật bất tử!")
        else
            NoirUI:Notify("👑 God Mode", "Đã tắt bất tử!")
        end
    end
end)

-- Lệnh .unload (tắt UI)
NoirUI:RegisterCommand("unload", function(args)
    game.CoreGui:FindFirstChild("NoirUI_V3_Ultimate"):Destroy()
end)
```

---

8. RUNBOX - THỰC THI LỆNH

Các loại lệnh được hỗ trợ:

Loại Cú pháp Ví dụ Kết quả
Custom Command .tên_lệnh .heal Chạy lệnh đã đăng ký
Custom Command có tham số .tên_lệnh tham số .speed 100 Truyền tham số vào lệnh
Loadstring loadstring("code") loadstring(game:HttpGet("url"))() Tải và chạy script từ URL
Required required("TênModule") required("ChatModule") Gọi module client-side
Lua code Câu lệnh Lua print("Hello") Thực thi trực tiếp

Ví dụ trong RunBox:

```
.heal                    → Hồi máu
.speed 100               → Tăng tốc lên 100
.fly                     → Bật/tắt bay
.tp 0 100 0              → Bay lên độ cao 100
.tp Admin                → Teleport đến player Admin
.god                     → Bật bất tử
.unload                  → Tắt UI
loadstring(game:HttpGet("https://example.com/script.lua"))()
print("Hello World")
for i = 1, 10 do print(i) end
```

---

9. NOTIFICATIONS

```lua
-- Cú pháp cơ bản
NoirUI:Notify("Tiêu đề", "Nội dung thông báo")

-- Ví dụ
NoirUI:Notify("✅ Thành công", "Đã thực hiện hành động!")
NoirUI:Notify("⚠️ Cảnh báo", "Có lỗi xảy ra!")
NoirUI:Notify("💀 Kill", "Đã tiêu diệt kẻ địch!")
NoirUI:Notify("🎉 Chúc mừng", "Bạn đã chiến thắng!")
```

Đặc điểm:

· Độ mờ 0.25
· Tự động xếp chồng lên nhau
· Tự động biến mất sau 4 giây
· Có hiệu ứng xuất hiện mượt mà

---

10. VÍ DỤ HOÀN CHỈNH

```lua
-- ========== LOAD NOIRUI ==========
local NoirUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/NoirGoodBoi/UI/refs/heads/main/Main.lua"))()

-- ========== CÀI ĐẶT BACKGROUND ==========
local bgID = 1234567890  -- Thay ID ảnh của bạn

-- ========== TẠO CỬA SỔ ==========
local Window = NoirUI:CreateWindow({
    Name = "🔥 GOD MODE HUB 🔥",
    Accent = Color3.fromRGB(255, 50, 100),
    Icon = "👑",
    
    -- Background đẹp
    Background = {
        Image = bgID,
        Transparency = 0.4
    },
    
    LoadingBackground = {
        Image = bgID,
        Transparency = 0.3
    },
    
    MainBgColor = Color3.fromRGB(0, 0, 0),
    MainBgTransparency = 0.3,
    SidebarTransparency = 0.5,
    ContentTransparency = 0.2,
    
    KeySystem = false
})

-- ========== ĐĂNG KÝ COMMAND ==========
NoirUI:RegisterCommand("heal", function(args)
    game.Players.LocalPlayer.Character.Humanoid.Health = 100
    NoirUI:Notify("💚 Heal", "Đã hồi 100 máu!")
end)

NoirUI:RegisterCommand("speed", function(args)
    local speed = tonumber(args[1]) or 16
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = speed
    NoirUI:Notify("⚡ Speed", "Tốc độ: " .. speed)
end)

-- Lệnh fly
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

-- Lệnh tp
NoirUI:RegisterCommand("tp", function(args)
    local hrp = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    
    if #args >= 3 then
        hrp.CFrame = CFrame.new(tonumber(args[1]), tonumber(args[2]), tonumber(args[3]))
        NoirUI:Notify("🌍 Teleport", "Đã dịch chuyển!")
    elseif #args == 1 then
        local target = game:GetService("Players"):FindFirstChild(args[1])
        if target and target.Character then
            hrp.CFrame = target.Character.HumanoidRootPart.CFrame
            NoirUI:Notify("🌍 Teleport", "Đã đến " .. target.Name)
        end
    end
end)

-- ========== TẠO TAB ==========
local PlayerTab = Window:CreateTab("👤 Player")
local CombatTab = Window:CreateTab("⚔️ Combat")
local VisualTab = Window:CreateTab("👁️ Visual")
local TeleportTab = Window:CreateTab("🌍 Teleport")
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
    Callback = function()
        game.Players.LocalPlayer.Character.Humanoid.Health = 0
    end
})

-- ========== TAB VISUAL ==========
VisualTab:CreateSection("🎨 ESP SETTINGS")

VisualTab:CreateToggle({
    Name = "🔴 Bật ESP",
    Default = false,
    Callback = function(state)
        NoirUI:Notify("ESP", state and "Đã bật" or "Đã tắt")
    end
})

VisualTab:CreateColorPicker({
    Name = "🌈 Màu ESP",
    Default = Color3.fromRGB(255, 0, 0),
    Callback = function(color)
        print("ESP Color changed")
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

-- Lấy danh sách player
local players = {}
for _, v in pairs(game:GetService("Players"):GetPlayers()) do
    table.insert(players, v.Name)
end

TeleportTab:CreateDropdown({
    Name = "👥 TP đến player",
    Options = players,
    Default = game.Players.LocalPlayer.Name,
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
.heal      - Hồi 100 máu
.speed 50  - Đổi tốc độ
.fly       - Bật/tắt bay
.tp x y z  - Teleport theo tọa độ
.tp Tên    - Teleport đến người chơi
.god       - Bật/tắt bất tử
.unload    - Tắt UI
]]
})

-- ========== THÔNG BÁO ==========
task.wait(2)
NoirUI:Notify("🔥 GOD MODE HUB", "Đã tải thành công! Dùng .heal để test lệnh.")
```

---

11. MẸO & THỦ THUẬT

11.1 Lưu cài đặt người dùng

```lua
local settings = {
    walkSpeed = 16,
    autoFarm = false
}

-- Lưu khi thay đổi
PlayerTab:CreateSlider({
    Name = "WalkSpeed",
    Min = 16, Max = 250, Default = settings.walkSpeed,
    Callback = function(v)
        settings.walkSpeed = v
        if writefile then
            writefile("settings.json", HttpService:JSONEncode(settings))
        end
    end
})

-- Đọc khi khởi động
if isfile and isfile("settings.json") then
    settings = HttpService:JSONDecode(readfile("settings.json"))
end
```

11.2 Tạo command có nhiều tham số

```lua
NoirUI:RegisterCommand("give", function(args)
    -- .give weapon AK47
    local itemType = args[1]  -- "weapon"
    local itemName = args[2]  -- "AK47"
    print("Giving", itemName, "of type", itemType)
end)
```

11.3 Tạo admin command

```lua
local admins = {"AdminUser1", "AdminUser2"}

NoirUI:RegisterCommand("ban", function(args)
    local player = game:GetService("Players"):FindFirstChild(args[1])
    if player and table.find(admins, game.Players.LocalPlayer.Name) then
        player:Kick("Banned by admin")
    end
end)
```

11.4 Animation cho button (tự thêm)

```lua
-- Thêm vào sau khi tạo button
local function addButtonAnimation(button)
    button.MouseButton1Down:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.1), {Size = UDim2.new(0.95, 0, 0, 33)}):Play()
    end)
    button.MouseButton1Up:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.1), {Size = UDim2.new(0.95, 0, 0, 35)}):Play()
    end)
end
```

11.5 Keybind để mở UI

```lua
local UIS = game:GetService("UserInputService")
UIS.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and input.KeyCode == Enum.KeyCode.RightShift then
        local mainFrame = game.CoreGui:FindFirstChild("NoirUI_V3_Ultimate")
        if mainFrame then
            local mainUI = mainFrame:FindFirstChild("Frame")
            if mainUI then
                mainUI.Visible = not mainUI.Visible
            end
        end
    end
end)
```

---

📌 TỔNG KẾT CÁC THAM SỐ NHANH

Thành phần Tham số bắt buộc Tham số tùy chọn
CreateWindow - Name, Accent, Icon, Background, KeySystem...
CreateTab name icon
CreateLabel text -
CreateParagraph Title, Content -
CreateButton Name, Callback -
CreateToggle Name, Callback Default
CreateSlider Name, Min, Max, Default, Callback -
CreateTextBox Name, Callback -
CreateDropdown Name, Options, Callback Default
CreateColorPicker Name, Callback Default
CreateRunBox - Placeholder, ClearOnExecute
CreateSection text -

---

🎉 CHÚC BẠN THÀNH CÔNG VỚI NOIRUI! 🚀
