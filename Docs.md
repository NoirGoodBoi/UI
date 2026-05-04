Dưới đây là HƯỚNG DẪN SỬ DỤNG A-Z cho NoirUI V3 Ultimate với toàn bộ tính năng mới:

---

📘 NOIRUI V3 ULTIMATE - HƯỚNG DẪN SỬ DỤNG A-Z

MỤC LỤC

1. Giới thiệu
2. Cách tải và khởi tạo
3. Cấu hình cửa sổ & Background
4. Hệ thống Key
5. Tạo Tab
6. Các thành phần UI cơ bản
7. Các thành phần UI nâng cao
8. Custom Commands
9. Notifications
10. Ví dụ hoàn chỉnh
11. Mẹo & Thủ thuật
12. Bảng tổng kết nhanh

---

1. GIỚI THIỆU

NoirUI V3 Ultimate là thư viện giao diện người dùng thế hệ mới dành cho Roblox Executor.

🎯 Tính năng nổi bật

Tính năng Mô tả
🎨 Custom Background Hỗ trợ ảnh nền từ ID Roblox, URL, rbxasset
🖱️ Kéo thả độc lập Cửa sổ chính và nút float có thể kéo thả riêng
🔐 Key System Pro Bảo vệ UI bằng key, lưu vào file, hỗ trợ nhiều key
🌈 Hiệu ứng cầu vồng Viền UI chuyển màu liên tục
📱 Hỗ trợ Mobile Touch-friendly, kéo thả và tương tác bằng tay
🔍 Search Bar Tìm kiếm nội dung trong tab theo thời gian thực
⌨️ RunBox đa năng Custom command, loadstring, required, lua code
💬 Notifications Thông báo xếp chồng thông minh
🎨 250+ Icon Lucide Kho icon khổng lồ, chỉ cần gọi tên
📦 Loading Effect Hiệu ứng loading đẹp mắt
🔄 Dropdown động Tự cập nhật danh sách khi mở
📝 Subtitle Mô tả chi tiết cho từng element
🎚️ Slider increment Bước nhảy tùy chỉnh
🖼️ Clipping Mask Ảnh được cắt theo khung hình

---

2. CÁCH TẢI VÀ KHỞI TẠO

Cách 1: Load từ URL (Khuyến nghị)

```lua
local NoirUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/NoirGoodBoi/UI/refs/heads/main/Main.lua"))()
```

Cách 2: Kiểm tra lỗi trước khi load

```lua
local NoirUI = nil
local url = "https://raw.githubusercontent.com/NoirGoodBoi/UI/refs/heads/main/Main.lua"

local success, result = pcall(function()
    return loadstring(game:HttpGet(url))()
end)

if success then
    NoirUI = result
    print("✅ NoirUI loaded successfully!")
else
    warn("❌ Failed to load NoirUI:", result)
end
```

---

3. CẤU HÌNH CỬA SỔ & BACKGROUND

Cấu trúc đầy đủ các tham số

```lua
local Window = NoirUI:CreateWindow({
    -- ===== CƠ BẢN =====
    Name = "Tên UI",                                    -- Tiêu đề header
    Accent = Color3.fromRGB(170, 85, 255),              -- Màu chủ đạo
    Icon = "🚀",                                         -- Icon nút float
    LogoID = "user",                                    -- Logo header (tên icon hoặc ID)
    
    -- ===== VỊ TRÍ =====
    DefaultPosition = UDim2.new(0.5, -210, 0.5, -150),  -- Vị trí main UI
    FloatDefaultPosition = UDim2.new(0, 15, 0.5, -22),  -- Vị trí nút float
    
    -- ===== BACKGROUNDS =====
    Background = {                                       -- Ảnh nền main UI
        Image = 1234567890,                             -- ID Roblox (number hoặc string)
        Transparency = 0.5                               -- Độ mờ (0 = đậm, 1 = trong suốt)
    },
    
    LoadingBackground = {                               -- Ảnh nền loading
        Image = "rbxassetid://1234567890",
        Transparency = 0.3
    },
    
    KeyBackground = {                                   -- Ảnh nền key window
        Image = "https://example.com/bg.png",
        Transparency = 0.4
    },
    
    NotificationBackground = {                          -- Ảnh nền notification
        Image = 1234567890,
        Transparency = 0.2
    },
    
    FloatBackground = {                                 -- Ảnh nền float button
        Image = 1234567890,
        Transparency = 0.3
    },
    
    -- ===== ĐỘ TRONG SUỐT =====
    MainBgColor = Color3.fromRGB(10, 10, 10),           -- Màu nền dự phòng
    MainBgTransparency = nil,                           -- Tự động: có bg = 1, không bg = 0
    SidebarTransparency = 0.5,                          -- Độ mờ sidebar
    ContentTransparency = 0.3,                          -- Độ mờ vùng nội dung
})
```

