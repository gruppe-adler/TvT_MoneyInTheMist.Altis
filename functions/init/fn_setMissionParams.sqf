#include "component.hpp"

MITM_MISSIONPARAM_DEBUGMODE = ("DebugMode" call BIS_fnc_getParamValue) == 1;
MITM_MISSIONPARAM_CIVILIANS = ("Civilians" call BIS_fnc_getParamValue) == 1;
MITM_MISSIONPARAM_SIZEFACTOR = ("AreaSize" call BIS_fnc_getParamValue) / 10;

MITM_MISSIONPARAM_WEATHERSETTING = "WeatherSetting" call BIS_fnc_getParamValue;
MITM_MISSIONPARAM_TIMEOFDAY = "TimeOfDay" call BIS_fnc_getParamValue;
MITM_MISSIONPARAM_COURIERHEADSTART = "CourierHeadStart" call BIS_fnc_getParamValue;
