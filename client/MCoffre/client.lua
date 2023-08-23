ESX = nil 
jobornot = false
gangornot = false 
publicornot = true
publicornotget = true 
coordspris = false 
capacite = 100
CoffreK = {}

idget = 0 
capaciteget = ""
publicget = ""
jobget = ""
gangget = ""
jobautoriserget = ""
gangautoriserget = ""
xget =  ""
yget =  ""
zget =  ""
TriggerEvent(Config.GetSharedObject, function(obj) ESX = obj end)


Citizen.CreateThread(function()
	ESX.PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:setGang')
AddEventHandler('esx:setGang', function(gang)
    ESX.PlayerData.gang = gang
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)


RMenu.Add('MCoffre', 'mainMCoffre', RageUI.CreateMenu("MCoffre", "MCoffre"))
RMenu.Add('MCoffre', 'subMCoffre', RageUI.CreateSubMenu(RMenu:Get('MCoffre', 'mainMCoffre'), "MCoffre", "MCoffre"))
RMenu.Add('MCoffre2', 'subMCoffre2', RageUI.CreateSubMenu(RMenu:Get('MCoffre', 'subMCoffre'), "MCoffre2", "MCoffre2"))

Citizen.CreateThread(function()

    while true do

        RageUI.IsVisible(RMenu:Get('MCoffre', 'mainMCoffre'), function()
                        
            RageUI.Separator("↓ ~b~ Liste des coffre ~s~ ↓")
            RageUI.Line()

            RageUI.Button("Liste des coffre", nil, { RightLabel = "" }, true, {
                onSelected = function()
                end
            }, RMenu:Get('MCoffre', 'subMCoffre'))


            RageUI.Separator("↓ ~b~ Creer un coffre ~s~ ↓")
            RageUI.Line()

            RageUI.Button("Capacité du coffre (kg)", nil, { RightLabel = capacite .. " Kg" }, true, {
                onSelected = function()
                    capacite = KeyboardInput("Capacité du coffre (kg)", "", 3)
                end
            })

            RageUI.Line()

            if coordspris == true then 
                color = "~g~"
            else
                color = "~r~"
            end
            
            RageUI.Button(color .. "Coordonnées", nil, { RightLabel = ""  }, not recolte, {
                onSelected = function()
                    x = GetEntityCoords(PlayerPedId(), true).x
                    y = GetEntityCoords(PlayerPedId(), true).y
                    z = GetEntityCoords(PlayerPedId(), true).z
                    coordspris = true


                
                    ESX.ShowNotification("Coordonnées sauvegardées")
                end
            })

            RageUI.Line()

            RageUI.Checkbox("Public" , nil, publicornot, {}, {
                onChecked = function()
                    public = true
                    publicornot = true
                end,
                onUnChecked = function()
                    public = false
                    publicornot = false
                end
            })
        
            --Job

            if public == false then
                RageUI.Line()
                RageUI.Checkbox("Job", nil, jobornot, {}, {
                    onChecked = function()
                        job = true
                        jobornot = true
                        gang = false
                        gangornot = false

                    end,
                    onUnChecked = function()
                        job = false
                        jobornot = false
                    end
                })
                if job == true then
                    RageUI.Button("Job autorisé", nil, { RightLabel = ">>>" }, job, {
                        onSelected = function()
                            JobAutorise = KeyboardInput("Job autorisé", "", 20)
                        end
                    })
                end


                RageUI.Checkbox("Gang", nil, gangornot , {}, {
                    onChecked = function()
                        gang = true
                        gangornot = true
                        job = false
                        jobornot = false
                    end,
                    onUnChecked = function()
                        gang = false
                        gangornot = false
                    end
                })

                if gang == true then
                    RageUI.Button("Gang autorisé", nil, { RightLabel = ">>>" }, gang, {
                        onSelected = function()
                            GangAutorise = KeyboardInput("Gang autorisé", "", 20)
                        end
                    })
                end

                RageUI.Line()
            end 

            RageUI.Button("Creer le coffre", nil, { RightLabel = ">>>" }, coordspris, {
                onSelected = function()
                    if x == nil or y == nil or z == nil then
                        ESX.ShowNotification("Vous n'avez pas sauvegardé les coordonnées")
                        return 
                    end 
                    if publicornot == true then
                        TriggerServerEvent('esx_coffre:creercoffre',  x , y , z, capacite, "all")
                        ESX.ShowNotification("Coffre public créé")
                    elseif job == true then
                        TriggerServerEvent('esx_coffre:creercoffre',  x , y , z, capacite, JobAutorise , "job")
                        ESX.ShowNotification("Coffre job créé")
                    elseif gang == true then
                        TriggerServerEvent('esx_coffre:creercoffre', x , y , z , capacite, GangAutorise , "gang")
                        ESX.ShowNotification("Coffre gang créé")
                    end
                end
            })

        end,function()
        end)

        RageUI.IsVisible(RMenu:Get('MCoffre', 'subMCoffre'), function()
            for k, v in pairs(CoffreK) do
                RageUI.Button("Coffre n°" .. v.id, nil, { RightLabel = ">>>" }, true, {
                    onSelected = function()
                        idget = v.id
                        capaciteget = v.capacite
                        publicget = v.public
                        jobget = v.job
                        gangget = v.gang
                        jobautoriserget = v.jobautoriser
                        gangautoriserget = v.gangautoriser
                        xget = v.x
                        yget = v.y
                        zget = v.z
                    end
                }, RMenu:Get('MCoffre2', 'subMCoffre2'))
            end


        end, function()
        end)
        RageUI.IsVisible(RMenu:Get('MCoffre2', 'subMCoffre2'), function()
            RageUI.Separator("↓ ~b~ Coffre n°" .. idget .. " ~s~ ↓")
            RageUI.Separator("↓ ~b~ Capacité : " .. capaciteget .. " Kg ~s~ ↓")
            if publicget == "true" then 
                RageUI.Separator("↓ ~b~ Public : Oui ~s~ ↓")   
            else 
                RageUI.Separator("↓ ~b~ Public : Non ~s~ ↓")
            end
            if jobget == "true" then 
                RageUI.Separator("↓ ~b~ Job : Oui ~s~ ↓")
                RageUI.Separator("↓ ~b~ Job autorisé : " .. jobautoriserget .. " ~s~ ↓")
            end
            if gangget == "true" then 
                RageUI.Separator("↓ ~b~ Gang : Oui ~s~ ↓")
                RageUI.Separator("↓ ~b~ Gang autorisé : " .. gangautoriserget .. " ~s~ ↓")
            end


            
            RageUI.Button("Se teleporter au coffre", nil, { RightLabel = ">>>" }, true, {
                onSelected = function()
                    SetEntityCoords(PlayerPedId(), xget, yget, zget)
                end
            })


            RageUI.Button("Changer la position du coffre", nil, { RightLabel = ">>>" }, true, {
                onSelected = function()
                    ouiounon = KeyboardInput("Voulez vous vraiment changer la position du coffre ? (oui/non)", "", 3)
                    if ouiounon == "oui" then
                        x = GetEntityCoords(PlayerPedId(), true).x
                        y = GetEntityCoords(PlayerPedId(), true).y
                        z = GetEntityCoords(PlayerPedId(), true).z
                        TriggerServerEvent('esx_coffre:changeposcoffre', idget, x , y , z)
                        ESX.ShowNotification("Position du coffre changé")
                    end 
                end
            })

            RageUI.Button("Supprimer le coffre", nil, { RightLabel = ">>>" }, true, {
                onSelected = function()
                    TriggerServerEvent('esx_coffre:deletecoffre', idget)
                    ESX.ShowNotification("Coffre supprimé")
                end
            })

            if jobget == "true" then 
                RageUI.Button("Changer le job autorisé", nil, { RightLabel = ">>>" }, true, {
                    onSelected = function()
                        JobAutoriseget = KeyboardInput("Job autorisé", "", 20)
                        jobautoriserget = JobAutoriseget
                        TriggerServerEvent('esx_coffre:changejobautoriser', idget, JobAutoriseget)
                        ESX.ShowNotification("Job autorisé changé")
                    end
                })
            end 

            if gangget == "true" then 
                RageUI.Button("Changer le gang autorisé", nil, { RightLabel = ">>>" }, true, {
                    onSelected = function()
                        GangAutoriseget = KeyboardInput("Gang autorisé", "", 20)
                        gangautoriserget = GangAutoriseget
                        TriggerServerEvent('esx_coffre:changegangautoriser', idget, GangAutoriseget)
                        ESX.ShowNotification("Gang autorisé changé")
                    end
                })
            end







        end, function()
        end)

        Wait (0)
    end 
end)

RegisterCommand('coffre', function()
    RageUI.Visible(RMenu:Get('MCoffre', 'mainMCoffre'), not RageUI.Visible(RMenu:Get('MCoffre', 'mainMCoffre')))
end, false)

function GetCoffre()
    ESX.TriggerServerCallback('esx_coffre:getCoffre', function(coffre)
        CoffreK = coffre
    end)
end 

Citizen.CreateThread(function()
    while true do
        GetCoffre()
        Citizen.Wait(2000)   
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        for k, v in pairs(CoffreK) do
            if v.public == "true" then 
                v.x = tonumber(v.x)
                v.y = tonumber(v.y)
                v.z = tonumber(v.z)

                distance = #(GetEntityCoords(PlayerPedId(), true) - vector3(v.x, v.y, v.z))
                DrawMarker(27, v.x, v.y, v.z - 0.98, 0, 0, 0, 0, 0, 0, 1.5, 1.5, 1.5, 255, 0, 0, 100, 0, 0, 0, 0)
                if distance < 1.5 then
                    ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour ouvrir le coffre")
                    if IsControlJustPressed(1, 51) then
                        TriggerServerEvent('esx_coffre:createchest' , v.id , v.capacite)
                        Wait(1000)
                        exports.ox_inventory:openInventory("stash", "Coffre - " .. v.id)
                    end
                end
            elseif v.job == "true" then
                for k, v in pairs(CoffreK) do
                    if v.jobautoriser == ESX.PlayerData.job.name then
                        v.x = tonumber(v.x)
                        v.y = tonumber(v.y)
                        v.z = tonumber(v.z)

                        distance = #(GetEntityCoords(PlayerPedId(), true) - vector3(v.x, v.y, v.z))
                        DrawMarker(27, v.x, v.y, v.z - 0.98, 0, 0, 0, 0, 0, 0, 1.5, 1.5, 1.5, 255, 0, 0, 100, 0, 0, 0, 0)
                        if distance < 1.5 then
                            ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour ouvrir le coffre")
                            if IsControlJustPressed(1, 51) then
                                TriggerServerEvent('esx_coffre:createchest' , v.id , v.capacite)
                                Wait(1000)
                                exports.ox_inventory:openInventory("stash" , "Coffre - " .. v.id)
                            end
                        end
                    end
                end
            elseif v.gang == "true" then
                for k, v in pairs(CoffreK) do
                    if v.gangautoriser == ESX.PlayerData.gang.name then
                        v.x = tonumber(v.x)
                        v.y = tonumber(v.y)
                        v.z = tonumber(v.z)

                        distance = #(GetEntityCoords(PlayerPedId(), true) - vector3(v.x, v.y, v.z))
                        DrawMarker(27, v.x, v.y, v.z - 0.98, 0, 0, 0, 0, 0, 0, 1.5, 1.5, 1.5, 255, 0, 0, 100, 0, 0, 0, 0)
                        if distance < 1.5 then
                            ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour ouvrir le coffre")
                            if IsControlJustPressed(1, 51) then
                                TriggerServerEvent('esx_coffre:createchest' , v.id , v.capacite)
                                Wait(1000)
                                exports.ox_inventory:openInventory("stash", "Coffre - " .. v.id)
                            end
                        end
                    end
                end
            end

        end
    end
end)

function KeyboardInput(TextEntry, ExampleText, MaxStringLenght)
    AddTextEntry('FMMC_KEY_TIP1', TextEntry)
    DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", MaxStringLenght)
    blockinput = true

    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
        Citizen.Wait(0)
    end

    if UpdateOnscreenKeyboard() ~= 2 then
        local result = GetOnscreenKeyboardResult()
        Citizen.Wait(500)
        blockinput = false
        return result
    else
        Citizen.Wait(500)
        blockinput = false
        return nil
    end
end


-- Serveur 

--RegisterServerEvent('esx_coffre:creercoffre')
--AddEventHandler('esx_coffre:creercoffre', function(coords, capacite, job , lobel)
--    local _source = source
--    local xPlayer = ESX.GetPlayerFromId(_source)
--    local group = xPlayer.getGroup()
--    if group == "user" then 
--        TriggerClientEvent('esx:showNotification', _source, "Vous n'avez pas la permission de faire cela")
--    else    
--        if lobel == nil then 
--            --It is a public chest
--            MySQL.Async.execute('INSERT INTO MCoffre (capacite, coords, public) VALUES (@capacite, @coords, @public)', {
--                ['@capacite'] = capacite,
--                ['@coords'] = coords,
--                ['@public'] = "true"
--            }, function(rowsChanged)
--                TriggerClientEvent('esx:showNotification', _source, "Coffre crée")
--            end)
--        elseif lobel == "job" then
--            --It is a job chest
--            MySQL.Async.execute('INSERT INTO MCoffre (capacite, coords, job, jobautoriser) VALUES (@capacite, @coords, @job, @jobautoriser)', {
--                ['@capacite'] = capacite,
--                ['@coords'] = coords,
--                ['@job'] = "true",
--                ['@jobautoriser'] = job
--            }, function(rowsChanged)
--                TriggerClientEvent('esx:showNotification', _source, "Coffre crée")
--            end)
--        elseif lobel == "gang" then
--            --It is a gang chest
--            MySQL.Async.execute('INSERT INTO MCoffre (capacite, coords, gang, gangautoriser) VALUES (@capacite, @coords, @gang, @gangautoriser)', {
--                ['@capacite'] = capacite,
--                ['@coords'] = coords,
--                ['@gang'] = "true",
--                ['@gangautoriser'] = job
--            }, function(rowsChanged)
--                TriggerClientEvent('esx:showNotification', _source, "Coffre crée")
--            end)
--        end
--    end
--end)
--
--ESX.RegisterServerCallback('esx_coffre:getCoffre', function(source, cb)
--    MySQL.Async.fetchAll('SELECT * FROM MCoffre', {}, function(coffre)
--        cb(coffre)
--    end)
--end)
