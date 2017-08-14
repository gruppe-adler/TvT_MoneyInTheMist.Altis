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



_action = ["mitm_briefcase_joinSide","Join side","",{
    params ["_unit","_caller"];

    _newSide = side _unit;
    _oldSide = side _caller;

    ["mitm_notification",["DEFECTED",format ["%1 joined your side.",name _caller]]] remoteExec ["bis_fnc_showNotification",_newSide,false];
    ["mitm_notification",["DEFECTED",format ["%1 left your side.",name _caller]]] remoteExec ["bis_fnc_showNotification",_oldSide,false];

    [{
        params ["_newSide","_caller"];
        _group = createGroup [_newSide,true];
        [_caller] joinSilent _group;
    },[_newSide,_caller],2] call CBA_fnc_waitAndExecute;

},{playerSide == CIVILIAN && {side (_this select 0) != side (_this select 1)} && {side (_this select 0) != CIVILIAN}}] call ace_interact_menu_fnc_createAction;
["CAManBase",0,["ACE_MainActions"],_action,true] call ace_interact_menu_fnc_addActionToClass;



_action = ["mitm_briefcase_leaveSide","Leave side","",{
    params ["_caller"];

    _newSide = playerSide;
    _oldSide = side player;

    ["mitm_notification",["DEFECTED",format ["%1 joined your side.",name _caller]]] remoteExec ["bis_fnc_showNotification",_newSide,false];
    ["mitm_notification",["DEFECTED",format ["%1 left your side.",name _caller]]] remoteExec ["bis_fnc_showNotification",_oldSide,false];

    [{
        params ["_newSide","_caller"];
        _group = createGroup [_newSide,true];
        [_caller] joinSilent _group;
    },[_newSide,_caller],2] call CBA_fnc_waitAndExecute;

},{[player] call mitm_common_fnc_isCourier && playerSide != side player}] call ace_interact_menu_fnc_createAction;
["CAManBase",1,["ACE_SelfActions"],_action,true] call ace_interact_menu_fnc_addActionToClass;
