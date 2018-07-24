#include "ctrlCredits.sqf"

_terForum = parseText "<a underline='true' color='#0000FF' href='https://forums.bistudio.com/profile/1139559-7erra/'>BIS Forum profile</a>";
_txtTerraForum ctrlSetStructuredText _terForum;

_L16 = parseText "<a underline='true' color='#0000FF' href='http://www.vlehrbrig16.de/'>ArmA3 Unit</a>";
_txtUnit ctrlSetStructuredText _L16;

_dreadForum = parseText "<a underline='true' color='#0000FF' href='https://forums.bistudio.com/profile/797731-dreadedentity/'>DreadedEntity BIS profile</a>";
_txtDreadForum ctrlSetStructuredText _dreadForum;

_topic = parseText "<a underline='true' color='#0000FF' href='https://forums.bistudio.com/forums/topic/187668-code-snippet-extracting-full-classes-from-config/'>Topic link</a>";
_txtTopic ctrlSetStructuredText _topic;

