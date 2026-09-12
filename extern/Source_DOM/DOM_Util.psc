ScriptName DOM_Util hidden
{Global Utility Functions for DOM}
Import Utility

; ### Utility

Function LogUtil(string msg) Global
	Debug.Trace("DOM_Util: "+msg)
EndFunction

bool Function IsTogetherWithFast(ObjectReference subject_ref, ObjectReference object_ref, float distance = 10000.0) Global
	; -=TAK=- Same as above without utility cell check
	; Skyrim units 10 000 = 142 m

	If object_ref.IsInInterior()
		if !subject_ref.IsInInterior()
			return false
		endif
		if subject_ref.GetParentCell() != object_ref.GetParentCell()
			return false
		endif
		if subject_ref.GetDistance(object_ref) < distance
			return true
		endif
		return false
	endif

	; else object is not in interior
	if subject_ref.IsInInterior()
		return false
	endif
	if subject_ref.GetWorldSpace() != object_ref.GetWorldSpace()
		return false
	endif
	return subject_ref.GetDistance(object_ref) < distance
EndFunction

float Function GetObjectDistance(ObjectReference subject_ref, ObjectReference object_ref) Global
	; -=TAK=- Same as above without utility cell check
	; Skyrim units 10 000 = 142 m

	If object_ref.IsInInterior()
		if !subject_ref.IsInInterior()
			return -1.0
		endif
		if subject_ref.GetParentCell() != object_ref.GetParentCell()
			return -1.0
		endif
		return subject_ref.GetDistance(object_ref) 
	endif

	; else object is not in interior
	if subject_ref.IsInInterior()
		return -1.0
	endif
	if subject_ref.GetWorldSpace() != object_ref.GetWorldSpace()
		return -1.0
	endif
	return subject_ref.GetDistance(object_ref)
EndFunction

string Function GetLocationName(Actor akRef) Global
	if akRef == None
		return "the wilderness"
	endif
	Location the_loc = akRef.GetCurrentLocation()
	if the_loc == None
		Cell parentCell = akRef.GetParentCell()
		if parentCell != None
			string the_place = parentCell.GetName()
			if the_place != ""
				return the_place
			endif
		endif
		return "the wilderness"
	endif
	string the_name = the_loc.GetName()
	if the_name == ""
		Cell parentCell = akRef.GetParentCell()
		if parentCell != None
			string the_place = parentCell.GetName()
			if the_place != ""
				return the_place
			endif
		endif
		return "the wilderness"
	endif
	return the_name
EndFunction

string Function GetLocationTypeName(int location_type) Global
	if location_type == 1
		return "dungeon"
	elseif location_type == 2
		return "city"
	endif
	return "wilderness"
EndFunction

Function RemoveFromFaction(Actor akRef, Faction the_faction) Global
	if the_faction == None
		return
	endif
	if !akRef.IsInFaction(the_faction)
		return
	endif
	akRef.RemoveFromFaction(the_faction)
EndFunction

string Function DiffAsString(float x2, float x1) Global
	if x2 >= x1
		return "+"+(x2-x1)
	endif
	return "-"+(x1-x2)
EndFunction

string Function AddStringsWithComma(string s1, string s2) Global
	if s1 == ""
		return s2
	endif
	return s1+", "+s2
EndFunction

float Function getMax(float value1, float value2) Global
	if value1 > value2
		return value1
	endif
	return value2
EndFunction

int Function GetWeatherType(Actor akRef) Global
	if akRef.IsInInterior()
		return -2
	endif
	;		if wClass == 3     ; weather class: snow
	;		elseif wClass == 2 ; weather class: rain
	;		elseif wClass == 1 ; weather class: cloudy
	;		elseif wClass == 0 ; weather class: pleasant
	;		else               ; no current weather
	Weather currentWeather = Weather.GetCurrentWeather()
	if currentWeather != None
		int wClass = currentWeather.GetClassification() 
		return wClass
	endif
	return -1
EndFunction

Function StandUpActor(Actor akRef) Global
	int sitState = akRef.GetSitState()
	if sitState>0
		LogUtil("Animation: StandUpActor() ExitChairFront "+akRef.GetDisplayName())
		if sitState!=4 ; 4=already standing up
			Debug.SendAnimationEvent(akRef,"ExitChairFront")
		endif
		Wait(2.0)
		return
	endif
	int sleepState = akRef.GetSleepState()
	if sleepState>0
		LogUtil("Animation: StandUpActor() ExitBed "+akRef.GetDisplayName())
		if sleepState!=4 ; 4=already waking up
			Debug.SendAnimationEvent(akRef,"ExitBed")
		endif
		Wait(2.0)
		return
	endif
	if akRef.IsOnMount()
		akRef.Dismount()
		Wait(2.0)
	endif
EndFunction

Function CalmActor(Actor akRef) Global
	akRef.StopCombatAlarm()
	if akRef.IsInCombat()
		akRef.StopCombat()
		Wait(1.0)
	endif
	if akRef.IsWeaponDrawn()
		akRef.SheatheWeapon()
		Wait(1.0)
	endif
	if akRef.IsSneaking()
		akRef.StartSneaking()
		Wait(1.0)
	endif
EndFunction

Function CalmActorFast(Actor akRef) Global
	akRef.StopCombatAlarm()
	if akRef.IsInCombat()
		akRef.StopCombat()
	endif
	if akRef.IsWeaponDrawn()
		akRef.SheatheWeapon()
	endif
	if akRef.IsSneaking()
		akRef.StartSneaking()
	endif
EndFunction

Function FaceActor(Actor akRef, Actor akOther) Global
	Float pz = akRef.GetHeadingAngle(akOther) ; +180.0 if heading away from object
	akRef.SetAngle(akRef.GetAngleX(), akRef.GetAngleY(), akRef.GetAngleZ() + pz)
EndFunction

Function BackActor(Actor akRef, Actor akOther) Global
	Float pz = akRef.GetHeadingAngle(akOther)+180.0 
	akRef.SetAngle(akRef.GetAngleX(), akRef.GetAngleY(), akRef.GetAngleZ() + pz)
EndFunction

Function FrontActor(Actor akRef, Actor akOther) Global
	; Place Actor in front of other actor
	Float distance = 64.0
	Float az = akOther.GetAngleZ() ; +180.0 if from behind or use a negative distance
	akRef.MoveTo(akOther, distance * Math.Sin(az), distance * Math.Cos(az),1.0,false) ; do not match rotation
	Float pz = akRef.GetHeadingAngle(akOther)  ; +180.0 ; if heading away from object
	akRef.SetAngle(akRef.GetAngleX(), akRef.GetAngleY(), akRef.GetAngleZ() + pz)
EndFunction

Function MoveToFrontActor(Actor akRef, Actor akOther, Float distance = 64.0) Global
	; Place Actor in front of player without changing angle
	;*ogTrace("MoveToFrontActor "+distance)
	Float az = akOther.GetAngleZ() ; +180.0 if from behind or use a negative distance
	akRef.MoveTo(akOther, distance * Math.Sin(az), distance * Math.Cos(az),1.0,false) ; do not match rotation
EndFunction

Function MoveToFrontActorSide(Actor akRef, Actor akOther, Float distance = 64.0, Float side_step = 32.0) Global
	; Place Actor in front of player without changing angle
	;*ogTrace("MoveToFrontActorSide "+distance)
	Float az = akOther.GetAngleZ() ; +180.0 if from behind or use a negative distance
	akRef.MoveTo(akOther, distance * Math.Sin(az) + side_step * Math.Cos(az), distance * Math.Cos(az) + side_step * Math.Sin(az),1.0,false) ; do not match rotation
EndFunction

; this is used to fill the placeOfOriginNames array in DOM_Diary
string Function GetPlaceOfOriginNameByIndex(int idx) global
	if idx == 1
		return "the East March"
	endif
	if idx == 2
		return "Falkreath"
	endif
	if idx == 3
		return "Haafingar"
	endif
	if idx == 4
		return "Hjaalmarch"
	endif
	if idx == 5
		return "the Pale"
	endif
	if idx == 6
		return "the Reach"
	endif
	if idx == 7
		return "the Rift"
	endif
	if idx == 8
		return "Whiterun"
	endif
	if idx == 9
		return "Winterhold"
	endif
	if idx == 10
		return "the Orc Strongholds"
	endif
	if idx == 11
		return "Cidhna Mine"
	endif
	if idx == 12
		return "the Throat of the World"
	endif
	if idx == 13
		return "Cyrodiil"
	endif
	if idx == 14
		return "Tamriel" ; "the Khajiit Caravans"
	endif
	if idx == 15
		return "Bruma"
	endif
	return "Skyrim"
EndFunction

; this is used to fill the jobOfOriginNames array in DOM_Diary
string Function GetJobOfOriginNameByIndex(int idx, bool isFemale) global
	if idx == 1
		return "a Jarl"
	elseif idx == 2
		if isFemale
			return "a Noble woman"
		endif
		return "a Noble man"
	elseif idx == 3
		return "an Exiled"
	elseif idx == 4
		return "a Bandit"
	elseif idx == 5
		return "a Forsworn"
	elseif idx == 6
		return "a member of the imperial legion"
	elseif idx == 7
		return "a member of the stormcloaks"
	elseif idx == 8
		return "a member of the dark brotherhood"
	elseif idx == 9
		return "a member of the thieves guild"
	elseif idx == 10
		return "a member of the companions"
	elseif idx == 11
		return "a wild werewolf"
	elseif idx == 12
		return "a member of the silver hand"
	elseif idx == 13
		return "a member of the blades"
	elseif idx == 14
		return "a vigilant of Stendarr"
	elseif idx == 15
		return "a member of the Arena"
	elseif idx == 16
		return "a thalmor"
	elseif idx == 17
		return "a necromancer"
	elseif idx == 18
		return "a warlock "
	elseif idx == 19
		return "a vampire"
	elseif idx == 20
		return "a Wizard"
	elseif idx == 21
		return "a Justiciar"
	elseif idx == 22
		return "a Priest"
	elseif idx == 23
		return "a Wise woman"
	elseif idx == 24
		return "a Steward"
	elseif idx == 25
		return "a Bard"
	elseif idx == 26
		return "a Jeweler"
	elseif idx == 27
		return "an Apothecary"
	elseif idx == 28
		return "a Tailor"
	elseif idx == 29
		return "a Merchant"
	elseif idx == 30
		return "a Caravan merchant"
	elseif idx == 31
		return "a Fletcher" ; bow and arrows maker
	elseif idx == 32
		return "a Blacksmith"
	elseif idx == 33
		return "a Farmer"
	elseif idx == 34
		return "a Hunter"
	elseif idx == 35
		return "a Lumberjack"
	elseif idx == 36
		return "a Miner"
	elseif idx == 37
		return "a Guard"
	elseif idx == 38
		return "a beggar"
	elseif idx == 39
		return "a fence"
	elseif idx == 40
		return "an inn keeper"
	elseif idx == 41
		return "an inn servant"
	elseif idx == 49
		return "a Hagraven"
	; Wenches
	elseif idx == 50
		return "a travelling wench"
	elseif idx == 51
		return "a travelling servant"
	elseif idx == 52
		return "a travelling bodyguard"	
	; Slaves and slavers
	elseif idx == 100
		return "merely a piece of meat used by vampires"
	elseif idx == 101
		return "sold as a slave"
	elseif idx == 102
		return "a slave of Hydra"
	elseif idx == 103
		return "a bandit's slave"
	elseif idx == 104
		return "a bandit's slave fugitive"
	elseif idx == 105
		return "a slave"
	elseif idx == 106
		return "a slaver"
	endif
	return ""
EndFunction

string Function GetEmployerOfOriginNameByIndex(int idx) global
	if idx == 1
		return "the White Hall of Dawnstar"
	elseif idx == 2
		return "Falkreath Jarl's Longhouse"
	elseif idx == 3
		return "Markarth's Keep"
	elseif idx == 4
		return "Morthal's Longhouse"
	elseif idx == 5
		return "Riften's Mistveil Keep"
	elseif idx == 6
		return "Solitude's Blue Palace"
	elseif idx == 7
		return "Whiterun's Dragonsreach"
	elseif idx == 8
		return "Windhelm Palace"
	elseif idx == 9
		return "Winterhold Jarl's Longhouse"
	endif
	return ""
EndFunction

