
local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

-- Hauptfenster erstellen
local Window = Rayfield:CreateWindow({
    Name = "Premium Hub | v1.0",
    LoadingTitle = "Premium Experience",
    LoadingSubtitle = "by Expert Developers",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "PremiumHubConfig",
        FileName = "Settings.json"
    },
    Discord = {
        Enabled = true,
        Invite = "discord.gg/exampleserver",
        RememberJoins = true
    },
    KeySystem = true,
    KeySettings = {
        Title = "Premium Hub",
        Subtitle = "Key System",
        Note = "Join the Discord for key",
        FileName = "PremiumHubKey",
        SaveKey = true,
        GrabKeyFromSite = false,
        Key = "PREMIUM123"
    }
})

-- Tabs erstellen
local MainTab = Window:CreateTab("Main", 4483362458) -- Haus-Icon
local CombatTab = Window:CreateTab("Combat", 7733960981) -- Schwert-Icon
local PlayerTab = Window:CreateTab("Player", 9753762469) -- Avatar-Icon
local TeleportTab = Window:CreateTab("Teleport", 3944680095) -- Teleport-Icon
local FarmTab = Window:CreateTab("Farm", 6034287593) -- Farm-Icon
local MiscTab = Window:CreateTab("Misc", 9749315530) -- Einstellungen-Icon
local SettingsTab = Window:CreateTab("Settings", 6023426915) -- Zahnrad-Icon

-- Funktionen für spätere Verwendung
local function Notify(title, content, duration)
    Rayfield:Notify({
        Title = title,
        Content = content,
        Duration = duration or 6.5,
        Image = 4483362458,
        Actions = {
            Ignore = {
                Name = "Okay",
                Callback = function()
                end
            },
        },
    })
end

-- Hilfsvariablen
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")
local HttpService = game:GetService("HttpService")
local TweenService = game:GetService("TweenService")

local FlyEnabled = false
local NoclipEnabled = false
local SpeedEnabled = false
local JumpEnabled = false
local InfiniteYieldEnabled = false
local AntiAfkEnabled = false
local FullbrightEnabled = false
local EspEnabled = false
local AutoClickerEnabled = false
local AntiVoidEnabled = false
local AntiStunEnabled = false
local AutoStompEnabled = false
local AutoFarmEnabled = false
local AutoCollectEnabled = false
local AutoSellEnabled = false
local AutoBuyEnabled = false
local AutoQuestEnabled = false
local AutoRebirthEnabled = false

--[[
    MAIN TAB FUNKTIONEN
]]--

local MainSection = MainTab:CreateSection("Main Features")

-- Auto Win Button
MainTab:CreateButton({
    Name = "Auto Win (Spiel-spezifisch)",
    Callback = function()
        -- Spiel-spezifische Auto-Win-Logik hier
        Notify("Auto Win", "Attempting to trigger auto win...")
        
        -- Beispiel: Finde den Finish-Part und teleportiere dich dorthin
        local finish = Workspace:FindFirstChild("Finish") or Workspace:FindFirstChild("Win")
        if finish then
            LocalPlayer.Character:SetPrimaryPartCFrame(finish.CFrame + Vector3.new(0, 5, 0))
            Notify("Auto Win", "Teleported to finish point!", 3)
        else
            Notify("Auto Win", "No finish point found in workspace", 3)
        end
    end,
})

-- Anti-AFK Toggle
MainTab:CreateToggle({
    Name = "Anti AFK",
    CurrentValue = false,
    Flag = "AntiAfkToggle",
    Callback = function(Value)
        AntiAfkEnabled = Value
        if AntiAfkEnabled then
            Notify("Anti AFK", "Enabled - You won't be kicked for idling")
            
            local VirtualUser = game:GetService("VirtualUser")
            LocalPlayer.Idled:Connect(function()
                VirtualUser:CaptureController()
                VirtualUser:ClickButton2(Vector2.new())
            end)
        else
            Notify("Anti AFK", "Disabled")
        end
    end,
})

-- Infinite Yield Button
MainTab:CreateButton({
    Name = "Load Infinite Yield",
    Callback = function()
        InfiniteYieldEnabled = true
        loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()
        Notify("Infinite Yield", "Admin commands loaded!", 3)
    end,
})

