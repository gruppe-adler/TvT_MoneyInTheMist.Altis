#include "component.hpp"

params [["_mode","PRECHECK"]];

if (!isServer) exitWith {};

private _interval = switch (_mode) do {
    case ("PRECHECK"): {5};
    case ("CHECK"): {1};
    default {ERROR_1("Unknown mode %1",_mode); 10};
};

[{
    params ["_mode","_handle"];

    private _eliminationArray = [
        {side _x == WEST} count playableUnits == 0,
        {side _x == EAST} count playableUnits == 0,
        {side _x == INDEPENDENT} count playableUnits == 0,
        {side _x == CIVILIAN && {[_x] call mitm_common_fnc_isCourier}} count playableUnits == 0
    ];

    if ({_x} count _eliminationArray >= 3) then {

        if (_mode == "PRECHECK") then {
            [_handle] call CBA_fnc_removePerFrameHandler;
            ["CHECK"] call mitm_endings_fnc_checkEliminated;
        };

        if (_mode == "CHECK") then {
            _timer = missionNamespace getVariable ["mitm_sidesEliminatedFor",0];

            if (_timer > 10) then {
                [_handle] call CBA_fnc_removePerFrameHandler;

                _winner = sideUnknown;
                {
                    if (!_x) then {_winner = [WEST,EAST,INDEPENDENT,CIVILIAN] select _forEachIndex};
                } forEach _eliminationArray;

                missionNamespace setVariable ["mitm_endInProgressServer",true];
                missionNamespace setVariable ["mitm_gameEnded", [_winner, "OPPONENTS ELIMINATED!"], true];
            } else {
                missionNamespace setVariable ["mitm_sidesEliminatedFor",_timer + 1];
            };
        };

    } else {
        if (_mode == "CHECK") then {
            missionNamespace setVariable ["mitm_sidesEliminatedFor",0];
            [_handle] call CBA_fnc_removePerFrameHandler;
            ["PRECHECK"] call mitm_endings_fnc_checkEliminated;
        };
    };
},_interval,_mode] call CBA_fnc_addPerFrameHandler;
