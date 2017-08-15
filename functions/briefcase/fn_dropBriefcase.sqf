#include "component.hpp"

params ["_unit"];

private _briefcase = mitm_briefcase;

if (_unit != (_briefcase getVariable ["mitm_briefcase_owner",objNull])) exitWith {};
_unit setVariable ["mitm_briefcase_hasBriefcase",false,true];
_briefcase setVariable ["mitm_briefcase_owner",objNull,true];


detach _briefcase;
[_unit,true] remoteExec ["allowSprint",_unit,false];

private _pos = [];
if !(isNull objectParent _unit) then {
    _briefcase setPos [0,0,0];
    _maxDist = 3;
    while {count _pos == 0} do {
        _pos = (getPos _unit) findEmptyPosition [0,_maxDist,typeOf _briefcase];
        _maxDist = _maxDist + 2;
    };
} else {
    _pos = (getPos _briefcase) vectorAdd [0,1,0];
    _pos set [2,0];
};

_briefcase setPos _pos;

[SIDEUNKNOWN] call mitm_briefcase_fnc_activatePickupPoint;

if (side _unit != CIVILIAN) then {
    ["mitm_notification",["BRIEFCASE","You dropped the briefcase."]] remoteExec ["bis_fnc_showNotification",_unit,false];
};
