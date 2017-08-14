#include "component.hpp"

private _taskArray = MITM_SETUP_TASKSNAMESPACE getVariable (str CIVILIAN);

private _mainComplete = {[_x] call BIS_fnc_taskState == "Succeeded"} count _taskArray == 7;
if (_mainComplete) exitWith {
    missionNamespace setVariable ["mitm_endInProgressServer",true];
    missionNamespace setVariable ["mitm_gameEnded", [CIVILIAN, "BRIEFCASE DELIVERED!"], true];
};

private _sideComplete = {[_x] call BIS_fnc_taskState == "Succeeded"} count _taskArray == 4;
if (_sideComplete) then {
    {
        if ([_x] call BIS_fnc_taskState != "Succeeded") then {
            [_x,"SUCCEEDED",false] call BIS_fnc_taskSetState;
        };
        false
    } count _taskArray;

    _lastPos = MITM_MISSIONPOSITIONS select (count MITM_MISSIONPOSITIONS - 1);

    _taskParams = [_lastPos] call mitm_courierTasks_fnc_createTaskObjects;
    _taskParams params ["",["_taskObject",objNull],["_taskDescription","TASK CREATION FAILED. This should not happen. Contact the admin."]];

    _taskDescription = "Make your final delivery, the Briefcase.";
    _task = [CIVILIAN,"mitm_deliver_" + (str (count MITM_MISSIONPOSITIONS-1)),[_taskDescription,"Delivery (Main)",""],_taskObject,"AUTOASSIGNED",3,false,"default"] call BIS_fnc_taskCreate;
    _taskArray pushBack _task;

    _taskObject setVariable ["mitm_courierTasks_task",_task];
};
