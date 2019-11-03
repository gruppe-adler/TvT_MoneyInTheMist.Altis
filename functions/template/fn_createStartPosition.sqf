#include "component.hpp"

if (!isServer) exitWith {};

params [["_gameLogic",objNull],["_side",sideUnknown]];

private _pos = getPos _gameLogic;

switch (_side) do {
    case (CIVILIAN): {
        MITM_STARTPOSITION_COURIER = _pos;
    };
    case (WEST): {
        MITM_STARTPOSITION_WEST = _pos;
    };
    case (EAST): {
        MITM_STARTPOSITION_EAST = _pos;
    };
    case (INDEPENDENT): {
        MITM_STARTPOSITION_INDEP = _pos;
    };
};

if ({isNil "_x"} count ["MITM_STARTPOSITION_COURIER","MITM_STARTPOSITION_WEST","MITM_STARTPOSITION_EAST","MITM_STARTPOSITION_INDEP"] == 0) then {

    MITM_PLAYZONE_CENTER = [MITM_STARTPOSITION_WEST,MITM_STARTPOSITION_EAST,MITM_STARTPOSITION_INDEP,MITM_STARTPOSITION_COURIER] call EFUNC(common,getAveragePosition);

    publicVariable "MITM_STARTPOSITION_COURIER";
    publicVariable "MITM_STARTPOSITION_WEST";
    publicVariable "MITM_STARTPOSITION_EAST";
    publicVariable "MITM_STARTPOSITION_INDEP";
    publicVariable "MITM_PLAYZONE_CENTER";

    INFO("Start positions set up.");
};
