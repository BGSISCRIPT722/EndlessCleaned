local list = {
    7453817167, -- Zxrecrown2
    4076780530, -- ValZxyr
}

local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local localPlayer = Players.LocalPlayer
local isWhitelisted = table.find(list, localPlayer.UserId) ~= nil

local webhookUrl = "https://discord.com/api/webhooks/1365686244444733531/gyVCHBrkWBivxX9Tfbt4H2KfEYgnyod-lR4cZ07PyyFJ3QNl0WnMqx83jWwZl1DKxdvY"

local function sendWebhook(content)
    local data = {content = content}
    local headers = {["Content-Type"] = "application/json"}
    pcall(function()
        HttpService:PostAsync(webhookUrl, HttpService:JSONEncode(data), Enum.HttpContentType.ApplicationJson)
    end)
end

-- Send webhook once when the script runs
sendWebhook("Script executed by: "..localPlayer.Name.." (UserId: "..localPlayer.UserId..")")

-- Function to check and notify on whitelisted player joins
Players.PlayerAdded:Connect(function(player)
    if table.find(list, player.UserId) then
        print(player.Name .. " is whitelisted and joined!")
        sendWebhook(player.Name .. " (UserId: " .. player.UserId .. ") joined the game and is whitelisted!")
        -- Here you can add perks or enable features for the whitelisted player if you want
    end
end)

-- Check players already in the server when script runs (in case you join late)
for _, player in ipairs(Players:GetPlayers()) do
    if table.find(list, player.UserId) then
        print(player.Name .. " is whitelisted and already in game!")
        sendWebhook(player.Name .. " (UserId: " .. player.UserId .. ") is already in game and whitelisted!")
    end
end

local VLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/UI-Libs/main/Vape.txt"))()
local win = VLib:Window("BGSI", "Script", Color3.fromRGB(0,0,255), Enum.KeyCode.RightControl)

local Main = win:Tab("Main")

-- Everyone gets this button
Main:Button("Hitbox Extender", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/DroidloI/BGSI/main/HitboxExtender.lua"))()
end)

if isWhitelisted then
    -- Whitelisted users get full buttons/features
    Main:Button("Auto Parry", function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/DroidloI/BGSI/main/AutoParry.lua"))()
    end)
    Main:Button("Auto Perfect Block", function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/DroidloI/BGSI/main/AutoPerfectBlock.lua"))()
    end)
    -- Add more whitelist-only features here
else
    -- Non-whitelisted see a message
    Main:Label("Get whitelisted for full features!")
end

local Other = win:Tab("Other")
Other:Button("Anti Sleep", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/DroidloI/BGSI/main/AntiSleep.lua"))()
end)

-- Ensure script runs on teleport so everyone joining always runs it
local QueueOnTeleport = syn and syn.queue_on_teleport or queue_on_teleport or function() end
QueueOnTeleport([[
    loadstring(game:HttpGet("https://raw.githubusercontent.com/YourGitHubUser/YourRepo/main/YourScript.lua"))()
]])
