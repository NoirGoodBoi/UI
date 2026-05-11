📘 HƯỚNG DẪN SỬ DỤNG NOIR UI

📦 CÀI ĐẶT CƠ BẢN

```lua
-- Load UI
local NoirUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/NoirGoodBoi/UI/main/NoirUI.lua"))()

-- Tạo cửa sổ chính
local Window = NoirUI:CreateWindow({
    Name = "My Awesome Hub",           -- Tên UI
    Accent = Color3.fromRGB(170, 85, 255), -- Màu chủ đạo
    Icon = "settings",                  -- Icon cho float button
    DefaultPosition = UDim2.new(0.5, -210, 0.5, -150),  -- Vị trí main UI
    FloatDefaultPosition = UDim2.new(0, 15, 0.5, -22),  -- Vị trí float button
})
```

🎨 TẠO TAB

```lua
local MainTab = Window:CreateTab("Main", "home")     -- Tab chính
local SettingsTab = Window:CreateTab("Settings", "settings")  -- Tab cài đặt
local InfoTab = Window:CreateTab("Info", "info")     -- Tab thông tin
```

🧩 CÁC ELEMENT

1. Label - Văn bản động

```lua
MainTab:CreateLabel("Welcome to my script!")
MainTab:CreateLabel(function() 
    return "Health: " .. game.Players.LocalPlayer.Character.Humanoid.Health 
end)  -- Cập nhật realtime
```

2. Section - Phần chia

```lua
MainTab:CreateSection("Player Settings")      -- Có đường kẻ
MainTab:CreateSection("Utilities", true)      -- Không đường kẻ
```

3. Paragraph - Đoạn văn bản

```lua
MainTab:CreateParagraph({
    Title = "Information",
    Content = "Đây là một đoạn văn bản dài có thể xuống dòng và hiển thị thông tin chi tiết cho người dùng."
})
```

4. Button - Nút bấm

```lua
MainTab:CreateButton({
    Name = "Teleport to Base",
    Subtitle = "Dịch chuyển đến khu vực an toàn",  -- Tùy chọn
    Callback = function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(0, 10, 0)
        NoirUI:Notify("Teleport", "Đã dịch chuyển thành công!", "map-pin")
    end
})

-- Nút với align trái
MainTab:CreateButton({
    Name = "Left Align Button",
    Align = false,  -- Text căn trái, hiện "button" bên phải
    Callback = function()
        print("Clicked!")
    end
})
```

5. Toggle - Công tắc bật/tắt

```lua
local autoFarmState = false
MainTab:CreateToggle({
    Name = "Auto Farm",
    Subtitle = "Tự động farm khi bật",  -- Tùy chọn
    Default = false,                     -- Trạng thái mặc định
    Callback = function(state)
        autoFarmState = state
        print("Auto Farm:", state)
        if state then
            -- Bắt đầu farm
        else
            -- Dừng farm
        end
    end
})
```

6. Slider - Thanh trượt

```lua
MainTab:CreateSlider({
    Name = "Walk Speed",
    Subtitle = "Tốc độ di chuyển",      -- Tùy chọn
    range = {16, 100},                   -- {min, max}
    increment = 1,                       -- Bước nhảy
    Default = 16,                        -- Giá trị mặc định
    Callback = function(value)
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = value
    end
})

-- Slider với increment 0.1
MainTab:CreateSlider({
    Name = "Volume",
    range = {0, 1},
    increment = 0.1,
    Default = 0.5,
    Callback = function(value)
        NoirUI:SetVolume(value)
    end
})
```

7. TextBox - Ô nhập liệu

```lua
MainTab:CreateTextBox({
    Name = "Enter Password",
    Subtitle = "Nhập key để kích hoạt",  -- Tùy chọn
    Default = "",                         -- Giá trị mặc định
    Callback = function(text)
        print("Input:", text)
        if text == "secret123" then
            NoirUI:Notify("Success", "Key chính xác!", "check")
        end
    end
})
```

8. ColorPicker - Chọn màu

```lua
MainTab:CreateColorPicker({
    Name = "UI Accent Color",
    Subtitle = "Chọn màu sắc yêu thích",  -- Tùy chọn
    Default = Color3.fromRGB(255, 100, 100),
    Callback = function(color)
        print("Color selected:", color)
        -- Thay đổi màu UI...
    end
})
```

