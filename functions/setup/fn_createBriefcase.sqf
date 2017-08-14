#include "component.hpp"

if (!isServer) exitWith {};

_briefcase = "Land_Suitcase_F" createVehicle [0,0,0];
missionNamespace setVariable ["mitm_briefcase",_briefcase,true];

[{{isNull (missionNamespace getVariable [_x,objNull])} count ["mitm_courier","mitm_briefcase"] == 0},{
    [{[mitm_courier] call mitm_briefcase_fnc_attachBriefcase},[],3] call CBA_fnc_waitAndExecute;
},[]] call CBA_fnc_waitUntilAndExecute;

_briefcase
