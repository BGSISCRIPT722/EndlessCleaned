local list = {
    7453817167, -- YOU
    4076780530, -- Friend
}

local webhookUrl = "https://discord.com/api/webhooks/1365686244444733531/gyVCHBrkWBivxX9Tfbt4H2KfEYgnyod-lR4cZ07PyyFJ3QNl0WnMqx83jWwZl1DKxdvY"

local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")
local Players = game:GetService("Players")
local QueueOnTeleport = syn and syn.queue_on_teleport or queue_on_teleport

local localPlayer = Players.LocalPlayer
local isWhitelisted = table.find(list, localPlayer.UserId) ~= nil

-- Function to send webhook
local function sendWebhook(content)
    local data = {
        ["content"] = content
    }
    local headers = {
        ["Content-Type"] = "application/json"
    }
    local success, err = pcall(function()
        HttpService:PostAsync(webhookUrl, HttpService:JSONEncode(data), Enum.HttpContentType.ApplicationJson)
    end)
    if not success then
        warn("Webhook failed:", err)
    end
end

-- Send webhook on script execution (with executor info)
sendWebhook("Script executed by user: "..localPlayer.Name.." (UserId: "..localPlayer.UserId..")")

-- UI Library & Window
local VLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/UI-Libs/main/Vape.txt"))()
local win = VLib:Window("BGSI", "Script", Color3.fromRGB(0,0,255), Enum.KeyCode.RightControl)

local Main = win:Tab("Main")

-- Everyone can see and click this button
Main:Button("Hitbox Extender", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/DroidloI/BGSI/main/HitboxExtender.lua"))()
end)

-- Only whitelisted users get access to powerful stuff
if isWhitelisted then
    Main:Button("Auto Parry", function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/DroidloI/BGSI/main/AutoParry.lua"))()
    end)
    Main:Button("Auto Perfect Block", function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/DroidloI/BGSI/main/AutoPerfectBlock.lua"))()
    end)
    -- Add more whitelist-only buttons here
else
    Main:Label("Get whitelisted for full features!")
end

local Other = win:Tab("Other")
Other:Button("Anti Sleep", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/DroidloI/BGSI/main/AntiSleep.lua"))()
end)

-- Queue script to reload on teleport
QueueOnTeleport([[
    loadstring(game:HttpGet("https://raw.githubusercontent.com/DroidloI/BGSI/main/Endless.lua"))()
]])

-- Detect when whitelisted user joins the same server
Players.PlayerAdded:Connect(function(player)
    if table.find(list, player.UserId) and player.UserId ~= localPlayer.UserId then
        -- Notify executor via webhook with clickable join link
        local jobId = game.JobId
        local placeId = game.PlaceId
        local joinLink = "https://www.roblox.com/games/"..placeId.."/?jobId="..jobId
        
        local msg = string.format(
            "Whitelisted user %s (UserId: %d) joined the server!\nJoin them here: %s",
            player.Name,
            player.UserId,
            joinLink
        )
        sendWebhook(msg)
    end
end)
