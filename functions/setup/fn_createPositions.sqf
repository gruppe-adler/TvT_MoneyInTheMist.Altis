#include "component.hpp"


//create start position
private _islandCenter = [worldSize/2,worldSize/2,0];
private _thisPos = [];
for [{_i=0}, {_i<20}, {_i=_i+1}] do {
    _thisPos = [_islandCenter,[0,worldSize/2.3],[0,360],"",false,true] call mitm_common_fnc_findRandomPos;
    if (count _thisPos > 0) exitWith {};
};
if (count _thisPos == 0) exitWith {[false,"Could not find start position."]};
["playArea",str _thisPos,_thisPos,"","ICON","hd_start","COLORCIVILIAN"] call mitm_debug_fnc_createDebugMarker;
MITM_STARTPOSITION_COURIER = _thisPos;


//create 5 mission positions
MITM_MISSIONPOSITIONS = [];
private _nextPos = [];
private _lastPos = [0,0,0];
private _locationProbability = ["locationProbability",100] call mitm_common_fnc_getMissionConfigEntry;
(["locationDistances",[]] call mitm_common_fnc_getMissionConfigEntry) params ["_locMinDist","_locMaxDist"];
(["locationAngles",[]] call mitm_common_fnc_getMissionConfigEntry) params ["_locMinAngle","_locMaxAngle"];
for [{_i=0}, {_i<5}, {_i=_i+1}] do {

    if (_locationProbability < random 100) then {
        _nextPos = [_lastPos,_thisPos,_locMinDist,_locMaxDist,_locMinAngle,_locMaxAngle] call mitm_setup_fnc_findMissionLocation;
    } else {
        _nextPos = [_lastPos,_thisPos,_locMinDist,_locMaxDist,_locMinAngle,_locMaxAngle] call mitm_setup_fnc_findMissionRoadPosition;
    };

    if (count _nextPos == 0) exitWith {};

    _lastPos = _thisPos;
    _thisPos = _nextPos;
    MITM_MISSIONPOSITIONS pushBack _nextPos;
    ["playArea",str _thisPos,_thisPos,str _i,"ICON","hd_dot","COLORCIVILIAN"] call mitm_debug_fnc_createDebugMarker;
};
if (count _nextPos == 0) exitWith {[false,"Could not find suitable next location."]};


//create startpositions
private _remainingSides = [WEST,EAST,INDEPENDENT];
private _lastMissionPos = MITM_MISSIONPOSITIONS select (count MITM_MISSIONPOSITIONS - 1);
private _middleMissionPos = MITM_MISSIONPOSITIONS select round ((count MITM_MISSIONPOSITIONS - 1)/2);
private _startDir = (MITM_STARTPOSITION_COURIER getDir _lastMissionPos) + 90;
private _startPos = [];
{
    _side = _remainingSides deleteAt (round random (count _remainingSides - 1));
    _startPos = [_middleMissionPos,["teamStartDistances",[]] call mitm_common_fnc_getMissionConfigEntry,[_x-15,_x+15],"",false,true] call mitm_common_fnc_findRandomPos;

    if (count _startPos == 0) exitWith {};

    _varName = ["MITM_STARTPOSITION_WEST","MITM_STARTPOSITION_EAST","MITM_STARTPOSITION_INDEP"] select ([WEST,EAST,INDEPENDENT] find _side);
    missionNamespace setVariable [_varName,_startPos];

    ["playArea",str _startPos,_startPos,"","ICON","hd_start",[_side,"MARKER"] call mitm_common_fnc_getSideColor] call mitm_debug_fnc_createDebugMarker;

    false
} count [_startDir,_startDir+180,_startDir+270];
if (count _startPos == 0) exitWith {[false,"Could not find start position for a team."]};

publicVariable "MITM_STARTPOSITION_COURIER";
publicVariable "MITM_MISSIONPOSITIONS";
publicVariable "MITM_STARTPOSITION_WEST";
publicVariable "MITM_STARTPOSITION_EAST";
publicVariable "MITM_STARTPOSITION_INDEP";

[true,"Play area setup successful"]
