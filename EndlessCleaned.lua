--// Services
local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local LocalPlayer = Players.LocalPlayer
local TeleportService = game:GetService("TeleportService")

--// Configs
local webhookUrl = "YOUR_WEBHOOK_URL_HERE"

local whitelist = {
    7453817167, -- Zxrecrown2
    4076780530, -- ValZxyr
}

local isWhitelisted = table.find(whitelist, LocalPlayer.UserId) ~= nil

--// Webhook Sender
local function sendWebhook()
    local payload = {
        ["embeds"] = {{
            ["title"] = "Script Executed",
            ["color"] = 65280, -- Green
            ["fields"] = {
                {["name"] = "Player", ["value"] = LocalPlayer.Name, ["inline"] = true},
                {["name"] = "UserId", ["value"] = tostring(LocalPlayer.UserId), ["inline"] = true},
                {["name"] = "JobId", ["value"] = game.JobId, ["inline"] = false},
            }
        }}
    }

    local headers = {
        ["Content-Type"] = "application/json"
    }

    local success, response = pcall(function()
        if syn and syn.request then
            return syn.request({
                Url = webhookUrl,
                Method = "POST",
                Headers = headers,
                Body = HttpService:JSONEncode(payload)
            })
        elseif http_request then
            return http_request({
                Url = webhookUrl,
                Method = "POST",
                Headers = headers,
                Body = HttpService:JSONEncode(payload)
            })
        elseif request then
            return request({
                Url = webhookUrl,
                Method = "POST",
                Headers = headers,
                Body = HttpService:JSONEncode(payload)
            })
        else
            HttpService:PostAsync(webhookUrl, HttpService:JSONEncode(payload), Enum.HttpContentType.ApplicationJson)
        end
    end)

    if success then
        print("[✅] Webhook sent successfully!")
    else
        warn("[❌] Failed to send webhook:", response)
    end
end

--// Call webhook once when script starts
sendWebhook()

--// Load UI Library
local VLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/UI-Libs/main/Vape.txt"))()
local win = VLib:Window("BGSI", "Script", Color3.fromRGB(0,0,255), Enum.KeyCode.RightControl)

--// Tabs
local Main = win:Tab("Main")
local Other = win:Tab("Other")

--// Buttons
Main:Button("Hitbox Extender", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/DroidloI/BGSI/main/HitboxExtender.lua"))()
end)

if isWhitelisted then
    -- Extra features for whitelisted users
    Main:Button("Auto Parry", function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/DroidloI/BGSI/main/AutoParry.lua"))()
    end)

    Main:Button("Auto Perfect Block", function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/DroidloI/BGSI/main/AutoPerfectBlock.lua"))()
    end)
else
    -- Message for non-whitelisted
    Main:Label("Get whitelisted for full features!")
end

Other:Button("Anti Sleep", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/DroidloI/BGSI/main/AntiSleep.lua"))()
end)

--// Teleport Hook (makes script auto-load on teleport)
local queue = syn and syn.queue_on_teleport or queue_on_teleport or function() end
queue([[
    loadstring(game:HttpGet("https://raw.githubusercontent.com/BGSISCRIPT722/EndlessCleaned/refs/heads/main/EndlessCleaned.lua"))()
]])

