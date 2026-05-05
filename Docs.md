📘 NOIRUI V3 ULTIMATE - HƯỚNG DẪN SỬ DỤNG A-Z

MỤC LỤC

1. Giới thiệu
2. Cách tải và khởi tạo
3. Cấu hình cửa sổ & Background
4. Hệ thống Key
5. Hệ thống Âm thanh
6. Tạo Tab
7. Các thành phần UI cơ bản
8. Các thành phần UI nâng cao
9. Custom Commands
10. Notifications
11. Ví dụ hoàn chỉnh
12. Bảng tổng kết nhanh

---

1. GIỚI THIỆU

NoirUI V3 Ultimate là thư viện giao diện người dùng thế hệ mới dành cho Roblox Executor.

🎯 Tính năng nổi bật

Tính năng Mô tả
🎨 Custom Background Hỗ trợ ảnh nền từ ID Roblox, URL, rbxasset
🖱️ Kéo thả độc lập Cửa sổ chính và nút float có thể kéo thả riêng
🔐 Key System Pro Bảo vệ UI bằng key, lưu vào file
🔊 Âm thanh Hỗ trợ âm thanh cho nút float, tab, element
🌈 Hiệu ứng cầu vồng Viền UI chuyển màu liên tục
🔍 Search Bar Tìm kiếm nội dung trong tab
⌨️ RunBox đa năng Custom command, loadstring, lua code
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
    print("✅ Loaded successfully!")
else
    warn("❌ Failed to load:", result)
