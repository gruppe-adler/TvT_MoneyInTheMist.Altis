#include "component.hpp"

if (!isServer) exitWith {};

["mitm_notification",["Move out!",format ["You have a %1 minute head start.",round (MITM_MISSIONPARAM_COURIERHEADSTART/60)]]] remoteExec ["bis_fnc_showNotification",CIVILIAN,false];
["mitm_notification",["Game starting soon.","Please don't leave the spawn area."]] remoteExec ["bis_fnc_showNotification",[WEST,EAST,INDEPENDENT],false];

MIMT_SETUP_HEADSTARTTIMELEFT = MITM_MISSIONPARAM_COURIERHEADSTART;
[{
    MIMT_SETUP_HEADSTARTTIMELEFT = MIMT_SETUP_HEADSTARTTIMELEFT - 1;
    if (MIMT_SETUP_HEADSTARTTIMELEFT < 0) exitWith {
        [_this select 1] call CBA_fnc_removePerFrameHandler;
        missionNamespace setVariable ["MIMT_SETUP_GAMESTARTED",true,true];
        ["mitm_notification",["Game started","Your enemies are on their way."]] remoteExec ["bis_fnc_showNotification",CIVILIAN,false];
    };
    [MIMT_SETUP_HEADSTARTTIMELEFT] remoteExec ["mitm_setup_fnc_preparationTimeCountdown",[WEST,EAST,INDEPENDENT],false];
    publicVariable "MIMT_SETUP_HEADSTARTTIMELEFT";

},1,[]] call CBA_fnc_addPerFrameHandler;