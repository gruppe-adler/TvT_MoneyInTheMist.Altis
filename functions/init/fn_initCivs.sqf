#include "component.hpp"

if !(MITM_MISSIONPARAM_CIVILIANS) exitWith {};

private _islandType = ["type",""] call mitm_common_fnc_getIslandConfigEntry;

private _civCfg = missionConfigFile >> "CfgCivilians" >> _islandType;

private _clothes = [_civCfg,"clothes",[]] call BIS_fnc_returnConfigEntry;
private _headgear = [_civCfg,"headgear",[]] call BIS_fnc_returnConfigEntry;
private _faces = [_civCfg,"faces",[]] call BIS_fnc_returnConfigEntry;
private _goggles = [_civCfg,"goggles",[]] call BIS_fnc_returnConfigEntry;
private _backpacks = [_civCfg,"backpacks",[]] call BIS_fnc_returnConfigEntry;


[_clothes] call grad_civs_fnc_setClothes;
[_headgear] call grad_civs_fnc_setHeadgear;
[_faces] call grad_civs_fnc_setFaces;
[_goggles] call grad_civs_fnc_setGoggles;
[_backpacks] call grad_civs_fnc_setBackpacks;

[] call grad_civs_fnc_initModule;
