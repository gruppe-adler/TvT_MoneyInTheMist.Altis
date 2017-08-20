#include "component.hpp"

params ["_trigger"];

if (_trigger getVariable ["mitm_briefcase_exfilArriving",false]) exitWith {};
_trigger setVariable ["mitm_briefcase_exfilArriving",true];

private _ownerSide = _trigger getVariable ["mitm_setup_exfilPointOwner",sideUnknown];
if (_ownerSide == sideUnknown) exitWith {ERROR("Exfil trigger does not have an owner.")};

["mitm_notification",["EXFIL","Exfil inbound!"]] remoteExec ["bis_fnc_showNotification",_ownerSide,false];

private _faction = [MITM_MISSIONPARAM_FACTION_WEST,MITM_MISSIONPARAM_FACTION_EAST,MITM_MISSIONPARAM_FACTION_GUER] select ([WEST,EAST,INDEPENDENT] find _ownerSide);
private _spawnHeli = [missionConfigFile >> "cfgFactions" >> _faction, "exfilHeli","objNull"] call BIS_fnc_returnConfigEntry;
private _middleMissionPos = [MITM_MISSIONPOSITIONS select 2,MITM_MISSIONPOSITIONS select 3,MITM_MISSIONPOSITIONS select 4,MITM_MISSIONPOSITIONS select 5] call mitm_common_fnc_getAveragePosition;

private _spawnPos = _middleMissionPos getPos [2*(_middleMissionPos distance2D _trigger),_middleMissionPos getDir _trigger];
_spawnPos set [2,150];
private _heli = [_spawnPos] call compile _spawnHeli;
/*_heli setPos _spawnPos;*/
createVehicleCrew _heli;

_heli allowDamage false;
_heli setCombatMode "BLUE";
{_x allowDamage false} forEach (crew _heli);

_trigger setVariable ["mitm_briefcase_heli",_heli];

[group _heli,getPos _trigger,0,"MOVE","AWARE","YELLOW","FULL","NO CHANGE","(vehicle this) setVariable ['mitm_briefcase_heliArrived',true]"] call CBA_fnc_addWaypoint;


[{(_this select 0) distance2d (_this select 1) < 1000},{
    params ["_heli","_trigger"];

    "SmokeShellGreen" createVehicle (_trigger getPos [10,(_trigger getDir _heli) + 90]);
    "SmokeShellGreen" createVehicle (_trigger getPos [10,(_trigger getDir _heli) - 90]);

    (getPos _trigger) spawn {
        for [{_i=0}, {_i<5}, {_i=_i+1}] do {
            [[_this,[250,300],[0,360],"",false,false] call mitm_common_fnc_findRandomPos] call mitm_common_fnc_projectile;
            sleep random 0.2;
        };
    };
},[_heli,_trigger]] call CBA_fnc_waitUntilAndExecute;

[{
    (_this select 0) getVariable ["mitm_briefcase_heliArrived",false] &&
    {triggerActivated (_this select 1)}
},{
    _this spawn {
        params ["_heli","_trigger","_ownerSide"];

        sleep 2;
        missionNamespace setVariable ["mitm_endInProgressServer",true];
        missionNamespace setVariable ["mitm_gameEnded", [_ownerSide, "BRIEFCASE SECURED"], true];

        [_ownerSide] call mitm_endings_fnc_saveScore;
    };
},[_heli,_trigger,_ownerSide]] call CBA_fnc_waitUntilAndExecute;
