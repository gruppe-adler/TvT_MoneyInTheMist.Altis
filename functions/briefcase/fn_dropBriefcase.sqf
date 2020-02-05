#include "component.hpp"

params ["_unit"];

private _briefcase = mitm_briefcase;

if (_unit != (_briefcase getVariable ["mitm_briefcase_owner",objNull])) exitWith {};


detach _briefcase;
_briefcase setPosASL ((getPosASL _briefcase) vectorAdd [0,0,0.5]);

[_unit,true] remoteExec ["allowSprint",_unit,false];

/* private _offset = [[3,0,0.3],[2,0,0.3]] select (isNull objectParent _unit);
_briefcase attachTo [_unit,_offset,""]; */

[{
	params ["_briefcase", "_unit"];
	/* detach _briefcase; */

	_unit setVariable ["mitm_briefcase_hasBriefcase",false,true];
	_briefcase setVariable ["mitm_briefcase_owner",objNull,true];

    // spawn debris on water surfcase, if in water
    [_briefcase] call mitm_briefcase_fnc_spawnBriefCaseContents;

},[_briefcase, _unit],0.5] call CBA_fnc_waitAndExecute;


/*_briefcase setPos _pos;*/

[SIDEUNKNOWN] call mitm_briefcase_fnc_activatePickupPoint;


if (vehicle _unit != _unit) then {
    ["mitm_notification",["BRIEFCASE","Your vehicle dropped the briefcase."]] remoteExec ["bis_fnc_showNotification",(crew vehicle _unit) - [_unit],false];
};
if (side _unit != CIVILIAN) then {
    ["mitm_notification",["BRIEFCASE","You dropped the briefcase."]] remoteExec ["bis_fnc_showNotification",_unit,false];
};
