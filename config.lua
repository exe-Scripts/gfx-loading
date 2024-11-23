
-- PLEASE DONT FORGET TO CHANGE THE SERVERIP IN THE SCRIPT.JS FILE
-- SCRIPT WILL NOT BE WORKING OTHERWISE
--[[   /$$    /$$$$$$   /$$$$$$   /$$$$$$        /$$       /$$$$$$$$  /$$$$$$  /$$   /$$  /$$$$$$ 
     /$$$$   /$$__  $$ /$$$_  $$ /$$__  $$      | $$      | $$_____/ /$$__  $$| $$  /$$/ /$$__  $$
    |_  $$  | $$  \ $$| $$$$\ $$| $$  \ $$      | $$      | $$      | $$  \ $$| $$ /$$/ | $$  \__/
      | $$  |  $$$$$$$| $$ $$ $$|  $$$$$$$      | $$      | $$$$$   | $$$$$$$$| $$$$$/  |  $$$$$$     
      | $$   \____  $$| $$\ $$$$ \____  $$      | $$      | $$__/   | $$__  $$| $$  $$   \____  $$
      | $$   /$$  \ $$| $$ \ $$$ /$$  \ $$      | $$      | $$      | $$  | $$| $$\  $$  /$$  \ $$
     /$$$$$$|  $$$$$$/|  $$$$$$/|  $$$$$$/      | $$$$$$$$| $$$$$$$$| $$  | $$| $$ \  $$|  $$$$$$/
     |______/ \______/  \______/  \______/       |________/|________/|__/  |__/|__/  \__/ \______/ 
																							 
 https://discord.gg/aq7wjNZWkX  & https://discord.gg/1909leaks ]]
Config = {
    SteamAPIKey = GetConvar("steam_webApiKey", ""),
    RPName = {
        enabled = false,
        framework = "newesx", -- esx or qb or newesx or newqb
    },
    Tracks = {
        {
            image = "https://i1.sndcdn.com/artworks-zTkRgI2ltsmt-0-t500x500.jpg", 
            name = "WASTE", 
            singer = "KXLLSWXTCH", 
            file = "assets/tracks/music.mp3"
        },
        {
            image = "https://i1.sndcdn.com/artworks-000295836096-q26mx1-t500x500.jpg", 
            name = "Space Song", 
            singer = "Beach House", 
            file = "assets/tracks/music2.mp3"
        },
        {
            image = "https://i1.sndcdn.com/artworks-pkUF8ryhpshcyjXD-xTJoJg-t500x500.jpg", 
            name = "Where Is My Mind", 
            singer = "Pixies", 
            file = "assets/tracks/music3.mp3"
        },

    },
    ServerInfo = {
        ServerName = "GFX Loading Screen",
        ServerImage = "assets/logo.png",
        smallTitle = "Deatils Here",
        serverDescription = "This is a description",
    },
    Updates = {
        [1] = {
            title = "New Update",
            message = "The distance players can join can be set via config. The duration of the narrator in the game can be set via config. The score that teams need to reach to win can be set via config. The prize to be given to the winning team members can be set via config as money or goods",
            date = "01.01.2024",
            publishedBy = "fizzfau",
            publishedByImage = "assets/logo.png",
            image = "assets/logo.png",
        }
    },
    Keys = {
        ["ESC"] = {
            title = "Pause Menu",
            description = "Press ESC to open the pause menu",
        },
        ["F2"] = {
            title = "INVENTORY",
            description = "Press F2 to open the inventory", 
        },
        ["F1"] = {
            title = "PHONE",
            description = "Press F1 to open the phone", 
        },
        ["X"] = {
            title = "HANDS UP/DOWN",
            description = "Press X to put your hands up or down", 
        },
    
    },
--[[   /$$    /$$$$$$   /$$$$$$   /$$$$$$        /$$       /$$$$$$$$  /$$$$$$  /$$   /$$  /$$$$$$ 
     /$$$$   /$$__  $$ /$$$_  $$ /$$__  $$      | $$      | $$_____/ /$$__  $$| $$  /$$/ /$$__  $$
    |_  $$  | $$  \ $$| $$$$\ $$| $$  \ $$      | $$      | $$      | $$  \ $$| $$ /$$/ | $$  \__/
      | $$  |  $$$$$$$| $$ $$ $$|  $$$$$$$      | $$      | $$$$$   | $$$$$$$$| $$$$$/  |  $$$$$$     
      | $$   \____  $$| $$\ $$$$ \____  $$      | $$      | $$__/   | $$__  $$| $$  $$   \____  $$
      | $$   /$$  \ $$| $$ \ $$$ /$$  \ $$      | $$      | $$      | $$  | $$| $$\  $$  /$$  \ $$
     /$$$$$$|  $$$$$$/|  $$$$$$/|  $$$$$$/      | $$$$$$$$| $$$$$$$$| $$  | $$| $$ \  $$|  $$$$$$/
     |______/ \______/  \______/  \______/       |________/|________/|__/  |__/|__/  \__/ \______/ 
																							 
 https://discord.gg/aq7wjNZWkX  & https://discord.gg/1909leaks ]]    
    SocialMedia = {
        [1] = {
            image = "assets/inst-icon.png",
            link = "instagram.com/",
        },
        [2] = {
            image = "assets/x-icon.png",
            link = "x.com/",
        },
        [3] = {
            image = "assets/site-icon.png",
            link = "store.",
        },
        [4] = {
            image = "assets/discord-icon.png",
            link = " https://discord.gg/aq7wjNZWkX",
        },
    }
}

if Config.RPName.enabled then
    if Config.RPName.framework == "esx" then
        ESX = nil
        Citizen.CreateThread(function()
            while ESX == nil do
                TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
                Citizen.Wait(0)
            end
        end)
    elseif Config.RPName.framework == "qb" then
        QBCore = nil
        Citizen.CreateThread(function()
            while QBCore == nil do
                TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)
                Citizen.Wait(0)
            end
        end)
    elseif Config.RPName.framework == "newesx" then
        ESX = exports['es_extended']:getSharedObject()
    elseif Config.RPName.framework == "newqb" then
        QBCore = exports['qb-core']:GetCoreObject()
    end
end

function GetName(source)
    if Config.RPName.enabled then
        if Config.RPName.framework == "esx" then
            local xPlayer = ESX.GetPlayerFromId(source)
            if not xPlayer then return GetPlayerName(source) end
            return xPlayer.getName()
        elseif Config.RPName.framework == "qb" then
            local xPlayer = QBCore.Functions.GetPlayer(source)
            if not xPlayer then return GetPlayerName(source) end
            return xPlayer.charinfo.firstname.. " " ..xPlayer.charinfo.lastname
        elseif Config.RPName.framework == "newesx" then
            local xPlayer = ESX.GetPlayerFromId(source)
            if not xPlayer then return GetPlayerName(source) end
            return xPlayer.getName()
        elseif Config.RPName.framework == "newqb" then
            local xPlayer = QBCore.Functions.GetPlayer(source)
            if not xPlayer then return GetPlayerName(source) end
            return xPlayer.PlayerData.charinfo.firstname.. " " ..xPlayer.PlayerData.charinfo.lastname
        end
    else
        return GetPlayerName(source)
    end
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