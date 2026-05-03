📘 NOIRUI V3 ULTIMATE - HƯỚNG DẪN SỬ DỤNG A-Z (SIÊU CHI TIẾT)

---

MỤC LỤC

1. Giới thiệu
2. Cách tải và khởi tạo
3. Cấu hình cửa sổ & Background
4. Hệ thống Key (MỚI)
5. Tạo Tab
6. Các thành phần UI cơ bản
7. Các thành phần UI nâng cao (MỚI)
8. Custom Commands (MỚI)
9. RunBox - Thực thi lệnh đa năng (MỚI)
10. Notifications
11. Ví dụ hoàn chỉnh
12. Mẹo & Thủ thuật
13. Bảng tổng kết nhanh

---

1. GIỚI THIỆU

NoirUI V3 Ultimate là thư viện giao diện người dùng thế hệ mới dành cho Roblox Executor, được nâng cấp toàn diện từ phiên bản Classic.

🎯 Tính năng nổi bật

Tính năng Mô tả
🎨 Custom Background Hỗ trợ ảnh nền từ ID Roblox, URL, rbxasset cho từng thành phần riêng biệt
🖱️ Kéo thả độc lập Cửa sổ chính và nút float có thể kéo thả riêng biệt, lưu vị trí
🔐 Key System Pro Bảo vệ UI bằng key, lưu key vào file, hỗ trợ nhiều key cùng lúc
🌈 Hiệu ứng cầu vồng Viền UI chuyển màu liên tục với tốc độ có thể tùy chỉnh
📱 Hỗ trợ Mobile Touch-friendly, kéo thả và tương tác bằng tay mượt mà
🔍 Search Bar Tìm kiếm nội dung trong từng tab theo thời gian thực
⌨️ RunBox đa năng Thực thi custom command, loadstring, required, lua code
💬 Notifications Thông báo xếp chồng thông minh, tự động biến mất
🎨 250+ Icon Lucide Kho icon khổng lồ tích hợp sẵn, chỉ cần gọi tên
📦 Loading Effect Hiệu ứng loading đẹp mắt khi khởi tạo
🔄 Refresh On Open Dropdown tự động cập nhật danh sách khi mở

---

2. CÁCH TẢI VÀ KHỞI TẠO

Cách 1: Load từ URL (Khuyến nghị)

```lua
local NoirUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/NoirGoodBoi/UI/refs/heads/main/Main.lua"))()
```

