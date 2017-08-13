#include "component.hpp"

params ["_pos",["_blackListTypes",[]]];

private _types = [
    "CIV", 0.5,
    "DEADDROP",0.5
];

private _blackList = +_blackListTypes;
while {count _blackList > 0} do {
    _blackListType = _blackList deleteAt 0;
    _typesID = _types find _blackListType;
    if (_typesID >= 0) then {
        _types deleteAt (_typesID + 1);
        _types deleteAt _typesID;
    };
};

if (count _types == 0) exitWith {[false,objNull,""]};
private _type = _types call BIS_fnc_selectRandomWeighted;


private _taskParams = [];
switch (_type) do {
    case ("CIV"): {
        _civ = [_pos] call mitm_courierTasks_fnc_spawnCiv;
        _veh = [_pos] call mitm_courierTasks_fnc_spawnCivStaticVehicle;
        _civ setVariable ["mitm_courierTasks_civOwnedVehicle",_veh];

        _taskParams = [!isNull _civ,_civ,format ["Meet up with %1.",name _civ]];
    };
    case ("DEADDROP"): {
        _deadDrop = [_pos] call mitm_courierTasks_fnc_createDeadDrop;
        _taskParams = [!isNull _deadDrop,_deadDrop,format ["Deposit cache in dead drop (%1).",name _deadDrop]];
    };
};

if !(_taskParams select 0) then {
    _taskParams = [_pos,_blackListTypes + [_type]] call mitm_courierTasks_fnc_createTaskObjects;
};

_taskParams
