#include "component.hpp"

if (!isServer) exitWith {};

["pickup_debug"] call mitm_common_fnc_clearMarkerCategory;

private _pickupDistances = ["teamPickupDistances",[1000,2000]] call mitm_common_fnc_getMissionConfigEntry;
_pickupDistances params ["_pickupDistanceMin","_pickupDistanceMax"];
private _pickupPoints = [];

{
    _successful = false;
    _currentMinDist = _pickupDistanceMin;
    _currentMaxDist = _pickupDistanceMax;
    _pos = [];
    while {!_successful} do {
        _pos = [MITM_PLAYZONE_CENTER,[_currentMinDist,_currentMaxDist],[0,360],"Land_HelipadCircle_F"] call mitm_common_fnc_findRandomPos;
        if (count _pos > 0) then {
            if ({_pos distance2D _x < _currentMinDist} count _pickupPoints == 0) then {_successful = true};
        };
        _currentMinDist = _currentMinDist * 0.8;
        _currentMaxDist = _currentMaxDist * 1.2;
    };

    _pickupPoints pushBack _pos;
    missionNamespace setVariable [_x,_pos];

    if (MITM_MISSIONPARAM_DEBUGMODE) then {
        ["pickup_debug",str _pos,_pos,_x + " (DEBUG)","ICON","hd_end","COLORUNKNOWN"] call mitm_common_fnc_createCategoryMarker;
    };
} forEach ["MITM_PICKUP_WEST","MITM_PICKUP_EAST","MITM_PICKUP_INDEP"];