Lưu ý về Transparency:

· Nếu có Background → MainBgTransparency tự động = 1 (trong suốt)
· Nếu không có Background → MainBgTransparency tự động = 0 (đen)
· Có thể ghi đè bằng cách set MainBgTransparency thủ công

Ví dụ Background đẹp

```lua
local Window = NoirUI:CreateWindow({
    Name = "✨ ANIME HUB ✨",
    Accent = Color3.fromRGB(255, 100, 150),
    Icon = "🌸",
    LogoID = "heart",
    
    Background = {
        Image = "rbxassetid://1234567890",  -- Thay ID của bạn
        Transparency = 0.3                   -- Ảnh mờ nhẹ
    },
})
```

---

4. HỆ THỐNG KEY

Bật Key System

```lua
KeySystem = true,
KeySettings = {
    -- Key đơn
    Key = "free123",
    
    -- Hoặc nhiều key
    Key = {"free123", "vip456", "admin789"},
    
    -- Lưu key (không cần nhập lại)
    SaveKey = true,
    
    -- Tên file lưu
    FileName = "MyAwesomeHubKey",
    
    -- Giao diện key window
    Title = "🔐 KEY SYSTEM",
    Subtitle = "Nhập key để tiếp tục",
    Note = "Liên hệ admin để lấy key\nDiscord: discord.gg/xxx"
}
```

Tắt Key System

```lua
KeySystem = false   -- UI hiện loading ngay lập tức
```

---

5. TẠO TAB

Cú pháp

```lua
-- Có icon (tên Lucide hoặc Image ID)
local Tab1 = Window:CreateTab("Tên Tab", "user")

-- Không icon
local Tab2 = Window:CreateTab("Tên Tab")

-- Chỉ emoji làm icon
local Tab3 = Window:CreateTab("👤 Player")
```

Ví dụ

```lua
local CombatTab = Window:CreateTab("⚔️ Combat", "sword")
local VisualTab = Window:CreateTab("👁️ Visual", "eye")
local PlayerTab = Window:CreateTab("👤 Player", "user")
local TeleportTab = Window:CreateTab("🌍 Teleport", "map-pin")
local ConsoleTab = Window:CreateTab("⌨️ Console", "terminal")
```

Danh sách icon Lucide có sẵn

Danh mục Icon names
Cơ bản home, user, users, settings, menu, x, check, plus, minus, search
Điều hướng arrow-left, arrow-right, chevron-left, chevron-right, chevron-up, chevron-down
Hành động edit, trash, copy, save, download, upload, refresh-cw
Media play, pause, stop, volume, music, video, camera
Mạng xã hội github, youtube, twitter, facebook, discord, twitch
Bảo mật lock, shield, alert-circle, info, help-circle
Thời tiết sun, moon, cloud, wind, compass, globe, map
Thời gian calendar, clock, alarm-clock, timer
Sức khỏe heart, activity, battery
Game gamepad, controller, trophy, award, star
Mua sắm shopping-cart, credit-card, wallet, gift, tag
Lập trình code, terminal, command, git-branch

---

6. CÁC THÀNH PHẦN UI CƠ BẢN

6.1 CreateLabel - Nhãn văn bản

Công dụng: Hiển thị văn bản, có thể cập nhật động.

