ESX = nil 

TriggerEvent(Config.GetSharedObject, function(obj) ESX = obj end)




RegisterServerEvent('esx_coffre:creercoffre')
AddEventHandler('esx_coffre:creercoffre', function( x , y , z, capacite, job , lobel)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local group = xPlayer.getGroup()
    --Mettre les gramme en kg dans capacite
    capacite = capacite * 1000

    if group == "user" then 
        TriggerClientEvent('esx:showNotification', _source, "Vous n'avez pas la permission de faire cela")
    else    
        if lobel == nil then 
            --It is a public chest
            MySQL.Async.execute('INSERT INTO MCoffre (capacite, x , y , z , public) VALUES (@capacite, @x , @y , @z , @public)', {
                ['@capacite'] = capacite,
                ['@x'] = x,
                ['@y'] = y,
                ['@z'] = z,
                ['@public'] = "true"
            }, function(rowsChanged)
                TriggerClientEvent('esx:showNotification', _source, "Coffre crée")
            end)
        elseif lobel == "job" then
            --It is a job chest
            MySQL.Async.execute('INSERT INTO MCoffre (capacite, x , y , z, job, jobautoriser) VALUES (@capacite, @x , @y , @z, @job, @jobautoriser)', {
                ['@capacite'] = capacite,
                ['@x'] = x,
                ['@y'] = y,
                ['@z'] = z,
                ['@job'] = "true",
                ['@jobautoriser'] = job
            }, function(rowsChanged)
                TriggerClientEvent('esx:showNotification', _source, "Coffre crée")
            end)
        elseif lobel == "gang" then
            --It is a gang chest
            MySQL.Async.execute('INSERT INTO MCoffre (capacite, x , y , z, gang, gangautoriser) VALUES (@capacite, @x , @y , @z, @gang, @gangautoriser)', {
                ['@capacite'] = capacite,
                ['@x'] = x,
                ['@y'] = y,
                ['@z'] = z,
                ['@gang'] = "true",
                ['@gangautoriser'] = job
            }, function(rowsChanged)
                TriggerClientEvent('esx:showNotification', _source, "Coffre crée")
            end)
        end
    end
end)

ESX.RegisterServerCallback('esx_coffre:getCoffre', function(source, cb)
    MySQL.Async.fetchAll('SELECT * FROM MCoffre', {}, function(coffre)
        cb(coffre)
    end)
end)
RegisterServerEvent('esx_coffre:createchest')
RegisterNetEvent('esx_coffre:createchest', function(id, capacite)
    print ("Coffre - " .. id)
    exports.ox_inventory:RegisterStash("Coffre - " .. id,"Coffre - " .. id, 50, capacite, nil)
end)

RegisterServerEvent('esx_coffre:deletecoffre')
AddEventHandler('esx_coffre:deletecoffre', function(id)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local group = xPlayer.getGroup()
    if group == "user" then 
        TriggerClientEvent('esx:showNotification', _source, "Vous n'avez pas la permission de faire cela")
    else    
        MySQL.Async.execute('DELETE FROM MCoffre WHERE id = @id', {
            ['@id'] = id
        }, function(rowsChanged)
            TriggerClientEvent('esx:showNotification', _source, "Coffre supprimé")
        end)
    end
end)

RegisterServerEvent('esx_coffre:changeposcoffre')
AddEventHandler('esx_coffre:changeposcoffre', function(id, x, y, z)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local group = xPlayer.getGroup()
    if group == "user" then 
        TriggerClientEvent('esx:showNotification', _source, "Vous n'avez pas la permission de faire cela")
    else    
        MySQL.Async.execute('UPDATE MCoffre SET x = @x, y = @y, z = @z WHERE id = @id', {
            ['@id'] = id,
            ['@x'] = x,
            ['@y'] = y,
            ['@z'] = z
        }, function(rowsChanged)
            TriggerClientEvent('esx:showNotification', _source, "Coffre déplacé")
        end)
    end
end)

RegisterServerEvent('esx_coffre:changejobautoriser')
AddEventHandler('esx_coffre:changejobautoriser', function(id, job)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local group = xPlayer.getGroup()
    if group == "user" then 
        TriggerClientEvent('esx:showNotification', _source, "Vous n'avez pas la permission de faire cela")
    else    
        MySQL.Async.execute('UPDATE MCoffre SET jobautoriser = @job WHERE id = @id', {
            ['@id'] = id,
            ['@job'] = job
        }, function(rowsChanged)
            TriggerClientEvent('esx:showNotification', _source, "Job autorisé changé")
        end)
    end
end)

