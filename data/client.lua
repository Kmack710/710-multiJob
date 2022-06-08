-- Variables

local QBCore = nil
local job2label = "Unknown"

-- Grab core object

if Config.Core == 'new' then --new core
    QBCore = exports['qb-core']:GetCoreObject()
else --old core
    Citizen.CreateThread(function()
        while QBCore == nil do
            TriggerEvent("QBCore:GetObject", function(obj) QBCore = obj end)
            Citizen.Wait(10)
        end
    end)
end

-- Register keybind or command

if Cofnig.Open == "key" then
    RegisterKeyMapping('+changejob', 'Toggle MultiJob Menu', 'keyboard', Config.OpenKey)

    RegisterCommand('+changejob', function()
        TriggerEvent('710-multiJob:Client:OpenMenu')
    end)
else
    RegisterCommand(Config.Command, function()
        TriggerEvent('710-multiJob:Client:OpenMenu')
    end)
end

-- Events

if Config.usingQBmenu then 
    RegisterNetEvent('710-multiJob:Client:OpenMenu', function()
        QBCore.Functions.TriggerCallback('710-multiJob:Server:checkjob2', function(results)
            if not results then
                TriggerEvent("QBCore:Notify", "Error Fetching Job ", "error")
                job2label = "Unknown"
            else
                job2label = results
            end
        end)
        Wait(1000)
        local Player = QBCore.Functions.GetPlayerData()
        local citizenid = Player.citizenid
        local Menu = {
            {
                header = Config.MenuHeader,
                isMenuHeader = true
            },
            {
                header = "Current Job: "..Player.job.label,
                txt = "Click to change to "..job2label,
                params = {
                    isServer = true,
                    event = "710-multiJob:Server:ChangeJob",
                    args = {
                        citizenid = citizenid
                    }
                }
            },
        }
        exports['qb-menu']:openMenu(Menu)
    end)
end

if Config.usingRenzuContext then 
    RegisterNetEvent('710-multiJob:Client:OpenMenu', function()
        local Player = QBCore.Functions.GetPlayerData()
        local citizenid = Player.citizenid
        local multimenu = {}
    firstmenu = {
    ['ChangeJob'] = {
        ['title'] = 'Change Jobs',
        ['fa'] = '<i class="fad fa-hood-cloak"></i>',
        ['type'] = 'event', 
        ['content'] = '710-multiJob:Server:ChangeJob',
        ['variables'] = {server = true, send_entity = false, onclickcloseui = true, custom_arg = {args = citizenid}, arg_unpack = false},
    },
    ['CheckJob'] = {
        ['title'] = 'Your Current job is '..Player.job.label..".", 
        ['fa'] = '<i class="fad fa-question-square"></i>',
        ['type'] = 'event', 
        ['content'] = '710-multiJob:Server:ChangeJob', -- Doesnt matter what one they click they will still change jobs
        ['variables'] = {server = true, send_entity = false, onclickcloseui = true, custom_arg = {args = citizenid}, arg_unpack = false},
    },
    }
    multimenu['Change Jobs'] = firstmenu 
        TriggerEvent('renzu_contextmenu:insertmulti',multimenu,"Switch Job", false,"<left><img src=https://i.imgur.com/0SqHk1a.png width=35vh></center></i> Change Jobs<br>")
        TriggerEvent('renzu_contextmenu:show')
    end)
end