```lua
-- Label tĩnh
Tab:CreateLabel("Thông tin người chơi")
Tab:CreateLabel("Username: " .. game.Players.LocalPlayer.Name)

-- Label động (cập nhật bằng :Set())
local pingLabel = Tab:CreateLabel("Ping: Đang đo...")

task.spawn(function()
    while true do
        local ping = game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValue()
        pingLabel:Set("📡 Ping: " .. math.floor(ping) .. " ms")
        task.wait(1)
    end
end)

-- Label động (truyền function trực tiếp)
local fpsLabel = Tab:CreateLabel(function()
    return "🎮 FPS: " .. math.floor(1 / RunService.RenderStepped:Wait())
end)
```

---

6.2 CreateSection - Dòng phân cách

Công dụng: Phân nhóm các thành phần, có đường kẻ ngăn cách.

```lua
-- Có đường kẻ (mặc định)
Tab:CreateSection("⚔️ CHIẾN ĐẤU")

-- Không đường kẻ
Tab:CreateSection("🛡️ PHÒNG THỦ", true)
```

---

6.3 CreateParagraph - Đoạn văn bản dài

Công dụng: Hiển thị đoạn văn bản có tiêu đề, tự động xuống dòng.

```lua
Tab:CreateParagraph({
    Title = "🎨 Hướng dẫn sử dụng",
    Content = "Đây là nội dung hướng dẫn chi tiết.\nBạn có thể xuống dòng bằng \\n."
})
```

---

6.4 CreateButton - Nút bấm (CÓ SUBTITLE)

Công dụng: Tạo nút có thể click, hỗ trợ subtitle mô tả.

```lua
-- Căn giữa (mặc định)
Tab:CreateButton({
    Name = "💥 Tấn công",
    Subtitle = "Gây sát thương lên kẻ địch",
    Callback = function()
        NoirUI:Notify("Combat", "Đã tấn công!")
    end
})

-- Căn trái (Align = false) + có chữ "button" bên phải
Tab:CreateButton({
    Name = "⚙️ Cài đặt",
    Align = false,
    Subtitle = "Mở bảng cài đặt chi tiết",
    Callback = function()
        print("Mở cài đặt")
    end
})
```

Tham số Type Mặc định Mô tả
Name string ✅ bắt buộc Tên hiển thị trên nút
Callback function ✅ bắt buộc Hàm xử lý khi click
Align boolean true true = căn giữa, false = căn trái
Subtitle string nil Mô tả phụ bên dưới nút

---

6.5 CreateToggle - Công tắc bật/tắt (CÓ SUBTITLE)

Công dụng: Tạo switch bật/tắt, trả về trạng thái boolean.

```lua
Tab:CreateToggle({
    Name = "🤖 Auto Farm",
    Default = false,
    Subtitle = "Tự động farm khi bật",
    Callback = function(state)
        NoirUI:Notify("Auto Farm", state and "Đã bật" or "Đã tắt")
    end
})
```

Tham số Type Mặc định Mô tả
Name string ✅ bắt buộc Tên hiển thị
Callback function ✅ bắt buộc Hàm nhận trạng thái boolean
Default boolean false Trạng thái ban đầu
Subtitle string nil Mô tả phụ bên dưới

---

6.6 CreateSlider - Thanh trượt (CÓ RANGE, INCREMENT, SUBTITLE)

Công dụng: Điều chỉnh giá trị số với bước nhảy tùy chỉnh.

```lua
-- Cú pháp mới với range = {min, max}
Tab:CreateSlider({
    Name = "🎯 WalkSpeed",
    range = {16, 250},        -- {giá trị nhỏ nhất, giá trị lớn nhất}
    increment = 1,            -- Bước nhảy (mặc định = 1)
    Default = 16,
    Subtitle = "Tăng tốc độ di chuyển của nhân vật",
    Callback = function(value)
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = value
    end
})

-- Slider với increment 10
Tab:CreateSlider({
    Name = "💪 Damage",
    range = {0, 100},
    increment = 10,
    Default = 50,
    Subtitle = "Sát thương mỗi đòn đánh",
    Callback = function(v) print("Damage:", v) end
})

-- Slider với số thập phân
Tab:CreateSlider({
    Name = "🔊 Volume",
    range = {0, 1},
    increment = 0.1,
    Default = 0.5,
    Callback = function(v)
        game:GetService("SoundService").MasterVolume = v
    end
})
```

