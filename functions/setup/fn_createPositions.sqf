#include "component.hpp"


//create start position
private _islandCenter = [worldSize/2,worldSize/2,0];
private _thisPos = [];
for [{_i=0}, {_i<20}, {_i=_i+1}] do {
    _thisPos = [_islandCenter,[0,worldSize/2.3],[0,360],"",false,true] call mitm_common_fnc_findRandomPos;
    if (count _thisPos > 0) exitWith {};
};
if (count _thisPos == 0) exitWith {[false,"Could not find start position."]};
MITM_STARTPOSITION_COURIER = _thisPos;


//create 7 mission positions
MITM_MISSIONPOSITIONS = [];
private _nextPos = [];
private _locationProbability = ["locationProbability",100] call mitm_common_fnc_getMissionConfigEntry;
(["locationDistances",[]] call mitm_common_fnc_getMissionConfigEntry) params ["_locMinDist","_locMaxDist"];
(["locationAngles",[]] call mitm_common_fnc_getMissionConfigEntry) params ["_locMinAngle","_locMaxAngle"];
for [{_i=0}, {_i<7}, {_i=_i+1}] do {

    private ["_thisMinAngle","_thisMaxAngle","_lastPos","_thisPos"];

    switch (_i) do {
        case (0): {
            _thisMinAngle = _locMinAngle;
            _thisMaxAngle = _locMaxAngle;
            _lastPos = [0,0,0];
            _thisPos = MITM_STARTPOSITION_COURIER;
        };
        case (1): {
            _thisMinAngle = _locMinAngle;
            _thisMaxAngle = _locMaxAngle;
            _lastPos = MITM_STARTPOSITION_COURIER;
            _thisPos = MITM_MISSIONPOSITIONS select 0;
        };
        case (2): {
            _thisMinAngle = -50;
            _thisMaxAngle = -40;
            _lastPos = MITM_MISSIONPOSITIONS select 0;
            _thisPos = MITM_MISSIONPOSITIONS select 1;
        };
        case (3): {
            _thisMinAngle = 40;
            _thisMaxAngle = 50;
            _lastPos = MITM_MISSIONPOSITIONS select 0;
            _thisPos = MITM_MISSIONPOSITIONS select 1;
        };
        case (4): {
            _thisMinAngle = 40;
            _thisMaxAngle = 50;
            _lastPos = MITM_MISSIONPOSITIONS select 1;
            _thisPos = MITM_MISSIONPOSITIONS select 2;
        };
        case (5): {
            _thisMinAngle = -50;
            _thisMaxAngle = -40;
            _lastPos = MITM_MISSIONPOSITIONS select 1;
            _thisPos = MITM_MISSIONPOSITIONS select 3;
        };
        case (6): {
            _thisMinAngle = _locMinAngle;
            _thisMaxAngle = _locMaxAngle;
            _lastPos = [MITM_MISSIONPOSITIONS select 2,MITM_MISSIONPOSITIONS select 3] call mitm_common_fnc_getAveragePosition;
            _thisPos = [MITM_MISSIONPOSITIONS select 4,MITM_MISSIONPOSITIONS select 5] call mitm_common_fnc_getAveragePosition;
        };
    };

    _nextPos = if (_locationProbability < random 100) then {
        [_lastPos,_thisPos,_locMinDist,_locMaxDist,_thisMinAngle,_thisMaxAngle] call mitm_setup_fnc_findMissionLocation;
    } else {
        [_lastPos,_thisPos,_locMinDist,_locMaxDist,_thisMinAngle,_thisMaxAngle] call mitm_setup_fnc_findMissionRoadPosition;
    };
    if (count _nextPos == 0) exitWith {};

    MITM_MISSIONPOSITIONS pushBack _nextPos;
};
if (count _nextPos == 0) exitWith {[false,"Could not find suitable next location."]};


//create startpositions
private _remainingSides = [WEST,EAST,INDEPENDENT];
private _lastMissionPos = MITM_MISSIONPOSITIONS select (count MITM_MISSIONPOSITIONS - 1);
private _middleMissionPos = [MITM_MISSIONPOSITIONS select 2,MITM_MISSIONPOSITIONS select 3,MITM_MISSIONPOSITIONS select 4,MITM_MISSIONPOSITIONS select 5] call mitm_common_fnc_getAveragePosition;
private _courierDir = [MITM_STARTPOSITION_COURIER,MITM_MISSIONPOSITIONS] call mitm_common_fnc_getAverageDirection;
private _startPos = [];
{
    _side = _remainingSides deleteAt (round random (count _remainingSides - 1));
    _startPos = [_middleMissionPos,["teamStartDistances",[]] call mitm_common_fnc_getMissionConfigEntry,[_x-15,_x+15],"",false,true] call mitm_common_fnc_findRandomPos;

    if (count _startPos == 0) exitWith {};

    _varName = ["MITM_STARTPOSITION_WEST","MITM_STARTPOSITION_EAST","MITM_STARTPOSITION_INDEP"] select ([WEST,EAST,INDEPENDENT] find _side);
    missionNamespace setVariable [_varName,_startPos];

    false
} count [_courierDir,_courierDir+90,_courierDir+270];
if (count _startPos == 0) exitWith {[false,"Could not find start position for a team."]};

MITM_PLAYZONE_CENTER = _middleMissionPos;

publicVariable "MITM_STARTPOSITION_COURIER";
publicVariable "MITM_MISSIONPOSITIONS";
publicVariable "MITM_STARTPOSITION_WEST";
publicVariable "MITM_STARTPOSITION_EAST";
publicVariable "MITM_STARTPOSITION_INDEP";
publicVariable "MITM_PLAYZONE_CENTER";


[true,"Play area setup successful"]
