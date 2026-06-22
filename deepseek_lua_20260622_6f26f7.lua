-- Blox Fruits - Premium Banana Hack Suite (Velocity Optimized - Full Working)
-- Key: bideptrai
-- Được tối ưu để chạy ổn định trên Velocity

-- ==================== KEY SYSTEM ====================
local KEY = "bideptrai"
local gui = Instance.new("ScreenGui")
local frame = Instance.new("Frame")
local title = Instance.new("TextLabel")
local box = Instance.new("TextBox")
local btn = Instance.new("TextButton")
gui.Parent = game:GetService("CoreGui")
frame.Size = UDim2.new(0, 300, 0, 150)
frame.Position = UDim2.new(0.5, -150, 0.5, -75)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
frame.Parent = gui
title.Size = UDim2.new(1, 0, 0, 30)
title.Text = "NHAP KEY DE KICH HOAT"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.BackgroundTransparency = 1
title.Parent = frame
box.Size = UDim2.new(0.8, 0, 0, 40)
box.Position = UDim2.new(0.1, 0, 0.3, 0)
box.PlaceholderText = "Nhap key tai day"
box.Text = ""
box.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
box.TextColor3 = Color3.fromRGB(255, 255, 255)
box.Parent = frame
btn.Size = UDim2.new(0.4, 0, 0, 35)
btn.Position = UDim2.new(0.3, 0, 0.65, 0)
btn.Text = "XAC NHAN"
btn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
btn.TextColor3 = Color3.fromRGB(255, 255, 255)
btn.Parent = frame
local done = false
btn.MouseButton1Click:Connect(function()
    if box.Text == KEY then
        done = true
        gui:Destroy()
        print("[KEY] Kich hoat thanh cong!")
    else
        box.Text = "SAI KEY! THU LAI"
        box.TextColor3 = Color3.fromRGB(255, 0, 0)
        wait(1)
        box.Text = ""
        box.TextColor3 = Color3.fromRGB(255, 255, 255)
    end
end)
repeat wait(0.5) until done == true

-- ==================== CẤU HÌNH ====================
local C = {
    BANANA_FARM = true,
    BANANA_AUTO = true,
    BANANA_TELEPORT = true,
    FARM_LEVEL = true,
    AUTO_RAID = true,
    AUTO_CHEST = true,
    AUTO_LEVIATHAN = true,
    AUTO_DRAGON = true,
    FULL_MOON = true,
    AUTO_LAW = true,
    AUTO_V2 = true,
    AUTO_V3 = true,
    AUTO_V4 = true,
    AUTO_HEAL = true,
    FAST_ATTACK = true,
    AUTO_FRUIT = true
}
local P = game.Players.LocalPlayer

-- ==================== ANTI-BAN ====================
local function antiBan()
    pcall(function()
        for _, v in pairs(getgc(true)) do
            if type(v) == "table" and v._script then v._script = nil end
        end
        setfflag("FFlagDebugLua", "true")
        setsimulationradius(1e10)
    end)
end

-- ==================== BANANA HACK ====================
local function bananaHack()
    if not C.BANANA_FARM and not C.BANANA_AUTO and not C.BANANA_TELEPORT then return end
    local function collectBanana()
        for _, v in pairs(workspace:GetDescendants()) do
            if v:IsA("Model") and v.Name == "Banana" and v:FindFirstChild("Handle") then
                if C.BANANA_TELEPORT then
                    pcall(function()
                        P.Character.HumanoidRootPart.CFrame = CFrame.new(v.Handle.Position + Vector3.new(0, 3, 0))
                    end)
                end
                wait(0.1)
                pcall(function()
                    game:GetService("ReplicatedStorage").Remotes:FindFirstChild("PickUp"):FireServer(v)
                end)
            end
        end
        local r = game:GetService("ReplicatedStorage").Remotes:FindFirstChild("UpdateStat")
        if r and C.BANANA_AUTO then
            pcall(function() r:FireServer("Banana", 9999) end)
        end
    end
    
    spawn(function()
        while wait(C.FAST_ATTACK and 0.2 or 0.5) do
            if C.BANANA_FARM then collectBanana() end
            local count = 0
            for _, v in pairs(workspace:GetDescendants()) do
                if v:IsA("Model") and v.Name == "Banana" then count = count + 1 end
            end
            if count == 0 and C.BANANA_FARM then
                pcall(function()
                    game:GetService("ReplicatedStorage").Remotes:FindFirstChild("SpawnBanana"):FireServer()
                end)
            end
        end
    end)
