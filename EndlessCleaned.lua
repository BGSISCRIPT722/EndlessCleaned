local list = {
    154588755, -- Zxrecrown2
    4076780530, -- ValZxyr
}

local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local localPlayer = Players.LocalPlayer
local isWhitelisted = table.find(list, localPlayer.UserId) ~= nil

local webhookUrl = "https://discord.com/api/webhooks/1365686244444733531/gyVCHBrkWBivxX9Tfbt4H2KfEYgnyod-lR4cZ07PyyFJ3QNl0WnMqx83jWwZl1DKxdvY"

if syn and syn.request then
    syn.request({
        Url = webhookUrl,
        Method = "POST",
        Headers = {["Content-Type"] = "application/json"},
        Body = HttpService:JSONEncode({content = "Webhook test via syn.request"})
    })
    print("Webhook sent with syn.request")
else
    print("syn.request not available, using PostAsync fallback")
    sendWebhook("Webhook test via PostAsync")
end



sendWebhook("Script executed by: "..localPlayer.Name.." (UserId: "..localPlayer.UserId..") | Whitelisted: "..tostring(isWhitelisted))

local VLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/UI-Libs/main/Vape.txt"))()
local win = VLib:Window("BGSI", "Script", Color3.fromRGB(0,0,255), Enum.KeyCode.RightControl)

local Main = win:Tab("Main")

-- Everyone can access this
Main:Button("Hitbox Extender", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/DroidloI/BGSI/main/HitboxExtender.lua"))()
end)

if isWhitelisted then
    -- Whitelisted get full features/buttons
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
    -- Non-whitelisted see this label only
    Main:Label("Get whitelisted for full features!")
end

local Other = win:Tab("Other")

Other:Button("Anti Sleep", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/DroidloI/BGSI/main/AntiSleep.lua"))()
end)

-- Setup queue on teleport to reload this script automatically
local QueueOnTeleport = syn and syn.queue_on_teleport or queue_on_teleport or function() end
QueueOnTeleport([[
    loadstring(game:HttpGet("https://raw.githubusercontent.com/DroidloI/BGSI/refs/heads/main/Endless.lua"))()
]])
