#include "component.hpp"

if !(isServer) exitWith {};

MITM_SETUP_TASKSNAMESPACE = [] call CBA_fnc_createNamespace;
{MITM_SETUP_TASKSNAMESPACE setVariable [str _x,[]]} forEach [WEST,EAST,INDEPENDENT,CIVILIAN];


private _taskDescription = "
Alternatively, eliminate all other forces in the area. This includes the Courier.
";
{
    _task = [_x,"mitm_eliminate_" + (str _x),[_taskDescription,"Eliminate Enemies (alt.)",""],objNull,"AUTOASSIGNED",1,false,"default"] call BIS_fnc_taskCreate;
    _tasksArray = MITM_SETUP_TASKSNAMESPACE getVariable (str _x);
    _tasksArray pushBack _task;
} forEach [WEST,EAST,INDEPENDENT];


private _taskDescription = "
Get the Briefcase under your control. Force the Courier to join your side (his ACE-Interaction) and escort him or just kill him and take the Briefcase. However killing him will increase the Briefcase's tracking frequency.<br/>
<br/>
We will give you a pick-up location once you have the briefcase.
";
{
    _task = [_x,"mitm_seize_" + (str _x),[_taskDescription,"Seize Briefcase",""],objNull,"AUTOASSIGNED",3,true,"default"] call BIS_fnc_taskCreate;
    _tasksArray = MITM_SETUP_TASKSNAMESPACE getVariable (str _x);
    _tasksArray pushBack _task;
} forEach [WEST,EAST,INDEPENDENT];



_missionPositions = +MITM_MISSIONPOSITIONS;
_tasksArray = MITM_SETUP_TASKSNAMESPACE getVariable (str CIVILIAN);
private _lastPosition = _missionPositions deleteAt (count _missionPositions -1);
{
    _taskParams = [_x] call mitm_courierTasks_fnc_createTaskObjects;
    _taskParams params ["",["_taskObject",objNull],["_taskDescription","TASK CREATION FAILED. This should not happen. Contact the admin."]];
    
    _task = [CIVILIAN,"mitm_deliver_" + (str _forEachIndex),[_taskDescription,"Delivery (side)",""],_taskObject,"AUTOASSIGNED",1,false,"default"] call BIS_fnc_taskCreate;
    _tasksArray pushBack _task;

    _taskObject setVariable ["mitm_courierTasks_task",_task];
} forEach _missionPositions;
