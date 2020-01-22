#include "component.hpp"

if (!isServer) exitWith {};

if ((["useParamTime",1] call EFUNC(common,getMissionConfigEntry)) == 0) exitWith {INFO("Not setting time - disabled by config.")};

//random
if (MITM_MISSIONPARAM_TIMEOFDAY == -1) then {
    MITM_MISSIONPARAM_TIMEOFDAY = selectRandom [8,9,10,11,12,13,14,15,16,17];
};

_date = [2] call mitm_common_fnc_findMaxMoonDate;
_date set [3,MITM_MISSIONPARAM_TIMEOFDAY];

[_date] call bis_fnc_setDate;