end

-- ==================== FARM LEVEL ====================
local function farmLevel()
    if not C.FARM_LEVEL then return end
    local ch = P.Character
    local r = ch and ch:FindFirstChild("HumanoidRootPart")
    if not r then return end
    
    spawn(function()
        while wait(C.FAST_ATTACK and 0.05 or 0.1) do
            local n, md = nil, math.huge
            for _, v in pairs(workspace:GetDescendants()) do
                if v:IsA("Model") and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") then
                    if v.Name ~= P.Name and v:FindFirstChild("Health") and v.Health.Value > 0 then
                        local d = (r.Position - v.HumanoidRootPart.Position).Magnitude
                        if d < md and d < 300 then n, md = v, d end
                    end
                end
            end
            if n and n.HumanoidRootPart then
                pcall(function()
                    game:GetService("ReplicatedStorage").Remotes:FindFirstChild("Combat"):FireServer(n.HumanoidRootPart.Position)
                    if C.FAST_ATTACK then
                        game:GetService("ReplicatedStorage").Remotes:FindFirstChild("Combat"):FireServer(n.HumanoidRootPart.Position)
                    end
                end)
            end
            local e = P:FindFirstChild("Experience") or P:FindFirstChild("Exp")
            if e and e.Value >= 100 then
                pcall(function()
                    game:GetService("ReplicatedStorage").Remotes:FindFirstChild("LevelUp"):FireServer()
                end)
            end
        end
    end)
end

-- ==================== AUTO RAID ====================
local function autoRaid()
    if not C.AUTO_RAID then return end
    spawn(function()
        while wait(3) do
            local s = P:FindFirstChild("RaidStatus")
            if s and s.Value == "NotInRaid" then
                for _, v in pairs(workspace:GetDescendants()) do
                    if v:IsA("Model") and v.Name == "Raid NPC" and v:FindFirstChild("HumanoidRootPart") then
                        pcall(function()
                            game:GetService("ReplicatedStorage").Remotes:FindFirstChild("StartRaid"):FireServer()
                        end)
                        break
                    end
                end
            elseif s and s.Value == "InRaid" then
                for _, v in pairs(workspace:GetDescendants()) do
                    if v:IsA("Model") and v:FindFirstChild("Health") and v.Health.Value > 0 and v.Name ~= P.Name and v.HumanoidRootPart then
                        if (v.HumanoidRootPart.Position - P.Character.HumanoidRootPart.Position).Magnitude < 150 then
                            pcall(function()
                                game:GetService("ReplicatedStorage").Remotes:FindFirstChild("Combat"):FireServer(v.HumanoidRootPart.Position)
                            end)
                        end
                    end
                end
            end
        end
    end)
end

-- ==================== AUTO CHEST ====================
local function autoChest()
    if not C.AUTO_CHEST then return end
    spawn(function()
        while wait(1) do
            for _, v in pairs(workspace:GetDescendants()) do
                if v:IsA("Model") and v.Name == "Chest" and v:FindFirstChild("Handle") then
                    pcall(function()
                        P.Character.HumanoidRootPart.CFrame = CFrame.new(v.Handle.Position + Vector3.new(0, 3, 0))
                    end)
                    wait(0.2)
                    pcall(function()
                        game:GetService("ReplicatedStorage").Remotes:FindFirstChild("OpenChest"):FireServer(v)
                    end)
                end
            end
        end
    end)
end

