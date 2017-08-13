#include "component.hpp"

params [["_obj",objNull]];

if (isNull _obj) exitWith {false};

_obj == missionNamespace getVariable ["mitm_courier",objNull]
