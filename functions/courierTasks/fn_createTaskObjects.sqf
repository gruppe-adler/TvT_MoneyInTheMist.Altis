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
        [_civ] remoteExec ["mitm_courierTasks_fnc_createCivInteraction",0,true];
        _trigger = [
            _civ,
            ["ANYPLAYER","PRESENT",true],
            {(missionNamespace getVariable ['mitm_courier',objNull]) in (_this select 1)},
            {
                private _taskObject = (_this select 0) getVariable ["mitm_common_triggerAttachObject",objNull];
                [_taskObject,(missionNamespace getVariable ['mitm_courier',objNull])] call mitm_courierTasks_fnc_civOnVisible;
            }
        ] call mitm_common_fnc_createTrigger;
        _civ setVariable ["mitm_courierTasks_trigger",_trigger];

        _taskParams = [!isNull _civ,_civ,format ["Meet up with %1.",name _civ]];
    };


    case ("DEADDROP"): {
        _deadDropLogic = [_pos] call mitm_courierTasks_fnc_createDeadDrop;
        [_deadDropLogic] remoteExec ["mitm_courierTasks_fnc_createDeadDropInteraction",0,true];
        _trigger = [
            _deadDropLogic,
            ["ANYPLAYER","PRESENT",true],
            {(missionNamespace getVariable ['mitm_courier',objNull]) in (_this select 1)},
            {[(_this select 0) getVariable ["mitm_common_triggerAttachObject",objNull],"Dead Drop",10] remoteExec ["mitm_common_fnc_temp3dMarker",missionNamespace getVariable ["mitm_courier",objNull],false]}
        ] call mitm_common_fnc_createTrigger;
        _deadDropLogic setVariable ["mitm_courierTasks_trigger",_trigger];

        _taskParams = [!isNull _deadDropLogic,_deadDropLogic,"Deposit cache in dead drop."];
    };


};

if !(_taskParams select 0) then {
    _taskParams = [_pos,_blackListTypes + [_type]] call mitm_courierTasks_fnc_createTaskObjects;
};

_taskParams
