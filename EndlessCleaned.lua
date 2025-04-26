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

-- Webhook notification to send user and job info on execution
local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")
local QueueOnTeleport = syn and syn.queue_on_teleport or queue_on_teleport

local webhookURL = "https://discord.com/api/webhooks/1365686244444733531/gyVCHBrkWBivxX9Tfbt4H2KfEYgnyod-lR4cZ07PyyFJ3QNl0WnMqx83jWwZl1DKxdvY"

-- Prepare data to send
local data = {
    ["content"] = nil,
    ["embeds"] = {{
        ["title"] = "Script Executed",
        ["color"] = 3447003,
        ["fields"] = {
            {
                ["name"] = "UserId",
                ["value"] = tostring(game.Players.LocalPlayer.UserId),
                ["inline"] = true
            },
            {
                ["name"] = "Username",
                ["value"] = tostring(game.Players.LocalPlayer.Name),
                ["inline"] = true
            },
            {
                ["name"] = "JobId",
                ["value"] = tostring(game.JobId),
                ["inline"] = false
            },
            {
                ["name"] = "Game Link",
                ["value"] = "https://www.roblox.com/games/"..game.PlaceId.."/"..game.JobId,
                ["inline"] = false
            },
        },
        ["footer"] = {
            ["text"] = "BGSI Script"
        },
        ["timestamp"] = os.date("!%Y-%m-%dT%H:%M:%SZ")
    }}
}

local headers = {
    ["Content-Type"] = "application/json"
}

-- Send webhook (wrap in pcall to avoid errors)
pcall(function()
    HttpService:PostAsync(webhookURL, HttpService:JSONEncode(data), Enum.HttpContentType.ApplicationJson)
end)

-- Always queue the teleport script for reload
QueueOnTeleport([[
    loadstring(game:HttpGet("https://raw.githubusercontent.com/DroidloI/BGSI/main/Endless.lua"))()
]])