string Function GetClassOfOriginNameByIndex(int i) global
	if i == 1
		return "Archer"
	elseif i == 18
		return "Assassin"
	elseif i == 28
		return "Bandit"
	elseif i == 5
		return "Barbarian"
	elseif i == 17
		return "Bard"
	elseif i == 24
		return "Blade"
	elseif i == 9
		return "Conjurer"
	elseif i == 29
		return "Elementalist"
	elseif i == 35
		return "Flame"
	elseif i == 36
		return "Frost"
	elseif i == 26
		return "Guard"
	elseif i == 6
		return "Hero"
	elseif i == 8
		return "Mage"
	elseif i == 4
		return "Melee"
	elseif i == 2
		return "Missile"
	elseif i == 14
		return "Monk"
	elseif i == 16
		return "Mystic"
	elseif i == 30
		return "Necromancer"
	elseif i == 19
		return "Nightblade"
	elseif i == 31
		return "Nightingale"
	elseif i == 33
		return "Predator"
	elseif i == 34
		return "" ; "Animal"
	elseif i == 13
		return "Priest"
	elseif i == 23
		return "Ranger"
	elseif i == 20
		return "Rogue"
	elseif i == 22
		return "Scout"
	elseif i == 15
		return "Shaman"
	elseif i == 32
		return "Spellsword"
	elseif i == 27
		return "Soldier"
	elseif i == 10
		return "Sorcerer"
	elseif i == 37
		return "Storm"
	elseif i == 21
		return "Thief"
	elseif i == 25
		return "Vigilant"
	elseif i == 11
		return "Warlock"
	elseif i == 3
		return "Warrior"
	elseif i == 7
		return "Wizard"
	elseif i == 12
		return "Witchblade"
	endif
	return ""
EndFunction

string Function GetTrainerOfOriginNameByIndex(int idx) global
	; Magic
	if idx == 1
		return "Alteration"
	elseif idx == 2
		return "Conjuration"
	elseif idx == 3
		return "Destruction"
	elseif idx == 4
		return "Illusion"
	elseif idx == 5
		return "Restoration"
	; Knowledge
	elseif idx == 6
		return "Enchanting"
	elseif idx == 7
		return "Alchemy"
	elseif idx == 8
		return "Speechcraft"
	elseif idx == 9
		return "Smithing"
	; Fighting
	elseif idx == 10
		return "One-Handed weapons"
	elseif idx == 11
		return "Two-handed weapons"
	elseif idx == 12
		return "Block"
	elseif idx == 13
		return "Heavy Armor"
	; Stealth
	elseif idx == 14
		return "Light Armor"
	elseif idx == 15
		return "Marksman"
	elseif idx == 16
		return "Sneak"
	elseif idx == 17
		return "Lockpicking"
	elseif idx == 18
		return "Pickpocket"
	endif
	return ""
EndFunction

string Function GetElapsedTimeString(float origin_time) Global
	if origin_time == 0.0
		return "I can't remember when"
	endif
	float elapsed_time = GetCurrentGameTime()-origin_time
	if elapsed_time < 0.0
		return "in the future"
	endif
	if elapsed_time < 1.0
		float t_hours = elapsed_time*24.0
		if t_hours < 0.84
			float t_mins = t_hours*60.0
			if t_mins < 5.0
				return "just now"
			elseif t_mins < 24.0
				return "a few minutes ago"
			else
				return "less than an hour ago"
			endif
		elseif t_hours < 1.24
			return "an hour ago"
		elseif t_hours < 20.4
			return "a few hours ago"
		elseif t_hours < 23.8
			return "almost a day ago"
		else
			return "a day ago"
		endif
	elseif elapsed_time < 1.24
		return "a day ago"
	elseif elapsed_time < 1.84
		return "more than a day ago"
	elseif elapsed_time < 2.24
		return "two days ago"
	elseif elapsed_time < 6.12
		return "a few days ago"
	elseif elapsed_time < 8.42
		return "a week ago"
	elseif elapsed_time < 11.09
		return "more than a week ago"
	elseif elapsed_time < 20.64
		return "two weeks ago"
	elseif elapsed_time < 50.11
		return "a month ago"
	elseif elapsed_time < 90.36
		return "two months ago"
	elseif elapsed_time < 150.36
		return "a few months ago"
	elseif elapsed_time < 300.01
		return "months ago"
	elseif elapsed_time < 407.56
		return "a year ago"
	elseif elapsed_time < 666.66
		return "more than a year ago"
	elseif elapsed_time < 800.08
		return "two years ago"
	elseif elapsed_time < 1000.01
		return "a few years ago"
	elseif elapsed_time < 10000.1
		return "a long time ago"	
	endif
	; if we are here, something went wrong
	return "in the future"
EndFunction

string Function GetDifferenceTimeString(float before_time, float origin_time) Global
	if origin_time == 0.0
		return "right after"
	endif
	if before_time == 0.0
		return "immediately after"
	endif
	float elapsed_time = before_time-origin_time
	if elapsed_time < 1.0
		return "the very same day"
	endif
	if elapsed_time < 2
		return "about a day after"
	elseif elapsed_time < 3
		return "about two days after"
	elseif elapsed_time < 6.12
		return "a few days after"
	elseif elapsed_time < 8.42
		return "about a week after"
	elseif elapsed_time < 20.64
		return "two weeks after"
	elseif elapsed_time < 50.11
		return "about a month after"
	elseif elapsed_time < 90.36
		return "about two months after"
	elseif elapsed_time < 150.36
		return "a few months after"
	elseif elapsed_time < 300.01
		return "many months after"
	elseif elapsed_time < 407.56
		return "about a year after"
	elseif elapsed_time < 666.66
		return "more than a year after"
	elseif elapsed_time < 800.08
		return "about two years after"
	elseif elapsed_time < 1000.01
		return "a few years after"
	elseif elapsed_time < 10000.1
		return "a long time after"	
	endif
	; if we are here, something went wrong
	return "a very long time after"
EndFunction

string Function GetDifferenceTimeStringCaps(float before_time, float origin_time) Global
	if origin_time == 0.0
		return "Right after"
	endif
	if before_time == 0.0
		return "Immediately after"
	endif
	float elapsed_time = before_time-origin_time
	if elapsed_time < 1.0
		return "The very same day"
	endif
	if elapsed_time < 2
		return "About a day after"
	elseif elapsed_time < 3
		return "About two days after"
	elseif elapsed_time < 6.12
		return "A few days after"
	elseif elapsed_time < 8.42
		return "About a week after"
	elseif elapsed_time < 20.64
		return "Two weeks after"
	elseif elapsed_time < 50.11
		return "About a month after"
	elseif elapsed_time < 90.36
		return "About two months after"
	elseif elapsed_time < 150.36
		return "A few months after"
	elseif elapsed_time < 300.01
		return "Many months after"
	elseif elapsed_time < 407.56
		return "About a year after"
	elseif elapsed_time < 666.66
		return "More than a year after"
	elseif elapsed_time < 800.08
		return "About two years after"
	elseif elapsed_time < 1000.01
		return "A few years after"
	elseif elapsed_time < 10000.1
		return "A long time after"	
	endif
	; if we are here, something went wrong
	return "A very long time after"
EndFunction

; SL tags

string Function AddTag(string tags, string value) Global
	if tags == ""
		return value
	endif
	return tags + "," + value
EndFunction

bool Function HasTag(string[] Tags, string Tag) Global
	return Tag != "" && Tags.Find(Tag) != -1
EndFunction

bool Function StringHasTag(string Tags, string Tag) Global
	if stringUtil.find(Tags,Tag)>=0
		return true
	endif
	return false
EndFunction

int Function GetNumberOfTags(string tags) Global
	if tags == ""
		return 0
	endif
	string separator = ","
	int n = 1
	int idx = StringUtil.Find(tags,separator)
	int len = StringUtil.GetLength(tags)
	;Debug.Trace("GetNumberOfTags idx="+idx+" n="+n+" l="+len+" string="+tags)
	string s = tags
	int itry = 1
	while idx != -1 && itry < 128
		s = StringUtil.Substring(s, idx+1, len)
		;Debug.Trace("GetNumberOfTags idx="+idx+" n="+n+" l="+len+" string="+s)
		n += 1
		idx = StringUtil.Find(s,separator)
		len = StringUtil.GetLength(s)
		itry += 1
	endwhile
	;debug.trace("GetNumberOfTags Number of tags="+n)
	return n
EndFunction

string Function GetTagByIndex(int tag_index, string tags) Global
	if tags == ""
		return ""
	endif
	if tag_index < 0
		n = GetNumberOfTags(tags)
		int new_index = RandomInt(0,n-(1))
		;debug.trace("GetTagByIndex tag_index="+tag_index+" new_index="+new_index)
		tag_index = new_index
	endif
	string separator = ","
	int n = 0
	int idx = StringUtil.Find(tags,separator)
	int len = StringUtil.GetLength(tags)
	if tag_index == 0
		string s = StringUtil.Substring(tags,0,idx)
		;debug.trace("GetTagByIndex tag_index="+tag_index+" idx="+idx+" n="+n+" l="+len+" string="+s)
		return s
	endif
	n = 1
	;debug.trace("GetTagByIndex tag_index="+tag_index+" idx="+idx+" n="+n+" l="+len+" string="+tags)
	string s = tags
	int itry = 1
	while idx != -1 && itry < 128
		s = StringUtil.Substring(s, idx+1, len)
		;debug.trace("GetTagByIndex tag_index="+tag_index+" idx="+idx+" n="+n+" l="+len+" string="+s)
		idx = StringUtil.Find(s,separator)
		len = StringUtil.GetLength(s)
		if tag_index == n
			if idx != -1
				return StringUtil.Substring(s,0,idx)
			else
				return s
			endif
		endif
		n += 1
	endwhile
	;debug.trace("GetTagByIndex tag_index="+tag_index+" idx="+idx+" Number of tags="+n+" None selected")
	return ""
EndFunction

; ### Punishing and praising

bool Function IsSmallReason(int reason) Global
	if reason < 12
		return true
	endif
	return false
EndFunction

bool Function IsVeryImportantReason(int reason) Global
	if reason > 24
		return true
	endif
	return false
EndFunction

bool Function IsSmallKink(int kink) Global
	if kink >= 40 && kink < 50
		return true
	endif
	return false
EndFunction

int Function GetNumberOfKinks(Actor akRef) Global
	if akRef.isChild()
		return 0
	endif
	actorBase abTarget = akRef.GetLeveledActorBase()
	Race ActorRace  = abTarget.GetRace()
	string raceString = ActorRace.GetName()+" "+MiscUtil.GetRaceEditorID(ActorRace)
	;Debug.Trace("Looking up number of kinks for "+akRef.GetDisplayName()+" race = "+raceString)

	int n = 0
	if(stringUtil.find(raceString,"Argonian")>=0)
		n = RandomInt(0,5)
	elseif(stringUtil.find(raceString,"Breton")>=0)
		n = RandomInt(1,6)
	elseif(stringUtil.find(raceString,"Dark Elf")>=0)
		n = RandomInt(2,5)
	elseif(stringUtil.find(raceString,"High Elf")>=0)
		n = RandomInt(3,6)
	elseif(stringUtil.find(raceString,"Imperial")>=0)
		n = RandomInt(1,5)
	elseif(stringUtil.find(raceString,"Khajiit")>=0)
		n = RandomInt(0,2)
	elseif(stringUtil.find(raceString,"Nord")>=0)
		n = RandomInt(1,4)
	elseif(stringUtil.find(raceString,"Orc")>=0)
		n = RandomInt(0,3)
	elseif(stringUtil.find(raceString,"Redguard")>=0)
		n = RandomInt(1,4)
	elseif(stringUtil.find(raceString,"Wood Elf")>=0)
		n = RandomInt(2,6)
	elseif(stringUtil.find(raceString,"Snow Elf")>=0)
		n = RandomInt(2,7)
	endif
	; Special races
	if(stringUtil.find(raceString,"Vampire")>=0)
		n += 1
	endif
	if StringUtil.Find(raceString, "Old")>=0 || StringUtil.Find(raceString, "Elder")>=0
		n -= 1 ; Kink was maybe experienced and became less intense
	endif
	if n <= 0
		return 0
	endif
	return n
EndFunction

string Function GetTrainingStatusNameByIndex(int idx) Global
	if idx == 0
		return "freshly captured"
	endif
	if idx == 1
		return "untamed"
	endif
	if idx == 2
		return "degraded"
	endif
	if idx == 3
		return "abused"
	endif
	if idx == 4
		return "objectified"
	endif
	if idx == 5
		return "tamed"
	endif
	if idx == 6
		return "forced"
	endif
	if idx == 7
		return "dominated"
	endif
	if idx == 8
		return "subjugated"
	endif
	if idx == 9
		return "terrorized"
	endif
	if idx == 10
		return "enslaved"
	endif
	if idx == 11
		return "subdued"
	endif
	if idx == 12
		return "debased"
	endif
	if idx == 13
		return "demeaned"
	endif
	if idx == 14
		return "disgraced"
	endif
	if idx == 15
		return "shamed"
	endif
	if idx == 16
		return "submitted"
	endif
	if idx == 17
		return "humiliated"
	endif
	if idx == 18
		return "resignated"
	endif
	if idx == 19
		return "unbroken"
	endif
	if idx == 20
		return "mesmerized"
	endif
	if idx == 21
		return "ravished"
	endif
	if idx == 22
		return "bewitched"
	endif
	if idx == 23
		return "charmed"
	endif
	if idx == 24
		return "brainwashed"
	endif
	if idx == 25
		return "hypnotized"
	endif
	if idx == 26
		return "devoted"
	endif
	if idx == 27
		return "enraptured"
	endif
	return "unbroken" ; == 19
