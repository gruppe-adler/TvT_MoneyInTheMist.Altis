#include "component.hpp"

params ["_side","_searchPos","_varNameComplete"];

if (!isServer) exitWith {};


private _sideVehicles = switch (_side) do {
    case (WEST): {[missionConfigFile >> "cfgFactions" >> MITM_MISSIONPARAM_FACTION_WEST,"startVehicles",[]] call BIS_fnc_returnConfigEntry};
    case (EAST): {[missionConfigFile >> "cfgFactions" >> MITM_MISSIONPARAM_FACTION_EAST,"startVehicles",[]] call BIS_fnc_returnConfigEntry};
    case (INDEPENDENT): {[missionConfigFile >> "cfgFactions" >> MITM_MISSIONPARAM_FACTION_GUER,"startVehicles",[]] call BIS_fnc_returnConfigEntry};
    case (CIVILIAN): {[missionConfigFile >> "cfgFactions" >> MITM_MISSIONPARAM_FACTION_CIV,"startVehicles",[]] call BIS_fnc_returnConfigEntry};
};
private _sideVehicle = _sideVehicles select MITM_ISLANDPARAM_ISWOODLAND;


private _vehicleAmount = ceil ((_side countSide playableUnits)/4);
for [{_i=0}, {_i<_vehicleAmount}, {_i=_i+1}] do {
    private _maxDist = 10;
    private _spawnPos = [];
    while {count _spawnPos == 0} do {
        _spawnPos = _searchPos findEmptyPosition [0,_maxDist,_sideVehicle];
        _maxDist = _maxDist + 5;
    };

    private _veh = createVehicle [_sideVehicle,[0,0,0],[],0,"CAN_COLLIDE"];
    [_veh] call mitm_common_fnc_emptyContainer;
    _veh setPos _spawnPos;
};


missionNamespace setVariable [_varNameComplete,true,true];
