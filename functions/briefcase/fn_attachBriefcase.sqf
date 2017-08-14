#include "component.hpp"

params [["_unit",objNull],["_vehicleMode",false]];

private _briefcase = mitm_briefcase;

if (!isNull (_briefcase getVariable ["mitm_briefcase_owner",objNull])) exitWith {};
if (isNull _unit) exitWith {ERROR_1("Object to attach to is null.")};

/*[side _unit] call mitm_briefcase_fnc_activatePickupPoint;*/

private _offset = if (_vehicleMode) then {[0,0,-100]} else {[-0.03,-0.06,-0.19]};
_briefcase attachTo [_unit,_offset,"RightHand"];
_briefcase setVectorDirAndUp [[1,0,0],[0,0,1]];

[_unit,false] remoteExec ["allowSprint",_unit,false];
_unit setVariable ["mitm_briefcase_hasBriefcase",true,true];
_briefcase setVariable ["mitm_briefcase_owner",_unit];