Tham số Type Mặc định Mô tả
Name string ✅ bắt buộc Tên hiển thị
range table {0, 100} {min, max}
increment number 1 Bước nhảy
Default number min Giá trị ban đầu
Subtitle string nil Mô tả phụ bên dưới
Callback function ✅ bắt buộc Hàm nhận giá trị

---

6.7 CreateTextBox - Ô nhập văn bản (CÓ SUBTITLE)

Công dụng: Nhập văn bản, callback khi mất focus.

```lua
Tab:CreateTextBox({
    Name = "💬 Nhập tin nhắn",
    Default = "",
    Subtitle = "Tin nhắn sẽ được gửi đến chat",
    Callback = function(text)
        if text ~= "" then
            game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(text, "All")
        end
    end
})
```

Tham số Type Mặc định Mô tả
Name string ✅ bắt buộc Placeholder text
Callback function ✅ bắt buộc Hàm nhận text khi mất focus
Default string "" Giá trị mặc định
Subtitle string nil Mô tả phụ bên dưới

---

7. CÁC THÀNH PHẦN UI NÂNG CAO

7.1 CreateDropdown - Danh sách chọn lọc (CÓ SUBTITLE, ĐỘNG)

Công dụng: Tạo dropdown với danh sách options, có thể tĩnh hoặc tự động cập nhật.

Cách 1: Options tĩnh

```lua
VisualTab:CreateDropdown({
    Name = "🎒 Chọn vũ khí",
    Options = {"🔫 AK-47", "🔪 Knife", "💣 Grenade"},
    Default = "🔫 AK-47",
    Subtitle = "Trang bị vũ khí cho nhân vật",
    Callback = function(selected)
        NoirUI:Notify("Weapon", "Đã trang bị: " .. selected)
    end
})
```

Cách 2: Options động (tự cập nhật danh sách player)

```lua
local function getPlayerList()
    local players = {}
    for _, v in pairs(game:GetService("Players"):GetPlayers()) do
        if v ~= game.Players.LocalPlayer then
            table.insert(players, v.Name)
        end
    end
    table.sort(players)
    if #players == 0 then return {"Không có người chơi"} end
    return players
end

TeleportTab:CreateDropdown({
    Name = "👥 TP đến player",
    GetOptions = getPlayerList,          -- Hàm trả về danh sách mới
    RefreshOnOpen = true,                 -- Tự động refresh khi mở
    RefreshInterval = 3,                  -- Hoặc refresh tự động mỗi 3 giây
    Subtitle = "Chọn người chơi để teleport",
    Callback = function(selected)
        if selected == "Không có người chơi" then return end
        local target = game:GetService("Players"):FindFirstChild(selected)
        if target and target.Character then
            local hrp = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            if hrp then
                hrp.CFrame = target.Character.HumanoidRootPart.CFrame
                NoirUI:Notify("Teleport", "Đã đến " .. selected, "map-pin")
            end
        end
    end
})
```

Tham số Type Mô tả
Name string ✅ bắt buộc - Tên dropdown
Options/GetOptions table/function ✅ bắt buộc - Danh sách tĩnh hoặc hàm trả về danh sách
Callback function ✅ bắt buộc - Hàm nhận giá trị được chọn
Default string Giá trị mặc định
Subtitle string Mô tả phụ bên dưới
RefreshOnOpen boolean Tự động refresh khi mở dropdown
RefreshInterval number Tự động refresh theo giây

---

7.2 CreateColorPicker - Bảng chọn màu (CÓ SUBTITLE)

Công dụng: Bảng màu HSV đầy đủ, có thể kéo thả chọn màu.

```lua
VisualTab:CreateColorPicker({
    Name = "🎨 Màu ESP",
    Default = Color3.fromRGB(255, 0, 0),
    Subtitle = "Chọn màu cho hiệu ứng ESP",
    Callback = function(color)
        print("Màu đã chọn:", color)
        -- Cập nhật màu ESP
    end
})
```

Tham số Type Mặc định Mô tả
Name string ✅ bắt buộc Tên hiển thị
Callback function ✅ bắt buộc Hàm nhận màu được chọn
Default Color3 Color3.fromRGB(170,85,255) Màu mặc định
Subtitle string nil Mô tả phụ bên dưới

---

7.3 CreateRunBox - Ô thực thi lệnh đa năng

