#include "component.hpp"

if (!isServer) exitWith {};

["pickup_debug"] call mitm_common_fnc_clearMarkerCategory;

private _exfilAreaRadius = ["exfilAreaRadius",20] call mitm_common_fnc_getMissionConfigEntry;
private _exfilDistances = ["teamPickupDistances",[1000,2000]] call mitm_common_fnc_getMissionConfigEntry;
_exfilDistances params ["_exfilDistanceMin","_exfilDistanceMax"];

private _exfilPoints = [];

{
    _successful = false;
    _currentMinDist = _exfilDistanceMin;
    _currentMaxDist = _exfilDistanceMax;
    _pos = [];
    while {!_successful} do {
        _pos = [MITM_PLAYZONE_CENTER,[_currentMinDist,_currentMaxDist],[0,360],"Land_HelipadCircle_F"] call mitm_common_fnc_findRandomPos;
        if (count _pos > 0) then {
            if ({_pos distance2D _x < _currentMinDist} count _exfilPoints == 0) then {_successful = true};
        };
        _currentMinDist = _currentMinDist * 0.8;
        _currentMaxDist = _currentMaxDist * 1.2;
    };

    _exfilPoints pushBack _pos;

    _trigger = [
        _pos,
        [_exfilAreaRadius,_exfilAreaRadius,0,false],
        [["WEST SEIZED","EAST SEIZED","GUER SEIZED"] select _forEachIndex,"PRESENT",true],
        {missionNamespace getVariable ["mitm_briefcase_carryingSide",sideUnknown] in [(_this select 0) getVariable ["mitm_setup_exfilPointOwner",sideUnknown],SIDEUNKNOWN] && {(missionNamespace getVariable ["mitm_briefcase",objNull]) inArea (_this select 0)}},
        {[_this select 0,true] call mitm_briefcase_fnc_onExfilTriggerToggle},
        {[_this select 0,false] call mitm_briefcase_fnc_onExfilTriggerToggle}
    ] call mitm_common_fnc_createTrigger;
    _trigger setVariable ["mitm_setup_exfilPointOwner",[WEST,EAST,INDEPENDENT] select _forEachIndex];
    missionNamespace setVariable [_x,_trigger,false];

    if (MITM_MISSIONPARAM_DEBUGMODE) then {
        ["pickup_debug",str _pos,_pos,_x + " (DEBUG)","ICON","hd_end","COLORUNKNOWN"] call mitm_common_fnc_createCategoryMarker;
    };
} forEach ["MITM_EXFIL_WEST","MITM_EXFIL_EAST","MITM_EXFIL_GUER"];
