#include "component.hpp"

[{
    params ["_side","_searchPos"];

    {
        if (local _x && {side _x == _side}) then {
            _maxDist = 10;
            _pos = [];
            _x enableSimulation true;
            while {count _pos == 0} do {
                _pos = [_searchPos,[0,_maxDist]] call mitm_common_fnc_findRandomPos;
                _maxDist = _maxDist + 5;
            };
            _onTP = if (_side != CIVILIAN && {_x == player}) then {
                {[_this select 0] call mitm_setup_fnc_enforceStartTimer}
            } else {{}};
            _onTPParams = [_pos];

            [_x,_pos,_onTP,_onTPParams] call mitm_common_fnc_teleport;

            if (player == _x) then {openMap [false,false]};
        };
        false
    } count playableUnits;

}, _this, random 2] call CBA_fnc_waitAndExecute;
