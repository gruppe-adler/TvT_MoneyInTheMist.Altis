#include "component.hpp"

if (hasInterface) then {
    _endMission = {
        _value = _this select 1;
        _value params ["_winningSide", "_endText"];

        [player, true] call TFAR_fnc_forceSpectator;

        [_winningSide,_endText] spawn {
            params ["_winningSide","_endText"];

            if (missionNamespace getVariable ["mitm_endInProgressClient", false]) exitWith {INFO("A different ending is already in progress.")};
            mitm_endInProgressClient = true;

            _winningText = switch (_winningSide) do {
                case (WEST): {"SPECIAL FORCES WIN"};
                case (EAST): {"MAFIA WINS"};
                case (INDEPENDENT): {"REBELS WIN"};
                case (CIVILIAN): {"COURIER WINS"};
            };
            _text = format ["<img size= '6' style='vertical-align:middle' shadow='false' image='data\gruppe-adler.paa'/><br/><t size='.9' color='#FFFFFF'>%1<br/>%2</t>", _endText, _winningText];
            [_text,0,0,2,2] spawn BIS_fnc_dynamicText;

            INFO(_endText);
            INFO(_winningText);

            sleep 5;

            if (!isNil "MITM_COURIERPOINTSCATEGORIZED") then {
                [[],[],[],MITM_COURIERPOINTSCATEGORIZED] call mitm_points_fnc_displayPoints;
                sleep 13;
            } else {
                systemChat "Courier points this game have not been received. Not displaying points.";
            };

            if (!isNil "MITM_COURIERSTATSCOMPILED") then {
                [15,MITM_COURIERSTATSCOMPILED,"Courier Highscore",true,[true,1,false]] call grad_scoreboard_fnc_loadScoreboard;
                sleep 16;
            } else {
                systemChat "Courier highscores have not been received. Not displaying scoreboard.";
            };

            if (!isNil "MITM_MISSIONSTATS") then {
                MITM_MISSIONSTATS call grad_scoreboard_fnc_loadScoreboard;
                sleep 18;
            } else {
                systemChat "Mission stats have not been received. Not displaying scoreboard.";
            };

            if (MITM_MISSIONPARAM_DEBUGMODE) then {
                systemChat _endText;
                systemChat _winningText;
                systemChat "Debug mode is on. End mission manually.";
            } else {
                [{["end1", _this select 0, true, true, true] spawn BIS_fnc_endMission}, [_winningSide == playerSide], 5] call CBA_fnc_waitAndExecute;
            };
        };
    };

    //dedicated
    if (!isServer) then {
        "mitm_gameEnded" addPublicVariableEventHandler _endMission;
    };

    //localhost
    if (isServer) then {
        [{count (missionNamespace getVariable ["mitm_gameEnded", []]) > 0}, {
            ["mitm_gameEnded", mitm_gameEnded] call (_this select 0);
        }, [_endMission]] call CBA_fnc_waitUntilAndExecute;
    };
};
