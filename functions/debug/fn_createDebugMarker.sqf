#include "component.hpp"

if (!MITM_MISSIONPARAM_DEBUGMODE) exitWith {};

params ["_categoryName","_name","_pos",["_text",""],["_shape","ICON"],["_type","hd_dot"],["_color","COLORBLACK"]];

private _marker = createMarker [_name,_pos];
_marker setMarkerText _text;
_marker setMarkerShape _shape;
_marker setMarkerType _type;
_marker setMarkerColor _color;


if (isNil "MITM_DEBUGNAMESPACE") then {MITM_DEBUGNAMESPACE = [] call CBA_fnc_createNamespace};
if (isNil {MITM_DEBUGNAMESPACE getVariable _categoryName}) then {MITM_DEBUGNAMESPACE setVariable [_categoryName,[]]};

private _category = MITM_DEBUGNAMESPACE getVariable _categoryName;
_category pushBack _marker;
