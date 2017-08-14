#include "component.hpp"

params ["_pos"];

if (!hasInterface) exitWith {};
if (side player == side ((missionNamespace getVariable ["mitm_briefcase",objNull]) getVariable ["mitm_briefcase_owner",objNull])) exitWith {};

private _lastRunTime = missionNamespace getVariable ["mitm_mission_trackerLastRuntime",0];
if (CBA_missionTime - _lastRunTime < 10) exitWith {};
missionNamespace setVariable ["mitm_mission_trackerLastRuntime",CBA_missionTime];

player say "beep_strobe";
[_pos,0.2,1,1,1,{100},7] call grad_gpsTracker_fnc_openTitle;
