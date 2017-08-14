#include "component.hpp"

params ["_side"];

diag_log _this;

private _previousSide = missionNamespace getVariable ["mitm_briefcase_carryingSide",sideUnknown];
if (_side == _previousSide) exitWith {};
missionNamespace setVariable ["mitm_briefcase_carryingSide",_side];

private _otherSides = [WEST,EAST,INDEPENDENT,CIVILIAN] - [_side];


//toggle other tasks
private _civDeliverTasks = MITM_SETUP_TASKSNAMESPACE getVariable "courier_deliverTasks";
switch (_side) do {
    case (CIVILIAN): {
        _reclaimTask = MITM_SETUP_TASKSNAMESPACE getVariable ["reclaim",""];
        if (_reclaimTask != "") then {[_reclaimTask,"CANCELED",false] call BIS_fnc_taskSetState};

        {["mitm_seize_" + str _x,"ASSIGNED",true] call BIS_fnc_taskSetState; false} count _otherSides;
        {
            if ([_x] call BIS_fnc_taskState != "SUCCEEDED") then {
                [_x,"AUTOASSIGNED",false] call BIS_fnc_taskSetState;
            };
            false
        } count _civDeliverTasks;
        {
            _preventTask = MITM_SETUP_TASKSNAMESPACE getVariable ["prevent_" + str _x,""];
            if (_preventTask != "") then {
                [_preventTask,"CANCELED",false] call BIS_fnc_taskSetState;
            };
            false
        } count _otherSides;
    };
    case WEST;
    case EAST;
    case (INDEPENDENT): {
        ["mitm_seize_" + str _side,"SUCCEEDED",false] call BIS_fnc_taskSetState;
        {["mitm_seize_" + str _x,"FAILED",false] call BIS_fnc_taskSetState; false} count _otherSides;
        {
            if ([_x] call BIS_fnc_taskState != "SUCCEEDED") then {
                [_x,"CANCELED",false] call BIS_fnc_taskSetState;
            };
            false
        } count _civDeliverTasks;
    };
    case (SIDEUNKNOWN): {
        _reclaimTask = MITM_SETUP_TASKSNAMESPACE getVariable ["reclaim",""];
        if (_reclaimTask != "") then {
            _task = [CIVILIAN,"mitm_reclaim_" + (str CIVILIAN),["You lost the briefcase. Get it back.","Reclaim",""],objNull,"ASSIGNED",5,true,"default"] call BIS_fnc_taskCreate;
            MITM_SETUP_TASKSNAMESPACE setVariable ["reclaim",_task];
        };

    };
};


// handle tasks for other sides
{
    _pickupTask = MITM_SETUP_TASKSNAMESPACE getVariable ["pickup_" + str _x,""];
    if (_pickupTask != "") then {
        [_pickupTask,"CANCELED",false] call BIS_fnc_taskSetState;
    };
    false
} count _otherSides;


if (_side == CIVILIAN) exitWith {};


private _taskPos = switch (_side) do {
    case (WEST): {MITM_PICKUP_WEST};
    case (EAST): {MITM_PICKUP_EAST};
    case (INDEPENDENT): {MITM_PICKUP_INDEP};
};
{
    _preventTask = MITM_SETUP_TASKSNAMESPACE getVariable ["prevent_" + str _x,""];
    if (_preventTask != "") then {
        [_preventTask,"ASSIGNED",true] call BIS_fnc_taskSetState;
        [_preventTask,_taskPos] call BIS_fnc_taskSetDestination;
    } else {
        _task = [_x,"mitm_prevent_" + (str _x),["The enemy has the briefcase. Prevent their exfil.","Prevent exfil",""],_taskPos,"ASSIGNED",5,true,"default"] call BIS_fnc_taskCreate;
        MITM_SETUP_TASKSNAMESPACE setVariable ["prevent_" + str _x,_task];
    };
    false
} count _otherSides;




// handle tasks for owning side
private _pickupTask = MITM_SETUP_TASKSNAMESPACE getVariable ["pickup_" + str _side,""];
if (_pickupTask != "") then {
    [_pickupTask,"ASSIGNED",true] call BIS_fnc_taskSetState;
} else {
    _task = [_side,"pickup_" + str _side,["You have the briefcase. Move to the exfil position and defend it until your pick up arrives.","Exfil",""],_taskPos,"ASSIGNED",5,true,"default"] call BIS_fnc_taskCreate;
    MITM_SETUP_TASKSNAMESPACE setVariable ["pickup_" + str _side,_task];
};
private _preventTask = MITM_SETUP_TASKSNAMESPACE getVariable ["prevent_" + str _side,""];
if (_preventTask != "") then {
    [_preventTask,"CANCELED",false] call BIS_fnc_taskSetState;
};
