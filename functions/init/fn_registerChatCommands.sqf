#include "component.hpp"

["mitm_accept", {MITM_SETUP_PLAYZONECONFIRMATION = true; publicVariable "MITM_SETUP_PLAYZONECONFIRMATION"}, "admin"] call CBA_fnc_registerChatCommand;
["mitm_decline", {MITM_SETUP_PLAYZONECONFIRMATION = false; publicVariable "MITM_SETUP_PLAYZONECONFIRMATION"}, "admin"] call CBA_fnc_registerChatCommand;
