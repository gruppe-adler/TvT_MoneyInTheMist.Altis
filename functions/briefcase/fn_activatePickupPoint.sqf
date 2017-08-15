#include "component.hpp"

#define PREVENT(var1,var2) (format ["mitm_prevent_%1_%2",var1,var2])

params ["_side"];

private _previousSide = missionNamespace getVariable ["mitm_briefcase_carryingSide",sideUnknown];
if (_side == _previousSide) exitWith {};
missionNamespace setVariable ["mitm_briefcase_carryingSide",_side];

private _otherSides = [WEST,EAST,INDEPENDENT,CIVILIAN] - [_side];


// civ tasks ===================================================================
private _civDeliverTasks = MITM_SETUP_TASKSNAMESPACE getVariable "courier_deliverTasks";
private _civDeliverTaskStatus = ["CANCELED","AUTOASSIGNED"] select (_side == CIVILIAN);
{
    if ([_x] call BIS_fnc_taskState != "SUCCEEDED") then {
        [_x,_civDeliverTaskStatus,false] call BIS_fnc_taskSetState;
    };
    false
} count _civDeliverTasks;

private _reclaimTask = MITM_SETUP_TASKSNAMESPACE getVariable ["reclaim",""];
if (_side == SIDEUNKNOWN) then {
    if (_reclaimTask == "") then {
        _task = [CIVILIAN,"mitm_reclaim_" + (str CIVILIAN),["You lost the briefcase. Get it back.","Pick up Briefcase",""],missionNamespace getVariable ["mitm_briefcase",objNull],"ASSIGNED",5,true,"default"] call BIS_fnc_taskCreate;
        MITM_SETUP_TASKSNAMESPACE setVariable ["reclaim",_task];
    } else {
        [_reclaimTask,"ASSIGNED",false] call BIS_fnc_taskSetState;
    };
} else {
    if (_reclaimTask != "") then {[_reclaimTask,"CANCELED",false] call BIS_fnc_taskSetState};
};



if (_side == SIDEUNKNOWN) exitWith {};


// prevent and exfil tasks =====================================================
private _taskPos = switch (_side) do {
    case (WEST): {MITM_PICKUP_WEST};
    case (EAST): {MITM_PICKUP_EAST};
    case (INDEPENDENT): {MITM_PICKUP_INDEP};
    default {objNull};
};

// update all seize tasks
{["mitm_seize_" + str _x,["CANCELED","ASSIGNED"] select (_side == CIVILIAN),_side == CIVILIAN] call BIS_fnc_taskSetState; false} count _otherSides;
["mitm_seize_" + str _side,"SUCCEEDED",true] call BIS_fnc_taskSetState;


// cancel other exfil tasks
{if (["mitm_exfil_" + str _x] call BIS_fnc_taskExists) then {["mitm_exfil_" + str _x,"CANCELED",false] call BIS_fnc_taskSetState}; false} count _otherSides;

if (_side != CIVILIAN) then {

    // create/assign new exfil task for carrier side
    if (["mitm_exfil_" + str _side] call BIS_fnc_taskExists) then {
        ["mitm_exfil_" + str _side,"ASSIGNED",true] call BIS_fnc_taskSetState;
    } else {
        [_side,"mitm_exfil_" + str _side,["You have the briefcase. Move to the exfil position and defend it until your pick up arrives.","Exfil",""],_taskPos,"ASSIGNED",5,true,"default"] call BIS_fnc_taskCreate;
    };

    // create/assign new prevention tasks for other sides
    {
        if ([PREVENT(str _x,str _side)] call BIS_fnc_taskExists) then {
            [PREVENT(str _x,str _side),"ASSIGNED",true] call BIS_fnc_taskSetState;
        } else {
            [_x,PREVENT(str _x,str _side),["The enemy has the briefcase. Prevent their exfil.","Prevent exfil",""],_taskPos,"ASSIGNED",5,true,"default"] call BIS_fnc_taskCreate;
        };
        false
    } count _otherSides;
};

// cancel all other prevent tasks
{
    private _taskOwner = _x;
    {
        _taskName = PREVENT(str _taskOwner,str _x);
        if ([_taskName] call BIS_fnc_taskExists && {_x != _side}) then {
            [_taskName,"CANCELED",false] call BIS_fnc_taskSetState;
        };
        false
    } count [WEST,EAST,INDEPENDENT,CIVILIAN];
    false
} count [WEST,EAST,INDEPENDENT,CIVILIAN];
