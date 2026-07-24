Scriptname slaInternalModules Hidden

int function GetStaticEffectCount() global native
int function RegisterStaticEffect(string id) global native
int function GetStaticEffectId(string effectId) global native
bool function UnregisterStaticEffect(string id) global native
bool function IsStaticEffectActive(Actor who, int effectIdx) global native
int function GetDynamicEffectCount(Actor who) global native
string function GetDynamicEffect(Actor who, int number) global native
float function GetDynamicEffectValueByName(Actor who, string effectId) global native
float function GetDynamicEffectValue(Actor who, int number) global native
float function GetStaticEffectValue(Actor who, int effectIdx) global native
float function GetStaticEffectParam(Actor who, int effectIdx) global native
float function GetStaticEffectLimit(Actor who, int effectIdx) global native
int function GetStaticEffectAux(Actor who, int effectIdx) global native
float function GetStaticEffectAuxFloat(Actor who, int effectIdx) global native
function SetDynamicArousalEffect(Actor who, string effectId, float initialValue, int functionId, float param, float limit) global native
function ModDynamicArousalEffect(Actor who, string effectId, float modifier, float limit) global native
function SetStaticArousalEffect(Actor who, int effectIdx, int functionId, float param, float limit, int auxilliary) global native
function SetStaticArousalValue(Actor who, int effectIdx, float value) global native
function SetStaticAuxillaryFloat(Actor who, int effectIdx, float value) global native
function SetStaticAuxillaryInt(Actor who, int effectIdx, int value) global native
float function ModStaticArousalValue(Actor who, int effectIdx, float diff, float limit) global native
float function GetArousal(Actor who) global native
function UpdateSingleActorArousal(Actor who, float GameDaysPassed) global native

int function CleanUpActors(float lastUpdateBefore) global native

bool function GroupEffects(Actor who, int effIdx1, int effIdx2) global native
bool function RemoveEffectGroup(Actor who, int effIdx1) global native

bool function TryLock(int lockID) global native
function Unlock(int lockID) global native
Actor[] function DuplicateActorArray(Actor[] actors, int count) global native

String function FormatHex(int formId) global native