#include "component.hpp"

if (MITM_ISLANDPARAM_ISWOODLAND) then {
    _blufor = "mitm_blu";
    _opfor = "mitm_opf";
    _indep = "mitm_indep";
} else {
    _blufor = "mitm_blu_d";
    _opfor = "mitm_opf_d";
    _indep = "mitm_indep_d";
};

["BLU_F", _blufor] call GRAD_Loadout_fnc_FactionSetLoadout;
["OPF_F", _opfor] call GRAD_Loadout_fnc_FactionSetLoadout;
["IND_F", _indep] call GRAD_Loadout_fnc_FactionSetLoadout;
