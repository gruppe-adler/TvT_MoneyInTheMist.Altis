params ["_civPos","_westPos","_eastPos","_indepPos","_missionPositions"];

["playZone"] call mitm_common_fnc_clearMarkerCategory;

["playZone",str _civPos,_civPos,"","ICON","mil_start","COLORCIVILIAN"] call mitm_common_fnc_createCategoryMarker;
["playZone",str _westPos,_westPos,"","ICON","mil_start","COLORWEST"] call mitm_common_fnc_createCategoryMarker;
["playZone",str _eastPos,_eastPos,"","ICON","mil_start","COLOREAST"] call mitm_common_fnc_createCategoryMarker;
["playZone",str _indepPos,_indepPos,"","ICON","mil_start","COLORGUER"] call mitm_common_fnc_createCategoryMarker;

_missionPositions = +_missionPositions;
private _lastPosition = _missionPositions deleteAt (count _missionPositions -1);
{
    ["playZone",str _x,_x,"","ICON","mil_dot","COLORCIVILIAN"] call mitm_common_fnc_createCategoryMarker;
    false
} count _missionPositions;

["playZone",str _lastPosition,_lastPosition,"","ICON","mil_end","COLORCIVILIAN"] call mitm_common_fnc_createCategoryMarker;