9. Dropdown - Dropdown menu

```lua
-- Dropdown tĩnh
MainTab:CreateDropdown({
    Name = "Select Weapon",
    Subtitle = "Chọn vũ khí",            -- Tùy chọn
    Options = {"Sword", "Gun", "Bow", "Staff"},
    Default = "Sword",                    -- Giá trị mặc định
    Callback = function(option)
        print("Selected:", option)
    end
})

-- Dropdown động (tự cập nhật)
MainTab:CreateDropdown({
    Name = "Select Player",
    RefreshOnOpen = true,                 -- Refresh khi mở
    GetOptions = function()
        local players = {}
        for _, v in pairs(game.Players:GetChildren()) do
            if v ~= game.Players.LocalPlayer then
                table.insert(players, v.Name)
            end
        end
        return players
    end,
    Callback = function(option)
        print("Selected player:", option)
    end
})

-- Dropdown với refresh interval
MainTab:CreateDropdown({
    Name = "Live Players",
    RefreshInterval = true,               -- Tự động refresh
    GetOptions = function()
        return game.Players:GetChildren()
    end,
    Callback = function(option)
        print(option)
    end
})
```

10. RunBox - Chạy code

```lua
MainTab:CreateRunBox({
    Placeholder = "Nhập lệnh...",         -- Text gợi ý
    ClearOnExecute = true,                -- Xóa sau khi chạy
})

-- Các lệnh có sẵn:
-- .tp 0 10 0     -> Dịch chuyển (cần register command)
-- loadstring('print("Hello")')
-- print("Hello World")
```

🔊 HỆ THỐNG ÂM THANH

```lua
-- Chuyển đổi giữa các Vibe
NoirUI:SetVibe("Cyber")      -- Âm thanh điện tử
NoirUI:SetVibe("Soft")       -- Nhẹ nhàng
NoirUI:SetVibe("Retro")      -- Game cổ điển
NoirUI:SetVibe("Nature")     -- Thiên nhiên
NoirUI:SetVibe("Default")    -- Mặc định

-- Custom sound riêng
NoirUI:SetCustomSound("Click", "rbxassetid://1234567890")
NoirUI:SetCustomSound("Error", "rbxassetid://9876543210")
NoirUI:SetCustomSound("Success", "rbxassetid://5555555555")

-- Bật/tắt âm thanh
NoirUI:ToggleSound(false)    -- Tắt
NoirUI:ToggleSound(true)     -- Bật

-- Chỉnh âm lượng (0-1)
NoirUI:SetVolume(0.7)        -- 70% volume
```

💬 NOTIFICATION

```lua
-- Notify cơ bản
NoirUI:Notify("Title", "Message")

-- Notify với icon
NoirUI:Notify("Success", "Done!", "check")

-- Notify với âm thanh riêng
NoirUI:Notify("Error", "Something wrong!", "alert-triangle", "Error")
NoirUI:Notify("Good", "Completed!", "check-circle", "Success")
```

⌨️ CUSTOM COMMANDS (cho RunBox)

```lua
-- Đăng ký command
NoirUI:RegisterCommand("tp", function(args)
    local x = tonumber(args[1]) or 0
    local y = tonumber(args[2]) or 10
    local z = tonumber(args[3]) or 0
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(x, y, z)
    NoirUI:Notify("Teleport", string.format("Đã dịch chuyển đến (%d, %d, %d)", x, y, z), "map-pin")
end)

NoirUI:RegisterCommand("heal", function()
    local char = game.Players.LocalPlayer.Character
    if char and char.Humanoid then
        char.Humanoid.Health = char.Humanoid.MaxHealth
        NoirUI:Notify("Heal", "Đã hồi máu!", "heart")
    end
end)

NoirUI:RegisterCommand("kick", function(args)
    local target = args[1]
    if target then
        -- Code kick player...
        NoirUI:Notify("Kick", "Đã kick " .. target, "user-x")
    end
end)

-- Sử dụng trong RunBox: .tp 100 50 200
-- Sử dụng: .heal
-- Sử dụng: .kick PlayerName
```

🎨 TÙY CHỈNH NÂNG CAO

