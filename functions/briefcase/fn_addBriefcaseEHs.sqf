#include "component.hpp"

if (!hasInterface) exitWith {};

player addEventhandler ["GetInMan",{_this call mitm_briefcase_fnc_onGetIn}];
player addEventhandler ["GetOutMan",{_this call mitm_briefcase_fnc_onGetOut}];
player addEventhandler ["Killed",{_this call mitm_briefcase_fnc_onKilled}];
player addEventhandler ["AnimChanged",{_this call mitm_briefcase_fnc_onAnimChanged}];

["weapon",{_this call mitm_briefcase_fnc_onWeaponChanged}] call CBA_fnc_addPlayerEventHandler;

// weapon EH handles this, as units get "ACE_fakePrimaryWeapon" upon unconsciousness
/*["ace_unconscious", {diag_log "unconsc EH"; diag_log _this}] call CBA_fnc_addEventHandler;*/
