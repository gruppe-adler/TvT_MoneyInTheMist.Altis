#include "component.hpp"

params ["_unit"];

private _briefcase = mitm_briefcase;

if (_unit != (_briefcase getVariable ["mitm_briefcase_owner",objNull])) exitWith {};


detach _briefcase;
[_unit,true] remoteExec ["allowSprint",_unit,false];

private _offset = if !(isNull objectParent _unit) then {[3,0,0]} else {[2,0,0]};
_briefcase attachTo [_unit,_offset,""];
[{detach _this},_briefcase,0.5] call CBA_fnc_waitAndExecute;

_unit setVariable ["mitm_briefcase_hasBriefcase",false,true];
_briefcase setVariable ["mitm_briefcase_owner",objNull,true];


/*_briefcase setPos _pos;*/

[SIDEUNKNOWN] call mitm_briefcase_fnc_activatePickupPoint;

if (side _unit != CIVILIAN) then {
    ["mitm_notification",["BRIEFCASE","You dropped the briefcase."]] remoteExec ["bis_fnc_showNotification",_unit,false];
};