```lua
local Window = NoirUI:CreateWindow({
    -- Cơ bản
    Name = "Advanced Hub",
    Accent = Color3.fromRGB(255, 50, 150),
    Icon = "rocket",
    
    -- Vị trí
    DefaultPosition = UDim2.new(0.5, -300, 0.5, -200),
    FloatDefaultPosition = UDim2.new(0, 20, 0.5, -30),
    
    -- Màu sắc
    MainBgColor = Color3.fromRGB(8, 8, 12),
    MainBgTransparency = 0.05,
    
    -- Background ảnh cho main UI
    Background = {
        Image = "rbxassetid://1234567890",  -- hoặc số ID
        Transparency = 0.2
    },
    
    -- Background cho float button
    FloatBackground = {
        Image = 1234567890,
        Transparency = 0.1
    },
    
    -- Logo
    LogoID = "home",  -- hoặc "rbxassetid://..."
    
    -- Key System
    KeySystem = true,
    KeySettings = {
        Key = "mysecretkey123",     -- Hoặc {"key1", "key2"}
        SaveKey = true,              -- Lưu key
        FileName = "MyKey",          -- Tên file lưu
        Title = "🔐 AUTHORIZED ACCESS",
        Subtitle = "Nhập key để sử dụng",
        Note = "Liên hệ admin để lấy key"
    },
    
    -- Background cho key system
    KeyBackground = {
        Image = "rbxassetid://9876543210",
        Transparency = 0.1
    },
    
    -- Background cho loading
    LoadingBackground = {
        Image = "rbxassetid://5555555555",
        Transparency = 0.3
    },
    
    -- Background cho notification
    NotificationBackground = {
        Image = "rbxassetid://1111111111",
        Transparency = 0.2
    }
})
```

📝 VÍ DỤ HOÀN CHỈNH

```lua
local NoirUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/NoirGoodBoi/UI/main/NoirUI.lua"))()

-- Tạo window
local Window = NoirUI:CreateWindow({
    Name = "💀 DARK HUB 💀",
    Accent = Color3.fromRGB(255, 50, 50),
    Icon = "skull",
})

-- Tab Player
local PlayerTab = Window:CreateTab("Player", "user")

PlayerTab:CreateSection("Character Settings")

local speed = 16
PlayerTab:CreateSlider({
    Name = "Walk Speed",
    range = {16, 500},
    Default = 16,
    Callback = function(v)
        speed = v
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = v
    end
})

PlayerTab:CreateToggle({
    Name = "Fly Mode",
    Subtitle = "Bật để bay",
    Default = false,
    Callback = function(state)
        if state then
            -- Code fly...
            NoirUI:Notify("Fly", "Đã bật chế độ bay!", "wings")
        else
            -- Tắt fly
            NoirUI:Notify("Fly", "Đã tắt chế độ bay!", "wings")
        end
    end
})

-- Tab Teleport
local TeleportTab = Window:CreateTab("Teleport", "map-pin")

TeleportTab:CreateSection("Locations")

local locations = {
    {name = "Spawn", pos = CFrame.new(0, 10, 0)},
    {name = "Shop", pos = CFrame.new(100, 10, 200)},
    {name = "Arena", pos = CFrame.new(-150, 20, 50)}
}

for _, loc in pairs(locations) do
    TeleportTab:CreateButton({
        Name = "Teleport to " .. loc.name,
        Callback = function()
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = loc.pos
            NoirUI:Notify("Teleport", "Đã đến " .. loc.name, "map-pin", "Success")
        end
    })
end

-- Tab Settings
local SettingsTab = Window:CreateTab("Settings", "settings")

SettingsTab:CreateSection("Audio")

SettingsTab:CreateDropdown({
    Name = "Sound Vibe",
    Options = {"Default", "Cyber", "Soft", "Retro", "Nature"},
    Default = "Default",
    Callback = function(vibe)
        NoirUI:SetVibe(vibe)
        NoirUI:Notify("Sound", "Đã chuyển sang " .. vibe, "music")
    end
})

SettingsTab:CreateSlider({
    Name = "Volume",
    range = {0, 1},
    increment = 0.1,
    Default = 0.5,
    Callback = function(v)
        NoirUI:SetVolume(v)
    end
})

SettingsTab:CreateToggle({
    Name = "Enable Sound",
    Default = true,
    Callback = function(state)
        NoirUI:ToggleSound(state)
    end
})

SettingsTab:CreateSection("Commands")

SettingsTab:CreateRunBox({
    Placeholder = "Nhập lệnh hoặc code tại đây...",
    ClearOnExecute = true
})

-- Register custom commands
NoirUI:RegisterCommand("reset", function()
    game.Players.LocalPlayer.Character.Humanoid.Health = 0
    NoirUI:Notify("Reset", "Đã tự sát!", "skull", "Error")
end)

NoirUI:RegisterCommand("bring", function(args)
    local target = args[1]
    if target then
        local player = game.Players:FindFirstChild(target)
        if player and player.Character then
            player.Character.HumanoidRootPart.CFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
            NoirUI:Notify("Bring", "Đã kéo " .. target, "user-plus", "Success")
        end
    end
end)

-- Info Tab
local InfoTab = Window:CreateTab("Info", "info")

InfoTab:CreateParagraph({
    Title = "About",
    Content = "Dark Hub - Ultimate Script Hub\nVersion: 1.0\nCreator: Noir"
})

InfoTab:CreateLabel("User: " .. game.Players.LocalPlayer.Name)
InfoTab:CreateLabel(function()
    return "Ping: " .. math.floor(game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValue()) .. "ms"
end)
```

