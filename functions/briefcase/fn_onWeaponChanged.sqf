#include "component.hpp"

params ["_unit","_weapon"];

if !(_unit getVariable ["mitm_briefcase_hasBriefcase",false]) exitWith {};

if (_weapon != "") then {
    [_unit] call mitm_briefcase_fnc_dropBriefcase;
};
