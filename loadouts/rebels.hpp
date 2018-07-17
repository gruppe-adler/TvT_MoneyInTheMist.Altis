class rebels {
	class AllUnits {
		uniform = "LOP_U_PMC_Fatigue_04";
		vest = "";
		backpack = "rhs_sidor";
		headgear = "H_Shemag_olive";
        goggles = "";

		primaryWeapon = "rhs_weap_m70b1";
		primaryWeaponOptics = "";
        primaryWeaponMagazine = "rhs_30Rnd_762x39mm";
		primaryWeaponPointer = "";
		primaryWeaponMuzzle = "";
        primaryWeaponUnderbarrel = "";
        primaryWeaponUnderbarrelMagazine = "";

        secondaryWeapon = "";
        secondaryWeaponMagazine = "";

		handgunWeapon = "";
        handgunWeaponMagazine = "";

        binoculars = "Binocular";
		map = "ItemMap";
		compass = "ItemCompass";
		watch = "ItemWatch";
		gps = "ItemGPS";
		radio = "tf_anprc148jem";
		nvgoggles = "";

        addItemsToUniform[] = {
            LIST_6("ACE_fieldDressing"),
			LIST_4("ACE_morphine"),
			LIST_3("ACE_CableTie"),
			"ACE_epinephrine",
			"ACE_Flashlight_KSF1",
			"ACE_MapTools",
			"ACE_key_lockpick",
			"ACE_key_indp"
        };
        addItemsToVest[] = {};
        addItemsToBackpack[] = {};
    };
    class Type {
        //Rifleman
        class Soldier_F {
			headgear = "H_Cap_blk";
			goggles = "G_Bandanna_oli";
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
			goggles = "G_Balaclava_blk";
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
			goggles = "G_Bandanna_oli";
            secondaryWeapon = "rhs_weap_rpg26";
        };

        //Squad Leader
        class Soldier_SL_F: Soldier_F {
			headgear = "H_Cap_blk";
			goggles = "G_Bandanna_oli";
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
