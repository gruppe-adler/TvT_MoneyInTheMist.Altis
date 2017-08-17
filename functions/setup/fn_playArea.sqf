#include "component.hpp"

_result = [];
for [{_i=0},{_i<30},{_i=_i+1}] do {
    _result = [] call mitm_setup_fnc_createPositions;
    if (_result select 0) exitWith {};
};

_result
