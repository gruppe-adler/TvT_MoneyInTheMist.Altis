params ["_briefcase"];

private _pos = getPos _briefcase;

if (!surfaceIsWater _pos || !isServer) exitWith {};

_pos params ["_posX", "_posY", "_posZ"];

private _type = if (abs (getTerrainHeightASL [_posX, _posY, 0]) > 1) then {
    "MedicalGarbage_01_3x3_v2_F"
} else {
    "MedicalGarbage_01_1x1_v1_F"
};

private _debris = createVehicle [_type, [_posX, _posY, 0], [], 0, "CAN_COLLIDE"];
_debris setDir (random 360);
_debris enableSimulationGlobal false;
_debris setPos [_posX, _posY, 0]; // necessary

[{
    params ["_args", "_handle"];
    _args params ["_debris", "_briefcase"];

    private _owner = _briefcase getVariable ["mitm_briefcase_owner",objNull];

    // delete debris if briefcase is picked up again
    if (!isNull _owner) exitWith {
        [_handle] call CBA_fnc_removePerFrameHandler;
        deleteVehicle _debris;
    };

    // slowly rotate to give at least some visual eye candy
    _debris setDir ((getDir _debris) + 0.03);
}, 0, [_debris, _briefcase]] call CBA_fnc_addPerFrameHandler;