Công dụng: Nhập và thực thi nhiều loại lệnh khác nhau.

```lua
local ConsoleTab = Window:CreateTab("💻 Console", "terminal")
ConsoleTab:CreateRunBox({
    Placeholder = "Nhập lệnh: .heal, .speed 100, .fly, .tp 0 100 0, loadstring('url')...",
    ClearOnExecute = true   -- Xóa text sau khi chạy
})
```

Các loại lệnh được hỗ trợ:

Loại Cú pháp Ví dụ
Custom Command .tên_lệnh .heal
Custom Command có tham số .tên_lệnh tham số .speed 100
Loadstring loadstring("code")() loadstring(game:HttpGet("url"))()
Required required("TênModule") required("ChatModule")
Lua code Câu lệnh Lua print("Hello")

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
required("PlayerModule")
```

---

8. CUSTOM COMMANDS

Đăng ký lệnh

```lua
NoirUI:RegisterCommand("tên_lệnh", function(args)
    -- Xử lý lệnh
    -- args là table chứa các tham số (đã tách theo khoảng trắng)
end)
```

Ví dụ các lệnh cơ bản

```lua
-- Lệnh .heal (không tham số)
NoirUI:RegisterCommand("heal", function(args)
    local char = game.Players.LocalPlayer.Character
    if char and char:FindFirstChild("Humanoid") then
        char.Humanoid.Health = 100
        NoirUI:Notify("💚 Heal", "Đã hồi 100 máu!", "heart")
    end
end)

-- Lệnh .speed [tốc độ] (1 tham số)
NoirUI:RegisterCommand("speed", function(args)
    local speed = tonumber(args[1]) or 16
    local char = game.Players.LocalPlayer.Character
    if char and char:FindFirstChild("Humanoid") then
        char.Humanoid.WalkSpeed = speed
        NoirUI:Notify("⚡ Speed", "Tốc độ: " .. speed, "zap")
    end
end)

-- Lệnh .tp x y z hoặc .tp [tên]
NoirUI:RegisterCommand("tp", function(args)
    local hrp = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    
    if #args >= 3 then
        local x, y, z = tonumber(args[1]), tonumber(args[2]), tonumber(args[3])
        hrp.CFrame = CFrame.new(x, y, z)
        NoirUI:Notify("🌍 Teleport", string.format("Đã dịch đến (%.0f, %.0f, %.0f)", x, y, z), "map-pin")
    elseif #args == 1 then
        local target = game:GetService("Players"):FindFirstChild(args[1])
        if target and target.Character then
            hrp.CFrame = target.Character.HumanoidRootPart.CFrame
            NoirUI:Notify("🌍 Teleport", "Đã dịch đến " .. target.Name, "map-pin")
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
        NoirUI:Notify("🕊️ Fly", "Đã bật bay!", "feather")
    elseif isFlying then
        if bodyVel then bodyVel:Destroy() end
        isFlying = false
        NoirUI:Notify("🕊️ Fly", "Đã tắt bay!", "feather")
    end
end)

-- Lệnh .unload (tắt UI)
NoirUI:RegisterCommand("unload", function(args)
    local gui = game.CoreGui:FindFirstChild("NoirUI_V3_Ultimate")
    if gui then gui:Destroy() end
end)
```

---

9. NOTIFICATIONS (CÓ ICON)

Cú pháp

```lua
NoirUI:Notify("Tiêu đề", "Nội dung thông báo", "icon_name")  -- icon_name là tên Lucide
```

Ví dụ

```lua
-- Thông báo thành công
NoirUI:Notify("✅ Thành công", "Đã thực hiện hành động!", "check")

-- Thông báo cảnh báo
NoirUI:Notify("⚠️ Cảnh báo", "Có lỗi xảy ra!", "alert-triangle")

-- Thông báo lỗi
NoirUI:Notify("❌ Lỗi", "Không thể kết nối đến server!", "x")

