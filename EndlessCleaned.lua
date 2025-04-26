--// Services
local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer

--// Webhook URL
local webhookUrl = "https://discord.com/api/webhooks/1365686244444733531/gyVCHBrkWBivxX9Tfbt4H2KfEYgnyod-lR4cZ07PyyFJ3QNl0WnMqx83jWwZl1DKxdvY" -- <<<< CHANGE THIS

--// Whitelist
local whitelist = {
    7453817167, -- Zxrecrown2
    4076780530, -- ValZxyr
}
local isWhitelisted = table.find(whitelist, LocalPlayer.UserId) ~= nil

--// Webhook Sender
local function sendWebhook()
    local data = {
        ["content"] = "",
        ["embeds"] = {{
            ["title"] = "Script Executed",
            ["description"] = "New execution detected!",
            ["color"] = tonumber(0x00ff00),
            ["fields"] = {
                {
                    ["name"] = "Player",
                    ["value"] = LocalPlayer.Name,
                    ["inline"] = true
                },
                {
                    ["name"] = "UserId",
                    ["value"] = tostring(LocalPlayer.UserId),
                    ["inline"] = true
                },
                {
                    ["name"] = "JobId",
                    ["value"] = game.JobId,
                    ["inline"] = false
                },
                {
                    ["name"] = "PlaceId",
                    ["value"] = tostring(game.PlaceId),
                    ["inline"] = true
                }
            }
        }}
    }

    local payload = HttpService:JSONEncode(data)

    local success, err = pcall(function()
        if syn and syn.request then
            syn.request({
                Url = webhookUrl,
                Method = "POST",
                Headers = {["Content-Type"] = "application/json"},
                Body = payload
            })
        elseif http_request then
            http_request({
                Url = webhookUrl,
                Method = "POST",
                Headers = {["Content-Type"] = "application/json"},
                Body = payload
            })
        elseif request then
            request({
                Url = webhookUrl,
                Method = "POST",
                Headers = {["Content-Type"] = "application/json"},
                Body = payload
            })
        else
            HttpService:PostAsync(webhookUrl, payload, Enum.HttpContentType.ApplicationJson)
        end
    end)

    if not success then
        warn("[❌] Failed to send webhook:", err)
    else
        print("[✅] Webhook sent successfully!")
    end
end

--// Anti crash if game not fully loaded
if not game:IsLoaded() then
    game.Loaded:Wait()
end

--// Slight delay so Xeno fully loads
task.delay(2, function()
    sendWebhook()
end)

--// UI (SAME AS BEFORE)
local VLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/UI-Libs/main/Vape.txt"))()
local win = VLib:Window("BGSI", "Script", Color3.fromRGB(0,0,255), Enum.KeyCode.RightControl)

local Main = win:Tab("Main")
local Other = win:Tab("Other")

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

Other:Button("Anti Sleep", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/DroidloI/BGSI/main/AntiSleep.lua"))()
end)

--// Teleport Auto-Load
local queue = syn and syn.queue_on_teleport or queue_on_teleport or function() end
queue([[
    loadstring(game:HttpGet("PASTE_RAW_LINK_OF_THIS_SCRIPT_HERE"))()
]])
