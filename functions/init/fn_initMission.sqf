#include "component.hpp"

MITM_ISLANDPARAM_ISWOODLAND = ["isWoodland"] call mitm_common_fnc_getIslandConfigEntry;

[] call mitm_init_fnc_disablePlayableUnits;
if (hasInterface) then {[{!isNull (findDisplay 46)}, {openMap [true,true]}, []] call CBA_fnc_waitUntilAndExecute};

[] call mitm_init_fnc_setMissionParams;
[] call mitm_init_fnc_registerChatCommands;
[] call mitm_groupsettings_fnc_setGroupSettings;
[] call mitm_init_fnc_initCivs;
/*[] call  mitm_init_fnc_setLoadoutFactions;*/

[{!isNull player || isDedicated},{

    //setup
    [] call mitm_setup_fnc_createBriefing;
    [] call mitm_init_fnc_moveToInitPos;
    [] call mitm_setup_fnc_setTime;
    [] call mitm_setup_fnc_setWeather;
    [] call mitm_setup_fnc_setMapRespawnPos;
    [] call mitm_init_fnc_setup;

    //vehicles and teleport
    [{missionNamespace getVariable ["MITM_SETUP_PLAYZONECONFIRMATION",false] && {isNil _x} count ["MITM_STARTPOSITION_WEST","MITM_STARTPOSITION_EAST","MITM_STARTPOSITION_INDEP","MITM_STARTPOSITION_COURIER"] == 0},{

        [WEST,MITM_STARTPOSITION_WEST,"MITM_SETUP_STARTVEHICLEDONE_WEST"] call mitm_setup_fnc_createStartVehicle;
        [EAST,MITM_STARTPOSITION_EAST,"MITM_SETUP_STARTVEHICLEDONE_EAST"] call mitm_setup_fnc_createStartVehicle;
        [INDEPENDENT,MITM_STARTPOSITION_INDEP,"MITM_SETUP_STARTVEHICLEDONE_INDEP"] call mitm_setup_fnc_createStartVehicle;
        [CIVILIAN,MITM_STARTPOSITION_COURIER,"MITM_SETUP_STARTVEHICLEDONE_COURIER"] call mitm_setup_fnc_createStartVehicle;

        [{missionNamespace getVariable ["MITM_SETUP_STARTVEHICLEDONE_WEST",false]},{[WEST,MITM_STARTPOSITION_WEST] call mitm_setup_fnc_teleportSide},[]] call CBA_fnc_waitUntilAndExecute;
        [{missionNamespace getVariable ["MITM_SETUP_STARTVEHICLEDONE_EAST",false]},{[EAST,MITM_STARTPOSITION_EAST] call mitm_setup_fnc_teleportSide},[]] call CBA_fnc_waitUntilAndExecute;
        [{missionNamespace getVariable ["MITM_SETUP_STARTVEHICLEDONE_INDEP",false]},{[INDEPENDENT,MITM_STARTPOSITION_INDEP] call mitm_setup_fnc_teleportSide},[]] call CBA_fnc_waitUntilAndExecute;
        [{missionNamespace getVariable ["MITM_SETUP_STARTVEHICLEDONE_COURIER",false]},{[CIVILIAN,MITM_STARTPOSITION_COURIER] call mitm_setup_fnc_teleportSide},[]] call CBA_fnc_waitUntilAndExecute;

    },[]] call CBA_fnc_waitUntilAndExecute;

    //start game
    [{{!(missionNamespace getVariable [_x,false])} count ["MITM_SETUP_STARTVEHICLEDONE_WEST","MITM_SETUP_STARTVEHICLEDONE_EAST","MITM_SETUP_STARTVEHICLEDONE_INDEP","MITM_SETUP_STARTVEHICLEDONE_COURIER"] == 0},{
        [] call mitm_setup_fnc_createTasks;

        [{[] call mitm_setup_fnc_startGameTimer},[],5] call CBA_fnc_waitAndExecute;
    },[]] call CBA_fnc_waitUntilAndExecute;


    //exit JIP
    if (hasInterface && didJIP && missionNamespace getVariable ["MIMT_SETUP_GAMESTARTED", false] && {(playerSide in [EAST,WEST,INDEPENDENT,CIVILIAN])}) exitWith {player allowDamage true; player setDamage 1};
    if (hasInterface && didJIP) then {[player] remoteExec ["mitm_common_fnc_addToZeus",2,false]};



}, []] call CBA_fnc_waitUntilAndExecute;
