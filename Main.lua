local TweenService = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")

-- // Xóa UI cũ nếu tồn tại
local OldGui = game.CoreGui:FindFirstChild("NoirUI_V3_Ultimate")
if OldGui then OldGui:Destroy() end

local NoirUI = { Notifications = {}, ActiveConfirmFrame = nil, CustomCommands = {} }

-- ========== LUCIDE ICONS TÍCH HỢP SẴN ==========
local LucideIcons = {
    ["home"] = "rbxassetid://13060262529",
    ["user"] = "rbxassetid://81489458260315",
    ["users"] = "rbxassetid://16485180075",
    ["user-plus"] = "rbxassetid://11893826115",
    ["user-minus"] = "rbxassetid://116226374817056",
    ["settings"] = "rbxassetid://7059346373",
    ["menu"] = "rbxassetid://8622237899",
    ["more-horizontal"] = "rbxassetid://135691518843377",
    ["more-vertical"] = "rbxassetid://95014688478272",
    ["x"] = "rbxassetid://4458805208",
    ["check"] = "rbxassetid://5959696880",
    ["plus"] = "rbxassetid://401613236",
    ["minus"] = "rbxassetid://82235228007110",
    ["search"] = "rbxassetid://5107220207",
    ["arrow-left"] = "rbxassetid://12338896667",
    ["arrow-right"] = "rbxassetid://12338895277",
    ["arrow-up"] = "rbxassetid://12338897538",
    ["arrow-down"] = "rbxassetid://12338898398",
    ["chevron-left"] = "rbxassetid://83972042993874",
    ["chevron-right"] = "rbxassetid://115929304045144",
    ["chevron-up"] = "rbxassetid://99034290227012",
    ["chevron-down"] = "rbxassetid://103256317191387",
    ["chevrons-left"] = "rbxassetid://12338396009",
    ["chevrons-right"] = "rbxassetid://12338394619",
    ["chevrons-up"] = "rbxassetid://12338397019",
    ["chevrons-down"] = "rbxassetid://12338397670",
    ["edit"] = "rbxassetid://5595830734",
    ["trash"] = "rbxassetid://14002617467",
    ["copy"] = "rbxassetid://90434151822042",
    ["clipboard"] = "rbxassetid://76443890191204",
    ["refresh-cw"] = "rbxassetid://106091057679781",
    ["save"] = "rbxassetid://4458874645",
    ["download"] = "rbxassetid://78813928987436",
    ["upload"] = "rbxassetid://126456834497191",
    ["log-in"] = "rbxassetid://618861108",
    ["log-out"] = "rbxassetid://6264845452",
    ["power"] = "rbxassetid://12557422528",
    ["folder"] = "rbxassetid://78388764182737",
    ["folder-open"] = "rbxassetid://4974562710",
    ["file"] = "rbxassetid://73677849376635",
    ["archive"] = "rbxassetid://103382512835696",
    ["play"] = "rbxassetid://87003065970333",
    ["pause"] = "rbxassetid://4458862490",
    ["stop"] = "rbxassetid://4458885421",
    ["skip-back"] = "rbxassetid://18802845025",
    ["skip-forward"] = "rbxassetid://88365123525975",
    ["volume"] = "rbxassetid://6824925333",
    ["volume-1"] = "rbxassetid://6824925193",
    ["volume-2"] = "rbxassetid://6824925080",
    ["volume-x"] = "rbxassetid://115340156116773",
    ["headphones"] = "rbxassetid://14425582274",
    ["mic"] = "rbxassetid://219092693",
    ["mic-off"] = "rbxassetid://219092690",
    ["music"] = "rbxassetid://17387359605",
    ["video"] = "rbxassetid://12624074022",
    ["camera"] = "rbxassetid://13085201731",
    ["image"] = "rbxassetid://4458863833",
    ["smartphone"] = "rbxassetid://98853713657217",
    ["phone"] = "rbxassetid://8411963035",
    ["tablet"] = "rbxassetid://134616667923000",
    ["monitor"] = "rbxassetid://3120635703",
    ["tv"] = "rbxassetid://4458888115",
    ["cpu"] = "rbxassetid://88995379969023",
    ["hard-drive"] = "rbxassetid://77457389504900",
    ["server"] = "rbxassetid://15567974330",
    ["database"] = "rbxassetid://139314011663170",
    ["mail"] = "rbxassetid://16149098638",
    ["mail-open"] = "rbxassetid://5673469839",
    ["inbox"] = "rbxassetid://131589926324755",
    ["send"] = "rbxassetid://98712755979169",
    ["message-circle"] = "rbxassetid://74481341185839",
    ["message-square"] = "rbxassetid://111690516755548",
    ["at-sign"] = "rbxassetid://92559495578198",
    ["bell"] = "rbxassetid://11401835376",
    ["bell-off"] = "rbxassetid://81868571746318",
    ["github"] = "rbxassetid://106465383791027",
    ["youtube"] = "rbxassetid://139037997997612",
    ["twitter"] = "rbxassetid://1324431872",
    ["facebook"] = "rbxassetid://11163700816",
    ["instagram"] = "rbxassetid://88697780906499",
    ["linkedin"] = "rbxassetid://261568404",
    ["discord"] = "rbxassetid://135550354937113",
    ["twitch"] = "rbxassetid://7060611812",
    ["tiktok"] = "rbxassetid://75638865968068",
    ["reddit"] = "rbxassetid://10586157838",
    ["whatsapp"] = "rbxassetid://6749672343",
    ["telegram"] = "rbxassetid://123718469677217",
    ["spotify"] = "rbxassetid://136628997625291",
    ["apple"] = "rbxassetid://41715859",
    ["google"] = "rbxassetid://77673450508025",
    ["lock"] = "rbxassetid://12060512624",
    ["unlock"] = "rbxassetid://115289332203941",
    ["shield"] = "rbxassetid://98159911363596",
    ["shield-check"] = "rbxassetid://110457125738695",
    ["shield-alert"] = "rbxassetid://12988744896",
    ["alert-circle"] = "rbxassetid://11282218678",
    ["alert-triangle"] = "rbxassetid://79791826459299",
    ["info"] = "rbxassetid://76311199408449",
    ["help-circle"] = "rbxassetid://12120704330",
    ["sun"] = "rbxassetid://116100059610252",
    ["moon"] = "rbxassetid://8498174594",
    ["cloud"] = "rbxassetid://4458806371",
    ["cloud-rain"] = "rbxassetid://102757193172908",
    ["cloud-snow"] = "rbxassetid://132770119",
    ["cloud-lightning"] = "rbxassetid://89963608654043",
    ["droplet"] = "rbxassetid://124305926523450",
    ["wind"] = "rbxassetid://261307450",
    ["compass"] = "rbxassetid://72985075553067",
    ["globe"] = "rbxassetid://93730749759563",
    ["map"] = "rbxassetid://11345509329",
    ["map-pin"] = "rbxassetid://9661173947",
    ["navigation"] = "rbxassetid://93295279567893",
    ["calendar"] = "rbxassetid://99559214342519",
    ["clock"] = "rbxassetid://136442043483061",
    ["alarm-clock"] = "rbxassetid://129270692859326",
    ["timer"] = "rbxassetid://6761866149",
    ["heart"] = "rbxassetid://323045990",
    ["activity"] = "rbxassetid://100019486107683",
    ["battery"] = "rbxassetid://99494561409814",
    ["battery-charging"] = "rbxassetid://99146802308477",
    ["gamepad"] = "rbxassetid://11894535915",
    ["controller"] = "rbxassetid://12684121161",
    ["joystick"] = "rbxassetid://100224786437387",
    ["dice"] = "rbxassetid://86777156606703",
    ["trophy"] = "rbxassetid://13321838559",
    ["award"] = "rbxassetid://12941038883",
    ["medal"] = "rbxassetid://16170504068",
    ["star"] = "rbxassetid://138880939782808",
    ["shopping-cart"] = "rbxassetid://11385419674",
    ["shopping-bag"] = "rbxassetid://132847573851619",
    ["credit-card"] = "rbxassetid://18759664352",
    ["wallet"] = "rbxassetid://75406293336822",
    ["dollar-sign"] = "rbxassetid://136095164702019",
    ["truck"] = "rbxassetid://87183998145898",
    ["package"] = "rbxassetid://126416836022196",
    ["gift"] = "rbxassetid://132301831611974",
    ["tag"] = "rbxassetid://128003672551215",
    ["percent"] = "rbxassetid://140273715292653",
    ["code"] = "rbxassetid://87667913110964",
    ["terminal"] = "rbxassetid://16149179345",
    ["command"] = "rbxassetid://8278333371",
    ["zap"] = "rbxassetid://126575828309457",
    ["loader"] = "rbxassetid://82285050019288",
    ["feather"] = "rbxassetid://93633665863756",
    ["flag"] = "rbxassetid://11379131842",
    ["bookmark"] = "rbxassetid://90584338909157",
    ["key"] = "rbxassetid://117047144730308",
    ["sliders"] = "rbxassetid://121867517528976",
    ["aperture"] = "rbxassetid://9940311323",
    ["crop"] = "rbxassetid://118035809733815",
    ["layers"] = "rbxassetid://13853348331",
    ["grid"] = "rbxassetid://6953993752",
    ["list"] = "rbxassetid://15567843390",
    ["target"] = "rbxassetid://13557340523",
    ["crosshair"] = "rbxassetid://114078536525410",
    ["crosshair-2"] = "rbxassetid://5146843579",
    ["gauge"] = "rbxassetid://105442920358687",
    ["scale-3d"] = "rbxassetid://133233077350937",
    ["eye"] = "rbxassetid://15922050695",
    ["eye-off"] = "rbxassetid://6473252651",
-- //
    ["cat-1"] = "rbxassetid://6421296789",
    ["aesthetic-1"] = "rbxassetid://6675147486",
    ["aesthetic-2"] = "rbxassetid://10149736886",
    ["chibi-1"] = "rbxassetid://5248865554",
    ["chibi-2"] = "rbxassetid://7710824597",
    ["chibi-3"] = "rbxassetid://5410949701",
    ["aesthetic-3"] = "rbxassetid://11696859404",
    ["hutao-1"] = "rbxassetid://11424961420",
    ["yae-1"] = "rbxassetid://10983517729",
    ["aesthetic-4"] = "rbxassetid://10899663828",
    ["genshin-1"] = "rbxassetid://8677816475",
    ["chibi-4"] = "rbxassetid://6993174715",
    ["miku-1"] = "rbxassetid://8680995431",
    ["chibi-5"] = "rbxassetid://6982730545",
    ["aesthetic-5"] = "rbxassetid://6221611651",
    ["cat-1"] = "rbxassetid://2015724",
--// meme
    ["cheems-mc"] = "rbxassetid://9676276904",
    ["maxwell-mc"] = "rbxassetid://12181324390",
--// Minecraft
    ["mc-dirt"] = "rbxassetid://9267155972",
    ["mc-log"] = "rbxassetid://3258599312",
    ["mc-command"] = "rbxassetid://129804020",
    ["mc-planks"] = "rbxassetid://8676581022",
    ["mc-grass"] = "rbxassetid://96094743851836",
    ["mc-stone"] = "rbxassetid://3162897217",
    ["mc-heart"] = "rbxassetid://6680686532",
    ["mc-iron"] = "rbxassetid://3786068469",
    ["mc-tnt"] = "rbxassetid://5522032314",
    ["mc-diamond"] = "rbxassetid://5328690050",
    ["mc-glass"] = "rbxassetid://8676620530",
    ["mc-diamond-2"] = "rbxassetid://11168800609",
    ["mc-lava"] = "rbxassetid://11950155460",
    ["mc-nether-portal"] = "rbxassetid://9228727963",
    ["mc-water"] = "rbxassetid://7696395981",
    ["mc-dia-sword"] = "rbxassetid://3631652068",
    ["mc-stone-2"] = "rbxassetid://8139086777",
    ["mc-bookshelf"] = "rbxassetid://5901361400",
    ["mc-diamond-3"] = "rbxassetid://8677289915",
    ["mc-nertherite"] = "rbxassetid://7696392982",
    ["mc-cobblestone"] = "rbxassetid://5003953441",
    ["mc-carrot"] = "rbxassetid://9151372514",
    ["mc"] = "rbxassetid://8209318542",
    ["mc-book"] = "rbxassetid://7566388691",
    ["mc-disk"] = "rbxassetid://469714458",
    ["mc-gold"] = "rbxassetid://3374712254",
    ["mc-hunger-bar"] = "rbxassetid://4780279873",
    ["mc-apple"] = "rbxassetid://7892919616",
    ["mc-bow-1"] = "rbxassetid://147671465",
    ["mc-bedrock"] = "rbxassetid://12252439624",
    ["mc-magma"] = "rbxassetid://9065431099",
    ["mc-steve"] = "rbxassetid://5609138453",
    ["mc-arrow"] = "rbxassetid://7373742052",
    ["mc-cake"] = "rbxassetid://5971536621",
    ["mc-sand"] = "rbxassetid://9277770677",
    ["mc-stick"] = "rbxassetid://7248264418",
    ["mc-obsidian"] = "rbxassetid://10480259773",
    ["mc-barrier"] = "rbxassetid://74983718809653",
    ["mc-chest"] = "rbxassetid://9228492798",
    ["mc-snow"] = "rbxassetid://5612862976",
    ["mc-crafting-table"] = "rbxassetid://14934173224",
    ["mc-2"] = "rbxassetid://4995402103",
--// my love :3
    ["agnes-1"] = "rbxassetid://78611376918762",
    ["agnes-2"] = "rbxassetid://129792834663000",
    ["agnes-3"] = "rbxassetid://72822911823680",
    ["agnes-4"] = "rbxassetid://109514342561798",
    ["agnes-5"] = "rbxassetid://124076134701198",
    ["agnes-6"] = "rbxassetid://78920814168054",
    ["agnes-7"] = "rbxassetid://111964745088904",
    ["agnes-8"] = "rbxassetid://73819609027269",
}

