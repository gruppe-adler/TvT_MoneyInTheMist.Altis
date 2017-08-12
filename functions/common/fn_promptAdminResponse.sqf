#include "component.hpp"

params ["_message","_timeout","_varName","_timeOutValue",["_global",false]];

_adminID = [] call mitm_common_fnc_getAdminID;
if (_adminID >= 0) then {
    [_message] remoteExec ["mitm_common_fnc_adminPrompt",_adminID,false]
} else {
    _timeout = 0;
};

missionNamespace setVariable [_varName,nil,true];
[{
    params ["_varName","_timeOutValue","_global"];
    if (!isNil _varName) then {missionNamespace setVariable [_varName,_timeOutValue,_global]};
}, [_varName,_timeOutValue,_global], _timeout] call CBA_fnc_waitAndExecute;
