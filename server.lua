Citizen.CreateThread(function ()

    GlobalState.doors = Config.Doors
    
end)

RegisterCommand('doorlock', function (source, args, rawCommand)
    local doorName = args[1]
    local doors = GlobalState.doors

    if not doorName or not doors[doorName] then
        return
    end

    GlobalState.doors = doors

    TriggerClientEvent('st_doors:update', -1, doorName)
end)