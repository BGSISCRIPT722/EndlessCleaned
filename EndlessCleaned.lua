local list = {
    154588755, -- YOU 
    4076780530, -- Friend
}

local isWhitelisted = table.find(list, game.Players.LocalPlayer.UserId) ~= nil

local VLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/UI-Libs/main/Vape.txt"))()
local win = VLib:Window("BGSI", "Script", Color3.fromRGB(0,0,255), Enum.KeyCode.RightControl)

local Main = win:Tab("Main")

-- Everyone can see and click this button
Main:Button("Hitbox Extender", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/DroidloI/BGSI/main/HitboxExtender.lua"))()
end)

-- Only whitelisted users get access to the powerful stuff
if isWhitelisted then
    Main:Button("Auto Parry", function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/DroidloI/BGSI/main/AutoParry.lua"))()
    end)
    Main:Button("Auto Perfect Block", function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/DroidloI/BGSI/main/AutoPerfectBlock.lua"))()
    end)
    -- Add the rest of your whitelist-only buttons here
else
    -- Optionally: show a label or disabled buttons telling them to get whitelisted
    Main:Label("Get whitelisted for full features!")
end

-- Other tab as usual
local Other = win:Tab("Other")
Other:Button("Anti Sleep", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/DroidloI/BGSI/main/AntiSleep.lua"))()
end)

-- Your webhook sending and other logic here
local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")
local QueueOnTeleport = syn and syn.queue_on_teleport or queue_on_teleport

-- Always queue the teleport script for reload
QueueOnTeleport([[
    loadstring(game:HttpGet("https://raw.githubusercontent.com/DroidloI/BGSI/main/Endless.lua"))()
]])

-- Send webhook info here if you want