EndFunction

string Function GetBehaviourTextByIndex(int idx) Global
	if idx == 0
		return "doing nothing"
	endif
	if idx == 1
		return "dead"
	endif
	if idx == 2
		return "leashed"
	endif
	if idx == 3
		return "bagged"
	endif
	if idx == 4
		return "on duty"
	endif
	if idx == 5
		return "busying around"
	endif
	if idx == 6
		return "waiting"
	endif
	if idx == 7
		return "following me"
	endif
	if idx == 8
		return "following trainer"
	endif
	if idx == 9
		return "moving"
	endif
	if idx == 10
		return "fleeing"
	endif
	if idx == 11
		return "running away"
	endif
	if idx == 12
		return "posing"
	endif
	if idx == 13
		return "masturbating"
	endif
	if idx == 14
		return "being tied"
	endif
	if idx == 15
		return "being chained"
	endif
	if idx == 16
		return "being restrained"
	endif
	if idx == 17
		return "being restrained in furniture"
	endif
	if idx == 18
		return "using furniture"
	endif
	if idx == 19
		return "training"
	endif
	if idx == 20
		return "training"
	endif
	if idx == 21
		return "training"
	endif
	if idx == 22
		return "sex training"
	endif
	if idx == 23
		return "sex training"
	endif
	if idx == 24
		return "sex training"
	endif
	if idx == 25
		return "threesome training"
	endif
	if idx == 26
		return "threesome training"
	endif
	if idx == 27
		return "threesome training"
	endif
	if idx == 28
		return "cleaning"
	endif
	if idx == 29
		return "guarding"
	endif
	if idx == 30
		return "travelling"
	endif
	if idx == 31
		return "standing in jail"
	endif
	if idx == 32
		return "jailed"
	endif
	if idx == 33
		return "being restrained in jail"
	endif
	if idx == 34
		return "going to jail"
	endif
	if idx == 35
		return "showering"
	endif
	if idx == 36
		return "working"
	endif
	if idx == 37
		return "cleaning"
	endif
	if idx == 38
		return "being restrained in device"
	endif
	return "unknown" 
EndFunction

string Function GetMoodTextByIndex(int idx) Global
	if idx == 1
		return "freshly captured"
	endif
	if idx == 2
		return "angry"
	endif
	if idx == 3
		return "afraid"
	endif
	if idx == 4
		return "terrified"
	endif
	if idx == 5
		return "scared"
	endif
	if idx == 6
		return "ashamed"
	endif
	if idx == 7
		return "sad"
	endif
	if idx == 8
		return "shocked"
	endif
	if idx == 9
		return "broken"
	endif
	if idx == 10
		return "neutral"
	endif
	if idx == 11
		return "fine"
	endif
	if idx == 12
		return "happy"
	endif
	if idx == 13
		return "loyal"
	endif
	if idx == 14
		return "in love"
	endif
	if idx == 15
		return "depressed"
	endif
	if idx == 16
		return "insecure"
	endif
	if idx == 17
		return "jealous"
	endif
	if idx == 18
		return "outraged" ; "defiant"
	endif
	if idx == 19
		return "crushed"
	endif
	if idx == 20
		return "offended" ; "proud"
	endif
	if idx == 21
		return "charmed"
	endif
	if idx == -1
		return "surprised" ; = unknown
	endif
	return "empty minded"
EndFunction

; ##### Factions

int Function GetFactionRank(Actor _a, Faction the_faction) Global
	int x = _a.GetFactionRank(the_faction)
	if x<0
		if _a.IsInFaction(the_faction)
			return 256+x
		else
			return 0
		endif
	endif
	return x
EndFunction

float Function GetFactionRankFloat(Actor _a, Faction the_faction) Global
	if !_a.IsInFaction(the_faction)
		return 0.0
	endif
	float x = _a.GetFactionRank(the_faction) as float
	if x<0.0
		return 256.0+x
	endif
	return x
EndFunction

Function SetFactionRank(Actor akRef, Faction the_faction, int rank) Global
	;LogUtil(" SetFactionRank "+akRef.GetDisplayName()+" "+the_faction.GetName()+" "+rank)
	if rank > 0
		akRef.SetFactionRank(the_faction, rank)
		return
	endif
	if akRef.IsInFaction(the_faction)
		akRef.RemoveFromFaction(the_faction)
	endif
EndFunction

Function SetFactionRankFloat(Actor _a, Faction the_faction, float value) Global
	int rank = (value+0.5) as int
	if rank > 127
		rank = rank-(256) ; 250 -> -6 and 128 -> -128
	endif
	_a.SetFactionRank(the_faction, rank)
EndFunction

int Function GetFactionRankInt(Actor _a, Faction the_faction) Global
	if !_a.IsInFaction(the_faction)
		return -999
	endif
	int x = _a.GetFactionRank(the_faction)
	return x
EndFunction

Function SetFactionRankInt(Actor _a, Faction the_faction, int rank) Global
	if rank == -999
		if _a.IsInFaction(the_faction)
			_a.RemoveFromFaction(the_faction)
		endif
		return
	endif
	_a.SetFactionRank(the_faction,rank)
EndFunction

Function SetModifierFromFaction(Actor akTarget, Faction the_faction, float value) Global
	; Maximum value is 5.0 and number in faction is 256 from [-128,+127]
	; Modifiers are stored as *50.0+0.5
	int rank = (value*50.0+0.5) as int
	if rank > 127
		rank = rank-(256) ; 250 -> -6 and 128 -> -128
	endif
	akTarget.SetFactionRank(the_faction, rank)
EndFunction

float Function GetModifierFromFaction(Actor akTarget, Faction the_faction) Global
	float rank = (akTarget.GetFactionRank(the_faction)) as float
	if rank < 0
		rank = 256.0+rank ; -6 -> 250 and -128 -> 128
	endif
	rank *= 2.0
	return rank ; in percent 0 to 500% = 0 to 500
EndFunction

Function SetIntFaction(Actor akTarget, Faction the_faction, Int add_to) Global
	if add_to > 127
		akTarget.SetFactionRank(the_faction, 127)
	elseif add_to > 0
		akTarget.SetFactionRank(the_faction, add_to)
	else
		akTarget.RemoveFromFaction(the_faction)
	endif
EndFunction

Function SetBoolFaction(Actor akTarget, Faction the_faction, bool add_to) Global
	if add_to
		akTarget.AddToFaction(the_faction)
	else
		akTarget.RemoveFromFaction(the_faction)
	endif
EndFunction

int Function GetInFactionAsInt(Actor akRef, Faction fact) Global
	if akRef.IsInFaction(fact) 
		return 1
	endif
	return 0
EndFunction

Function SetInFactionAsInt(Actor akRef, Faction fact, int value) Global
	if value > 0
		akRef.setFactionRank(fact,1) 
	else
		akRef.removeFromFaction(fact) 
	endif
EndFunction

; ##### Relationships

string Function GetFriendshipString(Actor akRef, int i) Global
	;Debug.Trace(akRef.GetDisplayName()+" Get friendship type = "+i)
	if i==0
		return "friend"
	elseif i==1
		return "lover"
	elseif i==2
		return "spouse"
	elseif i==3 ; parent
		if akRef.GetLeveledActorBase().GetSex()==0
			return "son"
		endif
		return "daughter"
	elseif i==4 ; child
		if akRef.GetLeveledActorBase().GetSex()==0
			return "father"
		endif
		return "mother"
	elseif i==5 ; sibling
		if akRef.GetLeveledActorBase().GetSex()==0
			return "brother"
		endif
		return "sister"
	elseif i==6 ; grand parent
		if akRef.GetLeveledActorBase().GetSex()==0
			return "grandson"
		endif
		return "granddaughter"
	elseif i==7; grand child
		if akRef.GetLeveledActorBase().GetSex()==0
			return "grandfather"
		endif
		return "grandmother"
	elseif i==8
		return "cousin"
	elseif i==9
		if akRef.GetLeveledActorBase().GetSex()==0
			return "nephew"
		endif
		return "niece"
	elseif i==10
		if akRef.GetLeveledActorBase().GetSex()==0
			return "uncle"
		endif
		return "aunt"
	elseif i==11 ; great grand child
		if akRef.GetLeveledActorBase().GetSex()==0
			return "great-grandson"
		endif
		return "great-granddaughter"
	elseif i==12; great grand parent
		if akRef.GetLeveledActorBase().GetSex()==0
			return "great-grandfather"
		endif
		return "great-grandmother"
	elseif i==13
		if akRef.GetLeveledActorBase().GetSex()==0
			return "great-nephew"
		endif
		return "great-niece"
	elseif i==14
		if akRef.GetLeveledActorBase().GetSex()==0
			return "great-uncle"
		endif
		return "great-aunt"
	elseif i==16
		if akRef.GetLeveledActorBase().GetSex()==0
			return "nephew inlaw"
		endif
		return "niece inlaw"
	elseif i==17
		if akRef.GetLeveledActorBase().GetSex()==0
			return "uncle inlaw"
		endif
		return "aunt inlaw"
	elseif i==18
		if akRef.GetLeveledActorBase().GetSex()==0
			return "son inlaw"
		endif
		return "daughter inlaw"
	elseif i==19
		if akRef.GetLeveledActorBase().GetSex()==0
			return "father inlaw"
		endif
		return "mother inlaw"
	elseif i==20
		if akRef.GetLeveledActorBase().GetSex()==0
			return "brother inlaw"
		endif
		return "sister inlaw"
	elseif i==21 ; One sided relationships
		return "loved one"
	elseif i==22 ; One sided relationships
		if akRef.GetLeveledActorBase().GetSex()==0
			return "suitor"
		endif
		return "suitress"
	endif
	; i==15
	if akRef.GetLeveledActorBase().GetSex()==0
		return "kinsman"
	endif
	return "kinswoman"
EndFunction

; ### Messages

Function SendMessage(string msg) Global
	Debug.MessageBox(msg)
EndFunction

string Function DOMTimesMessage(string header, int n) Global
	if n == 1
		return header+"once"
	elseif n > 1
		return header+n+" times"
	endif
	return ""
EndFunction

string Function DOMFeelingsLine(Actor akTarget, string msg_line, Faction the_faction) Global
	int rank = akTarget.GetFactionRank(the_faction)
	if rank <= 0
		return ""
	endif
	return msg_line+rank+"\n"
EndFunction

string Function DOMFeelingsHeaderLine(Actor akTarget, string msg_line, Faction the_faction) Global
	int rank = akTarget.GetFactionRank(the_faction)
	return msg_line+rank+"\n"
EndFunction


string Function DOMFeelingsLine2(Actor akTarget, string msg_line1, Faction the_faction1, string msg_line2, Faction the_faction2) Global
	int rank = akTarget.GetFactionRank(the_faction1)
	if rank >= 100
		int rank2 = akTarget.GetFactionRank(the_faction2)
		if rank2 > 0
			return msg_line2+rank2+"\n"
		endif
	endif
	if rank <= 0
		return ""
	endif
	return msg_line1+rank+"\n"
EndFunction

string Function DOMFeelingsHeaderLine2(Actor akTarget, string msg_line1, Faction the_faction1, string msg_line2, Faction the_faction2) Global
	int rank = akTarget.GetFactionRank(the_faction1)
	if rank >= 100
		int rank2 = akTarget.GetFactionRank(the_faction2)
		if rank2 > 0
			return msg_line2+rank2+"\n"
		endif
	endif
	return msg_line1+rank+"\n"
EndFunction

string Function GetModifierName(int i) Global
	if i==0
		return "pain"
	elseif i==1
		return "fear"
	elseif i==2
		return "shame"
	elseif i==3
		return "stress"
	elseif i==4
		return "sorrow"
	elseif i==5
		return "discipline"
	elseif i==6
		return "punishing"
	elseif i==7
		return "persuading"
	elseif i==8
		return "depraving"
	elseif i==9
		return "stalking"
	elseif i==10
		return "slaving"
	elseif i==11
		return "pretending"
	elseif i==12
		return "combat"
	elseif i==13
		return "vaginal"
	elseif i==14
		return "oral"
	elseif i==15
		return "anal"
	elseif i==16
		return "house"
	elseif i==17
		return "pose"
	else ; if i==18
		return "work" ; hustling, mining, enchantment, alchemy, baking, smithing 
	endif
	return "crime"
EndFunction

string Function GetExtraModifierName(int i) Global
	if i==0
		return "stress"
	elseif i==1
		return "peacefulness"
	elseif i==2
		return "authority"
	elseif i==3
		return "unfairness"
	elseif i==4
		return "injustice"
	elseif i==5
		return "comforting"
	elseif i==6
		return "bondage"
	elseif i==7
		return "pleasure"
	elseif i==8
		return "joy"
	elseif i==9
		return "falling in love"
	elseif i==10
		return "confusion"
	elseif i==11
		return "manipulation"
	elseif i==12
		return "pressure"
	elseif i==13
		return "rebellion"
	elseif i==14
		return "guilt"
	elseif i==15
		return "orgasm"
	elseif i==16
		return "trauma"
	elseif i==17
		return "distress"
	elseif i==18
		return "praising"
	endif
	return "scolding"