🎯 MẸO VÀ THỦ THUẬT

1. Cập nhật label realtime

```lua
local healthLabel = MainTab:CreateLabel(function()
    local char = game.Players.LocalPlayer.Character
    if char and char.Humanoid then
        return "HP: " .. math.floor(char.Humanoid.Health) .. "/" .. char.Humanoid.MaxHealth
    end
    return "HP: 0/100"
end)
```

2. Toggle với nhiều chức năng

```lua
local features = {
    autoFarm = false,
    autoCollect = false,
    autoSell = false
}

MainTab:CreateToggle({
    Name = "Auto Farm",
    Callback = function(state)
        features.autoFarm = state
        if state then
            startAutoFarm()
        else
            stopAutoFarm()
        end
    end
})
```

3. Slider với nhiều giá trị

```lua
MainTab:CreateSlider({
    Name = "Settings Value",
    range = {0, 100},
    increment = 5,
    Default = 50,
    Callback = function(v)
        -- Lưu vào settings
        getgenv().SettingsValue = v
    end
})
```

4. Dropdown động theo thời gian thực

```lua
local playerDropdown = MainTab:CreateDropdown({
    Name = "Target Player",
    RefreshOnOpen = true,
    GetOptions = function()
        local list = {}
        for _, v in pairs(game.Players:GetPlayers()) do
            if v ~= game.Players.LocalPlayer then
                table.insert(list, v.Name)
            end
        end
        return list
    end,
    Callback = function(player)
        print("Selected target:", player)
    end
})
```

5. Kết hợp nhiều elements

```lua
local selectedItem = "Sword"
local quantity = 1

MainTab:CreateDropdown({
    Name = "Item",
    Options = {"Sword", "Shield", "Potion"},
    Callback = function(item)
        selectedItem = item
    end
})

MainTab:CreateSlider({
    Name = "Quantity",
    range = {1, 99},
    Callback = function(qty)
        quantity = qty
    end
})

MainTab:CreateButton({
    Name = "Buy Item",
    Callback = function()
        NoirUI:Notify("Purchase", string.format("Đã mua %d %s", quantity, selectedItem), "shopping-cart", "Success")
    end
})
```

❗ XỬ LÝ LỖI THƯỜNG GẶP

UI không hiển thị

```lua
-- Kiểm tra CoreGui
if not game.CoreGui:FindFirstChild("NoirUI_V3_Ultimate") then
    print("UI chưa được tạo")
end

-- Force show
Main.Visible = true
```

Âm thanh không phát

```lua
-- Kiểm tra sound settings
print("Sound enabled:", SoundSettings.Enabled)
print("Current volume:", SoundSettings.Volume)

-- Test sound
NoirUI:SetVolume(1)
NoirUI:ToggleSound(true)
NoirUI:Notify("Test", "Testing sound", nil, "Click")
```

Key System không hoạt động

```lua
-- Kiểm tra key
NoirUI:CreateWindow({
    KeySystem = true,
    KeySettings = {
        Key = {"key1", "key2", "key3"},  -- Dùng table nếu nhiều key
        SaveKey = true,
    }
})
```

Chúc bạn thành công! 🚀