local function ResolveIcon(iconInput)
    if not iconInput then return nil end
    if type(iconInput) == "number" then
        return "rbxassetid://" .. tostring(iconInput)
    end
    if type(iconInput) == "string" then
        if iconInput:match("^rbxassetid://") or iconInput:match("^http") then
            return iconInput
        end
        local iconName = iconInput:lower()
        if LucideIcons[iconName] then
            return LucideIcons[iconName]
        end
        return nil
    end
    return nil
end

-- // Hàm tạo subtitle
local function AddSubtitle(parent, subtitleText, yOffset)
    if not subtitleText or subtitleText == "" then return nil end
    
    local subtitle = Instance.new("TextLabel", parent)
    subtitle.Size = UDim2.new(1, -20, 0, 0)
    subtitle.Position = UDim2.new(0, 10, 0, yOffset)
    subtitle.BackgroundTransparency = 1
    subtitle.Text = subtitleText
    subtitle.TextColor3 = Color3.fromRGB(140, 140, 140)
    subtitle.Font = "Gotham"
    subtitle.TextSize = 10
    subtitle.TextXAlignment = "Left"
    subtitle.TextYAlignment = "Top"
    subtitle.TextWrapped = true
    subtitle.Name = "Subtitle"
    
    local function updateHeight()
        local textBounds = subtitle.TextBounds
        local lineCount = math.max(1, math.ceil(textBounds.X / (subtitle.AbsoluteSize.X - 20)))
        local newHeight = lineCount * 14
        subtitle.Size = UDim2.new(1, -20, 0, newHeight)
    end
    
    task.defer(updateHeight)
    subtitle:GetPropertyChangedSignal("Text"):Connect(updateHeight)
    subtitle:GetPropertyChangedSignal("AbsoluteSize"):Connect(updateHeight)
    
    return subtitle
