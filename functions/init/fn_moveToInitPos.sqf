#include "component.hpp"

private _posBlu = ["spawnPosBlu",[0,0,0]] call mitm_common_fnc_getIslandConfigEntry;
private _posOpf = ["spawnPosOpf",_posBlu] call mitm_common_fnc_getIslandConfigEntry;
private _posIndep = ["spawnPosIndep",_posBlu] call mitm_common_fnc_getIslandConfigEntry;

{
    if (local _x) then {
        _x allowDamage false;
        _searchPos = switch (side _x) do {
            case (WEST): {_posBlu};
            case (EAST): {_posOpf};
            case (INDEPENDENT): {_posIndep};
            default {_posBlu};
        };

        _maxDist = 10;
        _pos = [];
        while {count _pos == 0} do {
            _pos = _searchPos findEmptyPosition [0,_maxDist,"B_Soldier_F"];
            _maxDist = _maxDist + 5;
        };

        _x setPos _pos;
    };
    false
} count playableUnits;