Cách 2: Kiểm tra tồn tại trước khi load

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
    Name = "Tên UI",                              -- Tiêu đề header
    Accent = Color3.fromRGB(170, 85, 255),        -- Màu chủ đạo
    Icon = "🚀",                                   -- Icon nút float (emoji hoặc ID)
    LogoID = 1234567890,                          -- Logo header (Image ID)
    
    -- ===== VỊ TRÍ =====
    DefaultPosition = UDim2.new(0.5, -210, 0.5, -150),   -- Vị trí main UI
    FloatDefaultPosition = UDim2.new(0, 15, 0.5, -22),    -- Vị trí nút float
    
    -- ===== BACKGROUND CHO MAIN UI (MỚI) =====
    Background = {
        Image = 1234567890,            -- ID Roblox (number hoặc string)
        -- Hoặc: Image = "rbxassetid://1234567890"
        -- Hoặc: Image = "https://example.com/bg.png"
        -- Hoặc: Image = "rbxasset://textures/ui/Gradient.png"
        Transparency = 0.5              -- Độ mờ (0-1)
    },
    
    -- ===== BACKGROUND CHO LOADING (MỚI) =====
    LoadingBackground = {
        Image = 1234567890,
        Transparency = 0.3
    },
    
    -- ===== BACKGROUND CHO KEY UI (MỚI) =====
    KeyBackground = {
        Image = 1234567890,
        Transparency = 0.4
    },
    
    -- ===== BACKGROUND CHO NOTIFICATION (MỚI) =====
    NotificationBackground = {
        Image = 1234567890,
        Transparency = 0.2
    },
    
    -- ===== BACKGROUND CHO FLOAT BUTTON (MỚI) =====
    FloatBackground = {
        Image = 1234567890,
        Transparency = 0.3
    },
    
    -- ===== ĐỘ TRONG SUỐT CÁC THÀNH PHẦN (MỚI) =====
    MainBgColor = Color3.fromRGB(10, 10, 10),     -- Màu nền main
    MainBgTransparency = 0,                       -- Độ mờ nền main
    SidebarTransparency = 0.5,                    -- Độ mờ sidebar
    ContentTransparency = 0.3,                    -- Độ mờ vùng nội dung
    
    -- ===== HỆ THỐNG KEY (MỚI) =====
    KeySystem = true,                             -- Bật/tắt key system
    KeySettings = {
        Key = {"key1", "key2"},                   -- Một hoặc nhiều key
        SaveKey = true,                           -- Lưu key vào file
        FileName = "MyHubKey",                    -- Tên file lưu key
        Title = "🔐 WELCOME",                     -- Tiêu đề key window
        Subtitle = "Nhập key để tiếp tục",        -- Subtitle
        Note = "Mua key tại discord.gg/xxx"       -- Ghi chú
    }
})
```

Ví dụ Background đẹp

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
    
    -- Notification background
    NotificationBackground = {
        Image = 1234567890,
        Transparency = 0.15
    },
    
    KeySystem = false
})
```

---

4. HỆ THỐNG KEY (MỚI)

Bật Key System

```lua
KeySystem = true,
KeySettings = {
    -- Key đơn
    Key = "free123",
    
    -- Hoặc nhiều key (VIP, Admin, Free)
    Key = {"free123", "vip456", "admin789"},
    
    -- Lưu key (không cần nhập lại khi chạy lại)
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

Luồng hoạt động Key

```
Chạy script
    │
    ▼
Kiểm tra file key đã lưu chưa?
    │
    ├── Đã lưu → So khớp key
    │              │
    │              ├── Đúng → Hiện loading → UI chính
    │              │
    │              └── Sai → Xóa file cũ → Hiện bảng key
    │
    └── Chưa lưu → Hiện bảng key
                    │
                    ▼
              Nhập key
                    │
                    ├── Đúng → Lưu key → Loading → UI chính
                    │
                    └── Sai → Báo lỗi "Key không chính xác!"
                              │
                              └── Xóa text, yêu cầu nhập lại
```

---

5. TẠO TAB

Cú pháp

```lua
-- Có icon (Image ID hoặc tên icon từ Lucide)
local Tab1 = Window:CreateTab("Tên Tab", "icon_name")

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
Cơ bản home, house, user, users, settings, menu, x, close, check, plus, minus, search
Điều hướng arrow-left, arrow-right, arrow-up, arrow-down, chevron-left, chevron-right
Hành động edit, pen, trash, delete, copy, cut, paste, save, download, upload
Media play, pause, stop, volume, volume-x, mute, music, video, camera
Mạng xã hội github, youtube, twitter, facebook, instagram, discord, twitch, tiktok
Bảo mật lock, unlock, shield, alert-circle, alert-triangle, warning, info
Thời tiết sun, moon, cloud, cloud-rain, wind, compass, globe, map
Thời gian calendar, clock, alarm-clock, timer
Sức khỏe heart, activity, battery
Game gamepad, controller, joystick, dice, trophy, award, medal, star
Mua sắm shopping-cart, credit-card, wallet, dollar-sign, gift, tag
Lập trình code, terminal, command, git-branch

---

6. CÁC THÀNH PHẦN UI CƠ BẢN

6.1 CreateLabel - Nhãn văn bản

Công dụng: Hiển thị văn bản đơn giản, không tương tác.

