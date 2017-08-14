#include "component.hpp"

params ["_unit"];

if !(_unit getVariable ["mitm_briefcase_hasBriefcase",false]) exitWith {};

[_unit,false] call mitm_briefcase_fnc_attachBriefcase;
