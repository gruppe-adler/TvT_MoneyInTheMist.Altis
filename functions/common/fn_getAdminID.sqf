#include "component.hpp"

private _adminID = -1;
if (hasInterface && isServer) then {
    _adminID = clientOwner;
} else {
    {
        _ownerID = owner _x;
        if (admin _ownerID > 0) exitWith {_adminID = _ownerID};
        false
    } count allPlayers;
};

_adminID