EndFunction

string Function GetTraitsMessage(Actor akTarget, float[] TraitsArray) Global
    string msg
	
	msg =     "Honesty:       "+(TraitsArray[0] as int)+"\n" ; Honesty-Humility
	msg = msg+"Emotionality:  "+(TraitsArray[1] as int)+"\n" ; Emotionality
	msg = msg+"Extraversion:  "+(TraitsArray[2] as int)+"\n" ; eXtraversion
	msg = msg+"Agreeableness: "+(TraitsArray[3] as int)+"\n" ; Agreeableness
	msg = msg+"Conscientious: "+(TraitsArray[4] as int)+"\n" ; Conscientiousness
	msg = msg+"Openness:      "+(TraitsArray[5] as int)+"\n" ; Openness to Experience
	
	msg = msg+"Wilfulness:    "+(TraitsArray[6] as int)+"\n"  ; Mind strength against attacks     / differs from emotionality
	msg = msg+"Toughness:     "+(TraitsArray[7] as int)+"\n" ; Physical strength against attacks / differs from HP
	Race ActorRace  = akTarget.GetLeveledActorBase().GetRace()
	string raceString = MiscUtil.GetRaceEditorID(ActorRace)
	if StringUtil.Find(raceString, "Child") < 0
		msg = msg+"Sensuality:    "+(TraitsArray[8] as int)+"\n"  ; Physical sensibility to stimuli
		msg = msg+"Submissivity:  "+(TraitsArray[9] as int)+"\n" ; Perversion orientation DOM/sub
	endif
	msg = msg+"Boldness:      "+(TraitsArray[10] as int)+"\n" ; Mind social strength
	msg = msg+"Smartness:     "+(TraitsArray[11] as int)+"\n" ; Mind logical strength
	return msg
EndFunction

string Function GetRivalMessage(DOM_Actor sl_alias) Global
	string msg = ""
	If sl_alias != None
		DOM_Actor myRival = sl_alias.GetMyRival()
		if myRival != None
			msg += " I hate "+myRival.GetName()+"."
		endif
		DOM_Actor meRival = sl_alias.GetMeRival()
		if meRival != None
			msg += " I feel like "+meRival.GetName()+" doesn't like me."
		endif
	endif
	return msg
EndFunction

string Function GetFriendMessage(DOM_Actor sl_alias) Global
	if sl_alias == None
		return ""
	endif
	LogUtil(" GetFriendMessage "+sl_alias.getName()+" n="+sl_alias.friendArray.length)
	string msg = ""
	DOM_Actor best_friend = sl_alias.GetBestFriend()
	if best_friend 
		if sl_alias.GetFriendsNotFamilyCount() > 1
			msg += " "+best_friend.GetName()+" is my best friend."
		else
			msg += " "+best_friend.GetName()+" is my only friend."
		endif
	endif
	string pct = " I am friends with "
	int nb = 0
	; Loop over friends
	int i = 0
	int nmax = sl_alias.friendArray.length
	While i < nmax
		DOM_Actor afriend = sl_alias.GetFriend(i)
		if afriend != None && afriend != best_friend
			int rel = sl_alias.GetFriendType(i)
			if rel == 0
				LogUtil(" Friend of "+sl_alias.GetName()+" "+i+" = "+afriend.GetName()+" rel="+rel)
				msg=msg+pct+afriend.GetName()
				pct = ", "
				nb = 1
			endif
		endif
		i += 1
	EndWhile
	if nb > 0
		msg = msg+"."
	endif
	pct = " "
	nb = 0
	i = 0
	While i < nmax
		DOM_Actor afriend = sl_alias.GetFriend(i)
		if afriend != None
			int rel = sl_alias.GetFriendType(i)
			if rel != 0
				string reltype = GetFriendshipString(afriend.GetActorRef(), rel)
				LogUtil(" Friend of "+sl_alias.GetName()+" "+i+" = "+afriend.GetName()+" rel="+rel+" "+reltype)
				msg=msg+pct+afriend.GetName()+" is my "+reltype
				pct = ", "
				nb = 1
			endif
		endif
		i += 1
	EndWhile
	if nb > 0
		msg = msg+"."
	endif
	return msg
EndFunction

string Function GetOldFriendMessage(DOM_Actor sl_alias) Global
	string msg = ""
	If sl_alias != None
		string pct = " I will always remember "
		int nb = 0
		; Loop over old friends
		int i = 0
		int nmax = sl_alias.actorFriendArray.length
		While i < nmax
			Actor afriend = sl_alias.GetOldFriend(i)
			if afriend != None 
				;LogUtil(" old friend of "+sl_alias.GetName()+" "+i+" = "+afriend.GetDisplayName())
				msg=msg+pct+afriend.GetDisplayName()
				pct = ", "
				nb = 1
			endif
			i += 1
		EndWhile
		if nb > 0
			msg = msg+"."
		endif
	endif
	return msg
EndFunction

; Function to normalize modifier to give bigger personality effects on low and high values
float Function NormModifier(float mod) Global
	mod = mod/600.0

	if mod < 0.08
		return mod*0.1+0.002 ; 0.002 to 0.01
	elseif mod < 0.16
		return mod*0.4+0.016 ; 0.048 to 0.08
	elseif mod < 0.34
		return mod*0.2+0.092 ; 0.124 to 0.16 
	elseif mod >= 0.92
		return mod*25.0-(20.0) ; 3.0 to 5.0
	elseif mod >= 0.84
		return mod*6.25-(3.75) ; 1.5 to 2.0
	elseif mod >= 0.66 
		return mod*0.8+0.328 ; 0.856 to 1.0
	endif
	
	return mod ; Normalized so that modifier can be from 0.2% to 500% 
EndFunction

; Global seed Random Functions, used to get true Random numbers

float Function Random3G()
	float r = 34.0*(RandomFloat()+RandomFloat()+RandomFloat())-(1.0)
	return r;
EndFunction

float Function RandG100()
	float r = 25.0*(RandomFloat()+RandomFloat()+RandomFloat()+RandomFloat())
	return r;
EndFunction

float Function RandG50() Global
	float r = 12.5*(RandomFloat()+RandomFloat()+RandomFloat()+RandomFloat())
	return r;
EndFunction

float Function RandG1() Global
	float r = 0.25*(RandomFloat()+RandomFloat()+RandomFloat()+RandomFloat())
	return r;
EndFunction

; Some string utility Functions

string Function ReplaceText(string src, string sfind, string srepl) Global
	int i = StringUtil.Find(src, sfind, 0)
	;Debug.trace("ReplaceText src="+src+" find="+sfind+" replace="+srepl+" i="+i)
	if i < 0 
		return src
	endif

	int len = StringUtil.GetLength(sfind)
	string sub1
	if i == 0
		sub1 = ""
	else
		sub1 = StringUtil.Substring(src, 0, i)
	endif
	int lsrc = StringUtil.GetLength(src)
	string sub2
	if i+len >= lsrc
		sub2 = ""
	else
		sub2 = StringUtil.Substring(src, i+len)
	endif
	string dest = sub1+srepl+sub2
	;Debug.trace("ReplaceText dest="+dest+" sub1="+sub1+" sub2="+sub2+" l="+len)
	
	return dest
EndFunction

String Function ConvertIDToHex(Int m) Global
    String s
    int i = 0

    While (i < 8)
        int j = Math.LogicalAnd(m, 0xF)
        s = StringUtil.GetNthChar("0123456789abcdef", j) + s
        m = Math.RightShift(m, 4);
        i += 1
    EndWhile

    return s
EndFunction

float Function RandomizePc() Global
	return (RandomFloat()*0.24)+0.88; return a number between 0.88 and 1.12
EndFunction

; Get poses

; TIED
; ZazAPCAO051 Zaz Hogtied on the floor face down metal cuffs + rope STILL
; ZazAPCAO052 Zaz Hogtied on the floor face down metal cuffs + rope MOVING
; ZazAPCAO053 Zaz Hogtied on the floor face down metal cuffs + rope STRUGGLING
; ZazAPCAO054 Zaz Hogtied on the floor left side metal cuffs + rope MOVING
; ZazAPCAO055 Zaz Hogtied on the floor left side metal cuffs + rope STILL

; ZazAPCAO005 Zaz Wall cage kneeling arms back
; ZazAPCAO006 Zaz Wall cage sitting on side
; ZazAPCAO007 Zaz Wall cage standing
; ZazAPCAO008 Zaz Wall cage NOT WORKING standing arms back going through the cage

; ZazAPCAO017 Zaz invisible post front
; ZazAPCAO018 Zaz invisible post kneeling
; ZazAPCAO019 Zaz invisible post front legs and arms spread
; ZazAPCAO020 Zaz invisible post standing
; ZazAPCAO021 Zaz invisible post upside down
; ZazAPCAO022 Zaz invisible post hogtied

; ZazAPCHogtie01_Enter 4 ; 01 hogtied ropes (ROPES DISAPPEAR BECAUSE OF THE LOOP)
; ZazBitchLessonsKneeling_Enter ; Kneeling head on the ground ass up ready for the whip
; Zazboundknees_Enter ; Kneeling arms back looking down ropes on
; ZazGirlStrugglingOnTheGround_Enter ; Sit then struggle on the ground (NO ROPES)
; ZazGirlStandingWithDildo_Enter ; wet and then plays with dildo (NO DILDO)
; ZazAPFSA001 8 ; Tentacles
; ZazAPPillSolo01 5 ; Pillory
; ZapAddGag ; Adds gag to person standing in front
; ZazhornyFemale01 ; Touching pussy and breast standing
; ZapDomHandHips ; Hands on hips standing proud
; ZapSurrender ; hands up
; ZapSitSpread ; sitting on the floor legs spread hands on the ground to support chest
; ZaZXBedFFSTRU_Enter ; X Cross ropes struggling NO FURNITURE
; ZaZXBedFBSTRU_Enter ; X Cross turning face then back NO FURNITURE
; ZazAPChairTied01_Enter 2 ; Sitting arms in the back (no chair)
; ZazTortureChair_Enter ; Chair sitting normally and tied no ropes NO FURNITURE
; ZazTableOfSex01Enter 4 ; Attached to table on back, entering NO FURNITURE
; ZazAPTreeTied01_Enter 9 ; Attached to a tree NO TREE
; ZazOutdoorTableBondage01_Enter ; Laying attached struggling NO FURNITURE
; ZazOutsideXcross_Enter ; XCross NO FURNITURE
; ZazSlaveStockKneeling_Enter ; On stocks NO OBJECT
; ZazCarriageWheel01_Enter 4 ; Sitting hands in back tied to carriage, NO FURNITURE
; xDoubleChairTopEnter
; zazStruggleRope_Enter ; Standing struggling arms back ropes appears and disappears as entering
; xRopeDanceEnter
; ZazAPCumCumTree_Enter
; ZapStandShowArs
; ZapStandShowVagina
; ZapLieShowVagina
; ZapRedress01
; ZapRedress02
; ZapBid01 ; raise one hand to bid
; ZapBid02 ; raise one hand to bid
; ZapWriTurn01 Turn around hands in the back
; IdleSurrender Hands up

; ' Offset animations can play while the legs move about freely.
; ZazAPOA001 ZazAPOA001.hkx				' A standing hands behind back
; ZazAPOA002 ZazAPOA002.hkx				' A slight struggle animation
; ZazAPOA003 ZazAPOA003.hkx				' A elbows closer together
; ZazAPOA005 ZazAPOA005.hkx				' A elbows even closer together ***	Armbinder position (Devious Devices compatible)
; ZazAPOA006 ZazAPOA006.hkx				' A old arms bound animation with a bit of struggle armbinder position?
; ZazAPOA013 ZazAPOA013.hkx				' A Elbows tied close
; ZazAPOA020 ZazAPOA020.hkx				' A standing hands behind back loose ***Vertical Strictly Poled
; ZazAPOA023 ZazAPOA023.hkx				' A standing hands behind back ***   Fully Roped arms to backside,     Armbinder position (DD-compatible)
; ZazAPOA025 ZazAPOA025.hkx				' A Hands On Backside In Hand Cuffs not crossed

; ZazAPOA004 ZazAPOA004.hkx				' B standing hands behind back box tied
; ZazAPOA011 ZazAPOA011.hkx 			' B Hands Behind Back Ankled box tied
; ZazAPOA021 ZazAPOA021.hkx				' B Box Tied With Elbow Ropes

; ZazAPOA008 ZazAPOA008.hkx				' C Wrists crossed behind the back
; ZazAPOA015 ZazAPOA015.hkx				' C Hands crossed behind back elbows up - Wheeled
; ZazAPOA016 ZazAPOA016.hkx				' C Hands crossed behind the back