end
```

---

3. CẤU HÌNH CỬA SỔ & BACKGROUND

Cấu trúc đầy đủ

```lua
local Window = NoirUI:CreateWindow({
    -- ===== CƠ BẢN =====
    Name = "Tên UI",                                    -- Tiêu đề header
    Accent = Color3.fromRGB(170, 85, 255),              -- Màu chủ đạo
    Icon = "zap",                                        -- Icon nút float
    LogoID = "user",                                    -- Logo header
    
    -- ===== VỊ TRÍ =====
    DefaultPosition = UDim2.new(0.5, -210, 0.5, -150),
    FloatDefaultPosition = UDim2.new(0, 15, 0.5, -22),
    
    -- ===== BACKGROUNDS =====
    Background = {                                       -- Ảnh nền main UI
        Image = 1234567890,                             -- ID Roblox
        Transparency = 0.5                              -- Độ mờ (0-1)
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
    SidebarTransparency = 0.5,                          -- Độ mờ sidebar
    ContentTransparency = 0.3,                          -- Độ mờ vùng nội dung
})
```

Lưu ý về Background:

· Nếu có Background → nền main UI tự động trong suốt
· Nếu không có Background → nền đen mặc định
· Transparency = 0 → ảnh đậm, Transparency = 1 → ảnh trong suốt

---

4. HỆ THỐNG KEY

Bật Key System

```lua
KeySystem = true,
KeySettings = {
    -- Key đơn hoặc nhiều key
    Key = "free123",                    -- Hoặc Key = {"free123", "vip456"},
    
    SaveKey = true,                     -- Lưu key, không cần nhập lại
    FileName = "MyHubKey",              -- Tên file lưu
    
    Title = "🔐 KEY SYSTEM",
    Subtitle = "Nhập key để tiếp tục",
    Note = "Liên hệ admin để lấy key"
}
```

Tắt Key System

```lua
KeySystem = false
```

---

5. HỆ THỐNG ÂM THANH

Các loại âm thanh

soundType Khi nào phát
"click" Click nút float
"tab" Chuyển tab
"element" Click button, toggle, chọn dropdown

Cách sử dụng

```lua
-- Set âm thanh (thay ID bằng ID sound của bạn)
NoirUI:SetSound("click", "rbxassetid://1234567890")
NoirUI:SetSound("tab", "rbxassetid://0987654321")
NoirUI:SetSound("element", "rbxassetid://1122334455")

-- Tắt/bật âm thanh
NoirUI:ToggleSound(true)   -- Bật (mặc định)
NoirUI:ToggleSound(false)  -- Tắt

-- Chỉnh âm lượng (0-1)
NoirUI:SetVolume(0.5)      -- 50%
NoirUI:SetVolume(1)        -- 100%
NoirUI:SetVolume(0)        -- Tắt tiếng
```

Ví dụ hoàn chỉnh

```lua
local NoirUI = loadstring(game:HttpGet("url"))()
local Window = NoirUI:CreateWindow({ Name = "My Hub" })

-- Set âm thanh ngay sau khi tạo window
NoirUI:SetSound("click", "rbxassetid://1234567890")
NoirUI:SetSound("tab", "rbxassetid://0987654321")
NoirUI:SetSound("element", "rbxassetid://1122334455")
NoirUI:SetVolume(0.3)  -- Âm lượng 30%
```

---

6. TẠO TAB

Cú pháp

```lua
-- Có icon (tên Lucide hoặc Image ID)
local Tab1 = Window:CreateTab("Tên Tab", "user")

-- Không icon
local Tab2 = Window:CreateTab("Tên Tab")
```

Ví dụ

```lua
local PlayerTab = Window:CreateTab("👤 Player", "user")
local CombatTab = Window:CreateTab("⚔️ Combat", "sword")
local VisualTab = Window:CreateTab("👁️ Visual", "eye")
local TeleportTab = Window:CreateTab("🌍 Teleport", "map-pin")
local ConsoleTab = Window:CreateTab("⌨️ Console", "terminal")
```

Danh sách icon Lucide phổ biến

Danh mục Icon names
Cơ bản home, user, users, settings, menu, x, check, plus, minus, search
Điều hướng arrow-left, arrow-right, chevron-left, chevron-right
Hành động edit, trash, copy, save, download, upload, refresh-cw
Media play, pause, stop, volume, music, video, camera
Mạng xã hội github, youtube, twitter, facebook, discord
Bảo mật lock, shield, alert-circle, info
Game gamepad, controller, trophy, star
Khác heart, compass, map-pin, calendar, clock, zap, flag

---

7. CÁC THÀNH PHẦN UI CƠ BẢN

7.1 CreateLabel - Nhãn văn bản

```lua
-- Label tĩnh
Tab:CreateLabel("Thông tin người chơi")

-- Label động (tự cập nhật mỗi frame)
local pingLabel = Tab:CreateLabel(function()
    local ping = game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValue()
    return "📡 Ping: " .. math.floor(ping) .. " ms"
end)

-- Hoặc dùng method :Set() để cập nhật
local fpsLabel = Tab:CreateLabel("FPS: ...")
task.spawn(function()
    while true do
        local fps = math.floor(1 / RunService.RenderStepped:Wait())
        fpsLabel:Set("🎮 FPS: " .. fps)
        task.wait(0.5)
    end
end)
```

---

7.2 CreateSection - Dòng phân cách

```lua
-- Có đường kẻ (mặc định)
Tab:CreateSection("THÔNG TIN")

-- Không đường kẻ
Tab:CreateSection("CÀI ĐẶT", true)
```

---

7.3 CreateParagraph - Đoạn văn bản dài

```lua
Tab:CreateParagraph({
    Title = "🎨 Hướng dẫn",
    Content = "Đây là nội dung hướng dẫn chi tiết.\nBạn có thể xuống dòng bằng \\n."
})
```

---

7.4 CreateButton - Nút bấm (Có Subtitle + Âm thanh)

```lua
-- Căn giữa (mặc định)
Tab:CreateButton({
    Name = "💥 Tấn công",
    Subtitle = "Gây 50 sát thương",     -- Tùy chọn
    Callback = function()
        NoirUI:Notify("Combat", "Đã tấn công!")
    end
})

-- Căn trái + có chữ "button" bên phải
Tab:CreateButton({
    Name = "⚙️ Cài đặt",
    Align = false,                       -- false = căn trái
    Subtitle = "Mở bảng cài đặt",
    Callback = function() print("Settings") end
})
```

Tham số Type Mặc định Mô tả
Name string ✅ bắt buộc Tên hiển thị
Callback function ✅ bắt buộc Hàm xử lý
Align boolean true true=giữa, false=trái
Subtitle string nil Mô tả phụ

---

7.5 CreateToggle - Công tắc bật/tắt (Có Subtitle + Âm thanh)

```lua
Tab:CreateToggle({
    Name = "🤖 Auto Farm",
    Default = false,
    Subtitle = "Tự động farm khi bật",
    Callback = function(state)
        NoirUI:Notify("Auto Farm", state and "Bật" or "Tắt")
    end
})
```

Tham số Type Mô tả
Name string ✅ bắt buộc
Callback function ✅ bắt buộc
Default boolean false
Subtitle string nil

---

7.6 CreateSlider - Thanh trượt (Có Range, Increment, Subtitle)

```lua
-- Cú pháp mới: range = {min, max}
Tab:CreateSlider({
    Name = "WalkSpeed",
    range = {16, 250},           -- {giá trị nhỏ nhất, lớn nhất}
    increment = 1,               -- Bước nhảy (mặc định = 1)
    Default = 16,
    Subtitle = "Tăng tốc độ di chuyển",
    Callback = function(v)
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = v
    end
})

-- Slider với increment 10
Tab:CreateSlider({
    Name = "Damage",
    range = {0, 100},
    increment = 10,
    Default = 50,
    Callback = function(v) print(v) end
})

-- Slider số thập phân
Tab:CreateSlider({
    Name = "Volume",
    range = {0, 1},
    increment = 0.1,
    Default = 0.5,
    Callback = function(v) game:GetService("SoundService").MasterVolume = v end
})
```

Tham số Type Mặc định Mô tả
Name string ✅ bắt buộc Tên hiển thị
range table {0,100} {min, max}
Callback function ✅ bắt buộc Hàm nhận giá trị
increment number 1 Bước nhảy
Default number min Giá trị ban đầu
Subtitle string nil Mô tả phụ

---

7.7 CreateTextBox - Ô nhập văn bản (Có Subtitle)

```lua
Tab:CreateTextBox({
    Name = "Nhập tên",
    Default = "",
    Subtitle = "Tên hiển thị của bạn",
    Callback = function(text)
        print("Đã nhập:", text)
    end
})
```

---

8. CÁC THÀNH PHẦN UI NÂNG CAO

8.1 CreateDropdown - Danh sách chọn lọc (Có Subtitle + Âm thanh)

Cách 1: Options tĩnh

```lua
Tab:CreateDropdown({
    Name = "Chọn vũ khí",
    Options = {"🔫 AK-47", "🔪 Knife", "💣 Grenade"},
    Default = "🔫 AK-47",
    Subtitle = "Trang bị vũ khí",
    Callback = function(selected)
        print("Đã chọn:", selected)
    end
})
```

Cách 2: Options động (tự cập nhật danh sách player)

```lua
local function getPlayerList()
    local players = {}
    for _, p in pairs(game:GetService("Players"):GetPlayers()) do
        if p ~= game.Players.LocalPlayer then
            table.insert(players, p.Name)
        end
    end
    table.sort(players)
    if #players == 0 then return {"Không có người chơi"} end
    return players
end

Tab:CreateDropdown({
    Name = "Teleport to",
    GetOptions = getPlayerList,     -- Hàm trả về danh sách
    RefreshOnOpen = true,           -- Cập nhật khi mở dropdown
    Subtitle = "Chọn người chơi",
    Callback = function(selected)
        if selected == "Không có người chơi" then return end
        local target = game:GetService("Players"):FindFirstChild(selected)
        if target and target.Character then
            -- Teleport logic...
        end
    end
})
```

Tham số Type Mô tả
Name string ✅ bắt buộc
Options/GetOptions table/function ✅ bắt buộc
Callback function ✅ bắt buộc
Default string Giá trị mặc định
Subtitle string Mô tả phụ
RefreshOnOpen boolean Tự động cập nhật khi mở
RefreshInterval number Tự động cập nhật theo giây

---

8.2 CreateColorPicker - Bảng chọn màu (Có Subtitle)

```lua
Tab:CreateColorPicker({
    Name = "Màu ESP",
    Default = Color3.fromRGB(255, 0, 0),
    Subtitle = "Chọn màu cho ESP",
    Callback = function(color)
        print("Màu:", color)
    end
})
```

---

8.3 CreateRunBox - Ô thực thi lệnh đa năng

```lua
Tab:CreateRunBox({
    Placeholder = "Nhập lệnh: .heal, loadstring('url'), or lua code...",
    ClearOnExecute = true   -- Xóa text sau khi chạy
})
```

Các loại lệnh hỗ trợ

Loại Cú pháp Ví dụ
Custom Command .tên_lệnh args .heal, .speed 100
Loadstring loadstring("code")() loadstring(game:HttpGet("url"))()
Lua Code lua code print("Hello")

---

9. CUSTOM COMMANDS

Đăng ký lệnh

```lua
NoirUI:RegisterCommand("tên_lệnh", function(args)
    -- args là table chứa tham số (tách theo khoảng trắng)
end)
```

Ví dụ

```lua
-- Lệnh .heal (không tham số)
NoirUI:RegisterCommand("heal", function(args)
    local char = game.Players.LocalPlayer.Character
    if char and char:FindFirstChild("Humanoid") then
        char.Humanoid.Health = 100
        NoirUI:Notify("💚 Heal", "Đã hồi 100 máu!")
    end
end)

-- Lệnh .speed [tốc độ] (có tham số)
NoirUI:RegisterCommand("speed", function(args)
    local speed = tonumber(args[1]) or 16
    local char = game.Players.LocalPlayer.Character
    if char and char:FindFirstChild("Humanoid") then
        char.Humanoid.WalkSpeed = speed
        NoirUI:Notify("⚡ Speed", "Tốc độ: " .. speed)
    end
end)

-- Lệnh .tp x y z (nhiều tham số)
NoirUI:RegisterCommand("tp", function(args)
    local hrp = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    
    if #args >= 3 then
        local x, y, z = tonumber(args[1]), tonumber(args[2]), tonumber(args[3])
        hrp.CFrame = CFrame.new(x, y, z)
        NoirUI:Notify("Teleport", string.format("Đã dịch đến (%.0f, %.0f, %.0f)", x, y, z))
    elseif #args == 1 then
        local target = game:GetService("Players"):FindFirstChild(args[1])
        if target and target.Character then
            hrp.CFrame = target.Character.HumanoidRootPart.CFrame
            NoirUI:Notify("Teleport", "Đã đến " .. target.Name)
        end
    end
end)

-- Lệnh .unload (tắt UI)
NoirUI:RegisterCommand("unload", function(args)
    local gui = game.CoreGui:FindFirstChild("NoirUI_V3_Ultimate")
    if gui then gui:Destroy() end
end)
```

---

10. NOTIFICATIONS (Có Icon)

Cú pháp

```lua
NoirUI:Notify("Tiêu đề", "Nội dung", "icon_name")  -- icon_name tùy chọn
```

Ví dụ

```lua
-- Không icon
NoirUI:Notify("Thông báo", "Nội dung đơn giản")

-- Có icon
NoirUI:Notify("✅ Thành công", "Đã thực hiện!", "check")
NoirUI:Notify("⚠️ Cảnh báo", "Có lỗi xảy ra!", "alert-triangle")
NoirUI:Notify("❌ Lỗi", "Không thể kết nối!", "x")
NoirUI:Notify("ℹ️ Thông tin", "Đã tải thành công!", "info")

-- Trong callback
Tab:CreateButton({
    Name = "Test",
    Callback = function()
        NoirUI:Notify("🎉 Chúc mừng", "Bạn đã click!", "star")
    end
})
```

---

11. VÍ DỤ HOÀN CHỈNH

```lua
-- ========== LOAD NOIRUI ==========
local NoirUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/NoirGoodBoi/UI/refs/heads/main/Main.lua"))()

-- ========== TẠO CỬA SỔ ==========
local Window = NoirUI:CreateWindow({
    Name = "🔥 NOIR HUB 🔥",
    Accent = Color3.fromRGB(255, 50, 100),
    Icon = "zap",
    LogoID = "user",
    
    Background = {
        Image = 1234567890,      -- Thay ID ảnh của bạn
        Transparency = 0.3
    },
})

-- ========== SET ÂM THANH ==========
NoirUI:SetSound("click", "rbxassetid://1234567890")
NoirUI:SetSound("tab", "rbxassetid://0987654321")
NoirUI:SetSound("element", "rbxassetid://1122334455")
NoirUI:SetVolume(0.4)

-- ========== TẠO TAB ==========
local MainTab = Window:CreateTab("Main", "home")
local PlayerTab = Window:CreateTab("Player", "user")
local VisualTab = Window:CreateTab("Visual", "eye")

-- ========== TAB MAIN ==========
MainTab:CreateSection("THÔNG TIN")

-- Label động
local pingLabel = MainTab:CreateLabel(function()
    local ping = game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValue()
    return "📡 Ping: " .. math.floor(ping) .. " ms"
end)

local fpsLabel = MainTab:CreateLabel("FPS: ...")
task.spawn(function()
    while true do
        local fps = math.floor(1 / RunService.RenderStepped:Wait())
        fpsLabel:Set("🎮 FPS: " .. fps)
        task.wait(0.5)
    end
end)

MainTab:CreateSection("CÀI ĐẶT")

-- Button
MainTab:CreateButton({
    Name = "Execute Script",
    Align = false,
    Subtitle = "Chạy script auto farm",
    Callback = function()
        NoirUI:Notify("Execute", "Đã chạy script!", "play")
    end
})

-- Toggle
MainTab:CreateToggle({
    Name = "Auto Farm",
    Default = false,
    Subtitle = "Tự động farm",
    Callback = function(state)
        NoirUI:Notify("Auto Farm", state and "BẬT" or "TẮT", "zap")
    end
})

-- Slider
MainTab:CreateSlider({
    Name = "WalkSpeed",
    range = {16, 250},
    increment = 1,
    Default = 16,
    Subtitle = "Tăng tốc độ",
    Callback = function(v)
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = v
    end
})

-- ========== TAB PLAYER ==========
PlayerTab:CreateSection("TELEPORT")

-- Dropdown động
local function getPlayers()
    local players = {}
    for _, p in pairs(game:GetService("Players"):GetPlayers()) do
        if p ~= game.Players.LocalPlayer then
            table.insert(players, p.Name)
        end
    end
    return players
end

PlayerTab:CreateDropdown({
    Name = "TP đến player",
    GetOptions = getPlayers,
    RefreshOnOpen = true,
    Subtitle = "Chọn người chơi",
    Callback = function(selected)
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

-- ========== TAB VISUAL ==========
VisualTab:CreateSection("ESP")

VisualTab:CreateColorPicker({
    Name = "Màu ESP",
    Default = Color3.fromRGB(255, 0, 0),
    Subtitle = "Chọn màu",
    Callback = function(color)
        print("Màu:", color)
    end
})

-- ========== RUNBOX ==========
local ConsoleTab = Window:CreateTab("Console", "terminal")
ConsoleTab:CreateRunBox({
    Placeholder = "Nhập lệnh: .heal, .speed 100, loadstring('url')...",
    ClearOnExecute = true
})

-- ========== CUSTOM COMMANDS ==========
NoirUI:RegisterCommand("heal", function(args)
    local char = game.Players.LocalPlayer.Character
    if char and char:FindFirstChild("Humanoid") then
        char.Humanoid.Health = 100
        NoirUI:Notify("💚 Heal", "Đã hồi 100 máu!", "heart")
    end
end)

NoirUI:RegisterCommand("unload", function(args)
    local gui = game.CoreGui:FindFirstChild("NoirUI_V3_Ultimate")
    if gui then gui:Destroy()
end)

-- ========== THÔNG BÁO ==========
task.wait(2)
NoirUI:Notify("🔥 NOIR HUB", "Đã tải thành công! Dùng .heal để test.", "check")
```

---

12. BẢNG TỔNG KẾT NHANH

Bảng tham số CreateWindow

Tham số Type Required Default
Name string ✅ -
Accent Color3 ❌ Color3.fromRGB(170,85,255)
Icon string/number ❌ nil
LogoID string/number ❌ nil
DefaultPosition UDim2 ❌ (0.5,-210,0.5,-150)
FloatDefaultPosition UDim2 ❌ (0,15,0.5,-22)
Background table ❌ nil
LoadingBackground table ❌ nil
KeyBackground table ❌ nil
KeySystem boolean ❌ false
KeySettings table ❌ nil

Bảng các thành phần UI

Component Method Tính năng đặc biệt
Label CreateLabel Động với :Set()
Section CreateSection Có thể tắt đường kẻ
Button CreateButton Align, Subtitle, Âm thanh
Toggle CreateToggle Subtitle, Âm thanh
Slider CreateSlider range, increment, Subtitle
TextBox CreateTextBox Subtitle
Dropdown CreateDropdown Động, Subtitle, Âm thanh
ColorPicker CreateColorPicker Subtitle
RunBox CreateRunBox Đa năng

Bảng âm thanh

soundType Khi nào Method
"click" Nút float NoirUI:SetSound("click", id)
"tab" Chuyển tab NoirUI:SetSound("tab", id)
"element" Button, Toggle, Dropdown NoirUI:SetSound("element", id)

---

🎉 KẾT LUẬN

NoirUI V3 Ultimate là thư viện UI mạnh mẽ với đầy đủ tính năng:

· ✅ Âm thanh cho mọi tương tác
· ✅ Background clipping mask cho ảnh đẹp
· ✅ Subtitle mô tả chi tiết
· ✅ Slider với range và increment
· ✅ Dropdown động tự cập nhật
· ✅ Button có tùy chọn căn lề
· ✅ 250+ icon Lucide tích hợp sẵn
· ✅ Key System bảo vệ script

Chúc bạn thành công với NoirUI V3 Ultimate! 🚀
