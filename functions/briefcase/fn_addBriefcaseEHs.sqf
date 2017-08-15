#include "component.hpp"

if (!hasInterface) exitWith {};

player addEventhandler ["GetInMan",mitm_briefcase_fnc_onGetIn];
player addEventhandler ["GetOutMan",mitm_briefcase_fnc_onGetOut];
player addEventhandler ["Killed",mitm_briefcase_fnc_onKilled];
player addEventhandler ["AnimChanged",mitm_briefcase_fnc_onAnimChanged];

["weapon",mitm_briefcase_fnc_onWeaponChanged] call CBA_fnc_addPlayerEventHandler;
["ace_unconscious",mitm_briefcase_fnc_onUnconscious] call CBA_fnc_addEventHandler;