; ZazAPOA010 ZazAPOA010.hkx 			' D Hands crossed Behind Neck
; ZazAPOA019 ZazAPOA019.hkx				' D Hands In Front Crossed, Roped

; ZazAPOA014 ZazAPOA014.hkx				' E Hands tied in front not crossed ArmToBodyCloseBondage
; ZazAPOA018 ZazAPOA018.hkx				' E Hands In Front not crossed In Irons
; ZazAPOA022 ZazAPOA022.hkx				' E hands in front at chest level not crossed Koffi fiddle (DD-style)
; ZazAPOA024 ZazAPOA024.hkx				' E Hands In Front In Hand Cuff not crossed

; ZazAPOA017 ZazAPOA017.hkx				' F Hands Around Neck

; See OffsetArmsCrossed
; ZaZAPCSHMOFF                          ' Male shame offset
; ZaZAPCSHFOFF                          ' Female shame offset
; ZaZAPCHorMOff01 to 03                 ' Male horny offset
; ZaZAPCHorFOFF01 to 03                 ' Female horny offset
; 'Bed Bondage ZazAPBedBound01_Enter
; Zaz Enter Loop Exit Furnitures and Chains

bool Function IsCuteGSPose(int ipose) Global
	if ipose == 1 ; Fits, Gyrating, Reversed:90
		return true
	elseif ipose == 2 ; Fits, Gyrating, Reversed
		return true
	elseif ipose == 3 ; Fits, Gyrating
		return true
	elseif ipose == 5 ; Fits, Active
		return true
	elseif ipose == 10 ; Fits, Active
		return true
	elseif ipose == 14 ; Fits, Active
		return true
	elseif ipose == 17 ; Fits, Gyrating
		return true
	elseif ipose == 20 ; Fits, Active, Jiggly, Very Jiggly
		return true
	elseif ipose == 23 ; Fits, Gyrating
		return true
	elseif ipose == 24 ; Fits, Active, Very Active, Jiggly
		return true
	elseif ipose == 25 ; Fits, Gyrating
		return true
	elseif ipose == 26 ; Fits, Active, Very Active, Jiggly
		return true
	elseif ipose == 27 ; Fits, Active, Jiggly
		return true
	elseif ipose == 28 ; Fits, Active, Very Active, Jiggly
		return true
	elseif ipose == 29 ; Fits, Active
		return true
	elseif ipose == 34 ; Fits, Active, Very Active
		return true
	elseif ipose == 35 ; Fits, Active
		return true
	elseif ipose == 36 ; Fits, Gyrating
		return true
	elseif ipose == 38 ; Fits, Active, Jiggly
		return true
	elseif ipose == 39 ; Fits, Gyrating, Jiggly
		return true
	elseif ipose == 41 ; Active, Very Active, Jiggly
		return true
	elseif ipose == 42 ; Fits, Active, Very Active
		return true
	elseif ipose == 43 ; Fits, Active
		return true
	elseif ipose == 44 ; Fits, Active, Very Active
		return true
	elseif ipose == 47 ; Fits, Gyrating, Reversed
		return true
	elseif ipose == 49 ; Fits, Active, Very Active, Jiggly
		return true
	elseif ipose == 50 ; Fits, Active
		return true
	elseif ipose == 51 ; Fits, Active
		return true
	elseif ipose == 57 ; Fits, Active
		return true
	elseif ipose == 91 ; Fits, Active
		return true
	elseif ipose == 93 ; Fits, Active
		return true
	elseif ipose == 94 ; Fits, Active, Very Active
		return true
	elseif ipose == 96 ; Fits, Gyrating, Jiggly, Reversed:90
		return true
	elseif ipose == 101 ; Fits, Active
		return true
	elseif ipose == 103 ; Fits, Active, Very Active
		return true
	elseif ipose == 118 ; Fits, Gyrating, Reversed
		return true
	elseif ipose == 121 ; Fits, Gyrating
		return true
	elseif ipose == 123 ; Fits, Gyrating
		return true
	elseif ipose == 124 ; Fits, Calm, Reversed
		return true
	elseif ipose == 143 ; Fits, Still
		return true
	elseif ipose == 149 ; Fits, Gyrating
		return true
	elseif ipose == 167 ; Fits, Active
		return true
	elseif ipose == 171 ; Fits, Active, Reversed
		return true
	elseif ipose == 180 ; Gyrating, Fucking?, Reversed
		return true
	elseif ipose == 181 ; Fits, Gyrating, Reversed?
		return true
	elseif ipose == 183 ; Fits, Gyrating
		return true
	elseif ipose == 200 ; Fits, Gyrating, Jiggly
		return true
	elseif ipose == 201 ; Fits, Gyrating, Reversed:90?
		return true
	elseif ipose == 202 ; Fits, Gyrating, Reversed:90?
		return true
	elseif ipose == 203 ; Fits, Gyrating, Reversed:90?
		return true
	elseif ipose == 204 ; Fits, Calm, Reversed
		return true
	elseif ipose == 206 ; Fits, Still
		return true
	elseif ipose == 208 ; Fits, Active, Jiggly, Reversed:90?
		return true
	elseif ipose == 214 ; Fits, Active
		return true
	elseif ipose == 215 ; Fits, Calm
		return true
	elseif ipose == 230 ; Fits, Gyrating, Jiggly
		return true
	elseif ipose == 231 ; Fits, Active
		return true
	elseif ipose == 232 ; Fits, Gyrating
		return true
	elseif ipose == 235 ; Fits, Active
		return true
	elseif ipose == 245 ; Fits, Still
		return true
	elseif ipose == 246 ; Fits, Still
		return true
	elseif ipose == 256 ; Fits, Gyrating
		return true
	elseif ipose == 257 ; Fits, Gyrating
		return true
	elseif ipose == 260 ; Fits, Gyrating, Jiggly
		return true
	elseif ipose == 261 ; Fits, Gyrating, Reversed
		return true
	elseif ipose == 271 ; Fits, Active, Jiggly
		return true
	elseif ipose == 275 ; Fits, Active, Jiggly
		return true
	elseif ipose == 276 ; Fits, Active, Jiggly
		return true
	elseif ipose == 279 ; Fits, Active
		return true
	elseif ipose == 288 ; Fits, Still
		return true
	elseif ipose == 295 ; Fits, Active
		return true
	elseif ipose == 298 ; Fits, Active
		return true
	elseif ipose == 299 ; Fits, Gyrating
		return true
	elseif ipose == 304 ; Fits, Active
		return true
	elseif ipose == 306 ; Fits, Gyrating, Rapid Gyrating
		return true
	elseif ipose == 308 ; Fits, Gyrating
		return true
	elseif ipose == 310 ; Fits, Gyrating
		return true
	elseif ipose == 311 ; Fits, Active
		return true
	elseif ipose == 315 ; Fits, Lying, Calm
		return true
	elseif ipose == 316 ; Fits, Calm, Lying, Relaxation
		return true
	elseif ipose == 323 ; Fits, Active, Jiggly
		return true
	elseif ipose == 325 ; Fits, Still
		return true
	elseif ipose == 334 ; Fits, Gyrating
		return true
	elseif ipose == 336 ; Fits, Active, Jiggly
		return true
	elseif ipose == 337 ; Fits, Still
		return true
	elseif ipose == 340 ; Fits, Active
		return true
	elseif ipose == 342 ; Fits, Calm
		return true
	elseif ipose == 344 ; Fits, Gyrating
		return true
	elseif ipose == 346 ; Fits, Gyrating
		return true
	elseif ipose == 348 ; Fits, Active, Jiggly
		return true
	elseif ipose == 356 ; Fits, Still
		return true
	elseif ipose == 363 ; Fits, Gyrating
		return true
	elseif ipose == 364 ; Fits, Still
		return true
	elseif ipose == 378 ; Fits, Active
		return true
	elseif ipose == 382 ; Fits, Still
		return true
	elseif ipose == 388 ; Fits, Active, Twerking
		return true
	elseif ipose == 389 ; Fits, Gyrating
		return true
	elseif ipose == 394 ; Fits, Still
		return true
	elseif ipose == 395 ; Fits, Calm
		return true
	elseif ipose == 401 ; Fits, Gyrating
		return true
	elseif ipose == 402 ; Fits, Gyrating
		return true
	elseif ipose == 451 ; Fits, Active
		return true
	elseif ipose == 452 ; Fits, Active
		return true
	elseif ipose == 454 ; Fits, Calm
		return true
	elseif ipose == 462 ; Fits, Active, Very Active, Jiggly, Very Jiggly
		return true
	elseif ipose == 464 ; Fits, Gyrating
		return true
	elseif ipose == 465 ; Fits, Gyrating
		return true
	elseif ipose == 478 ; Fits, Still
		return true
	elseif ipose == 487 ; Still
		return true
	elseif ipose == 489 ; Still
		return true
	endif
	return false
EndFunction

