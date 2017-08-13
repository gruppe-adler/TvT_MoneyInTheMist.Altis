#include "component.hpp"

params ["_pos"];

private _types = [
    "SMALL TREE",
    "FENCE",
    "WALL",
    "HIDE"
];

private _possibleObjects = [];
for [{_i=0}, {_i<10}, {_i=_i+1}] do {
    _searchPos = [_pos,[10,40],[0,360],""] call mitm_common_fnc_findRandomPos;
    _possibleObjects = nearestTerrainObjects [_searchPos,_types,20,false,false];
    if (count _possibleObjects > 0) exitWith {};
};
if (count _possibleObjects == 0) exitWith {objNull};

private _deadDrop = selectRandom _possibleObjects;
private _deadDropLogic = createAgent ["Logic",getPos _deadDrop,[],0,"CAN_COLLIDE"];
["Logic", 0] call ace_interact_menu_fnc_addMainAction;


_action = ["mitm_courierTasks_deposit","Deposit Cache","",{

    params ["_deadDropLogic","_caller"];

    [_caller,(configFile >> "ACE_Repair" >> "Actions" >> "MiscRepair")] call mitm_common_fnc_doAnimation;

    _onComplete = {
        _args = _this select 0;
        _args params ["_deadDropLogic","_caller"];
        [_deadDropLogic getVariable ["mitm_courierTasks_task",""],"SUCCEEDED",true] spawn BIS_fnc_taskSetState;
        [_caller] call mitm_common_fnc_stopAnimation;
    };

    _onCancel = {
        _args = _this select 0;
        _args params ["_deadDrop","_caller"];
        [_caller] call mitm_common_fnc_stopAnimation;
    };

    [20, [_deadDropLogic,_caller], _onComplete, _onCancel, "Hiding Cache..."] call ace_common_fnc_progressBar;

},{[_this select 1] call mitm_common_fnc_isCourier}] call ace_interact_menu_fnc_createAction;


[_deadDropLogic,0,["ACE_MainActions"],_action] call ace_interact_menu_fnc_addActionToObject;

_deadDropLogic
