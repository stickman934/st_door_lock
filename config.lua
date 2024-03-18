Config = {}

-- Here you can add doors that you want to be locked
-- Format:
--['doorName'] = {                       - Your door name, it can be what ever you want
--  DoorHash = `doorName`,               - Needs to be same as prevous doorName
--  ModelHash = `GTAModelHash`,          - It can be something like v_ilev_cor_firedoorwide then use ``, if it's a number just put in the number
--  Coordinates = vector3(x, y, z),      - Door coordinates
--  Locked = 1,                          - If the value is 1 doors will be locked when server starts, if 0 doors will be unlocked when server starts
--  Pin = 1234,                          - PIN code for doors, max 4 digits
--  Automatic = true,                    - If true doors lock again after 5 sec, if false you can toggle lock
--}
-- Easy way to get ModelHash and coordinates form game is to use ID gun (https://github.com/Puntherline/pun_idgun)
-- You can use command /doorlock <doorName> to unlock doors from wherever you want. 

Config.Doors = {
    ['sinners'] = {
        DoorHash = `sinners`,
        ModelHash = `v_ilev_cor_firedoorwide`,
        Coordinates = vector3(436.551, -985.0123, 30.71557),
        Locked = 1,
        Pin = 1234,
        Automatic = true
    },
    ['sinnersoffice'] = {
        DoorHash = `sinnersoffice`,
        ModelHash = `v_ilev_fib_door3`,
        Coordinates = vector3(463.4168, -1001.015, 36.05486),
        Locked = 1,
        Pin = 9898,
        Automatic = false
    },
    ['sinnerscustody2'] = {
        DoorHash = `sinnerscustody2`,
        ModelHash = -550267256,
        Coordinates = vector3(455.9423, -984.8206, 26.82916),
        Locked = 1,
        Pin = 1234,
        Automatic = true
    }
}