string Function GetTestPose(int ipose) Global
	Debug.Trace("GetTestPose "+ipose)
	if ipose == 1
		return "DoMBabo_ChokeHug_S01_A01" ; choked from behind
	elseif ipose == 2
		return "DoMBabo_ChokeHug_S01_A02" ; choking from behind
	elseif ipose == 3
		return "DoMBabo_ChokeHug_S02_A01"
	elseif ipose == 4
		return "DoMBabo_ChokeHug_S02_A02"
	elseif ipose == 5
		return "DoMBabo_ChokeHug_S03_A01"
	elseif ipose == 6
		return "DoMBabo_ChokeHug_S03_A02"
	elseif ipose == 7
		return "DoMBabo_ChokeHug_S04_A01"
	elseif ipose == 8
		return "DoMBabo_ChokeHug_S04_A02"
	elseif ipose == 9
		return "DoMBabo_ChokeHug_S05_A01" ; getting away from grasp
	elseif ipose == 10
		return "DoMBabo_ChokeHug_S05_A02" ; letting go
	endif
	ipose -= 10

	if ipose == 1
		return "DoMChokeHoldPerv_A1_S1" ; held from behind legs kicking
	elseif ipose == 2
		return "DoMChokeHoldPerv_A2_S1" ; holding from behind pulling
	elseif ipose == 3
		return "DoMChokeHoldPerv_A1_S2" ; held from behind legs kicking
	elseif ipose == 4 
		return "DoMChokeHoldPerv_A2_S2" ; fucking from behind
	endif
	ipose -= 10

	if ipose == 1
		return "DOMBabo_StandingBound01_A1_S1" ; Standing hands behind back looking down shaking
	elseif ipose == 2
		return "DOMBabo_StandingBound01_A2_S1" ; Standing hecking breast
	elseif ipose == 3
		return "DOMBabo_StandingBound01_A1_S2" ; Standing hands behind back looking side shaking
	elseif ipose == 4
		return "DOMBabo_StandingBound01_A2_S2" ; Crouching looking pussy
	elseif ipose == 5
		return "DOMBabo_StandingBound01_A1_S3" ; Standing hands behind back shaking
	elseif ipose == 6
		return "DOMBabo_StandingBound01_A2_S3" ; Standing checking butt
	endif
	ipose -= 6

	if ipose == 1
		return "DOMBabo_NecroLegSpread02_A1_S1" ; Held in the air hands tied trying to run away
	elseif ipose == 2
		return "DOMBabo_NecroLegSpread02_A2_S1" ; Holding by the neck and pussy
	endif
	ipose -= 2

	if ipose == 1
		return "DOMBabo_MMMFGangbang01_A1_S1" ; Standing quiet
	elseif ipose == 2
		return "DOMBabo_MMMFGangbang01_A2_S1" ; Checking bottom
	elseif ipose == 3
		return "DOMBabo_MMMFGangbang01_A3_S1" ; Holding side
	elseif ipose == 4
		return "DOMBabo_MMMFGangbang01_A4_S1" ; Holding back
	elseif ipose == 5
		return "DOMBabo_MMMFGangbang01_A1_S2" ; Standing bent
	elseif ipose == 6
		return "DOMBabo_MMMFGangbang01_A2_S2" ; Checking bottom
	elseif ipose == 7
		return "DOMBabo_MMMFGangbang01_A3_S2" ; fucking
	elseif ipose == 8
		return "DOMBabo_MMMFGangbang01_A4_S2"
	elseif ipose == 9
		return "DOMBabo_MMMFGangbang01_A1_S3"
	elseif ipose == 10
		return "DOMBabo_MMMFGangbang01_A2_S3"
	elseif ipose == 11
		return "DOMBabo_MMMFGangbang01_A3_S3"
	elseif ipose == 12
		return "DOMBabo_MMMFGangbang01_A4_S3"
	elseif ipose == 13
		return "DOMBabo_MMMFGangbang01_A1_S4"
	elseif ipose == 14
		return "DOMBabo_MMMFGangbang01_A2_S4"
	elseif ipose == 15
		return "DOMBabo_MMMFGangbang01_A3_S4"
	elseif ipose == 16
		return "DOMBabo_MMMFGangbang01_A4_S4"
	elseif ipose == 17
		return "DOMBabo_MMMFGangbang01_A1_S5"
	elseif ipose == 18
		return "DOMBabo_MMMFGangbang01_A2_S5"
	elseif ipose == 19
		return "DOMBabo_MMMFGangbang01_A3_S5"
	elseif ipose == 20
		return "DOMBabo_MMMFGangbang01_A4_S5" ; Sitting crouched
	endif
	ipose -= 20

	if ipose == 1
		return "DOMBabo_MMMFGangbang02_A1_S1" ; Being held from behind, almost lifted
	elseif ipose == 2
		return "DOMBabo_MMMFGangbang02_A2_S1" ; Holding from behind locking arms
	elseif ipose == 3
		return "DOMBabo_MMMFGangbang02_A3_S1" ; Punching and then slaping boobs
	elseif ipose == 4
		return "DOMBabo_MMMFGangbang02_A4_S1" ; Teasing with finger
	elseif ipose == 5
		return "DOMBabo_MMMFGangbang02_A1_S2" ; Being held from behind, lifted legs up
	elseif ipose == 6
		return "DOMBabo_MMMFGangbang02_A2_S2" ; Holding
	elseif ipose == 7
		return "DOMBabo_MMMFGangbang02_A3_S2" ; Checking pussy and boobs
	elseif ipose == 8
		return "DOMBabo_MMMFGangbang02_A4_S2" ; Masturbating
	endif
	ipose -= 8

	if ipose == 1
		return "DOMBabo_MMMFGangbang03_A1_S1" ; Standing quiet
	elseif ipose == 2
		return "DOMBabo_MMMFGangbang03_A2_S1" ; Checking bottom
	elseif ipose == 3
		return "DOMBabo_MMMFGangbang03_A3_S1" ; Holding side
	elseif ipose == 4
		return "DOMBabo_MMMFGangbang03_A4_S1" ; Holding back
	elseif ipose == 5
		return "DOMBabo_MMMFGangbang03_A1_S2" ; Standing bent
	elseif ipose == 6
		return "DOMBabo_MMMFGangbang03_A2_S2" ; Checking bottom
	elseif ipose == 7
		return "DOMBabo_MMMFGangbang03_A3_S2" ; fucking
	elseif ipose == 8
		return "DOMBabo_MMMFGangbang03_A4_S2"
	endif
	ipose -= 8

	if ipose == 1
		return "Babo_DruggedFoodConsumptionF" 
	elseif ipose == 2
		return "Babo_DruggedFoodConsumptionM"
	elseif ipose == 3
		return "Babo_DruggedFoodConsumptionM"
	elseif ipose == 4
		return "Babo_DruggedFoodConsumptionM"
	endif
	
	ipose -= 4
	if ipose == 1
		return "Babo_DruggedFoodConsumptionF" 
	elseif ipose == 2
		return "Babo_DruggedFoodConsumptionM"
	elseif ipose == 3
		return "Babo_FoodEatAnyway"
	elseif ipose == 4
		return "Babo_FoodDisgusting"
	elseif ipose == 5
		return "BaboDrinkNormal" ; Drink a bottle of wine
	elseif ipose == 6
		return "BaboDrinkBlackOut" ; Drink a bottle of wine then feels bad and crouches
	elseif ipose == 7
		return "BaboBackHugStartF" ; Standing something weird is happening from the back
	elseif ipose == 8
		return "BaboBackHugStartM" ; Holding someone from back and caressing belly
	elseif ipose == 9
		return "BaboBackHugMolestStartF" ; Standing something weird is happening tries to push away
	elseif ipose == 10
		return "BaboBackHugMolestStartM" ; Holding someone from back and caressing crotch and breast
	elseif ipose == 11
		return "BaboFrontHugStartF" ; Standing something weird is happening
	elseif ipose == 12
		return "BaboFrontHugStartM" ; Jumps to someone and hold
	elseif ipose == 13
		return "BaboExaminePussyA1" ; Standing hands on breast being touched
	elseif ipose == 14
		return "BaboExaminePussyA2" ; Standing bending to examine crotch
	elseif ipose == 15
		return "BaboPlayingPussyA1" ; Standing feeling weird being fondled
	elseif ipose == 16
		return "BaboPlayingPussyA2" ; Kneeling fondling crotch
	elseif ipose == 17
		return "BaboShowingOffBodyA1" ; Standing hand on side disgust gesture with other hand
	elseif ipose == 18
		return "BaboShowingOffBodyA2" ; Standing crouching up and down examining a person's body
	elseif ipose == 19
		return "BaboSuckingPussyA01" ; Standing holding a head at crotch level
	elseif ipose == 20
		return "BaboSuckingPussyA02" ; Kneeling licking crotch holding butt
	elseif ipose == 21
		return "BaboRopeSquirm" ; Hands in back attached to rope, hanging from ceiling 
	elseif ipose == 22
		return "BaboRopeSway" ; Swaying with hands in back attached to rope, hanging from ceiling (struggle pose)
	elseif ipose == 23
		return "BaboRopeHit" ; Hands in back attached to rope, hanging from ceiling, something hits
	elseif ipose == 24
		return "BaboRopeIdle" ; Hands in back attached to rope, hanging from ceiling quietly
	elseif ipose == 25
		return "BaboRopePreHit" ; Hands in back attached to rope, hanging from ceiling, preparing for hit
	elseif ipose == 26
		return "BaboRopePreHitM" ; On ground touching someone hanging
	elseif ipose == 27
		return "BaboRopeHitM" ; On ground hitting the belly of someone hanging
	elseif ipose == 28
		return "BaboRopeFall" ; Being detached from rope
	elseif ipose == 29
		return "BaboWombHit" ; Being hit in belly then laying on floor
	elseif ipose == 30
		return "BaboWombHitLoop" ; Laying on floor looking at aggressor
	elseif ipose == 31
		return "BaboWombHitM" ; Hitting someone in belly
	elseif ipose == 32
		return "BaboHoldArmF" ; Being help by one arm hanging in the air feet barely touching ground
	elseif ipose == 33
		return "BaboHoldArmM" ; Holding someone in the air by one arm
	elseif ipose == 34
		return "BaboCrouchM" ; Crouched looking at someone on the floor
	elseif ipose == 35
		return "BaboCrouchM_S" ; Crouched grabbing something
	elseif ipose == 36
		return "BaboFaintF" ; On the floor on the belly ass up
	elseif ipose == 37
		return "BaboFaintF_S" ; On the floor on the belly head being pulled up
	elseif ipose == 38
		return "BaboDefeatSurrender" ; Standing holding both arms surrendering
	elseif ipose == 39
		return "Babo_DeathStart" ; Falling down on knees eyes shut hands in back
	elseif ipose == 40
		return "Babo_DeathLoop" ; Falling down on knees eyes open
	elseif ipose == 41
		return "Babo_Flirt_A01" ; Standing one arm down one hand holding elbow
	elseif ipose == 42
		return "Babo_Flirt_A02D" ; Standing holding shoulder and maybe teasing nipples
	elseif ipose == 43
		return "Babo_FlirtBreast_A01"  ; Standing one arm down one hand holding elbow uneasy
	elseif ipose == 44
		return "Babo_FlirtBreast_A02" ; Standing cupping breasts
	elseif ipose == 45
		return "Babo_FlirtPussy_A01" ; Standing one arm down one hand holding surprised
	elseif ipose == 46
		return "Babo_FlirtPussy_A02" ; Standing fondling crotch
	elseif ipose == 47
		return "Babo_FlirtFace_A01" ; Standing wary
	elseif ipose == 48
		return "Babo_FlirtFace_A02" ; Standing holding face
	elseif ipose == 49
		return "Babo_FlirtFaceEnd_A01" ; Standing wary one arm getting up at 90 degrees
	elseif ipose == 50
		return "Babo_FlirtFaceEnd_A02" ; Standing holding face kissing
	elseif ipose == 51
		return "Babo_Captured_A1" ; Standing start arms attached in the back bent forward
	elseif ipose == 52
		return "Babo_Captured_A2" ; Standing starting to check breast and butt
	elseif ipose == 53
		return "Babo_CapturedBoob_A1" ; Standing arms attached in the back bent forward
	elseif ipose == 54
		return "Babo_CapturedBoob_A2" ; Standing cupping breast and butt
	elseif ipose == 55
		return "Babo_CapturedPussy_A1" ; Standing arms attached in the back bent forward
	elseif ipose == 56
		return "Babo_CapturedPussy_A2" ; Kneeling fondling crotch
	elseif ipose == 57
		return "Babo_Investigation_S01_A01" ; Standing arms behind head
	elseif ipose == 58
		return "Babo_Investigation_S01_A02" ; Standing examining by eye
	elseif ipose == 59
		return "Babo_Investigation_S02_A01" ; Standing legs spread arms behind head
	elseif ipose == 60
		return "Babo_Investigation_S02_A02" ; Standing pushing head down
	elseif ipose == 61
		return "Babo_Investigation_S03_A01" ; Standing legs spread arms behind head
	elseif ipose == 62
		return "Babo_Investigation_S03_A02" ; Kneeling fondling crotch
	elseif ipose == 63
		return "Babo_Struggle_S01_A01" ; Standing both arms up at 90 degrees
	elseif ipose == 64
		return "Babo_Struggle_S01_A02" ; Standing holding arms from back
	elseif ipose == 65
		return "Babo_Struggle_S02_A01" ; Standing one arm up at 90 degrees
	elseif ipose == 66
		return "Babo_Struggle_S02_A02" ; Standing holding from back
	elseif ipose == 67
		return "Babo_Struggle_S03_A01" ; Standing arms around crotch
	elseif ipose == 68
		return "Babo_Struggle_S03_A02" ; Standing trying to access crotch area
	elseif ipose == 69
		return "Babo_Struggle_S05_A01" ; Standing giving a back kick to get away
	elseif ipose == 70
		return "Babo_Struggle_S05_A02" ; Standing being pushed away
	elseif ipose == 71
		return "Babo_Drunk_S01_A01" ; Barely standing drunk
	elseif ipose == 72
		return "Babo_Drunk_S01_A02" ; Holding someone from the side
	elseif ipose == 73
		return "Babo_Drunk_S02_A01" ; Barely standing drunk
	elseif ipose == 74
		return "Babo_Drunk_S02_A02" ; Caressing someone from the side
	elseif ipose == 75
		return "Babo_Drunk_S03_A01" ; Half on the floor being held up by one hand
	elseif ipose == 76
		return "Babo_Drunk_S03_A02" ; Kneeling removing clothes from a drunk person?
	elseif ipose == 77
		return "Babo_Drunk_S04_A01" ; Laying on side trying to get up on arms
	elseif ipose == 78
		return "Babo_Drunk_S04_A02" ; Kneeling kissing
	elseif ipose == 79
		return "Babo_Drunk_S05_A01" ; Standing drunk pushing away
	elseif ipose == 80
		return "Babo_Drunk_S05_A02" ; Standing getting away
	elseif ipose == 81
		return "Babo_Drunk_SBD_A01Start" ; On the floor getting picked up on shoulder
	elseif ipose == 82
		return "Babo_Drunk_SBD_A02Start" ; Getting up with someone on shoulder
	elseif ipose == 83
		return "Babo_DefeatPanting" ; Laying on side panting
	elseif ipose == 84
		return "Babo_DefeatTraumaLie" ; Sitting hands back on floor exhausted
	elseif ipose == 85
		return "Babo_DefeatTraumaStand" ; Crouching trauma
	elseif ipose == 86
		return "Babo_DefeatResist_A1_S1" ; Being attacked at neck then on floor
	elseif ipose == 87
		return "Babo_DefeatResist_A2_S1" ; Attacking at neck
	elseif ipose == 88
		return "BaboDefeatKnockOutStart" ; Being knocked out from standing to floor
	elseif ipose == 89
		return "BaboDefeatKnockOutLoop" ; Being knocked out on the floor
	elseif ipose == 90
		return "BaboDefeatKnockOutEnd" ; Being knocked out getting up
	elseif ipose == 91
		return "BaboFaintFStart" ; Fainting from standing to on knees
	elseif ipose == 92
		return "BaboFaintFEnd" ; Fainting getting up
	endif
	
	ipose -= 92
	if ipose == 1
		return "DOMSta_slap_backward" ; Moves forward as if slapped from back
	elseif ipose == 2
		return "DOMSta_slap_forward" ; Moves backward as if slapped from front
	elseif ipose == 3
		return "DF_Spank_NibblesSpanking_A1_S1" ; Lying on ? arms in the back being spanked
	elseif ipose == 4
		return "DF_Spank_NibblesSpanking_A2_S1" ; Sitting on ? spanking from left
	elseif ipose == 5
		return "DF_Spank_NibblesSpankingChair_A1_S1" ; Lying on ? being spanked
	elseif ipose == 6
		return "DF_Spank_NibblesSpankingChair_A2_S1" ; Sitting on ? spanking from right
	elseif ipose == 7
		return "DF_Spank_Anubs_rape_A1_S1" ; standing shocked hiding breasts and pussy
	elseif ipose == 8
		return "DF_Spank_Anubs_rape_A2_S1" ; standing holding from shoulder inviting to come closer with finger
	elseif ipose == 9
		return "DF_Spank_Anubs_spank_A1_S1" ; on 4 being spanked
	elseif ipose == 10
		return "DF_Spank_Anubs_spank_A2_S1" ; spanking someone on the floor from right
	elseif ipose == 11
		return "DF_Spank_Anubs_spankfist_A1_S1" ; on 4 being spanked harder
	elseif ipose == 12
		return "DF_Spank_Anubs_spankfist_A2_S1" ; spanking someone on the floor from right left hand is making a fist
	elseif ipose == 13
		return "DF_Spank_rydin_overlap_spanking_A1_S1" ; on belly being spanked
	elseif ipose == 14
		return "DF_Spank_rydin_overlap_spanking_A2_S1" ; sitting on floor spanking and caressing with other hand
	elseif ipose == 15
		return "DF_Spank_rydin_underarm_spanking_A1_S1" ; being held and spanked
	elseif ipose == 16
		return "DF_Spank_rydin_underarm_spanking_A2_S1" ; standing holding and spanking
	elseif ipose == 17
		return "HandonFace" ; face palm, this is not happening
	elseif ipose == 18
		return "HandonChin" ; hand on chin, thinking what to do next
	elseif ipose == 19
		return "BakaDroolingFace" ; face palm, this is not happening
	elseif ipose == 20
		return "BaboSpankingF" ; Standing moves suddenly forward as if slapped from back
	elseif ipose == 21
		return "BaboSpankingM" ; Standing spanking with right hand
	elseif ipose == 22
		return "BaboBackHugStartF" ; Oh my what's hapenning to me now
	elseif ipose == 23
		return "BaboBackHugStartM" ; Come in my arms little thing
	elseif ipose == 24
		return "BaboBackHugMolestStartF" ; Someone is rubbing me from behind
	elseif ipose == 25
		return "BaboBackHugMolestStartM" ; Checking someone's crotch from behind
	elseif ipose == 26
		return "BaboDrinkNormal" ; drinks a bottle by herself
	elseif ipose == 27
		return "BaboDrinkBlackOut" ; drinks a bottle by herself and then croutches as if feeling bad
	elseif ipose == 28
		return "SLA_FlirtPussy_A01" ; Standing holding one arm with other hand and pushing away someone slightly
	elseif ipose == 29
		return "SLA_FlirtPussy_A02" ; Standing holding around neck and checking pussy
	elseif ipose == 30
		return "SLA_Flirt_A01" ; Standing holding one arm with other hand
	elseif ipose == 31
		return "SLA_Flirt_A02D" ; Standing pitching a nipple
	endif
	ipose += 6
	if ipose == 38
		return "B_B_SpankDog_A1_S1" ; On 4 one arm up being ass checked
	elseif ipose == 39
		return "B_B_SpankDog_A2_S1" ; On one knee checking ass
	elseif ipose == 40
		return "B_B_SpankStand_A1_S1"  ; Standing being ass checked
	elseif ipose == 41
		return "B_B_SpankStand_A2_S1" ; Standing holding from front and checking ass
	elseif ipose == 42
		return "ZapSpank01_A2_S1" ; On a chair frozen spanking
	elseif ipose == 43
		return "ZapSpank01_A1_S1" ; Laying arms in back being frozen spanked
	elseif ipose == 44
		return "ZapSpank01_A2_S2" ; On a chair spanking
	elseif ipose == 45
		return "ZapSpank01_A1_S2" ; Laying arms in back being spanked
	elseif ipose == 46
		return "ZapSpank01_A2_S3" ; On a chair spanking harder
	elseif ipose == 47
		return "ZapSpank01_A1_S3"  ; Laying arms in back being spanked harder
	elseif ipose == 48
		return "ZapSpank01_A2_S4" ; On a chair spanking faster
	elseif ipose == 49
		return "ZapSpank01_A1_S4" ; Laying arms in back being spanked faster
	elseif ipose == 50
		return "ZapSpank01_A2_S5" ; spanking frozen, no chair
	elseif ipose == 51
		return "ZapSpank01_A1_S5" ; spanked frozen with chair
	endif
	
	ipose -= 51

	if ipose == 1
		return "Ace_CuddleFromBehind_A1_S1" ; Standing one arm up one down
	elseif ipose == 2
		return "Ace_CuddleFromBehind_A2_S1" ; Standing slow cuddle from behind
	elseif ipose == 3
		return "Ace_Headpat_A1_S1" ; Standing straight arms a bit up
	elseif ipose == 4
		return "Ace_Headpat_A2_S1" ; Standing slowly patting head
	elseif ipose == 5
		return "Ace_HoldingChin_A1_S1" ; Standing straight arms a bit up one more than the other
	elseif ipose == 6
		return "Ace_HoldingChin_A2_S1" ; Standing finger at someone else chin
	elseif ipose == 7
		return "Ace_KneelingHolding_A1_S1" ; Kneeling hands held like going for a bow
	elseif ipose == 8
		return "Ace_KneelingHolding_A2_S1" ; Kneeling hands on legs
	elseif ipose == 9
		return "Ace_KneelingSubLyingDown_A1_S1" ; Lying down 3/4 sexy
	elseif ipose == 10
		return "Ace_KneelingSubLyingDown_A2_S1" ; Down on 1 knee checking
	elseif ipose == 11
		return "Ace_LapPillow_A1_S1" ; Sitting down 3/4
	elseif ipose == 12
		return "Ace_LapPillow_A2_S1" ; Laying down head on someone else knees
	elseif ipose == 13
		return "Ace_LyingCuddle_A1_S1"  ; Laying together on side
	elseif ipose == 14
		return "Ace_LyingCuddle_A2_S1" ; Laying together on back
	elseif ipose == 15
		return "Ace_LyingCuddlingApproach_A1_S1"  ; Laying together on top
	elseif ipose == 16
		return "Ace_LyingCuddlingApproach_A2_S1"  ; Laying together getting up slightly
	elseif ipose == 17
		return "Ace_SittingApproach_A1_S1" ; Sitting on floor one hand up shy
	elseif ipose == 18
		return "Ace_SittingApproach_A2_S1" ; Sitting one hand on someone else shoulder
	elseif ipose == 19
		return "Ace_Spooning_A1_S1" ; Laying in spoon
	elseif ipose == 20
		return "Ace_Spooning_A2_S1" ; Laying spooning
	elseif ipose == 21
		return "Ace_StandingHandHolding_A1_S1" ; Standing holding one hand
	elseif ipose == 22
		return "Ace_StandingHandHolding_A2_S1" ; 
	elseif ipose == 23
		return "Ace_StandingHolding_A1_S1" ; Standing one hand up
	elseif ipose == 24
		return "Ace_StandingHolding_A2_S1" ; Standing holding both hands around waist of someone else
	elseif ipose == 25
		return "Ace_StandingKiss_A1_S1" ; Standing being kissed
	elseif ipose == 26
		return "Ace_StandingKiss_A2_S1" ; Standing kissing nicely
	elseif ipose == 27
		return "Ace_StandingSpank_A1_S1" ; Standing looking back being spanked
	elseif ipose == 28
		return "Ace_StandingSpank_A2_S1" ; Standing spanking
	elseif ipose == 29
		return "Ace_PrincessCarry_A1_S1" ; Being carried sitting
	elseif ipose == 30
		return "Ace_PrincessCarry_A2_S1" ; Carying someone
	elseif ipose == 31
		return "Ace_HeadCaress_A1_S1" ; Standing straight hands up on each side of breasts sexy
	elseif ipose == 32
		return "Ace_HeadCaress_A2_S1" ; Slowly caressing head
	elseif ipose == 33
		return "Ace_StandingHandHoldingNEW_A1_S1" ; Standing hands down being held 
	elseif ipose == 34
		return "Ace_StandingHandHoldingNEW_A2_S1" ; Standing hands down holding
	elseif ipose == 35
		return "Ace_ButtjobFromBehind_A1_S1" ; Standing presenting ass one hand on mouth
	elseif ipose == 36
		return "Ace_ButtjobFromBehind_A2_S1" ; Standing holding someone ass rubbing
	elseif ipose == 37
		return "Ace_GropingBreastsFromBehind_A1_S1" ; Standing both hands down submissive
	elseif ipose == 38
		return "Ace_GropingBreastsFromBehind_A2_S1" ; Standing cheching breast from behind
	elseif ipose == 39
		return "Ace_GropingFromBehind_A1_S1"  ; Standing both hands down humiliated
	elseif ipose == 40
		return "Ace_GropingFromBehind_A2_S1" ; Standing cheching pussy from behind
	elseif ipose == 41
		return "Ace_RubbingAssAgainstCrotch_A1_S1" ; Standing moving ass sexy
	elseif ipose == 42
		return "Ace_RubbingAssAgainstCrotch_A2_S1" ; Standing enjoying ass rub against crotch
	elseif ipose == 43
		return "Ace_RubbingPenisAgainstFace_A1_S1" ; On knees hands on legs face up
	elseif ipose == 44
		return "Ace_RubbingPenisAgainstFace_A2_S1" ; Rubbing crotch on face
	elseif ipose == 45
		return "Ace_SittingGropingBreast_A1_S1" ; Sitting 3/4
	elseif ipose == 46
		return "Ace_SittingGropingBreast_A2_S1" ; Sitting 3/4 groping breast
	elseif ipose == 47
		return "Ace_StandingGropingBreasts_A1_S1" ; Standing straight hands at the level of breast
	elseif ipose == 48
		return "Ace_StandingGropingBreasts_A2_S1" ; Standing cupping breast from front
	elseif ipose == 49
		return "Ace_MountedGrind_A1_S1" ; Cowgirl up
	elseif ipose == 50
		return "Ace_MountedGrind_A2_S1" ; Laying
	elseif ipose == 51
		return "Ace_LyingBoobjob_A1_S1" ; Cowgirl cupping breast
	elseif ipose == 52
		return "Ace_LyingBoobjob_A2_S1" ; Laying legs spread
	elseif ipose == 53
		return "Ace_LyingTitfuck_A1_S1" ; Cowgirl tit fuck
	elseif ipose == 54
		return "Ace_LyingTitfuck_A2_S1" ; Laying legs spread
	elseif ipose == 55
		return "Ace_MountedTitfuckBreastGrab_A1_S1" ; Laying on back
	elseif ipose == 56
		return "Ace_MountedTitfuckBreastGrab_A2_S1" ; On top tit fucking
	elseif ipose == 57
		return "Ace_MountedTitfuckCupping_A1_S1" ; Laying on back cupping breast
	elseif ipose == 58
		return "Ace_MountedTitfuckCupping_A2_S1" ; On top tit fucking
	elseif ipose == 59
		return "Ace_MountedTitfuck_A1_S1"  ; Laying on back
	elseif ipose == 60
		return "Ace_MountedTitfuck_A2_S1" ; On top tit fucking
	elseif ipose == 61
		return "Ace_StandingBoobjob_A1_S1" ; Up on knees boobjob
	elseif ipose == 62
		return "Ace_StandingBoobjob_A2_S1" ; Standing legs bent
	elseif ipose == 63
		return "Ace_StandingNippleSucking_A1_S1" ; Standing one hand up shy
	elseif ipose == 64
		return "Ace_StandingNippleSucking_A2_S1" ; Croutching sucking nipples
	elseif ipose == 65
		return "Ace_StandingTittyfuck_A1_S1" ; Up on knees showing boobs
	elseif ipose == 66
		return "Ace_StandingTittyfuck_A2_S1" ; Standing legs bent
	endif
	return ""
	ipose -= 66
	if ipose <= 0
		ipose = 1
	endif
	if ipose <= 81
		return "fuwa"+ipose
	endif
	ipose -= 81
	if ipose <= 81
		return "2FUW"+ipose
	endif
	ipose -= 81
	if ipose <= 81
		return "3FUW"+ipose
	endif
	ipose -= 81
	if ipose <= 81
		return "4FUW"+ipose
	endif
	ipose -= 81
	if ipose <= 81
		return "5FUW"+ipose
	endif
	ipose -= 81
	if ipose <= 81
		return "CST"+ipose
	endif
	ipose -= 81
	if ipose <= 81
		return "CUS"+ipose
	endif
	ipose -= 81
	if ipose <= 81
		return "CUT"+ipose
	endif
	ipose -= 81
	if ipose <= 81
		return "CSM"+ipose
	endif
	ipose -= 81
	if ipose <= 81
		return "CSS"+ipose
	endif
	ipose -= 81
	if ipose <= 81
		return "H6P"+ipose
	endif
	ipose -= 81
	if ipose <= 81
		return "H7P"+ipose
	endif
	ipose -= 81
	if ipose <= 81
		return "H8P"+ipose
	endif
	ipose -= 81
	if ipose <= 81
		return "H9P"+ipose
	endif
	ipose -= 81
	if ipose <= 81
		return "H10P"+ipose
	endif
	ipose -= 81
	if ipose <= 81
		return "H11P"+ipose
	endif
	ipose -= 81
	if ipose <= 81
		return "H12P"+ipose
	endif
	ipose -= 81
	if ipose <= 81
		return "H13P"+ipose
	endif
	ipose -= 81
	if ipose <= 81
		return "H14P"+ipose
	endif
	ipose -= 81
	if ipose <= 81
		return "H15P"+ipose
	endif
	ipose -= 81
	if ipose <= 81
		return "H16P"+ipose
	endif
	ipose -= 81
	if ipose <= 81
		return "H17P"+ipose
	endif
	ipose -= 81
	if ipose <= 81
		return "H18P"+ipose
	endif
	ipose -= 81
	if ipose <= 81
		return "H19P"+ipose
	endif
	ipose -= 81
	if ipose <= 81
		return "H20P"+ipose
	endif
	ipose -= 81
	if ipose <= 81
		return "H21P"+ipose
	endif
	ipose -= 81
	if ipose <= 81
		return "H22P"+ipose
	endif
	ipose -= 81
	if ipose <= 81
		return "H23P"+ipose
	endif
	ipose -= 81
	if ipose <= 81
		return "H24P"+ipose
	endif
	ipose -= 81
	if ipose <= 81
		return "H1MP"+ipose
	endif
	ipose -= 81
	if ipose <= 81
		return "H4PP"+ipose
	endif
	ipose -= 81
	if ipose <= 81
		return "H5PP"+ipose
	endif
	ipose -= 81
	if ipose <= 81
		return "HBEP"+ipose
	endif
	ipose -= 81
	if ipose <= 81
		return "H6PP"+ipose
	endif
	ipose -= 81
	if ipose <= 81
		return "H1Ob"+ipose
	endif
	ipose -= 81
	if ipose <= 81
		return "HSP"+ipose
	endif
	ipose -= 81
	if ipose <= 40
		return "HPPair"+ipose+"a"
	endif
	ipose -= 40
	if ipose <= 40
		return "HPPair"+ipose+"b"
	endif
	ipose -= 40
	if ipose <= 40
		return "H2Pair"+ipose+"a"
	endif
	ipose -= 40
	if ipose <= 40
		return "H2Pair"+ipose+"b"
	endif
	ipose -= 40
	if ipose <= 81
		return "H3PP"+ipose
	endif
	ipose -= 81
	if ipose <= 27
		return "HPThree27"+ipose+"a"
	endif
	ipose -= 27
	if ipose <= 27
		return "HPThree27"+ipose+"b"
	endif
	ipose -= 27
	if ipose <= 27
		return "HPThree27"+ipose+"b"
	endif
	ipose -= 27
	if ipose <= 81
		return "EXT"+ipose
	endif
	ipose -= 81
	if ipose <= 81
		return "HObP"+ipose
	endif
	ipose -= 81
	if ipose <= 81
		return "H25P"+ipose
	endif
	ipose -= 81
	if ipose <= 81
		return "H26P"+ipose
	endif
	ipose -= 81
	if ipose <= 81
		return "H1CP"+ipose
	endif
	ipose -= 81
	if ipose <= 81
		return "H2CP"+ipose
	endif
	ipose -= 81
	if ipose <= 81
		return "knox"+ipose
	endif
	ipose -= 81
	if ipose <= 81
		return "kn2x"+ipose
	endif
	ipose -= 81
	if ipose <= 81
		return "MK1P"+ipose
	endif
	ipose -= 81
	if ipose <= 81
		return "MK2P"+ipose
	endif
	ipose -= 81
	if ipose <= 9
		return "Gee"+ipose
	endif
	ipose -= 9
	if ipose <= 9
		return "Oh"+ipose
	endif
	ipose -= 9
	if ipose <= 9
		return "RDR"+ipose
	endif
	ipose -= 9
	if ipose <= 9
		return "BG"+ipose
	endif
	ipose -= 9
	if ipose <= 9
		return "Hoot"+ipose
	endif
	ipose -= 9
	if ipose <= 9
		return "Genie"+ipose
	endif
	ipose -= 9
	if ipose <= 9
		return "MT"+ipose
	endif
	ipose -= 9
	if ipose <= 9
		return "TB"+ipose
	endif
	ipose -= 9
	if ipose <= 9
		return "Concert"+ipose
	endif
	ipose -= 9
	if ipose <= 54
		return "PUPMStand"+ipose
	endif
	ipose -= 54
	if ipose <= 9
		return "PUPMSit"+ipose
	endif
	ipose -= 9
	if ipose <= 9
		return "PUPMLay"+ipose
	endif
	ipose -= 9
	if ipose <= 9
		return "PUPMKneel"+ipose
	endif
	ipose -= 9
	if ipose <= 18
		return "PPEX5St"+ipose
	endif
	ipose -= 18
	if ipose <= 9
		return "PPEX5Sit"+ipose
	endif
	ipose -= 9
	if ipose <= 9
		return "PPEX5Lay"+ipose
	endif
	ipose -= 9
	if ipose <= 9
		return "PPEX5Kn"+ipose
	endif
	ipose -= 9
	if ipose <= 9
		return "PPEX5WSt"+ipose
	endif
	ipose -= 9
	if ipose <= 9
		return "PPEX5WSit"+ipose
	endif
	ipose -= 9
	if ipose <= 9
		return "PPEX5WLay"+ipose
	endif
	ipose -= 9
	if ipose <= 9
		return "PPEX5WKn"+ipose
	endif
	ipose -= 9
	if ipose <= 324
		return "PUPEX"+ipose
	endif
	ipose -= 324
	if ipose <= 27
		return "PUP5Lay"+ipose
	endif
	ipose -= 27
	if ipose <= 27
		return "PUP5Sit"+ipose
	endif
	ipose -= 27
	if ipose <= 27
		return "PUP5Kneel"+ipose
	endif
	ipose -= 27
	if ipose <= 81
		return "PUP4Stand"+ipose
	endif
	ipose -= 81
	if ipose <= 27
		return "PUP3Lay"+ipose
	endif
	ipose -= 27
	if ipose <= 27
		return "PUP3Sit"+ipose
	endif
	ipose -= 27
	if ipose <= 27
		return "PUP3Kneel"+ipose
	endif
	ipose -= 27
	if ipose <= 81
		return "PUP2Stand"+ipose
	endif
	ipose -= 81
	if ipose <= 81
		return "PUPStand"+ipose
	endif
	ipose -= 81
	if ipose <= 40
		return "PPair"+ipose+"a"
	endif
	ipose -= 40
	if ipose <= 40
		return "PPair"+ipose+"b"
	endif
	ipose -= 40
	if ipose <= 81
		return "DPose"+ipose
	endif
	ipose -= 81
	if ipose <= 18
		return "APoseFist"+ipose
	endif
	ipose -= 18
	if ipose <= 18
		return "APoseZwei"+ipose
	endif
	ipose -= 18

	return ""
