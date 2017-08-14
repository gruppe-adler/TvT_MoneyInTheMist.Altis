#include "component.hpp"

if (!isServer) exitWith {};

private _posBlu = ["spawnPosBlu",[0,0,0]] call mitm_common_fnc_getIslandConfigEntry;
private _posOpf = ["spawnPosOpf",_posBlu] call mitm_common_fnc_getIslandConfigEntry;
private _posIndep = ["spawnPosIndep",_posBlu] call mitm_common_fnc_getIslandConfigEntry;
private _posCivilian = ["spawnPosCiv",_posBlu] call mitm_common_fnc_getIslandConfigEntry;

_posBlu = _posBlu findEmptyPosition [0,20];
_posOpf = _posOpf findEmptyPosition [0,20];
_posIndep = _posIndep findEmptyPosition [0,20];

"respawn_west" setMarkerPos _posBlu;
"respawn_east" setMarkerPos _posOpf;
"respawn_guerrila" setMarkerPos _posIndep;
"respawn_civilian" setMarkerPos _posCivilian;
