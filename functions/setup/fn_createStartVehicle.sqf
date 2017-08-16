#include "component.hpp"

params ["_side","_searchPos","_varNameComplete"];

if (!isServer) exitWith {};

// spawn vehicle ===============================================================
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
        _spawnPos = [_searchPos,[0,_maxDist],[0,360],_sideVehicle] call mitm_common_fnc_findRandomPos;
        /*_spawnPos = _searchPos findEmptyPosition [0,_maxDist,_sideVehicle];*/
        _maxDist = _maxDist + 5;
    };

    private _veh = createVehicle [_sideVehicle,_spawnPos,[],0,"NONE"];
    [_veh] call mitm_common_fnc_emptyContainer;


    // fill vehicle ============================================================
    private _vehicleContents = switch (_side) do {
        case (WEST): {[missionConfigFile >> "cfgFactions" >> MITM_MISSIONPARAM_FACTION_WEST,"startVehicleContents",[[],[],[],[]]] call BIS_fnc_returnConfigEntry};
        case (EAST): {[missionConfigFile >> "cfgFactions" >> MITM_MISSIONPARAM_FACTION_EAST,"startVehicleContents",[[],[],[],[]]] call BIS_fnc_returnConfigEntry};
        case (INDEPENDENT): {[missionConfigFile >> "cfgFactions" >> MITM_MISSIONPARAM_FACTION_GUER,"startVehicleContents",[[],[],[],[]]] call BIS_fnc_returnConfigEntry};
        case (CIVILIAN): {[missionConfigFile >> "cfgFactions" >> MITM_MISSIONPARAM_FACTION_CIV,"startVehicleContents",[[],[],[],[]]] call BIS_fnc_returnConfigEntry};
    };

    _vehicleContents params [["_backpacks",[]],["_items",[]],["_magazines",[]],["_weapons",[]]];
    {
        for [{_j=0}, {_j<(count _x -1)}, {_j=_j+2}] do {
            _type = _x select _j;
            _amount = _x select (_j+1);
            
            switch (_forEachIndex) do {
                case (0): {_veh addBackpackCargoGlobal [_type,_amount]};
                case (1): {_veh addItemCargoGlobal [_type,_amount]};
                case (2): {_veh addMagazineCargoGlobal [_type,_amount]};
                case (3): {_veh addWeaponCargoGlobal [_type,_amount]};
            };
        };
    } forEach [_backpacks,_items,_magazines,_weapons];
};



// set public var to true ======================================================
missionNamespace setVariable [_varNameComplete,true,true];
