# Money in the Mist Template Mode
While Money in the Mist was originally meant to be a completely randomly generated mission, there are now some functions that help creating a custom MitM mission.

Download a demo mission here:
[mitm_template_demomission.zip](https://github.com/gruppe-adler/TvT_MoneyInTheMist.Altis/files/4099633/mitm_template_demomission.zip)

Configure the mission by editing the files in the *USER* folder.

## Creating Starting Positions for Teams
Drop a game logic on the desired position. Add the following function to the logic's init:

**Syntax**  
`[logic, side] call mitm_template_fnc_createStartPosition`

**Parameters**  
1. logic - object, the logic object that defines the position
2. side - side, optional, the side that will start at this position. If left empty a random side will be chosen.

**Example**  
`[this, WEST] call mitm_template_fnc_createStartPosition`

## Creating Delivery Positions
Drop a game logic on the desired position. The actual object will be created by script. Add the following function to the logic's init:

**Syntax**  
`[logic, isLastPosition] call mitm_template_fnc_createMissionPosition`

**Parameters**  
1. logic - object, the logic object that defines the position
2. isLastPosition - bool, set this to true for the final delivery

**Example**  
`[this, false] call mitm_template_fnc_createMissionPosition`

## Creating Exfil Positions
Drop a game logic on the desired position. If you want to use this to create a side-specific exfil position while also using randomized starting positions, synch this to the starting position that you want it to belong to. Add the following function to the logic's init:

**Syntax**  
`[logic, side] call mitm_template_fnc_createExfilPoint`

**Parameters**  
1. logic - object, the logic object that defines the position
2. side - side, optional, the side that this exfil position will belong to. If you leave this blank, you have to synchronize it to a starting position's logic.

**Example**  
`[this, EAST] call mitm_template_fnc_createExfilPoint`