```lua
Tab:CreateLabel("Thông tin người chơi")
Tab:CreateLabel("Username: " .. game.Players.LocalPlayer.Name)
Tab:CreateLabel("User ID: " .. game.Players.LocalPlayer.UserId)
```

---

6.2 CreateSection - Dòng phân cách

Công dụng: Phân nhóm các thành phần trong tab.

```lua
Tab:CreateSection("⚔️ CHIẾN ĐẤU")
Tab:CreateButton({ Name = "Tấn công", Callback = function() end })
Tab:CreateButton({ Name = "Phòng thủ", Callback = function() end })

Tab:CreateSection("🛡️ PHÒNG THỦ")
Tab:CreateToggle({ Name = "Auto Block", Callback = function(s) end })
```

---

6.3 CreateParagraph - Đoạn văn dài

Công dụng: Hiển thị đoạn văn bản có tiêu đề và nội dung, tự động xuống dòng.

```lua
Tab:CreateParagraph({
    Title = "🎨 Hướng dẫn sử dụng",
    Content = "Đây là nội dung hướng dẫn chi tiết.\nBạn có thể xuống dòng bằng \\n."
})
```

---

6.4 CreateButton - Nút bấm

Công dụng: Tạo nút có thể click, thực thi callback.

```lua
Tab:CreateButton({
    Name = "💥 Tấn công",
    Callback = function()
        print("Đã tấn công!")
        NoirUI:Notify("Combat", "Bạn đã tấn công!")
    end
})
```

---

6.5 CreateToggle - Công tắc bật/tắt

Công dụng: Tạo switch bật/tắt, trả về trạng thái boolean.

```lua
local autoFarm = false
Tab:CreateToggle({
    Name = "🤖 Auto Farm",
    Default = false,      -- Trạng thái ban đầu
    Callback = function(state)
        autoFarm = state
        NoirUI:Notify("Auto Farm", state and "Đã bật" or "Đã tắt")
    end
})
```

---

6.6 CreateSlider - Thanh trượt

Công dụng: Điều chỉnh giá trị số trong khoảng min-max.

```lua
Tab:CreateSlider({
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

---

6.7 CreateTextBox - Ô nhập văn bản

Công dụng: Nhập văn bản, callback khi mất focus.

```lua
Tab:CreateTextBox({
    Name = "💬 Nhập tin nhắn",
    Callback = function(text)
        if text ~= "" then
            -- Gửi tin nhắn chat
            game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(text, "All")
        end
    end
})
```

---

7. CÁC THÀNH PHẦN UI NÂNG CAO (MỚI)

7.1 CreateDropdown - Danh sách chọn lọc

Đặc điểm: Có mũi tên xoay khi mở/đóng, tự động cuộn nếu nhiều option.

```lua
-- Cách 1: Options tĩnh
VisualTab:CreateDropdown({
    Name = "🎒 Chọn vũ khí",
    Options = {"🔫 AK-47", "🔪 Knife", "💣 Grenade", "🏹 Bow", "🔫 Pistol"},
    Default = "🔫 AK-47",
    Callback = function(selected)
        NoirUI:Notify("Weapon", "Đã trang bị: " .. selected)
    end
})

-- Cách 2: Options động (tự động cập nhật khi mở) - TÍNH NĂNG MỚI
local playerList = {}
local function refreshPlayerList()
    playerList = {}
    for _, v in pairs(game:GetService("Players"):GetPlayers()) do
        table.insert(playerList, v.Name)
    end
    return playerList
end

