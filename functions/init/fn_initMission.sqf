#include "component.hpp"

MITM_ISLANDPARAM_ISWOODLAND = ["isWoodland"] call mitm_common_fnc_getIslandConfigEntry;

[] call mitm_init_fnc_setMissionParams;
[] call mitm_init_fnc_registerChatCommands;
/*[] call  mitm_init_fnc_setLoadoutFactions;*/

[{!isNull player || isDedicated},{

    //setup
    [] call mitm_init_fnc_moveToInitPos;
    [] call mitm_setup_fnc_setTime;
    [] call mitm_setup_fnc_setWeather;
    [] call mitm_setup_fnc_setMapRespawnPos;
    [] call mitm_init_fnc_setup;

    [{missionNamespace getVariable ["MITM_SETUP_PLAYZONECONFIRMATION",false] && {isNil _x} count ["MITM_STARTPOSITION_WEST","MITM_STARTPOSITION_EAST","MITM_STARTPOSITION_INDEP","MITM_STARTPOSITION_COURIER"] == 0}, {
        [WEST,MITM_STARTPOSITION_WEST] call mitm_setup_fnc_teleportSide;
        [EAST,MITM_STARTPOSITION_EAST] call mitm_setup_fnc_teleportSide;
        [INDEPENDENT,MITM_STARTPOSITION_INDEP] call mitm_setup_fnc_teleportSide;
        [CIVILIAN,MITM_STARTPOSITION_COURIER] call mitm_setup_fnc_teleportSide;
    }, []] call CBA_fnc_waitUntilAndExecute;

    //exit JIP
    if (hasInterface && didJIP && missionNamespace getVariable ["mitm_init_gamestarted", false] && {(playerSide in [EAST,WEST,INDEPENDENT,CIVILIAN])}) exitWith {player allowDamage true; player setDamage 1};
    if (hasInterface && didJIP) then {[player] remoteExec ["mitm_common_fnc_addToZeus",2,false]};


}, []] call CBA_fnc_waitUntilAndExecute;
