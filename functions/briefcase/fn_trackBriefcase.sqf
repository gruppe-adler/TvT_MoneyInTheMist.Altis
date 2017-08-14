#include "component.hpp"

params ["_briefcase"];

private _accuracy = [(missionConfigFile >> "cfgMission"), "trackingAccuracy",100] call BIS_fnc_returnConfigEntry;
private _accuracyFactorNoCourier = [(missionConfigFile >> "cfgMission"), "trackingAccuracyFactorNoCourier",1] call BIS_fnc_returnConfigEntry;
private _accuracyFactorVehicle = [(missionConfigFile >> "cfgMission"), "trackingAccuracyFactorVehicle",1] call BIS_fnc_returnConfigEntry;
private _trackingMarkerFadeout = [(missionConfigFile >> "cfgMission"), "trackingMarkerFadeout",60] call BIS_fnc_returnConfigEntry;
private _intervalFactorNoCourier = [(missionConfigFile >> "cfgMission"), "trackingIntervalFactorNoCourier",1] call BIS_fnc_returnConfigEntry;
private _intervalFactorVehicle = [(missionConfigFile >> "cfgMission"), "trackingIntervalFactorVehicle",1] call BIS_fnc_returnConfigEntry;

([(missionConfigFile >> "cfgMission"), "trackingInterval",[60,70]] call BIS_fnc_returnConfigEntry) params ["_intervalMin","_intervalMax"];
private _intervalRandom = _intervalMax - _intervalMin;
_briefcase setVariable ["mitm_briefcase_currentInterval",_intervalMin + (random _intervalRandom)];

[{
    params ["_args","_handle"];
    _args params ["_briefcase","_accuracy","_accuracyFactorNoCourier","_accuracyFactorVehicle","_trackingMarkerFadeout","_intervalMin","_intervalRandom","_intervalFactorNoCourier","_intervalFactorVehicle"];

    if (isNull _briefcase) exitWith {[_handle] call CBA_fnc_removePerFrameHandler};

    _currentInterval = _briefcase getVariable ["mitm_briefcase_currentInterval",_intervalMin];;
    _currentAccuracy = _accuracy;

    _owner = _briefcase getVariable ["mitm_briefcase_owner",objNull];
    if !([_owner] call mitm_common_fnc_isCourier) then {
        _currentInterval = _currentInterval * _intervalFactorNoCourier;
        _currentAccuracy = _currentAccuracy * _accuracyFactorNoCourier;
    };

    if (!isNull objectParent _owner) then {
        _currentInterval = _currentInterval * _intervalFactorVehicle;
        _currentAccuracy = _currentAccuracy * _accuracyFactorVehicle;
    };

    _lastRun = _briefcase getVariable ["mitm_briefcase_lastMarkerTime",0];
    if (CBA_missionTime - _lastRun < _currentInterval) exitWith {};
    _briefcase setVariable ["mitm_briefcase_lastMarkerTime",CBA_missionTime];
    _briefcase setVariable ["mitm_briefcase_currentInterval",_intervalMin + (random _intervalRandom)];

    _markerPos = _briefcase getPos [random _currentAccuracy,random 360];
    diag_log [_currentAccuracy,_currentInterval,_markerPos,_briefcase];
    [_markerPos] remoteExec ["mitm_briefcase_fnc_showTracker",[WEST,EAST,INDEPENDENT],false];

    _centerMarker = createMarker [format ["mitm_briefcasemarker_center_%1",CBA_missionTime * 1000],_markerPos];
    _centerMarker setMarkerShape "ICON";
    _centerMarker setMarkerType "mil_dot";
    _centerMarker setMarkerColor "COLORUNKNOWN";
    _centerMarker setMarkerText (format ["%1",[daytime * 3600,"HH:MM"] call BIS_fnc_secondsToString]);

    _areaMarker = createMarker [format ["mitm_briefcasemarker_area_%1",CBA_missionTime * 1000],_markerPos];
    _areaMarker setMarkerShape "ELLIPSE";
    _areaMarker setMarkerColor "COLORCIV";
    _areaMarker setMarkerSize [_currentAccuracy,_currentAccuracy];
    _areaMarker setMarkerBrush "Border";

    [[_centerMarker,_areaMarker],_trackingMarkerFadeout] call mitm_common_fnc_fadeMarker;

} , 1, [_briefcase,_accuracy,_accuracyFactorNoCourier,_accuracyFactorVehicle,_trackingMarkerFadeout,_intervalMin,_intervalRandom,_intervalFactorNoCourier,_intervalFactorVehicle]] call CBA_fnc_addPerFrameHandler;

_briefcase setVariable ["mitm_briefcaseMarker_running",true];