-- Server Hop Button
MainTab:CreateButton({
    Name = "Server Hop",
    Callback = function()
        Notify("Server Hop", "Searching for a new server...")
        
        local Http = game:GetService("HttpService")
        local TPS = game:GetService("TeleportService")
        local API = "https://games.roblox.com/v1/games/%s/servers/Public?sortOrder=%s&limit=%s"
        
        local function Servers(ServerType)
            local Servers = {}
            local Request = Http:JSONDecode(game:HttpGet(API:format(game.PlaceId, "Desc", 100)))
            
            for Index, Server in next, Request.data do
                if Server.playing ~= Server.maxPlayers and Server.id ~= game.JobId then
                    table.insert(Servers, Server.id)
                end
            end
            
            if #Servers > 0 then
                TPS:TeleportToPlaceInstance(game.PlaceId, Servers[math.random(1, #Servers)])
            else
                return false
            end
        end
        
        if not Servers() then
            Notify("Server Hop", "No servers found, trying again...")
            Servers()
        end
    end,
})

-- Rejoin Button
MainTab:CreateButton({
    Name = "Rejoin Server",
    Callback = function()
        game:GetService("TeleportService"):Teleport(game.PlaceId, LocalPlayer)
        Notify("Rejoin", "Attempting to rejoin...", 3)
    end,
})

--[[
    COMBAT TAB FUNKTIONEN
]]--

local CombatSection = CombatTab:CreateSection("Combat Features")

-- Kill Aura Toggle
CombatTab:CreateToggle({
    Name = "Kill Aura",
    CurrentValue = false,
    Flag = "KillAuraToggle",
    Callback = function(Value)
        if Value then
            Notify("Kill Aura", "Enabled - Damaging nearby players")
            
            local function DamagePlayer(character)
                if character and character:FindFirstChild("Humanoid") then
                    character.Humanoid:TakeDamage(10) -- Beispielschaden
                end
            end
            
            while getgenv().KillAuraEnabled do
                task.wait(0.5)
                for _, player in ipairs(Players:GetPlayers()) do
                    if player ~= LocalPlayer and player.Character then
                        DamagePlayer(player.Character)
                    end
                end
            end
        else
            Notify("Kill Aura", "Disabled")
        end
        getgenv().KillAuraEnabled = Value
    end,
})

-- Auto Clicker Toggle
CombatTab:CreateToggle({
    Name = "Auto Clicker",
    CurrentValue = false,
    Flag = "AutoClickerToggle",
    Callback = function(Value)
        AutoClickerEnabled = Value
        if AutoClickerEnabled then
            Notify("Auto Clicker", "Enabled - Automatically clicking")
            
            local Mouse = LocalPlayer:GetMouse()
            local ClickInterval = 0.1 -- Klicks pro Sekunde
            
            local function AutoClick()
                if AutoClickerEnabled then
                    mouse1click()
                    task.wait(ClickInterval)
                    AutoClick()
                end
            end
            
            AutoClick()
        else
            Notify("Auto Clicker", "Disabled")
        end
    end,
})

-- Hitbox Expander Slider
CombatTab:CreateSlider({
    Name = "Hitbox Expander",
    Range = {1, 20},
    Increment = 1,
    Suffix = "Studs",
    CurrentValue = 1,
    Flag = "HitboxSlider",
    Callback = function(Value)
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character then
                for _, part in ipairs(player.Character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.Size = Vector3.new(Value, Value, Value)
                    end
                end
            end
        end
        Notify("Hitbox Expander", "Set to " .. Value .. " studs", 3)
    end,
})

-- Anti Stun Toggle
CombatTab:CreateToggle({
    Name = "Anti Stun",
    CurrentValue = false,
    Flag = "AntiStunToggle",
    Callback = function(Value)
        AntiStunEnabled = Value
        if AntiStunEnabled then
            Notify("Anti Stun", "Enabled - You won't be stunned")
            
            LocalPlayer.CharacterAdded:Connect(function(character)
                local humanoid = character:WaitForChild("Humanoid")
                humanoid.StatusChanged:Connect(function(_, newStatus)
                    if newStatus == Enum.HumanoidStatusType.Stunned then
                        humanoid:ChangeState(Enum.HumanoidStateType.Running)
                    end
                end)
            end)
        else
            Notify("Anti Stun", "Disabled")
        end
    end,
})

--[[
    PLAYER TAB FUNKTIONEN
]]--

local PlayerSection = PlayerTab:CreateSection("Player Modifications")

-- Fly Toggle
PlayerTab:CreateToggle({
    Name = "Fly",
    CurrentValue = false,
    Flag = "FlyToggle",
    Callback = function(Value)
        FlyEnabled = Value
        if FlyEnabled then
            Notify("Fly", "Enabled - Press E to toggle")
            
            local FlySpeed = 50
            local Control = {Flying = false}
            local ToggleKey = Enum.KeyCode.E
            
            local function Fly()
                local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
                local Humanoid = Character:FindFirstChildOfClass("Humanoid")
                Humanoid.PlatformStand = true
                
                local BodyGyro = Instance.new("BodyGyro", Character.HumanoidRootPart)
                local BodyVelocity = Instance.new("BodyVelocity", Character.HumanoidRootPart)
                
                BodyGyro.P = 9e4
                BodyGyro.maxTorque = Vector3.new(9e9, 9e9, 9e9)
                BodyGyro.cframe = Character.HumanoidRootPart.CFrame
                BodyVelocity.velocity = Vector3.new(0, 0, 0)
                BodyVelocity.maxForce = Vector3.new(9e9, 9e9, 9e9)
                
                UserInputService.InputBegan:Connect(function(Input, Processed)
                    if not Processed and Input.KeyCode == ToggleKey then
                        Control.Flying = not Control.Flying
                    end
                end)
                
                local function UpdateFly()
                    if not FlyEnabled then return end
                    
                    if Control.Flying then
                        BodyVelocity.Velocity = Character.Humanoid.MoveDirection * FlySpeed
                        BodyGyro.CFrame = Workspace.CurrentCamera.CoordinateFrame
                    else
                        BodyVelocity.Velocity = Vector3.new(0, 0, 0)
                    end
                end
                
                RunService.Heartbeat:Connect(UpdateFly)
            end
            
            LocalPlayer.CharacterAdded:Connect(Fly)
            if LocalPlayer.Character then Fly() end
        else
            Notify("Fly", "Disabled")
            if LocalPlayer.Character then
                local Humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
                if Humanoid then Humanoid.PlatformStand = false end
                
                local Root = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                if Root then
                    for _, v in ipairs(Root:GetChildren()) do
                        if v:IsA("BodyVelocity") or v:IsA("BodyGyro") then
                            v:Destroy()
                        end
                    end
                end
            end
        end
    end,
})

-- Speed Slider
PlayerTab:CreateSlider({
    Name = "Speed",
    Range = {16, 200},
    Increment = 1,
    Suffix = "Studs/s",
    CurrentValue = 16,
    Flag = "SpeedSlider",
    Callback = function(Value)
        SpeedEnabled = true
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
            LocalPlayer.Character:FindFirstChildOfClass("Humanoid").WalkSpeed = Value
        end
        Notify("Speed", "Set to " .. Value .. " studs/s", 3)
    end,
})

-- Jump Power Slider
PlayerTab:CreateSlider({
    Name = "Jump Power",
    Range = {50, 200},
    Increment = 1,
    Suffix = "Studs",
    CurrentValue = 50,
    Flag = "JumpSlider",
    Callback = function(Value)
        JumpEnabled = true
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
            LocalPlayer.Character:FindFirstChildOfClass("Humanoid").JumpPower = Value
        end
        Notify("Jump Power", "Set to " .. Value .. " studs", 3)
    end,
})

-- Noclip Toggle
PlayerTab:CreateToggle({
    Name = "Noclip",
    CurrentValue = false,
    Flag = "NoclipToggle",
    Callback = function(Value)
        NoclipEnabled = Value
        if NoclipEnabled then
            Notify("Noclip", "Enabled - You can walk through walls")
            
            local function NoclipLoop()
                if NoclipEnabled and LocalPlayer.Character then
                    for _, child in ipairs(LocalPlayer.Character:GetDescendants()) do
                        if child:IsA("BasePart") and child.CanCollide then
                            child.CanCollide = false
                        end
                    end
                end
            end
            
            local NoclipConnection = RunService.Stepped:Connect(NoclipLoop)
            
            -- Verbindung aufräumen wenn Noclip deaktiviert wird
            LocalPlayer.CharacterAdded:Connect(function()
                if not NoclipEnabled and NoclipConnection then
                    NoclipConnection:Disconnect()
                end
            end)
        else
            Notify("Noclip", "Disabled")
        end
    end,
})

--[[
    TELEPORT TAB FUNKTIONEN
]]--

local TeleportSection = TeleportTab:CreateSection("Teleport Locations")

-- Teleport zu Spieler Dropdown
local PlayerDropdown = TeleportTab:CreateDropdown({
    Name = "Teleport to Player",
    Options = {},
    CurrentOption = "",
    Flag = "PlayerTeleportDropdown",
    Callback = function(Option)
        local TargetPlayer = Players[Option]
        if TargetPlayer and TargetPlayer.Character and TargetPlayer.Character:FindFirstChild("HumanoidRootPart") then
            LocalPlayer.Character:SetPrimaryPartCFrame(TargetPlayer.Character.HumanoidRootPart.CFrame)
            Notify("Teleport", "Teleported to " .. Option, 3)
        end
    end,
})

-- Spielerliste aktualisieren
local function UpdatePlayerList()
    local PlayerNames = {}
    for _, Player in ipairs(Players:GetPlayers()) do
        if Player ~= LocalPlayer then
            table.insert(PlayerNames, Player.Name)
        end
    end
    PlayerDropdown:Refresh(PlayerNames, true)
end

Players.PlayerAdded:Connect(UpdatePlayerList)
Players.PlayerRemoving:Connect(UpdatePlayerList)
UpdatePlayerList()

-- Teleport zu Spawn Button
TeleportTab:CreateButton({
    Name = "Teleport to Spawn",
    Callback = function()
        local Spawn = Workspace:FindFirstChild("SpawnPoint") or Workspace:FindFirstChild("Spawn")
        if Spawn then
            LocalPlayer.Character:SetPrimaryPartCFrame(Spawn.CFrame)
            Notify("Teleport", "Teleported to spawn", 3)
        else
            Notify("Teleport", "No spawn point found", 3)
        end
    end,
})

--[[
    FARM TAB FUNKTIONEN
]]--

local FarmSection = FarmTab:CreateSection("Farming Features")

-- Auto Farm Toggle
FarmTab:CreateToggle({
    Name = "Auto Farm",
    CurrentValue = false,
    Flag = "AutoFarmToggle",
    Callback = function(Value)
        AutoFarmEnabled = Value
        if AutoFarmEnabled then
            Notify("Auto Farm", "Enabled - Farming automatically")
            
            while AutoFarmEnabled do
                task.wait()
                -- Beispiel-Farm-Logik: Finde den nächsten Gegner und greife an
                local closestEnemy, closestDistance = nil, math.huge
                
                for _, enemy in ipairs(Workspace:GetChildren()) do
                    if enemy:FindFirstChild("Humanoid") and enemy:FindFirstChild("HumanoidRootPart") then
                        local distance = (LocalPlayer.Character.HumanoidRootPart.Position - enemy.HumanoidRootPart.Position).Magnitude
                        if distance < closestDistance then
                            closestEnemy = enemy
                            closestDistance = distance
                        end
                    end
                end
                
                if closestEnemy then
                    LocalPlayer.Character:SetPrimaryPartCFrame(closestEnemy.HumanoidRootPart.CFrame * CFrame.new(0, 0, -3))
                    if closestEnemy.Humanoid.Health > 0 then
                        closestEnemy.Humanoid:TakeDamage(10) -- Beispielschaden
                    end
                end
            end
        else
            Notify("Auto Farm", "Disabled")
        end
    end,
})

-- Auto Collect Toggle
FarmTab:CreateToggle({
    Name = "Auto Collect Items",
    CurrentValue = false,
    Flag = "AutoCollectToggle",
    Callback = function(Value)
        AutoCollectEnabled = Value
        if AutoCollectEnabled then
            Notify("Auto Collect", "Enabled - Collecting items automatically")
            
            while AutoCollectEnabled do
                task.wait(0.5)
                for _, item in ipairs(Workspace:GetChildren()) do
                    if item:IsA("BasePart") and item.Name:find("Coin") or item.Name:find("Gem") then
                        firetouchinterest(LocalPlayer.Character.HumanoidRootPart, item, 0)
                        firetouchinterest(LocalPlayer.Character.HumanoidRootPart, item, 1)
                    end
                end
            end
        else
            Notify("Auto Collect", "Disabled")
        end
    end,
})

--[[
    MISC TAB FUNKTIONEN
]]--

local MiscSection = MiscTab:CreateSection("Miscellaneous Features")

-- ESP Toggle
MiscTab:CreateToggle({
    Name = "ESP",
    CurrentValue = false,
    Flag = "EspToggle",
    Callback = function(Value)
        EspEnabled = Value
        if EspEnabled then
            Notify("ESP", "Enabled - Showing player outlines")
            
            local function CreateEsp(player)
                if player ~= LocalPlayer then
                    local character = player.Character or player.CharacterAdded:Wait()
                    
                    local highlight = Instance.new("Highlight")
                    highlight.Name = player.Name .. "_ESP"
                    highlight.OutlineTransparency = 0
                    highlight.FillTransparency = 0.5
                    highlight.OutlineColor = Color3.fromRGB(255, 0, 0)
                    highlight.Parent = character
                    
                    player.CharacterAdded:Connect(function(newChar)
                        task.wait(1)
                        if EspEnabled then
                            local newHighlight = highlight:Clone()
                            newHighlight.Parent = newChar
                        end
                    end)
                end
            end
            
            for _, player in ipairs(Players:GetPlayers()) do
                CreateEsp(player)
            end
            
            Players.PlayerAdded:Connect(CreateEsp)
        else
            Notify("ESP", "Disabled")
            
            for _, player in ipairs(Players:GetPlayers()) do
                if player.Character then
                    local highlight = player.Character:FindFirstChild(player.Name .. "_ESP")
                    if highlight then highlight:Destroy() end
                end
            end
        end
    end,
})

-- Fullbright Toggle
MiscTab:CreateToggle({
    Name = "Fullbright",
    CurrentValue = false,
    Flag = "FullbrightToggle",
    Callback = function(Value)
        FullbrightEnabled = Value
        if FullbrightEnabled then
            Notify("Fullbright", "Enabled - World is fully lit")
            
            Lighting.Ambient = Color3.new(1, 1, 1)
            Lighting.ColorShift_Bottom = Color3.new(1, 1, 1)
            Lighting.ColorShift_Top = Color3.new(1, 1, 1)
            
            local function brighten()
                if not FullbrightEnabled then return end
                Lighting.GlobalShadows = false
                Lighting.Brightness = 2
                task.wait(1)
                brighten()
            end
            
            brighten()
        else
            Notify("Fullbright", "Disabled")
            Lighting.Ambient = Color3.new(0.5, 0.5, 0.5)
            Lighting.ColorShift_Bottom = Color3.new(0, 0, 0)
            Lighting.ColorShift_Top = Color3.new(0, 0, 0)
            Lighting.GlobalShadows = true
            Lighting.Brightness = 1
        end
    end,
})

--[[
    SETTINGS TAB FUNKTIONEN
]]--

local UISettings = SettingsTab:CreateSection("UI Settings")

-- UI Toggle Keybind
SettingsTab:CreateKeybind({
    Name = "UI Toggle Keybind",
    CurrentKeybind = "RightShift",
    HoldToInteract = false,
    Flag = "UIKeybindToggle",
    Callback = function(Keybind)
        Window:Toggle(Keybind)
    end,
})

-- UI Color Picker
SettingsTab:CreateColorpicker({
    Name = "UI Color",
    Color = Color3.fromRGB(0, 255, 255),
    Flag = "UIColorPicker",
    Callback = function(Color)
        Window:ChangeColor(Color)
    end
})

-- Destroy UI Button
SettingsTab:CreateButton({
    Name = "Destroy UI",
    Callback = function()
        Rayfield:Destroy()
        Notify("UI Destroyed", "The UI has been successfully destroyed", 3)
    end,
})

-- Nachricht beim Laden
Notify("Premium Hub", "Successfully loaded! Welcome " .. LocalPlayer.Name, 5)