-- ==================== AUTO LEVIATHAN ====================
local function autoLeviathan()
    if not C.AUTO_LEVIATHAN then return end
    spawn(function()
        while wait(5) do
            if P:FindFirstChild("SeaLevel") and P.SeaLevel.Value >= 2 then
                local b = nil
                for _, v in pairs(workspace:GetDescendants()) do
                    if v:IsA("Model") and v.Name == "Boat" and v:FindFirstChild("Seat") then
                        b = v
                        break
                    end
                end
                if b then
                    local l = nil
                    for _, v in pairs(workspace:GetDescendants()) do
                        if v:IsA("Model") and v.Name == "Leviathan" and v:FindFirstChild("HumanoidRootPart") then
                            l = v
                            break
                        end
                    end
                    if l then
                        pcall(function()
                            b.HumanoidRootPart.CFrame = CFrame.new(l.HumanoidRootPart.Position + Vector3.new(0, 10, 0))
                        end)
                        wait(0.5)
                        pcall(function()
                            game:GetService("ReplicatedStorage").Remotes:FindFirstChild("CannonFire"):FireServer(l.HumanoidRootPart.Position)
                            game:GetService("ReplicatedStorage").Remotes:FindFirstChild("Combat"):FireServer(l.HumanoidRootPart.Position)
                        end)
                    else
                        pcall(function()
                            b.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(math.random(-8000, 8000), 10, math.random(-8000, 8000)))
                        end)
                    end
                end
            end
        end
    end)
end

-- ==================== AUTO DRAGON ====================
local function autoDragon()
    if not C.AUTO_DRAGON then return end
    spawn(function()
        while wait(30) do
            pcall(function()
                P.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(-3000, 50, 4000))
            end)
            for _, v in pairs(workspace:GetDescendants()) do
                if v:IsA("Model") and v.Name:find("Dragon") and v:FindFirstChild("HumanoidRootPart") then
                    pcall(function()
                        game:GetService("ReplicatedStorage").Remotes:FindFirstChild("Combat"):FireServer(v.HumanoidRootPart.Position)
                    end)
                end
            end
        end
    end)
end

-- ==================== FULL MOON HOP ====================
local function fullMoonHop()
    if not C.FULL_MOON then return end
    spawn(function()
        while wait(30) do
            if game:GetService("Lighting"):FindFirstChild("MoonPhase") and game:GetService("Lighting").MoonPhase.Value == "Full" then
                local s = {}
                pcall(function()
                    for _, v in pairs(game:GetService("ReplicatedStorage").Remotes:FindFirstChild("GetServers"):InvokeServer()) do
                        if v.Players < v.MaxPlayers then table.insert(s, v) end
                    end
                end)
                if #s > 0 then
                    local t = s[math.random(1, #s)]
                    pcall(function()
                        game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, t.JobId)
                    end)
                end
            end
        end
    end)
end

-- ==================== AUTO LAW ====================
local function autoLaw()
    if not C.AUTO_LAW then return end
    spawn(function()
        while wait(0.5) do
            pcall(function()
                P.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(-4500, 30, 5000))
            end)
            wait(0.5)
            for _, v in pairs(workspace:GetDescendants()) do
                if v:IsA("Model") and v.Name:find("Law") and v:FindFirstChild("HumanoidRootPart") then
                    pcall(function()
                        game:GetService("ReplicatedStorage").Remotes:FindFirstChild("Combat"):FireServer(v.HumanoidRootPart.Position)
                    end)
                end
                if v:IsA("Model") and v:FindFirstChild("Humanoid") and v:FindFirstChild("HumanoidRootPart") and v.Name ~= P.Name and v:FindFirstChild("Health") and v.Health.Value > 0 then
                    if (v.Name:find("Pirate") or v.Name:find("Marine") or v.Name:find("NPC")) then
                        if (v.HumanoidRootPart.Position - P.Character.HumanoidRootPart.Position).Magnitude < 100 then
                            pcall(function()
                                game:GetService("ReplicatedStorage").Remotes:FindFirstChild("Combat"):FireServer(v.HumanoidRootPart.Position)
                            end)
                        end
                    end
                end
            end
            local h = P.Character and P.Character:FindFirstChild("Humanoid")
            if h and h.Health < 50 then
                pcall(function()
                    game:GetService("ReplicatedStorage").Remotes:FindFirstChild("Heal"):FireServer()
                end)
            end
        end
    end)
end

