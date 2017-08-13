locationDistances[] = {1000,2000};              // min and max distances for next courier location
locationAngles[] = {-45,45};                    // min and max angles for next courier position compared to old direction
locationProbability = 70;                       // probability in percent that a location is to be chosen instead of a random position near a road

teamStartDistances[] = {4000,4500};             // min and max distances to middle of courier tasks that teams will start in
startTimerEnforceDistance = 100;                // distance that a player can move from his start position before the start countdown is over

trackingInterval = 180;                         // interval in seconds in which the briefcase is marked on the map
trackingIntervalFactorNoCourier = 0.5;          // factor for tracking interval while the courier is not in possession of the briefcase
trackingIntervalFactorVehicle = 0.5;            // factor for tracking interval while briefcase is in a vehicle
