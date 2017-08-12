#include "component.hpp"

if (!isServer) exitWith {};

([] call mitm_setup_fnc_playArea) params ["_successful"];

if (_successful) then {
    ["Play zone setup successful. Confirm playzone with the chat command #mitm_accept or repeat the setup with #mitm_decline",15,"MITM_SETUP_PLAYZONECONFIRMATION",true,true] call mitm_common_fnc_promptAdminResponse;
    [{!isNil "MITM_SETUP_PLAYZONECONFIRMATION"}, {
        if (!MITM_SETUP_PLAYZONECONFIRMATION) then {
            [] call mitm_init_fnc_setup;
        };
    }, []] call CBA_fnc_waitUntilAndExecute;
} else {
    ["Play zone setup failed. Try again with smaller size with the chat command #mitm_retry or end mission with #mitm_abort",15,"MITM_SETUP_PLAYZONERETRY",false,false] call mitm_common_fnc_promptAdminResponse;
    [{!isNil "MITM_SETUP_PLAYZONERETRY"}, {
        if (MITM_SETUP_PLAYZONERETRY) then {
            MITM_MISSIONPARAM_SIZEFACTOR = MITM_MISSIONPARAM_SIZEFACTOR * 0.8;
            [] call mitm_init_fnc_setup;
        } else {
            "EveryoneLost" call BIS_fnc_endMissionServer;
        };
    }, []] call CBA_fnc_waitUntilAndExecute;
};