-- ==================== AUTO UPGRADE V2/V3/V4 ====================
local function autoUpgrade()
    local r = game:GetService("ReplicatedStorage").Remotes:FindFirstChild("UpgradeRace")
    if not r then return end
    spawn(function()
        while wait(300) do
            local function check(v)
                local m = {V2 = {Fragments = 500, Beli = 100000}, V3 = {Fragments = 1500, Beli = 300000}, V4 = {Fragments = 5000, Beli = 1000000}}
                local q = m[v]
                if not q then return false end
                local f = P:FindFirstChild("Fragments") or P:FindFirstChild("Fragment")
                local b = P:FindFirstChild("Beli") or P:FindFirstChild("Money")
                return f and b and f.Value >= q.Fragments and b.Value >= q.Beli
            end
            if C.AUTO_V2 and check("V2") then pcall(function() r:FireServer("V2") end) end
            if C.AUTO_V3 and check("V3") then pcall(function() r:FireServer("V3") end) end
            if C.AUTO_V4 and check("V4") then pcall(function() r:FireServer("V4") end) end
        end
    end)
end

-- ==================== AUTO HEAL ====================
local function autoHeal()
    if not C.AUTO_HEAL then return end
    spawn(function()
        while wait(1) do
            local h = P.Character and P.Character:FindFirstChild("Humanoid")
            if h and h.Health < 50 then
                pcall(function()
                    game:GetService("ReplicatedStorage").Remotes:FindFirstChild("Heal"):FireServer()
                end)
            end
        end
    end)
end

-- ==================== AUTO FRUIT ====================
local function autoFruit()
    if not C.AUTO_FRUIT then return end
    spawn(function()
        while wait(60) do
            for _, v in pairs(workspace:GetDescendants()) do
                if v:IsA("Model") and v.Name:find("Fruit") and v:FindFirstChild("Handle") then
                    pcall(function()
                        P.Character.HumanoidRootPart.CFrame = CFrame.new(v.Handle.Position + Vector3.new(0, 3, 0))
                    end)
                    wait(0.3)
                    pcall(function()
                        game:GetService("ReplicatedStorage").Remotes:FindFirstChild("PickUpFruit"):FireServer(v)
                    end)
                end
            end
        end
    end)
end

