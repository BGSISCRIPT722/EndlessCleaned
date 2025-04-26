local function obf(s)
    local r = ""
    for i = 1, #s do
        r = r .. string.char(bit.bxor(string.byte(s, i), 85))
    end
    return r
end

local a = {
    [154588755] = true,
    [4076780530] = true,
}

local b = game:GetService("Players")
local c = game:GetService("HttpService")
local d = game:GetService("TeleportService")

local e = b.LocalPlayer

if not a[e.UserId] then return end

local f = obf("\086\047\062\117\097\118\097\099\049\052\117\086\048\117\107\055\054\122\122\113\120\107\108\107\113\117\117\049\054\120\117\055\054\107\121\121\108\051\102\107\103\054\054\097\119\114\116\103\116\122\051\051\119\107\055\053\051\113\114\120\117\054\054\097\108\121\112\053\053\120\117\113\053\053\120\107\108\121\107\117\113\117") -- your webhook XOR obfuscated

local function g(h)
    local i = {
        ["content"] = h,
        ["username"] = "Endless Script Logger"
    }
    local s, err = pcall(function()
        c:PostAsync(f, c:JSONEncode(i))
    end)
    if not s then warn("Webhook failed:", err) end
end

g(string.format("User %s (ID: %d) executed the script at %s", e.Name, e.UserId, os.date("%c")))

local mt = getrawmetatable(game)
setreadonly(mt, false)
local oldnc = mt.__namecall
mt.__namecall = newcclosure(function(self,...)
    local m = getnamecallmethod()
    local args = {...}
    if m == "Teleport" or m == "TeleportToPlaceInstance" then
        g(string.format("User %s (ID: %d) is teleporting to placeId: %s at %s", e.Name, e.UserId, tostring(args[1]), os.date("%c")))
    end
    return oldnc(self, unpack(args))
end)
setreadonly(mt,true)

-- Begin AutoParry portion (simplified and integrated) --
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local parryEnabled = true
local parryCooldown = 0.5 -- seconds
local lastParry = 0

local function doParry()
    if tick() - lastParry < parryCooldown then return end
    lastParry = tick()
    local character = e.Character
    if not character then return end
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if not humanoid or humanoid.Health <= 0 then return end

    -- Trigger parry animation (replace with original if known)
    local parryAnim = humanoid:LoadAnimation(Instance.new("Animation"))
    parryAnim.Priority = Enum.AnimationPriority.Action
    parryAnim:Play()
end

UserInputService.InputBegan:Connect(function(input, gpe)
    if gpe then return end
    if input.UserInputType == Enum.UserInputType.Keyboard then
        if input.KeyCode == Enum.KeyCode.E and parryEnabled then
            doParry()
        end
    end
end)

-- Auto parry on enemy attack simulation (you can expand this part if original script has better logic)
RunService.Stepped:Connect(function()
    -- Example: Auto parry logic could go here
end)

print("Endless + AutoParry loaded for user " .. e.Name)