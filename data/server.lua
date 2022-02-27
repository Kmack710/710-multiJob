local QBCore = exports['qb-core']:GetCoreObject()


RegisterNetEvent('710-multiJob:Server:ChangeJob', function(args)
    local source = source
    local Player = QBCore.Functions.GetPlayer(source)
    if Config.usingRenzuContext then 
        citizenid = args['args']
    elseif Config.usingQBmenu then 
        citizenid = args.citizenid
    end
    local PlayerData = QBCore.Players[source].PlayerData
    Wait(1) -- to make sure client doesnt get log spam in chat for saving the player data 
    QBCore.Player.Save(source) -- Without this the players job might not be saved. If they change jobs to fast the database wont pick it up.
    Wait(1000) -- Wait to make sure the player data saves before we change it. (Without this if they change jobs to fast or just get a new job then change it wont save!)
    local result = MySQL.query.await('SELECT * FROM players WHERE citizenid = ?', {citizenid})
    if result[1] then
        local Job1 = result[1].job
        local Job2 = json.decode(result[1].job_two)   
        MySQL.query('UPDATE players SET job_two = job WHERE citizenid = ?', {citizenid}) -- job = json.encode(PlayerData.job),
        Player.Functions.SetJob(Job2.name, Job2.grade.level)
        --TriggerClientEvent('okokNotify:Alert', source, "Job Changer", "You have changed to your 2nd job "..Job2.label, 5000, 'info') -- if you wanna use OKOK uncomment this :) 
        TriggerClientEvent('QBCore:Notify', source, "You have changed to your 2nd job "..Job2.label, 'primary', 5000)      
    end        
end)