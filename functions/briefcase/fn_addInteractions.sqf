#include "component.hpp"

private _briefcase = mitm_briefcase;

private _action = ["mitm_briefcase_pickup","Pick up","",{

    params ["_briefcase","_caller"];
    if (currentWeapon _caller != "") then {
        _caller action ["SwitchWeapon", player, player, 99];
    };
    [_caller] remoteExec ["mitm_briefcase_fnc_attachBriefcase",2,false];

},{isNull ((_this select 0) getVariable ["mitm_briefcase_owner",objNull])},{},[],[0,0,0],2] call ace_interact_menu_fnc_createAction;
[_briefcase,0,[],_action] call ace_interact_menu_fnc_addActionToObject;



_action = ["mitm_briefcase_drop","Drop Briefcase","",{
    params ["_caller"];

    [_caller] call mitm_briefcase_fnc_dropBriefcase;

},{(_this select 0) getVariable ["mitm_briefcase_hasBriefcase",false]}] call ace_interact_menu_fnc_createAction;
["CAManBase",1,["ACE_SelfActions"],_action,true] call ace_interact_menu_fnc_addActionToClass;
