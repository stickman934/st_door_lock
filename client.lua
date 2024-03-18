Citizen.CreateThread(function ()

    local doors = GlobalState.doors

    if not doors then
        return
    end

    for k,v in pairs(doors) do
        AddDoorToSystem(v.DoorHash, v.ModelHash, v.Coordinates)
        DoorSystemSetDoorState(v.DoorHash, v.Locked)
    end

    while true do
        for j,t in pairs(doors) do
            if Vdist2(t.Coordinates, GetEntityCoords(PlayerPedId(), false)) < 10 then
                if DoorSystemGetDoorState(t.DoorHash) == 1 then
                    SetText(t.Coordinates, 'Locked', 'red')
                else
                    SetText(t.Coordinates, 'Unlocked', 'green')
                end  
            end
            if Vdist(t.Coordinates, GetEntityCoords(PlayerPedId(), false)) < 2 then
                if t.Automatic then
                    AddTextEntry('ST_UNLOCK', 'Press ~INPUT_PICKUP~ to unlock the door')
                    BeginTextCommandDisplayHelp('ST_UNLOCK')
                    EndTextCommandDisplayHelp(0, false, true, 1)
                    if IsControlJustPressed(0, 38) then
                        TriggerEvent('st_doors:update', j)
                    end
                else
                    if DoorSystemGetDoorState(t.DoorHash) == 1 then
                        AddTextEntry('ST_UNLOCK', 'Press ~INPUT_PICKUP~ to unlock the door')
                        BeginTextCommandDisplayHelp('ST_UNLOCK')
                        EndTextCommandDisplayHelp(0, false, true, 1)
                        if IsControlJustPressed(0, 38) then
                            TriggerEvent('st_doors:update', j)
                        end
                    else
                        AddTextEntry('ST_UNLOCK', 'Press ~INPUT_PICKUP~ to lock the door')
                        BeginTextCommandDisplayHelp('ST_UNLOCK')
                        EndTextCommandDisplayHelp(0, false, true, 1)
                        if IsControlJustPressed(0, 38) then
                            TriggerEvent('st_doors:update', j)
                        end
                    end
                end
            end
        end
        Citizen.Wait(0)
    end
end)

RegisterNetEvent('st_doors:update', function (doorName)

    local pin = tonumber(GetPin())
    local doorPin = Config.Doors[doorName].Pin

    if Config.Doors[doorName].Automatic then
        if pin == doorPin then
            DoorSystemSetDoorState(Config.Doors[doorName].DoorHash, 0)
            BeginTextCommandThefeedPost("STRING")
            AddTextComponentSubstringPlayerName("Doors Unlocked")
            EndTextCommandThefeedPostTicker(false, false)
            
            Citizen.Wait(5000)
    
            DoorSystemSetDoorState(Config.Doors[doorName].DoorHash, 1)
            BeginTextCommandThefeedPost("STRING")
            AddTextComponentSubstringPlayerName("Doors Locked")
            EndTextCommandThefeedPostTicker(false, false)
        else
            BeginTextCommandThefeedPost("STRING")
            AddTextComponentSubstringPlayerName("Wrong PIN!")
            ThefeedNextPostBackgroundColor(6)
            EndTextCommandThefeedPostTicker(true, false)
        end
    else
        local doorState = DoorSystemGetDoorState(Config.Doors[doorName].DoorHash)
        if doorState == 0 then
            DoorSystemSetDoorState(Config.Doors[doorName].DoorHash, 1)
        elseif doorState == 1 then
            DoorSystemSetDoorState(Config.Doors[doorName].DoorHash, 0)
        end
    end            
end)

function GetPin()
    AddTextEntry('ST_INPUT', 'Enter Door PIN')
    DisplayOnscreenKeyboard(1, 'ST_INPUT', '', '', '', '', '', 4)

    while UpdateOnscreenKeyboard() == 0 do
        Citizen.Wait(0)
    end

    if UpdateOnscreenKeyboard() ~= 2 then
        local result = GetOnscreenKeyboardResult()

        Citizen.Wait(0)

        return result
    else
        Citizen.Wait(0)

        return nil
    end
end

function SetText(coords, text , colour)
    local camCoords = GetGameplayCamCoord()
    local dist = #(coords - camCoords)
    
    -- Experimental math to scale the text down
    local scale = 200 / (GetGameplayCamFov() * dist)

    -- Format the text
    if colour == 'red' then
        SetTextColour(255, 0, 0, 255)
    elseif colour == 'green' then
        SetTextColour(0, 255, 0, 255)
    else
        SetTextColour(255, 255, 255, 255)
    end
    SetTextScale(0.0, 0.6 * scale)
    SetTextFont(0)
    SetTextDropshadow(0, 0, 0, 0, 55)
    SetTextDropShadow()
    SetTextCentre(true)

    -- Diplay the text
    BeginTextCommandDisplayText("STRING")
    AddTextComponentSubstringPlayerName(text)
    SetDrawOrigin(coords, 0)
    EndTextCommandDisplayText(0.0, 0.0)
    ClearDrawOrigin()
end