TeleportTab:CreateDropdown({
    Name = "👥 TP đến player",
    GetOptions = refreshPlayerList,     -- Hàm trả về danh sách mới
    RefreshOnOpen = true,               -- Tự động refresh khi mở dropdown
    Callback = function(selected)
        local target = game:GetService("Players"):FindFirstChild(selected)
        if target and target.Character then
            local hrp = game.Players.LocalPlayer.Character.HumanoidRootPart
            hrp.CFrame = target.Character.HumanoidRootPart.CFrame
        end
    end
})
```

---

7.2 CreateColorPicker - Bảng chọn màu

Đặc điểm: Bảng màu HSV đầy đủ, có thể kéo thả chọn màu, hiển thị màu xem trước.

```lua
VisualTab:CreateColorPicker({
    Name = "🎨 Màu ESP",
    Default = Color3.fromRGB(255, 0, 0),
    Callback = function(color)
        print("Màu đã chọn:", color)
        -- Cập nhật màu ESP
        for _, v in pairs(game:GetService("Players"):GetPlayers()) do
            if v ~= game.Players.LocalPlayer then
                -- Code ESP ở đây
            end
        end
    end
})
```

---

7.3 CreateRunBox - Ô thực thi lệnh đa năng (MỚI)

Công dụng: Nhập và thực thi nhiều loại lệnh khác nhau.

```lua
local ConsoleTab = Window:CreateTab("💻 Console")
ConsoleTab:CreateRunBox({
    Placeholder = "Nhập lệnh: .heal, loadstring('url'), required('Module'), hoặc Lua code...",
    ClearOnExecute = true   -- Xóa text sau khi chạy (tùy chọn)
})
```

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
required("PlayerModule")
```

---

8. CUSTOM COMMANDS (MỚI)

Đăng ký lệnh

Cú pháp:

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
        NoirUI:Notify("💚 Heal", "Đã hồi 100 máu!")
    end
end)

-- Lệnh .speed [tốc độ] (1 tham số)
NoirUI:RegisterCommand("speed", function(args)
    local speed = tonumber(args[1]) or 16
    local char = game.Players.LocalPlayer.Character
    if char and char:FindFirstChild("Humanoid") then
        char.Humanoid.WalkSpeed = speed
        NoirUI:Notify("⚡ Speed", "Tốc độ: " .. speed)
    end
end)