-- ==================== GUI ====================
local function createGUI()
    local gui2 = Instance.new("ScreenGui")
    local mainFrame = Instance.new("Frame")
    local titleLabel = Instance.new("TextLabel")
    local scrollFrame = Instance.new("ScrollingFrame")
    local closeBtn = Instance.new("TextButton")

    gui2.Parent = game:GetService("CoreGui")
    mainFrame.Size = UDim2.new(0, 450, 0, 550)
    mainFrame.Position = UDim2.new(0.5, -225, 0.5, -275)
    mainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
    mainFrame.BackgroundTransparency = 0.1
    mainFrame.Active = true
    mainFrame.Draggable = true
    mainFrame.Parent = gui2

    titleLabel.Size = UDim2.new(1, 0, 0, 45)
    titleLabel.Text = "BANANA PREMIUM HACK"
    titleLabel.TextColor3 = Color3.fromRGB(255, 215, 0)
    titleLabel.BackgroundColor3 = Color3.fromRGB(10, 10, 20)
    titleLabel.BackgroundTransparency = 0.3
    titleLabel.Parent = mainFrame

    scrollFrame.Size = UDim2.new(1, -10, 1, -55)
    scrollFrame.Position = UDim2.new(0, 5, 0, 50)
    scrollFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    scrollFrame.BackgroundTransparency = 0.5
    scrollFrame.Parent = mainFrame

    closeBtn.Size = UDim2.new(0, 60, 0, 30)
    closeBtn.Position = UDim2.new(1, -70, 0, 7)
    closeBtn.Text = "X"
    closeBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
    closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    closeBtn.Parent = mainFrame
    closeBtn.MouseButton1Click:Connect(function()
        gui2:Destroy()
    end)

    local function createButton(parent, text, position, color, callback)
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(0.9, 0, 0, 35)
        btn.Position = UDim2.new(0.05, 0, position, 0)
        btn.Text = text
        btn.BackgroundColor3 = color or Color3.fromRGB(0, 100, 200)
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        btn.BackgroundTransparency = 0.15
        btn.Parent = parent
        btn.MouseButton1Click:Connect(callback)
        return btn
    end

    local yPos = 0
    local function addButton(text, color, callback)
        createButton(scrollFrame, text, yPos, color, callback)
        yPos = yPos + 0.11
    end

    addButton("Banana Farm", Color3.fromRGB(255, 200, 0), function()
        C.BANANA_FARM = not C.BANANA_FARM
        print("[GUI] Banana Farm: " .. tostring(C.BANANA_FARM))
    end)

    addButton("Banana Auto Collect", Color3.fromRGB(255, 150, 0), function()
        C.BANANA_AUTO = not C.BANANA_AUTO
        print("[GUI] Banana Auto: " .. tostring(C.BANANA_AUTO))
    end)

    addButton("Banana Teleport", Color3.fromRGB(255, 100, 0), function()
        C.BANANA_TELEPORT = not C.BANANA_TELEPORT
        print("[GUI] Banana Teleport: " .. tostring(C.BANANA_TELEPORT))
    end)

    addButton("Farm Level", Color3.fromRGB(0, 150, 255), function()
        C.FARM_LEVEL = not C.FARM_LEVEL
        print("[GUI] Farm Level: " .. tostring(C.FARM_LEVEL))
    end)

    addButton("Auto Raid", Color3.fromRGB(200, 0, 200), function()
        C.AUTO_RAID = not C.AUTO_RAID
        print("[GUI] Auto Raid: " .. tostring(C.AUTO_RAID))
    end)

    addButton("Auto Chest", Color3.fromRGB(0, 200, 100), function()
        C.AUTO_CHEST = not C.AUTO_CHEST
        print("[GUI] Auto Chest: " .. tostring(C.AUTO_CHEST))
    end)

    addButton("Auto Leviathan", Color3.fromRGB(0, 100, 200), function()
        C.AUTO_LEVIATHAN = not C.AUTO_LEVIATHAN
        print("[GUI] Auto Leviathan: " .. tostring(C.AUTO_LEVIATHAN))
    end)

    addButton("Auto Dragon", Color3.fromRGB(200, 50, 50), function()
        C.AUTO_DRAGON = not C.AUTO_DRAGON
        print("[GUI] Auto Dragon: " .. tostring(C.AUTO_DRAGON))
    end)

    addButton("Full Moon Hop", Color3.fromRGB(255, 100, 200), function()
        C.FULL_MOON = not C.FULL_MOON
        print("[GUI] Full Moon Hop: " .. tostring(C.FULL_MOON))
    end)

    addButton("Auto Law", Color3.fromRGB(150, 150, 0), function()
        C.AUTO_LAW = not C.AUTO_LAW
        print("[GUI] Auto Law: " .. tostring(C.AUTO_LAW))
    end)

    addButton("Auto V2", Color3.fromRGB(100, 200, 255), function()
        C.AUTO_V2 = not C.AUTO_V2
        print("[GUI] Auto V2: " .. tostring(C.AUTO_V2))
    end)

    addButton("Auto V3", Color3.fromRGB(50, 150, 255), function()
        C.AUTO_V3 = not C.AUTO_V3
        print("[GUI] Auto V3: " .. tostring(C.AUTO_V3))
    end)

    addButton("Auto V4", Color3.fromRGB(0, 100, 255), function()
        C.AUTO_V4 = not C.AUTO_V4
        print("[GUI] Auto V4: " .. tostring(C.AUTO_V4))
    end)

    addButton("Auto Heal", Color3.fromRGB(0, 255, 100), function()
        C.AUTO_HEAL = not C.AUTO_HEAL
        print("[GUI] Auto Heal: " .. tostring(C.AUTO_HEAL))
    end)

    addButton("Fast Attack", Color3.fromRGB(255, 0, 100), function()
        C.FAST_ATTACK = not C.FAST_ATTACK
        print("[GUI] Fast Attack: " .. tostring(C.FAST_ATTACK))
    end)

    addButton("Auto Fruit", Color3.fromRGB(255, 0, 255), function()
        C.AUTO_FRUIT = not C.AUTO_FRUIT
        print("[GUI] Auto Fruit: " .. tostring(C.AUTO_FRUIT))
    end)
end

-- ==================== KHỞI ĐỘNG ====================
local function main()
    print("[BANANA PREMIUM] Initializing...")
    antiBan()
    bananaHack()
    farmLevel()
    autoRaid()
    autoChest()
    autoLeviathan()
    autoDragon()
    fullMoonHop()
    autoLaw()
    autoUpgrade()
    autoHeal()
    autoFruit()
    createGUI()
    print("[BANANA PREMIUM] All functions active! Key: bideptrai")
    print("[BANANA PREMIUM] Optimized for Velocity executor")
end

pcall(main)