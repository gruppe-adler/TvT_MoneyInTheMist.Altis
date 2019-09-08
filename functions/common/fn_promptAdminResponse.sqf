#include "component.hpp"

params ["_message","_timeout","_varName","_timeOutValue",["_global",false]];

[[_message,"MitM (Admin)"],{
    [{!isNull (findDisplay 46)},FUNC(customChat),_this] call CBA_fnc_waitUntilAndExecute;
}] remoteExec ["call",[] call mitm_common_fnc_getAdminID,false];

missionNamespace setVariable [_varName,nil,true];
private _onVarSet = {
    params ["_varName","_timeOutValue","_global"];
    if (isNil _varName) then {missionNamespace setVariable [_varName,_timeOutValue,_global]};
};
[{!isNil (_this select 0)},_onVarSet,[_varName,_timeOutValue,_global],_timeout,_onVarSet] call CBA_fnc_waitUntilAndExecute;