-- Lệnh .tp x y z hoặc .tp [tên] (nhiều tham số)
NoirUI:RegisterCommand("tp", function(args)
    local hrp = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    
    if #args >= 3 then
        -- Teleport theo tọa độ
        local x, y, z = tonumber(args[1]), tonumber(args[2]), tonumber(args[3])
        hrp.CFrame = CFrame.new(x, y, z)
        NoirUI:Notify("🌍 Teleport", string.format("Đã dịch đến (%.0f, %.0f, %.0f)", x, y, z))
    elseif #args == 1 then
        -- Teleport đến player
        local target = game:GetService("Players"):FindFirstChild(args[1])
        if target and target.Character then
            hrp.CFrame = target.Character.HumanoidRootPart.CFrame
            NoirUI:Notify("🌍 Teleport", "Đã dịch đến " .. target.Name)
        else
            NoirUI:Notify("❌ Lỗi", "Không tìm thấy player: " .. args[1])
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
local healthConnection = nil

NoirUI:RegisterCommand("god", function(args)
    local humanoid = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")
    if humanoid then
        godMode = not godMode
        if godMode then
            if healthConnection then healthConnection:Disconnect() end
            healthConnection = humanoid:GetPropertyChangedSignal("Health"):Connect(function()
                if humanoid.Health <= 0 and godMode then
                    humanoid.Health = 100
                end
            end)
            NoirUI:Notify("👑 God Mode", "Đã bật bất tử!")
        else
            if healthConnection then healthConnection:Disconnect() end
            healthConnection = nil
            NoirUI:Notify("👑 God Mode", "Đã tắt bất tử!")
        end
    end
end)

-- Lệnh .unload (tắt UI)
NoirUI:RegisterCommand("unload", function(args)
    local gui = game.CoreGui:FindFirstChild("NoirUI_V3_Ultimate")
    if gui then
        gui:Destroy()
        NoirUI:Notify("👋 Goodbye", "UI đã được gỡ!")
    end
end)

-- Lệnh .noclip (xuyên tường)
local noclipActive = false
local noclipConnection = nil

NoirUI:RegisterCommand("noclip", function(args)
    noclipActive = not noclipActive
    
    if noclipActive then
        noclipConnection = game:GetService("RunService").Stepped:Connect(function()
            local char = game.Players.LocalPlayer.Character
            if char then
                for _, part in pairs(char:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            end
        end)
        NoirUI:Notify("🌀 Noclip", "Đã bật xuyên tường!")
    else
        if noclipConnection then noclipConnection:Disconnect() end
        local char = game.Players.LocalPlayer.Character
        if char then
            for _, part in pairs(char:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = true
                end
            end
        end
        NoirUI:Notify("🌀 Noclip", "Đã tắt xuyên tường!")
    end
end)

-- Lệnh .clear (clear chat)
NoirUI:RegisterCommand("clear", function(args)
    local chatFrame = game:GetService("CoreGui"):FindFirstChild("Chat")
    if chatFrame then
        local messageList = chatFrame:FindFirstChild("MessageList")
        if messageList then
            for _, child in pairs(messageList:GetChildren()) do
                if child:IsA("Frame") then
                    child:Destroy()
                end
            end
        end
    end
    NoirUI:Notify("🧹 Clear Chat", "Đã xóa tin nhắn!")
end)
```

---

9. RUNBOX - THỰC THI LỆNH ĐA NĂNG (MỚI)

RunBox là thành phần đặc biệt cho phép người dùng nhập và thực thi nhiều loại lệnh khác nhau mà không cần viết thêm code.

Thêm RunBox vào UI

```lua
local ConsoleTab = Window:CreateTab("⌨️ Console")
ConsoleTab:CreateRunBox({
    Placeholder = "Nhập lệnh...",
    ClearOnExecute = true  -- Xóa text sau khi chạy
})
```

Chi tiết các loại lệnh

1. Custom Commands (đã đăng ký)

```
.heal          → Gọi lệnh heal
.speed 200     → Gọi lệnh speed với tham số 200
.tp 0 100 0    → Gọi lệnh tp với 3 tham số
```

2. Loadstring

```
loadstring(game:HttpGet("https://raw.githubusercontent.com/user/script.lua"))()
```

3. Required (gọi module client-side)

```
required("ChatModule")
required("PlayerModule")
required("CameraModule")
```

4. Lua code trực tiếp

```
print("Hello World")
game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 100
for i = 1, 10 do print(i) end
local players = game:GetService("Players"):GetPlayers()
```

---

10. NOTIFICATIONS

Cú pháp cơ bản

```lua
NoirUI:Notify("Tiêu đề", "Nội dung thông báo")
```

Ví dụ

```lua
-- Thông báo thành công
NoirUI:Notify("✅ Thành công", "Đã thực hiện hành động!")

-- Thông báo cảnh báo
NoirUI:Notify("⚠️ Cảnh báo", "Có lỗi xảy ra!")

-- Thông báo lỗi
NoirUI:Notify("❌ Lỗi", "Không thể kết nối đến server!")

-- Thông báo thông tin
NoirUI:Notify("ℹ️ Thông tin", "Đã tải thành công " .. #data .. " mục")

-- Thông báo trong callback
Tab:CreateButton({
    Name = "Test Notify",
    Callback = function()
        NoirUI:Notify("🎉 Chúc mừng", "Bạn đã click nút thành công!")
    end
})
```

Đặc điểm của Notification

Đặc điểm Mô tả
Độ mờ 0.25 (có thể tùy chỉnh qua NotificationBackground)
Xếp chồng Tự động xếp chồng lên nhau, notification mới ở dưới
Thời gian Tự động biến mất sau 4 giây
Hiệu ứng Xuất hiện với hiệu ứng Back Easing, biến mất mượt mà
Vị trí Góc phải màn hình

---

11. VÍ DỤ HOÀN CHỈNH

Ví dụ 1: Admin Hub đầy đủ tính năng

```lua
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
    
    LoadingBackground = {
        Image = bgID,
        Transparency = 0.3
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
-- Lệnh heal
NoirUI:RegisterCommand("heal", function(args)
    local char = game.Players.LocalPlayer.Character
    if char and char:FindFirstChild("Humanoid") then
        char.Humanoid.Health = 100
        NoirUI:Notify("💚 Heal", "Đã hồi 100 máu!")
    end
end)

-- Lệnh speed
NoirUI:RegisterCommand("speed", function(args)
    local speed = tonumber(args[1]) or 16
    local char = game.Players.LocalPlayer.Character
    if char and char:FindFirstChild("Humanoid") then
        char.Humanoid.WalkSpeed = speed
        NoirUI:Notify("⚡ Speed", "Tốc độ: " .. speed)
    end
end)

-- Lệnh tp
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

-- Lệnh god
local godMode = false
local healthConnection = nil

NoirUI:RegisterCommand("god", function(args)
    local humanoid = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")
    if humanoid then
        godMode = not godMode
        if godMode then
            if healthConnection then healthConnection:Disconnect() end
            healthConnection = humanoid:GetPropertyChangedSignal("Health"):Connect(function()
                if humanoid.Health <= 0 and godMode then
                    humanoid.Health = 100
                end
            end)
            NoirUI:Notify("👑 God Mode", "Đã bật bất tử!")
        else
            if healthConnection then healthConnection:Disconnect() end
            healthConnection = nil
            NoirUI:Notify("👑 God Mode", "Đã tắt bất tử!")
        end
    end
end)

-- Lệnh unload
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
PlayerTab:CreateLabel("Ping: " .. game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValueString())

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
        -- Code tấn công ở đây
        NoirUI:Notify("Combat", "Đã tấn công!")
    end
})

CombatTab:CreateButton({
    Name = "🔄 Reset Character",
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
    end})

VisualTab:CreateDropdown({
    Name = "🎯 Chọn bộ phận",
    Options = {"Head", "Chest", "Legs", "Full Body"},
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

-- Dropdown động (tự động cập nhật danh sách player)
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
.god         - Bật/tắt bất tử
.noclip      - Bật/tắt xuyên tường
.clear       - Xóa chat
.unload      - Tắt UI
]]
})

-- ========== THÔNG BÁO KHỞI TẠO ==========
task.wait(2)
NoirUI:Notify("🔥 ADMIN HUB PRO", "Đã tải thành công! Dùng .heal để test lệnh.")
```

---

12. MẸO & THỦ THUẬT

12.1 Lưu cài đặt người dùng

```lua
local HttpService = game:GetService("HttpService")
local settings = {
    walkSpeed = 16,
    jumpPower = 50,
    autoFarm = false,
    espColor = Color3.fromRGB(255, 0, 0)
}

-- Hàm lưu settings
local function saveSettings()
    if writefile then
        local data = HttpService:JSONEncode(settings)
        writefile("hub_settings.json", data)
    end
end

-- Hàm tải settings
local function loadSettings()
    if isfile and isfile("hub_settings.json") then
        local data = readfile("hub_settings.json")
        local loaded = HttpService:JSONDecode(data)
        for k, v in pairs(loaded) do
            settings[k] = v
        end
    end
end

-- Gọi load khi khởi tạo
loadSettings()

-- Lưu khi thay đổi
Tab:CreateSlider({
    Name = "WalkSpeed",
    Min = 16, Max = 250, Default = settings.walkSpeed,
    Callback = function(v)
        settings.walkSpeed = v
        saveSettings()
    end
})
```

12.2 Thêm animation cho button

```lua
-- Thêm effect hover cho button (tự thêm vào code gốc hoặc tạo function riêng)
local function addButtonHoverEffect(button)
    button.MouseEnter:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.2), {BackgroundTransparency = 0.2}):Play()
    end)
    button.MouseLeave:Connect(function()
        TweenService:Create(button, TweenInfo.new(0.2), {BackgroundTransparency = 0.6}):Play()
    end)
