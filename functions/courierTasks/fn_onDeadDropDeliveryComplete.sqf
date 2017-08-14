#include "component.hpp"

params ["_deadDropLogic"];

[_deadDropLogic getVariable ["mitm_courierTasks_task",""],"SUCCEEDED",true] spawn BIS_fnc_taskSetState;
_deadDropLogic setVariable ["mitm_courierTasks_taskComplete",true,true];
deleteVehicle (_deadDropLogic getVariable ["mitm_courierTasks_trigger",objNull]);

[] call mitm_courierTasks_fnc_checkCourierTasksComplete;
