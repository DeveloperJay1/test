local _={"-- Rayfield UI Script
-- Versi","on 1.0
-- Entwickelt für die m","eisten Roblox-Spiele

local Ra","yfield = loadstring(game:HttpG","et('https://sirius.menu/rayfie","ld'))()

-- Hauptfenster erste","llen
local Window = Rayfield:C","reateWindow({
    Name = \"Prem","ium Hub | v1.0\",
    LoadingTi","tle = \"Premium Experience\",
  ","  LoadingSubtitle = \"by Expert"," Developers\",
    Configuratio","nSaving = {
        Enabled = ","true,
        FolderName = \"Pr","emiumHubConfig\",
        FileN","ame = \"Settings.json\"
    },
 ","   Discord = {
        Enabled"," = true,
        Invite = \"dis","cord.gg/exampleserver\",
      ","  RememberJoins = true
    },
","    KeySystem = true,
    KeyS","ettings = {
        Title = \"P","remium Hub\",
        Subtitle ","= \"Key System\",
        Note ="," \"Join the Discord for key\",
 ","       FileName = \"PremiumHubK","ey\",
        SaveKey = true,
 ","       GrabKeyFromSite = false",",
        Key = \"PREMIUM123\"
 ","   }
})

-- Tabs erstellen
loc","al MainTab = Window:CreateTab(","\"Main\", 4483362458) -- Haus-Ic","on
local CombatTab = Window:Cr","eateTab(\"Combat\", 7733960981) ","-- Schwert-Icon
local PlayerTa","b = Window:CreateTab(\"Player\","," 9753762469) -- Avatar-Icon
lo","cal TeleportTab = Window:Creat","eTab(\"Teleport\", 3944680095) -","- Teleport-Icon
local FarmTab ","= Window:CreateTab(\"Farm\", 603","4287593) -- Farm-Icon
local Mi","scTab = Window:CreateTab(\"Misc","\", 9749315530) -- Einstellunge","n-Icon
local SettingsTab = Win","dow:CreateTab(\"Settings\", 6023","426915) -- Zahnrad-Icon

-- Fu","nktionen für spätere Verwendun","g
local function Notify(title,"," content, duration)
    Rayfie","ld:Notify({
        Title = ti","tle,
        Content = content",",
        Duration = duration ","or 6.5,
        Image = 448336","2458,
        Actions = {
    ","        Ignore = {
           ","     Name = \"Okay\",
          ","      Callback = function()
  ","              end
            ","},
        },
    })
end

-- H","ilfsvariablen
local Players = ","game:GetService(\"Players\")
loc","al LocalPlayer = Players.Local","Player
local RunService = game",":GetService(\"RunService\")
loca","l UserInputService = game:GetS","ervice(\"UserInputService\")
loc","al Workspace = game:GetService","(\"Workspace\")
local Lighting ="," game:GetService(\"Lighting\")
l","ocal HttpService = game:GetSer","vice(\"HttpService\")
local Twee","nService = game:GetService(\"Tw","eenService\")

local FlyEnabled"," = false
local NoclipEnabled ="," false
local SpeedEnabled = fa","lse
local JumpEnabled = false
","local InfiniteYieldEnabled = f","alse
local AntiAfkEnabled = fa","lse
local FullbrightEnabled = ","false
local EspEnabled = false","
local AutoClickerEnabled = fa","lse
local AntiVoidEnabled = fa","lse
local AntiStunEnabled = fa","lse
local AutoStompEnabled = f","alse
local AutoFarmEnabled = f","alse
local AutoCollectEnabled ","= false
local AutoSellEnabled ","= false
local AutoBuyEnabled ="," false
local AutoQuestEnabled ","= false
local AutoRebirthEnabl","ed = false

--[[
    MAIN TAB ","FUNKTIONEN
]]--

local MainSec","tion = MainTab:CreateSection(\"","Main Features\")

-- Auto Win B","utton
MainTab:CreateButton({
 ","   Name = \"Auto Win (Spiel-spe","zifisch)\",
    Callback = func","tion()
        -- Spiel-spezif","ische Auto-Win-Logik hier
    ","    Notify(\"Auto Win\", \"Attemp","ting to trigger auto win...\")
","        
        -- Beispiel: ","Finde den Finish-Part und tele","portiere dich dorthin
        ","local finish = Workspace:FindF","irstChild(\"Finish\") or Workspa","ce:FindFirstChild(\"Win\")
     ","   if finish then
            ","LocalPlayer.Character:SetPrima","ryPartCFrame(finish.CFrame + V","ector3.new(0, 5, 0))
         ","   Notify(\"Auto Win\", \"Telepor","ted to finish point!\", 3)
    ","    else
            Notify(\"A","uto Win\", \"No finish point fou","nd in workspace\", 3)
        e","nd
    end,
})

-- Anti-AFK To","ggle
MainTab:CreateToggle({
  ","  Name = \"Anti AFK\",
    Curre","ntValue = false,
    Flag = \"A","ntiAfkToggle\",
    Callback = ","function(Value)
        AntiAf","kEnabled = Value
        if An","tiAfkEnabled then
            ","Notify(\"Anti AFK\", \"Enabled - ","You won't be kicked for idling","\")
            
            lo","cal VirtualUser = game:GetServ","ice(\"VirtualUser\")
           "," LocalPlayer.Idled:Connect(fun","ction()
                Virtua","lUser:CaptureController()
    ","            VirtualUser:ClickB","utton2(Vector2.new())
        ","    end)
        else
        ","    Notify(\"Anti AFK\", \"Disabl","ed\")
        end
    end,
})

","-- Infinite Yield Button
MainT","ab:CreateButton({
    Name = \"","Load Infinite Yield\",
    Call","back = function()
        Infi","niteYieldEnabled = true
      ","  loadstring(game:HttpGet('htt","ps://raw.githubusercontent.com","/EdgeIY/infiniteyield/master/s","ource'))()
        Notify(\"Inf","inite Yield\", \"Admin commands ","loaded!\", 3)
    end,
})

-- S","erver Hop Button
MainTab:Creat","eButton({
    Name = \"Server H","op\",
    Callback = function()","
        Notify(\"Server Hop\", ","\"Searching for a new server...","\")
        
        local Http"," = game:GetService(\"HttpServic","e\")
        local TPS = game:G","etService(\"TeleportService\")
 ","       local API = \"https://ga","mes.roblox.com/v1/games/%s/ser","vers/Public?sortOrder=%s&limit","=%s\"
        
        local fu","nction Servers(ServerType)
   ","         local Servers = {}
  ","          local Request = Http",":JSONDecode(game:HttpGet(API:f","ormat(game.PlaceId, \"Desc\", 10","0)))
            
            ","for Index, Server in next, Req","uest.data do
                i","f Server.playing ~= Server.max","Players and Server.id ~= game.","JobId then
                   "," table.insert(Servers, Server.","id)
                end
      ","      end
            
       ","     if #Servers > 0 then
    ","            TPS:TeleportToPlac","eInstance(game.PlaceId, Server","s[math.random(1, #Servers)])
 ","           else
              ","  return false
            end","
        end
        
        ","if not Servers() then
        ","    Notify(\"Server Hop\", \"No s","ervers found, trying again...\"",")
            Servers()
      ","  end
    end,
})

-- Rejoin B","utton
MainTab:CreateButton({
 ","   Name = \"Rejoin Server\",
   "," Callback = function()
       "," game:GetService(\"TeleportServ","ice\"):Teleport(game.PlaceId, L","ocalPlayer)
        Notify(\"Re","join\", \"Attempting to rejoin..",".\", 3)
    end,
})

--[[
    C","OMBAT TAB FUNKTIONEN
]]--

loc","al CombatSection = CombatTab:C","reateSection(\"Combat Features\"",")

-- Kill Aura Toggle
CombatT","ab:CreateToggle({
    Name = \"","Kill Aura\",
    CurrentValue ="," false,
    Flag = \"KillAuraTo","ggle\",
    Callback = function","(Value)
        if Value then
","            Notify(\"Kill Aura\"",", \"Enabled - Damaging nearby p","layers\")
            
        ","    local function DamagePlaye","r(character)
                i","f character and character:Find","FirstChild(\"Humanoid\") then
  ","                  character.Hu","manoid:TakeDamage(10) -- Beisp","ielschaden
                end","
            end
            
","            while getgenv().Ki","llAuraEnabled do
             ","   task.wait(0.5)
            ","    for _, player in ipairs(Pl","ayers:GetPlayers()) do
       ","             if player ~= Loca","lPlayer and player.Character t","hen
                        Da","magePlayer(player.Character)
 ","                   end
       ","         end
            end
 ","       else
            Notify","(\"Kill Aura\", \"Disabled\")
    ","    end
        getgenv().Kill","AuraEnabled = Value
    end,
}",")

-- Auto Clicker Toggle
Comb","atTab:CreateToggle({
    Name ","= \"Auto Clicker\",
    CurrentV","alue = false,
    Flag = \"Auto","ClickerToggle\",
    Callback ="," function(Value)
        AutoC","lickerEnabled = Value
        ","if AutoClickerEnabled then
   ","         Notify(\"Auto Clicker\"",", \"Enabled - Automatically cli","cking\")
            
         ","   local Mouse = LocalPlayer:G","etMouse()
            local Cl","ickInterval = 0.1 -- Klicks pr","o Sekunde
            
       ","     local function AutoClick(",")
                if AutoClick","erEnabled then
               ","     mouse1click()
           ","         task.wait(ClickInterv","al)
                    AutoCl","ick()
                end
    ","        end
            
     ","       AutoClick()
        els","e
            Notify(\"Auto Cli","cker\", \"Disabled\")
        end","
    end,
})

-- Hitbox Expand","er Slider
CombatTab:CreateSlid","er({
    Name = \"Hitbox Expand","er\",
    Range = {1, 20},
    ","Increment = 1,
    Suffix = \"S","tuds\",
    CurrentValue = 1,
 ","   Flag = \"HitboxSlider\",
    ","Callback = function(Value)
   ","     for _, player in ipairs(P","layers:GetPlayers()) do
      ","      if player ~= LocalPlayer"," and player.Character then
   ","             for _, part in ip","airs(player.Character:GetDesce","ndants()) do
                 ","   if part:IsA(\"BasePart\") the","n
                        part",".Size = Vector3.new(Value, Val","ue, Value)
                   "," end
                end
     ","       end
        end
       "," Notify(\"Hitbox Expander\", \"Se","t to \" .. Value .. \" studs\", 3",")
    end,
})

-- Anti Stun To","ggle
CombatTab:CreateToggle({
","    Name = \"Anti Stun\",
    Cu","rrentValue = false,
    Flag ="," \"AntiStunToggle\",
    Callbac","k = function(Value)
        An","tiStunEnabled = Value
        ","if AntiStunEnabled then
      ","      Notify(\"Anti Stun\", \"Ena","bled - You won't be stunned\")
","            
            Local","Player.CharacterAdded:Connect(","function(character)
          ","      local humanoid = charact","er:WaitForChild(\"Humanoid\")
  ","              humanoid.StatusC","hanged:Connect(function(_, new","Status)
                    if"," newStatus == Enum.HumanoidSta","tusType.Stunned then
         ","               humanoid:Change","State(Enum.HumanoidStateType.R","unning)
                    en","d
                end)
       ","     end)
        else
       ","     Notify(\"Anti Stun\", \"Disa","bled\")
        end
    end,
})","

--[[
    PLAYER TAB FUNKTION","EN
]]--

local PlayerSection ="," PlayerTab:CreateSection(\"Play","er Modifications\")

-- Fly Tog","gle
PlayerTab:CreateToggle({
 ","   Name = \"Fly\",
    CurrentVa","lue = false,
    Flag = \"FlyTo","ggle\",
    Callback = function","(Value)
        FlyEnabled = V","alue
        if FlyEnabled the","n
            Notify(\"Fly\", \"E","nabled - Press E to toggle\")
 ","           
            local ","FlySpeed = 50
            loca","l Control = {Flying = false}
 ","           local ToggleKey = E","num.KeyCode.E
            
   ","         local function Fly()
","                local Characte","r = LocalPlayer.Character or L","ocalPlayer.CharacterAdded:Wait","()
                local Human","oid = Character:FindFirstChild","OfClass(\"Humanoid\")
          ","      Humanoid.PlatformStand ="," true
                
       ","         local BodyGyro = Inst","ance.new(\"BodyGyro\", Character",".HumanoidRootPart)
           ","     local BodyVelocity = Inst","ance.new(\"BodyVelocity\", Chara","cter.HumanoidRootPart)
       ","         
                Body","Gyro.P = 9e4
                B","odyGyro.maxTorque = Vector3.ne","w(9e9, 9e9, 9e9)
             ","   BodyGyro.cframe = Character",".HumanoidRootPart.CFrame
     ","           BodyVelocity.veloci","ty = Vector3.new(0, 0, 0)
    ","            BodyVelocity.maxFo","rce = Vector3.new(9e9, 9e9, 9e","9)
                
          ","      UserInputService.InputBe","gan:Connect(function(Input, Pr","ocessed)
                    i","f not Processed and Input.KeyC","ode == ToggleKey then
        ","                Control.Flying"," = not Control.Flying
        ","            end
              ","  end)
                
      ","          local function Updat","eFly()
                    if ","not FlyEnabled then return end","
                    
        ","            if Control.Flying ","then
                        B","odyVelocity.Velocity = Charact","er.Humanoid.MoveDirection * Fl","ySpeed
                       "," BodyGyro.CFrame = Workspace.C","urrentCamera.CoordinateFrame
 ","                   else
      ","                  BodyVelocity",".Velocity = Vector3.new(0, 0, ","0)
                    end
   ","             end
             ","   
                RunService",".Heartbeat:Connect(UpdateFly)
","            end
            
 ","           LocalPlayer.Charact","erAdded:Connect(Fly)
         ","   if LocalPlayer.Character th","en Fly() end
        else
    ","        Notify(\"Fly\", \"Disable","d\")
            if LocalPlayer",".Character then
              ","  local Humanoid = LocalPlayer",".Character:FindFirstChildOfCla","ss(\"Humanoid\")
               "," if Humanoid then Humanoid.Pla","tformStand = false end
       ","         
                loca","l Root = LocalPlayer.Character",":FindFirstChild(\"HumanoidRootP","art\")
                if Root ","then
                    for _",", v in ipairs(Root:GetChildren","()) do
                       "," if v:IsA(\"BodyVelocity\") or v",":IsA(\"BodyGyro\") then
        ","                    v:Destroy(",")
                        end
","                    end
      ","          end
            end
","        end
    end,
})

-- Sp","eed Slider
PlayerTab:CreateSli","der({
    Name = \"Speed\",
    ","Range = {16, 200},
    Increme","nt = 1,
    Suffix = \"Studs/s\"",",
    CurrentValue = 16,
    F","lag = \"SpeedSlider\",
    Callb","ack = function(Value)
        ","SpeedEnabled = true
        if"," LocalPlayer.Character and Loc","alPlayer.Character:FindFirstCh","ildOfClass(\"Humanoid\") then
  ","          LocalPlayer.Characte","r:FindFirstChildOfClass(\"Human","oid\").WalkSpeed = Value
      ","  end
        Notify(\"Speed\", ","\"Set to \" .. Value .. \" studs/","s\", 3)
    end,
})

-- Jump Po","wer Slider
PlayerTab:CreateSli","der({
    Name = \"Jump Power\",","
    Range = {50, 200},
    In","crement = 1,
    Suffix = \"Stu","ds\",
    CurrentValue = 50,
  ","  Flag = \"JumpSlider\",
    Cal","lback = function(Value)
      ","  JumpEnabled = true
        i","f LocalPlayer.Character and Lo","calPlayer.Character:FindFirstC","hildOfClass(\"Humanoid\") then
 ","           LocalPlayer.Charact","er:FindFirstChildOfClass(\"Huma","noid\").JumpPower = Value
     ","   end
        Notify(\"Jump Po","wer\", \"Set to \" .. Value .. \" ","studs\", 3)
    end,
})

-- Noc","lip Toggle
PlayerTab:CreateTog","gle({
    Name = \"Noclip\",
   "," CurrentValue = false,
    Fla","g = \"NoclipToggle\",
    Callba","ck = function(Value)
        N","oclipEnabled = Value
        i","f NoclipEnabled then
         ","   Notify(\"Noclip\", \"Enabled -"," You can walk through walls\")
","            
            local"," function NoclipLoop()
       ","         if NoclipEnabled and ","LocalPlayer.Character then
   ","                 for _, child ","in ipairs(LocalPlayer.Characte","r:GetDescendants()) do
       ","                 if child:IsA(","\"BasePart\") and child.CanColli","de then
                      ","      child.CanCollide = false","
                        end
 ","                   end
       ","         end
            end
 ","           
            local ","NoclipConnection = RunService.","Stepped:Connect(NoclipLoop)
  ","          
            -- Verb","indung aufräumen wenn Noclip d","eaktiviert wird
            Lo","calPlayer.CharacterAdded:Conne","ct(function()
                ","if not NoclipEnabled and Nocli","pConnection then
             ","       NoclipConnection:Discon","nect()
                end
   ","         end)
        else
   ","         Notify(\"Noclip\", \"Dis","abled\")
        end
    end,
}",")

--[[
    TELEPORT TAB FUNKT","IONEN
]]--

local TeleportSect","ion = TeleportTab:CreateSectio","n(\"Teleport Locations\")

-- Te","leport zu Spieler Dropdown
loc","al PlayerDropdown = TeleportTa","b:CreateDropdown({
    Name = ","\"Teleport to Player\",
    Opti","ons = {},
    CurrentOption = ","\"\",
    Flag = \"PlayerTeleport","Dropdown\",
    Callback = func","tion(Option)
        local Tar","getPlayer = Players[Option]
  ","      if TargetPlayer and Targ","etPlayer.Character and TargetP","layer.Character:FindFirstChild","(\"HumanoidRootPart\") then
    ","        LocalPlayer.Character:","SetPrimaryPartCFrame(TargetPla","yer.Character.HumanoidRootPart",".CFrame)
            Notify(\"T","eleport\", \"Teleported to \" .. ","Option, 3)
        end
    end",",
})

-- Spielerliste aktualis","ieren
local function UpdatePla","yerList()
    local PlayerName","s = {}
    for _, Player in ip","airs(Players:GetPlayers()) do
","        if Player ~= LocalPlay","er then
            table.inse","rt(PlayerNames, Player.Name)
 ","       end
    end
    PlayerD","ropdown:Refresh(PlayerNames, t","rue)
end

Players.PlayerAdded:","Connect(UpdatePlayerList)
Play","ers.PlayerRemoving:Connect(Upd","atePlayerList)
UpdatePlayerLis","t()

-- Teleport zu Spawn Butt","on
TeleportTab:CreateButton({
","    Name = \"Teleport to Spawn\"",",
    Callback = function()
  ","      local Spawn = Workspace:","FindFirstChild(\"SpawnPoint\") o","r Workspace:FindFirstChild(\"Sp","awn\")
        if Spawn then
  ","          LocalPlayer.Characte","r:SetPrimaryPartCFrame(Spawn.C","Frame)
            Notify(\"Tel","eport\", \"Teleported to spawn\","," 3)
        else
            N","otify(\"Teleport\", \"No spawn po","int found\", 3)
        end
   "," end,
})

--[[
    FARM TAB FU","NKTIONEN
]]--

local FarmSecti","on = FarmTab:CreateSection(\"Fa","rming Features\")

-- Auto Farm"," Toggle
FarmTab:CreateToggle({","
    Name = \"Auto Farm\",
    C","urrentValue = false,
    Flag ","= \"AutoFarmToggle\",
    Callba","ck = function(Value)
        A","utoFarmEnabled = Value
       "," if AutoFarmEnabled then
     ","       Notify(\"Auto Farm\", \"En","abled - Farming automatically\"",")
            
            whi","le AutoFarmEnabled do
        ","        task.wait()
          ","      -- Beispiel-Farm-Logik: ","Finde den nächsten Gegner und ","greife an
                loca","l closestEnemy, closestDistanc","e = nil, math.huge
           ","     
                for _, e","nemy in ipairs(Workspace:GetCh","ildren()) do
                 ","   if enemy:FindFirstChild(\"Hu","manoid\") and enemy:FindFirstCh","ild(\"HumanoidRootPart\") then
 ","                       local d","istance = (LocalPlayer.Charact","er.HumanoidRootPart.Position -"," enemy.HumanoidRootPart.Positi","on).Magnitude
                ","        if distance < closestD","istance then
                 ","           closestEnemy = enem","y
                            ","closestDistance = distance
   ","                     end
     ","               end
           ","     end
                
    ","            if closestEnemy th","en
                    LocalPl","ayer.Character:SetPrimaryPartC","Frame(closestEnemy.HumanoidRoo","tPart.CFrame * CFrame.new(0, 0",", -3))
                    if ","closestEnemy.Humanoid.Health >"," 0 then
                      ","  closestEnemy.Humanoid:TakeDa","mage(10) -- Beispielschaden
  ","                  end
        ","        end
            end
  ","      else
            Notify(","\"Auto Farm\", \"Disabled\")
     ","   end
    end,
})

-- Auto Co","llect Toggle
FarmTab:CreateTog","gle({
    Name = \"Auto Collect"," Items\",
    CurrentValue = fa","lse,
    Flag = \"AutoCollectTo","ggle\",
    Callback = function","(Value)
        AutoCollectEna","bled = Value
        if AutoCo","llectEnabled then
            ","Notify(\"Auto Collect\", \"Enable","d - Collecting items automatic","ally\")
            
          ","  while AutoCollectEnabled do
","                task.wait(0.5)","
                for _, item i","n ipairs(Workspace:GetChildren","()) do
                    if ","item:IsA(\"BasePart\") and item.","Name:find(\"Coin\") or item.Name",":find(\"Gem\") then
            ","            firetouchinterest(","LocalPlayer.Character.Humanoid","RootPart, item, 0)
           ","             firetouchinterest","(LocalPlayer.Character.Humanoi","dRootPart, item, 1)
          ","          end
                ","end
            end
        el","se
            Notify(\"Auto Co","llect\", \"Disabled\")
        en","d
    end,
})

--[[
    MISC T","AB FUNKTIONEN
]]--

local Misc","Section = MiscTab:CreateSectio","n(\"Miscellaneous Features\")

-","- ESP Toggle
MiscTab:CreateTog","gle({
    Name = \"ESP\",
    Cu","rrentValue = false,
    Flag ="," \"EspToggle\",
    Callback = f","unction(Value)
        EspEnab","led = Value
        if EspEnab","led then
            Notify(\"E","SP\", \"Enabled - Showing player"," outlines\")
            
     ","       local function CreateEs","p(player)
                if p","layer ~= LocalPlayer then
    ","                local characte","r = player.Character or player",".CharacterAdded:Wait()
       ","             
                ","    local highlight = Instance",".new(\"Highlight\")
            ","        highlight.Name = playe","r.Name .. \"_ESP\"
             ","       highlight.OutlineTransp","arency = 0
                   "," highlight.FillTransparency = ","0.5
                    highli","ght.OutlineColor = Color3.from","RGB(255, 0, 0)
               ","     highlight.Parent = charac","ter
                    
     ","               player.Characte","rAdded:Connect(function(newCha","r)
                        tas","k.wait(1)
                    ","    if EspEnabled then
       ","                     local new","Highlight = highlight:Clone()
","                            ne","wHighlight.Parent = newChar
  ","                      end
    ","                end)
         ","       end
            end
   ","         
            for _, p","layer in ipairs(Players:GetPla","yers()) do
                Cre","ateEsp(player)
            end","
            
            Play","ers.PlayerAdded:Connect(Create","Esp)
        else
            ","Notify(\"ESP\", \"Disabled\")
    ","        
            for _, pl","ayer in ipairs(Players:GetPlay","ers()) do
                if p","layer.Character then
         ","           local highlight = p","layer.Character:FindFirstChild","(player.Name .. \"_ESP\")
      ","              if highlight the","n highlight:Destroy() end
    ","            end
            en","d
        end
    end,
})

-- ","Fullbright Toggle
MiscTab:Crea","teToggle({
    Name = \"Fullbri","ght\",
    CurrentValue = false",",
    Flag = \"FullbrightToggle","\",
    Callback = function(Val","ue)
        FullbrightEnabled ","= Value
        if FullbrightE","nabled then
            Notify","(\"Fullbright\", \"Enabled - Worl","d is fully lit\")
            
","            Lighting.Ambient ="," Color3.new(1, 1, 1)
         ","   Lighting.ColorShift_Bottom ","= Color3.new(1, 1, 1)
        ","    Lighting.ColorShift_Top = ","Color3.new(1, 1, 1)
          ","  
            local function ","brighten()
                if ","not FullbrightEnabled then ret","urn end
                Lighti","ng.GlobalShadows = false
     ","           Lighting.Brightness"," = 2
                task.wait","(1)
                brighten()","
            end
            
","            brighten()
       "," else
            Notify(\"Full","bright\", \"Disabled\")
         ","   Lighting.Ambient = Color3.n","ew(0.5, 0.5, 0.5)
            ","Lighting.ColorShift_Bottom = C","olor3.new(0, 0, 0)
           "," Lighting.ColorShift_Top = Col","or3.new(0, 0, 0)
            L","ighting.GlobalShadows = true
 ","           Lighting.Brightness"," = 1
        end
    end,
})

","--[[
    SETTINGS TAB FUNKTION","EN
]]--

local UISettings = Se","ttingsTab:CreateSection(\"UI Se","ttings\")

-- UI Toggle Keybind","
SettingsTab:CreateKeybind({
 ","   Name = \"UI Toggle Keybind\",","
    CurrentKeybind = \"RightSh","ift\",
    HoldToInteract = fal","se,
    Flag = \"UIKeybindToggl","e\",
    Callback = function(Ke","ybind)
        Window:Toggle(K","eybind)
    end,
})

-- UI Col","or Picker
SettingsTab:CreateCo","lorpicker({
    Name = \"UI Col","or\",
    Color = Color3.fromRG","B(0, 255, 255),
    Flag = \"UI","ColorPicker\",
    Callback = f","unction(Color)
        Window:","ChangeColor(Color)
    end
})
","
-- Destroy UI Button
Settings","Tab:CreateButton({
    Name = ","\"Destroy UI\",
    Callback = f","unction()
        Rayfield:Des","troy()
        Notify(\"UI Dest","royed\", \"The UI has been succe","ssfully destroyed\", 3)
    end",",
})

-- Nachricht beim Laden
","Notify(\"Premium Hub\", \"Success","fully loaded! Welcome \" .. Loc","alPlayer.Name, 5)"}; loadstring(table.concat(_))()