end
```

12.3 Toggle UI bằng phím tắt

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

12.4 Tạo nhiều tab với icon từ Lucide

```lua
-- Sử dụng icon từ thư viện Lucide có sẵn
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

12.5 Xử lý khi UI bị destroy

```lua
-- Lưu ý: Khi UI bị destroy, các connection vẫn chạy
-- Nên cleanup khi cần

local function cleanupUI()
    local gui = game.CoreGui:FindFirstChild("NoirUI_V3_Ultimate")
    if gui then
        -- Hủy các connection chạy nền
        if healthConnection then healthConnection:Disconnect() end
        if noclipConnection then noclipConnection:Disconnect() end
        
        -- Xóa UI
        gui:Destroy()
    end
end

-- Đăng ký lệnh unload
NoirUI:RegisterCommand("unload", function(args)
    cleanupUI()
end)
```

---

13. BẢNG TỔNG KẾT NHANH

13.1 Tham số CreateWindow

Tham số Type Required Default
Name string ✅ -
Accent Color3 ❌ Color3.fromRGB(170,85,255)
Icon string/number ❌ nil
LogoID number ❌ nil
DefaultPosition UDim2 ❌ UDim2.new(0.5,-210,0.5,-150)
FloatDefaultPosition UDim2 ❌ UDim2.new(0,15,0.5,-22)
Background table ❌ nil
LoadingBackground table ❌ nil
KeyBackground table ❌ nil
NotificationBackground table ❌ nil
FloatBackground table ❌ nil
MainBgColor Color3 ❌ Color3.fromRGB(10,10,10)
MainBgTransparency number ❌ 0
SidebarTransparency number ❌ 0.5
ContentTransparency number ❌ 0.3
KeySystem boolean ❌ false
KeySettings table ❌ nil

