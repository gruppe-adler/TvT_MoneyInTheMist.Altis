class cfgFactions {
    class special_forces {
        startVehicles[] = {"rhsusf_m998_d_s_2dr_halftop","rhsusf_m998_w_s_2dr_halftop"};
        exfilHeli = "_veh = createVehicle ['RHS_UH60M',_this select 0,[],0,'FLY'];[_veh,['standard',1],['Holder',0,'AddCargoHook_COver',0]] call BIS_fnc_initVehicle; _veh";
    };
    class mafia {
        startVehicles[] = {"C_Van_01_transport_F","C_Van_01_transport_F"};
        exfilHeli = "_veh = createVehicle ['RHS_Mi8MTV3_vdv',(_this select 0),[],0,'FLY']; [_veh,['LOP_SLA',1],['LeftDoor',0,'hide_door_hatch',0,'AddCargoHook_COver',0]] call BIS_fnc_initVehicle; _veh";
    };
    class rebels {
        startVehicles[] = {"LOP_AM_Landrover","LOP_AM_Landrover"};
        exfilHeli = "_veh = createVehicle ['LOP_IRAN_Mi8MTV3_UPK23',_this select 0,[],0,'FLY'];[_veh,nil,['LeftDoor',0,'hide_door_hatch',0,'AddCargoHook_COver',0]] call BIS_fnc_initVehicle; _veh";
    };
    class courier {
        startVehicles[] = {"RDS_Gaz24_Civ_02","RDS_Gaz24_Civ_01"};
    };
};
