local TweenService = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")

-- // Xóa UI cũ nếu tồn tại
local OldGui = game.CoreGui:FindFirstChild("NoirUI_V3_Ultimate")
if OldGui then OldGui:Destroy() end

local NoirUI = { Notifications = {}, ActiveConfirmFrame = nil, CustomCommands = {} }

-- // Hàm kéo thả
local function MakeDraggable(frame)
    local dragging, dragInput, dragStart, startPos
    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true; dragStart = input.Position; startPos = frame.Position
            input.Changed:Connect(function() if input.UserInputState == Enum.UserInputState.End then dragging = false end end)
        end
    end)
    frame.InputChanged:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then dragInput = input end end)
    UIS.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
end

-- // Hàm tải background
local function LoadBackground(frame, bgSetting)
    if not bgSetting then return end
    
    local bgImage = Instance.new("ImageLabel", frame)
    bgImage.Size = UDim2.new(1, 0, 1, 0)
    bgImage.Position = UDim2.new(0, 0, 0, 0)
    bgImage.BackgroundTransparency = 1
    bgImage.ZIndex = 0
    bgImage.ImageTransparency = bgSetting.Transparency or 0.5
    bgImage.ScaleType = Enum.ScaleType.Crop
    
    -- Xử lý ID Roblox
    if type(bgSetting.Image) == "number" or (type(bgSetting.Image) == "string" and bgSetting.Image:match("^%d+$")) then
        bgImage.Image = "rbxassetid://" .. tostring(bgSetting.Image)
    -- Xử lý URL
    elseif type(bgSetting.Image) == "string" and bgSetting.Image:match("^http") then
        bgImage.Image = bgSetting.Image
    -- Xử lý rbxasset
    elseif type(bgSetting.Image) == "string" then
        bgImage.Image = bgSetting.Image
    end
    
    -- Đưa background xuống dưới cùng
    local function SendToBack()
        bgImage.ZIndex = 0
        for _, child in pairs(frame:GetChildren()) do
            if child ~= bgImage and child:IsA("GuiObject") then
                child.ZIndex = math.max(child.ZIndex, 1)
            end
        end
    end
    
    SendToBack()
    frame.ChildAdded:Connect(SendToBack)
end

-- // Đăng ký custom command
function NoirUI:RegisterCommand(prefix, callback)
    NoirUI.CustomCommands[prefix:lower()] = callback
end

