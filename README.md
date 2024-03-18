# Door Lock Script for FiveM

It's a simple script to lock door that you want. It has to modes Automatic and Manual. In automatic mode when you unlock the door they will automatically lock after 5 sec. In manual mode doors will stay unlocked until you lock them again. It will also show if the doors are locked or unlocked. You can set a 4 digit PIN for every door.

To unlock/lock door simply walk to the door and press E. You can also use a command to unlock/lock doors from anywhere. `/doorlock <doorName>`

This is my firs FiveM script so it's not perfect :)

## Config

You can as many doors as you want in Config.lua. There is already some in config as and example and you can remove them.

### Config format

```
['doorName'] = {
        DoorHash = `doorName`,
        ModelHash = `GTAModelHash`,
        Coordinates = vector3(x, y, z),
        Locked = 1,
        Pin = 1234,
        Automatic = true
},
```
| Name        | Description                                            | Notes         |
|   :---:     |    :----:                                              |   :---:       |
| doorName    | Name of the door. This will be used for command.       | Can be whatever you want.   |
| DoorHash    | Door hash.                                             | This must be the same as doorName.   |
| ModelHash   | Game model hash.                                       | You can get this by using ID Gun. ( [ID Gun GitHub ](https://github.com/Puntherline/pun_idgun) )    |
| Coordinates | Door cooridantes                                       | Again you can use ID Gun to get this information.  |
| Locked      | When server starts is the door locked                  | 1 = Locked, 0 = Unlocked.    |
| Pin         | PIN for the door                                       | Max 4 digits.   |
| Automatic   | Is the door in Automatic or Manual mode                | true = Auto, false = Manual     |
