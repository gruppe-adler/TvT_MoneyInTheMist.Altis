params ["_civPos","_westPos","_eastPos","_indepPos","_missionPositions"];

["playArea"] call mitm_debug_fnc_clearDebugMarkers;

["playArea",str _civPos,_civPos,"","ICON","mil_start","COLORCIVILIAN"] call mitm_debug_fnc_createDebugMarker;
["playArea",str _westPos,_westPos,"","ICON","mil_start","COLORWEST"] call mitm_debug_fnc_createDebugMarker;
["playArea",str _eastPos,_eastPos,"","ICON","mil_start","COLOREAST"] call mitm_debug_fnc_createDebugMarker;
["playArea",str _indepPos,_indepPos,"","ICON","mil_start","COLORGUER"] call mitm_debug_fnc_createDebugMarker;

{
    ["playArea",str _x,_x,"","ICON","mil_dot","COLORCIVILIAN"] call mitm_debug_fnc_createDebugMarker;
    false
} count _missionPositions;
