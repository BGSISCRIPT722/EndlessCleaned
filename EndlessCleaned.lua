local list = {
    154588755, -- Zxrecrown2
    4076780530, -- ValZxyr
}

local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local localPlayer = Players.LocalPlayer
local isWhitelisted = table.find(list, localPlayer.UserId) ~= nil

local webhookUrl = "https://discord.com/api/webhooks/1365686244444733531/gyVCHBrkWBivxX9Tfbt4H2KfEYgnyod-lR4cZ07PyyFJ3QNl0WnMqx83jWwZl1DKxdvY"

local function sendWebhook(content)
    local data = {content = content}
    pcall(function()
        HttpService:PostAsync(webhookUrl, HttpService:JSONEncode(data), Enum.HttpContentType.ApplicationJson)
    end)
end

-- Notify when the script is executed by the local player
sendWebhook("Script executed by: "..localPlayer.Name.." (UserId: "..localPlayer.UserId..")")

-- Notify and log when a whitelisted player joins (including those already in the server)
Players.PlayerAdded:Connect(function(player)
    if table.find(list, player.UserId) then
        print(player.Name .. " is whitelisted and joined!")
        sendWebhook(player.Name .. " (UserId: " .. player.UserId .. ") joined and is whitelisted!")
    end
end)

for _, player in ipairs(Players:GetPlayers()) do
    if table.find(list, player.UserId) then
        print(player.Name .. " is whitelisted and already in game!")
        sendWebhook(player.Name .. " (UserId: " .. player.UserId .. ") is already in game and whitelisted!")
    end
end

local VLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/UI-Libs/main/Vape.txt"))()
local win = VLib:Window("BGSI", "Script", Color3.fromRGB(0,0,255), Enum.KeyCode.RightControl)

local Main = win:Tab("Main")

-- Available for everyone
Main:Button("Hitbox Extender", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/DroidloI/BGSI/main/HitboxExtender.lua"))()
end)

if isWhitelisted then
    -- Whitelisted exclusive features
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

local QueueOnTeleport = syn and syn.queue_on_teleport or queue_on_teleport or function() end
QueueOnTeleport([[
    loadstring(game:HttpGet("https://raw.githubusercontent.com/YourGitHubUser/YourRepo/main/YourScript.lua"))()
]])