EndFunction

Function QueueNiNodeUpdate(Actor akRef) Global
	if !akRef.Is3dLoaded()
		return
	endif
	if akRef.IsOnMount()
		return
	endif
	akRef.QueueNiNodeUpdate()
EndFunction

;/
int Function GetGSPose()
	; Keywords
	; Wall - Object - Furniture
    ; Impractical: "Clipping", "Deformation", "Location"=Needs an added furniture, "Preset-dependent", "Non-looping" 
    ; Non-lore-friendly 
    ; Covering
    ; Penis — The animation assumes the actor has a penis.

    ; Fits — Animations that would be a good fit for DOM somewhere, default "Just be cute!" unless otherwise.
    ; Reversed — Any animation where the slave is looking or presenting her assets away from the PC
    ; Reversed:90 — Might look better rotated sideways instead of completely reversed.
    ; Animations are Standing unless: Sitting, Squatting, Kneeling, Lying
    ; Speed: Still, Calm, Active, Gyrating
    ; Jiggly = Especially good for breast movement.
    ; Presentation: Ass, Breasts, or Pussy
    ; Rubbing body = Sensual; Rubbing crotch = Masturbatory
	; Exercise
	; Relaxation — Any animations where the slave looks like she's just comfortably chillin'.
    ; Serving: Chalice 
    ; Submissive — e.g., crossed wrists, arms folded behind back, etc.
    ; Cleaning — There are only two of these
	; Dancing #373 is the only one

