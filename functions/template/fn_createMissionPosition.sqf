#include "component.hpp"

if (!isServer) exitWith {};

params [["_gameLogic",objNull],["_isLastPosition",false]];

if (isNil "MITM_MISSIONPOSITIONS") then {MITM_MISSIONPOSITIONS = []};

if (_isLastPosition) then {
    MITM_MISSIONPOSITIONS pushBack (getPos _gameLogic);
} else {
    reverse MITM_MISSIONPOSITIONS;
    MITM_MISSIONPOSITIONS pushBack (getPos _gameLogic);
    reverse MITM_MISSIONPOSITIONS;
};

if (count MITM_MISSIONPOSITIONS == 7) then {
    publicVariable "MITM_MISSIONPOSITIONS";

    INFO("Mission positions set up.")
};
