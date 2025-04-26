-- Whitelist user IDs here
local whitelist = {
    7453817167, -- Zxrecrown2
    4076780530, -- ValZxyr
}

local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local localPlayer = Players.LocalPlayer
local isWhitelisted = table.find(whitelist, localPlayer.UserId) ~= nil

-- Your webhook URL here
local webhookUrl = "https://discord.com/api/webhooks/1363539478370848879/DrpYDIyh6e9tDoQsrTrmvtwe1Z6qJP5Hm5v7QeCNfLQ-UabIKjcKNgrlzRRciy-mBFZW"

-- Function to send webhook via syn.request or fallback to PostAsync
local function sendWebhook(content)
    local data = {
        content = content
    }
    local jsonData = HttpService:JSONEncode(data)

    if syn and syn.request then
        local success, err = pcall(function()
            syn.request({
                Url = webhookUrl,
                Method = "POST",
                Headers = { ["Content-Type"] = "application/json" },
                Body = jsonData,
            })
        end)
        if not success then
            warn("[Webhook] syn.request failed: " .. tostring(err))
        else
            print("[Webhook] Sent successfully with syn.request")
        end
    else
        local success, err = pcall(function()
            HttpService:PostAsync(webhookUrl, jsonData, Enum.HttpContentType.ApplicationJson)
        end)
        if not success then
            warn("[Webhook] HttpService:PostAsync failed: " .. tostring(err))
        else
            print("[Webhook] Sent successfully with PostAsync")
        end
    end
end

-- Send webhook on script execution
sendWebhook("Script executed by: " .. localPlayer.Name .. " (UserId: " .. localPlayer.UserId .. ") - Whitelisted: " .. tostring(isWhitelisted))

-- Load UI Lib and create window
local VLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/UI-Libs/main/Vape.txt"))()
local win = VLib:Window("BGSI", "Script", Color3.fromRGB(0, 0, 255), Enum.KeyCode.RightControl)

local Main = win:Tab("Main")

-- Button everyone can see/use
Main:Button("Hitbox Extender", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/DroidloI/BGSI/main/HitboxExtender.lua"))()
end)

-- Whitelist-only buttons
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

-- Queue the script on teleport to auto-run
local QueueOnTeleport = syn and syn.queue_on_teleport or queue_on_teleport or function() end
QueueOnTeleport([[
    loadstring(game:HttpGet("https://raw.githubusercontent.com/DroidloI/BGSI/main/Endless.lua"))()
]])

print("Script loaded. Whitelisted:", isWhitelisted)
