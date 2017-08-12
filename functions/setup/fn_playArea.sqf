#include "component.hpp"

_result = [];
for [{_i=0}, {_i<100}, {_i=_i+1}] do {
    ["playArea"] call mitm_debug_fnc_clearDebugMarkers;
    _result = [] call mitm_setup_fnc_createPositions;
    if (_result select 0) exitWith {};
    if (MITM_MISSIONPARAM_DEBUGMODE) then {WARNING(_result select 1)};
};

_result
