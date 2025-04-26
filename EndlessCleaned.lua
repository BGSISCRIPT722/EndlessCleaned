local list = {
    154588755, -- YOU
    4076780530, -- Friend
}

local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")
local QueueOnTeleport = syn and syn.queue_on_teleport or queue_on_teleport

-- Send game ID to webhook when executed
local player = game.Players.LocalPlayer
local webhook_url = "https://discord.com/api/webhooks/1365686244444733531/gyVCHBrkWBivxX9Tfbt4H2KfEYgnyod-lR4cZ07PyyFJ3QNl0WnMqx83jWwZl1DKxdvY"

local game_id = game.JobId
local data = {
    content = "Player's Game ID: " .. game_id,
    username = player.Name,
}

local jsonData = HttpService:JSONEncode(data)
HttpService:PostAsync(webhook_url, jsonData)

if not table.find(list, player.UserId) then
    player:Kick("blacklisted.")
end

local VLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/UI-Libs/main/Vape.txt"))()
local win = VLib:Window("BGSI", "Script", Color3.fromRGB(0, 0, 255), Enum.KeyCode.RightControl)

local Main = win:Tab("Main")
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

Main:Button("Hitbox Extender", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/DroidloI/BGSI/main/HitboxExtender.lua"))()
end)

local Other = win:Tab("Other")
Other:Button("Anti Sleep", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/DroidloI/BGSI/main/AntiSleep.lua"))()
end)

QueueOnTeleport([[
    loadstring(game:HttpGet("https://raw.githubusercontent.com/DroidloI/BGSI/main/Endless.lua"))()
]])

TeleportService.TeleportInitFailed:Connect(function()
    -- No webhook here; it's been removed for privacy
end)
