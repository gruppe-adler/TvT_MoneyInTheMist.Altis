locationDistances[] = {1000,2000};              // min and max distances for next courier location
locationAngles[] = {-45,45};                    // min and max angles for next courier position compared to old direction
locationProbability = 80;                       // probability in percent that a location is to be chosen instead of a random position near a road

teamStartDistances[] = {4000,4500};             // min and max distances to middle of courier tasks that teams will start in
startTimerEnforceDistance = 100;                // distance that a player can move from his start position before the start countdown is over

teamPickupDistances[] = {2500,3500};            // min and max distances to middle of courier tasks that team pickup tasks will be created

trackingInterval[] = {270,360};                 // interval in seconds in which the briefcase is marked on the map (min, max >> random value)
trackingIntervalFactorNoCourier = 0.5;          // factor for tracking interval while the courier is not in possession of the briefcase
trackingIntervalFactorVehicle = 0.5;            // factor for tracking interval while briefcase is in a vehicle
trackingIntervalFactorNoCarrier = 0.9;          // factor for tracking interval while briefcase has no carrier

trackingAccuracy = 250;                         // accuracy of tracking marker in m
trackingAccuracyFactorNoCourier = 0.8;          // factor for accuracy while the courier is not in possession of the briefcase (lower means better accuracy)
trackingAccuracyFactorVehicle = 0.8;            // factor for accuracy while the briefcase is in a vehicle
trackingAccuracyFactorNoCarrier = 0.2;          // factor for accuracy while no one is carrying the briefcase
trackingMarkerFadeout = 200;                    // time in s for markers to fade out


exfilAreaRadius = 120;                          // radius for the exfil area
exfilDefenseTime = 540;                         // time in s that the team with the briefcase has to defend their exfil point
exfilStopDefenseTime = 40;                      // time in s that the exfil area has to be out of control or the briefcase has left the area for the defense timer to reset

jipToSpectatorTime = 1800;                      // time after which JIP players will be moved straight to spectator

class civVehicles {
    randomFuel[] = {0.15,0.35};

    carLocationAmountFactor = 0.3;
    carLocationMinDist = 30;

    carRoadAmountFactor = 0.03;
    carRoadMinDist = 300;

    boatCoastAmountFactor = 1;
    boatTypes[] = {
        "C_Boat_Civil_01_F",
        "C_Boat_Civil_01_rescue_F",
        "C_Boat_Transport_02_F",
        "C_Scooter_Transport_01_F",
        "C_Rubberboat"
    };
};