end

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

-- // Hàm setup background (CÁCH 2 - ĐƠN GIẢN, CẮT THEO CORNER + STROKE)
local function SetupBackground(frame, bgSetting, bgColor, defaultTransparency)
    -- Xóa background cũ nếu có
    local existingBg = frame:FindFirstChild("_BackgroundImage")
    if existingBg then existingBg:Destroy() end
    
    if bgSetting and bgSetting.Image then
        -- Lấy corner radius từ frame cha (hoặc tạo mới)
        local frameCorner = frame:FindFirstChild("UICorner")
        local cornerRadius = frameCorner and frameCorner.CornerRadius or UDim.new(0, 12)
        
        -- Tạo ImageLabel làm background
        local bgImage = Instance.new("ImageLabel")
        bgImage.Name = "_BackgroundImage"
        bgImage.Size = UDim2.new(1, 0, 1, 0)
        bgImage.Position = UDim2.new(0, 0, 0, 0)
        bgImage.BackgroundTransparency = 1
        bgImage.ImageTransparency = bgSetting.Transparency or 0
        bgImage.ScaleType = Enum.ScaleType.Crop
        bgImage.ZIndex = 0
        bgImage.Parent = frame
        
        -- Thêm corner cho background image (để bo góc ảnh)
        local bgCorner = Instance.new("UICorner")
        bgCorner.CornerRadius = cornerRadius
        bgCorner.Parent = bgImage
        
        -- Set image
        local imgValue = bgSetting.Image
        if type(imgValue) == "number" or (type(imgValue) == "string" and imgValue:match("^%d+$")) then
            bgImage.Image = "rbxassetid://" .. tostring(imgValue)
        elseif type(imgValue) == "string" then
            bgImage.Image = imgValue
        end
        
        -- Đưa background xuống dưới cùng
        bgImage.ZIndex = 0
        for _, child in pairs(frame:GetChildren()) do
            if child ~= bgImage and child:IsA("GuiObject") then
                child.ZIndex = math.max(child.ZIndex, 1)
            end
        end
        
        -- BẬT CLIP để cắt theo frame cha (quan trọng!)
        frame.ClipsDescendants = true
        frame.BackgroundTransparency = 1
        
        return true -- Có ảnh
    else
        -- KHÔNG ẢNH: set transparency theo setting
        frame.BackgroundTransparency = defaultTransparency or 0
        frame.BackgroundColor3 = bgColor or Color3.fromRGB(10, 10, 10)
        frame.ClipsDescendants = false -- Không cần clip nếu ko có ảnh
        return false -- Không có ảnh
    end
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
    
    local mainDefaultPos = settings.DefaultPosition or UDim2.new(0.5, -210, 0.5, -150)
    local floatDefaultPos = settings.FloatDefaultPosition or UDim2.new(0, 15, 0.5, -22)
    
    -- //////////////// MAIN UI ////////////////
    local Main = Instance.new("Frame", ScreenGui)
    Main.Size = UDim2.new(0, 420, 0, 300)
    Main.Position = mainDefaultPos
    Main.BackgroundColor3 = settings.MainBgColor or Color3.fromRGB(10, 10, 10)
    Main.Visible = false
    local mainCorner = Instance.new("UICorner", Main)
    mainCorner.CornerRadius = UDim.new(0, 12)
    local MainStroke = Instance.new("UIStroke", Main)
    MainStroke.Thickness = 2
    
    -- Setup background cho MAIN
    local hasMainBg = SetupBackground(Main, settings.Background, settings.MainBgColor, settings.MainBgTransparency or 0)
    
    -- //////////////// BẢNG LOADING ////////////////
    local LoadingFrame = Instance.new("Frame", ScreenGui)
    LoadingFrame.Size = UDim2.new(0, 300, 0, 120)
    LoadingFrame.Position = UDim2.new(0.5, -150, 0.5, -60)
    LoadingFrame.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
    LoadingFrame.ZIndex = 200
    local loadingCorner = Instance.new("UICorner", LoadingFrame)
    loadingCorner.CornerRadius = UDim.new(0, 12)
    local LoadingStroke = Instance.new("UIStroke", LoadingFrame)
    LoadingStroke.Color = ACCENT
    LoadingStroke.Thickness = 2
    
    local hasLoadingBg = SetupBackground(LoadingFrame, settings.LoadingBackground, Color3.fromRGB(12, 12, 12), 0.95)
    LoadingStroke.Transparency = hasLoadingBg and 0 or 1
    
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
    
    local function StartLoading()
        LoadingFrame.Visible = true
        
        if not hasLoadingBg then
            TweenService:Create(LoadingFrame, TweenInfo.new(0.5), {BackgroundTransparency = 0}):Play()
            TweenService:Create(LoadingStroke, TweenInfo.new(0.5), {Transparency = 0}):Play()
        end
        
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
                
                TweenService:Create(LoadingFrame, TweenInfo.new(0.5), {BackgroundTransparency = 1}):Play()
                TweenService:Create(LoadingStroke, TweenInfo.new(0.5), {Transparency = 1}):Play()
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
    
    -- //////////////// HỆ THỐNG KEY ////////////////
    local KeySolved = false
    local KUI = nil
    
    local function ShowMainUIAfterLoading()
        task.wait(2)
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
            local keyCorner = Instance.new("UICorner", KUI)
            keyCorner.CornerRadius = UDim.new(0, 12)
            local kstr = Instance.new("UIStroke", KUI)
            kstr.Thickness = 2
            kstr.Color = ACCENT
            MakeDraggable(KUI)
            
            -- Setup background cho KEY UI
            SetupBackground(KUI, settings.KeyBackground, Color3.fromRGB(12, 12, 12), 0)
            
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
            Instance.new("UICorner", KI).CornerRadius = UDim.new(0, 6)
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
            Instance.new("UICorner", KB).CornerRadius = UDim.new(0, 6)
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
        local logoImage = ResolveIcon(settings.LogoID)
        if logoImage then L.Image = logoImage end
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
        Instance.new("UICorner", b).CornerRadius = UDim.new(0, 6)
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
        local confCorner = Instance.new("UICorner", Conf)
        confCorner.CornerRadius = UDim.new(0, 12)
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
        Instance.new("UICorner", cbtn).CornerRadius = UDim.new(0, 6)
        local fbtn = Instance.new("TextButton", Conf)
        fbtn.Size = UDim2.new(0.4, 0, 0, 32)
        fbtn.Position = UDim2.new(0.53, 0, 0.6, 0)
        fbtn.BackgroundColor3 = ACCENT
        fbtn.Text = "Confirm"
        fbtn.TextColor3 = Color3.new(1,1,1)
        fbtn.ZIndex = 101
        Instance.new("UICorner", fbtn).CornerRadius = UDim.new(0, 6)
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
    Side.BackgroundTransparency = 1
    Side.ClipsDescendants = true
    local sideCorner = Instance.new("UICorner", Side)
    sideCorner.CornerRadius = UDim.new(0, 8)
    
    local SideStroke = Instance.new("UIStroke", Side)
    SideStroke.Color = ACCENT
    SideStroke.Thickness = 1
    SideStroke.Transparency = 0.7
    
    local TScroll = Instance.new("ScrollingFrame", Side)
    TScroll.Size = UDim2.new(1, 0, 1, -55)
    TScroll.Position = UDim2.new(0, 0, 0, 0)
    TScroll.BackgroundTransparency = 1
    TScroll.ScrollBarThickness = 3
    TScroll.ScrollBarImageColor3 = ACCENT
    TScroll.ScrollBarImageTransparency = 0.5
    TScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
    TScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
    
    local TLayout = Instance.new("UIListLayout", TScroll)
    TLayout.Padding = UDim.new(0, 5)
    TLayout.SortOrder = Enum.SortOrder.LayoutOrder
    
    local function updateSidebarCanvas()
        task.wait()
        TScroll.CanvasSize = UDim2.new(0, 0, 0, TLayout.AbsoluteContentSize.Y + 10)
    end
    TLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(updateSidebarCanvas)
    
    local UA = Instance.new("Frame", Side)
    UA.Size = UDim2.new(1, 0, 0, 50)
    UA.Position = UDim2.new(0, 0, 1, -45)
    UA.BackgroundTransparency = 1
    UA.ZIndex = 10
    
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
    Cont.BackgroundTransparency = 1
    Cont.ClipsDescendants = true
    local contCorner = Instance.new("UICorner", Cont)
    contCorner.CornerRadius = UDim.new(0, 8)
    
    local ContStroke = Instance.new("UIStroke", Cont)
    ContStroke.Color = ACCENT
    ContStroke.Thickness = 1
    ContStroke.Transparency = 0.7
    
    -- //////////////// FLOAT BUTTON ////////////////
    local TBtn = Instance.new("ImageButton", ScreenGui)
    TBtn.Size = UDim2.new(0, 45, 0, 45)
    TBtn.Position = floatDefaultPos
    TBtn.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    TBtn.Image = ""
    TBtn.ImageTransparency = 0.2
    TBtn.ZIndex = 10
    TBtn.ClipsDescendants = true
    local btnCorner = Instance.new("UICorner", TBtn)
    btnCorner.CornerRadius = UDim.new(1, 0)
    local TS = Instance.new("UIStroke", TBtn)
    TS.Color = ACCENT
    TS.Thickness = 2
    
    if settings.FloatBackground and settings.FloatBackground.Image then
        -- Setup background cho float button bằng cách thêm ảnh trực tiếp
        local bgImage = Instance.new("ImageLabel", TBtn)
        bgImage.Size = UDim2.new(1, 0, 1, 0)
        bgImage.Position = UDim2.new(0, 0, 0, 0)
        bgImage.BackgroundTransparency = 1
        local bgImgVal = settings.FloatBackground.Image
        if type(bgImgVal) == "number" or (type(bgImgVal) == "string" and bgImgVal:match("^%d+$")) then
            bgImage.Image = "rbxassetid://" .. tostring(bgImgVal)
        elseif type(bgImgVal) == "string" then
            bgImage.Image = bgImgVal
        end
        bgImage.ImageTransparency = settings.FloatBackground.Transparency or 0
        bgImage.ScaleType = Enum.ScaleType.Crop
        bgImage.ClipsDescendants = true
        bgImage.ZIndex = TBtn.ZIndex + 1
        
        -- Thêm corner cho background ảnh
        local bgCorner = Instance.new("UICorner")
        bgCorner.CornerRadius = UDim.new(1, 0)
        bgCorner.Parent = bgImage
        
        TBtn.BackgroundTransparency = 1
        TBtn.ClipsDescendants = true
        
        local overlay = Instance.new("Frame", TBtn)
        overlay.Size = UDim2.new(1, 0, 1, 0)
        overlay.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        overlay.BackgroundTransparency = 0.4
        overlay.ZIndex = TBtn.ZIndex + 2
        local overlayCorner = Instance.new("UICorner")
        overlayCorner.CornerRadius = UDim.new(1, 0)
        overlayCorner.Parent = overlay
    else
        TBtn.BackgroundTransparency = 0
    end
    
    local iconValue = settings.Icon
    if iconValue then
        local iconImage = ResolveIcon(iconValue)
        if iconImage then
            local FI = Instance.new("ImageLabel", TBtn)
            FI.Size = UDim2.new(1, 0, 1, 0)
            FI.Position = UDim2.new(0, 0, 0, 0)
            FI.BackgroundTransparency = 1
            FI.Image = iconImage
            FI.ImageColor3 = Color3.new(1, 1, 1)
            FI.ClipsDescendants = true
            FI.ScaleType = Enum.ScaleType.Crop
            FI.ZIndex = TBtn.ZIndex + 5
        elseif type(iconValue) == "string" then
            local textIcon = Instance.new("TextLabel", TBtn)
            textIcon.Size = UDim2.new(1, 0, 1, 0)
            textIcon.BackgroundTransparency = 1
            textIcon.Text = iconValue
            textIcon.TextColor3 = ACCENT
            textIcon.TextSize = 22
            textIcon.Font = Enum.Font.GothamBold
            textIcon.ZIndex = TBtn.ZIndex + 5
        end
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
    
    -- TOGGLE UI: CHỈ ẨN/HIỆN, KHÔNG THAY ĐỔI TRANSPARENCY
    TBtn.MouseButton1Click:Connect(function()
        if not KeySolved and KUI and KUI.Parent then
            KUI.Visible = not KUI.Visible
        else
            Main.Visible = not Main.Visible
            if Main.Visible then
                Main.Position = mainDefaultPos
            end
        end
    end)
    
    -- //////////////// NOTIFICATIONS ////////////////
    function NoirUI:Notify(title, message, iconName)
        local n = Instance.new("Frame", ScreenGui)
        n.Size = UDim2.new(0, 260, 0, 65)
        n.Position = UDim2.new(1, 20, 0.8, 0)
        n.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
        local notifCorner = Instance.new("UICorner", n)
        notifCorner.CornerRadius = UDim.new(0, 8)
        local ns = Instance.new("UIStroke", n)
        ns.Color = ACCENT
        
        -- Setup background cho NOTIFICATION
        SetupBackground(n, settings.NotificationBackground, Color3.fromRGB(15, 15, 15), 0.25)
        
        if iconName then
            local iconImg = ResolveIcon(iconName)
            if iconImg then
                local icon = Instance.new("ImageLabel", n)
                icon.Size = UDim2.new(0, 24, 0, 24)
                icon.Position = UDim2.new(0, 10, 0.5, -12)
                icon.BackgroundTransparency = 1
                icon.Image = iconImg
                icon.ImageColor3 = Color3.new(1, 1, 1)
                icon.ZIndex = 2
            end
        end
        
        local tl = Instance.new("TextLabel", n)
        tl.Size = UDim2.new(1, iconName and -45 or -15, 0, 20)
        tl.Position = UDim2.new(0, iconName and 40 or 15, 0, 5)
        tl.Text = title
        tl.TextColor3 = ACCENT
        tl.BackgroundTransparency = 1
        tl.Font = "GothamBold"
        tl.TextSize = 13
        tl.TextXAlignment = "Left"
        
        local ml = Instance.new("TextLabel", n)
        ml.Size = UDim2.new(1, iconName and -45 or -25, 0, 35)
        ml.Position = UDim2.new(0, iconName and 40 or 15, 0, 25)
        ml.Text = message
        ml.TextColor3 = Color3.new(1,1,1)
        ml.BackgroundTransparency = 1
        ml.TextWrapped = true
        ml.TextXAlignment = "Left"
        ml.TextYAlignment = "Top"
        ml.Font = "GothamMedium"
        ml.TextSize = 11
        
        for i, v in ipairs(NoirUI.Notifications) do
            TweenService:Create(v, TweenInfo.new(0.3), {Position = UDim2.new(1, -280, 0.8, -(i * 75))}):Play()
        end
        table.insert(NoirUI.Notifications, 1, n)
        TweenService:Create(n, TweenInfo.new(0.5, Enum.EasingStyle.Back), {Position = UDim2.new(1, -280, 0.8, 0)}):Play()
        task.delay(4, function()
            TweenService:Create(n, TweenInfo.new(0.5), {Position = UDim2.new(1, 20, n.Position.Y.Scale, n.Position.Y.Offset), BackgroundTransparency = 1}):Play()
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
    
    -- //////////////// TẠO TAB & ELEMENTS (GIỮ NGUYÊN) ////////////////
    local Window = {}
    
    function Window:CreateTab(name, icon)
        local B = Instance.new("TextButton", TScroll)
        B.Size = UDim2.new(1, -5, 0, 32)
        B.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
        B.BackgroundTransparency = 0.7
        B.Text = ""
        Instance.new("UICorner", B).CornerRadius = UDim.new(0, 6)
        local BT = Instance.new("TextLabel", B)
        BT.Size = UDim2.new(1, -10, 1, 0)
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
            IC.ClipsDescendants = true
            IC.ScaleType = Enum.ScaleType.Crop
            IC.ZIndex = 2
            
            local iconImage = ResolveIcon(icon)
            if iconImage then
                IC.Image = iconImage
            else
                IC.Image = "rbxassetid://6031094700"
            end
            IC.ImageColor3 = Color3.new(1, 1, 1)
        end
        
        local TabContainer = Instance.new("ScrollingFrame", Cont)
        TabContainer.Size = UDim2.new(1, 0, 1, 0)
        TabContainer.BackgroundTransparency = 1
        TabContainer.Visible = false
        TabContainer.ScrollBarThickness = 3
        TabContainer.ScrollBarImageColor3 = ACCENT
        TabContainer.ScrollBarImageTransparency = 0.5
        TabContainer.AutomaticCanvasSize = Enum.AutomaticSize.Y
        TabContainer.CanvasSize = UDim2.new(0, 0, 0, 0)
        
        local SearchFrame = Instance.new("Frame", TabContainer)
        SearchFrame.Size = UDim2.new(1, -20, 0, 35)
        SearchFrame.Position = UDim2.new(0, 10, 0, 0)
        SearchFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
        SearchFrame.BackgroundTransparency = 0.5
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
                    local img = v:FindFirstChild("ImageLabel")
                    if img then img.ImageColor3 = Color3.fromRGB(150, 150, 150) end
                end
            end
            TabContainer.Visible = true
            BT.TextColor3 = ACCENT
            local tabImg = B:FindFirstChild("ImageLabel")
            if tabImg then tabImg.ImageColor3 = Color3.fromRGB(150, 150, 150) end
            updateCanvas()
        end)
        
        if #TScroll:GetChildren() == 0 then
            TabContainer.Visible = true
            BT.TextColor3 = ACCENT
        end
        
        local Tab = { Count = 0, Elements = {}, Connections = {} }
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
        
        -- ========== CÁC ELEMENT ==========
        function Tab:CreateLabel(text, updateFunction)
            local l = Instance.new("TextLabel", ContentFrame)
            l.Size = UDim2.new(0.95, 0, 0, 20)
            l.BackgroundTransparency = 1
            l.Text = type(text) == "function" and text() or text
            l.TextColor3 = Color3.fromRGB(200, 200, 200)
            l.Font = "GothamMedium"
            l.TextSize = 12
            l.TextXAlignment = "Left"
            l.LayoutOrder = GetO()
            l.Name = "Label"
            table.insert(Tab.Elements, l)
            
            if type(text) == "function" then
                local connection = RunService.RenderStepped:Connect(function()
                    if l and l.Parent then
                        l.Text = text()
                    else
                        connection:Disconnect()
                    end
                end)
                table.insert(Tab.Connections, connection)
            end
            return l
        end
        
        function Tab:CreateSection(title, noLine)
            local s = Instance.new("Frame", ContentFrame)
            s.Size = UDim2.new(0.95, 0, 0, noLine and 25 or 35)
            s.BackgroundTransparency = 1
            s.LayoutOrder = GetO()
            s.Name = title
            table.insert(Tab.Elements, s)
            
            local lbl = Instance.new("TextLabel", s)
            lbl.Size = UDim2.new(1, 0, 0, 20)
            lbl.Position = UDim2.new(0, 0, 0, 0)
            lbl.Text = title:upper()
            lbl.TextColor3 = ACCENT
            lbl.Font = "GothamBold"
            lbl.TextSize = 11
            lbl.TextXAlignment = "Left"
            lbl.BackgroundTransparency = 1
            
            if not noLine then
                local line = Instance.new("Frame", s)
                line.Size = UDim2.new(1, 0, 0, 1)
                line.Position = UDim2.new(0, 0, 0, 22)
                line.BackgroundColor3 = ACCENT
                line.BackgroundTransparency = 0.5
                line.BorderSizePixel = 0
            end
            return s
        end
        
        function Tab:CreateParagraph(opt)
            local f = Instance.new("Frame", ContentFrame)
            f.Size = UDim2.new(0.95, 0, 0, 65)
            f.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
            f.BackgroundTransparency = 0.5
            Instance.new("UICorner", f).CornerRadius = UDim.new(0, 8)
            f.LayoutOrder = GetO()
            f.Name = opt.Title or ""
            table.insert(Tab.Elements, f)
            
            local title = Instance.new("TextLabel", f)
            title.Size = UDim2.new(1, -20, 0, 25)
            title.Position = UDim2.new(0, 10, 0, 5)
            title.Text = opt.Title or ""
            title.TextColor3 = ACCENT
            title.Font = "GothamBold"
            title.TextSize = 13
            title.BackgroundTransparency = 1
            title.TextXAlignment = "Left"
            
            local content = Instance.new("TextLabel", f)
            content.Size = UDim2.new(1, -20, 0, 30)
            content.Position = UDim2.new(0, 10, 0, 25)
            content.Text = opt.Content or ""
            content.TextColor3 = Color3.new(1, 1, 1)
            content.Font = "GothamMedium"
            content.TextSize = 11
            content.BackgroundTransparency = 1
            content.TextWrapped = true
            content.TextXAlignment = "Left"
            content.TextYAlignment = "Top"
            return f
        end
        
        function Tab:CreateTextBox(opt)
            local hasSubtitle = opt.Subtitle and opt.Subtitle ~= ""
            local f = Instance.new("Frame", ContentFrame)
            f.Size = UDim2.new(0.95, 0, 0, hasSubtitle and 55 or 35)
            f.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
            f.BackgroundTransparency = 0.7
            Instance.new("UICorner", f).CornerRadius = UDim.new(0, 8)
            f.LayoutOrder = GetO()
            f.Name = opt.Name or ""
            table.insert(Tab.Elements, f)
            
            local i = Instance.new("TextBox", f)
            i.Size = UDim2.new(1, -20, 0, 35)
            i.Position = UDim2.new(0, 10, 0, 0)
            i.BackgroundTransparency = 1
            i.PlaceholderText = opt.Name
            i.Text = opt.Default or ""
            i.TextColor3 = Color3.new(1, 1, 1)
            i.Font = "GothamMedium"
            i.TextSize = 12
            i.TextXAlignment = "Left"
            i.FocusLost:Connect(function() if opt.Callback then opt.Callback(i.Text) end end)
            
            if hasSubtitle then
                AddSubtitle(f, opt.Subtitle, 38)
            end
        end
        
        function Tab:CreateButton(opt)
            local hasSubtitle = opt.Subtitle and opt.Subtitle ~= ""
            local b = Instance.new("TextButton", ContentFrame)
            b.Size = UDim2.new(0.95, 0, 0, hasSubtitle and 55 or 35)
            b.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
            b.BackgroundTransparency = 0.6
            b.Text = opt.Name
            b.TextColor3 = Color3.new(1, 1, 1)
            b.Font = "GothamMedium"
            b.TextSize = 12
            Instance.new("UICorner", b).CornerRadius = UDim.new(0, 8)
            b.LayoutOrder = GetO()
            b.Name = opt.Name
            table.insert(Tab.Elements, b)
            
            if opt.Align == false then
                b.TextXAlignment = "Left"
                b.Text = "  " .. opt.Name
                local hint = Instance.new("TextLabel", b)
                hint.Size = UDim2.new(0, 50, 0, 35)
                hint.Position = UDim2.new(1, -55, 0, 0)
                hint.BackgroundTransparency = 1
                hint.Text = "button"
                hint.TextColor3 = Color3.fromRGB(120, 120, 120)
                hint.Font = "GothamMedium"
                hint.TextSize = 10
                hint.TextXAlignment = "Right"
                hint.TextYAlignment = "Center"
                hint.ZIndex = 2
            else
                b.TextXAlignment = "Center"
            end
            
            if hasSubtitle then
                AddSubtitle(b, opt.Subtitle, 38)
            end
            
            b.MouseButton1Click:Connect(opt.Callback)
        end
        
        function Tab:CreateToggle(opt)
            local hasSubtitle = opt.Subtitle and opt.Subtitle ~= ""
            local s = opt.Default or false
            local t = Instance.new("TextButton", ContentFrame)
            t.Size = UDim2.new(0.95, 0, 0, hasSubtitle and 55 or 35)
            t.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
            t.BackgroundTransparency = 0.6
            t.Text = "  " .. opt.Name
            t.TextColor3 = s and ACCENT or Color3.fromRGB(180, 180, 180)
            t.TextXAlignment = "Left"
            t.TextSize = 12
            Instance.new("UICorner", t).CornerRadius = UDim.new(0, 8)
            t.LayoutOrder = GetO()
            t.Name = opt.Name
            table.insert(Tab.Elements, t)
            
            local bx = Instance.new("Frame", t)
            bx.Size = UDim2.new(0, 30, 0, 16)
            bx.Position = UDim2.new(1, -40, 0.5, hasSubtitle and -15 or -8)
            bx.BackgroundColor3 = s and ACCENT or Color3.fromRGB(40, 40, 40)
            bx.BackgroundTransparency = 0.3
            Instance.new("UICorner", bx).CornerRadius = UDim.new(1, 0)
            
            if hasSubtitle then
                AddSubtitle(t, opt.Subtitle, 38)
            end
            
            t.MouseButton1Click:Connect(function()
                s = not s
                t.TextColor3 = s and ACCENT or Color3.fromRGB(180, 180, 180)
                bx.BackgroundColor3 = s and ACCENT or Color3.fromRGB(40, 40, 40)
                opt.Callback(s)
            end)
        end
        
        function Tab:CreateSlider(opt)
            local hasSubtitle = opt.Subtitle and opt.Subtitle ~= ""
            local range = opt.range or {0, 100}
            local min = range[1]
            local max = range[2]
            local increment = opt.increment or 1
            local defaultValue = opt.Default or min
            
            defaultValue = math.floor((defaultValue - min) / increment) * increment + min
            defaultValue = math.clamp(defaultValue, min, max)
            
            local f = Instance.new("Frame", ContentFrame)
            f.Size = UDim2.new(0.95, 0, 0, hasSubtitle and 70 or 50)
            f.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
            f.BackgroundTransparency = 0.7
            Instance.new("UICorner", f).CornerRadius = UDim.new(0, 8)
            f.LayoutOrder = GetO()
            f.Name = opt.Name or ""
            table.insert(Tab.Elements, f)
            
            local l = Instance.new("TextLabel", f)
            l.Size = UDim2.new(1, 0, 0, 20)
            l.Position = UDim2.new(0, 12, 0, hasSubtitle and 5 or 5)
            l.BackgroundTransparency = 1
            l.Text = opt.Name .. ": " .. defaultValue
            l.TextColor3 = Color3.new(1, 1, 1)
            l.TextXAlignment = "Left"
            l.TextSize = 11
            
            local sbg = Instance.new("Frame", f)
            sbg.Size = UDim2.new(0.9, 0, 0, 8)
            sbg.Position = UDim2.new(0.05, 0, hasSubtitle and 0.55 or 0.7, 0)
            sbg.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            sbg.BackgroundTransparency = 0.5
            Instance.new("UICorner", sbg)
            
            local fill = Instance.new("Frame", sbg)
            local percent = (defaultValue - min) / (max - min)
            fill.Size = UDim2.new(percent, 0, 1, 0)
            fill.BackgroundColor3 = ACCENT
            Instance.new("UICorner", fill)
            
            if hasSubtitle then
                AddSubtitle(f, opt.Subtitle, 48)
            end
            
            local isHeld = false
            local function UpdateSlider(input)
                local p = math.clamp((input.Position.X - sbg.AbsolutePosition.X) / sbg.AbsoluteSize.X, 0, 1)
                local rawValue = min + (max - min) * p
                local v = math.floor((rawValue - min) / increment) * increment + min
                v = math.clamp(v, min, max)
                local newPercent = (v - min) / (max - min)
                fill.Size = UDim2.new(newPercent, 0, 1, 0)
                l.Text = opt.Name .. ": " .. v
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
            local hasSubtitle = opt.Subtitle and opt.Subtitle ~= ""
            local ColorSelected = opt.Default or Color3.fromRGB(170, 85, 255)
            local h, s, v = ColorSelected:ToHSV()
            local open = false
            
            local f = Instance.new("Frame", ContentFrame)
            f.Size = UDim2.new(0.95, 0, 0, hasSubtitle and 55 or 35)
            f.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
            f.BackgroundTransparency = 0.7
            Instance.new("UICorner", f).CornerRadius = UDim.new(0, 8)
            f.LayoutOrder = GetO()
            f.ClipsDescendants = true
            f.Name = opt.Name or ""
            table.insert(Tab.Elements, f)
            
            local t = Instance.new("TextLabel", f)
            t.Size = UDim2.new(1, 0, 0, 35)
            t.Position = UDim2.new(0, 12, 0, 0)
            t.BackgroundTransparency = 1
            t.Text = opt.Name
            t.TextColor3 = Color3.new(1, 1, 1)
            t.Font = "GothamMedium"
            t.TextSize = 12
            t.TextXAlignment = "Left"
            
            local pvw = Instance.new("TextButton", f)
            pvw.Size = UDim2.new(0, 40, 0, 18)
            pvw.Position = UDim2.new(1, -50, 0, hasSubtitle and 8.5 or 8.5)
            pvw.BackgroundColor3 = ColorSelected
            pvw.Text = ""
            Instance.new("UICorner", pvw).CornerRadius = UDim.new(0, 4)
            
            if hasSubtitle then
                AddSubtitle(f, opt.Subtitle, 38)
            end
            
            local Holder = Instance.new("Frame", f)
            Holder.Size = UDim2.new(1, 0, 0, 140)
            Holder.Position = UDim2.new(0, 0, 0, 35)
            Holder.BackgroundTransparency = 1
            
            local satBox = Instance.new("ImageButton", Holder)
            satBox.Size = UDim2.new(0.9, 0, 0, 100)
            satBox.Position = UDim2.new(0.05, 0, 0, 5)
            satBox.Image = "rbxassetid://4155801252"
            satBox.BackgroundColor3 = Color3.fromHSV(h, 1, 1)
            Instance.new("UICorner", satBox).CornerRadius = UDim.new(0, 6)
            
            local cursor = Instance.new("Frame", satBox)
            cursor.Size = UDim2.new(0, 8, 0, 8)
            cursor.AnchorPoint = Vector2.new(0.5, 0.5)
            cursor.BackgroundColor3 = Color3.new(1, 1, 1)
            cursor.Position = UDim2.new(s, 0, 1 - v, 0)
            Instance.new("UICorner", cursor).CornerRadius = UDim.new(1, 0)
            
            local hueSlide = Instance.new("ImageButton", Holder)
            hueSlide.Size = UDim2.new(0.9, 0, 0, 12)
            hueSlide.Position = UDim2.new(0.05, 0, 0, 115)
            hueSlide.Image = "rbxassetid://3641079629"
            Instance.new("UICorner", hueSlide).CornerRadius = UDim.new(0, 6)
            
            local hCursor = Instance.new("Frame", hueSlide)
            hCursor.Size = UDim2.new(0, 4, 1, 4)
            hCursor.Position = UDim2.new(1 - h, 0, 0.5, 0)
            hCursor.AnchorPoint = Vector2.new(0.5, 0.5)
            hCursor.BackgroundColor3 = Color3.new(1, 1, 1)
            Instance.new("UICorner", hCursor)
            
            local function UpdateColor()
                local finalCol = Color3.fromHSV(h, s, v)
                pvw.BackgroundColor3 = finalCol
                satBox.BackgroundColor3 = Color3.fromHSV(h, 1, 1)
                cursor.Position = UDim2.new(s, 0, 1 - v, 0)
                hCursor.Position = UDim2.new(1 - h, 0, 0.5, 0)
                if opt.Callback then opt.Callback(finalCol) end
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
                TweenService:Create(f, TweenInfo.new(0.3), {Size = open and UDim2.new(0.95, 0, 0, 180) or UDim2.new(0.95, 0, 0, hasSubtitle and 55 or 35)}):Play()
            end)
        end
        
        function Tab:CreateDropdown(opt)
            local hasSubtitle = opt.Subtitle and opt.Subtitle ~= ""
            local d = Instance.new("Frame", ContentFrame)
            d.Size = UDim2.new(0.95, 0, 0, hasSubtitle and 55 or 35)
            d.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
            d.BackgroundTransparency = 0.7
            Instance.new("UICorner", d).CornerRadius = UDim.new(0, 8)
            d.LayoutOrder = GetO()
            d.ClipsDescendants = true
            d.Name = opt.Name or ""
            table.insert(Tab.Elements, d)
            
            local t = Instance.new("TextButton", d)
            t.Name = "DropdownButton"
            t.Size = UDim2.new(1, 0, 0, 35)
            t.BackgroundTransparency = 1
            t.Text = "  " .. opt.Name .. " : " .. (opt.Default or (opt.Options and opt.Options[1] or "Đang tải..."))
            t.TextColor3 = Color3.new(1, 1, 1)
            t.Font = "GothamMedium"
            t.TextSize = 12
            t.TextXAlignment = "Left"
            
            local Arrow = Instance.new("TextLabel", t)
            Arrow.Name = "ArrowLabel"
            Arrow.Size = UDim2.new(0, 30, 1, 0)
            Arrow.Position = UDim2.new(1, -35, 0, 0)
            Arrow.BackgroundTransparency = 1
            Arrow.Text = "▼"
            Arrow.TextColor3 = Color3.fromRGB(180, 180, 180)
            Arrow.Font = "GothamMedium"
            Arrow.TextSize = 14
            Arrow.TextXAlignment = "Center"
            
            if hasSubtitle then
                AddSubtitle(d, opt.Subtitle, 38)
            end
            
            local il = Instance.new("ScrollingFrame", d)
            il.Name = "OptionsList"
            il.Size = UDim2.new(1, 0, 0, 120)
            il.Position = UDim2.new(0, 0, 0, 35)
            il.BackgroundTransparency = 1
            il.ScrollBarThickness = 2
            il.AutomaticCanvasSize = "Y"
            il.Visible = false
            local ilLayout = Instance.new("UIListLayout", il)
            ilLayout.Padding = UDim.new(0, 2)
            
            local function refreshOptions()
                if not opt.GetOptions then return end
                local newOptions = opt.GetOptions()
                if not newOptions then return end
                
                for _, child in pairs(il:GetChildren()) do
                    if child:IsA("TextButton") then
                        child:Destroy()
                    end
                end
                
                for _, option in pairs(newOptions) do
                    local it = Instance.new("TextButton", il)
                    it.Size = UDim2.new(1, 0, 0, 30)
                    it.BackgroundColor3 = Color3.fromRGB(28, 28, 28)
                    it.BackgroundTransparency = 0.5
                    it.Text = option
                    it.TextColor3 = Color3.fromRGB(200, 200, 200)
                    it.Font = "GothamMedium"
                    it.TextSize = 11
                    it.MouseButton1Click:Connect(function()
                        il.Visible = false
                        Arrow.Text = "▼"
                        t.Text = "  " .. opt.Name .. " : " .. option
                        TweenService:Create(d, TweenInfo.new(0.3), {Size = UDim2.new(0.95, 0, 0, hasSubtitle and 55 or 35)}):Play()
                        if opt.Callback then opt.Callback(option) end
                    end)
                end
                
                task.wait()
                local optionCount = math.min(#newOptions, 4)
                il.Size = UDim2.new(1, 0, 0, optionCount * 32)
                
                if opt.Default then
                    t.Text = "  " .. opt.Name .. " : " .. opt.Default
                elseif newOptions[1] then
                    t.Text = "  " .. opt.Name .. " : " .. newOptions[1]
                end
            end
            
            local open = false
            t.MouseButton1Click:Connect(function()
                open = not open
                il.Visible = open
                Arrow.Text = open and "▲" or "▼"
                if open and opt.RefreshOnOpen then
                    refreshOptions()
                end
                TweenService:Create(d, TweenInfo.new(0.3), {Size = open and UDim2.new(0.95, 0, 0, 35 + il.Size.Y.Offset + (hasSubtitle and 20 or 0)) or UDim2.new(0.95, 0, 0, hasSubtitle and 55 or 35)}):Play()
            end)
            
            if opt.GetOptions then
                refreshOptions()
            elseif opt.Options then
                for _, v in pairs(opt.Options) do
                    local it = Instance.new("TextButton", il)
                    it.Size = UDim2.new(1, 0, 0, 30)
                    it.BackgroundColor3 = Color3.fromRGB(28, 28, 28)
                    it.BackgroundTransparency = 0.5
                    it.Text = v
                    it.TextColor3 = Color3.fromRGB(200, 200, 200)
                    it.Font = "GothamMedium"
                    it.TextSize = 11
                    it.MouseButton1Click:Connect(function()
                        open = false
                        il.Visible = false
                        Arrow.Text = "▼"
                        t.Text = "  " .. opt.Name .. " : " .. v
                        TweenService:Create(d, TweenInfo.new(0.3), {Size = UDim2.new(0.95, 0, 0, hasSubtitle and 55 or 35)}):Play()
                        opt.Callback(v)
                    end)
                end
                local optionCount = math.min(#opt.Options, 4)
                il.Size = UDim2.new(1, 0, 0, optionCount * 32)
            end
            
            if opt.RefreshInterval and opt.GetOptions then
                local refreshConnection = RunService.RenderStepped:Connect(function()
                    if d and d.Parent then
                        local newOptions = opt.GetOptions()
                        if newOptions then
                            local currentCount = 0
                            for _, child in pairs(il:GetChildren()) do
                                if child:IsA("TextButton") then currentCount = currentCount + 1 end
                            end
                            if currentCount ~= #newOptions then
                                refreshOptions()
                            end
                        end
                    else
                        refreshConnection:Disconnect()
                    end
                end)
                table.insert(Tab.Connections, refreshConnection)
            end
        end
        
        function Tab:CreateRunBox(opt)
            local f = Instance.new("Frame", ContentFrame)
            f.Size = UDim2.new(0.95, 0, 0, 38)
            f.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
            f.BackgroundTransparency = 0.7
            Instance.new("UICorner", f).CornerRadius = UDim.new(0, 8)
            f.LayoutOrder = GetO()
            f.Name = "RunBox"
            table.insert(Tab.Elements, f)
            
            local i = Instance.new("TextBox", f)
            i.Size = UDim2.new(1, -65, 1, 0)
            i.Position = UDim2.new(0, 10, 0, 0)
            i.BackgroundTransparency = 1
            i.PlaceholderText = opt.Placeholder or "Nhập: .cmd, loadstring('url'), or lua code"
            i.Text = ""
            i.TextColor3 = Color3.new(1, 1, 1)
            i.Font = "GothamMedium"
            i.TextSize = 11
            i.TextXAlignment = "Left"
            i.ClearTextOnFocus = false
            
            local r = Instance.new("TextButton", f)
            r.Size = UDim2.new(0, 50, 0, 26)
            r.Position = UDim2.new(1, -55, 0.5, -13)
            r.BackgroundColor3 = ACCENT
            r.Text = "RUN"
            r.TextColor3 = Color3.new(1, 1, 1)
            r.Font = "GothamBold"
            r.TextSize = 10
            Instance.new("UICorner", r).CornerRadius = UDim.new(0, 6)
            
            r.MouseButton1Click:Connect(function()
                local input = i.Text
                if input == "" then return end
                
                if input:sub(1, 1) == "." then
                    local parts = {}
                    for part in input:sub(2):gmatch("%S+") do
                        table.insert(parts, part)
                    end
                    local cmd = parts[1] and parts[1]:lower() or ""
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
        
        return Tab
    end
    
    return Window
end

return NoirUI