function NoirUI:CreateWindow(settings)
    local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
    ScreenGui.Name = "NoirUI_V3_Ultimate"
    ScreenGui.ResetOnSpawn = false
    local ACCENT = settings.Accent or Color3.fromRGB(170, 85, 255)
    
    -- Lưu vị trí mặc định của MAIN UI
    local mainDefaultPos = settings.DefaultPosition or UDim2.new(0.5, -210, 0.5, -150)
    local floatDefaultPos = settings.FloatDefaultPosition or UDim2.new(0, 15, 0.5, -22)
    
    -- //////////////// MAIN UI ////////////////
    local Main = Instance.new("Frame", ScreenGui)
    Main.Size = UDim2.new(0, 420, 0, 300)
    Main.Position = mainDefaultPos
    Main.BackgroundColor3 = settings.MainBgColor or Color3.fromRGB(10, 10, 10)
    Main.BackgroundTransparency = settings.MainBgTransparency or 0
    Main.ClipsDescendants = true
    Main.Visible = false
    Main.BackgroundTransparency = 1
    Instance.new("UICorner", Main)
    local MainStroke = Instance.new("UIStroke", Main)
    MainStroke.Thickness = 2
    
    -- // Load Background cho Main UI
    if settings.Background then
        LoadBackground(Main, settings.Background)
    end
    
    -- //////////////// BẢNG LOADING (CHỈ BACKGROUND FADE, CHỮ HIỆN RÕ NGAY) ////////////////
    local LoadingFrame = Instance.new("Frame", ScreenGui)
    LoadingFrame.Size = UDim2.new(0, 300, 0, 120)
    LoadingFrame.Position = UDim2.new(0.5, -150, 0.5, -60)
    LoadingFrame.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
    LoadingFrame.BackgroundTransparency = 1
    LoadingFrame.ZIndex = 200
    Instance.new("UICorner", LoadingFrame).CornerRadius = UDim.new(0, 12)
    local LoadingStroke = Instance.new("UIStroke", LoadingFrame)
    LoadingStroke.Color = ACCENT
    LoadingStroke.Thickness = 2
    LoadingStroke.Transparency = 1
    
    -- Load Background cho Loading nếu có
    if settings.LoadingBackground then
        LoadBackground(LoadingFrame, settings.LoadingBackground)
    end
    
    -- Chữ hiện rõ ngay từ đầu (không fade)
    local LoadingTitle = Instance.new("TextLabel", LoadingFrame)
    LoadingTitle.Size = UDim2.new(1, -40, 0, 30)
    LoadingTitle.Position = UDim2.new(0, 20, 0, 15)
    LoadingTitle.BackgroundTransparency = 1
    LoadingTitle.Text = settings.Name or "NOIR HUB"
    LoadingTitle.TextColor3 = ACCENT
    LoadingTitle.Font = "GothamBold"
    LoadingTitle.TextSize = 18
    LoadingTitle.TextXAlignment = "Left"
    LoadingTitle.ZIndex = 201
    
    local LoadingSub = Instance.new("TextLabel", LoadingFrame)
    LoadingSub.Size = UDim2.new(1, -40, 0, 20)
    LoadingSub.Position = UDim2.new(0, 20, 0, 45)
    LoadingSub.BackgroundTransparency = 1
    LoadingSub.Text = "Đang khởi tạo..."
    LoadingSub.TextColor3 = Color3.fromRGB(180, 180, 180)
    LoadingSub.Font = "GothamMedium"
    LoadingSub.TextSize = 12
    LoadingSub.TextXAlignment = "Left"
    LoadingSub.ZIndex = 201
    
    local LoadingBarBg = Instance.new("Frame", LoadingFrame)
    LoadingBarBg.Size = UDim2.new(0.86, 0, 0, 6)
    LoadingBarBg.Position = UDim2.new(0.07, 0, 0.7, 0)
    LoadingBarBg.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    LoadingBarBg.BackgroundTransparency = 0.5
    Instance.new("UICorner", LoadingBarBg).CornerRadius = UDim.new(1, 0)
    LoadingBarBg.ZIndex = 201
    
    local LoadingBar = Instance.new("Frame", LoadingBarBg)
    LoadingBar.Size = UDim2.new(0, 0, 1, 0)
    LoadingBar.BackgroundColor3 = ACCENT
    Instance.new("UICorner", LoadingBar).CornerRadius = UDim.new(1, 0)
    LoadingBar.ZIndex = 201
    
    local LoadingPercent = Instance.new("TextLabel", LoadingFrame)
    LoadingPercent.Size = UDim2.new(1, 0, 0, 20)
    LoadingPercent.Position = UDim2.new(0, 0, 0.85, 0)
    LoadingPercent.BackgroundTransparency = 1
    LoadingPercent.Text = "0%"
    LoadingPercent.TextColor3 = ACCENT
    LoadingPercent.Font = "GothamBold"
    LoadingPercent.TextSize = 12
    LoadingPercent.ZIndex = 201
    
    -- Hàm chạy loading: 0.5s fade in background, 1s chạy thanh, 0.5s fade out
    local function StartLoading()
        LoadingFrame.Visible = true
        
        TweenService:Create(LoadingFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = 0}):Play()
        TweenService:Create(LoadingStroke, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Transparency = 0}):Play()
        
        task.wait(0.5)
        
        local startTime = tick()
        local loadingConnection
        loadingConnection = RunService.RenderStepped:Connect(function()
            local elapsed = tick() - startTime
            local percent = math.min(1, elapsed / 1)
            LoadingBar.Size = UDim2.new(percent, 0, 1, 0)
            LoadingPercent.Text = math.floor(percent * 100) .. "%"
            
            if percent >= 1 then
                loadingConnection:Disconnect()
                LoadingSub.Text = "Loaded!"
                
                TweenService:Create(LoadingFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = 1}):Play()
                TweenService:Create(LoadingStroke, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Transparency = 1}):Play()
                task.wait(0.5)
                LoadingFrame:Destroy()
            end
        end)
    end
    
    -- Hiệu ứng cầu vồng viền main
    task.spawn(function()
        while Main and Main.Parent do
            for i = 0, 1, 0.01 do
                if not Main or not Main.Parent then break end
                MainStroke.Color = Color3.fromHSV(i, 0.8, 1)
                task.wait(0.04)
            end
        end
    end)
    
    -- //////////////// HỆ THỐNG KEY (HIỆN TRƯỚC LOADING) ////////////////
    local KeySolved = false
    local KUI = nil
    
    local function ShowMainUIAfterLoading()
        task.wait(2)
        TweenService:Create(Main, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = settings.MainBgTransparency or 0}):Play()
        Main.Visible = true
        Main.Position = mainDefaultPos
    end
    
    if settings.KeySystem then
        local KS = settings.KeySettings or {}
        local KeyPath = (KS.FileName or "NoirKey") .. ".json"
        local function CheckKeys(val)
            local keys = type(KS.Key) == "table" and KS.Key or {KS.Key}
            for _, k in pairs(keys) do if val == k then return true end end
            return false
        end
        
        LoadingFrame.Visible = false
        
        if KS.SaveKey and isfile and isfile(KeyPath) then
            local saved = readfile(KeyPath)
            if CheckKeys(saved) then
                KeySolved = true
                StartLoading()
                ShowMainUIAfterLoading()
            end
        end
        
        if not KeySolved then
            KUI = Instance.new("Frame", ScreenGui)
            KUI.Size = UDim2.new(0, 320, 0, 200)
            KUI.Position = UDim2.new(0.5, -160, 0.5, -100)
            KUI.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
            KUI.BackgroundTransparency = 0
            Instance.new("UICorner", KUI)
            local kstr = Instance.new("UIStroke", KUI)
            kstr.Thickness = 2
            kstr.Color = ACCENT
            MakeDraggable(KUI)
            
            if settings.KeyBackground then
                LoadBackground(KUI, settings.KeyBackground)
            end
            
            TweenService:Create(KUI, TweenInfo.new(0.3), {BackgroundTransparency = 0}):Play()
            
            local KT = Instance.new("TextLabel", KUI)
            KT.Size = UDim2.new(1,0,0,35)
            KT.Position = UDim2.new(0,0,0,10)
            KT.Text = KS.Title or "KEY SYSTEM"
            KT.TextColor3 = ACCENT
            KT.Font = "GothamBold"
            KT.TextSize = 16
            KT.BackgroundTransparency = 1
            KT.ZIndex = 2
            
            local KSub = Instance.new("TextLabel", KUI)
            KSub.Size = UDim2.new(1,0,0,20)
            KSub.Position = UDim2.new(0,0,0,30)
            KSub.Text = KS.Subtitle or "Vui lòng nhập key để tiếp tục"
            KSub.TextColor3 = Color3.fromRGB(150,150,150)
            KSub.Font = "GothamMedium"
            KSub.TextSize = 12
            KSub.BackgroundTransparency = 1
            KSub.ZIndex = 2
            
            local KI = Instance.new("TextBox", KUI)
            KI.Size = UDim2.new(0.8, 0, 0, 35)
            KI.Position = UDim2.new(0.1, 0, 0.35, 10)
            KI.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
            KI.TextColor3 = Color3.new(1,1,1)
            KI.PlaceholderText = "Nhập Key..."
            KI.Text = ""
            Instance.new("UICorner", KI)
            Instance.new("UIStroke", KI).Color = Color3.fromRGB(40,40,40)
            KI.ZIndex = 2
            
            local Note = Instance.new("TextLabel", KUI)
            Note.Size = UDim2.new(0.8,0,0,30)
            Note.Position = UDim2.new(0.1,0,0.55,10)
            Note.Text = KS.Note or ""
            Note.TextColor3 = Color3.fromRGB(120,120,120)
            Note.Font = "Gotham"
            Note.TextSize = 10
            Note.BackgroundTransparency = 1
            Note.TextWrapped = true
            Note.ZIndex = 2
            
            local KB = Instance.new("TextButton", KUI)
            KB.Size = UDim2.new(0.8, 0, 0, 35)
            KB.Position = UDim2.new(0.1, 0, 0.75, 10)
            KB.BackgroundColor3 = ACCENT
            KB.Text = "XÁC NHẬN"
            KB.Font = "GothamBold"
            KB.TextColor3 = Color3.new(1,1,1)
            Instance.new("UICorner", KB)
            KB.ZIndex = 2
            
            KB.MouseButton1Click:Connect(function()
                if CheckKeys(KI.Text) then
                    if KS.SaveKey and writefile then writefile(KeyPath, KI.Text) end
                    TweenService:Create(KUI, TweenInfo.new(0.3), {BackgroundTransparency = 1}):Play()
                    task.wait(0.3)
                    KUI:Destroy()
                    KeySolved = true
                    StartLoading()
                    ShowMainUIAfterLoading()
                else
                    KI.Text = ""
                    KI.PlaceholderText = "Key không chính xác!"
                    task.wait(1)
                    KI.PlaceholderText = "Nhập Key..."
                end
            end)
        end
    else
        StartLoading()
        ShowMainUIAfterLoading()
    end
    
    -- //////////////// HEADER ////////////////
    local Header = Instance.new("Frame", Main)
    Header.Size = UDim2.new(1, 0, 0, 40)
    Header.BackgroundTransparency = 1
    if settings.LogoID then
        local L = Instance.new("ImageLabel", Header)
        L.Size = UDim2.new(0, 24, 0, 24)
        L.Position = UDim2.new(0, 10, 0.5, -12)
        L.BackgroundTransparency = 1
        L.Image = "rbxassetid://"..tostring(settings.LogoID)
    end
    local Title = Instance.new("TextLabel", Header)
    Title.Size = UDim2.new(1, -120, 1, 0)
    Title.Position = UDim2.new(0, settings.LogoID and 40 or 15, 0, 0)
    Title.BackgroundTransparency = 1
    Title.Text = settings.Name or "NOIR HUB"
    Title.TextColor3 = Color3.new(1,1,1)
    Title.Font = "GothamBold"
    Title.TextSize = 14
    Title.TextXAlignment = "Left"
    
    local Btns = Instance.new("Frame", Header)
    Btns.Size = UDim2.new(0, 70, 1, 0)
    Btns.Position = UDim2.new(1, -75, 0, 0)
    Btns.BackgroundTransparency = 1
    local BL = Instance.new("UIListLayout", Btns)
    BL.FillDirection = "Horizontal"
    BL.HorizontalAlignment = "Right"
    BL.VerticalAlignment = "Center"
    BL.Padding = UDim.new(0, 8)
    
    local function TopB(txt, col, cb)
        local b = Instance.new("TextButton", Btns)
        b.Size = UDim2.new(0, 22, 0, 22)
        b.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
        b.Text = txt
        b.TextColor3 = col
        b.Font = "GothamBold"
        Instance.new("UICorner", b)
        b.MouseButton1Click:Connect(cb)
    end
    
    local isM = false
    TopB("-", Color3.fromRGB(255, 200, 50), function()
        isM = not isM
        TweenService:Create(Main, TweenInfo.new(0.4), {Size = isM and UDim2.new(0, 420, 0, 40) or UDim2.new(0, 420, 0, 300)}):Play()
    end)
    
    TopB("X", Color3.fromRGB(255, 100, 100), function()
        if NoirUI.ActiveConfirmFrame then return end
        local Conf = Instance.new("Frame", ScreenGui)
        NoirUI.ActiveConfirmFrame = Conf
        Conf.Size = UDim2.new(0, 260, 0, 120)
        Conf.Position = UDim2.new(0.5, -130, 0.5, -60)
        Conf.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
        Conf.ZIndex = 100
        Instance.new("UICorner", Conf)
        local s = Instance.new("UIStroke", Conf)
        s.Color = ACCENT
        s.Thickness = 2
        local t = Instance.new("TextLabel", Conf)
        t.Size = UDim2.new(1, 0, 0.5, 0)
        t.BackgroundTransparency = 1
        t.Text = "Bạn có muốn đóng UI không?"
        t.TextColor3 = Color3.new(1,1,1)
        t.Font = "GothamMedium"
        t.TextSize = 13
        t.ZIndex = 101
        local cbtn = Instance.new("TextButton", Conf)
        cbtn.Size = UDim2.new(0.4, 0, 0, 32)
        cbtn.Position = UDim2.new(0.07, 0, 0.6, 0)
        cbtn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
        cbtn.Text = "Cancel"
        cbtn.TextColor3 = Color3.new(1,1,1)
        cbtn.ZIndex = 101
        Instance.new("UICorner", cbtn)
        local fbtn = Instance.new("TextButton", Conf)
        fbtn.Size = UDim2.new(0.4, 0, 0, 32)
        fbtn.Position = UDim2.new(0.53, 0, 0.6, 0)
        fbtn.BackgroundColor3 = ACCENT
        fbtn.Text = "Confirm"
        fbtn.TextColor3 = Color3.new(1,1,1)
        fbtn.ZIndex = 101
        Instance.new("UICorner", fbtn)
        local function destroyConfirm()
            NoirUI.ActiveConfirmFrame = nil
            Conf:Destroy()
        end
        cbtn.MouseButton1Click:Connect(destroyConfirm)
        fbtn.MouseButton1Click:Connect(function()
            ScreenGui:Destroy()
            destroyConfirm()
        end)
    end)
    
    -- //////////////// SIDEBAR ////////////////
    local Side = Instance.new("Frame", Main)
    Side.Size = UDim2.new(0, 110, 1, -50)
    Side.Position = UDim2.new(0, 5, 0, 40)
    Side.BackgroundTransparency = settings.SidebarTransparency or 0.5
    Side.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    Side.ClipsDescendants = true
    Instance.new("UICorner", Side).CornerRadius = UDim.new(0, 8)
    
    local TScroll = Instance.new("ScrollingFrame", Side)
    TScroll.Size = UDim2.new(1, 0, 1, -55)
    TScroll.BackgroundTransparency = 1
    TScroll.ScrollBarThickness = 0
    TScroll.AutomaticCanvasSize = "Y"
    Instance.new("UIListLayout", TScroll).Padding = UDim.new(0, 5)
    
    local UA = Instance.new("Frame", Side)
    UA.Size = UDim2.new(1, 0, 0, 50)
    UA.Position = UDim2.new(0, 0, 1, -45)
    UA.BackgroundTransparency = 1
    local AI = Instance.new("ImageLabel", UA)
    AI.Size = UDim2.new(0, 38, 0, 38)
    AI.Position = UDim2.new(0.5, -19, 0, 0)
    pcall(function() AI.Image = Players:GetUserThumbnailAsync(Players.LocalPlayer.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size100x100) end)
    Instance.new("UICorner", AI).CornerRadius = UDim.new(1,0)
    Instance.new("UIStroke", AI).Color = ACCENT
    
    -- //////////////// CONTENT ////////////////
    local Cont = Instance.new("Frame", Main)
    Cont.Size = UDim2.new(1, -125, 1, -50)
    Cont.Position = UDim2.new(0, 120, 0, 40)
    Cont.BackgroundTransparency = settings.ContentTransparency or 0.3
    Cont.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    Cont.ClipsDescendants = true
    Instance.new("UICorner", Cont).CornerRadius = UDim.new(0, 8)
    
    -- //////////////// FLOAT BUTTON ////////////////
    local TBtn = Instance.new("TextButton", ScreenGui)
    TBtn.Size = UDim2.new(0, 45, 0, 45)
    TBtn.Position = floatDefaultPos
    TBtn.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    TBtn.Text = type(settings.Icon) == "string" and settings.Icon or ""
    TBtn.TextColor3 = ACCENT
    TBtn.TextSize = 18
    Instance.new("UICorner", TBtn).CornerRadius = UDim.new(1,0)
    local TS = Instance.new("UIStroke", TBtn)
    TS.Color = ACCENT
    TS.Thickness = 2
    
    if settings.FloatBackground then
        LoadBackground(TBtn, settings.FloatBackground)
    end
    
    local floatDragging = false
    local floatDragStart, floatStartPos, floatDragInput
    TBtn.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            floatDragging = true
            floatDragStart = input.Position
            floatStartPos = TBtn.Position
        end
    end)
    TBtn.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            floatDragInput = input
        end
    end)
    UIS.InputChanged:Connect(function(input)
        if input == floatDragInput and floatDragging then
            local delta = input.Position - floatDragStart
            TBtn.Position = UDim2.new(floatStartPos.X.Scale, floatStartPos.X.Offset + delta.X, floatStartPos.Y.Scale, floatStartPos.Y.Offset + delta.Y)
        end
    end)
    UIS.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            floatDragging = false
        end
    end)
    
    if type(settings.Icon) == "number" then
        local FI = Instance.new("ImageLabel", TBtn)
        FI.Size = UDim2.new(0.6,0,0.6,0)
        FI.Position = UDim2.new(0.2,0,0.2,0)
        FI.BackgroundTransparency = 1
        FI.Image = "rbxassetid://"..tostring(settings.Icon)
        FI.ImageColor3 = ACCENT
        TBtn.Text = ""
    end
    
    TBtn.MouseButton1Click:Connect(function()
        if not KeySolved and KUI and KUI.Parent then
            KUI.Visible = not KUI.Visible
        else
            if not Main.Visible then
                Main.Position = mainDefaultPos
                TweenService:Create(Main, TweenInfo.new(0.2), {BackgroundTransparency = settings.MainBgTransparency or 0}):Play()
            else
                TweenService:Create(Main, TweenInfo.new(0.2), {BackgroundTransparency = 1}):Play()
                task.wait(0.2)
            end
            Main.Visible = not Main.Visible
        end
    end)
    
    -- //////////////// NOTIFICATIONS (mờ 0.25) ////////////////
    function NoirUI:Notify(t, m)
        local n = Instance.new("Frame", ScreenGui)
        n.Size = UDim2.new(0,220,0,65)
        n.Position = UDim2.new(1,20,0.8,0)
        n.BackgroundColor3 = Color3.fromRGB(15,15,15)
        n.BackgroundTransparency = 0.25
        Instance.new("UICorner", n)
        local ns = Instance.new("UIStroke", n)
        ns.Color = ACCENT
        
        if settings.NotificationBackground then
            LoadBackground(n, settings.NotificationBackground)
        end
        
        local tl = Instance.new("TextLabel", n)
        tl.Size = UDim2.new(1,-10,0,20)
        tl.Position = UDim2.new(0,10,0,5)
        tl.Text = t
        tl.TextColor3 = ACCENT
        tl.BackgroundTransparency = 1
        tl.Font = "GothamBold"
        tl.TextSize = 13
        tl.TextXAlignment = "Left"
        
        local ml = Instance.new("TextLabel", n)
        ml.Size = UDim2.new(1,-20,0,35)
        ml.Position = UDim2.new(0,10,0,25)
        ml.Text = m
        ml.TextColor3 = Color3.new(1,1,1)
        ml.BackgroundTransparency = 1
        ml.TextWrapped = true
        ml.TextXAlignment = "Left"
        ml.TextYAlignment = "Top"
        ml.Font = "GothamMedium"
        ml.TextSize = 11
        
        for i, v in ipairs(NoirUI.Notifications) do
            TweenService:Create(v, TweenInfo.new(0.3), {Position = UDim2.new(1,-240,0.8,-(i*75))}):Play()
        end
        table.insert(NoirUI.Notifications, 1, n)
        TweenService:Create(n, TweenInfo.new(0.5, Enum.EasingStyle.Back), {Position = UDim2.new(1,-240,0.8,0)}):Play()
        task.delay(4, function()
            TweenService:Create(n, TweenInfo.new(0.5), {Position = UDim2.new(1,20,n.Position.Y.Scale,n.Position.Y.Offset), BackgroundTransparency = 1}):Play()
            task.wait(0.5)
            for i, v in ipairs(NoirUI.Notifications) do
                if v == n then
                    table.remove(NoirUI.Notifications, i)
                    break
                end
            end
            n:Destroy()
        end)
    end
    
    -- //////////////// TẠO TAB & ELEMENTS ////////////////
    local Window = {}
    
    function Window:CreateTab(name, icon)
        local B = Instance.new("TextButton", TScroll)
        B.Size = UDim2.new(1, -5, 0, 32)
        B.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
        B.Text = ""
        Instance.new("UICorner", B)
        local BT = Instance.new("TextLabel", B)
        BT.Size = UDim2.new(1,-10,1,0)
        BT.Position = UDim2.new(0, icon and 35 or 8, 0, 0)
        BT.BackgroundTransparency = 1
        BT.Text = name
        BT.TextColor3 = Color3.fromRGB(150, 150, 150)
        BT.Font = "GothamMedium"
        BT.TextSize = 11
        BT.TextXAlignment = "Left"
        if icon then
            local IC = Instance.new("ImageLabel", B)
            IC.Size = UDim2.new(0, 18, 0, 18)
            IC.Position = UDim2.new(0, 8, 0.5, -9)
            IC.BackgroundTransparency = 1
            IC.Image = "rbxassetid://"..tostring(icon)
            IC.ImageColor3 = Color3.fromRGB(150, 150, 150)
        end
        
        local TabContainer = Instance.new("ScrollingFrame", Cont)
        TabContainer.Size = UDim2.new(1, 0, 1, 0)
        TabContainer.BackgroundTransparency = 1
        TabContainer.Visible = false
        TabContainer.ScrollBarThickness = 1
        TabContainer.AutomaticCanvasSize = "Y"
        
        local SearchFrame = Instance.new("Frame", TabContainer)
        SearchFrame.Size = UDim2.new(1, -20, 0, 35)
        SearchFrame.Position = UDim2.new(0, 10, 0, 0)
        SearchFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
        SearchFrame.BackgroundTransparency = 0.8
        Instance.new("UICorner", SearchFrame).CornerRadius = UDim.new(0, 8)
        
        local SearchIcon = Instance.new("TextLabel", SearchFrame)
        SearchIcon.Size = UDim2.new(0, 30, 1, 0)
        SearchIcon.BackgroundTransparency = 1
        SearchIcon.Text = "🔍"
        SearchIcon.TextColor3 = Color3.fromRGB(150, 150, 150)
        SearchIcon.Font = "GothamMedium"
        SearchIcon.TextSize = 14
        
        local SearchBox = Instance.new("TextBox", SearchFrame)
        SearchBox.Size = UDim2.new(1, -35, 1, 0)
        SearchBox.Position = UDim2.new(0, 35, 0, 0)
        SearchBox.BackgroundTransparency = 1
        SearchBox.PlaceholderText = "Tìm kiếm..."
        SearchBox.Text = ""
        SearchBox.TextColor3 = Color3.new(1,1,1)
        SearchBox.Font = "GothamMedium"
        SearchBox.TextSize = 12
        SearchBox.ClearTextOnFocus = false
        
        local ContentFrame = Instance.new("Frame", TabContainer)
        ContentFrame.Size = UDim2.new(1, 0, 0, 0)
        ContentFrame.Position = UDim2.new(0, 0, 0, 45)
        ContentFrame.BackgroundTransparency = 1
        local ContentLayout = Instance.new("UIListLayout", ContentFrame)
        ContentLayout.Padding = UDim.new(0, 8)
        ContentLayout.HorizontalAlignment = "Center"
        ContentLayout.SortOrder = Enum.SortOrder.LayoutOrder
        
        local function updateCanvas()
            task.wait()
            TabContainer.CanvasSize = UDim2.new(0, 0, 0, ContentFrame.AbsoluteSize.Y + 55)
        end
        ContentLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(updateCanvas)
        
        B.MouseButton1Click:Connect(function()
            for _, v in pairs(Cont:GetChildren()) do
                if v:IsA("ScrollingFrame") then v.Visible = false end
            end
            for _, v in pairs(TScroll:GetChildren()) do
                if v:IsA("TextButton") then
                    local t = v:FindFirstChild("TextLabel")
                    if t then t.TextColor3 = Color3.fromRGB(150, 150, 150) end
                    if v:FindFirstChild("ImageLabel") then v.ImageLabel.ImageColor3 = Color3.fromRGB(150, 150, 150) end
                end
            end
            TabContainer.Visible = true
            BT.TextColor3 = ACCENT
            if B:FindFirstChild("ImageLabel") then B.ImageLabel.ImageColor3 = ACCENT end
            updateCanvas()
        end)
        
        if #TScroll:GetChildren() == 2 then
            TabContainer.Visible = true
            BT.TextColor3 = ACCENT
            if B:FindFirstChild("ImageLabel") then B.ImageLabel.ImageColor3 = ACCENT end
        end
        
        local Tab = { Count = 0, Elements = {} }
        local function GetO() Tab.Count = Tab.Count + 1; return Tab.Count end
        
        local function filterElements(searchText)
            local search = searchText:lower()
            for _, element in pairs(Tab.Elements) do
                if search == "" or (element.Name and element.Name:lower():find(search)) then
                    element.Visible = true
                else
                    element.Visible = false
                end
            end
            updateCanvas()
        end
        
        SearchBox.Changed:Connect(function(prop)
            if prop == "Text" then filterElements(SearchBox.Text) end
        end)
        
        function Tab:CreateLabel(t)
            local l = Instance.new("TextLabel", ContentFrame)
            l.Size = UDim2.new(0.95,0,0,20)
            l.BackgroundTransparency = 1
            l.Text = t
            l.TextColor3 = Color3.fromRGB(200,200,200)
            l.Font = "GothamMedium"
            l.TextSize = 12
            l.TextXAlignment = "Left"
            l.LayoutOrder = GetO()
            l.Name = t
            table.insert(Tab.Elements, l)
            return l
        end
        
        function Tab:CreateParagraph(opt)
            local f = Instance.new("Frame", ContentFrame)
            f.Size = UDim2.new(0.95,0,0,65)
            f.BackgroundColor3 = Color3.fromRGB(15,15,15)
            f.BackgroundTransparency = 0.3
            Instance.new("UICorner", f)
            f.LayoutOrder = GetO()
            f.Name = opt.Title or ""
            table.insert(Tab.Elements, f)
            local t = Instance.new("TextLabel", f)
            t.Size = UDim2.new(1,-20,0,25)
            t.Position = UDim2.new(0,10,0,5)
            t.Text = opt.Title
            t.TextColor3 = ACCENT
            t.Font = "GothamBold"
            t.TextSize = 13
            t.BackgroundTransparency = 1
            t.TextXAlignment = "Left"
            local c = Instance.new("TextLabel", f)
            c.Size = UDim2.new(1,-20,0,30)
            c.Position = UDim2.new(0,10,0,25)
            c.Text = opt.Content
            c.TextColor3 = Color3.new(1,1,1)
            c.Font = "GothamMedium"
            c.TextSize = 11
            c.BackgroundTransparency = 1
            c.TextWrapped = true
            c.TextXAlignment = "Left"
            c.TextYAlignment = "Top"
        end
        
        function Tab:CreateTextBox(opt)
            local f = Instance.new("Frame", ContentFrame)
            f.Size = UDim2.new(0.95,0,0,35)
            f.BackgroundColor3 = Color3.fromRGB(22,22,22)
            f.BackgroundTransparency = 0.2
            Instance.new("UICorner", f)
            f.LayoutOrder = GetO()
            f.Name = opt.Name or ""
            table.insert(Tab.Elements, f)
            local i = Instance.new("TextBox", f)
            i.Size = UDim2.new(1,-20,1,0)
            i.Position = UDim2.new(0,10,0,0)
            i.BackgroundTransparency = 1
            i.PlaceholderText = opt.Name
            i.Text = ""
            i.TextColor3 = Color3.new(1,1,1)
            i.Font = "GothamMedium"
            i.TextSize = 12
            i.TextXAlignment = "Left"
            i.FocusLost:Connect(function() opt.Callback(i.Text) end)
        end
        
        function Tab:CreateButton(opt)
            local b = Instance.new("TextButton", ContentFrame)
            b.Size = UDim2.new(0.95,0,0,35)
            b.BackgroundColor3 = Color3.fromRGB(25,25,25)
            b.Text = opt.Name
            b.TextColor3 = Color3.new(1,1,1)
            b.Font = "GothamMedium"
            b.TextSize = 12
            Instance.new("UICorner", b)
            b.LayoutOrder = GetO()
            b.Name = opt.Name
            table.insert(Tab.Elements, b)
            b.MouseButton1Click:Connect(opt.Callback)
        end
        
        function Tab:CreateToggle(opt)
            local s = opt.Default or false
            local t = Instance.new("TextButton", ContentFrame)
            t.Size = UDim2.new(0.95,0,0,35)
            t.BackgroundColor3 = Color3.fromRGB(25,25,25)
            t.Text = "  "..opt.Name
            t.TextColor3 = s and ACCENT or Color3.fromRGB(180,180,180)
            t.TextXAlignment = "Left"
            t.TextSize = 12
            Instance.new("UICorner", t)
            t.LayoutOrder = GetO()
            t.Name = opt.Name
            table.insert(Tab.Elements, t)
            local bx = Instance.new("Frame", t)
            bx.Size = UDim2.new(0,30,0,16)
            bx.Position = UDim2.new(1,-40,0.5,-8)
            bx.BackgroundColor3 = s and ACCENT or Color3.fromRGB(40,40,40)
            Instance.new("UICorner", bx).CornerRadius = UDim.new(1,0)
            t.MouseButton1Click:Connect(function()
                s = not s
                t.TextColor3 = s and ACCENT or Color3.fromRGB(180,180,180)
                bx.BackgroundColor3 = s and ACCENT or Color3.fromRGB(40,40,40)
                opt.Callback(s)
            end)
        end
        
        function Tab:CreateSlider(opt)
            local f = Instance.new("Frame", ContentFrame)
            f.Size = UDim2.new(0.95,0,0,50)
            f.BackgroundColor3 = Color3.fromRGB(22,22,22)
            f.BackgroundTransparency = 0.2
            Instance.new("UICorner", f)
            f.LayoutOrder = GetO()
            f.Name = opt.Name or ""
            table.insert(Tab.Elements, f)
            local l = Instance.new("TextLabel", f)
            l.Size = UDim2.new(1,0,0,20)
            l.Position = UDim2.new(0,12,0,5)
            l.BackgroundTransparency = 1
            l.Text = opt.Name..": "..opt.Default
            l.TextColor3 = Color3.new(1,1,1)
            l.TextXAlignment = "Left"
            l.TextSize = 11
            local sbg = Instance.new("Frame", f)
            sbg.Size = UDim2.new(0.9,0,0,8)
            sbg.Position = UDim2.new(0.05,0,0.7,0)
            sbg.BackgroundColor3 = Color3.fromRGB(40,40,40)
            Instance.new("UICorner", sbg)
            local fill = Instance.new("Frame", sbg)
            fill.Size = UDim2.new(math.clamp((opt.Default-opt.Min)/(opt.Max-opt.Min),0,1),0,1,0)
            fill.BackgroundColor3 = ACCENT
            Instance.new("UICorner", fill)
            local isHeld = false
            local function UpdateSlider(input)
                local p = math.clamp((input.Position.X - sbg.AbsolutePosition.X) / sbg.AbsoluteSize.X, 0, 1)
                local v = math.floor(opt.Min + (opt.Max - opt.Min) * p)
                fill.Size = UDim2.new(p, 0, 1, 0)
                l.Text = opt.Name..": "..v
                opt.Callback(v)
            end
            sbg.InputBegan:Connect(function(i)
                if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
                    isHeld = true
                    UpdateSlider(i)
                end
            end)
            UIS.InputEnded:Connect(function(i)
                if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
                    isHeld = false
                end
            end)
            UIS.InputChanged:Connect(function(i)
                if isHeld and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then
                    UpdateSlider(i)
                end
            end)
        end
        
        function Tab:CreateColorPicker(opt)
            local ColorSelected = opt.Default or Color3.fromRGB(170, 85, 255)
            local h, s, v = ColorSelected:ToHSV()
            local open = false
            local f = Instance.new("Frame", ContentFrame)
            f.Size = UDim2.new(0.95,0,0,35)
            f.BackgroundColor3 = Color3.fromRGB(22,22,22)
            f.BackgroundTransparency = 0.2
            Instance.new("UICorner", f)
            f.LayoutOrder = GetO()
            f.ClipsDescendants = true
            f.Name = opt.Name or ""
            table.insert(Tab.Elements, f)
            local t = Instance.new("TextLabel", f)
            t.Size = UDim2.new(1,0,0,35)
            t.Position = UDim2.new(0,12,0,0)
            t.BackgroundTransparency = 1
            t.Text = opt.Name
            t.TextColor3 = Color3.new(1,1,1)
            t.Font = "GothamMedium"
            t.TextSize = 12
            t.TextXAlignment = "Left"
            local pvw = Instance.new("TextButton", f)
            pvw.Size = UDim2.new(0,40,0,18)
            pvw.Position = UDim2.new(1,-50,0,8.5)
            pvw.BackgroundColor3 = ColorSelected
            pvw.Text = ""
            Instance.new("UICorner", pvw)
            local Holder = Instance.new("Frame", f)
            Holder.Size = UDim2.new(1,0,0,140)
            Holder.Position = UDim2.new(0,0,0,35)
            Holder.BackgroundTransparency = 1
            local satBox = Instance.new("ImageButton", Holder)
            satBox.Size = UDim2.new(0.9,0,0,100)
            satBox.Position = UDim2.new(0.05,0,0,5)
            satBox.Image = "rbxassetid://4155801252"
            satBox.BackgroundColor3 = Color3.fromHSV(h, 1, 1)
            Instance.new("UICorner", satBox)
            local cursor = Instance.new("Frame", satBox)
            cursor.Size = UDim2.new(0,8,0,8)
            cursor.AnchorPoint = Vector2.new(0.5,0.5)
            cursor.BackgroundColor3 = Color3.new(1,1,1)
            cursor.Position = UDim2.new(s,0,1-v,0)
            Instance.new("UICorner", cursor).CornerRadius = UDim.new(1,0)
            local hueSlide = Instance.new("ImageButton", Holder)
            hueSlide.Size = UDim2.new(0.9,0,0,12)
            hueSlide.Position = UDim2.new(0.05,0,0,115)
            hueSlide.Image = "rbxassetid://3641079629"
            Instance.new("UICorner", hueSlide)
            local hCursor = Instance.new("Frame", hueSlide)
            hCursor.Size = UDim2.new(0,4,1,4)
            hCursor.Position = UDim2.new(1-h,0,0.5,0)
            hCursor.AnchorPoint = Vector2.new(0.5,0.5)
            hCursor.BackgroundColor3 = Color3.new(1,1,1)
            Instance.new("UICorner", hCursor)
            local function UpdateColor()
                local finalCol = Color3.fromHSV(h, s, v)
                pvw.BackgroundColor3 = finalCol
                satBox.BackgroundColor3 = Color3.fromHSV(h, 1, 1)
                cursor.Position = UDim2.new(s, 0, 1-v, 0)
                hCursor.Position = UDim2.new(1-h, 0, 0.5, 0)
                opt.Callback(finalCol)
            end
            local hS, hH = false, false
            satBox.InputBegan:Connect(function(i)
                if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then hS = true end
            end)
            hueSlide.InputBegan:Connect(function(i)
                if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then hH = true end
            end)
            UIS.InputEnded:Connect(function(i)
                if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then hS, hH = false, false end
            end)
            UIS.InputChanged:Connect(function(i)
                if (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then
                    if hS then
                        s = math.clamp((i.Position.X - satBox.AbsolutePosition.X) / satBox.AbsoluteSize.X, 0, 1)
                        v = 1 - math.clamp((i.Position.Y - satBox.AbsolutePosition.Y) / satBox.AbsoluteSize.Y, 0, 1)
                        UpdateColor()
                    elseif hH then
                        h = 1 - math.clamp((i.Position.X - hueSlide.AbsolutePosition.X) / hueSlide.AbsoluteSize.X, 0, 1)
                        UpdateColor()
                    end
                end
            end)
            pvw.MouseButton1Click:Connect(function()
                open = not open
                TweenService:Create(f, TweenInfo.new(0.3), {Size = open and UDim2.new(0.95,0,0,180) or UDim2.new(0.95,0,0,35)}):Play()
            end)
        end
        
        function Tab:CreateDropdown(opt)
            local d = Instance.new("Frame", ContentFrame)
            d.Size = UDim2.new(0.95,0,0,35)
            d.BackgroundColor3 = Color3.fromRGB(22,22,22)
            d.BackgroundTransparency = 0.2
            Instance.new("UICorner", d)
            d.LayoutOrder = GetO()
            d.ClipsDescendants = true
            d.Name = opt.Name or ""
            table.insert(Tab.Elements, d)
            
            local t = Instance.new("TextButton", d)
            t.Size = UDim2.new(1,0,0,35)
            t.BackgroundTransparency = 1
            t.Text = "  "..opt.Name.." : "..(opt.Default or opt.Options[1])
            t.TextColor3 = Color3.new(1,1,1)
            t.Font = "GothamMedium"
            t.TextSize = 12
            t.TextXAlignment = "Left"
            
            local Arrow = Instance.new("TextLabel", t)
            Arrow.Size = UDim2.new(0, 30, 1, 0)
            Arrow.Position = UDim2.new(1, -35, 0, 0)
            Arrow.BackgroundTransparency = 1
            Arrow.Text = "▼"
            Arrow.TextColor3 = Color3.fromRGB(180, 180, 180)
            Arrow.Font = "GothamMedium"
            Arrow.TextSize = 14
            Arrow.TextXAlignment = "Center"
            
            local il = Instance.new("ScrollingFrame", d)
            il.Size = UDim2.new(1,0,0, math.min(#opt.Options, 4) * 30)
            il.Position = UDim2.new(0,0,0,35)
            il.BackgroundTransparency = 1
            il.ScrollBarThickness = 2
            il.AutomaticCanvasSize = "Y"
            il.Visible = false
            Instance.new("UIListLayout", il)
            
            local open = false
            t.MouseButton1Click:Connect(function()
                open = not open
                il.Visible = open
                Arrow.Text = open and "▲" or "▼"
                TweenService:Create(d, TweenInfo.new(0.3), {Size = open and UDim2.new(0.95,0,0,35+il.Size.Y.Offset) or UDim2.new(0.95,0,0,35)}):Play()
            end)
            
            for _, v in pairs(opt.Options) do
                local it = Instance.new("TextButton", il)
                it.Size = UDim2.new(1,0,0,30)
                it.BackgroundColor3 = Color3.fromRGB(28,28,28)
                it.Text = v
                it.TextColor3 = Color3.fromRGB(200,200,200)
                it.Font = "GothamMedium"
                it.TextSize = 11
                it.MouseButton1Click:Connect(function()
                    open = false
                    il.Visible = false
                    Arrow.Text = "▼"
                    t.Text = "  "..opt.Name.." : "..v
                    TweenService:Create(d, TweenInfo.new(0.3), {Size = UDim2.new(0.95,0,0,35)}):Play()
                    opt.Callback(v)
                end)
            end
        end
        
        function Tab:CreateRunBox(opt)
            local f = Instance.new("Frame", ContentFrame)
            f.Size = UDim2.new(0.95,0,0,38)
            f.BackgroundColor3 = Color3.fromRGB(18,18,18)
            f.BackgroundTransparency = 0.2
            Instance.new("UICorner", f)
            f.LayoutOrder = GetO()
            f.Name = "RunBox"
            table.insert(Tab.Elements, f)
            
            local i = Instance.new("TextBox", f)
            i.Size = UDim2.new(1,-65,1,0)
            i.Position = UDim2.new(0,10,0,0)
            i.BackgroundTransparency = 1
            i.PlaceholderText = opt.Placeholder or "Nhập: .cmd, loadstring('url'), required('Module'), or lua code"
            i.Text = ""
            i.TextColor3 = Color3.new(1,1,1)
            i.Font = "GothamMedium"
            i.TextSize = 11
            i.TextXAlignment = "Left"
            i.ClearTextOnFocus = false
            
            local r = Instance.new("TextButton", f)
            r.Size = UDim2.new(0,50,0,26)
            r.Position = UDim2.new(1,-55,0.5,-13)
            r.BackgroundColor3 = ACCENT
            r.Text = "RUN"
            r.TextColor3 = Color3.new(1,1,1)
            r.Font = "GothamBold"
            r.TextSize = 10
            Instance.new("UICorner", r)
            
            r.MouseButton1Click:Connect(function()
                local input = i.Text
                if input == "" then return end
                
                if input:sub(1,1) == "." then
                    local parts = input:sub(2):split(" ")
                    local cmd = parts[1]:lower()
                    local args = {}
                    for j = 2, #parts do
                        table.insert(args, parts[j])
                    end
                    
                    local customCallback = NoirUI.CustomCommands[cmd]
                    if customCallback then
                        local success, err = pcall(function()
                            customCallback(args)
                        end)
                        if not success then
                            NoirUI:Notify("Command Error", err or "Lỗi không xác định")
                        end
                    else
                        NoirUI:Notify("❌ Unknown Command", "Không tìm thấy lệnh: ." .. cmd)
                    end
                    
                elseif input:lower():match("loadstring") then
                    local str = input:match("loadstring%((.+)%)")
                    if str then
                        local cleaned = str:gsub("^[\"'](.*)[\"']$", "%1")
                        local success, err = loadstring(cleaned)
                        if success then
                            success()
                            NoirUI:Notify("Loadstring", "Đã chạy thành công!")
                        else
                            NoirUI:Notify("Loadstring Error", err or "Lỗi cú pháp")
                        end
                    else
                        NoirUI:Notify("Loadstring Error", "Cú pháp không hợp lệ")
                    end
                    
                elseif input:lower():match("required") then
                    local module = input:match("required%((.+)%)")
                    if module then
                        local cleaned = module:gsub("^[\"'](.*)[\"']$", "%1")
                        local success, result = pcall(function()
                            return require(game:GetService("Players").LocalPlayer:FindFirstChild("PlayerScripts"):WaitForChild(cleaned))
                        end)
                        if success then
                            NoirUI:Notify("Required", "Đã require thành công!")
                        else
                            NoirUI:Notify("Required Error", "Không tìm thấy module: " .. cleaned)
                        end
                    else
                        NoirUI:Notify("Required Error", "Cú pháp không hợp lệ")
                    end
                    
                else
                    local success, err = loadstring(input)
                    if success then
                        success()
                        NoirUI:Notify("Execute", "Code đã chạy thành công!")
                    else
                        NoirUI:Notify("Error", err or "Lỗi cú pháp")
                    end
                end
                
                if opt.ClearOnExecute then
                    i.Text = ""
                end
            end)
        end
        
        function Tab:CreateSection(t)
            local s = Instance.new("Frame", ContentFrame)
            s.Size = UDim2.new(0.95, 0, 0, 25)
            s.BackgroundTransparency = 1
            s.LayoutOrder = GetO()
            s.Name = t
            table.insert(Tab.Elements, s)
            local lbl = Instance.new("TextLabel", s)
            lbl.Size = UDim2.new(1,0,1,0)
            lbl.Text = t:upper()
            lbl.TextColor3 = ACCENT
            lbl.Font = "GothamBold"
            lbl.TextSize = 10
            lbl.TextXAlignment = "Left"
            lbl.BackgroundTransparency = 1
        end
        
        return Tab
    end
    
    return Window
end

return NoirUI
