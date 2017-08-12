#include "component.hpp"

params [["_message",""]];

mitm_adminMessages_channel radioChannelAdd [player];

player customChat [mitm_adminMessages_channel, _message];

mitm_adminMessages_channel radioChannelRemove [player];