13.2 Các thành phần UI

Component Method Parameters
Label CreateLabel(text) text: string
Section CreateSection(text) text: string
Paragraph CreateParagraph({Title, Content}) Title, Content
Button CreateButton({Name, Callback}) Name, Callback
Toggle CreateToggle({Name, Default, Callback}) Name, Default, Callback
Slider CreateSlider({Name, Min, Max, Default, Callback}) Tất cả
TextBox CreateTextBox({Name, Callback}) Name, Callback
Dropdown CreateDropdown({Name, Options/GetOptions, Default, Callback, RefreshOnOpen}) Xem trên
ColorPicker CreateColorPicker({Name, Default, Callback}) Name, Default, Callback
RunBox CreateRunBox({Placeholder, ClearOnExecute}) Placeholder, ClearOnExecute

13.3 Các loại lệnh RunBox

Loại Cú pháp Ví dụ
Custom Command .command args .heal, .speed 100
Loadstring loadstring("code")() loadstring(game:HttpGet("url"))()
Required required("module") required("ChatModule")
Lua Code lua code print("Hello")

---

🎉 KẾT LUẬN

NoirUI V3 Ultimate là một thư viện UI mạnh mẽ và hiện đại, cung cấp đầy đủ các thành phần cần thiết để tạo ra một giao diện chuyên nghiệp. Với các tính năng mới như:

· ✅ Background tùy chỉnh cho từng thành phần
· ✅ Key System bảo vệ script
· ✅ Custom Commands với prefix .
· ✅ RunBox đa năng
· ✅ Dropdown động tự cập nhật
· ✅ 250+ icon Lucide tích hợp sẵn

Bạn có thể dễ dàng tạo ra bất kỳ loại UI nào từ đơn giản đến phức tạp chỉ với vài dòng code.

---

Chúc bạn thành công với NoirUI V3 Ultimate! 🚀
