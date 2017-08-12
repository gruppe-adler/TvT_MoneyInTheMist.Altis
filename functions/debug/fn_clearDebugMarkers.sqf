#include "component.hpp"

params ["_categoryName"];

if (isNil "MITM_DEBUGNAMESPACE") exitWith {};

{
    deleteMarker _x;
    false
} count (MITM_DEBUGNAMESPACE getVariable [_categoryName,[]]);