RegisterServerEvent('esx_coffre:changegangautoriser')
AddEventHandler('esx_coffre:changegangautoriser', function(id, gang)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local group = xPlayer.getGroup()
    if group == "user" then 
        TriggerClientEvent('esx:showNotification', _source, "Vous n'avez pas la permission de faire cela")
    else    
        MySQL.Async.execute('UPDATE MCoffre SET gangautoriser = @gang WHERE id = @id', {
            ['@id'] = id,
            ['@gang'] = gang
        }, function(rowsChanged)
            TriggerClientEvent('esx:showNotification', _source, "Gang autorisé changé")
        end)
    end
end)



--SQL 
--CREATE TABLE `MCoffre` (
--  `id` int(255) NOT NULL,
--  `capacite` int(255) NOT NULL,
--  `coords` varchar(255) NOT NULL,
--  `job` varchar(255) NOT NULL DEFAULT 'false',
--  `jobautoriser` varchar(255) NOT NULL,
--  `gang` varchar(255) NOT NULL DEFAULT 'false',
--  `gangautoriser` varchar(255) NOT NULL,
--  `public` varchar(255) NOT NULL DEFAULT 'false'
--) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
--
--
--ALTER TABLE `MCoffre`
--  ADD PRIMARY KEY (`id`);
--
--
--ALTER TABLE `MCoffre`
--  MODIFY `id` int(255) NOT NULL AUTO_INCREMENT;
--COMMIT;




--Coter Client 

--RMenu.Add('MCoffre', 'mainMCoffre', RageUI.CreateMenu("MCoffre", "MCoffre"))
--
--
--Citizen.CreateThread(function()
--
--    while true do
--        RageUI.IsVisible(RMenu:Get('MCoffre', 'mainMCoffre'), function()
--            RageUI.Separator("↓ ~b~ Creer un coffre ~s~ ↓")
--            RageUI.Line()
--
--            RageUI.Button("Capacité du coffre (kg)", nil, { RightLabel = capacite .. " Kg" }, true, {
--                onSelected = function()
--                    capacite = KeyboardInput("Capacité du coffre (kg)", "", 3)
--                end
--            })
--
--            RageUI.Line()
--            
--            RageUI.Button("Coordonnées", nil, { RightLabel = ""  }, not recolte, {
--                onSelected = function()
--                    x, y, z = table.unpack(GetEntityCoords(PlayerPedId(), true))
--                    coords = x .. ", " .. y .. ", " .. z
--                    ESX.ShowNotification("Coordonnées sauvegardées")
--                end
--            })
--
--            RageUI.Line()
--
--            RageUI.Checkbox("Public" , nil, publicornot, {}, {
--                onChecked = function()
--                    public = true
--                    publicornot = true
--                end,
--                onUnChecked = function()
--                    public = false
--                    publicornot = false
--                end
--            })
--        
--            --Job
--
--            if public == false then
--                RageUI.Line()
--                RageUI.Checkbox("Job", nil, jobornot, {}, {
--                    onChecked = function()
--                        job = true
--                        jobornot = true
--                        gang = false
--                        gangornot = false
--
--                    end,
--                    onUnChecked = function()
--                        job = false
--                        jobornot = false
--                    end
--                })
--                if job == true then
--                    RageUI.Button("Job autorisé", nil, { RightLabel = ">>>" }, job, {
--                        onSelected = function()
--                            JobAutorise = KeyboardInput("Job autorisé", "", 20)
--                        end
--                    })
--                end
--
--
--                RageUI.Checkbox("Gang", nil, gangornot , {}, {
--                    onChecked = function()
--                        gang = true
--                        gangornot = true
--                        job = false
--                        jobornot = false
--                    end,
--                    onUnChecked = function()
--                        gang = false
--                        gangornot = false
--                    end
--                })
--
--                if gang == true then
--                    RageUI.Button("Gang autorisé", nil, { RightLabel = ">>>" }, gang, {
--                        onSelected = function()
--                            GangAutorise = KeyboardInput("Gang autorisé", "", 20)
--                        end
--                    })
--                end
--
--                RageUI.Line()
--            end 
--
--            RageUI.Button("Creer le coffre", nil, { RightLabel = ">>>" }, true, {
--                onSelected = function()
--                  if public == true then
--                      TriggerServerEvent('esx_coffre:creercoffre', coords, capacite, "all")
--                  elseif job == true then
--                      TriggerServerEvent('esx_coffre:creercoffre', coords, capacite, JobAutorise , "job")
--                  elseif gang == true then
--                      TriggerServerEvent('esx_coffre:creercoffre', coords, capacite, GangAutorise , "gang")   
--                  end
--                end
--            })
--
--        end,function()
--        end)
--        Wait (0)
--    end 
--end)