class rebels {
    class AllUnits {
        uniform[] = {
            "LOP_U_PMC_Fatigue_04",
            "LOP_U_PMC_Fatigue_01",
            "U_I_C_Soldier_Bandit_2_F",
            "U_I_C_Soldier_Bandit_3_F",
            "U_I_C_Soldier_Para_1_F",
            "U_I_C_Soldier_Para_3_F",
            "U_I_C_Soldier_Para_4_F"
        };
        backpack[] = {
            "rhs_sidor",
            "rhs_assault_umbts"
        };
        headgear[] = {
            "H_Cap_blk",
            "H_Cap_oli",
            "H_Bandanna_gry",
            "H_Bandanna_khk",
            "H_Bandanna_cbr",
            "H_Booniehat_oli",
            "H_Booniehat_khk",
            "rhs_beanie_green",
            "H_Shemag_olive",
            "H_ShemagOpen_tan"
        };
        goggles[] = {
            "",
            "G_Bandanna_oli",
            "G_Bandanna_blk",
            "G_Bandanna_khk",
            "G_Bandanna_sport",
            "G_Bandanna_shades",
            "G_Bandanna_beast",
            "G_Bandanna_aviator",
            "rhs_scarf",
            "G_Balaclava_blk",
            "G_Balaclava_oli",
            "rhs_balaclava1_olive"
        };
        primaryWeapon[] = {
            "rhs_weap_m70b1",
            "rhs_weap_m70ab2"
        };
        primaryWeaponMagazine = "rhs_30Rnd_762x39mm";
        binoculars = "Binocular";
        map = "ItemMap";
        compass = "ItemCompass";
        watch = "ItemWatch";
        gps = "ItemGPS";
        radio = "TFAR_anprc148jem";
        addItemsToUniform[] = {
            LIST_6("ACE_fieldDressing"),
            LIST_4("ACE_morphine"),
            "ACE_epinephrine",
            "ACE_Flashlight_KSF1",
            "ACE_MapTools",
            "ACE_key_lockpick",
            "ACE_key_indp"
        };
    };
    class Type {
        //Rifleman
        class Soldier_F {
            headgear = "H_Cap_blk";
            addItemsToBackpack[] = {
                LIST_7("rhs_30Rnd_762x39mm"),
                LIST_2("rhs_mag_rdg2_white"),
                LIST_2("rhs_mag_f1")
            };
        };

        //Asst. Autorifleman
        class soldier_AAR_F: Soldier_F {
            addVest = "V_Chestrig_rgr";
            addItemsToVest[] = {
                LIST_2("rhs_100Rnd_762x54mmR"),
                LIST_1("ACE_EntrenchingTool")
            };
        };

        //Autorifleman
        class soldier_AR_F: Soldier_F {
            headgear = "";
            primaryWeapon = "rhs_weap_pkm";
            primaryWeaponMagazine = "rhs_100Rnd_762x54mmR";
            addItemsToBackpack[] = {
                LIST_2("rhs_100Rnd_762x54mmR")
            };
        };

        //Combat Life Saver
        class medic_F: Soldier_F {
            vest = "V_BandollierB_rgr";
            backpack = "rhs_medic_bag";
            addItemsToVest[] = {
                LIST_5("rhs_30Rnd_762x39mm")
            };
            addItemsToBackpack[] = {
                LIST_15("ACE_fieldDressing"),
                LIST_8("ACE_epinephrine"),
                LIST_8("ACE_morphine"),
                LIST_2("ACE_salineIV")
            };
        };

        //Rifleman (AT)
        class soldier_LAT_F: Soldier_F {
            headgear = "H_Cap_blk";
            secondaryWeapon = "rhs_weap_rpg26";
        };

        //Squad Leader
        class Soldier_SL_F: Soldier_F {
            headgear = "H_Cap_blk";
            primaryWeapon = "rhs_weap_ak103_gp25";
            primaryWeaponUnderbarrelMagazine = "rhs_GRD40_White";
            vest = "V_BandollierB_rgr";
            addItemsToVest[] = {
                LIST_2("rhs_GRD40_White"),
                LIST_2("rhs_GRD40_Red")
            };
        };

        //Team Leader
        class Soldier_TL_F: Soldier_SL_F {

        };
    };
};
