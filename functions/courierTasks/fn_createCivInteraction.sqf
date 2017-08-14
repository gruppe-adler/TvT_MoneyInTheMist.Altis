#include "component.hpp"

params ["_civ"];

_action = ["mitm_courierTasks_deliver","Hand over delivery","",{

    params ["_civ","_caller"];

    _onComplete = {
        _args = _this select 0;
        _args params ["_civ","_caller"];
        [_civ] remoteExec ["mitm_courierTasks_fnc_onCivDeliveryComplete",2,false];
    };

    _onCancel = {
        _args = _this select 0;
        _args params ["_deadDrop","_caller"];
        hint "canceled handing over";
    };

    [6, [_civ,_caller], _onComplete, _onCancel, "Handing over..."] call ace_common_fnc_progressBar;

},{[_this select 1] call mitm_common_fnc_isCourier && {!((_this select 0) getVariable ["mitm_courierTasks_taskComplete",false])}},{},[],[0,0,0],4,[false,false,false,false,true]] call ace_interact_menu_fnc_createAction;

[_civ,0,["ACE_MainActions"],_action] call ace_interact_menu_fnc_addActionToObject;