60 ; Active, Squatting, Fucking
107 ; Active, Squatting, Fucking
369 ; Active, Fucking
372 ; Active, Fucking

59 ; Lying, Active, Masturbatory, Penis
61 ; Lying, Active, Masturbatory, Penis
62 ; Sitting, Calm, Masturbatory, Penis
264 ; Calm, Masturbatory, Penis
408 ; Squatting, Active, Masturbatory, Penis

6 ; Fits, Lying, Gyrating, Presentation: Ass
40 ; Fits, Lying, Calm, Presentation: Pussy
108 ; Fits, Calm, Lying, Relaxation, Reversed
205 ; Fits, Calm, Lying, Sensual, Presentation: Ass, Relaxation, Reversed?
207 ; Fits, Lying, Active, Presentation: Ass, Reversed?
278 ; Fits, Lying, Calm, Presentation: Ass, Relaxation
349 ; Fits, Lying, Calm, Relaxation
367 ; Fits, Lying, Still, Relaxation, Reversed:90
399 ; Fits, Lying, Still, Relaxation, Reversed:90
418 ; Fits, Still, Lying, Submissive

32 ; Fits, Kneeling, Calm, Presentation: Ass, Reversed
95 ; Fits, Active, Kneeling, Presentation: Ass, Reversed
106 ; Active, Kneeling, Fucking, Reversed?
147 ; Fits, Kneeling, Active, Sensual
150 ; Fits, Kneeling, Calm, Sensual, Presentation: Ass, Reversed
289 ; Fits, Kneeling, Still, Presentation: Ass, Reversed
290 ; Fits, Kneeling, Still, Presentation: Breasts, Submissive ; Possible alternative to "Kneeling, hands behind head"
291 ; Active, Kneeling
294 ; Fits, Kneeling, Still, Submissive
296 ; Fits, Kneeling, Still
313 ; Fits, Kneeling, Still, Submissive
320 ; Fits, Calm, Kneeling, Sensual, Reversed
324 ; Fits, Kneeling, Gyrating, Submissive ; Possible alternative to "Kneeling, hands behind head"
332 ; Fits, Kneeling, Still
350 ; Fits, Kneeling, Calm, Presentation: Ass, Reversed
351 ; Fits, Kneeling, Calm, Presentation: Ass, Reversed
361 ; Fits, Kneeling, Still
393 ; Fits, Calm, Kneeling, Presentation: Ass, Pussy, Reversed
404 ; Fits, Calm, Kneeling
417 ; Fits, Still, Kneeling, Submissive ; Possible alternative to "Bow to your Mistress"
456 ; Fits, Kneeling, Still, Reversed
177 ; Fits, Kneeling, Gyrating, Presentation: Ass, Reversed
182 ; Fits, Kneeling, Active, Exercise, Presentation: Ass, Pussy, Reversed
192 ; Fits, Kneeling, Calm, Sensual, Presentation: Ass, Reversed
254 ; Fits, Calm, Kneeling, Presentation: Ass, Reversed

33 ; Fits, Sitting, Calm, Relaxation
228 ; Fits, Sitting, Calm, Relaxation
242 ; Fits, Sitting, Still, Relaxation
274 ; Fits, Calm, Sitting, Sensual, Relaxation
365 ; Fits, Sitting, Still, Relaxation
366 ; Fits, Sitting, Still, Relaxation
374 ; Fits, Sitting, Still, Presentation: Pussy, Relaxation
391 ; Fits, Sitting, Still, Relaxation
392 ; Fits, Sitting, Still
455 ; Fits, Sitting, Still, Relaxation
459 ; Fits, Sitting, Still, Relaxation

7 ; Fits, Gyrating, Masturbatory
11 ; Fits, Active, Very Active, Masturbatory
105 ; Fits, Active, Sensual, Very Sensual, Masturbatory
170 ; Fits, Gyrating, Masturbatory
226 ; Fits, Sitting, Calm, Masturbatory
371 ; Fits, Calm, Masturbatory, Submissive

18 ; Fits, Active, Squatting, Reversed
54 ; Fits, Squatting, Calm, Reversed:90
119 ; Squatting, Active, Reversed, Fucking?
127 ; Squatting, Active, Reversed, Fucking?
238 ; Fits, Squatting, Gyrating
243 ; Fits, Squatting, Active, Jiggly, Reversed:90?
277 ; Fits, Calm, Squatting
341 ; Fits, Squatting, Gyrating, Reversed
345 ; Active, Squatting
375 ; Fits, Squatting, Still
458 ; Fits, Squatting, Still, Relaxation



/;