#include "component.hpp"

private _tasksArray = MITM_SETUP_TASKSNAMESPACE getVariable ["courier_deliverTasks",[]];

private _mainComplete = {[_x] call BIS_fnc_taskState == "Succeeded"} count _tasksArray == 7;
if (_mainComplete) exitWith {
    [CIVILIAN,"BRIEFCASE DELIVERED!"] spawn EFUNC(endings,endMissionServer);
    [CIVILIAN,15,"Main Delivery"] call mitm_points_fnc_addPoints;
    [CIVILIAN] call mitm_endings_fnc_saveScore;
};

private _sideComplete = {[_x] call BIS_fnc_taskState == "Succeeded"} count _tasksArray == 4;
if (_sideComplete) then {
    {
        if ([_x] call BIS_fnc_taskState != "Succeeded") then {
            [_x,"SUCCEEDED",false] call BIS_fnc_taskSetState;
        };
        false
    } count _tasksArray;

    _lastPos = MITM_MISSIONPOSITIONS select (count MITM_MISSIONPOSITIONS - 1);

    // setting interaction time on last objective higher
    _taskParams = [_lastPos, [], 120] call mitm_courierTasks_fnc_createTaskObjects;
    _taskParams params ["",["_taskObject",objNull]];

    _taskDescription = "Make your final delivery, the Briefcase.";
    _task = [CIVILIAN,"mitm_deliver_" + (str (count MITM_MISSIONPOSITIONS-1)),[_taskDescription,"Delivery (Main)",""],_taskObject,"AUTOASSIGNED",3,true,"default"] call BIS_fnc_taskCreate;
    _tasksArray pushBack _task;

    _taskObject setVariable ["mitm_courierTasks_task",_task];
};