-- Thông báo thông tin
NoirUI:Notify("ℹ️ Thông tin", "Đã tải thành công " .. #data .. " mục", "info")

-- Không icon
NoirUI:Notify("Thông báo", "Nội dung đơn giản")

-- Trong callback
Tab:CreateButton({
    Name = "Test Notify",
    Callback = function()
        NoirUI:Notify("🎉 Chúc mừng", "Bạn đã click nút thành công!", "star")
    end
})
```

Đặc điểm Notification

Đặc điểm Mô tả
Độ mờ 0.25 (có thể tùy chỉnh qua NotificationBackground)
Xếp chồng Tự động xếp chồng lên nhau
Thời gian Tự động biến mất sau 4 giây
Hiệu ứng Xuất hiện với Back Easing
Vị trí Góc phải màn hình
Icon Hỗ trợ Lucide icon (24x24)

---

10. VÍ DỤ HOÀN CHỈNH

Admin Hub Pro với đầy đủ tính năng

```lua
-- ========== LOAD NOIRUI ==========
local NoirUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/NoirGoodBoi/UI/refs/heads/main/Main.lua"))()

-- ========== CÀI ĐẶT BACKGROUND ==========
local bgID = 1234567890  -- Thay ID ảnh của bạn

-- ========== TẠO CỬA SỔ ==========
local Window = NoirUI:CreateWindow({
    Name = "🔥 ADMIN HUB PRO 🔥",
    Accent = Color3.fromRGB(255, 50, 100),
    Icon = "zap",
    LogoID = "crown",
    
    Background = {
        Image = bgID,
        Transparency = 0.35
    },
    
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
        NoirUI:Notify("💚 Heal", "Đã hồi 100 máu!", "heart")
    end
end)

NoirUI:RegisterCommand("speed", function(args)
    local speed = tonumber(args[1]) or 16
    local char = game.Players.LocalPlayer.Character
    if char and char:FindFirstChild("Humanoid") then
        char.Humanoid.WalkSpeed = speed
        NoirUI:Notify("⚡ Speed", "Tốc độ: " .. speed, "zap")
    end
end)

NoirUI:RegisterCommand("fly", function(args)
    local hrp = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not isFlying and hrp then
        isFlying = true
        bodyVel = Instance.new("BodyVelocity")
        bodyVel.MaxForce = Vector3.new(10000, 10000, 10000)
        bodyVel.Velocity = Vector3.new(0, 0, 0)
        bodyVel.Parent = hrp
        NoirUI:Notify("🕊️ Fly", "Đã bật bay!", "feather")
    elseif isFlying then
        if bodyVel then bodyVel:Destroy() end
        isFlying = false
        NoirUI:Notify("🕊️ Fly", "Đã tắt bay!", "feather")
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

local pingLabel = PlayerTab:CreateLabel(function()
    local ping = game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValue()
    return "📡 Ping: " .. math.floor(ping) .. " ms"
end)

PlayerTab:CreateSection("💪 TÙY CHỈNH")
PlayerTab:CreateSlider({
    Name = "WalkSpeed",
    range = {16, 250},
    increment = 1,
    Default = 16,
    Subtitle = "Tăng tốc độ di chuyển",
    Callback = function(v)
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = v
    end
})

PlayerTab:CreateSlider({
    Name = "JumpPower",
    range = {50, 300},
    increment = 5,
    Default = 50,
    Subtitle = "Tăng độ cao nhảy",
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
    Subtitle = "Tự động farm quái",
    Callback = function(state)
        autoFarm = state
        NoirUI:Notify("Auto Farm", state and "Đã bật" or "Đã tắt", "zap")
    end
})

CombatTab:CreateButton({
    Name = "💥 Tấn công",
    Subtitle = "Gây 50 sát thương",
    Callback = function()
        NoirUI:Notify("Combat", "Đã tấn công!", "sword")
    end
})

-- ========== TAB VISUAL ==========
VisualTab:CreateSection("🎨 ESP SETTINGS")

local espEnabled = false
VisualTab:CreateToggle({
    Name = "🔴 Bật ESP",
    Default = false,
    Subtitle = "Hiển thị khung người chơi",
    Callback = function(state)
        espEnabled = state
        NoirUI:Notify("ESP", state and "Đã bật" or "Đã tắt", "eye")
    end
})

VisualTab:CreateColorPicker({
    Name = "🌈 Màu ESP",
    Default = Color3.fromRGB(255, 0, 0),
    Subtitle = "Chọn màu cho khung ESP",
    Callback = function(color)
        print("ESP Color:", color)
    end
})

VisualTab:CreateDropdown({
    Name = "🎯 Chọn bộ phận",
    Options = {"Head", "Chest", "Legs"},
    Default = "Head",
    Subtitle = "Bộ phận sẽ hiển thị ESP",
    Callback = function(selected)
        NoirUI:Notify("Target", "Đã chọn: " .. selected, "target")
    end
})

-- ========== TAB TELEPORT ==========
TeleportTab:CreateSection("📍 TELEPORT")

TeleportTab:CreateButton({
    Name = "🌍 TP về Spawn",
    Subtitle = "Quay về điểm xuất phát",
    Callback = function()
        local hrp = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if hrp then
            hrp.CFrame = CFrame.new(0, 50, 0)
            NoirUI:Notify("Teleport", "Đã về spawn!", "map-pin")
        end
    end
})

local function getPlayerList()
    local players = {}
    for _, v in pairs(game:GetService("Players"):GetPlayers()) do
        if v ~= game.Players.LocalPlayer then
            table.insert(players, v.Name)
        end
    end
    table.sort(players)
    if #players == 0 then return {"Không có người chơi"} end
    return players
end

TeleportTab:CreateDropdown({
    Name = "👥 TP đến player",
    GetOptions = getPlayerList,
    RefreshOnOpen = true,
    Subtitle = "Chọn người chơi để teleport",
    Callback = function(selected)
        if selected == "Không có người chơi" then return end
        local target = game:GetService("Players"):FindFirstChild(selected)
        if target and target.Character then
            local hrp = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            if hrp then
                hrp.CFrame = target.Character.HumanoidRootPart.CFrame
                NoirUI:Notify("Teleport", "Đã đến " .. selected, "map-pin")
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
NoirUI:Notify("🔥 ADMIN HUB PRO", "Đã tải thành công! Dùng .heal để test lệnh.", "check")
```

---

11. MẸO & THỦ THUẬT

11.1 Tạo nhiều tab nhanh với icon từ Lucide

```lua
local tabs = {
    {name = "Home", icon = "home"},
    {name = "Settings", icon = "settings"},
    {name = "User", icon = "user"},
    {name = "Game", icon = "gamepad"},
    {name = "Music", icon = "music"},
}

for _, tab in pairs(tabs) do
    local newTab = Window:CreateTab(tab.name, tab.icon)
    newTab:CreateLabel("This is " .. tab.name .. " tab")
end
```

11.2 Lưu cài đặt người dùng

```lua
local HttpService = game:GetService("HttpService")
local settings = {
    walkSpeed = 16,
    jumpPower = 50,
    autoFarm = false,
    espColor = Color3.fromRGB(255, 0, 0)
}

local function saveSettings()
    if writefile then
        local data = HttpService:JSONEncode(settings)
        writefile("hub_settings.json", data)
    end
end

local function loadSettings()
    if isfile and isfile("hub_settings.json") then
        local data = readfile("hub_settings.json")
        local loaded = HttpService:JSONDecode(data)
        for k, v in pairs(loaded) do
            settings[k] = v
        end
    end
end

loadSettings()

Tab:CreateSlider({
    Name = "WalkSpeed",
    range = {16, 250},
    Default = settings.walkSpeed,
    Callback = function(v)
        settings.walkSpeed = v
        saveSettings()
    end
})
```

11.3 Toggle UI bằng phím tắt

```lua
local UIS = game:GetService("UserInputService")
UIS.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and input.KeyCode == Enum.KeyCode.RightShift then
        local mainFrame = game.CoreGui:FindFirstChild("NoirUI_V3_Ultimate")
        if mainFrame then
            local mainUI = mainFrame:FindFirstChildWhichIsA("Frame")
            if mainUI then
                mainUI.Visible = not mainUI.Visible
            end
        end
    end
end)
```

11.4 Tạo Background động (đổi ảnh theo thời gian)

```lua
local backgrounds = {
    "rbxassetid://1234567890",
    "rbxassetid://0987654321",
    "rbxassetid://1122334455"
}
local bgIndex = 1

task.spawn(function()
    while true do
        task.wait(10)  -- Đổi mỗi 10 giây
        bgIndex = bgIndex % #backgrounds + 1
        local bgImage = game.CoreGui:FindFirstChild("NoirUI_V3_Ultimate"):FindFirstChild("_BackgroundImage")
        if bgImage then
            bgImage.Image = backgrounds[bgIndex]
        end
    end
end)
```

11.5 Xử lý khi UI bị destroy

```lua
local function cleanupUI()
    local gui = game.CoreGui:FindFirstChild("NoirUI_V3_Ultimate")
    if gui then
        if healthConnection then healthConnection:Disconnect() end
        if noclipConnection then noclipConnection:Disconnect() end
        if flyConnection then flyConnection:Disconnect() end
        gui:Destroy()
    end
end

NoirUI:RegisterCommand("unload", function(args)
    cleanupUI()
end)
```

---

12. BẢNG TỔNG KẾT NHANH

12.1 Tham số CreateWindow

Tham số Type Required Default
Name string ✅ -
Accent Color3 ❌ Color3.fromRGB(170,85,255)
Icon string/number ❌ nil
LogoID string/number ❌ nil
DefaultPosition UDim2 ❌ UDim2.new(0.5,-210,0.5,-150)
FloatDefaultPosition UDim2 ❌ UDim2.new(0,15,0.5,-22)
Background table ❌ nil
LoadingBackground table ❌ nil
KeyBackground table ❌ nil
NotificationBackground table ❌ nil
FloatBackground table ❌ nil
MainBgColor Color3 ❌ Color3.fromRGB(10,10,10)
MainBgTransparency number ❌ nil (auto)
SidebarTransparency number ❌ 0.5
ContentTransparency number ❌ 0.3
KeySystem boolean ❌ false
KeySettings table ❌ nil

12.2 Các thành phần UI mới

Component Method Điểm mới
Label CreateLabel Có method :Set() để update
Section CreateSection Có tham số noLine để tắt đường kẻ
Button CreateButton Subtitle, Align (center/left)
Toggle CreateToggle Subtitle
Slider CreateSlider range = {min,max}, increment, Subtitle
TextBox CreateTextBox Subtitle, Default
Dropdown CreateDropdown Subtitle, GetOptions, RefreshOnOpen, RefreshInterval
ColorPicker CreateColorPicker Subtitle
RunBox CreateRunBox Giữ nguyên
Paragraph CreateParagraph Giữ nguyên

12.3 Các loại lệnh RunBox

Loại Cú pháp Ví dụ
Custom Command .command args .heal, .speed 100
Loadstring loadstring("code")() loadstring(game:HttpGet("url"))()
Required required("module") required("ChatModule")
Lua Code lua code print("Hello")

12.4 Icon Lucide phổ biến

Danh mục Icon names
Cơ bản home, user, users, settings, menu, x, check, plus, minus, search
Hành động edit, trash, copy, save, download, upload, refresh-cw
Media play, pause, stop, volume, music, video, camera
Mạng xã hội github, youtube, twitter, facebook, discord
Bảo mật lock, shield, alert-circle, info, help-circle
Game gamepad, controller, trophy, award, star
Khác heart, compass, map-pin, calendar, clock, zap, flag, key

---

🎉 KẾT LUẬN

NoirUI V3 Ultimate là một thư viện UI mạnh mẽ và hiện đại, cung cấp đầy đủ các thành phần cần thiết để tạo ra một giao diện chuyên nghiệp.

Tính năng chính mới:

· ✅ Subtitle cho tất cả elements - mô tả chi tiết từng chức năng
· ✅ Slider với range = {min, max} và increment - linh hoạt hơn
· ✅ Button có Align - căn trái hoặc căn giữa
· ✅ Label động với :Set() - cập nhật dễ dàng
· ✅ Dropdown tự động refresh - luôn cập nhật danh sách mới
· ✅ Clipping Mask cho icon - ảnh được cắt theo khung
· ✅ Icon giữ màu gốc - không bị nhuộm accent
· ✅ Tự động xử lý background transparency - không cần chỉnh thủ công
· ✅ Notification có icon Lucide - thông báo sinh động hơn

---

Chúc bạn thành công với NoirUI V3 Ultimate! 🚀
