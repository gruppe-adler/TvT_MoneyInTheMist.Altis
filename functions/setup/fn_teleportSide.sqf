#include "component.hpp"

[{
    params ["_side","_searchPos"];

    {
        if (local _x && {side _x == _side}) then {
            _maxDist = 10;
            _pos = [];
            while {count _pos == 0} do {
                _pos = [_searchPos,[0,_maxDist]] call mitm_common_fnc_findRandomPos;
                _maxDist = _maxDist + 5;
            };
            [_x,_pos] call mitm_common_fnc_teleport;
        };
        false
    } count playableUnits;

}, _this, random 2] call CBA_fnc_waitAndExecute;
