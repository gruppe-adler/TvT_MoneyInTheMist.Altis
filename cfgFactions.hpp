class cfgFactions {
    class special_forces {
        loadouts[] = {"special_forces_d","special_forces_w"};
        startVehicles[] = {"rhs_kamaz5350_vv","rhs_kamaz5350_vv"};
        exfilHeli = "_veh = createVehicle ['RHS_UH60M',_this select 0,[],0,'FLY'];[_veh,['standard',1],['Holder',0,'AddCargoHook_COver',0]] call BIS_fnc_initVehicle; _veh";
    };

    class mafia {
        loadouts[] = {"mafia","mafia"};
        startVehicles[] = {"RHS_Ural_Civ_03","RHS_Ural_Civ_03"};
        exfilHeli = "_veh = createVehicle ['RHS_Mi8MTV3_vdv',(_this select 0),[],0,'FLY']; [_veh,['LOP_SLA',1],['LeftDoor',0,'hide_door_hatch',0,'AddCargoHook_COver',0]] call BIS_fnc_initVehicle; _veh";
    };

    class rebels {
        loadouts[] = {"rebels","rebels"};
        startVehicles[] = {"rhs_zil131_vv","rhs_zil131_vv"};
        exfilHeli = "_veh = createVehicle ['LOP_IRAN_Mi8MTV3_UPK23',_this select 0,[],0,'FLY'];[_veh,nil,['LeftDoor',0,'hide_door_hatch',0,'AddCargoHook_COver',0]] call BIS_fnc_initVehicle; _veh";
    };

    class courier {
        loadouts[] = {"courier","courier"};
        startVehicles[] = {"RDS_Gaz24_Civ_02","RDS_Gaz24_Civ_01"};
        startVehicleContents[] = {
            {
                "B_AssaultPack_cbr",1
            },
            {
                "rhs_vest_pistol_holster",1,
                "ACE_SpraypaintGreen",1,
                "ToolKit",1
            },
            {
                "rhs_mag_9x18_8_57N181S",3,
                "rhs_mag_f1",1
            },
            {
                "rhs_weap_makarov_pm",1,
                "Binocular",1
            }
        };
    };
};
