if (!isserver) exitWith {};

private ["_theobj"];

_theobj = _this select 0;

if (isnil "A_present") then {A_present = false};
if (isnil "B_present") then {B_present = false};
if (isnil "C_present") then {C_present = false};
if (isnil "hostageSet") then {hostageSet = false};

if (hostageSet) exitWith {};

switch (_theobj) do
{
case "A":
{
A_present = true;
}; 
case "B":
{
B_present = true;
}; 
case "C":
{
C_present = true;
}; 
};

if (A_present && B_present) exitWith {hostage setpos getpos logic_C; hostageSet = true;};

if (A_present && C_present) exitWith {hostage setpos getpos logic_B; hostageSet = true;};

if (C_present && B_present) exitWith {hostage setpos getpos logic_A; hostageSet = true;};
