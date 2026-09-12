Scriptname DOM_Diary extends Quest  
Import Utility
Import DOM_Util

DOM_PlayerAlias Property DOMPlayerAlias Auto 
DOM_Core Property DOMCore Auto
DOM_SlaverManager Property DOM01 Auto
DOM_SlaveManager Property DOM02 Auto
DOM_Generator Property DOMGenerator Auto

DOM_DiaryBook Property DiaryBookPlayer Auto
DOM_DiaryBook Property DiaryBook Auto
DOM_DiaryReadableBook Property DiaryReadPlayer Auto
DOM_DiaryReadableBook Property DiaryReadSlave Auto
DOM_DiaryReadableBook Property DiaryReadSlaver Auto
DOM_DiaryBook[] Property diaryArray Auto
DOM_DiaryBook[] Property diaryXArray Auto
ObjectReference Property DOMJeremyMarker Auto
ObjectReference Property DiaryMessageText Auto
ObjectReference Property DiaryTitle Auto
ObjectReference Property DiarySubTitle Auto
ObjectReference Property DiarySummary Auto
ObjectReference Property DiaryPersonalityEntry Auto
ObjectReference Property DiaryFeelingsEntry Auto
ObjectReference Property DiaryStatusEntry Auto
ObjectReference Property DiaryLastEntry Auto
ObjectReference[] Property DiaryParagraph Auto
Faction Property DOMPlayerSlaveFaction Auto
Faction Property DOMPlayerSlaverFaction Auto
Faction Property DOMSlaveManagerFaction Auto
; Origin factions
Faction Property DOMPlaceOriginFaction Auto
Faction Property DOMJobOriginFaction Auto
Faction Property DOMEmployerOriginFaction Auto
Faction Property DOMTrainerOriginFaction Auto
Faction Property DOMClassOriginFaction Auto

Message Property DOMDiaryPageMessage Auto
Int Property maxNumberOfParagraph = 128 Auto Hidden
bool Property playerDiaryToggle = true Auto Hidden
bool Property slaveDiaryToggle = true Auto Hidden
bool Property slaverDiaryToggle = true Auto Hidden

; Player's Diary
string quest_start_txt
float quest_start_time = 0.0
string quest_start_name
string quest_start_loc
int quest_start_mood = -1
int quest_start_gender = -1
Actor quest_start_actor

string quest_last_txt
float quest_last_time = 0.0
string quest_last_name
string quest_last_loc
int quest_last_mood = -1
int quest_last_gender = -1
Actor quest_last_actor

string quest_total_txt
string quest_origin_txt
string quest_combat_txt
string quest_mood_txt
string quest_behaviour_txt
int quest_total_capture = 0
int quest_total_female = 0
int quest_total_male = 0

string quest_release_txt
float quest_release_time = 0.0
int quest_release_total = 0
string quest_release_name
int quest_release_mood = 0
int quest_release_gender = -1
Actor quest_release_actor

string quest_ransom_txt
float quest_ransom_time = 0.0
int quest_ransom_total = 0
string quest_ransom_name
int quest_ransom_mood = 0
int quest_ransom_gender = -1
Actor quest_ransom_actor

string quest_sex_txt
int quest_sex_total = 0
int quest_sex_anal = 0
int quest_sex_oral = 0
int quest_sex_vaginal = 0
int quest_sex_gender
string quest_sex_name
int quest_sex_mood = -1
Actor quest_sex_actor

string quest_punish_txt
float quest_punish_time = 0.0
int quest_punish_strokes
int quest_punish_gender
string quest_punish_reason
string quest_punish_type
string quest_punish_name
int quest_punish_mood = -1
Actor quest_punish_actor

string quest_praise_txt
float quest_praise_time = 0.0
int quest_praise_gender
string quest_praise_reason
string quest_praise_type
string quest_praise_name
int quest_praise_mood = -1
Actor quest_praise_actor

string quest_chat_txt
float quest_chat_time = 0.0
int quest_chat_gender
string quest_chat_reason
string quest_chat_type
string quest_chat_name
int quest_chat_mood = -1
bool quest_chat_status
Actor quest_chat_actor

string quest_training_txt = ""
string quest_value_txt = ""
string quest_location_txt = ""

; Local slave information
string memory_slave_personality = ""
string memory_slave_feelings    = ""
string memory_slave_stats       = ""
string memory_slave_mood        = ""

Event OnInit()
	;LogInfo("Starting")
EndEvent

Function Initialize()
	LogInfo("===============================================================================")
	LogInfo("==                            DOM: Diary manager                             ==")
	LogInfo("===============================================================================")

	if DOMPlayerAlias == None
		ReferenceAlias player_alias = DOMCore.GetAliasByName("PlayerAlias") as ReferenceAlias
		DOMPlayerAlias = player_alias as DOM_PlayerAlias
		LogInfo("WARNING: DOMPlayerAlias was not set - trying to recover DOMPlayerAlias="+DOMPlayerAlias)
	endif
	if DiaryBookPlayer == None
		if DiaryBook != None
			DiaryBookPlayer = DiaryBook
		else
			DiaryBookPlayer = Game.GetFormFromFile(0x009E4C33, "DiaryOfMine.esm") as DOM_DiaryBook
		endif
	endif
	
	; Fill string arrays
	FillStringArrays()

	; Ensure phantom diaries are put somewhere that is not visible
	DiaryReadPlayer.Moveto(DOMJeremyMarker) ; Put book somewhere that is nowhere
	DiaryReadSlave.Moveto(DOMJeremyMarker)  ; Put book somewhere that is nowhere
	DiaryReadSlaver.Moveto(DOMJeremyMarker) ; Put book somewhere that is nowhere
	
	if DOMJobOriginFaction == None
		DOMJobOriginFaction = DOMGenerator.DOMJobOriginFaction
	endif
	;LogTrace("Initialize DOMJobOriginFaction="+DOMJobOriginFaction)
	if DOMEmployerOriginFaction == None
		DOMEmployerOriginFaction = DOMGenerator.DOMEmployerOriginFaction
	endif
	;LogTrace("Initialize DOMEmployerOriginFaction="+DOMEmployerOriginFaction)
	if DOMTrainerOriginFaction == None
		DOMTrainerOriginFaction = DOMGenerator.DOMTrainerOriginFaction
	endif
	;LogTrace("Initialize DOMTrainerOriginFaction="+DOMTrainerOriginFaction)
EndFunction

string[] Property placeOfOriginNames Auto Hidden
string[] Property jobOfOriginNames Auto Hidden
string[] Property employerOfOriginNames Auto Hidden
string[] Property trainerOfOriginNames Auto Hidden
string[] Property classOfOriginNames Auto Hidden
string[] Property trainingStatusNames Auto Hidden
string[] Property behaviourStatusNames Auto Hidden
string[] Property moodStatusNames Auto Hidden

Function FillStringArrays()
	if placeOfOriginNames.length < 16 || placeOfOriginNames[0] == ""
		LogTrace("FillArrays placeOfOriginNames")
		placeOfOriginNames = new string[16]
		int i = 0
		int n = 16
		while i < n
			placeOfOriginNames[i] = GetPlaceOfOriginNameByIndex(i)
			LogTrace("FillStringArrays placeOfOriginNames "+i+" "+placeOfOriginNames[i])
			i += 1
		endwhile
	endif
	if jobOfOriginNames.length < 107
		LogTrace("FillArrays jobOfOriginNames")
		jobOfOriginNames = new string[107]
		int i = 0
		int n = 107
		while i < n
			jobOfOriginNames[i] = GetJobOfOriginNameByIndex(i,true)
			LogTrace("FillStringArrays jobOfOriginNames "+i+" "+jobOfOriginNames[i])
			i += 1
		endwhile
	endif
	if employerOfOriginNames.length < 10
		LogTrace("FillArrays employerOfOriginNames")
		employerOfOriginNames = new string[10]
		int i = 0
		int n = 10
		while i < n
			employerOfOriginNames[i] = GetEmployerOfOriginNameByIndex(i)
			LogTrace("FillStringArrays employerOfOriginNames "+i+" "+employerOfOriginNames[i])
			i += 1
		endwhile
	endif
	if trainerOfOriginNames.length < 19
		LogTrace("FillArrays trainerOfOriginNames")
		trainerOfOriginNames = new string[19]
		int i = 0
		int n = 19
		while i < n
			trainerOfOriginNames[i] = GetTrainerOfOriginNameByIndex(i)
			LogTrace("FillStringArrays trainerOfOriginNames "+i+" "+trainerOfOriginNames[i])
			i += 1
		endwhile
	endif
	if classOfOriginNames.length < 38
		LogTrace("FillArrays classOfOriginNames")
		classOfOriginNames = new string[38]
		int i = 0
		int n = 38
		while i < n
			classOfOriginNames[i] = GetClassOfOriginNameByIndex(i)
			LogTrace("FillStringArrays classOfOriginNames "+i+" "+classOfOriginNames[i])
			i += 1
		endwhile
	endif
	if trainingStatusNames.length < 28
		LogTrace("FillArrays trainingStatusNames")
		trainingStatusNames = new string[28]
		int i = 0
		int n = 28
		while i < n
			trainingStatusNames[i] = GetTrainingStatusNameByIndex(i)
			LogTrace("FillStringArrays trainingStatusNames "+i+" "+trainingStatusNames[i])
			i += 1
		endwhile
	endif
	if behaviourStatusNames.length < 39
		LogTrace("FillArrays behaviourStatusNames")
		behaviourStatusNames = new string[39]
		int i = 0
		int n = 39
		while i < n
			behaviourStatusNames[i] = GetBehaviourTextByIndex(i)
			LogTrace("FillStringArrays behaviourStatusNames "+i+" "+behaviourStatusNames[i])
			i += 1
		endwhile
	endif
	if moodStatusNames.length < 22
		LogTrace("FillArrays moodStatusNames")
		moodStatusNames = new string[22]
		int i = 0
		int n = 22
		while i < n
			moodStatusNames[i] = GetMoodTextByIndex(i)
			LogTrace("FillStringArrays moodStatusNames "+i+" "+moodStatusNames[i])
			i += 1
		endwhile
	endif
EndFunction

string Function GetPlaceOfOriginName(Actor akRef)
	int idx = akRef.GetFactionRank(DOMPlaceOriginFaction)
	string the_place
	if idx >= 0 && idx < placeOfOriginNames.length
		the_place = placeOfOriginNames[idx]
		;LogTrace("GetPlaceOfOriginName from array idx="+idx+" place="+the_place)
	else
		the_place = GetPlaceOfOriginNameByIndex(idx)
		LogTrace("GetPlaceOfOriginName from DOM_Util idx="+idx+" place="+the_place)
	endif
	return the_place
EndFunction

string Function GetJobOfOriginName(Actor akRef)
	;LogTrace("GetJobOfOriginName faction="+DOMJobOriginFaction)
	int idx = akRef.GetFactionRank(DOMJobOriginFaction)
	bool is_female = (akRef.GetLeveledActorBase().GetSex() == 1)
	string the_job
	if idx >= 0 && idx < jobOfOriginNames.length && (is_female || idx != 2) ; Noble man gets job title from DOM_Util
		the_job = jobOfOriginNames[idx]
		;LogTrace("GetJobOfOriginName from array idx="+idx+" job="+the_job)
	else
		the_job = GetJobOfOriginNameByIndex(idx,is_female)
		LogTrace("GetJobOfOriginName from DOM_Util idx="+idx+" job="+the_job)
	endif
	return the_job
EndFunction

string Function GetEmployerOfOriginName(Actor akRef)
	;LogTrace("DOMEmployerOriginFaction = "+DOMEmployerOriginFaction)
	int idx = akRef.GetFactionRank(DOMEmployerOriginFaction)
	string the_employer
	if idx >= 0 && idx < employerOfOriginNames.length
		the_employer = employerOfOriginNames[idx]
		;LogTrace("GetEmployerOfOriginName from array idx="+idx+" employer="+the_employer)
	else
		the_employer = GetEmployerOfOriginNameByIndex(idx)
		LogTrace("GetEmployerOfOriginName from DOM_Util idx="+idx+" employer="+the_employer)
	endif
	return the_employer
EndFunction

string Function GetTrainerOfOriginName(Actor akRef)
	;LogTrace("DOMTrainerOriginFaction = "+DOMTrainerOriginFaction)
	int idx = akRef.GetFactionRank(DOMTrainerOriginFaction)
	string the_skill
	if idx >= 0 && idx < trainerOfOriginNames.length
		the_skill = trainerOfOriginNames[idx]
		;LogTrace("GetTrainerOfOriginName from array idx="+idx+" skill="+the_skill)
	else
		the_skill = GetTrainerOfOriginNameByIndex(idx)
		LogTrace("GetTrainerOfOriginName from DOM_Util idx="+idx+" skill="+the_skill)
	endif
	return the_skill
EndFunction

string Function GetClassOfOriginName(Actor akRef)
	int idx = akRef.GetFactionRank(DOMClassOriginFaction)
	string the_skill
	if idx >= 0 && idx < classOfOriginNames.length
		the_skill = classOfOriginNames[idx]
		;LogTrace("GetClassOfOriginName from array idx="+idx+" skill="+the_skill)
	else
		the_skill = GetClassOfOriginNameByIndex(idx)
		LogTrace("GetClassOfOriginName from DOM_Util idx="+idx+" skill="+the_skill)
	endif
	return the_skill
EndFunction

string Function GetOccupationOfOriginName(Actor akRef)
	string the_job = GetJobOfOriginName(akRef)
	string the_emp = GetEmployerOfOriginName(akRef)
	string the_skill = GetTrainerOfOriginName(akRef)
	string the_class = GetClassOfOriginName(akRef)
	LogTrace("GetOccupationOfOriginName "+akRef.GetDisplayName()+" job="+the_job+" employer="+the_emp+" trainer skill="+the_skill+" class="+the_class)
	if the_job != "" && the_class != "" ; check for doubles
		if stringUtil.find(the_job,the_class)>=0
			the_class = ""
		elseif stringUtil.find(the_class,the_job)>=0
			the_job = the_class
			the_class = ""
		endif
	endif
	if the_class != ""
		if the_class == "Archer" || the_class == "Assassin"
			the_class = "an "+the_class
		elseif the_class != "Missile" && the_class != "Melee"
			the_class = "a "+the_class
		endif
	endif
	if the_job == ""
		if the_class != ""
			the_job = the_class
			the_class = ""
		endif
	endif
	if the_job == ""
		if the_emp == ""
			if the_skill == ""
				return ""
			endif
			return "a trainer in "+the_skill
		endif
		if the_skill == ""
			return "working in "+the_emp
		endif
		return "working in "+the_emp+" and a trainer in "+the_skill
	endif
	if the_class == ""
		if the_emp == ""
			if the_skill == ""
				return the_job
			endif
			return the_job+" and a trainer in "+the_skill
		endif
		if the_skill == ""
			return the_job+" in "+the_emp
		endif
		return the_job+" in "+the_emp+" and a trainer in "+the_skill
	endif
	if the_emp == ""
		if the_skill == ""
			return the_job+" and "+the_class
		endif
		return the_job+" and "+the_class+". I am also a trainer in "+the_skill
	endif
	if the_skill == ""
		return the_job+" and "+the_class+" in "+the_emp
	endif
	return the_job+" and "+the_class+" in "+the_emp+". I am also a trainer in "+the_skill
EndFunction

string Function GetTrainingStatusName(int idx)
	string the_status
	if idx >= 0 && idx < trainingStatusNames.length
		the_status = trainingStatusNames[idx]
		;LogTrace("GetTrainingStatusName from array idx="+idx+" status="+the_status)
	else
		the_status = GetTrainerOfOriginNameByIndex(idx)
		LogTrace("GetTrainingStatusName from DOM_Util idx="+idx+" status="+the_status)
	endif
	return the_status
EndFunction

string Function GetBehaviourStatusName(int idx)
	string the_status
	if idx >= 0 && idx < behaviourStatusNames.length
		the_status = behaviourStatusNames[idx]
		;LogTrace("GetBehaviourStatusName from array idx="+idx+" status="+the_status)
	else
		the_status = GetBehaviourTextByIndex(idx)
		LogTrace("GetBehaviourStatusName from DOM_Util idx="+idx+" status="+the_status)
	endif
	return the_status
EndFunction

string Function GetMoodStatusName(int idx)
	string the_status
	if idx >= 0 && idx < moodStatusNames.length
		the_status = moodStatusNames[idx]
		;LogTrace("GetMoodStatusName from array idx="+idx+" status="+the_status)
	else
		the_status = GetMoodTextByIndex(idx)
		LogTrace("GetMoodStatusName from DOM_Util idx="+idx+" status="+the_status)
	endif
	return the_status
EndFunction

DOM_DiaryBook Function GetDiary(DOM_Actor akActor)
	if akActor == None
		return DiaryBookPlayer
	endif
	if akActor.akRef.IsInFaction(DOMPlayerSlaverFaction)
		return GetDiaryX(akActor)
	endif
	int rank = akActor.akRef.GetFactionRank(DOMSlaveManagerFaction)
	if rank != 0
		return None
	endif
	int idx = DOM02.GetAliasIndex(akActor.akRef)
	if idx < 0 || idx >= diaryArray.length
		return None
	endif
	return diaryArray[idx]
EndFunction

DOM_DiaryBook Function GetDiaryX(DOM_Actor akActor)
	int idx = DOM01.GetAliasIndex(akActor.akRef)
	if idx < 0 || idx >= diaryXArray.length
		return None
	endif
	return diaryXArray[idx]
EndFunction

Function CheckDiaryByIndex(int idx, DOM_Actor akActor)
	;LogTrace("CheckDiaryByIndex: "+idx+" size="+diaryArray.length)
	if idx < 0 || idx >= diaryArray.length
		return
	endif
	DOM_DiaryBook akBook = diaryArray[idx]
	if akBook.actor_alias != None
		if akBook.actor_alias == akActor && akBook.GetDisplayName() == "Diary of "+akActor.GetName() ; Already set
			;LogTrace("CheckDiaryByIndex: "+idx+" name="+akBook.GetDisplayName())
			return
		endif
	endif
	LogTrace("Reset diary: "+akBook.GetDisplayName()+" for "+akActor.GetName())
	DOM_Mind akMind = akActor.mind
	if akMind.memory_capture_time == 0.0
		akMind.memory_capture_time = GetCurrentGameTime()
	endif
	if akMind.memory_capture_mood <= 0
		akMind.memory_capture_mood = akMind.GetMoodIndex()
	endif
	if akMind.memory_capture_occupation == "" 
		akMind.memory_capture_occupation = GetOccupationOfOriginName(akActor.akRef)
	endif
	if akMind.memory_capture_location == "" ; || akMind.memory_capture_location == "the wilderness"
		akMind.memory_capture_location = GetLocationName(akActor.akRef)
	endif
	if akMind.memory_capture_origin == ""
		akMind.memory_capture_origin = GetPlaceOfOriginName(akActor.akRef)
	endif
	if akMind.memory_capture_type == ""
		akMind.memory_capture_type = "overwhelmed"
	endif
	;akBook.SetAsMyDiary(akActor,Game.GetPlayer())
	akBook.SetAsMyDiary(akActor,akActor.akRef)
	LogTrace("Recovered diary: "+akBook.GetName()+" / "+akBook.GetDisplayName())
EndFunction

Function CheckDiaryXByIndex(int idx, DOM_Actor akActor)
	;LogTrace("CheckDiaryXByIndex: "+idx+" size="+diaryXArray.length)
	if idx < 0 || idx >= diaryXArray.length
		return
	endif
	DOM_DiaryBook akBook = diaryXArray[idx]
	if akBook.actor_alias != None
		if akBook.actor_alias == akActor && akBook.GetDisplayName() == "Diary of "+akActor.GetName() ; Already set
			;LogTrace("CheckDiaryXByIndex: "+idx+" name="+akBook.GetDisplayName())
			return
		endif
	endif
	LogTrace("Reset diary X: "+akBook.GetDisplayName()+" for "+akActor.GetName())
	DOM_Mind akMind = akActor.mind
	if akMind.memory_capture_time == 0.0
		akMind.memory_capture_time = GetCurrentGameTime()
	endif
	if akMind.memory_capture_mood <= 0
		akMind.memory_capture_mood = akMind.GetMoodIndex()
	endif
	if akMind.memory_capture_occupation == "" 
		akMind.memory_capture_occupation = GetOccupationOfOriginName(akActor.akRef)
	endif
	if akMind.memory_capture_location == "" ; || akMind.memory_capture_location == "the wilderness"
		akMind.memory_capture_location = GetLocationName(akActor.akRef)
	endif
	if akMind.memory_capture_origin == ""
		akMind.memory_capture_origin = GetPlaceOfOriginName(akActor.akRef)
	endif
	if akMind.memory_capture_type == ""
		akMind.memory_capture_type = "recruited"
	endif
	;akBook.SetAsMyDiary(akActor,Game.GetPlayer())
	akBook.SetAsMyDiary(akActor,akActor.akRef)
	LogTrace("Recovered diary X: "+akBook.GetName()+" / "+akBook.GetDisplayName())
EndFunction

Function CloseDiary(DOM_Actor akActor)
	DOM_DiaryBook akBook = GetDiary(akActor)
	;LogTrace("CloseDiary book="+akBook)
	if akBook == None
		return
	endif
	akBook.Moveto(DOMJeremyMarker) ; Put book somewhere that is nowhere
	akBook.SetDisplayName("A Diary",true)
EndFunction

Function OpenDiary(DOM_Actor akActor, bool is_player_diary)
	if akActor != None
		LogTrace("OpenDiary "+akActor.GetName())
	else
		LogTrace("OpenDiary for Player")
	endif
	if is_player_diary
		ClearPlayerMemory()
	else
		ClearSlaveMemory()
	endif
	int ipar = 0
	int ibutton = 0
	LogTrace("OpenDiary DiaryTitle="+DiaryTitle.GetBaseObject().GetName())
	while ibutton != 7
		string msg
		if is_player_diary || akActor == None
			msg = GetNextParagraphTextPlayer(ipar)
		else
			msg = GetNextParagraphTextSlave(ipar,akActor)
		endif
		DiaryMessageText.GetBaseObject().SetName(msg)
		LogTrace("OpenDiary DiaryMessageText="+DiaryMessageText.GetBaseObject().GetName())
		ibutton = DOMDiaryPageMessage.Show()
		if ibutton != 7 ; Exit
			if is_player_diary || akActor == None
				ipar = GetNextParagraphIndexPlayer(ipar,ibutton)
			else
				ipar = GetNextParagraphIndexSlave(ipar,ibutton,akActor)
			endif
		endif
	endwhile
EndFunction

int Function GetNextParagraphIndexPlayer(int ipar, int ibutton)
	if ibutton == 0 || ibutton == 7
		return 0
	endif
	if ibutton == 1
		ipar -= 10
		if ipar <= 0
			return 0
		endif
		return ipar
	endif
	if ibutton == 2
		ipar -= 1
		if ipar <= 0
			return 0
		endif
		return ipar
	endif
	if ibutton == 3
		ipar += 1
		if ipar > 19
			ipar = 19
		endif
		return ipar
	endif
	if ibutton == 4
		ipar += 10
		if ipar > 19
			ipar = 19
		endif
		return ipar
	endif
	if ibutton == 5
		return 9
	endif
	return 19
EndFunction	

int Function GetNextParagraphIndexSlave(int ipar, int ibutton, DOM_Actor akActor)
	if ibutton == 0 || ibutton == 7
		return 0
	endif
	if ibutton == 1
		ipar -= 10
		if ipar <= 0
			return 0
		endif
		return ipar
	endif
	if ibutton == 2
		ipar -= 1
		if ipar <= 0
			return 0
		endif
		return ipar
	endif
	int nent = akActor.mind.memory_entries + 5
	if ibutton == 3
		ipar += 1
		if ipar > nent
			ipar = nent
		endif
		return ipar
	endif
	if ibutton == 4
		ipar += 10
		if ipar > nent
			ipar = nent
		endif
		return ipar
	endif
	if ibutton == 5
		return akActor.mind.memory_entries + 1
	endif
	return nent
EndFunction	

string Function GetNextParagraphTextPlayer(int ipar)
	if ipar == 0
		return TextPlayerFirstCapture()
	endif
	if ipar == 1
		return TextPlayerTotalCapture()
	endif
	if ipar == 2
		return TextSlavesTrainingLevel()
	endif
	if ipar == 3
		return TextSlavesBehaviour()
	endif
	if ipar == 4
		return TextSlavesMood()
	endif
	if ipar == 5
		return TextSlavesValue()
	endif
	if ipar == 6
		return TextSlavesLocation()
	endif
	if ipar == 7
		return TextSlavesOrigin()
	endif
	if ipar == 8
		return TextSlavesSexualAbuse()
	endif
	if ipar == 9
		return TextSlavesPunishment()
	endif
	if ipar == 10
		return TextSlavesPraise()
	endif
	if ipar == 11
		return TextSlavesChat()
	endif
	if ipar == 12
		return TextSlavesSlavers()
	endif
	if ipar == 13
		return TextSlavesHome()
	endif
	if ipar == 14
		return TextSlavesRansom()
	endif
	if ipar == 15
		return TextSlavesSold()
	endif
	if ipar == 16
		return TextSlavesRelease()
	endif
	if ipar == 17
		return TextSlavesMaid()
	endif
	if ipar == 18
		return TextSlavesCombat()
	endif
	if ipar == 19
		return TextPlayerLastCapture()
	endif
	return ""
EndFunction

string Function GetNextParagraphTextSlave(int ipar, DOM_Actor akActor)
	if ipar == 0
		return TextSlavePresentation(akActor)
	endif
	if ipar == 1
		return TextSlaveCapture(akActor)
	endif
	int ient = ipar - (2)
	int nent = akActor.mind.memory_entries
	if ient < nent
		return TextSlaveAbuse(ient,akActor)
	endif
	if ient == nent
		return TextSlaveTraits(akActor)
	endif
	if ient == (nent + 1)
		return TextSlaveFeelings(akActor)
	endif
	if ient == (nent + 2)
		return TextSlaveStats(akActor)
	endif
	if ient == (nent + 3)
		return TextSlaveMood(akActor)
	endif
	return ""
EndFunction
Function ClearPlayerMemory()
	quest_training_txt = ""
	quest_value_txt = ""
	quest_location_txt = ""
EndFunction

Function ClearSlaveMemory()
	memory_slave_personality = ""
	memory_slave_feelings    = ""
    memory_slave_stats       = ""
    memory_slave_mood        = ""
EndFunction

string Function TextSlaveMood(DOM_Actor akActor)
	if memory_slave_mood == ""
		memory_slave_mood = DOMCore.DOMMoodMessage(akActor.akRef)
	endif
	return memory_slave_mood
EndFunction

string Function TextSlaveStats(DOM_Actor akActor)
	if memory_slave_stats == ""
		memory_slave_stats = DOMCore.DOMStatsMessage(akActor.akRef)
	endif
	return memory_slave_stats
EndFunction

string Function TextSlaveFeelings(DOM_Actor akActor)
	if memory_slave_feelings == ""
		memory_slave_feelings = DOMCore.DOMFeelingsVerboseMessage(akActor.akRef)
	endif
	return memory_slave_feelings
EndFunction

string Function TextSlaveTraits(DOM_Actor akActor)
	if memory_slave_personality == ""
		memory_slave_personality = DOMCore.DOMTraitsVerboseMessage(akActor.akRef)
	endif
	return memory_slave_personality
EndFunction

Function UpdatePlayerText()
	LogTrace("Player's diary is updating number of paragraphs="+DiaryParagraph.Length)	
	ClearPlayerMemory()

	DiaryTitle.GetBaseObject().SetName(TextPlayerFirstCapture())
	DiarySubTitle.GetBaseObject().SetName(TextPlayerTotalCapture())
	DiarySummary.GetBaseObject().SetName(TextSlavesTrainingLevel())
	DiaryParagraph[0].GetBaseObject().SetName(TextSlavesBehaviour())
	DiaryParagraph[1].GetBaseObject().SetName(TextSlavesMood())
	DiaryParagraph[2].GetBaseObject().SetName(TextSlavesValue())
	DiaryParagraph[3].GetBaseObject().SetName(TextSlavesLocation())
	DiaryParagraph[4].GetBaseObject().SetName(TextSlavesOrigin())
	DiaryParagraph[5].GetBaseObject().SetName(TextSlavesSexualAbuse())
	DiaryParagraph[6].GetBaseObject().SetName(TextSlavesPunishment())
	DiaryParagraph[7].GetBaseObject().SetName(TextSlavesPraise())
	DiaryParagraph[8].GetBaseObject().SetName(TextSlavesChat())
	DiaryParagraph[9].GetBaseObject().SetName(TextSlavesSlavers())
	DiaryParagraph[10].GetBaseObject().SetName(TextSlavesHome())
	DiaryParagraph[11].GetBaseObject().SetName(TextSlavesRansom())
	DiaryParagraph[12].GetBaseObject().SetName(TextSlavesSold())
	DiaryParagraph[13].GetBaseObject().SetName(TextSlavesRelease())
	DiaryParagraph[14].GetBaseObject().SetName(TextSlavesMaid())
	DiaryParagraph[15].GetBaseObject().SetName(TextSlavesCombat())
	DiaryParagraph[16].GetBaseObject().SetName(TextPlayerLastCapture())
EndFunction

Function UpdateSlaveText(DOM_Actor akActor)
	;LogTrace("UpdateSlaveText: Slave's diary is updating actor="+akActor)	
	if akActor == None
		if diaryArray.length < 1
			;LogTrace("UpdateSlaveText: array is empty")	
			return
		endif
		akActor = diaryArray[0].actor_alias
		if akActor == None
			;LogTrace("UpdateSlaveText: no valid actor found")	
			return
		endif
	endif
	if akActor.akRef == None
		return
	endif
	;LogTrace("UpdateSlaveText: Slave's diary is updating "+akActor.GetName())	
	ClearSlaveMemory()

	DiaryTitle.GetBaseObject().SetName(TextSlavePresentation(akActor))
	DiarySubTitle.GetBaseObject().SetName(TextSlaveCapture(akActor))
	int ient = 0
	;LogTrace("UpdateSlaveText first par ient="+ient)
	DiarySummary.GetBaseObject().SetName(TextSlaveAbuse(ient,akActor))
	ient += 1
	int ipar = 0
	int nent = akActor.mind.memory_entries
	int nparmax = DiaryParagraph.length
	int npar = nparmax
	if npar > maxNumberOfParagraph
		npar = maxNumberOfParagraph
	endif
	int nskip = nent - npar
	int nmod = 0
	if nskip < 0
		nskip = 0
	elseif nskip > npar
		nskip = nskip /npar
	else
		nmod = npar / nskip
		nskip = nmod / 2
	endif
	;LogTrace("UpdateSlaveText nent="+nent+" npar="+npar+" nparmax="+nparmax+" nskip="+nskip+" nmod="+nmod)
	int last_entry = 0
	while ient < nent && ipar < npar
		;LogTrace("UpdateSlaveText fill paragraph i="+ipar+" with entry="+ient)
		DiaryParagraph[ipar].GetBaseObject().SetName(TextSlaveAbuse(ient,akActor))
		last_entry = ient
		ipar += 1
		if nskip == 0
			ient += 1
		elseif nmod == 0
			ient += nskip
		else
			ient += 1
			if ((ient-nskip) % nmod) == 0
				ient += 1
			endif
		endif
	endwhile
	if ipar < nparmax && last_entry < (nent - (1)) ; Last entry was not printed
		last_entry = nent - (1)
		;LogTrace("UpdateSlaveText fill paragraph i="+ipar+" with last entry="+last_entry)
		DiaryParagraph[ipar].GetBaseObject().SetName(TextSlaveAbuse(last_entry,akActor))
		ipar += 1
	endif
	if ipar < nparmax
		DiaryParagraph[ipar].GetBaseObject().SetName(DOMCore.DOMTraitsVerboseMessage(akActor.akRef))
		DiaryPersonalityEntry.GetBaseObject().SetName("")
		ipar += 1
	else
		DiaryPersonalityEntry.GetBaseObject().SetName(DOMCore.DOMTraitsVerboseMessage(akActor.akRef))
	endif
	if akActor.mind.is_slave
		if ipar < nparmax
			DiaryParagraph[ipar].GetBaseObject().SetName(DOMCore.DOMFeelingsVerboseMessage(akActor.akRef))
			DiaryFeelingsEntry.GetBaseObject().SetName("")
			ipar += 1
		else
			DiaryFeelingsEntry.GetBaseObject().SetName(DOMCore.DOMFeelingsVerboseMessage(akActor.akRef))
		endif
	else
			DiaryFeelingsEntry.GetBaseObject().SetName("")
	endif
	if ipar < nparmax
		DiaryParagraph[ipar].GetBaseObject().SetName(DOMCore.DOMStatsMessage(akActor.akRef))
		DiaryStatusEntry.GetBaseObject().SetName("")
		ipar += 1
	else
		DiaryStatusEntry.GetBaseObject().SetName(DOMCore.DOMStatsMessage(akActor.akRef))
	endif
	if ipar < nparmax
		DiaryParagraph[ipar].GetBaseObject().SetName(DOMCore.DOMMoodMessage(akActor.akRef))
		DiaryLastEntry.GetBaseObject().SetName("")
		ipar += 1
	else
		DiaryLastEntry.GetBaseObject().SetName(DOMCore.DOMMoodMessage(akActor.akRef))
	endif

	while ipar < nparmax
		;LogTrace("UpdateSlaveText clear paragraph i="+ipar)
		DiaryParagraph[ipar].GetBaseObject().SetName("")
		ipar += 1
	endwhile
EndFunction

; ===================================================================================
; =                                                                                 =
; = Memory notifications                                                            =
; =                                                                                 =
; ===================================================================================

Function NotifyLoadGame()
	;LogTrace("NotifyLoadGame")
	if DiaryBookPlayer.GetActorOwner() != None
		DiaryBookPlayer.SetAsMyDiary(None,Game.GetPlayer())
	endif
	if quest_start_time != 0.0
		return
	endif
	int nslaves = DOM02.GetActorCount()
	if nslaves == 0
		return
	endif
	; Slaves were captured but Diary start time was never set.
	if quest_total_capture == 0
		quest_total_capture = nslaves
	endif
	bool do_last = true
	if quest_last_actor != None
		do_last = false
	endif
	float current_time = GetCurrentGameTime()
	int idx = 0
	while idx < nslaves
		DOM_Actor akActor = DOM02.GetActorByIndex(idx)
		if akActor != None 
			int gender = (akActor.actorSex) % 2
			if quest_start_actor == None
				quest_start_txt = ""
				quest_start_time = current_time
				quest_start_name = akActor.GetName()
				quest_start_loc = GetLocationName(akActor.akRef)
				quest_start_gender = gender
				quest_start_actor = akActor.akRef
				quest_start_mood  = akActor.mind.GetMoodIndex()
				if quest_start_mood == 10 ; neutral
					quest_start_mood = 3 ; afraid
				endif
			endif
			if do_last && idx+1 >= nslaves
				quest_last_txt = ""
				quest_last_time = current_time
				quest_last_name = akActor.GetName()
				quest_last_loc = GetLocationName(akActor.akRef)
				quest_last_gender = gender
				quest_last_actor = akActor.akRef
				quest_last_mood = akActor.mind.GetMoodIndex()
				if quest_last_mood == 10 ; neutral
					quest_last_mood = 3 ; afraid
				endif
			endif
			if gender == 1
				quest_total_female += 1
			else
				quest_total_male += 1
			endif
		endif
		idx += 1
	endwhile
EndFunction

Function NotifyTrainingStatusUpdate(DOM_Actor akActor, int the_level)
	if !slaveDiaryToggle && akActor.mind.is_slave
		return
	endif
	if !slaverDiaryToggle && !(akActor.mind.is_slave)
		return
	endif
	quest_training_txt = ""
	DOM_Mind akMind = akActor.mind
	;LogTrace("NotifyTrainingStatusUpdate "+akActor.GetName())
	int the_mood = akMind.GetMoodIndex()
	string the_status = GetTrainingStatusName(the_level)
	string the_loc = GetLocationName(akActor.akRef)
	float current_time = GetCurrentGameTime()
	int idx = akMind.StoreNewMemory(40, current_time, the_loc, the_status, "", the_mood, the_level, akMind.IsRespectfulWritings(), akMind.IsDevoted() || !akMind.is_slave)
	SetTextSlaveTrainingStatusUpdate(idx, akActor)
	akMind.RegisterNewMemory(idx)
EndFunction

Function NotifyChangeMood(DOM_Actor akActor)
	if !slaveDiaryToggle && akActor.mind.is_slave
		return
	endif
	if !slaverDiaryToggle && !(akActor.mind.is_slave)
		return
	endif
	quest_mood_txt = ""
	if akActor.mind.IsAshamed()
		NotifyMoodAshamed(akActor)
	elseif akActor.mind.mood == "broken"
		NotifyMoodBroken(akActor)
	elseif akActor.mind.mood == "inlove"
		NotifyMoodInLove(akActor)
	endif
EndFunction

Function NotifyMoodAshamed(DOM_Actor akActor)
	if !slaveDiaryToggle && akActor.mind.is_slave
		return
	endif
	if !slaverDiaryToggle && !(akActor.mind.is_slave)
		return
	endif
	DOM_Mind akMind = akActor.mind
	;LogTrace("NotifyMoodAshamed "+akActor.GetName())
	int the_mood = 6 ; ashamed
	int the_level = akMind.training_status
	string the_loc = GetLocationName(akActor.akRef)
	float current_time = GetCurrentGameTime()
	int idx = akMind.StoreNewMemory(28, current_time, the_loc, "ashamed", "", the_mood, the_level, akMind.IsRespectfulWritings(), akMind.IsDevoted() || !akMind.is_slave)
	SetTextSlaveAshamed(idx, akActor)
	akMind.RegisterNewMemory(idx)
EndFunction

Function NotifyMoodShock(DOM_Actor akActor)
	if !slaveDiaryToggle && akActor.mind.is_slave
		return
	endif
	if !slaverDiaryToggle && !(akActor.mind.is_slave)
		return
	endif
	DOM_Mind akMind = akActor.mind
	if akMind.HasMemory(29) ; Shock memory already registered
		return
	endif
	;LogTrace("NotifyMoodShock "+akActor.GetName())
	int the_mood = 8 ; shock
	int the_level = akMind.training_status
	string the_loc = GetLocationName(akActor.akRef)
	float current_time = GetCurrentGameTime()
	int idx = akMind.StoreNewMemory(29, current_time, the_loc, "shock", "for the first time", the_mood, the_level, akMind.IsRespectfulWritings(), akMind.IsDevoted() || !akMind.is_slave)
	SetTextSlaveShock(idx, akActor)
	akMind.RegisterNewMemory(idx)
EndFunction

Function NotifyMoodBroken(DOM_Actor akActor)
	if !slaveDiaryToggle && akActor.mind.is_slave
		return
	endif
	if !slaverDiaryToggle && !(akActor.mind.is_slave)
		return
	endif
	DOM_Mind akMind = akActor.mind
	if akMind.HasMemory(30) ; Broken memory already registered
		return
	endif
	;LogTrace("NotifyMoodBroken "+akActor.GetName())
	int the_mood = 9 ; broken
	int the_level = akMind.training_status
	string the_loc = GetLocationName(akActor.akRef)
	float current_time = GetCurrentGameTime()
	int idx = akMind.StoreNewMemory(30, current_time, the_loc, "broken", "for the first time", the_mood, the_level, akMind.IsRespectfulWritings(), akMind.IsDevoted() || !akMind.is_slave)
	SetTextSlaveBroken(idx, akActor)
	akMind.RegisterNewMemory(idx)
EndFunction

Function NotifyMoodInLove(DOM_Actor akActor)
	if !slaveDiaryToggle && akActor.mind.is_slave
		return
	endif
	if !slaverDiaryToggle && !(akActor.mind.is_slave)
		return
	endif
	DOM_Mind akMind = akActor.mind
	if akMind.HasMemory(31) ; Falling in love memory already registered
		return
	endif
	;LogTrace("NotifyMoodInLove "+akActor.GetName())
	int the_mood = 14 ; in love
	int the_level = akMind.training_status
	string the_loc = GetLocationName(akActor.akRef)
	float current_time = GetCurrentGameTime()
	int idx = akMind.StoreNewMemory(31, current_time, the_loc, "inlove", "for the first time", the_mood, the_level, akMind.IsRespectfulWritings(), akMind.IsDevoted() || !akMind.is_slave)
	SetTextSlaveInLove(idx, akActor)
	akMind.RegisterNewMemory(idx)
EndFunction

Function NotifyChangeBehaviour(DOM_Actor akActor)
	if !slaveDiaryToggle && akActor.mind.is_slave
		return
	endif
	if !slaverDiaryToggle && !(akActor.mind.is_slave)
		return
	endif
	if akActor.prev_behaviour == akActor.behaviour
		return
	endif
	quest_behaviour_txt = ""
	;LogTrace("NotifyChangeBehaviour "+akActor.GetName())

	if akActor.behaviour == "masturbate"
		NotifyBehaviourMasturbate(akActor)
	elseif akActor.behaviour == "pose"
		NotifyBehaviourPose(akActor)
	elseif akActor.behaviour == "jail_stand" || akActor.behaviour == "jail_sandbox" || akActor.behaviour == "jail_restrained"
		NotifyBehaviourJail(akActor)
	elseif akActor.behaviour == "work"
		NotifyBehaviourWork(akActor)
	elseif akActor.behaviour == "clean_house"
		NotifyBehaviourSweep(akActor)
	elseif akActor.is_restrained
		NotifyBehaviourTied(akActor)
	endif
EndFunction

Function NotifyBehaviourMasturbate(DOM_Actor akActor)
	if !slaveDiaryToggle && akActor.mind.is_slave
		return
	endif
	if !slaverDiaryToggle && !(akActor.mind.is_slave)
		return
	endif
	DOM_Mind akMind = akActor.mind
	int the_mood = akMind.GetMoodIndex()
	int the_level = akMind.training_status
	string the_loc = GetLocationName(akActor.akRef)
	float current_time = GetCurrentGameTime()
	int idx = akMind.StoreNewMemory(15, current_time, the_loc, akActor.behaviour, akActor.poseId, the_mood, the_level, akMind.IsRespectfulWritings(), akMind.IsDevoted() || !akMind.is_slave)
	SetTextSlaveMasturbate(idx, akActor)
	akMind.RegisterNewMemory(idx)
EndFunction

Function NotifyBehaviourPose(DOM_Actor akActor)
	if !slaveDiaryToggle && akActor.mind.is_slave
		return
	endif
	if !slaverDiaryToggle && !(akActor.mind.is_slave)
		return
	endif
	DOM_Mind akMind = akActor.mind
	int the_mood = akMind.GetMoodIndex()
	int the_level = akMind.training_status
	string the_loc = GetLocationName(akActor.akRef)
	float current_time = GetCurrentGameTime()
	int idx = akMind.StoreNewMemory(16, current_time, the_loc, akActor.behaviour, akActor.poseId, the_mood, the_level, akMind.IsRespectfulWritings(), akMind.IsDevoted() || !akMind.is_slave)
	SetTextSlavePose(idx, akActor)
	akMind.RegisterNewMemory(idx)
EndFunction

Function NotifyBehaviourTied(DOM_Actor akActor)
	if !slaveDiaryToggle && akActor.mind.is_slave
		return
	endif
	if !slaverDiaryToggle && !(akActor.mind.is_slave)
		return
	endif
	DOM_Mind akMind = akActor.mind
	int the_mood = akMind.GetMoodIndex()
	int the_level = akMind.training_status
	string the_loc = GetLocationName(akActor.akRef)
	float current_time = GetCurrentGameTime()
	int idx = akMind.StoreNewMemory(18, current_time, the_loc, akActor.behaviour, akActor.GetPose(), the_mood, the_level, akMind.IsRespectfulWritings(), akMind.IsDevoted() || !akMind.is_slave)
	SetTextSlaveTied(idx, akActor)
	akMind.RegisterNewMemory(idx)
EndFunction

Function NotifyBehaviourJail(DOM_Actor akActor)
	if !slaveDiaryToggle && akActor.mind.is_slave
		return
	endif
	if !slaverDiaryToggle && !(akActor.mind.is_slave)
		return
	endif
	DOM_Mind akMind = akActor.mind
	int the_mood = akMind.GetMoodIndex()
	int the_level = akMind.training_status
	string the_loc = GetLocationName(akActor.akRef)
	float current_time = GetCurrentGameTime()
	int idx = akMind.StoreNewMemory(44, current_time, the_loc, akActor.behaviour, akActor.GetPose(), the_mood, the_level, akMind.IsRespectfulWritings(), akMind.IsDevoted() || !akMind.is_slave)
	SetTextSlaveJail(idx, akActor)
	akMind.RegisterNewMemory(idx)
EndFunction

Function NotifyBehaviourSweep(DOM_Actor akActor)
	if !slaveDiaryToggle && akActor.mind.is_slave
		return
	endif
	if !slaverDiaryToggle && !(akActor.mind.is_slave)
		return
	endif
	DOM_Mind akMind = akActor.mind
	int the_mood = akMind.GetMoodIndex()
	int the_level = akMind.training_status
	string the_loc = GetLocationName(akActor.akRef)
	float current_time = GetCurrentGameTime()
	int idx = akMind.StoreNewMemory(45, current_time, the_loc, akActor.behaviour, "", the_mood, the_level, akMind.IsRespectfulWritings(), akMind.IsDevoted() || !akMind.is_slave)
	SetTextSlaveSweep(idx, akActor)
	akMind.RegisterNewMemory(idx)
EndFunction

Function NotifyBehaviourWork(DOM_Actor akActor)
	if !slaveDiaryToggle && akActor.mind.is_slave
		return
	endif
	if !slaverDiaryToggle && !(akActor.mind.is_slave)
		return
	endif
	DOM_Mind akMind = akActor.mind
	int the_mood = akMind.GetMoodIndex()
	int the_level = akMind.training_status
	string the_loc = GetLocationName(akActor.akRef)
	float current_time = GetCurrentGameTime()
	string reason
	int rank = akActor.akRef.GetFactionRank(DOMCore.DOMWorkMode)
	if rank == 1
		reason = "mine"
	else
		reason = "work"
	endif
	int idx = akMind.StoreNewMemory(46, current_time, the_loc, akActor.behaviour, reason, the_mood, the_level, akMind.IsRespectfulWritings(), akMind.IsDevoted() || !akMind.is_slave)
	SetTextSlaveWork(idx, akActor)
	akMind.RegisterNewMemory(idx)
EndFunction

Function NotifyShowering(DOM_Actor akActor, string type, bool is_success)
	if !slaveDiaryToggle && akActor.mind.is_slave
		return
	endif
	if !slaverDiaryToggle && !(akActor.mind.is_slave)
		return
	endif
	DOM_Mind akMind = akActor.mind
	if !akMind.should_be_naked ; not naked
		return
	endif
	int the_mood = akMind.GetMoodIndex()
	int the_level = akMind.training_status
	string the_loc = GetLocationName(akActor.akRef)
	float current_time = GetCurrentGameTime()
	int idx = akMind.StoreNewMemory(10, current_time, the_loc, type, akActor.dirty_level, the_mood, the_level, akMind.IsRespectfulWritings(), is_success)
	SetTextSlaveShowering(idx, akActor)
	akMind.RegisterNewMemory(idx)
EndFunction

Function NotifyStrip(DOM_Actor akActor, string type, bool is_success)
	if !slaveDiaryToggle && akActor.mind.is_slave
		return
	endif
	if !slaverDiaryToggle && !(akActor.mind.is_slave)
		return
	endif
	DOM_Mind akMind = akActor.mind
	int the_mood = akMind.GetMoodIndex()
	int the_level = akMind.training_status
	string the_loc = GetLocationName(akActor.akRef)
	float current_time = GetCurrentGameTime()
	string the_place
	if akActor.is_in_city
		the_place = "city"
	elseif akActor.is_in_dungeon
		the_place = "dungeon"
	else
		the_place = "wilderness"
	endif
	;LogTrace("NotifyStrip place="+the_place)
	int idx = akMind.StoreNewMemory(49, current_time, the_loc, type, the_place, the_mood, the_level, akMind.IsRespectfulWritings(), is_success)
	SetTextSlaveStrip(idx, akActor)
	akMind.RegisterNewMemory(idx)
EndFunction

Function NotifyBrand(DOM_Actor akActor, string area)
	if !slaveDiaryToggle && akActor.mind.is_slave
		return
	endif
	if !slaverDiaryToggle && !(akActor.mind.is_slave)
		return
	endif
	DOM_Mind akMind = akActor.mind
	int the_mood = akMind.GetMoodIndex()
	int the_level = akMind.training_status
	string the_loc = GetLocationName(akActor.akRef)
	float current_time = GetCurrentGameTime()
	string the_place
	if akActor.is_in_city
		the_place = "city"
	elseif akActor.is_in_dungeon
		the_place = "dungeon"
	else
		the_place = "wilderness"
	endif
	int idx = akMind.StoreNewMemory(53, current_time, the_loc, area, the_place, the_mood, the_level, akMind.IsRespectfulWritings(), akMind.IsDevoted() || !akMind.is_slave)
	SetTextSlaveBrand(idx, akActor)
	akMind.RegisterNewMemory(idx)
EndFunction

Function NotifyEquipCollar(DOM_Actor akActor)
	if !slaveDiaryToggle && akActor.mind.is_slave
		return
	endif
	if !slaverDiaryToggle && !(akActor.mind.is_slave)
		return
	endif
	if !akActor.has_collar ; not wearing a collar
		return
	endif
	;LogTrace("NotifyEquipCollar "+akActor.GetName())
	DOM_Mind akMind = akActor.mind
	;if akMind.HasMemory(50) ; Wear collar memory already registered
	;	return
	;endif
	;LogTrace("NotifyEquipCollar "+akActor.GetName())
	int the_mood = akMind.GetMoodIndex()
	int the_level = akMind.training_status
	string the_loc = GetLocationName(akActor.akRef)
	float current_time = GetCurrentGameTime()
	int idx = akMind.StoreNewMemory(50, current_time, the_loc, "wear", "a collar", the_mood, the_level, akMind.IsRespectfulWritings(), akMind.IsDevoted() || !akMind.is_slave)
	SetTextSlaveCollar(idx, akActor)
	akMind.RegisterNewMemory(idx)
EndFunction

Function NotifyEquipGag(DOM_Actor akActor)
	if !slaveDiaryToggle && akActor.mind.is_slave
		return
	endif
	if !slaverDiaryToggle && !(akActor.mind.is_slave)
		return
	endif
	if !akActor.has_mouth_gag ; not wearing a gag
		return
	endif
	;LogTrace("NotifyEquipGag "+akActor.GetName())
	DOM_Mind akMind = akActor.mind
	;if akMind.HasMemory(51) ; Wear gag memory already registered
	;	return
	;endif
	int the_mood = akMind.GetMoodIndex()
	int the_level = akMind.training_status
	string the_loc = GetLocationName(akActor.akRef)
	float current_time = GetCurrentGameTime()
	int idx = akMind.StoreNewMemory(51, current_time, the_loc, "wear", "a gag", the_mood, the_level, akMind.IsRespectfulWritings(), akMind.IsDevoted() || !akMind.is_slave)
	SetTextSlaveGag(idx, akActor)
	akMind.RegisterNewMemory(idx)
EndFunction

Function NotifyEquipBlindfold(DOM_Actor akActor)
	if !slaveDiaryToggle && akActor.mind.is_slave
		return
	endif
	if !slaverDiaryToggle && !(akActor.mind.is_slave)
		return
	endif
	if !akActor.has_blindfold ; not wearing a collar
		return
	endif
	;LogTrace("NotifyEquipBlindfold "+akActor.GetName())
	DOM_Mind akMind = akActor.mind
	;if akMind.HasMemory(52) ; Wear blindfold memory already registered
	;	return
	;endif
	int the_mood = akMind.GetMoodIndex()
	int the_level = akMind.training_status
	string the_loc = GetLocationName(akActor.akRef)
	float current_time = GetCurrentGameTime()
	int idx = akMind.StoreNewMemory(52, current_time, the_loc, "wear", "a blindfold", the_mood, the_level, akMind.IsRespectfulWritings(), akMind.IsDevoted() || !akMind.is_slave)
	SetTextSlaveBlindfold(idx, akActor)
	akMind.RegisterNewMemory(idx)
EndFunction

Function NotifyEquipPlugAnal(DOM_Actor akActor)
	if !slaveDiaryToggle && akActor.mind.is_slave
		return
	endif
	if !slaverDiaryToggle && !(akActor.mind.is_slave)
		return
	endif
	if !akActor.has_plug_anal ; not wearing a plug
		return
	endif
	;LogTrace("NotifyEquipPlugAnal "+akActor.GetName())
	DOM_Mind akMind = akActor.mind
	;if akMind.HasMemory(54) ; Wear plug memory already registered
	;	return
	;endif
	int the_mood = akMind.GetMoodIndex()
	int the_level = akMind.training_status
	string the_loc = GetLocationName(akActor.akRef)
	float current_time = GetCurrentGameTime()
	int idx = akMind.StoreNewMemory(54, current_time, the_loc, "plug", "anal", the_mood, the_level, akMind.IsRespectfulWritings(), akMind.IsDevoted() || !akMind.is_slave)
	SetTextSlavePlug(idx, akActor)
	akMind.RegisterNewMemory(idx)
EndFunction

Function NotifyEquipPlugVaginal(DOM_Actor akActor)
	if !slaveDiaryToggle && akActor.mind.is_slave
		return
	endif
	if !slaverDiaryToggle && !(akActor.mind.is_slave)
		return
	endif
	if !akActor.has_plug_vaginal ; not wearing a plug
		return
	endif
	;LogTrace("NotifyEquipPlugVaginal "+akActor.GetName())
	DOM_Mind akMind = akActor.mind
	;if akMind.HasMemory(55) ; Wear plug memory already registered
	;	return
	;endif
	int the_mood = akMind.GetMoodIndex()
	int the_level = akMind.training_status
	string the_loc = GetLocationName(akActor.akRef)
	float current_time = GetCurrentGameTime()
	int idx = akMind.StoreNewMemory(55, current_time, the_loc, "plug", "anal", the_mood, the_level, akMind.IsRespectfulWritings(), akMind.IsDevoted() || !akMind.is_slave)
	SetTextSlavePlug(idx, akActor)
	akMind.RegisterNewMemory(idx)
EndFunction

Function NotifyChangeCombat(DOM_Actor akActor)
	if !slaveDiaryToggle && akActor.mind.is_slave
		return
	endif
	if !slaverDiaryToggle && !(akActor.mind.is_slave)
		return
	endif
	quest_combat_txt = ""
	string reason 
	DOM_Mind akMind = akActor.mind
	int the_mood = akMind.GetMoodIndex()
	int the_level = akMind.training_status
	string the_loc = GetLocationName(akActor.akRef)
	float current_time = GetCurrentGameTime()
	if akMind.should_fight_for_player
		reason = "fight"
	else
		reason = "not fight"
	endif
	int idx = akMind.StoreNewMemory(17, current_time, the_loc, akActor.behaviour, reason, the_mood, the_level, akMind.IsRespectfulWritings(),akMind.IsDevoted() || !akMind.is_slave)
	SetTextSlaveCombat(idx, akActor)
	akMind.RegisterNewMemory(idx)
EndFunction

Function NotifyFriendship(DOM_Actor akActor, DOM_Actor akFriend, DOM_Actor akPrevFriend, DOM_Actor akPrevFriendOfFriend)
	if !slaveDiaryToggle && akActor.mind.is_slave
		return
	endif
	if !slaverDiaryToggle && !(akActor.mind.is_slave)
		return
	endif
	;LogTrace("NotifyFriendship "+akActor.GetName()+" and "+akFriend.GetName())
	int the_mood = akActor.mind.GetMoodIndex()
	int the_level = DOMCore.GetFriendshipType(akActor.akRef,akFriend.akRef)
	string the_loc = GetLocationName(akActor.akRef)
	if the_loc == "" || the_loc == "the wilderness" 
		the_loc = "Skyrim"
	endif
	float current_time = GetCurrentGameTime()
	; Notify actor
	string prev_friend_name
	if akPrevFriend != None
		prev_friend_name = akPrevFriend.GetName()
	endif
	bool is_female1 = (akFriend.actorSex %2) == 1
	int idx1 = akActor.mind.StoreNewMemory(20, current_time, the_loc, akFriend.GetName(), prev_friend_name, the_mood, the_level, akActor.mind.IsRespectfulWritings(), is_female1)
	SetTextSlaveFriendship(idx1, akActor)
	akActor.mind.RegisterNewMemory(idx1)
	; Notify friend
	the_mood = akFriend.mind.GetMoodIndex()
	if akPrevFriendOfFriend != None
		prev_friend_name = akPrevFriendOfFriend.GetName()
	endif
	bool is_female2 = (akActor.actorSex %2) == 1
	the_level = DOMCore.GetFriendshipType(akFriend.akRef,akActor.akRef)
	int idx2 = akFriend.mind.StoreNewMemory(20, current_time, the_loc, akActor.GetName(), prev_friend_name, the_mood, the_level, akFriend.mind.IsRespectfulWritings(), is_female2)
	SetTextSlaveFriendship(idx2, akFriend)
	akFriend.mind.RegisterNewMemory(idx2)
	; Notify previous friend
	if akPrevFriend != None
		;LogTrace("NotifyFriendship previous friend "+akPrevFriend.GetName())
		the_mood = akPrevFriend.mind.GetMoodIndex()
		the_level = DOMCore.GetFriendshipType(akPrevFriend.akRef,akActor.akRef)
		int idx3 = akPrevFriend.mind.StoreNewMemory(21, current_time, the_loc, akActor.GetName(), akFriend.GetName(), the_mood, the_level, akPrevFriend.mind.IsRespectfulWritings(), is_female2)
		SetTextSlaveLostFriendship(idx3, akPrevFriend)
		akPrevFriend.mind.RegisterNewMemory(idx3)
	elseif akPrevFriendOfFriend != None
		;LogTrace("NotifyFriendship previous friend of friend "+akPrevFriendOfFriend.GetName())
		the_mood = akPrevFriendOfFriend.mind.GetMoodIndex()
		the_level = DOMCore.GetFriendshipType(akPrevFriendOfFriend.akRef,akFriend.akRef)
		int idx4 = akPrevFriendOfFriend.mind.StoreNewMemory(21, current_time, the_loc, akFriend.GetName(), akActor.GetName(), the_mood, the_level, akPrevFriendOfFriend.mind.IsRespectfulWritings(), is_female1)
		SetTextSlaveLostFriendship(idx4, akPrevFriendOfFriend)
		akPrevFriendOfFriend.mind.RegisterNewMemory(idx4)
	endif
EndFunction

Function NotifyCapture(DOM_Actor akActor)
	if !slaveDiaryToggle && akActor.mind.is_slave
		return
	endif
	if !slaverDiaryToggle && !(akActor.mind.is_slave)
		return
	endif
	;LogTrace("NotifyCapture "+akActor.GetName())
	float current_time = GetCurrentGameTime()
	if quest_start_time == 0.0 ; first captured
		quest_start_txt = ""
		quest_start_time = current_time
		quest_start_name = akActor.GetName()
		quest_start_loc = GetLocationName(akActor.akRef)
		quest_start_gender = (akActor.actorSex) % 2
		quest_start_actor = akActor.akRef
		quest_start_mood = -1
	else
		quest_last_txt = ""
		quest_last_time = current_time
		quest_last_name = akActor.GetName()
		quest_last_loc = GetLocationName(akActor.akRef)
		quest_last_gender = (akActor.actorSex) % 2
		quest_last_actor = akActor.akRef
		quest_last_mood = -1
	endif

	quest_mood_txt = ""
	quest_behaviour_txt = ""
	quest_total_txt = ""
	quest_origin_txt = ""
	quest_ransom_txt = ""
	int gender = akActor.actorSex
	quest_total_capture += 1
	if gender == 1
		quest_total_female += 1
	elseif gender == 0
		quest_total_male += 1
	endif

	if akActor.mind.memory_capture_ntimes+akActor.mind.memory_capture_rtimes >= 1
		NotifyNewCapture(akActor)
		return
	endif
	
	akActor.mind.memory_capture_time = current_time
	akActor.mind.memory_capture_occupation = GetOccupationOfOriginName(akActor.akRef)
	akActor.mind.memory_capture_location = GetLocationName(akActor.akRef)
	akActor.mind.memory_capture_origin = GetPlaceOfOriginName(akActor.akRef)
	akActor.mind.memory_capture_type = "overwhelmed"
	akActor.mind.memory_capture_txt = ""
	akActor.mind.memory_capture_ntimes = 1
	SetTextSlaveCapture(akActor)
EndFunction

Function NotifyCaptureCircumstances1(DOM_Actor akActor, string last_anim)
	if !slaveDiaryToggle && akActor.mind.is_slave
		return
	endif
	if !(akActor.mind.is_slave)
		return
	endif
	if akActor.mind.memory_capture_ntimes+akActor.mind.memory_capture_rtimes > 1
		return
	endif
	;LogTrace("NotifyCaptureCircumstances1 "+akActor.GetName()+" "+last_anim)
	if last_anim == "BleedOutStart"
		akActor.mind.memory_capture_type = "captured after a tough and unfair combat"
	elseif last_anim == ""
		akActor.mind.memory_capture_type = "taken by surprise"
	endif
EndFunction

Function NotifyCaptureCircumstances2(DOM_Actor akActor, bool is_unaware, bool is_frombehind, int sitState, int sleepState)
	if !slaveDiaryToggle && akActor.mind.is_slave
		return
	endif
	if !(akActor.mind.is_slave)
		return
	endif
	if akActor.mind.memory_capture_ntimes+akActor.mind.memory_capture_rtimes > 1
		return
	endif
	;LogTrace("NotifyCaptureCircumstances2 "+akActor.GetName()+" "+is_unaware+" "+is_frombehind+" "+sitState+" "+sleepState)
	if akActor.mind.memory_capture_type != "" && akActor.mind.memory_capture_type != "overwhelmed"
		return
	endif
	if sleepState > 0 
		akActor.mind.memory_capture_type = "surprised in my sleep"
	elseif sitState > 0 
		akActor.mind.memory_capture_type = "surprised as I was sitting and unable to fight back"
	elseif is_frombehind
		akActor.mind.memory_capture_type = "cowardly attacked from behind"
	elseif is_unaware
		akActor.mind.memory_capture_type = "caught off guard"
	else
		akActor.mind.memory_capture_type = "taken against my will"
	endif
EndFunction

Function NotifyIsCaptured(DOM_Actor akActor)
	if !slaveDiaryToggle && akActor.mind.is_slave
		return
	endif
	if !(akActor.mind.is_slave)
		return
	endif
	if akActor.mind.memory_capture_ntimes+akActor.mind.memory_capture_rtimes > 1
		return
	endif
	;LogTrace("NotifyIsCaptured "+akActor.GetName())
	if !akActor.mind.is_player_actor
		; Get personal Diary
		int idx = DOM02.GetAliasIndex(akActor.akRef)
		if idx >= 0 && idx < diaryArray.length
			DOM_DiaryBook the_diary = diaryArray[idx]
			the_diary.SetAsMyDiary(akActor,akActor.akRef)
		endif
	endif
	DOM_Mind akMind = akActor.mind
	;LogTrace("NotifyIsCaptured idx="+idx)
	int the_mood = akMind.GetMoodIndex()
	akMind.memory_capture_mood = the_mood
	akMind.memory_origin_txt = ""
	akMind.memory_capture_txt = ""
	akMind.memory_capture_occupation = GetOccupationOfOriginName(akActor.akRef)
	akMind.memory_capture_origin = GetPlaceOfOriginName(akActor.akRef)
	akMind.memory_capture_location = GetLocationName(akActor.akRef)
	SetTextSlaveCapture(akActor)
	if quest_start_mood == -1 ; first captured
		quest_start_mood  = the_mood
		quest_start_txt = ""
	else ; last captured
		quest_last_mood  = the_mood
		quest_last_txt = ""
	endif
	quest_mood_txt = ""
	quest_behaviour_txt = ""
	quest_total_txt = ""
	quest_origin_txt = ""
	quest_ransom_txt = ""
EndFunction

Function NotifyIsRecruited(DOM_Actor akActor)
	;LogTrace("NotifyIsRecruited slaverDiaryToggle="+slaverDiaryToggle+" isSlave="+akActor.mind.is_slave+" name="+akActor.GetName())
	if akActor.mind.is_slave
		return
	endif
	if !slaverDiaryToggle && !(akActor.mind.is_slave)
		return
	endif
	if akActor.mind.memory_capture_ntimes+akActor.mind.memory_capture_rtimes > 1
		NotifyNewRecruit(akActor)
		return
	endif
	if !akActor.mind.is_player_actor
		; Get personal Diary
		int idx = DOM01.GetAliasIndex(akActor.akRef)
		if idx >= 0 && idx < diaryXArray.length
			DOM_DiaryBook the_diary = diaryXArray[idx]
			the_diary.SetAsMyDiary(akActor,akActor.akRef)
		endif
	endif
	DOM_Mind akMind = akActor.mind
	int the_mood = akMind.GetMoodIndex()
	akMind.memory_capture_mood = the_mood
	akMind.memory_origin_txt = ""
	akMind.memory_capture_txt = ""
	akMind.memory_capture_occupation = GetOccupationOfOriginName(akActor.akRef)
	akMind.memory_capture_origin = GetPlaceOfOriginName(akActor.akRef)
	akMind.memory_capture_location = GetLocationName(akActor.akRef)
	akMind.memory_capture_type = "recruited"
	akActor.mind.memory_capture_ntimes = 1
	SetTextSlaverRecruit(akActor)
EndFunction

Function NotifyNewCapture(DOM_Actor akActor)
	;LogTrace("NotifyNewCapture slaverDiaryToggle="+slaverDiaryToggle+" isSlave="+akActor.mind.is_slave+" name="+akActor.GetName())
	if !slaverDiaryToggle
		return
	endif

	if !akActor.mind.is_player_actor
		; Get personal Diary
		int idx = DOM02.GetAliasIndex(akActor.akRef)
		if idx >= 0 && idx < diaryArray.length
			DOM_DiaryBook the_diary = diaryArray[idx]
			the_diary.SetAsMyDiary(akActor,akActor.akRef)
		endif
	endif
	DOM_Mind akMind = akActor.mind
	akMind.memory_capture_ntimes += 1
	int the_mood = akMind.GetMoodIndex()
	int the_level = akMind.training_status
	string the_loc = GetLocationName(akActor.akRef)
	float current_time = GetCurrentGameTime()

	int id = akMind.StoreNewMemory(38, current_time, the_loc, "capture", "capture", the_mood, the_level, true, true)
	SetTextSlaveNewCapture(id, akActor)
	akMind.RegisterNewMemory(id)
EndFunction

Function NotifyNewRecruit(DOM_Actor akActor)
	;LogTrace("NotifyNewRecruit slaverDiaryToggle="+slaverDiaryToggle+" isSlave="+akActor.mind.is_slave+" name="+akActor.GetName())
	if !slaverDiaryToggle
		return
	endif
	if !akActor.mind.is_player_actor
		; Get personal Diary
		int idx = DOM01.GetAliasIndex(akActor.akRef)
		if idx >= 0 && idx < diaryXArray.length
			DOM_DiaryBook the_diary = diaryXArray[idx]
			the_diary.SetAsMyDiary(akActor,akActor.akRef)
		endif
	endif
	DOM_Mind akMind = akActor.mind
	akMind.memory_capture_rtimes += 1
	int the_mood = akMind.GetMoodIndex()
	int the_level = akMind.training_status
	string the_loc = GetLocationName(akActor.akRef)
	float current_time = GetCurrentGameTime()

	int id = akMind.StoreNewMemory(39, current_time, the_loc, "recruit", "recruit", the_mood, the_level, true, true)
	SetTextSlaverNewRecruit(id, akActor)
	akMind.RegisterNewMemory(id)
EndFunction

Function NotifyRelease(DOM_Actor akActor)
	if !playerDiaryToggle
		return
	endif
	;LogTrace("NotifyRelease "+akActor.GetName()+" is_freed="+akActor.mind.is_freed_slave)
	DOM_Mind akMind = akActor.mind
	if !akMind.is_freed_slave || !akMind.is_slave
		return ; This is not a freed slave
	endif
	akMind.memory_capture_ftimes += 1
	quest_release_total += 1
	quest_release_txt = ""
	quest_release_time = GetCurrentGameTime()
	quest_release_name = akActor.GetName()
	quest_release_gender = (akActor.actorSex) % 2
	quest_release_actor = akActor.akRef
	quest_release_mood = akActor.mind.GetMoodIndex()
	quest_mood_txt = ""
	quest_behaviour_txt = ""
	quest_total_txt = ""
	quest_origin_txt = ""
	quest_combat_txt = ""
	quest_ransom_txt = ""
EndFunction

Function NotifyReleaseRansom(DOM_Actor akActor)
	if !playerDiaryToggle
		return
	endif
	;LogTrace("NotifyReleaseRansom "+akActor.GetName())
	DOM_Mind akMind = akActor.mind
	akMind.memory_capture_ftimes += 1
	quest_ransom_total += 1
	quest_ransom_txt = ""
	quest_ransom_time = GetCurrentGameTime()
	quest_ransom_name = akActor.GetName()
	quest_ransom_gender = (akActor.actorSex) % 2
	quest_ransom_actor = akActor.akRef
	quest_ransom_mood = akActor.mind.GetMoodIndex()
	quest_mood_txt = ""
	quest_behaviour_txt = ""
	quest_total_txt = ""
	quest_origin_txt = ""
	quest_combat_txt = ""
EndFunction

Function NotifyReleaseSold(DOM_Actor akActor)
	if !playerDiaryToggle
		return
	endif
	;LogTrace("NotifyReleaseSold "+akActor.GetName())
	quest_mood_txt = ""
	quest_behaviour_txt = ""
	quest_total_txt = ""
	quest_origin_txt = ""
	quest_combat_txt = ""
	quest_ransom_txt = ""
EndFunction

Function NotifyReleasetoHSH(DOM_Actor akActor)
	if !playerDiaryToggle
		return
	endif
	;LogTrace("NotifyReleasetoHSH "+akActor.GetName())
	quest_mood_txt = ""
	quest_behaviour_txt = ""
	quest_total_txt = ""
	quest_origin_txt = ""
	quest_combat_txt = ""
	quest_ransom_txt = ""
EndFunction

Function NotifyReleasetoPAH(DOM_Actor akActor)
	if !playerDiaryToggle
		return
	endif
	;LogTrace("NotifyReleasetoPAH "+akActor.GetName())
	quest_mood_txt = ""
	quest_behaviour_txt = ""
	quest_total_txt = ""
	quest_origin_txt = ""
	quest_combat_txt = ""
	quest_ransom_txt = ""
EndFunction
	
Function NotifyEndSex(DOM_Actor akActor, string type, string reason, bool hadOral, bool hadVaginal, bool hadAnal, bool had_orgasm, bool sex_is_non_consensual)
	if !slaveDiaryToggle && akActor.mind.is_slave
		return
	endif
	if !slaverDiaryToggle && !(akActor.mind.is_slave)
		return
	endif
	LogTrace("NotifyEndSex "+akActor.GetName())
	quest_sex_txt = ""
	quest_sex_total += 1
	if hadOral
		quest_sex_oral += 1
	endif	
	if hadVaginal
		quest_sex_vaginal += 1
	endif	
	if hadAnal
		quest_sex_anal += 1
	endif	
	DOM_Mind akMind = akActor.mind
	int the_mood = akMind.GetMoodIndex()
	int the_level = akMind.training_status
	if !akMind.is_player_actor
		quest_sex_name = akActor.GetName()
		quest_sex_gender = (akActor.actorSex) % 2
		quest_sex_actor = akActor.akRef
		quest_sex_mood = the_mood
	endif
	string the_loc = GetLocationName(akActor.akRef)
	if reason == "no reason"
		reason = akMind.whipping_reason_name
	endif
	float current_time = GetCurrentGameTime()
	int idx
	if sex_is_non_consensual
		idx = akMind.StoreNewMemory(11, current_time, the_loc, type, reason, the_mood, the_level, akMind.IsRespectfulWritings(), had_orgasm)
		SetTextSlaveRape(idx, akActor)
	else
		idx = akMind.StoreNewMemory(12, current_time, the_loc, type, reason, the_mood, the_level, akMind.IsRespectfulWritings(), had_orgasm)
		SetTextSlaveSex(idx, akActor)
	endif
	akMind.RegisterNewMemory(idx)
EndFunction

Function NotifyOrgasm(DOM_Actor akActor, string type, bool should_be_noorgasm, bool was_allowed_toorgasm, bool sex_is_non_consensual)
	if !slaveDiaryToggle && akActor.mind.is_slave
		return
	endif
	if !slaverDiaryToggle && !(akActor.mind.is_slave)
		return
	endif
	;LogTrace("NotifyOrgasm "+akActor.GetName())
	DOM_Mind akMind = akActor.mind
	int the_mood = akMind.GetMoodIndex()
	int the_level = akMind.training_status
	string the_loc = GetLocationName(akActor.akRef)
	float current_time = GetCurrentGameTime()
	string reason
	if should_be_noorgasm 
		if was_allowed_toorgasm
			reason = "was allowed to orgasm"
		else
			reason = "was not allowed to orgasm"
		endif
	endif
	int idx = akMind.StoreNewMemory(27, current_time, the_loc, type, reason, the_mood, the_level, akMind.IsRespectfulWritings(), sex_is_non_consensual || !akMind.is_slave)
	SetTextSlaveOrgasm(idx, akActor)
	akMind.RegisterNewMemory(idx)
EndFunction

Function NotifyLostVirginity(DOM_Actor akActor, string type, bool had_orgasm, bool sex_is_non_consensual)
	if !slaveDiaryToggle && akActor.mind.is_slave
		return
	endif
	if !slaverDiaryToggle && !(akActor.mind.is_slave)
		return
	endif
	;LogTrace("NotifyLostVirginity "+akActor.GetName())
	DOM_Mind akMind = akActor.mind
	string the_loc = GetLocationName(akActor.akRef)
	string reason = ""
	if had_orgasm
		reason = "orgasm"
	endif
	int the_mood = akMind.GetMoodIndex()
	int the_level = akMind.training_status
	float current_time = GetCurrentGameTime()
	int idx = akMind.StoreNewMemory(60, current_time, the_loc, type, reason, the_mood, the_level, akMind.IsRespectfulWritings(), sex_is_non_consensual || !akMind.is_slave)
	SetTextSlaveVirginity(idx, akActor)
	akMind.RegisterNewMemory(idx)
EndFunction

Function NotifyEndScold(DOM_Actor akActor, string reason, bool is_success)
	if !slaveDiaryToggle && akActor.mind.is_slave
		return
	endif
	if !slaverDiaryToggle && !(akActor.mind.is_slave)
		return
	endif
	;LogTrace("NotifyEndScold "+akActor.GetName())
	float current_time = GetCurrentGameTime()
	quest_punish_txt     = ""
	quest_punish_time    = current_time
	quest_punish_strokes = 0
	quest_punish_reason  = reason
	quest_punish_type    = "scold"
	quest_punish_name    = akActor.GetName()
	quest_punish_gender  = (akActor.actorSex) % 2
	quest_punish_actor   = akActor.akRef
	DOM_Mind akMind = akActor.mind
	int the_mood = akMind.GetMoodIndex()
	int the_level = akMind.training_status
	quest_punish_mood    = the_mood
	string the_loc = GetLocationName(akActor.akRef)
	
	int idx = akMind.StoreNewMemory(9, current_time, the_loc, "scold", reason, the_mood, the_level, akMind.IsRespectfulWritings(), is_success)
	SetTextSlaveScold(idx, akActor)
	akMind.RegisterNewMemory(idx)
EndFunction

Function NotifyEndPunishment(DOM_Actor akActor, string type, string reason, int strokes)
	if !slaveDiaryToggle && akActor.mind.is_slave
		return
	endif
	if !slaverDiaryToggle && !(akActor.mind.is_slave)
		return
	endif
	;LogTrace("NotifyEndPunishment "+akActor.GetName()+" type="+type+" reason="+reason)
	float current_time = GetCurrentGameTime()
	quest_punish_txt     = ""
	quest_punish_time    = current_time
	quest_punish_strokes = strokes
	quest_punish_reason  = reason
	quest_punish_type    = type
	quest_punish_name    = akActor.GetName()
	quest_punish_gender  = (akActor.actorSex) % 2
	quest_punish_actor   = akActor.akRef
	DOM_Mind akMind = akActor.mind
	int the_mood = akMind.GetMoodIndex()
	int the_level = akMind.training_status
	quest_punish_mood    = the_mood
	
	string the_loc = GetLocationName(akActor.akRef)
	int idx = akMind.StoreNewMemory(1, current_time, the_loc, type, reason, the_mood, the_level, akMind.IsRespectfulWritings(), akMind.IsDevoted() || !akMind.is_slave)
	SetTextSlavePunishment(idx, akActor)
	akMind.RegisterNewMemory(idx)
EndFunction

Function NotifyEndPraise(DOM_Actor akActor, string type, string reason, bool got_angry)
	if !slaveDiaryToggle && akActor.mind.is_slave
		return
	endif
	if !slaverDiaryToggle && !(akActor.mind.is_slave)
		return
	endif
	;LogTrace("NotifyEndPraise "+akActor.GetName())
	float current_time = GetCurrentGameTime()
	quest_praise_txt     = ""
	quest_praise_time    = current_time
	quest_praise_reason  = reason
	quest_praise_type    = type
	quest_praise_name    = akActor.GetName()
	quest_praise_gender  = (akActor.actorSex) % 2
	quest_praise_actor   = akActor.akRef
	DOM_Mind akMind = akActor.mind
	int the_mood = akMind.GetMoodIndex()
	int the_level = akMind.training_status
	quest_praise_mood    = the_mood

	string the_loc = GetLocationName(akActor.akRef)
	int idx = akMind.StoreNewMemory(2, current_time, the_loc, type, reason, the_mood, the_level, akMind.IsRespectfulWritings(), !got_angry || !akMind.is_slave)
	SetTextSlavePraise(idx, akActor)
	akMind.RegisterNewMemory(idx)
EndFunction

Function NotifyEndChat(DOM_Actor akActor, string type, bool is_success)
	if !slaveDiaryToggle && akActor.mind.is_slave
		return
	endif
	if !slaverDiaryToggle && !(akActor.mind.is_slave)
		return
	endif
	;LogTrace("NotifyEndPraise "+akActor.GetName())
	float current_time = GetCurrentGameTime()
	quest_praise_txt     = ""
	quest_praise_time    = current_time
	quest_praise_reason  = "chat"
	quest_praise_type    = type
	quest_praise_name    = akActor.GetName()
	quest_praise_gender  = (akActor.actorSex) % 2
	quest_praise_actor   = akActor.akRef
	DOM_Mind akMind = akActor.mind
	int the_mood = akMind.GetMoodIndex()
	int the_level = akMind.training_status
	quest_praise_mood    = the_mood

	string the_loc = GetLocationName(akActor.akRef)
	int idx = akMind.StoreNewMemory(32, current_time, the_loc, type, "chat", the_mood, the_level, akMind.IsRespectfulWritings(), is_success)
	SetTextSlaveChat(idx, akActor)
	akMind.RegisterNewMemory(idx)
EndFunction

Function NotifyEndInsult(DOM_Actor akActor, string reason, bool is_success)
	if !slaveDiaryToggle && akActor.mind.is_slave
		return
	endif
	if !slaverDiaryToggle && !(akActor.mind.is_slave)
		return
	endif
	;LogTrace("NotifyEndInsult "+akActor.GetName())
	float current_time = GetCurrentGameTime()
	quest_chat_txt     = ""
	quest_chat_time    = current_time
	quest_chat_reason  = reason
	quest_chat_type    = "insulted"
	quest_chat_name    = akActor.GetName()
	quest_chat_gender  = (akActor.actorSex) % 2
	quest_chat_actor   = akActor.akRef
	quest_chat_status  = is_success
	DOM_Mind akMind = akActor.mind
	int the_mood = akMind.GetMoodIndex()
	int the_level = akMind.training_status
	quest_chat_mood    = the_mood

	string the_loc = GetLocationName(akActor.akRef)
	int idx = akMind.StoreNewMemory(3, current_time, the_loc, "insulted", reason, the_mood, the_level, akMind.IsRespectfulWritings(), is_success)
	SetTextSlaveInsult(idx, akActor)
	akMind.RegisterNewMemory(idx)
EndFunction

Function NotifyStartSalute(DOM_Actor akActor, string type, bool is_group_order, bool is_success)
	if !slaveDiaryToggle && akActor.mind.is_slave
		return
	endif
	if !slaverDiaryToggle && !(akActor.mind.is_slave)
		return
	endif
	akActor.is_group_order = false
	;LogTrace("NotifyEndInsult "+akActor.GetName())
	float current_time = GetCurrentGameTime()
	DOM_Mind akMind = akActor.mind
	int the_mood = akMind.GetMoodIndex()
	int the_level = akMind.training_status
	string the_loc = GetLocationName(akActor.akRef)
	string reason
	if is_group_order
		reason = "group"
	else
		reason = ""
	endif
	int idx = akMind.StoreNewMemory(0, current_time, the_loc, type, reason, the_mood, the_level, akMind.IsRespectfulWritings(), is_success)
	SetTextSlaveSalute(idx, akActor)
	akMind.RegisterNewMemory(idx)
EndFunction

Function NotifyEndFlatter(DOM_Actor akActor, string reason, bool is_success)
	if !slaveDiaryToggle && akActor.mind.is_slave
		return
	endif
	if !slaverDiaryToggle && !(akActor.mind.is_slave)
		return
	endif
	;LogTrace("NotifyEndFlatter "+akActor.GetName())
	float current_time = GetCurrentGameTime()
	quest_chat_txt     = ""
	quest_chat_time    = current_time
	quest_chat_reason  = reason
	quest_chat_type    = "flattered"
	quest_chat_name    = akActor.GetName()
	quest_chat_gender  = (akActor.actorSex) % 2
	quest_chat_actor   = akActor.akRef
	quest_chat_status  = is_success
	DOM_Mind akMind = akActor.mind
	int the_mood = akMind.GetMoodIndex()
	int the_level = akMind.training_status
	quest_chat_mood    = the_mood

	string the_loc = GetLocationName(akActor.akRef)
	int idx = akMind.StoreNewMemory(4, current_time, the_loc, "flattered", reason, the_mood, the_level, akMind.IsRespectfulWritings(), is_success)
	SetTextSlaveFlatter(idx, akActor)
	akMind.RegisterNewMemory(idx)
EndFunction

Function NotifyEndComforted(DOM_Actor akActor, string reason, bool is_success)
	if !slaveDiaryToggle && akActor.mind.is_slave
		return
	endif
	if !slaverDiaryToggle && !(akActor.mind.is_slave)
		return
	endif
	;LogTrace("NotifyEndChat "+akActor.GetName())
	float current_time = GetCurrentGameTime()
	quest_chat_txt     = ""
	quest_chat_time    = current_time
	quest_chat_reason  = reason
	quest_chat_type    = "comforted"
	quest_chat_name    = akActor.GetName()
	quest_chat_gender  = (akActor.actorSex) % 2
	quest_chat_actor   = akActor.akRef
	quest_chat_status  = is_success
	DOM_Mind akMind = akActor.mind
	int the_mood = akMind.GetMoodIndex()
	int the_level = akMind.training_status
	quest_chat_mood    = the_mood

	string the_loc = GetLocationName(akActor.akRef)
	int idx = akMind.StoreNewMemory(5, current_time, the_loc, "comforted", reason, the_mood, the_level, akMind.IsRespectfulWritings(), is_success)
	SetTextSlaveComfort(idx, akActor)
	akMind.RegisterNewMemory(idx)
EndFunction

Function NotifyDiscoverKink(DOM_Actor akActor, string kink_name)
	if !slaveDiaryToggle && akActor.mind.is_slave
		return
	endif
	if !slaverDiaryToggle && !(akActor.mind.is_slave)
		return
	endif
	;LogTrace("NotifyDiscoverKink "+akActor.GetName())
	float current_time = GetCurrentGameTime()
	DOM_Mind akMind = akActor.mind
	int the_mood = akMind.GetMoodIndex()
	int the_level = akMind.training_status
	quest_chat_mood    = the_mood

	string the_loc = GetLocationName(akActor.akRef)
	int idx = akMind.StoreNewMemory(41, current_time, the_loc, "discovered kink", kink_name, the_mood, the_level, akMind.IsRespectfulWritings(), akMind.IsDevoted() || !akMind.is_slave)
	SetTextSlaveDiscoverKink(idx, akActor)
	akMind.RegisterNewMemory(idx)
EndFunction

Function NotifyTeasingKink(DOM_Actor akActor, string kink_name)
	if !slaveDiaryToggle && akActor.mind.is_slave
		return
	endif
	if !slaverDiaryToggle && !(akActor.mind.is_slave)
		return
	endif
	;LogTrace("NotifyDiscoverKink "+akActor.GetName())
	float current_time = GetCurrentGameTime()
	DOM_Mind akMind = akActor.mind
	int the_mood = akMind.GetMoodIndex()
	int the_level = akMind.training_status
	quest_chat_mood    = the_mood

	string the_loc = GetLocationName(akActor.akRef)
	int idx = akMind.StoreNewMemory(41, current_time, the_loc, "teasing kink", kink_name, the_mood, the_level, akMind.IsRespectfulWritings(), akMind.IsDevoted() || !akMind.is_slave)
	SetTextSlaveTeasingKink(idx, akActor)
	akMind.RegisterNewMemory(idx)
EndFunction

Function NotifyAcquiredKink(DOM_Actor akActor, string kink_name)
	if !slaveDiaryToggle && akActor.mind.is_slave
		return
	endif
	if !slaverDiaryToggle && !(akActor.mind.is_slave)
		return
	endif
	;LogTrace("NotifyDiscoverKink "+akActor.GetName())
	float current_time = GetCurrentGameTime()
	DOM_Mind akMind = akActor.mind
	int the_mood = akMind.GetMoodIndex()
	int the_level = akMind.training_status
	quest_chat_mood    = the_mood

	string the_loc = GetLocationName(akActor.akRef)
	int idx = akMind.StoreNewMemory(41, current_time, the_loc, "acquired kink", kink_name, the_mood, the_level, akMind.IsRespectfulWritings(), akMind.IsDevoted() || !akMind.is_slave)
	SetTextSlaveAcquiredKink(idx, akActor)
	akMind.RegisterNewMemory(idx)
EndFunction

Function NotifyStartPromise(DOM_Actor akActor, string reason)
	if !slaveDiaryToggle && akActor.mind.is_slave
		return
	endif
	if !slaverDiaryToggle && !(akActor.mind.is_slave)
		return
	endif
	;LogTrace("NotifyEndChat "+akActor.GetName())
	float current_time = GetCurrentGameTime()
	DOM_Mind akMind = akActor.mind
	int the_mood = akMind.GetMoodIndex()
	int the_level = akMind.training_status
	quest_chat_mood    = the_mood

	string the_loc = GetLocationName(akActor.akRef)
	int idx = akMind.StoreNewMemory(6, current_time, the_loc, "promise", reason, the_mood, the_level, akMind.IsRespectfulWritings(), akMind.IsDevoted() || !akMind.is_slave)
	SetTextSlaveGivePromise(idx, akActor)
	akMind.RegisterNewMemory(idx)
EndFunction

Function NotifyKeptPromise(DOM_Actor akActor, string reason)
	if !slaveDiaryToggle && akActor.mind.is_slave
		return
	endif
	if !slaverDiaryToggle && !(akActor.mind.is_slave)
		return
	endif
	;LogTrace("NotifyEndChat "+akActor.GetName())
	float current_time = GetCurrentGameTime()
	DOM_Mind akMind = akActor.mind
	int the_mood = akMind.GetMoodIndex()
	int the_level = akMind.training_status
	quest_chat_mood    = the_mood

	string the_loc = GetLocationName(akActor.akRef)
	int idx = akMind.StoreNewMemory(7, current_time, the_loc, "promise kept", reason, the_mood, the_level, akMind.IsRespectfulWritings(), akMind.IsDevoted() || !akMind.is_slave)
	SetTextSlaveKeptPromise(idx, akActor)
	akMind.RegisterNewMemory(idx)
EndFunction

Function NotifyStartThreat(DOM_Actor akActor, string reason, bool is_success)
	if !slaveDiaryToggle && akActor.mind.is_slave
		return
	endif
	if !slaverDiaryToggle && !(akActor.mind.is_slave)
		return
	endif
	;LogTrace("NotifyEndChat "+akActor.GetName())
	float current_time = GetCurrentGameTime()
	DOM_Mind akMind = akActor.mind
	int the_mood = akMind.GetMoodIndex()
	int the_level = akMind.training_status
	quest_chat_mood    = the_mood

	string the_loc = GetLocationName(akActor.akRef)
	int idx = akMind.StoreNewMemory(8, current_time, the_loc, "threat", reason, the_mood, the_level, akMind.IsRespectfulWritings(), akMind.IsDevoted() || !akMind.is_slave)
	SetTextSlaveThreaten(idx, akActor)
	akMind.RegisterNewMemory(idx)
EndFunction

Function NotifyEndPricing(DOM_Actor akActor, int the_price, bool is_broken)
	if !slaveDiaryToggle && akActor.mind.is_slave
		return
	endif
	if !slaverDiaryToggle && !(akActor.mind.is_slave)
		return
	endif
	;LogTrace("NotifyEndPricing "+akActor.GetName())
	float current_time = GetCurrentGameTime()
	DOM_Mind akMind = akActor.mind
	int the_mood = akMind.GetMoodIndex()
	int the_level = akMind.training_status
	quest_chat_mood    = the_mood

	string the_loc = GetLocationName(akActor.akRef)
	string str_price = the_price
	int idx = akMind.StoreNewMemory(19, current_time, the_loc, "pricing", str_price, the_mood, the_level, akMind.IsRespectfulWritings(), is_broken)
	SetTextSlavePricing(idx, akActor)
	akMind.RegisterNewMemory(idx)
EndFunction

Function NotifyEndCheck(DOM_Actor akActor, string type, string level, bool is_success)
	if !slaveDiaryToggle && akActor.mind.is_slave
		return
	endif
	if !slaverDiaryToggle && !(akActor.mind.is_slave)
		return
	endif
	;LogTrace("NotifyEndCheck "+akActor.GetName())
	float current_time = GetCurrentGameTime()
	DOM_Mind akMind = akActor.mind
	int the_mood = akMind.GetMoodIndex()
	int the_level = akMind.training_status
	quest_chat_mood    = the_mood

	string the_loc = GetLocationName(akActor.akRef)
	int idx = akMind.StoreNewMemory(13, current_time, the_loc, type, level, the_mood, the_level, akMind.IsRespectfulWritings(), is_success)
	SetTextSlaveCheck(idx, akActor)
	akMind.RegisterNewMemory(idx)
EndFunction

Function NotifyEndKiss(DOM_Actor akActor, string type, string level, bool is_success)
	if !slaveDiaryToggle && akActor.mind.is_slave
		return
	endif
	if !slaverDiaryToggle && !(akActor.mind.is_slave)
		return
	endif
	;LogTrace("NotifyEndKiss "+akActor.GetName())
	float current_time = GetCurrentGameTime()
	DOM_Mind akMind = akActor.mind
	int the_mood = akMind.GetMoodIndex()
	int the_level = akMind.training_status
	quest_chat_mood    = the_mood

	string the_loc = GetLocationName(akActor.akRef)
	int idx = akMind.StoreNewMemory(14, current_time, the_loc, type, level, the_mood, the_level, akMind.IsRespectfulWritings(), is_success)
	SetTextSlaveKiss(idx, akActor)
	akMind.RegisterNewMemory(idx)
EndFunction

Function NotifyDrunk(DOM_Actor akActor, string type, int level, bool is_passedout)
	if !slaveDiaryToggle && akActor.mind.is_slave
		return
	endif
	if !slaverDiaryToggle && !(akActor.mind.is_slave)
		return
	endif
	; level = 3 drunk
	; level = 4 smashed
	; level = wasted / almost passed out
	;LogTrace("NotifyDrunk "+akActor.GetName())
	string str_level
	if level == 5
		str_level = "wasted"
	elseif level == 4
		str_level = "smashed"
	else
		str_level = "drunk"
	endif
		
	float current_time = GetCurrentGameTime()
	DOM_Mind akMind = akActor.mind
	int the_mood = akMind.GetMoodIndex()
	int the_level = akMind.training_status
	quest_chat_mood    = the_mood

	string the_loc = GetLocationName(akActor.akRef)
	int idx = akMind.StoreNewMemory(23, current_time, the_loc, type, str_level, the_mood, the_level, akMind.IsRespectfulWritings(), is_passedout)
	SetTextSlaveDrunk(idx, akActor)
	akMind.RegisterNewMemory(idx)
EndFunction

Function NotifySilent(DOM_Actor akActor, string type, string reason, bool is_success)
	if !slaveDiaryToggle && akActor.mind.is_slave
		return
	endif
	if !slaverDiaryToggle && !(akActor.mind.is_slave)
		return
	endif
	float current_time = GetCurrentGameTime()
	DOM_Mind akMind = akActor.mind
	int the_mood = akMind.GetMoodIndex()
	int the_level = akMind.training_status
	quest_chat_mood    = the_mood

	string the_loc = GetLocationName(akActor.akRef)
	int idx = akMind.StoreNewMemory(24, current_time, the_loc, type, reason, the_mood, the_level, akMind.IsRespectfulWritings(), is_success)
	SetTextSlaveSilent(idx, akActor)
	akMind.RegisterNewMemory(idx)
EndFunction

Function NotifyRespect(DOM_Actor akActor, string type, string reason, bool is_success)
	if !slaveDiaryToggle && akActor.mind.is_slave
		return
	endif
	if !slaverDiaryToggle && !(akActor.mind.is_slave)
		return
	endif
	float current_time = GetCurrentGameTime()
	DOM_Mind akMind = akActor.mind
	int the_mood = akMind.GetMoodIndex()
	int the_level = akMind.training_status
	quest_chat_mood    = the_mood

	string the_loc = GetLocationName(akActor.akRef)
	int idx = akMind.StoreNewMemory(25, current_time, the_loc, type, reason, the_mood, the_level, akMind.IsRespectfulWritings(), is_success)
	SetTextSlaveRespect(idx, akActor)
	akMind.RegisterNewMemory(idx)
EndFunction

Function NotifyWalkOnFour(DOM_Actor akActor, string type, string reason, bool is_success)
	if !slaveDiaryToggle && akActor.mind.is_slave
		return
	endif
	if !slaverDiaryToggle && !(akActor.mind.is_slave)
		return
	endif
	float current_time = GetCurrentGameTime()
	DOM_Mind akMind = akActor.mind
	int the_mood = akMind.GetMoodIndex()
	int the_level = akMind.training_status
	quest_chat_mood    = the_mood

	string the_loc = GetLocationName(akActor.akRef)
	int idx = akMind.StoreNewMemory(33, current_time, the_loc, type, reason, the_mood, the_level, akMind.IsRespectfulWritings(), is_success)
	SetTextSlaveWalkOnFour(idx, akActor)
	akMind.RegisterNewMemory(idx)
EndFunction

Function NotifyDrugged(DOM_Actor akActor, string type, string reason, bool is_passedout)
	if !slaveDiaryToggle && akActor.mind.is_slave
		return
	endif
	if !slaverDiaryToggle && !(akActor.mind.is_slave)
		return
	endif
	float current_time = GetCurrentGameTime()
	DOM_Mind akMind = akActor.mind
	int the_mood = akMind.GetMoodIndex()
	int the_level = akMind.training_status
	quest_chat_mood    = the_mood

	string the_loc = GetLocationName(akActor.akRef)
	int idx = akMind.StoreNewMemory(36, current_time, the_loc, type, reason, the_mood, the_level, akMind.IsRespectfulWritings(), is_passedout)
	SetTextSlaveDrugged(idx, akActor)
	akMind.RegisterNewMemory(idx)
EndFunction

Function NotifyAddicted(DOM_Actor akActor, string type, string reason, bool is_passedout)
	if !slaveDiaryToggle && akActor.mind.is_slave
		return
	endif
	if !slaverDiaryToggle && !(akActor.mind.is_slave)
		return
	endif
	float current_time = GetCurrentGameTime()
	DOM_Mind akMind = akActor.mind
	int the_mood = akMind.GetMoodIndex()
	int the_level = akMind.training_status
	quest_chat_mood    = the_mood

	string the_loc = GetLocationName(akActor.akRef)
	int idx = akMind.StoreNewMemory(36, current_time, the_loc, type, reason, the_mood, the_level, akMind.IsRespectfulWritings(), is_passedout)
	SetTextSlaveAddicted(idx, akActor)
	akMind.RegisterNewMemory(idx)
EndFunction

Function NotifyOrgasmControl(DOM_Actor akActor, string type, string reason, bool is_success)
	if !slaveDiaryToggle && akActor.mind.is_slave
		return
	endif
	if !slaverDiaryToggle && !(akActor.mind.is_slave)
		return
	endif
	float current_time = GetCurrentGameTime()
	DOM_Mind akMind = akActor.mind
	int the_mood = akMind.GetMoodIndex()
	int the_level = akMind.training_status
	quest_chat_mood    = the_mood

	string the_loc = GetLocationName(akActor.akRef)
	int idx = akMind.StoreNewMemory(26, current_time, the_loc, type, reason, the_mood, the_level, akMind.IsRespectfulWritings(), is_success)
	SetTextSlaveOrgasmControl(idx, akActor)
	akMind.RegisterNewMemory(idx)
EndFunction

; ===================================================================================
; =                                                                                 =
; = Player's diary                                                                  =
; =                                                                                 =
; ===================================================================================

string Function TextPlayerFirstCapture()
	;LogTrace("TextPlayerFirstCapture txt="+quest_start_txt)
	if quest_start_txt != ""
		return quest_start_txt
	endif
	if quest_start_time == 0.0 ; never captured
		return "I don't have any slave yet. I should probably go hunting."
	endif
	SetTextPlayerFirstCapture()
	return quest_start_txt
EndFunction

Function SetTextPlayerFirstCapture()
	;LogTrace("SetTextPlayerFirstCapture time="+quest_start_time)
	if quest_start_time == 0.0 ; never captured
		quest_start_txt = ""
		return
	endif
	string txt = "My first capture was on "
	string txt_time = GameTimeToString(quest_start_time)+"."
	string txt_slave
	if quest_start_actor != None
		if (quest_start_gender%2) == 1
			txt_slave = " her name was "+quest_start_name+", I found her while I was in "+quest_start_loc
		else
			txt_slave = " his name was "+quest_start_name+", I found him while I was in "+quest_start_loc
		endif
		if quest_start_mood <= 0 && quest_start_mood != 10
			if (quest_start_gender%2) == 1
				txt_slave += ", she was so "+GetMoodStatusName(quest_start_mood)
			else
				txt_slave += ", he was so "+GetMoodStatusName(quest_start_mood)
			endif
		endif
		txt_slave += "."
	endif
	quest_start_txt = txt+txt_time+txt_slave
EndFunction

string Function TextPlayerLastCapture()
	;LogTrace("TextPlayerLastCapture txt="+quest_last_txt)
	if quest_last_txt != ""
		return quest_last_txt
	endif
	if quest_last_time == 0.0 ; no last capture
		if quest_start_time != 0.0
			return "That was fun, let's try it again."
		endif
		return ""
	endif
	SetTextPlayerLastCapture()
	return quest_last_txt
EndFunction

Function SetTextPlayerLastCapture()
	;LogTrace("SetTextPlayerLastCapture time="+quest_last_time)
	if quest_last_time == 0.0
		quest_last_txt = ""
		return
	endif
	string txt = "My Last capture was "+GetElapsedTimeString(quest_last_time)+"."
	string txt_slave = ""
	if quest_last_actor != None
		if (quest_start_gender%2) == 1
			txt_slave = " her name was "+quest_last_name+", I found her in "+quest_start_loc
		else
			txt_slave = " his name was "+quest_last_name+", I found him in "+quest_start_loc
		endif
		if quest_last_mood <= 0 && quest_last_mood != 10
			if (quest_start_gender%2) == 1
				txt_slave += " she was so "+GetMoodStatusName(quest_last_mood)
			else
				txt_slave += " she was so "+GetMoodStatusName(quest_last_mood)
			endif
		endif
		txt_slave += "."
	endif
	quest_last_txt = txt+txt_slave
EndFunction

string Function TextPlayerTotalCapture()
	;LogTrace("TextPlayerTotalCapture txt="+quest_total_txt)
	if quest_total_txt != ""
		return quest_total_txt
	endif
	SetTextPlayerTotalCapture()
	return quest_total_txt
EndFunction

Function SetTextPlayerTotalCapture()
	;LogTrace("SetTextPlayerTotalCapture time="+quest_start_time)
	if quest_start_time == 0.0 ; never captured
		quest_total_txt = ""
		return
	endif
	string txt
	int nslaves = DOM02.GetActorCount()
	if nslaves == 0
		txt = "It seems like I got rid of all my slaves"
	elseif nslaves == 1
		txt = "I have one slave."
		if quest_last_gender == 1
			txt += " Her name is "+quest_last_name+"."
		elseif quest_last_gender == 0
			txt += " His name is "+quest_last_name+"."
		endif
		txt += " It's a good start."	
	else
		txt = "I am the proud owner of "+nslaves+" slaves."
	endif
	if quest_total_capture > 1
		txt += " I captured a total of "+quest_total_capture+" slaves."
	endif
	if quest_total_capture >= 6
		if quest_total_male == 0
			txt += " All females, it seems I have a soft spot for them."
		elseif quest_total_female == 0
			txt += " All males, ot seems I have a soft spot for them."
		elseif quest_total_female == 1
			txt += " One female and "+quest_total_male+" males."
		elseif quest_total_male == 1
			txt += " "+quest_total_female+" females and one male."
		else
			txt += " "+quest_total_female+" females and "+quest_total_male+" males."
		endif
	elseif quest_total_capture >= 3
		if quest_total_female == nslaves
			txt += " All females."
		elseif quest_total_male == nslaves
			txt += " All males."
		endif
	endif
	quest_total_txt = txt
EndFunction

string Function TextSlavesTrainingLevel()
	if quest_training_txt != ""
		return quest_training_txt
	endif
	SetTextPlayerTrainingLevel()
	return quest_training_txt
EndFunction

Function SetTextPlayerTrainingLevel()
	int nslaves = DOM02.GetActorCount()
	if nslaves == 0
		quest_training_txt = "Here I will write a short status of my progression"
		return
	endif
	int idx = 0
	int[] nStatus = new int[28]
	bool is_mult = false
	bool is_fresh = true
	bool is_trained = true
	bool is_ready = true
	string sname
	int prevStatus = -1
	while idx < nslaves
		DOM_Actor akSlave = DOM02.GetActorByIndex(idx)
		if akSlave != None
			int iStatus = akSlave.mind.training_status
			nStatus[iStatus] = nStatus[iStatus]+1
			if prevStatus < 0
				prevStatus = iStatus
				sname = akSlave.GetName()
			elseif prevStatus != iStatus
				is_mult = true
			endif
			if iStatus > 1
				is_fresh = false
			endif
			if iStatus < 20
				is_trained = false
				is_ready = false
			elseif iStatus < 27
				is_ready = false
			endif
		endif
		idx += 1
	endwhile
	string txt
	if !is_mult
		idx = 0
		while idx < nStatus.length
			if nStatus[idx] > 0
				if nslaves == 1
					txt = "I have one "+GetTrainingStatusName(idx)+" slave, "+sname+"."
				else
					txt = "I have "+nslaves+" "+GetTrainingStatusName(idx)+" slaves."
				endif
				if idx >= 27
					txt += " It can not get better than that!"
				elseif idx >= 20 
					txt += " A bit more effort and they will all be enraptured."
				elseif idx <= 1
					txt += " I still have a lot of training to do."
				else
					txt += " It's coming into shape."
				endif
				quest_training_txt = txt
				return
			endif
			idx += 1
		endwhile
	endif
	idx = 0
	bool is_first = true
	while idx < nStatus.length
		int ns = nStatus[idx]
		;LogTrace("TextSlavesTrainingLevel "+idx+" / "+nStatus.length+" = "+ns)
		if  ns > 0
			if is_first
				txt = "I have"
				is_first = false
			else
				txt += ","
			endif
			if ns == 1
				txt += " one "+GetTrainingStatusName(idx)
			else
				txt += " "+ns+" "+GetTrainingStatusName(idx)
			endif
		endif
		idx += 1
	endwhile	
	txt += " slaves."
	if is_ready
		txt += " It can not get better than that!"
	elseif is_trained
		txt += " A bit more training and they will all be enraptured."
	elseif is_fresh
		txt += " I still have a lot of training to do."
	else
		txt += " It's coming into shape."
	endif
	quest_training_txt = txt
EndFunction

string Function TextSlavesBehaviour()
	;LogTrace("TextSlavesBehaviour txt="+quest_behaviour_txt)
	if quest_behaviour_txt != ""
		return quest_behaviour_txt
	endif
	SetTextSlavesBehaviour()
	return quest_behaviour_txt
EndFunction

Function SetTextSlavesBehaviour()
	int nslaves = DOM02.GetActorCount()
	if nslaves == 0
		quest_behaviour_txt = "Here I will write what I do with my stock."
		return
	endif
	int idx = 0
	int[] nStatus = new int[39]
	bool is_mult = false
	int prevStatus = -1
	string sname
	while idx < nslaves
		DOM_Actor akSlave = DOM02.GetActorByIndex(idx)
		if akSlave != None
			int iStatus = akSlave.GetBehaviourIndex()
			nStatus[iStatus] = nStatus[iStatus]+1
			if prevStatus < 0
				prevStatus = iStatus
				sname = akSlave.GetName()
			elseif prevStatus != iStatus
				is_mult = true
			endif
		endif
		idx += 1
	endwhile
	string txt
	if !is_mult
		idx = 0
		while idx < nStatus.length
			if nStatus[idx] > 0
				if nslaves == 1
					txt = "I have one slave "+GetBehaviourStatusName(idx)+", "+sname+"."
				else
					txt = "I have "+nslaves+" slaves "+GetBehaviourStatusName(idx)+"."
				endif
				quest_behaviour_txt = txt
				return
			endif
			idx += 1
		endwhile
	endif
	idx = 0
	bool is_first = true
	while idx < nStatus.length
		int ns = nStatus[idx]
		if  ns > 0
			if is_first
				txt = "I have"
				is_first = false
			else
				txt += ","
			endif
			if ns == 1
				txt += " one "
				txt += GetBehaviourStatusName(idx)
			else
				txt += " "+ns+" "
				txt += GetBehaviourStatusName(idx)
			endif
		endif
		idx += 1
	endwhile	
	txt += " slaves."
	quest_behaviour_txt = txt
EndFunction

string Function TextSlavesMood()
	;LogTrace("TextSlavesMood txt="+quest_mood_txt)
	if quest_mood_txt != ""
		return quest_mood_txt
	endif
	SetTextSlavesMood()
	return quest_mood_txt
EndFunction

Function SetTextSlavesMood()
	int nslaves = DOM02.GetActorCount()
	if nslaves == 0
		quest_mood_txt = "Here I will write how my slaves are doing."
		return
	endif
	int idx = 0
	int[] nStatus = new int[32]
	bool is_mult = false
	int prevStatus = -1
	string sname
	while idx < nslaves
		DOM_Actor akSlave = DOM02.GetActorByIndex(idx)
		if akSlave != None
			int iStatus = akSlave.mind.GetMoodIndex()
			if iStatus >= 0
				nStatus[iStatus] = nStatus[iStatus]+1
				if prevStatus < 0
					prevStatus = iStatus
					sname = akSlave.GetName()
				elseif prevStatus != iStatus
					is_mult = true
				endif
			endif
		endif
		idx += 1
	endwhile
	string txt
	if !is_mult
		idx = 0
		while idx < nStatus.length
			if nStatus[idx] > 0
				if nslaves == 1
					txt = "I have one slave "+GetMoodStatusName(idx)+", "+sname+"."
				else
					txt = "I have "+nslaves+" slaves "+GetMoodStatusName(idx)+"."
				endif
				quest_mood_txt = txt
				return
			endif
			idx += 1
		endwhile
	endif
	idx = 0
	bool is_first = true
	while idx < nStatus.length
		int ns = nStatus[idx]
		if  ns > 0
			if is_first
				txt = "I have"
				is_first = false
			else
				txt += ","
			endif
			if ns == 1
				txt += " one "
				txt += GetMoodStatusName(idx)
			else
				txt += " "+ns+" "
				txt += GetMoodStatusName(idx)
			endif
		endif
		idx += 1
	endwhile	
	txt += " slaves."
	quest_mood_txt = txt
EndFunction

string Function TextSlavesValue()
	;LogTrace("TextSlavesValue txt="+quest_mood_txt)
	if quest_value_txt != ""
		return quest_value_txt
	endif
	SetTextSlavesValue()
	return quest_value_txt
EndFunction

Function SetTextSlavesValue()
	int nslaves = DOM02.GetActorCount()
	if nslaves == 0
		quest_value_txt = "Here I will write the value of my stock."
		return
	endif
	int idx = 0
	int best_value = 0
	int best_sex = 0
	string best_name
	int best2_value = 0
	int best2_sex = 0
	string best2_name
	int best3_value = 0
	string best3_name
	int best4_value = 0
	string best4_name
	int total_value = 0
	while idx < nslaves
		DOM_Actor akSlave = DOM02.GetActorByIndex(idx)
		if akSlave != None
			int value = DOMGenerator.GetActorPrice(akSlave.akRef)
			total_value += value
			if value > best_value
				if best_value > 0
					if best2_value > 0
						if best3_value > 0
							best4_value = best3_value
							best4_name = best3_name
						endif
						best3_value = best2_value
						best3_name = best2_name
					endif
					best2_value = best_value
					best2_sex = best_sex
					best2_name = best_name
				endif
				best_value = value
				best_sex = akSlave.actorSex % 2
				best_name = akSlave.GetName()
			elseif value > best2_value
				if best2_value > 0
					if best3_value > 0
						best4_value = best3_value
						best4_name = best3_name
					endif
					best3_value = best2_value
					best3_name = best2_name
				endif
				best2_value = value
				best2_sex = akSlave.actorSex % 2
				best2_name = akSlave.GetName()
			elseif value > best3_value
				if best3_value > 0
					best4_value = best3_value
					best4_name = best3_name
				endif
				best3_value = value
				best3_name = akSlave.GetName()
			elseif value > best4_value
				best4_value = value
				best4_name = akSlave.GetName()
			endif
		endif
		idx += 1
	endwhile
	string txt
	if nslaves == 1
		quest_value_txt = "The value of my slave "+best_name+" is "+best_value+" gold."
		return
	endif
	if best_sex == 1
		txt = "My best slave is "+best_name+", she is worth "+best_value+" gold."
	else
		txt = "My best slave is "+best_name+", he is worth "+best_value+" gold."
	endif
	if best2_sex == 1
		txt += " Next to best is "+best2_name+" and she is worth "+best2_value+" gold."
	else
		txt += " Next to best is "+best2_name+" and he is worth "+best2_value+" gold."
	endif
	if best3_value > 0
		txt += " Also worth mentionning is "+best3_name+" with a value of "+best3_value+" gold"
	endif
	if best4_value > 0
		txt += " and "+best4_name+" which is worth "+best4_value+" gold."
	else
		txt += "."
	endif
	txt += " For my "+nslaves+" slaves, I could get "+total_value+" gold."
	quest_value_txt = txt
	return
EndFunction

string Function TextSlavesLocation()
	if quest_location_txt != ""
		return quest_location_txt
	endif
	SetTextSlavesLocation()
	return quest_location_txt
EndFunction

Function SetTextSlavesLocation()
	int nslaves = DOM02.GetActorCount()
	if nslaves == 0
		quest_location_txt = "Here I will write where my slaves are stored."
		return
	endif
	int idx = 0
	int icur = -1
	string[] myLocs = new String[12]
	int[] nLocs = new Int[12]
	int imax = myLocs.length ; Should be same number for both arrays above
	while idx < nslaves
		DOM_Actor akSlave = DOM02.GetActorByIndex(idx)
		if akSlave != None
			string nameLoc = GetLocationName(akSlave.akRef)
			int iloc = myLocs.find(nameLoc)
			if iloc >= 0
				nLocs[iloc] = nLocs[iloc]+1
			elseif icur < imax-(1)
				icur += 1
				myLocs[icur] = nameLoc
				nLocs[icur] = 1
			endif
			;LogTrace(" current loc="+nameLoc)
		endif
		idx += 1
	endwhile
	idx = 0
	string txt
	while idx <= icur
		if idx == 0
			if nLocs[idx] == 1
				txt += "I have one slave in "+myLocs[idx]
			else
				txt += "I have "+nLocs[idx]+" slaves in "+myLocs[idx]
			endif
		elseif idx == icur
			if nLocs[idx] == 1
				txt += " and one in "+myLocs[idx]
			else
				txt += " and "+nLocs[idx]+" in "+myLocs[idx]
			endif
		else
			if nLocs[idx] == 1
				txt += ", one in "+myLocs[idx]
			else
				txt += ", "+nLocs[idx]+" in "+myLocs[idx]
			endif
		endif
		idx += 1
	endwhile
	txt += "."
	quest_location_txt = txt
	return
EndFunction

string Function TextSlavesOrigin()
	;LogTrace("TextSlavesOrigin txt="+quest_origin_txt)
	if quest_origin_txt != ""
		return quest_origin_txt
	endif
	SetTextSlavesOrigin()
	;LogTrace("TextSlavesOrigin reset txt="+quest_last_txt)
	return quest_origin_txt
EndFunction

Function SetTextSlavesOrigin()
	int nslaves = DOM02.GetActorCount()
	if nslaves == 0 || quest_start_time == 0.0
		quest_origin_txt = "Here I will write where I hunt my future slaves."
		return 
	endif
	int idx = 0
	int icur = -1
	string[] myLocs = new String[12]
	int[] nLocs = new Int[12]
	int imax = myLocs.length ; Should be same number for both arrays above
	while idx < nslaves
		DOM_Actor akSlave = DOM02.GetActorByIndex(idx)
		if akSlave != None
			;string nameLoc = akSlave.mind.memory_capture_origin
			string nameLoc = akSlave.mind.memory_capture_location
			int iloc = myLocs.find(nameLoc)
			if iloc >= 0
				nLocs[iloc] = nLocs[iloc]+1
			elseif icur < imax-(1)
				icur += 1
				myLocs[icur] = nameLoc
				nLocs[icur] = 1
			endif
		endif
		idx += 1
	endwhile
	idx = 0
	string txt
	while idx <= icur
		if idx == 0
			if nLocs[idx] == 1
				txt += "I have one slave from "+myLocs[idx]
			else
				txt += "I have "+nLocs[idx]+" slaves from "+myLocs[idx]
			endif
		elseif idx == icur
			if nLocs[idx] == 1
				txt += " and one from "+myLocs[idx]
			else
				txt += " and "+nLocs[idx]+" from "+myLocs[idx]
			endif
		else
			if nLocs[idx] == 1
				txt += ", one from "+myLocs[idx]
			else
				txt += ", "+nLocs[idx]+" from "+myLocs[idx]
			endif
		endif
		idx += 1
	endwhile
	txt += "."
	quest_origin_txt = txt
EndFunction

string Function TextSlavesMaid()
	;int nslaves = DOM02.GetActorCount()
	;if nslaves == 0
	;	return "Here I will write about my maids and servants."
	;endif
	return "Here I will write about my maids, servants and workers."
EndFunction

string Function TextSlavesCombat()
	;LogTrace("TextSlavesCombat txt="+quest_combat_txt)
	if quest_combat_txt != ""
		return quest_combat_txt
	endif
	if quest_start_time == 0.0; no last capture
		return "Here I will write about my fighting slaves."
	endif
	SetTextSlavesCombat()
	;LogTrace("TextSlavesCombat reset txt="+quest_combat_txt)
	return quest_combat_txt
EndFunction

Function SetTextSlavesCombat()
	int nslaves = DOM02.GetActorCount()
	if nslaves == 0
		return
	endif
	int idx = 0
	int nfollow = 0
	int nstand = 0
	DOM_Actor akSoloFollow = None
	DOM_Actor akSoloStand = None
	while idx < nslaves
		DOM_Actor akSlave = DOM02.GetActorByIndex(idx)
		if akSlave != None
			bool is_fighting = akSlave.mind.should_fight_for_player
			if is_fighting
				string behaviour = akSlave.behaviour
				if behaviour == "follow_player"
					akSoloFollow = akSlave
					nfollow += 1
				else
					akSoloStand = akSlave
					nstand += 1
				endif
			endif
		endif
		idx += 1
	endwhile
	if nfollow == 1 && nstand == 0
		quest_combat_txt = akSoloFollow.GetName()+" is my bodyguard."
		return
	endif
	if nfollow == 0 && nstand == 1
		quest_combat_txt = akSoloStand.GetName()+" should fight for me, but is not following me for the moment."
		return
	endif
	if nfollow == 1 && nstand == 1
		quest_combat_txt = akSoloFollow.GetName()+" is my bodyguard. "+akSoloStand.GetName()+" should also fight for me, but is not following me for the moment."
		return
	endif
	string txt
	if nfollow == 1
		txt = akSoloFollow.GetName()+" is my bodyguard."
	elseif nfollow > 0
		txt = "I have "+nfollow+" bodyguards."
	endif
	if nstand == 1
		txt += akSoloStand.GetName()+" should fight for me, but is not following me for the moment."
	elseif nstand > 0
		txt += "I have "+nstand+" combat slaves, not following me for the moment."
	endif
	if txt == ""
		txt = "Here I will write about my fighting slaves."
	endif
	quest_combat_txt = txt
EndFunction

string Function TextSlavesHome()
	;int nslavers = DOM01.GetActorCount()
	;if nslavers == 0
	;	return "Here I will write about my home sweet home."
	;endif
	return "Here I will write about my home sweet home."
EndFunction

string Function TextSlavesSlavers()
	;int nslavers = DOM01.GetActorCount()
	;if nslavers == 0
	;	return "Here I will write about my slavers."
	;endif
	return "Here I will write about my slavers."
EndFunction

string Function TextSlavesSexualAbuse()
	;LogTrace("TextSlavesSexualAbuse txt="+quest_sex_txt)
	if quest_sex_txt != ""
		return quest_sex_txt
	endif
	if quest_sex_total == 0.0; no sexing yet
		return "Here I will write about my sexual achievements."
	endif
	SetTextSlavesSexualAbuse()
	return quest_sex_txt
EndFunction

Function SetTextSlavesSexualAbuse()
	if quest_sex_total == 0
		return
	endif
	; Quick and dirty temporary fix
	if quest_sex_mood <= 0 && quest_sex_actor != None
		DOM_Actor akActor = DOMCore.GetSlave(quest_sex_actor)
		if akActor != None
			quest_sex_mood = akActor.mind.GetMoodIndex()
		endif
	endif
	; Start of text
	string txt
	if quest_sex_total == 1
		txt = "I had sex with my slave "+quest_sex_name+" once"
		if quest_sex_oral == 1
			if quest_sex_gender == 1
				txt += ", with her mouth"
			else
				txt += ", with his mouth"
			endif
		endif
		if quest_sex_vaginal == 1 && quest_sex_gender == 1
			if quest_sex_gender == 1 && (quest_sex_oral == 0 || quest_sex_anal == 1)
				txt += ", in her pussy"
			else
				txt += " and in her pussy"
			endif
		endif
		if quest_sex_anal == 1
			if (quest_sex_oral == 1 || quest_sex_anal == 1)
				if quest_sex_gender == 1
					txt += " and in her ass"
				else
					txt += " and in his ass"
				endif
			else
				if quest_sex_gender == 1
					txt += ", in her ass"
				else
					txt += ", in his ass"
				endif
			endif
		endif
		if quest_sex_mood > 0 && quest_sex_mood != 10
			if quest_sex_gender == 1
				txt += ", she was so "+GetMoodStatusName(quest_sex_mood)
			else
				txt += ", he was so "+GetMoodStatusName(quest_sex_mood)
			endif
		endif
		txt += "."
	else
		if quest_total_capture == 1
			txt = "I had sex with my slave "+quest_sex_name+" "+quest_sex_total+" times"
			if quest_sex_mood > 0 && quest_sex_mood != 10
				if quest_sex_gender == 1
					txt += ", she was so "+GetMoodStatusName(quest_sex_mood)+"."
				else
					txt += ", he was so "+GetMoodStatusName(quest_sex_mood)+"."
				endif
			endif
		else
			txt = "I had sex with my slaves "+quest_sex_total+" times."
		endif
		if quest_sex_oral == 1
			txt += " Once in the mouth."
		elseif quest_sex_oral > 1
			txt += " "+quest_sex_oral+" times in the mouth."
		endif
		if quest_sex_vaginal == 1
			txt += " Once in the pussy."
		elseif quest_sex_vaginal > 1
			txt += " "+quest_sex_vaginal+" times in the pussy."
		endif
		if quest_sex_anal == 1
			txt += " Once in the ass."
		elseif quest_sex_anal > 1
			txt += " "+quest_sex_anal+" times in the ass."
		endif	
	endif
	if quest_sex_total > 1 && quest_total_capture > 1
		txt += " Last one to get raped was "+quest_sex_name
		if quest_sex_mood > 0 && quest_sex_mood != 10
			if quest_sex_gender == 1
				txt += ", she was so "+GetMoodStatusName(quest_sex_mood)+"."
			else
				txt += ", he was so "+GetMoodStatusName(quest_sex_mood)+"."
			endif
		endif
	endif
	quest_sex_txt = txt
EndFunction

string Function TextSlavesPunishment()
	;LogTrace("TextSlavesPunishment txt="+quest_punish_txt)
	if quest_punish_txt != ""
		return quest_punish_txt
	endif
	if quest_punish_time == 0.0 ; no last punishment
		if quest_start_time != 0.0
			int nslaves = DOM02.GetActorCount()
			if nslaves == 1
				return "I guess some kind of punishment is in order. So now, what could be the reason?"
			elseif nslaves > 1
				return "I guess some kind of punishment is in order. If I don't find a good reason, they will."
			endif
		endif
	endif
	SetTextSlavesPunishment()
	return quest_punish_txt
EndFunction

Function SetTextSlavesPunishment()
	if quest_punish_time == 0.0 ; no last punishment
		return
	endif
	
	string txt = "Last punishment was for "+quest_punish_name+" "+GetElapsedTimeString(quest_punish_time)+"."
	string txt_slave = ""
	if quest_punish_actor != None
		if quest_punish_strokes > 1
			txt_slave = " "+quest_punish_name+" was punished with "+quest_punish_strokes+" strokes for "+quest_punish_reason
		else
			string type_desc = DOMCore.GetJSONPunishmentTypeDescriptionByName(quest_punish_type)
			txt_slave = " "+quest_punish_name+" was punished "+type_desc+" for "+quest_punish_reason
		endif
		if quest_punish_mood > 0 && quest_punish_mood != 10
			if quest_punish_gender == 1
				txt_slave += ", she was so "+GetMoodStatusName(quest_punish_mood)
			else
				txt_slave += ", he was so "+GetMoodStatusName(quest_punish_mood)
			endif
		endif
		txt_slave += "."
	endif
	quest_punish_txt = txt+txt_slave
EndFunction

string Function TextSlavesPraise()
	;LogTrace("TextSlavesPraise txt="+quest_praise_txt)
	if quest_praise_txt != ""
		return quest_praise_txt
	endif
	if quest_praise_time == 0.0 ; no last praise
		if quest_start_time != 0.0
			int nslaves = DOM02.GetActorCount()
			if nslaves == 1
				return "I guess I could just be nice for once. Oh, who am I kidding?!"
			elseif nslaves > 1
				return "I guess I could also be nice to them. Oh, who am I kidding?!"
			endif
		endif
	endif
	SetTextSlavesPraise()
	return quest_praise_txt
EndFunction

Function SetTextSlavesPraise()
	if quest_praise_time == 0.0 ; no last praise
		return
	endif
	
	string txt = "I tried to be nice to "+quest_praise_name+" "+GetElapsedTimeString(quest_praise_time)+"."
	string txt_slave = ""
	if quest_praise_actor != None
		string type_desc = DOMCore.GetJSONPraisingTypeDescriptionByName(quest_praise_type)
		txt_slave = quest_praise_name+" was "+type_desc+" for "+quest_praise_reason
		if quest_praise_mood > 0 && quest_praise_mood != 10
			if quest_praise_gender == 1
				txt_slave += ", she was so "+GetMoodStatusName(quest_praise_mood)
			else
				txt_slave += ", he was so "+GetMoodStatusName(quest_praise_mood)
			endif
		endif
		txt_slave += "."
	endif
	quest_praise_txt = txt+" "+txt_slave
EndFunction

string Function TextSlavesChat()
	;LogTrace("TextSlavesChat txt="+quest_chat_txt)
	if quest_chat_txt != ""
		return quest_chat_txt
	endif
	if quest_chat_time == 0.0 ; no last chat
		if quest_start_time != 0.0
			return "They say chatting with your slave is important too."
		endif
		return ""
	endif
	SetTextSlavesChat()
	return quest_chat_txt
EndFunction

Function SetTextSlavesChat()
	if quest_chat_time == 0.0 ; no last flatter
		return
	endif
	
	string txt = "I "+quest_chat_reason+" "+quest_chat_name+" "+GetElapsedTimeString(quest_chat_time)+"."
	string txt_slave = ""
	if quest_chat_actor != None
		txt_slave = quest_chat_name+" was "+quest_chat_reason+" and told "+quest_chat_type
		if quest_chat_mood > 0 && quest_chat_mood != 10
			if quest_chat_gender == 1
				txt_slave += ", she was so "+GetMoodStatusName(quest_chat_mood)
			else
				txt_slave += ", he was so "+GetMoodStatusName(quest_chat_mood)
			endif
		endif
		if quest_chat_status
			txt_slave += " and seemed to be receptive."
		else
			txt_slave += " but didn't seem to be receptive."
		endif
	endif
	quest_chat_txt = txt+txt_slave
EndFunction

string Function TextSlavesRelease()
	;LogTrace("TextSlavesRelease txt="+quest_release_txt)
	if quest_release_txt != ""
		return quest_release_txt
	endif
	if quest_start_time == 0.0
		return "They say chatting with your slave is important too."
	endif
	SetTextSlavesRelease()
	return quest_release_txt
EndFunction

Function SetTextSlavesRelease()
	if quest_release_time == 0.0 ; no release
		if quest_start_time == 0.0
			return
		endif
		int nslaves = DOM02.GetActorCount()
		if nslaves == 1
			if quest_start_gender == 1
				quest_release_txt = "I have captured only one slave, "+quest_start_name+" and I am not planning on freeing her."
				return
			else
				quest_release_txt = "I have captured only one slave, "+quest_start_name+" and I am not planning on freeing "+DOMPlayerAlias.GetPlayerObjective()+"."
				return
			endif
		elseif nslaves > 1
			quest_release_txt = "I have never freed a slave."
			return
		endif
		return
	endif
	
	string txt
	if quest_release_total == 1
		txt = "I was nice to "+quest_release_name
		if (quest_release_gender%2) == 1
			txt += " and I chose to free her. She was so "+GetMoodStatusName(quest_release_mood)+"."
		else
			txt += " and I chose to free him. He was so "+GetMoodStatusName(quest_release_mood)+"."
		endif
		txt += " I still wonder if that was the right thing to do."
	elseif quest_release_total >  0
		txt = "I decided to free "+quest_release_total+" slaves."
		txt += " Last one to be freed was "+quest_release_name
		if (quest_release_gender%2) == 1
			txt += ", she was so "+GetMoodStatusName(quest_release_mood)+"."
		else
			txt += ", he was so "+GetMoodStatusName(quest_release_mood)+"."
		endif
		txt += " I still wonder if that was the right thing to do."
	endif
	quest_release_txt = txt
EndFunction

string Function TextSlavesRansom()
	;LogTrace("TextSlavesRansom txt="+quest_ransom_txt)
	if quest_ransom_txt != ""
		return quest_ransom_txt
	endif
	if quest_ransom_time == 0.0 ; no last ransom
		if quest_start_time != 0.0
			return "Here I will write about the slaves I have ransomed."
		endif
		return ""
	endif
	SetTextSlavesRansom()
	return quest_ransom_txt
EndFunction

Function SetTextSlavesRansom()
	if quest_start_time == 0.0
		return
	endif
	
	string txt
	if quest_ransom_total == 1
		txt = "I was nice to "+quest_ransom_name
		if (quest_ransom_gender%2) == 1
			txt += " and I chose to ransom her. She was so "+GetMoodStatusName(quest_ransom_mood)+"."
		else
			txt += " and I chose to ransom him. He was so "+GetMoodStatusName(quest_ransom_mood)+"."
		endif
		txt += " I still wonder if that was the right thing to do."
	elseif quest_ransom_total >  0
		txt = "I decided to ransom "+quest_ransom_total+" slaves."
		txt += " Last one to be ransomed was "+quest_ransom_name
		if (quest_ransom_gender%2) == 1
			txt += ", she was so "+GetMoodStatusName(quest_ransom_mood)+"."
		else
			txt += ", he was so "+GetMoodStatusName(quest_ransom_mood)+"."
		endif
		txt += " That was easy earned money."
	endif

	if txt == ""
		if quest_ransom_time == 0.0 ; no release for ransom
			int nslaves = DOM02.GetActorCount()
			if nslaves == 1
				if (quest_start_gender%2) == 1
					txt = "I have captured only one slave, "+quest_start_name+" and I am not done with her."
				else
					txt = "I have captured only one slave, "+quest_start_name+" and I am not done with him."
				endif
			elseif nslaves > 1
				txt = "I kept all the slaves I have captured for my own."
			endif
		endif
	endif

	int nslaves = DOM02.GetActorCount()
	if nslaves == 0
		if quest_start_time == 0.0
			return ; no release no slaves
		endif
		quest_ransom_txt = txt
		return
	endif

	string txt_ransom
	if nslaves == 1
		DOM_Actor akSlave = DOM02.GetActorByIndex(0)
		if akSlave != None
			if (akSlave.actorSex %2) == 1
				txt_ransom = " My slave "+akSlave.GetName()+" has family who could pay a nice ransom in exchange of her freedom."
			else
				txt_ransom = " My slave "+akSlave.GetName()+" has family who could pay a nice ransom in exchange of his freedom."
			endif
		endif
	else
		txt_ransom = " Among my slaves I know a few who could have family ready to pay a ransom in echange of their freedom: "
		int idx = 0
		bool is_first = true
		string txt_last
		while idx < nslaves
			DOM_Actor akSlave = DOM02.GetActorByIndex(idx)
			if akSlave != None
				bool has_family = akSlave.akRef.HasFamilyRelationship(None)
				;LogTrace(akSlave.GetName()+" HasFamilyRelationship="+has_family)
				if has_family
					if txt_last != ""
						if is_first	
							is_first = false
							txt_ransom += " "
						else
							txt_ransom += ", "
						endif
						txt_ransom += txt_last
					endif
					txt_last = akSlave.GetName()
				endif
			endif
			idx += 1
		endwhile
		if txt_last != ""
			if is_first
				txt_ransom += " "+txt_last+"."
			else
				txt_ransom += " and "+txt_last+"."
			endif
		endif
		txt += txt_ransom
	endif
	quest_ransom_txt = txt
EndFunction

string Function TextSlavesSold()
	return "Here I will write about selling slaves to customers."
EndFunction

; ===================================================================================
; =                                                                                 =
; = Slave's diary                                                                   =
; =                                                                                 =
; ===================================================================================

string Function TextSlaveAbuse(int idx, DOM_Actor akActor)
	;LogTrace("TextSlaveAbuse idx="+idx+" "+akActor.GetName())
	if akActor == None
		return ""
	endif
	DOM_Mind akMind = akActor.mind
	if akMind == None
		return ""
	endif
	if akMind.memory_entries <= idx
		return ""
	endif
	if akMind.memory_abuse_txt[idx] != ""
		;LogTrace("TextSlaveAbuse SET idx="+idx+" "+akActor.GetName()+" "+akMind.memory_abuse_txt[idx])
		return akMind.memory_abuse_txt[idx]
	endif
	SetTextSlaveAbuse(idx, akActor)
	;LogTrace("TextSlaveAbuse RESET idx="+idx+" "+akActor.GetName()+" "+akMind.memory_abuse_txt[idx])
	return akMind.memory_abuse_txt[idx]
EndFunction

Function SetTextSlaveAbuse(int idx, DOM_Actor akActor)
	;LogTrace("SetTextSlaveAbuse "+akActor)
	if akActor == None
		return
	endif
	;LogTrace("SetTextSlaveAbuse "+akActor.GetName())
	DOM_Mind akMind = akActor.mind
	if akMind == None
		return
	endif
	int cat = akMind.memory_abuse_category[idx]
	;LogTrace("SetTextSlaveAbuse: WARNING text should have been set previously cat="+cat+" actor="+akActor)
	if cat == 0
		SetTextSlaveSalute(idx,akActor)
	elseif cat == 1 ; also see default below
		SetTextSlavePunishment(idx, akActor)
	elseif cat == 2
		SetTextSlavePraise(idx,akActor)
	elseif cat == 3
		SetTextSlaveInsult(idx,akActor)
	elseif cat == 4
		SetTextSlaveFlatter(idx,akActor)
	elseif cat == 5
		SetTextSlaveComfort(idx,akActor)
	elseif cat == 6
		SetTextSlaveGivePromise(idx,akActor)
	elseif cat == 7
		SetTextSlaveKeptPromise(idx,akActor)
	elseif cat == 8
		SetTextSlaveThreaten(idx,akActor)
	elseif cat == 9
		SetTextSlaveScold(idx,akActor)
	elseif cat == 10
		SetTextSlaveShowering(idx,akActor)
	elseif cat == 11
		SetTextSlaveRape(idx,akActor)
	elseif cat == 12
		SetTextSlaveSex(idx,akActor)
	elseif cat == 13
		SetTextSlaveCheck(idx,akActor)
	elseif cat == 14
		SetTextSlaveKiss(idx,akActor)
	elseif cat == 15
		SetTextSlaveMasturbate(idx,akActor)
	elseif cat == 16
		SetTextSlavePose(idx,akActor)
	elseif cat == 17
		SetTextSlaveCombat(idx,akActor)
	elseif cat == 18
		SetTextSlaveTied(idx,akActor)
	elseif cat == 19
		SetTextSlavePricing(idx,akActor)
	elseif cat == 20
		SetTextSlaveFriendship(idx,akActor)
	elseif cat == 21
		SetTextSlaveLostFriendship(idx,akActor)
	;elseif cat == 22
	;	SetTextSlaveRecoverFriendship(idx,akActor)
	elseif cat == 23
		SetTextSlaveDrunk(idx,akActor)
	elseif cat == 24
		SetTextSlaveSilent(idx,akActor)
	elseif cat == 25
		SetTextSlaveRespect(idx,akActor)
	elseif cat == 26
		SetTextSlaveOrgasmControl(idx,akActor)
	elseif cat == 27
		SetTextSlaveOrgasm(idx,akActor)
	elseif cat == 28
		SetTextSlaveAshamed(idx,akActor)
	elseif cat == 29
		SetTextSlaveShock(idx,akActor)
	elseif cat == 30
		SetTextSlaveBroken(idx,akActor)
	elseif cat == 31
		SetTextSlaveInlove(idx,akActor)
	elseif cat == 32
		SetTextSlaveChat(idx,akActor)
	elseif cat == 33
		SetTextSlaveWalkOnFour(idx,akActor)
	elseif cat == 36
		SetTextSlaveDrugged(idx,akActor)
	elseif cat == 37
		SetTextSlaveAddicted(idx,akActor)
	elseif cat == 38
		SetTextSlaveNewCapture(idx,akActor)
	elseif cat == 39
		SetTextSlaverNewRecruit(idx,akActor)
	elseif cat == 40
		SetTextSlaveTrainingStatusUpdate(idx,akActor)
	elseif cat == 41
		SetTextSlaveDiscoverKink(idx,akActor)
	elseif cat == 42
		SetTextSlaveTeasingKink(idx,akActor)
	elseif cat == 43
		SetTextSlaveAcquiredKink(idx,akActor)
	elseif cat == 44
		SetTextSlaveJail(idx,akActor)
	elseif cat == 45
		SetTextSlaveSweep(idx,akActor)
	elseif cat == 46
		SetTextSlaveWork(idx,akActor)
	elseif cat == 49
		SetTextSlaveStrip(idx,akActor)
	elseif cat == 50
		SetTextSlaveCollar(idx,akActor)
	elseif cat == 51
		SetTextSlaveGag(idx,akActor)
	elseif cat == 52
		SetTextSlaveBlindfold(idx,akActor)
	elseif cat == 53
		SetTextSlaveBrand(idx,akActor)
	elseif cat == 54
		SetTextSlavePlug(idx,akActor)
	elseif cat == 55
		SetTextSlavePlug(idx,akActor)
	elseif cat == 60
		SetTextSlaveVirginity(idx,akActor)
	else
		SetTextSlavePunishment(idx, akActor)
	endif
EndFunction

string Function TextSlavePresentation(DOM_Actor akActor)
	;LogTrace("TextSlavePresentation "+akActor)
	if akActor == None
		return ""
	endif
	;LogTrace("TextSlavePresentation "+akActor.GetName())
	DOM_Mind akMind = akActor.mind
	if akMind == None
		return "My name is "+akActor.GetName()
	endif
	if akMind.memory_origin_txt != ""
		return akMind.memory_origin_txt
	endif
	SetTextSlavePresentation(akActor)
	return akMind.memory_origin_txt
EndFunction

Function SetTextSlavePresentation(DOM_Actor akActor)
	;LogTrace("SetTextSlavePresentation "+akActor)
	if akActor == None
		return
	endif
	;LogTrace("SetTextSlavePresentation "+akActor.GetName())
	DOM_Mind akMind = akActor.mind
	if akMind == None
		return
	endif
	string txt
	if RandomFloat()*200.0 < akMind.HEXACO_eXtraversion
		txt = "If you're not me, please return this diary to "+akActor.GetName()+"."
	elseif RandomFloat()*200.0 < akMind.HEXACO_Honesty
		txt = "This is where I will write about all my fears and hopes."
	elseif RandomFloat()*200.0 < akMind.HEXACO_Emotionality
		txt = "My dear diary,"
	elseif RandomFloat()*200.0 < akMind.HEXACO_Agreeableness
		txt = "Dear reader, welcome to my diary,"
	elseif RandomFloat()*200.0 < akMind.HEXACO_Conscientiousness
		txt = "Let's start with the beginning,"
	elseif RandomFloat()*200.0 < akMind.HEXACO_Openness
		txt = "This is my diary, read if you dare."
	elseif RandomFloat()*200.0 < akMind.FACET_Sensuality
		txt = "To the stranger who found my diary, please do not read further!"
	elseif RandomFloat()*200.0 < akMind.FACET_Submissivity
		txt = "This diary will contain everything about my most unfathomable side."
	elseif RandomFloat()*200.0 < akMind.FACET_Toughness
		txt = "My diary from my first days of adventuring,"
	elseif RandomFloat()*200.0 < akMind.FACET_Boldness
		txt = "A diary about me and everything else,"
	elseif RandomFloat()*200.0 < akMind.FACET_Smartness
		txt = "Let's start the journey,"
	elseif RandomFloat()*200.0 < akMind.FACET_Wilfulness
		txt = "My diary, with one entry per day,"
	elseif RandomFloat() < 0.5
		txt = "This is my diary,"
	else
		txt = "This is the diary of "+akActor.GetName()+","
	endif
	if akMind.memory_capture_location == akMind.memory_capture_origin
		txt += " I am "+akActor.GetName()+" from "+akMind.memory_capture_location+"." 
	else	
		txt += " I am "+akActor.GetName()+" from "+akMind.memory_capture_location+" in "+akMind.memory_capture_origin+"." 
	endif
	if akMind.memory_capture_occupation != ""
		txt += " I am "+akMind.memory_capture_occupation+"."
	endif
	;LogTrace("SetTextSlavePresentation "+txt)	
	akMind.memory_origin_txt = txt
EndFunction
	
string Function TextSlaveCapture(DOM_Actor akActor)
	;LogTrace("TextSlaveCapture "+akActor)
	if akActor == None
		return ""
	endif
	DOM_Mind akMind = akActor.mind
	if akMind == None
		return "This is my diary."
	endif
	if akMind.memory_capture_txt != ""
		return akMind.memory_capture_txt
	endif
	if akMind.memory_capture_type == "recruited"
		SetTextSlaverRecruit(akActor)
	else
		SetTextSlaveCapture(akActor)
	endif
	return akMind.memory_capture_txt
EndFunction

Function SetTextSlaveCapture(DOM_Actor akActor)
	;LogTrace("SetTextSlaveCapture "+akActor)
	if akActor == None
		return
	endif
	DOM_Mind akMind = akActor.mind
	if akMind == None
		return
	endif
	;LogTrace("SetTextSlaveCapture "+akActor.GetName())
	string txt = "It all happened on "+GameTimeToString(akMind.memory_capture_time)+" in "+akMind.memory_capture_location+", I was "+akMind.memory_capture_type+"."
	if akMind.memory_capture_mood <= 9 || (akMind.memory_capture_mood >= 18 && akMind.memory_capture_mood < 21) ; broken or below, or defiant, proud, crushed
		txt += " Then this crazy "+DOMPlayerAlias.playerBadName+", named "+Game.GetPlayer().GetDisplayname()+", tells me I am "+DOMPlayerAlias.GetPlayerPossessive()+" slave!"
		if akMind.memory_capture_mood != 10
			txt += " I was so "+GetMoodStatusName(akMind.memory_capture_mood)+"."
		else
			txt += " I don't know how but I managed to keep my composure, I am really proud of myself."
		endif
	elseif akMind.memory_capture_mood >= 14 && akMind.memory_capture_mood < 18 ; above in love, below defiant
		txt += " Then "+DOMPlayerAlias.GetPlayerTitle()+" "+Game.GetPlayer().GetDisplayname()+" came and told me "
		txt += DOMPlayerAlias.GetPlayerPronoun()+" wants me as "+DOMPlayerAlias.GetPlayerPossessive()+" slave. I am so in love with "+DOMPlayerAlias.GetPlayerObjective()+" I could not refuse!"
	elseif akMind.memory_capture_mood == 13 ; loyal
		txt += " Then "+DOMPlayerAlias.GetPlayerTitle()+" "+Game.GetPlayer().GetDisplayname()+" came and told me "
		txt += DOMPlayerAlias.GetPlayerPronoun()+" wants me at "+DOMPlayerAlias.GetPlayerPossessive()+" service. I could not refuse!"
	else ; neutral to happy and charmed
		txt += " Then this "+DOMPlayerAlias.playerBadName+", named "+Game.GetPlayer().GetDisplayname()+", tells me I am "+DOMPlayerAlias.GetPlayerPossessive()+" slave!"
		txt += " I was a bit surprised to say the least"
		if akMind.memory_capture_mood == 10
			txt += "."
		else
			txt += ", but I am "+GetMoodStatusName(akMind.memory_capture_mood)+"."
		endif
	endif
	akMind.memory_capture_txt = txt
EndFunction

Function SetTextSlaverRecruit(DOM_Actor akActor)
	;LogTrace("SetTextSlaverRecruit "+akActor)
	if akActor == None
		return
	endif
	DOM_Mind akMind = akActor.mind
	if akMind == None
		return
	endif
	;LogTrace("SetTextSlaverRecruit "+akActor.GetName())
	string txt = "It was "+GameTimeToString(akMind.memory_capture_time)+" in "+akMind.memory_capture_location
	if akActor.mind.is_player_actor
		txt += ", when I decided to start a new life."
	else
		txt += ", I was "+akMind.memory_capture_type+"."
		if akMind.memory_capture_mood <= 9 || (akMind.memory_capture_mood >= 18 && akMind.memory_capture_mood < 21) ; broken or below, or defiant, proud, crushed
			txt += " "+DOMPlayerAlias.GetPlayerTitle()+" "+Game.GetPlayer().GetDisplayname()+", told me I should join "+DOMPlayerAlias.GetPlayerObjective()+" as a slaver."
			if akMind.memory_capture_mood != 10
				txt += " I was so "+GetMoodStatusName(akMind.memory_capture_mood)+"."
			else
				txt += " I think this is a dream come true, I am really proud of myself."
			endif
		elseif akMind.memory_capture_mood >= 14 && akMind.memory_capture_mood < 18 ; above in love, below defiant
			txt += " "+DOMPlayerAlias.GetPlayerTitle()+" "+Game.GetPlayer().GetDisplayname()+" came and told me "
			txt += DOMPlayerAlias.GetPlayerPronoun()+" wants me to be one of "+DOMPlayerAlias.GetPlayerPossessive()+" slaver. I am so in love with "+DOMPlayerAlias.GetPlayerObjective()+" I could not refuse!"
		elseif akMind.memory_capture_mood == 13 ; loyal
			txt += " "+DOMPlayerAlias.GetPlayerTitle()+" "+Game.GetPlayer().GetDisplayname()+" came and told me "
			txt += DOMPlayerAlias.GetPlayerPronoun()+" wants me to work for "+DOMPlayerAlias.GetPlayerObjective()+" as a slaver. I could not refuse!"
		else ; neutral to happy and charmed
			txt += " "+DOMPlayerAlias.GetPlayerTitle()+" "+Game.GetPlayer().GetDisplayname()+", told  me I should work for "+DOMPlayerAlias.GetPlayerObjective()+" and be a slaver."
			txt += " It did sound very interesting, and certainly something I would enjoy."
			if akMind.memory_capture_mood == 10
				txt += "."
			else
				txt += " A new life is starting for me and I am "+GetMoodStatusName(akMind.memory_capture_mood)+"."
			endif
		endif
	endif
	akMind.memory_capture_txt = txt
EndFunction

bool Function StartTextSlaveAbuse(int idx, DOM_Actor akActor, bool is_aggressive)
	DOM_Mind akMind = akActor.mind
	float time         = akMind.memory_abuse_time[idx]
	string loc         = akMind.memory_abuse_location[idx]
	float prev_time
	string prev_loc
	if idx == 0
		prev_time   = akMind.memory_capture_time
		prev_loc    = akMind.memory_capture_location
	else
		int prev_idx = idx-(1)
		prev_time   = akMind.memory_abuse_time[prev_idx]
		prev_loc    = akMind.memory_abuse_location[prev_idx]
	endif
	
	string txt
	if idx == 0
		txt = GetDifferenceTimeStringCaps(prev_time,time)+" while we were in "+loc
		akMind.memory_abuse_txt[idx] = txt
		return false ; no caps after that
	endif
	int mood           = akMind.memory_abuse_mood[idx]
	bool is_respectful = akMind.memory_abuse_respectful[idx]
	bool same_day = (time-prev_time)<1.0
	bool same_loc = (prev_loc == loc)
	bool next_caps =  true ; if false, no caps after that text
	if (mood > 8 && mood < 18) || is_respectful || !akMind.is_slave
		if is_aggressive
			if (idx%10) == 1
				txt = DOMPlayerAlias.GetPlayerTitleIfRespectful(akMind.memory_abuse_respectful[idx])+" was not happy today."
			elseif (idx%10) == 2
				txt = "Today "+DOMPlayerAlias.GetPlayerTitleIfRespectful(akMind.memory_abuse_respectful[idx])+" confronted me."
			elseif (idx%10) == 3
				txt = DOMPlayerAlias.GetPlayerTitleIfRespectful(akMind.memory_abuse_respectful[idx])+" came up to me with a displeased expression."
			elseif (idx%10) == 4
				txt = DOMPlayerAlias.GetPlayerTitleIfRespectful(akMind.memory_abuse_respectful[idx])+" addressed me in a stern manner."
			elseif (idx%10) == 5
				txt = DOMPlayerAlias.GetPlayerTitleIfRespectful(akMind.memory_abuse_respectful[idx])+" approached me with dissatisfaction."
			elseif (idx%10) == 6
				txt = DOMPlayerAlias.GetPlayerTitleIfRespectful(akMind.memory_abuse_respectful[idx])+" engaged me with a critical tone."
			elseif (idx%10) == 7
				txt = DOMPlayerAlias.GetPlayerTitleIfRespectful(akMind.memory_abuse_respectful[idx])+" confronted me angrily today."
			elseif (idx%10) == 8
				txt = "Today "+DOMPlayerAlias.GetPlayerTitleIfRespectful(akMind.memory_abuse_respectful[idx])+" lashed out at me."
			elseif (idx%10) == 9
				txt = DOMPlayerAlias.GetPlayerTitleIfRespectful(akMind.memory_abuse_respectful[idx])+" approached me, seething with anger."
			else
				txt = "Today "+DOMPlayerAlias.GetPlayerTitleIfRespectful(akMind.memory_abuse_respectful[idx])+" came angrily to me."
			endif
		elseif (idx%10) == 1
			txt = DOMPlayerAlias.GetPlayerTitleIfRespectful(akMind.memory_abuse_respectful[idx])+" came to me today."
		elseif (idx%10) == 2
			txt = DOMPlayerAlias.GetPlayerTitleIfRespectful(akMind.memory_abuse_respectful[idx])+" came to see me."
		elseif (idx%10) == 3
			txt = DOMPlayerAlias.GetPlayerTitleIfRespectful(akMind.memory_abuse_respectful[idx])+" approached me today."
		elseif (idx%10) == 4
			txt = DOMPlayerAlias.GetPlayerTitleIfRespectful(akMind.memory_abuse_respectful[idx])+" reached out to me."
		elseif (idx%10) == 5
			txt = DOMPlayerAlias.GetPlayerTitleIfRespectful(akMind.memory_abuse_respectful[idx])+" sought me out today."
		elseif (idx%10) == 6
			txt = "Today "+DOMPlayerAlias.GetPlayerTitleIfRespectful(akMind.memory_abuse_respectful[idx])+" came to talk to me."
		elseif (idx%10) == 7
			txt = DOMPlayerAlias.GetPlayerTitleIfRespectful(akMind.memory_abuse_respectful[idx])+" came up to me today."
		elseif (idx%10) == 8
			txt = "Today "+DOMPlayerAlias.GetPlayerTitleIfRespectful(akMind.memory_abuse_respectful[idx])+" came my way."
		elseif (idx%10) == 9
			txt = "Today "+DOMPlayerAlias.GetPlayerTitleIfRespectful(akMind.memory_abuse_respectful[idx])+" addressed me directly."
		else
			txt += "Today"
			next_caps = false
		endif
		if next_caps && !same_day
			txt += " It was on "+GameTimeToString(time)
			next_caps = false
		endif
	elseif (idx%10) == 1
		txt = "No! It started again! This is a nightmare!"
		if !same_day
			txt += " "+GetDifferenceTimeStringCaps(prev_time,time)
			next_caps = false
		endif
	elseif (idx%10) == 2
		txt = "Someone has to come and rescue me! Please!"
		if !same_day
			txt += " On "+GameTimeToString(time)
			next_caps = false
		endif
	elseif (idx%10) == 3
		txt = "I can't take it anymore..."
		if !same_day
			txt += " "+GetDifferenceTimeStringCaps(prev_time,time)
			next_caps = false
		endif
	elseif (idx%10) == 4
		txt = "Not again! Why is this happening to me?"
		if !same_day
			txt += " On "+GameTimeToString(time)
			next_caps = false
		endif
	elseif (idx%10) == 5
		txt = "How can this be possible!"
		if !same_day
			txt += " "+GetDifferenceTimeStringCaps(prev_time,time)
			next_caps = false
		endif
	elseif (idx%10) == 6
		txt += "This will never end..."
		if !same_day
			txt += " On "+GameTimeToString(time)
			next_caps = false
		endif
	elseif (idx%10) == 7
		txt += "Just when I thought there was still hope."
		if !same_day
			txt += " On "+GameTimeToString(time)
			next_caps = false
		endif
	elseif (idx%10) == 8
		txt += "Am I in hell already?"
		if !same_day
			txt += " On "+GameTimeToString(time)
			next_caps = false
		endif
	elseif (idx%10) == 9
		txt += "No, no, no, no! This can't be happening again!"
		if !same_day
			txt += " On "+GameTimeToString(time)
			next_caps = false
		endif
	else
		txt += "Today"
		next_caps = false
	endif

	if !same_loc
		if next_caps
			txt += " While we were in "+loc
			next_caps = false
		else
			txt += ", while we were in "+loc
			next_caps = false
		endif
	endif

	akMind.memory_abuse_txt[idx] = txt
	return next_caps 
EndFunction

string Function TitleTextSlaveAbuse(int idx, DOM_Actor akActor, bool has_caps, bool has_comma)
	DOM_Mind akMind = akActor.mind
	int mood           = akMind.memory_abuse_mood[idx]
	bool is_respectful = akMind.memory_abuse_respectful[idx]
	if (mood > 8 && mood < 18) || is_respectful
		if has_caps
			return " "+DOMPlayerAlias.GetPlayerTitle()
		endif
		return ", "+DOMPlayerAlias.GetPlayerTitle()
	endif
	
	string txt_adj
	if idx == 0
		txt_adj = ""
	elseif (idx%6) == 1
		txt_adj = "crazy "
	elseif (idx%6) == 2
		txt_adj = "horrible "
	elseif (idx%6) == 3
		txt_adj = "disgusting "
	elseif (idx%6) == 4
		txt_adj = "furious "
	elseif (idx%6) == 5
		txt_adj = "mad "
	endif

	string txt = txt_adj+DOMPlayerAlias.playerNeutralName
	
	if has_caps
		return " This "+txt
	endif
	if has_comma
		return ", this "+txt
	endif
	return " this "+txt
EndFunction

Function SetTextSlaveNewCapture(int idx, DOM_Actor akActor)
	;LogTrace("SetTextSlaveNewCapture "+idx+" "+akActor.GetName())
	if idx < 0
		return
	endif
	if akActor == None
		return
	endif
	DOM_Mind akMind = akActor.mind
	if akMind == None
		return
	endif
	; Current event
	int mood           = akMind.memory_abuse_mood[idx]
	int level          = akMind.memory_abuse_level[idx]
	string type        = akMind.memory_abuse_type[idx]
	string reason      = akMind.memory_abuse_reason[idx]
	; Previous event
	int prev_mood
	int prev_level
	string prev2_type
	string prev_type
	string prev_reason
	if idx == 0
		prev_mood   = akMind.memory_capture_mood
		prev_level  = 0
		prev_type   = akMind.memory_capture_type
		prev_reason = "capture"
		prev2_type  = "nothing" 
	else
		int prev_idx = idx-(1)
		prev_mood   = akMind.memory_abuse_mood[prev_idx]
		prev_level  = akMind.memory_abuse_level[prev_idx]
		prev_type   = akMind.memory_abuse_type[prev_idx]
		prev_reason = akMind.memory_abuse_reason[prev_idx]
		if idx > 1
			int prev2_idx = idx-(2)
			prev2_type  = akMind.memory_abuse_type[prev2_idx]
		else
			prev2_type  = "nothing" 
		endif
	endif
	
	bool has_caps = false
	string txt = "Today "
	txt += TitleTextSlaveAbuse(idx, akActor, has_caps, true) ; has comma 
	txt += " decided to enslave me"
	if akMind.memory_capture_ntimes > 1
		txt += " again!"
	else ; if akMind.memory_capture_rtimes > 1
		txt += " after all I did for "+DOMPlayerAlias.GetPlayerObjective()+"!"
	endif
	if mood == 2 || mood == 18 ; angry, defiant
		txt += " I swear I am going to kill "+DOMPlayerAlias.GetPlayerObjective()+". I just need to find a weapon."
	elseif mood == 6 || mood == 20 ; ashamed, proud
		txt += " I am not a merchandise, this "+DOMPlayerAlias.playerBadName+" will pay for this!"
	elseif mood == 7 || mood == 19 ; sad, crushed
		txt += " This can't be true, I don't think I can stand anymore abuse from this "+DOMPlayerAlias.playerBadName+"."
	elseif mood <= 9  ; broken, afraid
		txt += " I will never trust this "+DOMPlayerAlias.playerBadName+" again!"
	elseif mood >= 14 && mood < 18 ; above in love, below defiant
		txt += "I am so in love with "+DOMPlayerAlias.GetPlayerTitle()+" "+Game.GetPlayer().GetDisplayname()+", I felt completely empty without "+DOMPlayerAlias.GetPlayerObjective()+"."
	elseif mood == 13 ; loyal
		txt += " I am so proud to be back at "+DOMPlayerAlias.GetPlayerTitle()+" "+Game.GetPlayer().GetDisplayname()+" 's service."
	else ; neutral to happy and charmed
		txt += " "+DOMPlayerAlias.GetPlayerTitle()+" "+Game.GetPlayer().GetDisplayname()+", told  me I am forever "+DOMPlayerAlias.GetPlayerPossessive()+" slave."
		if mood == 10
			txt += "."
		else
			txt += " At least I am back to something I am used to, I am "+GetMoodStatusName(mood)+"."
		endif
	endif
	string txt_punc = " It"
	if mood != 10 && mood != 11 && mood > 1 && mood != prev_mood
		string the_mood = GetMoodStatusName(mood)
		if (mood == 2 || mood == 18 || mood == 17) && reason == "being angry"
			txt += txt_punc+" made me very "+the_mood
		else
			txt += txt_punc+" "+GetMoodSlaveText(mood)
		endif
	elseif level != prev_level
		string the_level = GetTrainingStatusName(level)
		txt += txt_punc+" made me feel completely "+the_level
	elseif txt_punc == ", it"
		txt += "."
		txt_punc = ""
	else
		txt_punc = ""
	endif
	if txt_punc != ""
		txt += "."
	endif
	akMind.memory_abuse_txt[idx] = txt
	;LogTrace("SetTextSlaveNewCapture idx="+idx+" "+akActor.GetName()+" "+akMind.memory_abuse_txt[idx])
EndFunction

Function SetTextSlaverNewRecruit(int idx, DOM_Actor akActor)
	;LogTrace("SetTextSlaverNewRecruit "+idx+" "+akActor.GetName())
	if idx < 0
		return
	endif
	if akActor == None
		return
	endif
	DOM_Mind akMind = akActor.mind
	if akMind == None
		return
	endif
	; Current event
	float time         = akMind.memory_abuse_time[idx]
	int mood           = akMind.memory_abuse_mood[idx]
	int level          = akMind.memory_abuse_level[idx]
	string loc         = akMind.memory_abuse_location[idx]
	string type        = akMind.memory_abuse_type[idx]
	string reason      = akMind.memory_abuse_reason[idx]
	; Previous event
	int prev_mood
	int prev_level
	string prev2_type
	string prev_type
	string prev_reason
	if idx == 0
		prev_mood   = akMind.memory_capture_mood
		prev_level  = 0
		prev_type   = akMind.memory_capture_type
		prev_reason = "capture"
		prev2_type  = "nothing" 
	else
		int prev_idx = idx-(1)
		prev_mood   = akMind.memory_abuse_mood[prev_idx]
		prev_level  = akMind.memory_abuse_level[prev_idx]
		prev_type   = akMind.memory_abuse_type[prev_idx]
		prev_reason = akMind.memory_abuse_reason[prev_idx]
		if idx > 1
			int prev2_idx = idx-(2)
			prev2_type  = akMind.memory_abuse_type[prev2_idx]
		else
			prev2_type  = "nothing" 
		endif
	endif

	string txt = "It was "+GameTimeToString(time)+" in "+loc+", I was "+type+"."
	if mood <= 9 || (mood >= 18 && mood <21) ; broken or below, or defiant, proud, crushed
		txt += " "+DOMPlayerAlias.GetPlayerTitle()+" "+Game.GetPlayer().GetDisplayname()+", told me I should join "+DOMPlayerAlias.GetPlayerObjective()+" as a slaver."
		if mood != 10
			txt += " I was so "+GetMoodStatusName(mood)+"."
		else
			txt += " I think this is a dream come true, I am really proud of myself."
		endif
	elseif mood >= 14 && mood < 18 ; above in love, below defiant
		txt += " "+DOMPlayerAlias.GetPlayerTitle()+" "+Game.GetPlayer().GetDisplayname()+" came and told me "
		txt += DOMPlayerAlias.GetPlayerPronoun()+" wants me to be one of "+DOMPlayerAlias.GetPlayerPossessive()+" slaver. I am so in love with "+DOMPlayerAlias.GetPlayerObjective()+" I could not refuse!"
	elseif mood == 13 ; loyal
		txt += " "+DOMPlayerAlias.GetPlayerTitle()+" "+Game.GetPlayer().GetDisplayname()+" came and told me "
		txt += DOMPlayerAlias.GetPlayerPronoun()+" wants me to work for "+DOMPlayerAlias.GetPlayerObjective()+" as a slaver. I could not refuse!"
	else ; neutral to happy and charmed
		txt += " "+DOMPlayerAlias.GetPlayerTitle()+" "+Game.GetPlayer().GetDisplayname()+", told  me I should work for "+DOMPlayerAlias.GetPlayerObjective()+" and be a slaver."
		txt += " It did sound very interesting, and certainly something I would enjoy."
		if mood == 10
			txt += "."
		else
			txt += " A new life is starting for me and I am "+GetMoodStatusName(mood)+"."
		endif
	endif

	if akMind.memory_capture_rtimes > 1
		txt += " Finally everything is back to normal!"
	else ; if akMind.memory_capture_ntimes > 1
		txt += " This a the reward I was hopping for!"
	endif
	akMind.memory_abuse_txt[idx] = txt
	;LogTrace("SetTextSlaverNewRecruit idx="+idx+" "+akActor.GetName()+" "+akMind.memory_abuse_txt[idx])
EndFunction

Function SetTextSlaveScold(int idx, DOM_Actor akActor)
	;LogTrace("SetTextSlaveScold "+idx+" "+akActor.GetName())
	if idx < 0
		return
	endif
	if akActor == None
		return
	endif
	DOM_Mind akMind = akActor.mind
	if akMind == None
		return
	endif
	; Current event
	int mood           = akMind.memory_abuse_mood[idx]
	int level          = akMind.memory_abuse_level[idx]
	string type        = akMind.memory_abuse_type[idx]
	string reason      = akMind.memory_abuse_reason[idx]
	; Previous event
	int prev_mood
	int prev_level
	string prev2_type
	string prev_type
	string prev_reason
	if idx == 0
		prev_mood   = akMind.memory_capture_mood
		prev_level  = 0
		prev_type   = akMind.memory_capture_type
		prev_reason = "capture"
		prev2_type  = "nothing" 
	else
		int prev_idx = idx-(1)
		prev_mood   = akMind.memory_abuse_mood[prev_idx]
		prev_level  = akMind.memory_abuse_level[prev_idx]
		prev_type   = akMind.memory_abuse_type[prev_idx]
		prev_reason = akMind.memory_abuse_reason[prev_idx]
		if idx > 1
			int prev2_idx = idx-(2)
			prev2_type  = akMind.memory_abuse_type[prev2_idx]
		else
			prev2_type  = "nothing" 
		endif
	endif
	
	bool has_caps = StartTextSlaveAbuse(idx, akActor, true) ; aggressive event
	string txt = akMind.memory_abuse_txt[idx]
	txt += TitleTextSlaveAbuse(idx, akActor, has_caps, true) ; has comma 
	txt += " scolded me"
	int ntimes = akMind.memory_abuse_ntimes[idx]
	if ntimes > 1
		if ntimes > 3
			txt += ", many times"
		elseif ntimes > 2
			txt += ", three times"
		else
			txt += ", twice"
		endif
	endif
	if reason == "no reason" || reason == ""
		txt += " for no apparent reason!"
	elseif stringUtil.find(reason,"didnt")>=0
		if idx == 0
			txt += " because I "+reason+" or so "+DOMPlayerAlias.GetPlayerPronoun()+" said."
		else
			txt += " because I "+reason+"."
		endif
	elseif idx == 0
		txt += " for "+reason+" or so "+DOMPlayerAlias.GetPlayerPronoun()+" said."
	else
		txt += " for "+reason+"."
	endif
	if prev_type == type && prev2_type != prev_type && reason == prev_reason
		txt += " AGAIN!"
	endif
	string txt_punc = " It"
	if prev_reason == reason
		if idx < 32
			txt += " "+DOMPlayerAlias.GetPlayerPronoun()+" said that's a warning"
			txt_punc = ", it"
		else
			txt += " "+DOMPlayerAlias.GetPlayerPronoun()+" said next time there will be consequences"
		endif
	elseif mood == 7 || mood == 8 || mood == 15 || mood == 16
		txt += " "+DOMPlayerAlias.GetPlayerPronoun()+" said I am hopeless"
		txt_punc = ", it"
	endif
	if mood != 10 && mood != 11 && mood > 1 && mood != prev_mood
		string the_mood = GetMoodStatusName(mood)
		if (mood == 2 || mood == 18 || mood == 17) && reason == "being angry" ; angry/defiant/jealous
			txt += txt_punc+" made me even more "+the_mood
		else
			txt += txt_punc+" "+GetMoodSlaveText(mood)
		endif
	elseif level != prev_level
		string the_level = GetTrainingStatusName(level)
		txt += txt_punc+" made me feel completely "+the_level
	elseif txt_punc == ", it"
		txt += "."
		txt_punc = ""
	else
		txt_punc = ""
	endif
	if txt_punc != ""
		txt += "."
	endif
	akMind.memory_abuse_txt[idx] = txt
	;LogTrace("SetTextSlaveScold idx="+idx+" "+akActor.GetName()+" "+akMind.memory_abuse_txt[idx])
EndFunction

Function SetTextSlavePunishment(int idx, DOM_Actor akActor)
	;LogTrace("SetTextSlavePunishment "+idx+" "+akActor.GetName())
	if idx < 0
		return
	endif
	if akActor == None
		return
	endif
	DOM_Mind akMind = akActor.mind
	if akMind == None
		return
	endif
	; Current event
	int mood           = akMind.memory_abuse_mood[idx]
	int level          = akMind.memory_abuse_level[idx]
	string type        = akMind.memory_abuse_type[idx]
	string reason      = akMind.memory_abuse_reason[idx]
	; Previous event
	int prev_mood
	int prev_level
	string prev2_type
	string prev_type
	string prev_reason
	if idx == 0
		prev_mood   = akMind.memory_capture_mood
		prev_level  = 0
		prev_type   = akMind.memory_capture_type
		prev_reason = "capture"
		prev2_type  = "nothing" 
	else
		int prev_idx = idx-(1)
		prev_mood   = akMind.memory_abuse_mood[prev_idx]
		prev_level  = akMind.memory_abuse_level[prev_idx]
		prev_type   = akMind.memory_abuse_type[prev_idx]
		prev_reason = akMind.memory_abuse_reason[prev_idx]
		if idx > 1
			int prev2_idx = idx-(2)
			prev2_type  = akMind.memory_abuse_type[prev2_idx]
		else
			prev2_type  = "nothing" 
		endif
	endif
	
	bool has_caps = StartTextSlaveAbuse(idx, akActor, true) ; aggressive event
	string txt = akMind.memory_abuse_txt[idx]
	txt += TitleTextSlaveAbuse(idx, akActor, has_caps, true) ; has comma 
	if (idx%10) == 0
		txt += " proceeded to "
	elseif (idx%10) == 1
		txt += " started to "
	elseif (idx%10) == 2
		txt += " decided to "
	elseif (idx%10) == 3
		txt += " was determined to "
	elseif (idx%10) == 4
		txt += " began to "
	elseif (idx%10) == 5
		txt += " wanted to make a point and tried to "
	elseif (idx%10) == 6
		txt += " came to me with a weird grin on "+DOMPlayerAlias.GetPlayerPossessive()+" face and started to "
	elseif (idx%10) == 7
		txt += " thought it would be funny to "
	elseif (idx%10) == 8
		txt += " tried to break me and proceeded to "
	elseif (idx%10) == 9
		txt += " unleashed "+DOMPlayerAlias.GetPlayerPossessive()+" anger on me and began to "
	endif
	txt += DOMCore.GetJSONPunishmentTypeTextByName(type)
	int ntimes = akMind.memory_abuse_ntimes[idx]
	if ntimes > 1
		if ntimes > 3
			txt += ", many times"
		elseif ntimes > 2
			txt += ", three times"
		else
			txt += ", twice"
		endif
	endif
	if reason == "no reason" || reason == ""
		txt += "!"
		;txt += " for no apparent reason!"
	elseif stringUtil.find(reason,"didnt")>=0
		if idx == 0
			txt += " because I "+reason+" or so "+DOMPlayerAlias.GetPlayerPronoun()+" said."
		else
			txt += " because I "+reason+"."
		endif
	elseif idx == 0
		txt += " for "+reason+" or so "+DOMPlayerAlias.GetPlayerPronoun()+" said."
	else
		txt += " for "+reason+"."
	endif
	if prev_type == type && prev2_type != prev_type
		txt += " AGAIN!"
	endif
	string txt_punc = " It"
	if prev_reason == reason
		if idx < 32
			txt += " "+DOMPlayerAlias.GetPlayerPronoun()+" said that will teach me"
			txt_punc = ", it"
		else
			txt += " "+DOMPlayerAlias.GetPlayerPronoun()+" said I should have learned by now."
		endif
	elseif mood == 7 || mood == 8 || mood == 15 || mood == 16
		txt += " "+DOMPlayerAlias.GetPlayerPronoun()+" said I am useless"
		txt_punc = ", it"
	endif
	if mood != 10 && mood != 11 && mood > 1 && mood != prev_mood
		string the_mood = GetMoodStatusName(mood)
		if (mood == 2 || mood == 18 || mood == 17) && reason == "being angry"
			txt += txt_punc+" made me even more "+the_mood
		else
			txt += txt_punc+" "+GetMoodSlaveText(mood)
		endif
	elseif level != prev_level
		string the_level = GetTrainingStatusName(level)
		txt += txt_punc+" made me feel completely "+the_level
	elseif txt_punc == ", it"
		txt += "."
		txt_punc = ""
	else
		txt_punc = ""
	endif
	if txt_punc != ""
		txt += "."
	endif
	akMind.memory_abuse_txt[idx] = txt
	;LogTrace("SetTextSlavePunishment idx="+idx+" "+akActor.GetName()+" "+akMind.memory_abuse_txt[idx])
EndFunction

Function SetTextSlaveRape(int idx, DOM_Actor akActor)
	;LogTrace("SetTextSlaveRape "+idx+" "+akActor.GetName())
	if idx < 0
		return
	endif
	if akActor == None
		return
	endif
	DOM_Mind akMind = akActor.mind
	if akMind == None
		return
	endif
	; Current event
	int mood           = akMind.memory_abuse_mood[idx]
	int level          = akMind.memory_abuse_level[idx]
	string type        = akMind.memory_abuse_type[idx]
	string reason      = akMind.memory_abuse_reason[idx]
	; Previous event
	int prev_mood
	int prev_level
	string prev2_type
	string prev_type
	string prev_reason
	if idx == 0
		prev_mood   = akMind.memory_capture_mood
		prev_level  = 0
		prev_type   = akMind.memory_capture_type
		prev_reason = "capture"
		prev2_type  = "nothing" 
	else
		int prev_idx = idx-(1)
		prev_mood   = akMind.memory_abuse_mood[prev_idx]
		prev_level  = akMind.memory_abuse_level[prev_idx]
		prev_type   = akMind.memory_abuse_type[prev_idx]
		prev_reason = akMind.memory_abuse_reason[prev_idx]
		if idx > 1
			int prev2_idx = idx-(2)
			prev2_type  = akMind.memory_abuse_type[prev2_idx]
		else
			prev2_type  = "nothing" 
		endif
	endif
	
	bool has_caps = StartTextSlaveAbuse(idx, akActor, true) ; aggressive event
	string txt = akMind.memory_abuse_txt[idx]
	txt += TitleTextSlaveAbuse(idx, akActor, has_caps, true) ; has comma 
	if (idx%10) == 0
		txt += " proceeded to "
	elseif (idx%10) == 1
		txt += " started to "
	elseif (idx%10) == 2
		txt += " decided to "
	elseif (idx%10) == 3
		txt += " was determined to "
	elseif (idx%10) == 4
		txt += " began to "
	elseif (idx%10) == 5
		txt += " wanted to make a point and tried to "
	elseif (idx%10) == 6
		txt += " came to me with a weird grin on "+DOMPlayerAlias.GetPlayerPossessive()+" face and started to "
	elseif (idx%10) == 7
		txt += " thought it would be funny to "
	elseif (idx%10) == 8
		txt += " tried to break me and proceeded to "
	elseif (idx%10) == 9
		txt += " unleashed "+DOMPlayerAlias.GetPlayerPossessive()+" anger on me and began to "
	endif
	txt += DOMCore.GetJSONPunishmentTypeTextByName(type)
	int ntimes = akMind.memory_abuse_ntimes[idx]
	if ntimes > 1
		if ntimes > 3
			txt += ", many times"
		elseif ntimes > 2
			txt += ", three times"
		else
			txt += ", twice"
		endif
	endif
	if reason == "no reason" || reason == ""
		txt += "!"
		txt += " for no apparent reason!"
	elseif stringUtil.find(reason,"didnt")>=0
		if idx == 0
			txt += " because I "+reason+" or so "+DOMPlayerAlias.GetPlayerPronoun()+" said."
		else
			txt += " because I "+reason+"."
		endif
	elseif idx == 0
		txt += " for "+reason+" or so "+DOMPlayerAlias.GetPlayerPronoun()+" said."
	else
		txt += " for "+reason+"."
	endif
	if prev_type == type && prev2_type != prev_type
		txt += " AGAIN!"
	endif
	bool had_orgasm = akMind.memory_abuse_flag[idx]
	if had_orgasm
		if mood < 8 || mood > 17
			txt += " I am so ashamed of what happened, it was... special."
		elseif mood > 11 
			if akMind.FACET_Submissivity > 80.0
				txt += " I love to be handled like that!"
			elseif akMind.FACET_Submissivity > 60.0
				txt += " I must admit I like it rough."
			elseif akMind.FACET_Submissivity < 20.0
				txt += " I wish I was not on the receiving end though..."
			else
				txt += " I was so aroused, I couldn't hide it."
			endif
		else
			txt += " The worst part is it turned me on! I wish I could control my body."
		endif
	endif
	string txt_punc = " It"
	if prev_reason == reason
		if idx < 8
			txt += " "+DOMPlayerAlias.GetPlayerPronoun()+" said that will teach me"
			txt_punc = ", it"
		else
			txt += " "+DOMPlayerAlias.GetPlayerPronoun()+" said I should have learned by now."
		endif
	elseif mood == 7 || mood == 8 || mood == 15 || mood == 16
		txt += " "+DOMPlayerAlias.GetPlayerPronoun()+" said I am useless"
		txt_punc = ", it"
	endif
	if mood != 10 && mood != 11 && mood > 1 && mood != prev_mood
		txt += txt_punc+" "+GetMoodSlaveText(mood)
	elseif level != prev_level
		string the_level = GetTrainingStatusName(level)
		txt += txt_punc+" made me feel completely "+the_level
	elseif txt_punc == ", it"
		txt += "."
		txt_punc = ""
	else
		txt_punc = ""
	endif
	if txt_punc != ""
		txt += "."
	endif
	akMind.memory_abuse_txt[idx] = txt
	;LogTrace("SetTextSlaveRape idx="+idx+" "+akActor.GetName()+" "+akMind.memory_abuse_txt[idx])
EndFunction

Function SetTextSlaveSex(int idx, DOM_Actor akActor)
	;LogTrace("SetTextSlaveSex "+idx+" "+akActor.GetName())
	if idx < 0
		return
	endif
	if akActor == None
		return
	endif
	DOM_Mind akMind = akActor.mind
	if akMind == None
		return
	endif
	; Current event
	int mood           = akMind.memory_abuse_mood[idx]
	int level          = akMind.memory_abuse_level[idx]
	string type        = akMind.memory_abuse_type[idx]
	; Previous event
	int prev_mood
	int prev_level
	string prev2_type
	string prev_type
	if idx == 0
		prev_mood   = akMind.memory_capture_mood
		prev_level  = 0
		prev_type   = akMind.memory_capture_type
		prev2_type  = "nothing" 
	else
		int prev_idx = idx-(1)
		prev_mood   = akMind.memory_abuse_mood[prev_idx]
		prev_level  = akMind.memory_abuse_level[prev_idx]
		prev_type   = akMind.memory_abuse_type[prev_idx]
		if idx > 1
			int prev2_idx = idx-(2)
			prev2_type  = akMind.memory_abuse_type[prev2_idx]
		else
			prev2_type  = "nothing" 
		endif
	endif
	
	bool has_caps = StartTextSlaveAbuse(idx, akActor, true) ; aggressive event
	string txt = akMind.memory_abuse_txt[idx]
	txt += TitleTextSlaveAbuse(idx, akActor, has_caps, true) ; has comma 
	if (idx%10) == 0
		txt += " proceeded to "
	elseif (idx%10) == 1
		txt += " started to "
	elseif (idx%10) == 2
		txt += " decided to "
	elseif (idx%10) == 3
		txt += " was determined to "
	elseif (idx%10) == 4
		txt += " began to "
	elseif (idx%10) == 5
		txt += " wanted to make a point and tried to "
	elseif (idx%10) == 6
		txt += " came to me with a weird grin on "+DOMPlayerAlias.GetPlayerPossessive()+" face and started to "
	elseif (idx%10) == 7
		txt += " thought it would be funny to "
	elseif (idx%10) == 8
		txt += " tried to break me and proceeded to "
	elseif (idx%10) == 9
		txt += " unleashed "+DOMPlayerAlias.GetPlayerPossessive()+" anger on me and began to "
	endif
	txt += DOMCore.GetJSONPunishmentTypeTextByName(type)
	int ntimes = akMind.memory_abuse_ntimes[idx]
	if ntimes > 1
		if ntimes > 3
			txt += ", many times"
		elseif ntimes > 2
			txt += ", three times"
		else
			txt += ", twice"
		endif
	endif
	string txt_punc = ", it"
	bool had_orgasm = akMind.memory_abuse_flag[idx]
	if had_orgasm
		if mood < 8 || mood > 17
			txt += " I am so ashamed for what happened."
			txt_punc = " It"
		elseif mood > 11
			if akMind.FACET_Submissivity > 80.0
				txt += " I love it when it gets a bit rough!"
			else
				txt += " I was so aroused, I couldn't hide it."
			endif
			txt_punc = " It"
		else
			txt += " I wish I could control my body, because I was indeed turned on."
			txt_punc = " It"
		endif
	endif
	if mood != 10 && mood != 11 && mood > 1 && mood != prev_mood
		txt += txt_punc+" "+GetMoodSlaveText(mood)
	elseif level != prev_level
		string the_level = GetTrainingStatusName(level)
		txt += txt_punc+" made me feel completely "+the_level
	elseif txt_punc == ", it"
		txt += "."
		txt_punc = ""
	else
		txt_punc = ""
	endif
	if txt_punc != ""
		txt += "."
	endif
	akMind.memory_abuse_txt[idx] = txt
	;LogTrace("SetTextSlaveSex idx="+idx+" "+akActor.GetName()+" "+akMind.memory_abuse_txt[idx])
EndFunction

Function SetTextSlaveVirginity(int idx, DOM_Actor akActor)
	;LogTrace("SetTextSlaveVirginity "+idx+" "+akActor.GetName())
	if idx < 0
		return
	endif
	if akActor == None
		return
	endif
	DOM_Mind akMind = akActor.mind
	if akMind == None
		return
	endif
	; Current event
	int mood           = akMind.memory_abuse_mood[idx]
	int level          = akMind.memory_abuse_level[idx]
	string type        = akMind.memory_abuse_type[idx]
	string reason      = akMind.memory_abuse_reason[idx]
	int prev_mood
	int prev_level
	if idx == 0
		prev_mood   = akMind.memory_capture_mood
		prev_level  = 0
	else
		int prev_idx = idx-(1)
		prev_mood   = akMind.memory_abuse_mood[prev_idx]
		prev_level  = akMind.memory_abuse_level[prev_idx]
	endif
	
	bool has_caps = StartTextSlaveAbuse(idx, akActor, true) ; aggressive event
	string txt = akMind.memory_abuse_txt[idx]
	txt += TitleTextSlaveAbuse(idx, akActor, has_caps, true) ; has comma 
	if type == "vaginal"
		txt += " took my virginity"
	elseif type == "oral"
		txt += " initiated me to oral sex"
	elseif type == "anal"
		txt += " initiated me to anal sex"
	elseif type == "same"
		if (akActor.actorSex%2) == 1
			txt += " initiated me to lesbian sex"
		else
			txt += " initiated me to gay sex"
		endif
	elseif type == "gang"
		txt += " initiated me to party sex"
	endif
	if reason == "orgasm"
		txt += ", I felt something warm coming over me like I never did before. This was really not what I expected."
	elseif mood < 13 || mood > 17
		txt += ", it was weird to say the least and now I feel soiled."
	else
		txt += ", I wish "+DOMPlayerAlias.GetPlayerTitleIfRespectful(akMind.memory_abuse_respectful[idx])+" would be more considerate."
	endif
	if mood != 10 && mood != 11 && mood > 1 && mood != prev_mood
		txt += " It "+GetMoodSlaveText(mood)+"."
	elseif level != prev_level
		string the_level = GetTrainingStatusName(level)
		txt += " I felt completely "+the_level+"."
	endif
	akMind.memory_abuse_txt[idx] = txt
	;LogTrace("SetTextSlaveRape idx="+idx+" "+akActor.GetName()+" "+akMind.memory_abuse_txt[idx])
EndFunction

Function SetTextSlaveDiscoverKink(int idx, DOM_Actor akActor)
	;LogTrace("SetTextSlaveDiscoverKink "+idx+" "+akActor.GetName())
	if idx < 0
		return
	endif
	if akActor == None
		return
	endif
	DOM_Mind akMind = akActor.mind
	if akMind == None
		return
	endif
	; Current event
	int mood           = akMind.memory_abuse_mood[idx]
	int level          = akMind.memory_abuse_level[idx]
	string type        = akMind.memory_abuse_type[idx]
	string reason      = akMind.memory_abuse_reason[idx]
	; Previous event
	int prev_mood
	int prev_level
	string prev2_type
	string prev_type
	string prev_reason
	if idx == 0
		prev_mood   = akMind.memory_capture_mood
		prev_level  = 0
		prev_type   = akMind.memory_capture_type
		prev_reason = "capture"
		prev2_type  = "nothing" 
	else
		int prev_idx = idx-(1)
		prev_mood   = akMind.memory_abuse_mood[prev_idx]
		prev_level  = akMind.memory_abuse_level[prev_idx]
		prev_type   = akMind.memory_abuse_type[prev_idx]
		prev_reason = akMind.memory_abuse_reason[prev_idx]
		if idx > 1
			int prev2_idx = idx-(2)
			prev2_type  = akMind.memory_abuse_type[prev2_idx]
		else
			prev2_type  = "nothing" 
		endif
	endif
	
	bool has_caps = StartTextSlaveAbuse(idx, akActor, true) ; aggressive event
	string txt = akMind.memory_abuse_txt[idx]
	txt += TitleTextSlaveAbuse(idx, akActor, has_caps, true) ; has comma 
	txt += " uncovered my kink of "+akMind.memory_abuse_reason[idx]+"."
	string txt_intro = ""
	if mood > 11 && mood < 18
		txt += " I am starting to feel very hot!"
	elseif mood == 6 || mood == 20 || mood == 9
		txt += " There is no way "+DOMPlayerAlias.GetPlayerPronoun()+" could not have noticed something was weird. I feel so ashamed!"
	elseif mood > 7
		txt += " This is so embarrassing!"
	else
		txt += " I hope "+DOMPlayerAlias.GetPlayerPronoun()+" didn't notice I was blushing."
	endif
	if mood == 20
		txt += " Still, I manage to keep my composure."
	elseif mood != 10 && mood != 11 && mood > 1 && mood != prev_mood
		txt += " I am so "+GetMoodStatusName(mood)+"."
	elseif level != prev_level
		string the_level = GetTrainingStatusName(level)
		txt += " I felt completely "+the_level+"."
	endif
	akMind.memory_abuse_txt[idx] = txt
	;LogTrace("SetTextSlaveDiscoverKink idx="+idx+" "+akActor.GetName()+" "+akMind.memory_abuse_txt[idx])
EndFunction

Function SetTextSlaveTeasingKink(int idx, DOM_Actor akActor)
	;LogTrace("SetTextSlaveTeasingKink "+idx+" "+akActor.GetName())
	if idx < 0
		return
	endif
	if akActor == None
		return
	endif
	DOM_Mind akMind = akActor.mind
	if akMind == None
		return
	endif
	; Current event
	int mood           = akMind.memory_abuse_mood[idx]
	int level          = akMind.memory_abuse_level[idx]
	string type        = akMind.memory_abuse_type[idx]
	string reason      = akMind.memory_abuse_reason[idx]
	; Previous event
	int prev_mood
	int prev_level
	string prev2_type
	string prev_type
	string prev_reason
	if idx == 0
		prev_mood   = akMind.memory_capture_mood
		prev_level  = 0
		prev_type   = akMind.memory_capture_type
		prev_reason = "capture"
		prev2_type  = "nothing" 
	else
		int prev_idx = idx-(1)
		prev_mood   = akMind.memory_abuse_mood[prev_idx]
		prev_level  = akMind.memory_abuse_level[prev_idx]
		prev_type   = akMind.memory_abuse_type[prev_idx]
		prev_reason = akMind.memory_abuse_reason[prev_idx]
		if idx > 1
			int prev2_idx = idx-(2)
			prev2_type  = akMind.memory_abuse_type[prev2_idx]
		else
			prev2_type  = "nothing" 
		endif
	endif
	
	bool has_caps = StartTextSlaveAbuse(idx, akActor, true) ; aggressive event
	string txt = akMind.memory_abuse_txt[idx]
	txt += TitleTextSlaveAbuse(idx, akActor, has_caps, true) ; has comma 
	txt += " was teasing me with "+akMind.memory_abuse_reason[idx]+"."
	string txt_intro = ""
	if mood > 11 && mood < 18
		txt += " Could I be turned on by that?"
	elseif mood == 6 || mood == 20 || mood == 9
		txt += " Really? This is just disgusting."
	elseif mood > 7
		txt += " I need to think about something else."
	else
		txt += " I need to stop this nonsense."
	endif
	if mood == 20
		txt += " I am above all this."
	elseif mood != 10 && mood != 11 && mood > 1 && mood != prev_mood
		txt += " I am so "+GetMoodStatusName(mood)+"."
	elseif level != prev_level
		string the_level = GetTrainingStatusName(level)
		txt += " I felt so "+the_level+"."
	endif
	akMind.memory_abuse_txt[idx] = txt
	;LogTrace("SetTextSlaveTeasingKink idx="+idx+" "+akActor.GetName()+" "+akMind.memory_abuse_txt[idx])
EndFunction

Function SetTextSlaveAcquiredKink(int idx, DOM_Actor akActor)
	;LogTrace("SetTextSlaveAcquiredKink "+idx+" "+akActor.GetName())
	if idx < 0
		return
	endif
	if akActor == None
		return
	endif
	DOM_Mind akMind = akActor.mind
	if akMind == None
		return
	endif
	; Current event
	int mood           = akMind.memory_abuse_mood[idx]
	int level          = akMind.memory_abuse_level[idx]
	string type        = akMind.memory_abuse_type[idx]
	string reason      = akMind.memory_abuse_reason[idx]
	; Previous event
	int prev_mood
	int prev_level
	string prev2_type
	string prev_type
	string prev_reason
	if idx == 0
		prev_mood   = akMind.memory_capture_mood
		prev_level  = 0
		prev_type   = akMind.memory_capture_type
		prev_reason = "capture"
		prev2_type  = "nothing" 
	else
		int prev_idx = idx-(1)
		prev_mood   = akMind.memory_abuse_mood[prev_idx]
		prev_level  = akMind.memory_abuse_level[prev_idx]
		prev_type   = akMind.memory_abuse_type[prev_idx]
		prev_reason = akMind.memory_abuse_reason[prev_idx]
		if idx > 1
			int prev2_idx = idx-(2)
			prev2_type  = akMind.memory_abuse_type[prev2_idx]
		else
			prev2_type  = "nothing" 
		endif
	endif
	
	bool has_caps = StartTextSlaveAbuse(idx, akActor, true) ; aggressive event
	string txt = akMind.memory_abuse_txt[idx]
	txt += TitleTextSlaveAbuse(idx, akActor, has_caps, true) ; has comma 
	txt += " finally got me into "+akMind.memory_abuse_reason[idx]+"."
	string txt_intro = ""
	if mood > 11 && mood < 18
		txt += " I admit I am starting to like it!"
	elseif mood == 6 || mood == 20 || mood == 9
		txt += " What did you do to me? Oh, "+DOMPlayerAlias.GetPlayerTitleIfRespectful(akMind.memory_abuse_respectful[idx])+", I feel so ashamed!"
	elseif mood > 7
		txt += " How could this happen to me? I was so embarrassed!"
	else
		txt += " There is no way "+DOMPlayerAlias.GetPlayerPronoun()+" didn't notice I was blushing."
	endif
	if mood == 20
		txt += " So what? It's not a defect, it's an asset."
	elseif mood != 10 && mood != 11 && mood > 1 && mood != prev_mood
		txt += " I am so "+GetMoodStatusName(mood)+"."
	elseif level != prev_level
		string the_level = GetTrainingStatusName(level)
		txt += " I felt completely "+the_level+"."
	endif
	akMind.memory_abuse_txt[idx] = txt
	;LogTrace("SetTextSlaveAcquiredKink idx="+idx+" "+akActor.GetName()+" "+akMind.memory_abuse_txt[idx])
EndFunction

Function SetTextSlaveTied(int idx, DOM_Actor akActor)
	;LogTrace("SetTextSlaveTied "+idx+" "+akActor.GetName())
	if idx < 0
		return
	endif
	if akActor == None
		return
	endif
	DOM_Mind akMind = akActor.mind
	if akMind == None
		return
	endif
	
	; Current event
	int mood           = akMind.memory_abuse_mood[idx]
	int level          = akMind.memory_abuse_level[idx]
	; Previous event
	int prev_mood
	int prev_level
	if idx == 0
		prev_mood   = akMind.memory_capture_mood
		prev_level  = 0
	else
		int prev_idx = idx-(1)
		prev_mood   = akMind.memory_abuse_mood[prev_idx]
		prev_level  = akMind.memory_abuse_level[prev_idx]
	endif
	
	bool has_caps = StartTextSlaveAbuse(idx, akActor, true) ; aggressive event
	string txt = akMind.memory_abuse_txt[idx]
	txt += TitleTextSlaveAbuse(idx, akActor, has_caps, true) ; needs comma 
	string the_pose = akMind.memory_abuse_reason[idx] ; 1: standing, 2: laying, 3: kneeling
	if stringUtil.find(the_pose,"ZapWriPose")>=0
		txt += " decided to tie me and forced me to stand on my knees"
	elseif stringUtil.find(the_pose,"ZazAPCAO3")>=0
		txt += " decided to restrain me with those big chains"
	elseif stringUtil.find(the_pose,"ZazAPCAO00")>=0
		txt += " decided to lock me into a cage"
	elseif stringUtil.find(the_pose,"ZazAPCAO01")>=0 || stringUtil.find(the_pose,"ZazAPCAO20")>=0
		txt += " decided to tie me to a whipping post"
	elseif stringUtil.find(the_pose,"ZazAPCA")>=0
		txt += " decided to tie me to some weird furniture"
	else
		txt += " decided to tie me"
	endif
	int ntimes = akMind.memory_abuse_ntimes[idx]
	if ntimes > 1
		if ntimes > 3
			txt += ", many times"
		elseif ntimes > 2
			txt += ", three times"
		else
			txt += ", twice"
		endif
	endif
	txt += " I felt so exposed"
	if mood != 10 && mood != 11 && mood > 1 && mood != prev_mood
		txt += ", and it "+GetMoodSlaveText(mood)+"."
	elseif level != prev_level
		string the_level = GetTrainingStatusName(level)
		txt += ", and I completely "+the_level+"."
	else
		txt += "!"
	endif
	akMind.memory_abuse_txt[idx] = txt
	;LogTrace("SetTextSlaveTied idx="+idx+" "+akActor.GetName()+" "+akMind.memory_abuse_txt[idx])
EndFunction

Function SetTextSlaveJail(int idx, DOM_Actor akActor)
	;LogTrace("SetTextSlaveJail "+idx+" "+akActor.GetName())
	if idx < 0
		return
	endif
	if akActor == None
		return
	endif
	DOM_Mind akMind = akActor.mind
	if akMind == None
		return
	endif
	
	; Current event
	int mood           = akMind.memory_abuse_mood[idx]
	int level          = akMind.memory_abuse_level[idx]
	; Previous event
	int prev_mood
	int prev_level
	if idx == 0
		prev_mood   = akMind.memory_capture_mood
		prev_level  = 0
	else
		int prev_idx = idx-(1)
		prev_mood   = akMind.memory_abuse_mood[prev_idx]
		prev_level  = akMind.memory_abuse_level[prev_idx]
	endif
	
	bool has_caps = StartTextSlaveAbuse(idx, akActor, true) ; aggressive event
	string txt = akMind.memory_abuse_txt[idx]
	txt += TitleTextSlaveAbuse(idx, akActor, has_caps, true) ; needs comma 
	string type = akMind.memory_abuse_type[idx]
	if type == "jail_stand"
		txt += " put me in jail. I was not even allowed to wander in my cell, I had to stand still"
	elseif type == "jail_restrained"
		txt += " took me to a jail cell and tied me up. I was "
	else
		txt += " decided to send me to jail"
	endif
	string the_pose = akMind.memory_abuse_reason[idx] ; 1: standing, 2: laying, 3: kneeling
	if stringUtil.find(the_pose,"ZapWriPose")>=0
		txt += " restrained with ropes and I had to stand on my knees"
	elseif stringUtil.find(the_pose,"ZazAPCAO3")>=0
		txt += " tightly restrained with those big chains"
	elseif stringUtil.find(the_pose,"ZazAPCAO00")>=0
		txt += " locked into a cage"
	elseif stringUtil.find(the_pose,"ZazAPCAO01")>=0 || stringUtil.find(the_pose,"ZazAPCAO20")>=0
		txt += " tied to a whipping post"
	elseif stringUtil.find(the_pose,"ZazAPCA")>=0
		txt += " tied to some weird furniture"
	else
		txt += " completely unable to move"
	endif
	int ntimes = akMind.memory_abuse_ntimes[idx]
	if ntimes > 1
		if ntimes > 3
			txt += ", many times"
		elseif ntimes > 2
			txt += ", three times"
		else
			txt += ", twice"
		endif
	endif
	if mood != 10 && mood != 11 && mood > 1 && mood != prev_mood
		txt += ", and it "+GetMoodSlaveText(mood)+"."
	elseif level != prev_level
		string the_level = GetTrainingStatusName(level)
		txt += ", and I completely "+the_level+"."
	else
		txt += "!"
	endif
	akMind.memory_abuse_txt[idx] = txt
	;LogTrace("SetTextSlaveJail idx="+idx+" "+akActor.GetName()+" "+akMind.memory_abuse_txt[idx])
EndFunction

Function SetTextSlaveSweep(int idx, DOM_Actor akActor)
	;LogTrace("SetTextSlaveSweep "+idx+" "+akActor.GetName())
	if idx < 0
		return
	endif
	if akActor == None
		return
	endif
	DOM_Mind akMind = akActor.mind
	if akMind == None
		return
	endif
	
	; Current event
	int mood           = akMind.memory_abuse_mood[idx]
	int level          = akMind.memory_abuse_level[idx]
	; Previous event
	int prev_mood
	int prev_level
	if idx == 0
		prev_mood   = akMind.memory_capture_mood
		prev_level  = 0
	else
		int prev_idx = idx-(1)
		prev_mood   = akMind.memory_abuse_mood[prev_idx]
		prev_level  = akMind.memory_abuse_level[prev_idx]
	endif
	
	bool has_caps = StartTextSlaveAbuse(idx, akActor, true) ; aggressive event
	string txt = akMind.memory_abuse_txt[idx]
	txt += TitleTextSlaveAbuse(idx, akActor, has_caps, true) ; needs comma 
	if (akActor.actorSex%2) == 0
		txt += " decided I was "+DOMPlayerAlias.GetPlayerPossessive()+" servant"
	else
		txt += " decided I was "+DOMPlayerAlias.GetPlayerPossessive()+" maid"
	endif
	if akMind.memory_abuse_flag[idx]
		txt += ", I am so honored"
	elseif akMind.memory_abuse_respectful[idx]
		txt += " and told me to clean the mess in "+DOMPlayerAlias.GetPlayerPossessive()+" hideout"
	else
		txt += " and told me to clean the mess in "+DOMPlayerAlias.GetPlayerPossessive()+" filthy lair"
	endif
	int ntimes = akMind.memory_abuse_ntimes[idx]
	if ntimes > 1
		if ntimes > 3
			txt += ", many times"
		elseif ntimes > 2
			txt += ", three times"
		else
			txt += ", twice"
		endif
	endif
	if mood != 10 && mood != 11 && mood > 1 && mood != prev_mood
		txt += ", and it "+GetMoodSlaveText(mood)+"."
	elseif level != prev_level
		string the_level = GetTrainingStatusName(level)
		txt += ", and I completely "+the_level+"."
	else
		txt += "!"
	endif
	akMind.memory_abuse_txt[idx] = txt
	;LogTrace("SetTextSlaveSweep idx="+idx+" "+akActor.GetName()+" "+akMind.memory_abuse_txt[idx])
EndFunction

Function SetTextSlaveWork(int idx, DOM_Actor akActor)
	;LogTrace("SetTextSlaveWork "+idx+" "+akActor.GetName())
	if idx < 0
		return
	endif
	if akActor == None
		return
	endif
	DOM_Mind akMind = akActor.mind
	if akMind == None
		return
	endif
	
	; Current event
	int mood           = akMind.memory_abuse_mood[idx]
	int level          = akMind.memory_abuse_level[idx]
	; Previous event
	int prev_mood
	int prev_level
	if idx == 0
		prev_mood   = akMind.memory_capture_mood
		prev_level  = 0
	else
		int prev_idx = idx-(1)
		prev_mood   = akMind.memory_abuse_mood[prev_idx]
		prev_level  = akMind.memory_abuse_level[prev_idx]
	endif
	
	bool has_caps = StartTextSlaveAbuse(idx, akActor, true) ; aggressive event
	string txt = akMind.memory_abuse_txt[idx]
	txt += TitleTextSlaveAbuse(idx, akActor, has_caps, true) ; needs comma 
	string type = akMind.memory_abuse_reason[idx]
	if type == "mine"
		txt += " forced me to work in the mines"
	else
		txt += " forced me to do work for "+DOMPlayerAlias.GetPlayerObjective()
	endif
	if akMind.memory_abuse_flag[idx]
		txt += ", I will make "+DOMPlayerAlias.GetPlayerObjective()+" rich"
	endif
	int ntimes = akMind.memory_abuse_ntimes[idx]
	if ntimes > 1
		if ntimes > 3
			txt += ", many times"
		elseif ntimes > 2
			txt += ", three times"
		else
			txt += ", twice"
		endif
	endif
	if mood != 10 && mood != 11 && mood > 1 && mood != prev_mood
		txt += ", and it "+GetMoodSlaveText(mood)+"."
	elseif level != prev_level
		string the_level = GetTrainingStatusName(level)
		txt += ", and I completely "+the_level+"."
	else
		txt += "!"
	endif
	akMind.memory_abuse_txt[idx] = txt
	;LogTrace("SetTextSlaveWork idx="+idx+" "+akActor.GetName()+" "+akMind.memory_abuse_txt[idx])
EndFunction

Function SetTextSlaveMasturbate(int idx, DOM_Actor akActor)
	;LogTrace("SetTextSlaveMasturbate "+idx+" "+akActor.GetName())
	if idx < 0
		return
	endif
	if akActor == None
		return
	endif
	DOM_Mind akMind = akActor.mind
	if akMind == None
		return
	endif
	
	; Current event
	int mood           = akMind.memory_abuse_mood[idx]
	int level          = akMind.memory_abuse_level[idx]
	; Previous event
	int prev_mood
	int prev_level
	if idx == 0
		prev_mood   = akMind.memory_capture_mood
		prev_level  = 0
	else
		int prev_idx = idx-(1)
		prev_mood   = akMind.memory_abuse_mood[prev_idx]
		prev_level  = akMind.memory_abuse_level[prev_idx]
	endif
	
	bool has_caps = StartTextSlaveAbuse(idx, akActor, true) ; aggressive event
	string txt = akMind.memory_abuse_txt[idx]
	txt += TitleTextSlaveAbuse(idx, akActor, has_caps, true) ; needs comma 
	txt += " forced me to masturbate"
	int x = StringUtil.AsOrd(akMind.memory_abuse_reason[idx]) ; 1: standing, 2: laying, 3: kneeling
	if x == 3
		txt += " while kneeling down"
	elseif x == 2
		txt += " while laying down"
	else
		txt += " while standing up"
	endif
	int ntimes = akMind.memory_abuse_ntimes[idx]
	if ntimes > 1
		if ntimes > 3
			txt += ", many times"
		elseif ntimes > 2
			txt += ", three times"
		else
			txt += ", twice"
		endif
	endif
	if mood != 10 && mood != 11 && mood > 1 && mood != prev_mood
		txt += ", it "+GetMoodSlaveText(mood)+"."
	elseif level != prev_level
		string the_level = GetTrainingStatusName(level)
		txt += ", I felt completely "+the_level+"."
	else
		txt += "."
	endif
	akMind.memory_abuse_txt[idx] = txt
	;LogTrace("SetTextSlaveMasturbate idx="+idx+" "+akActor.GetName()+" "+akMind.memory_abuse_txt[idx])
EndFunction

Function SetTextSlavePose(int idx, DOM_Actor akActor)
	;LogTrace("SetTextSlavePose "+idx+" "+akActor.GetName())
	if idx < 0
		return
	endif
	if akActor == None
		return
	endif
	
	DOM_Mind akMind = akActor.mind
	if akMind == None
		return
	endif
	bool has_caps = StartTextSlaveAbuse(idx, akActor, true) ; aggressive event
	string txt = akMind.memory_abuse_txt[idx]
	string txt_title = TitleTextSlaveAbuse(idx, akActor, false, false) ; no caps, no comma
	string poseId = akMind.memory_abuse_reason[idx]
	string the_pose
	if poseID == "99"
		the_pose = "pose holding a torch"
	elseif poseId == "100"
		the_pose = "dance"
	elseif poseId == "101"
		the_pose = "play music"
	elseif poseId == "102"
		the_pose = "stand still with a cute pose"
	elseif poseId == "110"
		the_pose = "stand still showing my breasts"
	elseif poseId == "111"
		the_pose = "stand still moving my ass"
	elseif poseId == "112"
		if (akActor.actorSex %2) == 1
			the_pose = "stand still while presenting my pussy"
		else
			the_pose = "stand still while presenting my crotch "
		endif
	elseif poseId == "113"
		the_pose = "stand still with a sexy pose"
	elseif poseId == "20"
		the_pose = "serve drinks like  a tavern whore"
	elseif poseId == "21"
		the_pose = "hold flowers like I am a stupid vase"
	elseif poseId == "30"
		the_pose = "get on my fours and serve as a living chair"
	elseif poseId == "10"
		the_pose = "stand still with a respectful pose"
	else
		the_pose = "stand still with a weird pose"
	endif
	txt = " I was forced to "+the_pose
	int ntimes = akMind.memory_abuse_ntimes[idx]
	if ntimes > 1
		if ntimes > 3
			txt += ", many times"
		elseif ntimes > 2
			txt += ", three times"
		else
			txt += ", twice"
		endif
	endif
	txt += " by "+txt_title+"."
	akMind.memory_abuse_txt[idx] = txt
	;LogTrace("SetTextSlavePose idx="+idx+" "+akActor.GetName()+" "+akMind.memory_abuse_txt[idx])
EndFunction

Function SetTextSlaveCombat(int idx, DOM_Actor akActor)
	;LogTrace("SetTextSlaveCombat "+idx+" "+akActor.GetName())
	if idx < 0
		return
	endif
	if akActor == None
		return
	endif
	DOM_Mind akMind = akActor.mind
	if akMind == None
		return
	endif

	bool has_caps = StartTextSlaveAbuse(idx, akActor, false) ; not aggressive event
	string txt = akMind.memory_abuse_txt[idx]
	if akMind.memory_abuse_reason[idx] == "fight"
		txt += " I was asked to fight for "+DOMPlayerAlias.GetPlayerTitleIfRespectful(akMind.memory_abuse_respectful[idx])+". At least it could mean I get to have my weapons and armor back."
	else
		txt += " I was asked to not fight for "+DOMPlayerAlias.GetPlayerTitleIfRespectful(akMind.memory_abuse_respectful[idx])+". Did I do something wrong?"
	endif
	akMind.memory_abuse_txt[idx] = txt
	;LogTrace("SetTextSlaveCombat idx="+idx+" "+akActor.GetName()+" "+akMind.memory_abuse_txt[idx])
EndFunction

Function SetTextSlaveTrainingStatusUpdate(int idx, DOM_Actor akActor)
	;LogTrace("SetTextSlaveTrainingStatusUpdate "+idx+" "+akActor.GetName())
	if idx < 0
		return
	endif
	if akActor == None
		return
	endif
	DOM_Mind akMind = akActor.mind
	if akMind == None
		return
	endif
	; Current event
	string txt
	string title = DOMPlayerAlias.GetPlayerTitleIfRespectful(akMind.memory_abuse_respectful[idx])
	float time = akMind.memory_abuse_time[idx]
	string loc = akMind.memory_abuse_location[idx]
	string the_level = akMind.memory_abuse_type[idx]
	txt = " On "+GameTimeToString(time)+" while I was in "+loc+", I felt I had to adapt to my new situation."
	int n = akMind.GetNumberOfHiddenKinks()
	if n <= 0
		if !akMind.memory_abuse_flag[idx] ; not devoted & slave
			txt += " I am strong and pure. There is still hope, even though I feel "+the_level+"."
		else
			txt += " This experience will prove to be good for me and I feel "+the_level+"."
		endif
	else
		int ikink = akMind.GetAnyHiddenKink()
		if ikink < 0
			if !akMind.memory_abuse_flag[idx] ; not devoted & slave
				txt += " I need to find a way out, even though I feel "+the_level+"."
			else
				txt += " I learned a lot about myself, and now I feel "+the_level+"."
			endif
		else	
			string kink_name = DOMCore.GetJSONKinkReasonNameByIndex(ikink,akActor.actorSex)
			if !akMind.memory_abuse_flag[idx] ; not devoted & slave
				txt += " I feel "+the_level+" and I know it could get worse..."
				txt += " Imagine what would happen if this "+DOMPlayerAlias.playerBadName+" discovers my kink for "+kink_name+"!"
			else
				txt += " I feel weirdly "+the_level+"..."
				txt += " I really wish "+DOMPlayerAlias.GetPlayerTitleIfRespectful(akMind.memory_abuse_respectful[idx])+" would discover my kink for "+kink_name+"!"
			endif
		endif
	endif
	
	akMind.memory_abuse_txt[idx] = txt
	;LogTrace("SetTextSlaveTrainingStatusUpdate idx="+idx+" "+akActor.GetName()+" "+akMind.memory_abuse_txt[idx])
EndFunction

Function SetTextSlaveAshamed(int idx, DOM_Actor akActor)
	;LogTrace("SetTextSlaveAshamed "+idx+" "+akActor.GetName())
	if idx < 0
		return
	endif
	if akActor == None
		return
	endif
	DOM_Mind akMind = akActor.mind
	if akMind == None
		return
	endif
	; Current event
	string txt
	string title = DOMPlayerAlias.GetPlayerTitleIfRespectful(akMind.memory_abuse_respectful[idx])
	float time = akMind.memory_abuse_time[idx]
	string loc = akMind.memory_abuse_location[idx]
	txt = " On "+GameTimeToString(time)+" while I was in "+loc+", I suddenly felt so ashamed about this whole situation."
	int n = akMind.GetNumberOfHiddenKinks()
	if n <= 0
		txt += " But there is no reason why I should be ashamed of myself."
		if akActor.actorSex == 1
			Actorbase abTarget = akActor.akRef.GetLeveledActorBase()
			Race ActorRace     = abTarget.GetRace()
			string raceString  = ActorRace.GetName()
			txt += " Afterall, I am a strong and confident "+raceString+" woman!"
		else
			txt += " I am void of any impure thoughts."
		endif
	else
		int ikink = akMind.GetAnyHiddenKink()
		if ikink < 0
			if !akMind.memory_abuse_flag[idx] ; not devoted & slave
				txt += " It couldn't be worse, now this "+DOMPlayerAlias.playerBadName+" knows everything about my kinks!"
			else
				txt += " It couldn't be better, "+DOMPlayerAlias.GetPlayerTitleIfRespectful(akMind.memory_abuse_respectful[idx])+" knows everything about my kinks!"
			endif
		else	
			string kink_name = DOMCore.GetJSONKinkReasonNameByIndex(ikink,akActor.actorSex)
			if !akMind.memory_abuse_flag[idx] ; not devoted & slave
				txt += " I know it could get worse..."
				txt += " Imagine what would happen if this "+DOMPlayerAlias.playerBadName+" discovers my kink for "+kink_name+"!"
			else
				txt += " This is interesting..."
				txt += " I wish "+DOMPlayerAlias.GetPlayerTitleIfRespectful(akMind.memory_abuse_respectful[idx])+" would discover my kink for "+kink_name+"!"
			endif
		endif
	endif
	
	akMind.memory_abuse_txt[idx] = txt
	;LogTrace("SetTextSlaveAshamed idx="+idx+" "+akActor.GetName()+" "+akMind.memory_abuse_txt[idx])
EndFunction

Function SetTextSlaveDrunk(int idx, DOM_Actor akActor)
	;LogTrace("SetTextSlaveDrunk "+idx+" "+akActor.GetName())
	if idx < 0
		return
	endif
	if akActor == None
		return
	endif
	DOM_Mind akMind = akActor.mind
	if akMind == None
		return
	endif
	; Current event
	string txt
	string title = DOMPlayerAlias.GetPlayerTitleIfRespectful(akMind.memory_abuse_respectful[idx])
	float time = akMind.memory_abuse_time[idx]
	string loc = akMind.memory_abuse_location[idx]
	string type = akMind.memory_abuse_type[idx]
	string reason = akMind.memory_abuse_reason[idx]
	int mood = akMind.memory_abuse_mood[idx]
	bool was_passedout = akMind.memory_abuse_flag[idx]
	txt = " On "+GameTimeToString(time)
	if reason == "wasted"
		txt += " I somehow got to drink more than I can admit, I was so wasted"
		if was_passedout
			txt += " I couldn't feel my legs anymore. So I decided to lay down, and after that everything went black."
		else
			txt += " I could barely hold myself together. I don't remember what happened after that, but I don't think I passed out."
		endif
	elseif reason == "smashed"
		txt += " I was forced to drink more than my usual, I was really smashed"
		int ikink = akMind.GetAnyHiddenKink()
		if ikink >= 0
			string kink_name = DOMCore.GetJSONKinkReasonNameByIndex(ikink,akActor.actorSex)
			txt += " I don't remember exactly what I said, but hopefully I didn't say anything about my kink for "+kink_name+"."
		else
			txt += " I don't remember exactly what I said, but hopefully I didn't say anything I should be ashamed of."
		endif
	else
		txt += " I was forced to drink and I definetely felt a bit more than tipsy."
		int ntimes = akMind.memory_abuse_ntimes[idx]
		if ntimes > 1
			txt += " Nothing to worry about, but it's not the first time and I might not be able to deal with it much longer."
		else
			txt += " Nothing to worry about, but I hope I will be able to hold myself together if it happens again."
		endif
	endif
	
	akMind.memory_abuse_txt[idx] = txt
	;LogTrace("SetTextSlaveDrunk idx="+idx+" "+akActor.GetName()+" "+akMind.memory_abuse_txt[idx])
EndFunction

Function SetTextSlaveSilent(int idx, DOM_Actor akActor)
	;LogTrace("SetTextSlaveSilent "+idx+" "+akActor.GetName())
	if idx < 0
		return
	endif
	if akActor == None
		return
	endif
	DOM_Mind akMind = akActor.mind
	if akMind == None
		return
	endif
	; Current event
	string txt
	string title = DOMPlayerAlias.GetPlayerTitleIfRespectful(akMind.memory_abuse_respectful[idx])
	float time = akMind.memory_abuse_time[idx]
	string loc = akMind.memory_abuse_location[idx]
	string type = akMind.memory_abuse_type[idx]
	string reason = akMind.memory_abuse_reason[idx]
	int mood = akMind.memory_abuse_mood[idx]
	txt = " On "+GameTimeToString(time)
	if akMind.memory_abuse_flag[idx]
		txt += " "+title+" told me to be silent."
	else
		txt += " "+title+" told me I was now allowed to speak again."
	endif
	
	akMind.memory_abuse_txt[idx] = txt
	;LogTrace("SetTextSlaveSilent idx="+idx+" "+akActor.GetName()+" "+akMind.memory_abuse_txt[idx])
EndFunction

Function SetTextSlaveRespect(int idx, DOM_Actor akActor)
	;LogTrace("SetTextSlaveRespect "+idx+" "+akActor.GetName())
	if idx < 0
		return
	endif
	if akActor == None
		return
	endif
	DOM_Mind akMind = akActor.mind
	if akMind == None
		return
	endif
	; Current event
	string txt
	string title = DOMPlayerAlias.GetPlayerTitleIfRespectful(akMind.memory_abuse_respectful[idx])
	float time = akMind.memory_abuse_time[idx]
	string loc = akMind.memory_abuse_location[idx]
	string type = akMind.memory_abuse_type[idx]
	string reason = akMind.memory_abuse_reason[idx]
	int mood = akMind.memory_abuse_mood[idx]
	bool was_passedout = akMind.memory_abuse_flag[idx]
	txt = " On "+GameTimeToString(time)
	if akMind.memory_abuse_flag[idx]
		txt += " "+title+" told me to be respectful."
	else
		txt += " "+title+" told me I was now allowed to address "+DOMPlayerAlias.GetPlayerObjective()+" as I want."
	endif
	
	akMind.memory_abuse_txt[idx] = txt
	;LogTrace("SetTextSlaveRespect idx="+idx+" "+akActor.GetName()+" "+akMind.memory_abuse_txt[idx])
EndFunction

Function SetTextSlaveWalkOnFour(int idx, DOM_Actor akActor)
	;LogTrace("SetTextSlaveWalkOnFour "+idx+" "+akActor.GetName())
	if idx < 0
		return
	endif
	if akActor == None
		return
	endif
	DOM_Mind akMind = akActor.mind
	if akMind == None
		return
	endif
	; Current event
	string txt
	string title = DOMPlayerAlias.GetPlayerTitleIfRespectful(akMind.memory_abuse_respectful[idx])
	float time = akMind.memory_abuse_time[idx]
	string loc = akMind.memory_abuse_location[idx]
	string type = akMind.memory_abuse_type[idx]
	string reason = akMind.memory_abuse_reason[idx]
	int mood = akMind.memory_abuse_mood[idx]
	txt = " On "+GameTimeToString(time)
	if akMind.memory_abuse_flag[idx]
		txt += " "+title+" told me to be walk like a dog."
	else
		txt += " "+title+" told me I was now allowed to walk as a human being."
	endif
	
	akMind.memory_abuse_txt[idx] = txt
	;LogTrace("SetTextSlaveWalkOnFour idx="+idx+" "+akActor.GetName()+" "+akMind.memory_abuse_txt[idx])
EndFunction


Function SetTextSlaveDrugged(int idx, DOM_Actor akActor)
	;LogTrace("SetTextSlaveDrugged "+idx+" "+akActor.GetName())
	if idx < 0
		return
	endif
	if akActor == None
		return
	endif
	DOM_Mind akMind = akActor.mind
	if akMind == None
		return
	endif
	; Current event
	string txt
	string title = DOMPlayerAlias.GetPlayerTitleIfRespectful(akMind.memory_abuse_respectful[idx])
	float time = akMind.memory_abuse_time[idx]
	string loc = akMind.memory_abuse_location[idx]
	string type = akMind.memory_abuse_type[idx]
	int mood = akMind.memory_abuse_mood[idx]
	bool was_passedout = akMind.memory_abuse_flag[idx]
	txt = " On "+GameTimeToString(time)
	Actorbase abTarget = akActor.akRef.GetLeveledActorBase()
	Race ActorRace  = abTarget.GetRace()
	string raceString = ActorRace.GetName()+" "+MiscUtil.GetRaceEditorID(ActorRace)
	if stringUtil.find(raceString,"Khajiit")>=0
		if was_passedout
			txt += " "+title+" gave me a lot of "+type+". I don't really remember what happened next."
		else
			txt += " "+title+" gave me some "+type+". It was soothing."
		endif
	else
		if was_passedout
			txt += " "+title+" forced me to take a lot of "+type+". I don't really remember what happened next."
		else
			txt += " "+title+" forced me to take "+type+". It was weird."
		endif
	endif
	
	akMind.memory_abuse_txt[idx] = txt
	;LogTrace("SetTextSlaveDrugged idx="+idx+" "+akActor.GetName()+" "+akMind.memory_abuse_txt[idx])
EndFunction

Function SetTextSlaveAddicted(int idx, DOM_Actor akActor)
	;LogTrace("SetTextSlaveAddicted "+idx+" "+akActor.GetName())
	if idx < 0
		return
	endif
	if akActor == None
		return
	endif
	DOM_Mind akMind = akActor.mind
	if akMind == None
		return
	endif
	; Current event
	string txt
	float time = akMind.memory_abuse_time[idx]
	string loc = akMind.memory_abuse_location[idx]
	string type = akMind.memory_abuse_type[idx]
	int mood = akMind.memory_abuse_mood[idx]
	bool was_passedout = akMind.memory_abuse_flag[idx]
	txt = " On "+GameTimeToString(time)
	Actorbase abTarget = akActor.akRef.GetLeveledActorBase()
	Race ActorRace  = abTarget.GetRace()
	string raceString = ActorRace.GetName()+" "+MiscUtil.GetRaceEditorID(ActorRace)
	if stringUtil.find(raceString,"Khajiit")>=0
		if was_passedout
			txt += " I had so much "+type+", Sheggorath reached out to me and congratulated me for my achievements."
		else
			txt += " I had a bit of "+type+", I wish I could have more, Khajiit needs to pray Sheggorath for more "+type+"."
		endif
	else
		if was_passedout
			txt += " I think I had a little bit too much "+type+", and completely lost track of reality. I must have more soon."
		else
			txt += " I had a bit of "+type+", just a tiny bit. It felt great."
		endif
	endif
	
	akMind.memory_abuse_txt[idx] = txt
	;LogTrace("SetTextSlaveAddicted idx="+idx+" "+akActor.GetName()+" "+akMind.memory_abuse_txt[idx])
EndFunction

Function SetTextSlaveOrgasmControl(int idx, DOM_Actor akActor)
	;LogTrace("SetTextSlaveOrgasmControl "+idx+" "+akActor.GetName())
	if idx < 0
		return
	endif
	if akActor == None
		return
	endif
	DOM_Mind akMind = akActor.mind
	if akMind == None
		return
	endif
	; Current event
	string txt
	string title = DOMPlayerAlias.GetPlayerTitleIfRespectful(akMind.memory_abuse_respectful[idx])
	float time = akMind.memory_abuse_time[idx]
	string loc = akMind.memory_abuse_location[idx]
	string type = akMind.memory_abuse_type[idx]
	string reason = akMind.memory_abuse_reason[idx]
	int mood = akMind.memory_abuse_mood[idx]
	bool was_passedout = akMind.memory_abuse_flag[idx]
	txt = " On "+GameTimeToString(time)
	if akMind.memory_abuse_flag[idx]
		txt += " "+title+" told me I was now subject to orgasm control."
	else
		txt += " "+title+" told me I was now allowed to orgasm as I wished."
	endif
	
	akMind.memory_abuse_txt[idx] = txt
	;LogTrace("SetTextSlaveOrgasmControl idx="+idx+" "+akActor.GetName()+" "+akMind.memory_abuse_txt[idx])
EndFunction

Function SetTextSlaveOrgasm(int idx, DOM_Actor akActor)
	;LogTrace("SetTextSlaveOrgasm "+idx+" "+akActor.GetName())
	if idx < 0
		return
	endif
	if akActor == None
		return
	endif
	DOM_Mind akMind = akActor.mind
	if akMind == None
		return
	endif
	; Current event
	string txt
	string title = DOMPlayerAlias.GetPlayerTitleIfRespectful(akMind.memory_abuse_respectful[idx])
	float time = akMind.memory_abuse_time[idx]
	string loc = akMind.memory_abuse_location[idx]
	string type = akMind.memory_abuse_type[idx]
	string reason = akMind.memory_abuse_reason[idx]
	int mood = akMind.memory_abuse_mood[idx]
	bool was_consensual = akMind.memory_abuse_flag[idx]
	if type == "rape"
		txt = " On "+GameTimeToString(time)+" while I was being raped, a wave of pleasure came over me. It was so strong I couldn't help it!"
	elseif type == "masturbate"
		txt = " On "+GameTimeToString(time)+" while I was masturbating, a wave of pleasure came over me. It was so strong I couldn't help it!"
	else
		txt = " On "+GameTimeToString(time)+" while I was "+type+"d, a wave of pleasure came over me. It was so strong I couldn't help it!"
	endif
	if reason != ""
		txt += "Apparently I "+reason
		if mood > 10 && mood < 18
			if reason == "was not allowed to orgasm"
				txt += ". Oops!"
			else
				txt += ". Thank you "+DOMPlayerAlias.GetPlayerTitle()+"!"
			endif
		else
			if reason == "was not allowed to orgasm"
				txt += ". So, it was my own choice afterall."
			else
				txt += ". I am so angry at myself, I couldn't hold it in."
			endif
		endif
	endif
	int n = akMind.GetNumberOfHiddenKinks()
	if n <= 0
		txt += " I wish I could control my body next time."
		if akActor.actorSex == 1
			Actorbase abTarget = akActor.akRef.GetLeveledActorBase()
			Race ActorRace     = abTarget.GetRace()
			string raceString  = ActorRace.GetName()
			txt += " Afterall, I am a strong and confident "+raceString+" woman!"
		else
			txt += " It should be easy, as I am void of any impure thoughts."
		endif
	else
		int ikink = akMind.GetAnyHiddenKink()
		if ikink < 0
			if !akMind.memory_abuse_flag[idx] ; non consensual & slave
				txt += " I sincerely wish this "+DOMPlayerAlias.playerBadName+" didn't know everything about my kinks!"
			else
				txt += " Everything got more interesting now that "+DOMPlayerAlias.GetPlayerTitle()+" knows everything about my kinks!"
			endif
		else	
			string kink_name = DOMCore.GetJSONKinkReasonNameByIndex(ikink,akActor.actorSex)
			if !akMind.memory_abuse_flag[idx] ; not consensual & slave
				txt += " I got so excited, I couldn't help but think about my kink for "+kink_name+"!"
			else
				txt += " This is interesting..."
				txt += " Maybe I should talk to "+DOMPlayerAlias.GetPlayerTitle()+" about my kink for "+kink_name+"!"
			endif
		endif
	endif
	
	akMind.memory_abuse_txt[idx] = txt
	;LogTrace("SetTextSlaveOrgasm idx="+idx+" "+akActor.GetName()+" "+akMind.memory_abuse_txt[idx])
EndFunction

Function SetTextSlaveShock(int idx, DOM_Actor akActor)
	;LogTrace("SetTextSlaveShock "+idx+" "+akActor.GetName())
	if idx < 0
		return
	endif
	if akActor == None
		return
	endif
	DOM_Mind akMind = akActor.mind
	if akMind == None
		return
	endif
	; Current event
	string txt
	string title = DOMPlayerAlias.GetPlayerTitleIfRespectful(akMind.memory_abuse_respectful[idx])
	float time = akMind.memory_abuse_time[idx]
	string loc = akMind.memory_abuse_location[idx]
	txt = " On "+GameTimeToString(time)+" while I was in "+loc
	if  RandomFloat()*200.0 < akMind.HEXACO_Agreeableness
		txt += " I just stopped listening to all the shouting and crying. It was just so unbreable, I believe I stopped thinking."
	elseif RandomFloat()*200.0 < akMind.HEXACO_eXtraversion
		txt += " I don't know what happenned to me, I became all crying and stopped talking completely. This is so not me, I hope nothing is broken in my brain."
	elseif RandomFloat()*200.0 < akMind.HEXACO_Emotionality
		txt += " everything became so overwhelming, I couldn't stop crying to the point where, all I could think about was how this is so sad and how much I want to cry."
	elseif RandomFloat()*200.0 < akMind.HEXACO_Conscientiousness
		txt += " my whole world collapsed. Nothing is ever going to be like before. I am doomed."
	elseif RandomFloat()*200.0 < akMind.HEXACO_Honesty
		txt += " I realized this world is crazy, and I think I am becoming crazy myself. How can someone inflict so much pain to others?"
	elseif RandomFloat()*200.0 < akMind.HEXACO_Openness
		txt += " my mind decided to stop processing. "
	elseif RandomFloat()*200.0 < akMind.FACET_Sensuality
		txt += " all the beating and abuse finally got the better of me. I lost control of my mind, shutdown all lights and stopped thinking."
	elseif RandomFloat()*200.0 < akMind.FACET_Submissivity
		txt += " my body took control of my brain. I turned into a mindless doll, stupidely begging for more beating and abuse."
	elseif RandomFloat()*200.0 < akMind.FACET_Boldness
		txt += " it was so hard for me to admit I couldn't endure more of this abuse. But once I accepted it, the pain suddenly disappeared."
	elseif RandomFloat()*200.0 < akMind.FACET_Wilfulness
		txt += " I just needed to go deep into myself to recover. I know I will find the strength to fight for my freedom, this is not even a setback."
	elseif RandomFloat()*200.0 < akMind.FACET_Toughness
		txt += " I realized sometimes the mind needs to take a break. This is what happened to me today, just a small tiny momentary lapse of reason."
	elseif RandomFloat()*200.0 < akMind.FACET_Smartness
		txt += " my mind just disconnected. Sometimes the brain just shutdown, I guess that's what happened today."
	else
		txt += " everything suddenly became dark. I could feel my eyes were still open, but I could see anything, I couldn't hear and couldn't feel anything neither."
	endif

	akMind.memory_abuse_txt[idx] = txt
	;LogTrace("SetTextSlaveShock idx="+idx+" "+akActor.GetName()+" "+akMind.memory_abuse_txt[idx])
EndFunction

Function SetTextSlaveBroken(int idx, DOM_Actor akActor)
	;LogTrace("SetTextSlaveBroken "+idx+" "+akActor.GetName())
	if idx < 0
		return
	endif
	if akActor == None
		return
	endif
	DOM_Mind akMind = akActor.mind
	if akMind == None
		return
	endif
	; Current event
	string txt
	float time = akMind.memory_abuse_time[idx]
	string loc = akMind.memory_abuse_location[idx]
	txt = " On "+GameTimeToString(time)+" while I was in "+loc
	if  RandomFloat()*200.0 < akMind.HEXACO_Agreeableness
		txt += " I realized, this is my life now, to serve and be used."
	elseif RandomFloat()*200.0 < akMind.HEXACO_eXtraversion
		txt += " I did everything as ordered. My mind says no, but my body does it anyway."
	elseif RandomFloat()*200.0 < akMind.HEXACO_Emotionality
		txt += " I managed to stop crying today. I think I just had to accept, this is my fate, I am doomed to be a slave."
	elseif RandomFloat()*200.0 < akMind.HEXACO_Conscientiousness
		txt += " I could not help but act like a slave. Yes "+DOMPlayerAlias.GetPlayerTitle()+"! I am at your service "+DOMPlayerAlias.GetPlayerTitle()+"! It seems there is no point fighting it anymore."
	elseif RandomFloat()*200.0 < akMind.HEXACO_Honesty
		txt += " I did what "+DOMPlayerAlias.GetPlayerTitleIfRespectful(akMind.memory_abuse_respectful[idx])+" told me to do. With tears in my eyes, I realized I would never escape this nightmare."
	elseif RandomFloat()*200.0 < akMind.HEXACO_Openness
		txt += " it became all clear to me, there will never be an end to the beating and abuse, unless I do as I am told."
	elseif RandomFloat()*200.0 < akMind.FACET_Sensuality
		txt += " I could not control my body anymore. The truth is "+DOMPlayerAlias.GetPlayerTitleIfRespectful(akMind.memory_abuse_respectful[idx])+" is totally in control of my senses and emotions. I am hopeless."
	elseif RandomFloat()*200.0 < akMind.FACET_Submissivity
		if (akActor.actorSex %2 ) == 1
			txt += " I finally admitted it! Yes, I admit the discipline is hitting me in the right spot. At this very moment, realizing I am a slave made me wet myself."
		else
			txt += " I finally admitted it! Yes, I admit the discipline is hitting me in the right spot. At this very moment, realizing I am a slave made me hard."
		endif
	elseif RandomFloat()*50.0 > akMind.FACET_Submissivity
		txt += " I must admit there can be only one "+DOMPlayerAlias.GetPlayerTitle()
		txt += ". I just hope "+DOMPlayerAlias.GetPlayerPronoun()+" will allow me to take out my anger on the other slaves!"
	elseif RandomFloat()*200.0 < akMind.FACET_Boldness
		txt += " I realized if I want to survive, I just have to accept my fate, for now..."
	elseif RandomFloat()*200.0 < akMind.FACET_Wilfulness
		txt += " I recognized just have to hope someone will come and rescue me, because my will is completely broken."
	elseif RandomFloat()*200.0 < akMind.FACET_Toughness
		txt += " I found my match. I give up, "+DOMPlayerAlias.GetPlayerTitleIfRespectful(akMind.memory_abuse_respectful[idx])+" managed to tamed me. I tried hard but I could not take it anymore."
	elseif RandomFloat()*200.0 < akMind.FACET_Smartness
		txt += " I thought I should be like the reed and bend as much as I can to avoid breaking completely."
	else
		txt += " I fully embraced my condition as a slave. I am now nothing more than a merchandise. This is so sad, I couldn't stop crying!"
	endif

	akMind.memory_abuse_txt[idx] = txt
	;LogTrace("SetTextSlaveInlove idx="+idx+" "+akActor.GetName()+" "+akMind.memory_abuse_txt[idx])
EndFunction

Function SetTextSlaveInlove(int idx, DOM_Actor akActor)
	;LogTrace("SetTextSlaveInlove "+idx+" "+akActor.GetName())
	if idx < 0
		return
	endif
	if akActor == None
		return
	endif
	DOM_Mind akMind = akActor.mind
	if akMind == None
		return
	endif
	; Current event
	string txt
	if  RandomFloat()*200.0 < akMind.HEXACO_Agreeableness
		txt = DOMPlayerAlias.GetPlayerTitle()+" has been hard on me, but I must admit, I am not that easy. "
		txt += "I start to understand what this is all about. It's about me learning my place"
		txt += " and taking care of my beloved "+DOMPlayerAlias.GetPlayerTitle()+"."
	elseif RandomFloat()*200.0 < akMind.HEXACO_eXtraversion
		txt = "Love! Love is everywhere and I am but a vessel for true love to be delivered to the praiseworthy. "
		txt += DOMPlayerAlias.GetPlayerTitle()+" has proven "+DOMPlayerAlias.GetPlayerPronoun()+" "+DOMPlayerAlias.GetPlayerBeVerb()+" the chosen one. "+DOMPlayerAlias.GetPlayerPronoun()+" has been chosen by Dibella herself."
		txt += " My destiny is to serve "+DOMPlayerAlias.GetPlayerObjective()+" and shower "+DOMPlayerAlias.GetPlayerObjective()+" with love!"
	elseif RandomFloat()*200.0 < akMind.HEXACO_Emotionality
		txt = "I am so in love, I am so happy I found my soul mate. "
		txt += "If only "+DOMPlayerAlias.GetPlayerTitle()+" would see me. I truly hope "+DOMPlayerAlias.GetPlayerPronoun()+" has feelings for me!"
		txt += " "+DOMPlayerAlias.GetPlayerPronoun()+" "+DOMPlayerAlias.GetPlayerBeVerb()+" my reason to live, "+DOMPlayerAlias.GetPlayerPronoun()+" "+DOMPlayerAlias.GetPlayerBeVerb()+" the one and only one."
	elseif RandomFloat()*200.0 < akMind.HEXACO_Conscientiousness
		txt = DOMPlayerAlias.GetPlayerTitle()+" is everything to me."
		txt += " "+DOMPlayerAlias.GetPlayerPossessive()+" orders are my desires, "+DOMPlayerAlias.GetPlayerPossessive()+" slaps are my rewards, "+DOMPlayerAlias.GetPlayerPossessive()+" words are my food."
		txt += " I am "+DOMPlayerAlias.GetPlayerPossessive()+" slave and that is all I have ever wished for."
	elseif RandomFloat()*200.0 < akMind.HEXACO_Honesty
		txt ="The best love makes us reach for more and ultimately makes us a better person."
		txt += " The best love is the fire I feel in my heart for "+DOMPlayerAlias.GetPlayerTitle()+". "
		txt += " Only "+DOMPlayerAlias.GetPlayerObjective()+" can put it out, and even so it will rise again from its ashes and will burn over and over again."
	elseif RandomFloat()*200.0 < akMind.HEXACO_Openness
		txt ="I know "+DOMPlayerAlias.GetPlayerTitle()+" is perfect, and I love "+DOMPlayerAlias.GetPlayerObjective()+"."
		txt +=" Then I realized "+DOMPlayerAlias.GetPlayerPronoun()+" was not so perfect, and I loved "+DOMPlayerAlias.GetPlayerObjective()+" even more."
		txt +=" Whatever happen, I would choose "+DOMPlayerAlias.GetPlayerObjective()+" and I will choose "+DOMPlayerAlias.GetPlayerObjective()+" over and over and over."
	elseif RandomFloat()*200.0 < akMind.FACET_Sensuality
		txt = "I would give anything to feel "+DOMPlayerAlias.GetPlayerPossessive()+" touch, to feel "+DOMPlayerAlias.GetPlayerPossessive()+" hands on me. "
		txt += "Please Dibella, I pray to you, make "+DOMPlayerAlias.GetPlayerTitle()+" burn with desire for me. "
		txt += "I promise I will worship you, almost as much as I worship "+DOMPlayerAlias.GetPlayerObjective()+", for the rest of my life."
	elseif RandomFloat()*200.0 < akMind.FACET_Submissivity
		txt = "I have only one wish, and that is to be with "+DOMPlayerAlias.GetPlayerTitle()+" forever. "
		txt += "I would do anything, yes really anything for "+DOMPlayerAlias.GetPlayerObjective()+", whatever the cost,"
		txt += " and I want "+DOMPlayerAlias.GetPlayerObjective()+" to punish me for that. I want "+DOMPlayerAlias.GetPlayerObjective()+" to use me in all possible ways!"
	elseif RandomFloat()*200.0 < akMind.FACET_Boldness
		txt = "I have only one wish, and that is to be with "+DOMPlayerAlias.GetPlayerTitle()+" forever. "
		txt += "I would do anything, yes really anything for "+DOMPlayerAlias.GetPlayerObjective()+"."
		txt += " Everybody hear me, "+DOMPlayerAlias.GetPlayerTitle()+" is the greatest. Anyone saying otherwise should be put to death."
	elseif RandomFloat()*200.0 < akMind.FACET_Wilfulness
		txt = "Sometimes the love of your life appears to you after the greatest mistake of your life. "
		txt += "I might have misjudged "+DOMPlayerAlias.GetPlayerTitle()+" and the daedra know I was amply punished for my mistake."
		txt += " Nevertheless, I will eagerly endure more punishment, for as long as I am with "+DOMPlayerAlias.GetPlayerObjective()+"."
	elseif RandomFloat()*200.0 < akMind.FACET_Toughness
		txt += "Today I realized someone needs me more than I had expected. "
		txt += DOMPlayerAlias.GetPlayerTitle()+" might seem tough but "+DOMPlayerAlias.GetPlayerPronoun()+" needs me to take care of "+DOMPlayerAlias.GetPlayerObjective()+"."
		txt += " Actually, it might be possible I need "+DOMPlayerAlias.GetPlayerObjective()+" just as much..."
	elseif RandomFloat()*200.0 < akMind.FACET_Smartness
		txt += "I must admit I didn't know what love was, before meeting "+DOMPlayerAlias.GetPlayerTitle()+"."
		txt += " Thanks to "+DOMPlayerAlias.GetPlayerTitle()+", now I know, and everyday I love "+DOMPlayerAlias.GetPlayerObjective()+" more, if that's even possible."
		txt += " It was a hard journey, but I finally understand my only purpose in life was to find "+DOMPlayerAlias.GetPlayerTitle()+" and cherish "+DOMPlayerAlias.GetPlayerObjective()+"."
	else
		txt += "My dear diary, today I found love! I have been looking for it for so long, "
		txt += " and it was right here in front of me. I thought it was fearsome and vicious."
		txt += " But fearsome and vicious was what I needed! "
		txt += " I can't wait to admit my love to "+DOMPlayerAlias.GetPlayerTitle()+". I hope "+DOMPlayerAlias.GetPlayerPronoun()+" will take me and keep me forever."
	endif

	akMind.memory_abuse_txt[idx] = txt
	;LogTrace("SetTextSlaveInlove idx="+idx+" "+akActor.GetName()+" "+akMind.memory_abuse_txt[idx])
EndFunction

Function SetTextSlaveFriendship(int idx,  DOM_Actor akActor)
	;LogTrace("SetTextSlaveFriendship "+idx+" "+akActor.GetName())
	if idx < 0
		return
	endif
	if akActor == None
		return
	endif
	DOM_Mind akMind = akActor.mind
	if akMind == None
		return
	endif
	int type = akMind.memory_abuse_level[idx]
	string txt
	bool is_female = akMind.memory_abuse_flag[idx] ; this is actually friend gender 
	if type == 0
		txt = "Today I befriended "+akMind.memory_abuse_type[idx]+"."
		if is_female
			txt += " I am so happy to be her friend."
		else
			txt += " I am so happy to be his friend."
		endif
		if RandomFloat()*50.0 > akMind.FACET_Boldness
			txt += " I am glad I found someone to share my fears with."
		elseif RandomFloat()*50.0 > akMind.HEXACO_Agreeableness
			txt += " This is much unlike me."
		elseif RandomFloat()*50.0 > akMind.HEXACO_eXtraversion
			txt += " At least someone gets me."
		else
			txt += " I am sure we will be able to support each others."
		endif
	else
		string rel = GetFriendshipString(akActor.akRef,type)
		txt = "Today I was reunited with my "+rel+" "+akMind.memory_abuse_type[idx]+"."
		if is_female
			txt += " I am so happy to be with her."
		else
			txt += " I am so happy to be with him."
		endif
		if RandomFloat()*50.0 > akMind.FACET_Boldness
			txt += " I am glad I have someone to share my fears with."
		elseif RandomFloat()*50.0 > akMind.HEXACO_Agreeableness
			txt += " I didn't think I would come to that."
		elseif RandomFloat()*50.0 > akMind.HEXACO_eXtraversion
			txt += " At least someone gets me."
		else
			txt += " I am sure we will be able to support each others."
		endif
	endif
	akMind.memory_abuse_txt[idx] = txt
	;LogTrace("SetTextSlaveFriendship idx="+idx+" "+akActor.GetName()+" "+akMind.memory_abuse_txt[idx])
EndFunction

Function SetTextSlaveLostFriendship(int idx, DOM_Actor akActor)
	;LogTrace("SetTextSlaveLostFriendship "+idx+" "+akActor.GetName())
	if idx < 0
		return
	endif
	if akActor == None
		return
	endif
	DOM_Mind akMind = akActor.mind
	if akMind == None
		return
	endif
	int type = akMind.memory_abuse_level[idx]
	string txt
	if type == 0
		txt = "On "+GameTimeToString(akMind.memory_abuse_time[idx])+" "+akMind.memory_abuse_type[idx]+" told me "+akMind.memory_abuse_reason[idx]+" is a better friend than me." 
	else
		string rel = GetFriendshipString(akActor.akRef,type)
		txt = "On "+GameTimeToString(akMind.memory_abuse_time[idx])+" "+akMind.memory_abuse_type[idx]+" told me "+akActor.actorPronoun+" needs to focus on "+akMind.memory_abuse_reason[idx]
	endif
	bool is_female = akMind.memory_abuse_flag[idx] ; this is actually friend gender 
	if is_female
		if type == 0
			txt += " So I am no longer her friend. Anyhow, I don't need her!"
		else
			txt += " I guess it means I will see her less often now."
		endif
	else
		if type == 0
			txt += " So I am no longer his friend. Anyhow, I don't need him!"
		else
			txt += " I guess it means I will see him less often now."
		endif
	endif
	akMind.memory_abuse_txt[idx] = txt
	;LogTrace("SetTextSlaveLostFriendship idx="+idx+" "+akActor.GetName()+" "+akMind.memory_abuse_txt[idx])
EndFunction

Function SetTextSlavePraise(int idx, DOM_Actor akActor)
	;LogTrace("SetTextSlavePraise "+idx+" "+akActor.GetName())
	if idx < 0
		return
	endif
	if akActor == None
		return
	endif
	DOM_Mind akMind = akActor.mind
	if akMind == None
		return
	endif
	
	; Current event
	int mood           = akMind.memory_abuse_mood[idx]
	int level          = akMind.memory_abuse_level[idx]
	; Previous event
	int prev_mood
	int prev_level
	if idx == 0
		prev_mood   = akMind.memory_capture_mood
		prev_level  = 0
	else
		int prev_idx = idx-(1)
		prev_mood   = akMind.memory_abuse_mood[prev_idx]
		prev_level  = akMind.memory_abuse_level[prev_idx]
	endif
	
	bool has_caps = StartTextSlaveAbuse(idx, akActor, false) ; not aggressive event
	string txt = akMind.memory_abuse_txt[idx]
	txt += TitleTextSlaveAbuse(idx, akActor, has_caps, true) ; needs comma 
	string type = akMind.memory_abuse_type[idx]
	string reason = akMind.memory_abuse_reason[idx]
	if type == "tell"
		if stringUtil.find(reason,"didnt")>=0
			txt += " praised me"
			int ntimes = akMind.memory_abuse_ntimes[idx]
			if ntimes > 1
				if ntimes > 3
					txt += ", many times"
				elseif ntimes > 2
					txt += ", three times"
				else
					txt += ", twice"
				endif
			endif
			txt += "because I "+reason+"."
		else
			txt += " praised me"
			int ntimes = akMind.memory_abuse_ntimes[idx]
			if ntimes > 1
				if ntimes > 3
					txt += ", many times"
				elseif ntimes > 2
					txt += ", three times"
				else
					txt += ", twice"
				endif
			endif
			txt += " for "+reason+"."
		endif
	else
		string type_text = DOMCore.GetJSONPraisingTypeTextByName(type)
		if stringUtil.find(reason,"didnt")>=0
			txt += " praised me "+type_text+" because I "+reason+"."
		else
			txt += " praised me "+type_text+" for "+reason+"."
		endif
	endif
	bool is_success = akMind.memory_abuse_flag[idx] ; this is actually praise success
	if is_success 
		if reason == "crying"
			if mood > 8 && mood < 14
				txt += " I am trying my best, I just don't know why it makes me so sad."		
			elseif mood > 13 && mood < 18
				txt += " I am trying my best to please my "+DOMPlayerAlias.GetPlayerTitle()+"!"		
			else
				txt += " What is that supposed to mean?"	
			endif
		elseif mood == 10 || mood == 18 ; angry, defiant
			txt += " I hate it when "+DOMPlayerAlias.GetPlayerPronoun()+" "+DOMPlayerAlias.GetPlayerBeVerb()+" right."
		elseif mood > 13 && mood < 18 ; in love
			txt += " I love it when "+DOMPlayerAlias.GetPlayerTitle()+" acknowledges me."
		elseif mood >= 9 && mood != 20 ; proud
			txt += " I guess "+DOMPlayerAlias.GetPlayerTitleIfRespectful(akMind.memory_abuse_respectful[idx])+" "+DOMPlayerAlias.GetPlayerBeVerb()+" not that bad after all."
		elseif akMind.HEXACO_Honesty > RandomFloat()*100.0
			txt += " I think there is hope, things have to get better."
		elseif akMind.HEXACO_Emotionality > RandomFloat()*100.0
			txt += " This is so confusing."
		elseif akMind.HEXACO_eXtraversion > RandomFloat()*100.0
			txt += " Maybe my charm starts to have an effect on "+DOMPlayerAlias.GetPlayerTitleIfRespectful(akMind.memory_abuse_respectful[idx])+"."
		elseif akMind.HEXACO_Agreeableness > RandomFloat()*100.0
			txt += " I am sure even the worse monster has a heart, somewhere."
		elseif akMind.HEXACO_Conscientiousness > RandomFloat()*100.0
			txt += " I hope "+DOMPlayerAlias.GetPlayerPronoun()+" sees, I am trying my best."
		elseif akMind.HEXACO_Openness > RandomFloat()*100.0
			txt += " I feel like "+DOMPlayerAlias.GetPlayerPronoun()+" "+DOMPlayerAlias.GetPlayerBeVerb()+" trying to mess with my head."
		endif
	else
		 txt += " What's that even supposed to mean?"
	endif
	if mood != 10 && mood != 11 && mood > 1 && mood != prev_mood
		txt += " It "+GetMoodSlaveText(mood)+"."
	elseif level != prev_level
		string the_level = GetTrainingStatusName(level)
		txt += " I felt completely "+the_level+"."
	endif
	akMind.memory_abuse_txt[idx] = txt
	;LogTrace("SetTextSlavePraise idx="+idx+" "+akActor.GetName()+" "+akMind.memory_abuse_txt[idx])
EndFunction

Function SetTextSlaveChat(int idx, DOM_Actor akActor)
	;LogTrace("SetTextSlaveChat "+idx+" "+akActor.GetName())
	if idx < 0
		return
	endif
	if akActor == None
		return
	endif
	DOM_Mind akMind = akActor.mind
	if akMind == None
		return
	endif
	
	; Current event
	int mood           = akMind.memory_abuse_mood[idx]
	int level          = akMind.memory_abuse_level[idx]
	; Previous event
	int prev_mood
	int prev_level
	if idx == 0
		prev_mood   = akMind.memory_capture_mood
		prev_level  = 0
	else
		int prev_idx = idx-(1)
		prev_mood   = akMind.memory_abuse_mood[prev_idx]
		prev_level  = akMind.memory_abuse_level[prev_idx]
	endif
	
	bool has_caps = StartTextSlaveAbuse(idx, akActor, false) ; not aggressive event
	string txt = akMind.memory_abuse_txt[idx]
	txt += TitleTextSlaveAbuse(idx, akActor, has_caps, true) ; needs comma 
	string type = akMind.memory_abuse_type[idx]
	string reason = akMind.memory_abuse_reason[idx]
	if type == "personality"
		txt += " asked me about myself"
		int ntimes = akMind.memory_abuse_ntimes[idx]
		if ntimes > 1
			if ntimes > 3
				txt += ", many times"
			elseif ntimes > 2
				txt += ", three times"
			else
				txt += ", twice"
			endif
		endif
	else ; feelings
		txt += " asked me about my feelings"
		int ntimes = akMind.memory_abuse_ntimes[idx]
		if ntimes > 1
			if ntimes > 3
				txt += ", many times"
			elseif ntimes > 2
				txt += ", three times"
			else
				txt += ", twice"
			endif
		endif
	endif
	bool is_success = akMind.memory_abuse_flag[idx] ; this is actually chat success
	if is_success 
		if mood == 10 || mood == 18 ; angry, defiant
			txt += " I guess at least, "+DOMPlayerAlias.GetPlayerPronoun()+" tries."
		elseif mood == 20 ; proud
			txt += " Maybe "+DOMPlayerAlias.GetPlayerTitleIfRespectful(akMind.memory_abuse_respectful[idx])+" "+DOMPlayerAlias.GetPlayerBeVerb()+" will realize "+DOMPlayerAlias.GetPlayerPossessive()+" mistake."
		elseif mood > 8 && mood < 14
			txt += " I guess it's nice "+DOMPlayerAlias.GetPlayerPronoun()+" tries."
		elseif mood > 13 && mood < 18 ; in love
			txt += " I am so happy "+DOMPlayerAlias.GetPlayerTitle()+" came to talk to me!"		
		elseif akMind.HEXACO_Honesty > RandomFloat()*100.0
			txt += " I am still not sure "+DOMPlayerAlias.GetPlayerPronoun()+" "+DOMPlayerAlias.GetPlayerHaveVerb()+" feelings of "+DOMPlayerAlias.GetPlayerPossessive()+" own."	
		elseif akMind.HEXACO_Emotionality > RandomFloat()*100.0
			txt += " I don't know why I got so emotional."
		elseif akMind.HEXACO_eXtraversion > RandomFloat()*100.0
			txt += " I think I can manage to charm "+DOMPlayerAlias.GetPlayerTitleIfRespectful(akMind.memory_abuse_respectful[idx])+"."
		elseif akMind.HEXACO_Agreeableness > RandomFloat()*100.0
			txt += " I knew there was something more to "+DOMPlayerAlias.GetPlayerObjective()+"."
		elseif akMind.HEXACO_Conscientiousness > RandomFloat()*100.0
			txt += " I hope "+DOMPlayerAlias.GetPlayerPronoun()+" finally sees, I am worth something."
		elseif akMind.HEXACO_Openness > RandomFloat()*100.0
			txt += " I am sure "+DOMPlayerAlias.GetPlayerPronoun()+" "+DOMPlayerAlias.GetPlayerBeVerb()+" will soon realize I'd more useful as a friend and free citizen."
		endif
	else
		if akMind.HEXACO_Honesty > RandomFloat()*100.0
			txt += " It's a first step toward redemption, but the trail is long for "+DOMPlayerAlias.GetPlayerObjective()+"."	
		elseif akMind.HEXACO_Emotionality > RandomFloat()*100.0
			txt += " I know "+DOMPlayerAlias.GetPlayerPronoun()+" "+DOMPlayerAlias.GetPlayerBeVerb()+" messing with my head, I hate it!"
		elseif akMind.HEXACO_eXtraversion > RandomFloat()*100.0
			txt += " I guess, I could use my charm to get a better treatment."
		elseif akMind.HEXACO_Agreeableness > RandomFloat()*100.0
			txt += " It's a small thing, but there is still hope in this world!"
		elseif akMind.HEXACO_Conscientiousness > RandomFloat()*100.0
			txt += " Let's see if those words are followed by actions."
		elseif akMind.HEXACO_Openness > RandomFloat()*100.0
			txt += " If "+DOMPlayerAlias.GetPlayerPronoun()+" wants to talk to me "+DOMPlayerAlias.GetPlayerPronoun()+" first needs to treat me as equal."
		else
			txt += " It's just words, I hate those pretenders."	
		endif
	endif
	if mood != 10 && mood != 11 && mood > 1 && mood != prev_mood
		txt += " It "+GetMoodSlaveText(mood)+"."
	elseif level != prev_level
		string the_level = GetTrainingStatusName(level)
		txt += " I felt completely "+the_level+"."
	endif
	akMind.memory_abuse_txt[idx] = txt
	;LogTrace("SetTextSlaveChat idx="+idx+" "+akActor.GetName()+" "+akMind.memory_abuse_txt[idx])
EndFunction

Function SetTextSlaveInsult(int idx, DOM_Actor akActor)
	;LogTrace("SetTextSlaveInsult "+idx+" "+akActor.GetName())
	if idx < 0
		return
	endif
	if akActor == None
		return
	endif
	DOM_Mind akMind = akActor.mind
	if akMind == None
		return
	endif
	
	; Current event
	int mood           = akMind.memory_abuse_mood[idx]
	int level          = akMind.memory_abuse_level[idx]
	; Previous event
	int prev_mood
	int prev_level
	if idx == 0
		prev_mood   = akMind.memory_capture_mood
		prev_level  = 0
	else
		int prev_idx = idx-(1)
		prev_mood   = akMind.memory_abuse_mood[prev_idx]
		prev_level  = akMind.memory_abuse_level[prev_idx]
	endif
	
	bool has_caps = StartTextSlaveAbuse(idx, akActor, false) ; not aggressive event
	string txt = akMind.memory_abuse_txt[idx]
	txt += TitleTextSlaveAbuse(idx, akActor, has_caps, true) ; needs comma 
	string reason = akMind.memory_abuse_reason[idx]
	if reason == "useless" || reason == "worthless"
		txt += " insulted me and told me I am "+reason+"."
	elseif reason == "disgrace"
		txt += " insulted me and called me a "+reason+"."
	else
		txt += " insulted me and told me "+reason+" words."
	endif
	int ntimes = akMind.memory_abuse_ntimes[idx]
	if ntimes > 1
		if ntimes > 3
			txt += " Many times in a row!"
		elseif ntimes > 2
			txt += " Three times, because who know, maybe I didn't get it the two first times?"
		else
			txt += " Twice, like one time was not enough."
		endif
	endif
	bool is_success = akMind.memory_abuse_flag[idx] ; this is actually insult success
	if is_success
		txt += " It was indeed hurtful. I guess I should try to work on my behaviour."
	else
		txt += " Does "+DOMPlayerAlias.GetPlayerPronoun()+" really think I care?"
	endif
	if mood != 10 && mood != 11 && mood > 1 && mood != prev_mood
		txt += " It "+GetMoodSlaveText(mood)+"."
	elseif level != prev_level
		string the_level = GetTrainingStatusName(level)
		txt += " I felt completely "+the_level+"."
	endif
	akMind.memory_abuse_txt[idx] = txt
	;LogTrace("SetTextSlaveInsult idx="+idx+" "+akActor.GetName()+" "+akMind.memory_abuse_txt[idx])
EndFunction

Function SetTextSlaveSalute(int idx, DOM_Actor akActor)
	;LogTrace("SetTextSlaveSalute "+idx+" "+akActor.GetName())
	if idx < 0
		return
	endif
	if akActor == None
		return
	endif
	DOM_Mind akMind = akActor.mind
	if akMind == None
		return
	endif
	
	; Current event
	int mood           = akMind.memory_abuse_mood[idx]
	int level          = akMind.memory_abuse_level[idx]
	; Previous event
	int prev_mood
	int prev_level
	if idx == 0
		prev_mood   = akMind.memory_capture_mood
		prev_level  = 0
	else
		int prev_idx = idx-(1)
		prev_mood   = akMind.memory_abuse_mood[prev_idx]
		prev_level  = akMind.memory_abuse_level[prev_idx]
	endif
	
	bool has_caps = StartTextSlaveAbuse(idx, akActor, false) ; not aggressive event
	string txt = akMind.memory_abuse_txt[idx]
	txt += TitleTextSlaveAbuse(idx, akActor, has_caps, true) ; needs comma 
	string type   = akMind.memory_abuse_type[idx]
	string reason = akMind.memory_abuse_reason[idx]
	if reason == "group"
		txt += " made all of us "+type+" in front of "+DOMPlayerAlias.GetPlayerObjective()+"."
	else
		txt += " made me "+type+" in front of "+DOMPlayerAlias.GetPlayerObjective()+"."
	endif
	bool is_success = akMind.memory_abuse_flag[idx] ; this is actually insult success
	if is_success
		txt += " I hope "+DOMPlayerAlias.GetPlayerPronoun()+" sees I am trying my best."
	else
		txt += " I made my point and refused to obey, "+DOMPlayerAlias.GetPlayerPronoun()+" didn't seem so please about that."
	endif
	int ntimes = akMind.memory_abuse_ntimes[idx]
	if ntimes > 1
		if ntimes > 3
			txt += " Not only once, but many times in a row!"
		elseif ntimes > 2
			txt += " Three times, because who know, maybe we didn't get it the two first times?"
		else
			txt += " Twice, like one time was not enough."
		endif
	endif
	if mood != 10 && mood != 11 && mood > 1 && mood != prev_mood
		txt += " It "+GetMoodSlaveText(mood)+"."
	elseif level != prev_level
		string the_level = GetTrainingStatusName(level)
		txt += " I felt completely "+the_level+"."
	endif
	akMind.memory_abuse_txt[idx] = txt
	;LogTrace("SetTextSlaveSalute idx="+idx+" "+akActor.GetName()+" "+akMind.memory_abuse_txt[idx])
EndFunction

Function SetTextSlaveFlatter(int idx, DOM_Actor akActor)
	;LogTrace("SetTextSlaveFlatter "+idx+" "+akActor.GetName())
	if idx < 0
		return
	endif
	if akActor == None
		return
	endif
	DOM_Mind akMind = akActor.mind
	if akMind == None
		return
	endif
	
	; Current event
	int mood           = akMind.memory_abuse_mood[idx]
	int level          = akMind.memory_abuse_level[idx]
	; Previous event
	int prev_mood
	int prev_level
	if idx == 0
		prev_mood   = akMind.memory_capture_mood
		prev_level  = 0
	else
		int prev_idx = idx-(1)
		prev_mood   = akMind.memory_abuse_mood[prev_idx]
		prev_level  = akMind.memory_abuse_level[prev_idx]
	endif
	
	bool has_caps = StartTextSlaveAbuse(idx, akActor, false) ; not aggressive event
	string txt = akMind.memory_abuse_txt[idx]
	txt += TitleTextSlaveAbuse(idx, akActor, has_caps, true) ; needs comma 
	string reason = akMind.memory_abuse_reason[idx]
	bool is_success = akMind.memory_abuse_flag[idx] ; this is actually flatter success
	if reason == "dirty" || reason == "sexy"
		txt += " flattered me using "+reason+" words."
		int ntimes = akMind.memory_abuse_ntimes[idx]
		if ntimes > 1
			if ntimes > 3
				txt += " Many times in a row!"
			elseif ntimes > 2
				txt += " Three times..."
			else
				txt += " Twice, I heard it the first time, but ok."
			endif
		endif
		if is_success
			txt += " That was a nice change. I guess I am not so worthless after all."
		else
			txt += " Who does "+DOMPlayerAlias.GetPlayerPronoun()+" think "+DOMPlayerAlias.GetPlayerPronoun()+" is?"
		endif			
	elseif reason == "romance"
		if is_success
			txt += " talked nice to me, it was pretty much romantic, I must admit."
		else
			txt += " talked about how cute I am and something about butterflies... What is wrong with this "+DOMPlayerAlias.playerNeutralName+"?"
		endif			
	else
		if is_success
			txt += " said I have been doing good recently. I hope it means things will get better for me in a very near future."
		else
			txt += " talked bullshit about me being good and what not. Does "+DOMPlayerAlias.GetPlayerPronoun()+" really think I am doing this willingly?"
		endif
	endif
	if mood != 10 && mood != 11 && mood > 1 && mood != prev_mood
		txt += " It "+GetMoodSlaveText(mood)+"."
	elseif level != prev_level
		string the_level = GetTrainingStatusName(level)
		txt += " I felt completely "+the_level+"."
	endif
	akMind.memory_abuse_txt[idx] = txt
	;LogTrace("SetTextSlaveFlatter idx="+idx+" "+akActor.GetName()+" "+akMind.memory_abuse_txt[idx])
EndFunction

Function SetTextSlaveComfort(int idx, DOM_Actor akActor)
	;LogTrace("SetTextSlaveComfort "+idx+" "+akActor.GetName())
	if idx < 0
		return
	endif
	if akActor == None
		return
	endif
	DOM_Mind akMind = akActor.mind
	if akMind == None
		return
	endif
	
	; Current event
	int mood           = akMind.memory_abuse_mood[idx]
	int level          = akMind.memory_abuse_level[idx]
	; Previous event
	int prev_mood
	int prev_level
	if idx == 0
		prev_mood   = akMind.memory_capture_mood
		prev_level  = 0
	else
		int prev_idx = idx-(1)
		prev_mood   = akMind.memory_abuse_mood[prev_idx]
		prev_level  = akMind.memory_abuse_level[prev_idx]
	endif
	
	bool has_caps = StartTextSlaveAbuse(idx, akActor, false) ; not aggressive event
	string txt = akMind.memory_abuse_txt[idx]
	string txt_title = TitleTextSlaveAbuse(idx, akActor, false, false) ; no caps no comma 
	string reason = akMind.memory_abuse_reason[idx]
	bool is_success = akMind.memory_abuse_flag[idx] ; this is actually comfort success
	txt += " I was so sad, tears started rolling down my cheeks."
	int ntimes = akMind.memory_abuse_ntimes[idx]
	if ntimes > 1
		txt += " Unfortunately, it has become a habit recently."
	endif
	if reason == "guilt"
		if is_success
			txt += " Then "+txt_title+" came to me and made me realize I can not blame anybody else but me."
			txt += DOMPlayerAlias.GetPlayerPronoun()+" "+DOMPlayerAlias.GetPlayerBeVerb()+" not completely wrong."
		else
			txt += " Then "+txt_title+" came to me and starts bullying me, telling me it's all my fault. How could it be my fault?"
			txt += " Of course it's "+DOMPlayerAlias.GetPlayerPossessive()+" fault!"
		endif			
	elseif reason == "insult"
		if is_success
			txt += " Then "+txt_title+" came and talked to me. The words were harsh and it was mean, but so true. I need to get my shit together and stop whining."
		else
			txt += " Then "+txt_title+" came and started to insult me."
			txt += " Does "+DOMPlayerAlias.GetPlayerPronoun()+" really think that's how you comfort someone?"
		endif			
	elseif reason == "threat"
		txt += " Then "+txt_title+" came and told me to stop whining or face the consequences."
		if is_success
			txt += " I wish I could stop. I promised "+DOMPlayerAlias.GetPlayerObjective()+" I will try."
		else
			txt += " What consequences? I don't think it can get worse than what it is!"
		endif			
	else ; if reason == "care"
		txt += " Then "+txt_title+" came to give me a hug."
		if is_success
			txt += " That was so cute, I really didn't expect "+DOMPlayerAlias.GetPlayerObjective()+" to care at all."
		else
			txt += " Of course I told "+DOMPlayerAlias.GetPlayerObjective()+" to go and penetrate "+DOMPlayerAlias.GetPlayerObjective()+"self anally with a splintered broom handle."
		endif			
	endif
	if mood != 10 && mood != 11 && mood > 1 && mood != prev_mood
		if is_success
			if mood != 7 && mood != 8 && mood != 15
				txt += " I actually felt much better after that."
			elseif mood == 8
				txt += " I became so emotionnal, it made me collapse completely, and even more tears ran down my eyes."
			else
				txt += " It "+GetMoodSlaveText(mood)+"."
			endif
		else
			txt += " Oh! It "+GetMoodSlaveText(mood)+"."
		endif
	elseif level != prev_level
		string the_level = GetTrainingStatusName(level)
		txt += " I felt completely "+the_level+"."
	endif
	akMind.memory_abuse_txt[idx] = txt
	;LogTrace("SetTextSlaveComfort idx="+idx+" "+akActor.GetName()+" "+akMind.memory_abuse_txt[idx])
EndFunction

Function SetTextSlaveThreaten(int idx, DOM_Actor akActor)
	;LogTrace("SetTextSlaveThreaten "+idx+" "+akActor.GetName())
	if idx < 0
		return
	endif
	if akActor == None
		return
	endif
	DOM_Mind akMind = akActor.mind
	if akMind == None
		return
	endif
	
	bool has_caps = StartTextSlaveAbuse(idx, akActor, false) ; not aggressive event
	string txt = akMind.memory_abuse_txt[idx]
	txt += TitleTextSlaveAbuse(idx, akActor, has_caps, true) ; needs comma 
	string reason = akMind.memory_abuse_reason[idx]
	txt += " threatened me against "+reason+"." 
	int ntimes = akMind.memory_abuse_ntimes[idx]
	if ntimes > 1
		if ntimes > 3
			txt += " "+DOMPlayerAlias.GetPlayerPronoun()+" keeps repeating "+DOMPlayerAlias.GetPlayerObjective()+"self!"
		elseif ntimes > 2
			txt += " It was the third time, maybe I should start paying attention."
		else
			txt += " Apparently it's important to "+DOMPlayerAlias.GetPlayerObjective()+" because that's not the first time."
		endif
	endif
	bool is_success = akMind.memory_abuse_flag[idx] ; this is actually threat success
	if is_success
		txt += " I guess I have to pay attentation to not anger "+DOMPlayerAlias.GetPlayerObjective()+" again."
	else
		txt += " Really? This "+DOMPlayerAlias.playerBadName+" "+DOMPlayerAlias.GetPlayerBeVerb()+" just out of "+DOMPlayerAlias.GetPlayerPossessive()+" mind!"
	endif
	akMind.memory_abuse_txt[idx] = txt
	;LogTrace("SetTextSlaveThreaten idx="+idx+" "+akActor.GetName()+" "+akMind.memory_abuse_txt[idx])
EndFunction

Function SetTextSlavePricing(int idx, DOM_Actor akActor)
	;LogTrace("SetTextSlavePricing "+idx+" "+akActor.GetName())
	if idx < 0
		return
	endif
	if akActor == None
		return
	endif
	DOM_Mind akMind = akActor.mind
	if akMind == None
		return
	endif
	
	bool has_caps = StartTextSlaveAbuse(idx, akActor, false) ; not aggressive event
	int mood           = akMind.memory_abuse_mood[idx]
	string txt = akMind.memory_abuse_txt[idx]
	txt += TitleTextSlaveAbuse(idx, akActor, has_caps, true) ; needs comma 
	string reason = akMind.memory_abuse_reason[idx]
	bool is_success = akMind.memory_abuse_flag[idx] ; this is actually put on display success
	if is_success
		if mood > 8 && mood < 18
			txt += " put me on display like a fine slave to sell." 
			if akMind.is_love_interest
				txt += " I tried my best to look sexy, but I hope "+DOMPlayerAlias.GetPlayerTitle()+" "+DOMPlayerAlias.GetPlayerBeVerb()+" not planning to get rid of me. Hopefully no one can ever afford "+reason+" gold."
			else
				txt += " I tried my best to look like prime merchandise and make "+DOMPlayerAlias.GetPlayerTitle()+" proud. Apparently I am worth "+reason+" gold."
			endif
		elseif akMind.memory_abuse_respectful[idx]
			txt += " put me on display, it seems I might be up for sell." 
			txt += " I guess I have to look my best if I want to find a better owner. Is anyone willing to pay "+reason+" gold to rescue me?"
		else
			txt += " put me on display like a piece of meat to sell." 
			txt += " This "+DOMPlayerAlias.playerBadName+" treats us like nothing but cattle. I am not sure anyone wants to know, but supposedly the cattle is worth "+reason+" gold."
		endif
	else
		txt += " wanted to put me on display like I was a lowly slave." 
		txt += " This "+DOMPlayerAlias.playerBadName+" treats us like nothing but cattle. Well, no one will buy me, I am a free person!"
	endif
	int ntimes = akMind.memory_abuse_ntimes[idx]
	if ntimes > 1
		if ntimes > 3
			txt += " "+DOMPlayerAlias.GetPlayerPronoun()+" "+DOMPlayerAlias.GetPlayerHaveVerb()+" something on "+DOMPlayerAlias.GetPlayerPossessive()+" mind,"
			txt += " because it's far from the first time."
		elseif ntimes > 2
			txt += " It was the third time in a row, I think I heard about potential buyers."
		else
			txt += " It's the second time, something is happening..."
		endif
	endif
	akMind.memory_abuse_txt[idx] = txt
	;LogTrace("SetTextSlavePricing idx="+idx+" "+akActor.GetName()+" "+akMind.memory_abuse_txt[idx])
EndFunction

Function SetTextSlaveCheck(int idx, DOM_Actor akActor)
	;LogTrace("SetTextSlaveCheck "+idx+" "+akActor.GetName())
	if idx < 0
		return
	endif
	if akActor == None
		return
	endif
	DOM_Mind akMind = akActor.mind
	if akMind == None
		return
	endif
	
	bool has_caps = StartTextSlaveAbuse(idx, akActor, false) ; not aggressive event
	string txt = akMind.memory_abuse_txt[idx]
	txt += TitleTextSlaveAbuse(idx, akActor, has_caps, true) ; needs comma 
	string reason = akMind.memory_abuse_reason[idx]
	string type = akMind.memory_abuse_type[idx]
	bool is_success = akMind.memory_abuse_flag[idx] 
	if is_success 
		txt += " approached me to check "+DOMPlayerAlias.GetPlayerPossessive()+" sex slave" 
		int ntimes = akMind.memory_abuse_ntimes[idx]
		if ntimes > 1
			txt += "."
		elseif type == "back"
			txt += ", from the back."
		elseif type == "floor"
			txt += ", and lay next to me."
		else
			txt += "."
		endif
		txt += reason
		if ntimes > 1
			if ntimes > 3
				txt += " It has been like that for many times now, and I am starting to enjoy it. What's wrong with me?"
			elseif ntimes > 2
				txt += " It was the third time in a row. Am I starting to enjoy it?"
			else
				txt += " It's the second time, what's wrong with me?"
			endif
		endif
	else
		txt += " approached me with "+DOMPlayerAlias.GetPlayerPossessive()+" dirty hands."
		txt += " I immediately set boundaries, this "+DOMPlayerAlias.playerBadName+" better keeps "+DOMPlayerAlias.GetPlayerPossessive()+" hands to "+DOMPlayerAlias.GetPlayerObjective()+"self."
		int ntimes = akMind.memory_abuse_ntimes[idx]
		if ntimes > 1
			if ntimes > 3
				txt += " It has been like that for many times now, but I keep pushing "+DOMPlayerAlias.GetPlayerObjective()+" away."
			elseif ntimes > 2
				txt += " It was the third time in a row, "+DOMPlayerAlias.GetPlayerPronoun()+" doesn't seem to understand."
			else
				txt += " It's the second time, "+DOMPlayerAlias.GetPlayerPronoun()+" "+DOMPlayerAlias.GetPlayerHaveVerb()+" to stop now!"
			endif
		endif
	endif
	akMind.memory_abuse_txt[idx] = txt
	;LogTrace("SetTextSlavePricing idx="+idx+" "+akActor.GetName()+" "+akMind.memory_abuse_txt[idx])
EndFunction

Function SetTextSlaveKiss(int idx, DOM_Actor akActor)
	;LogTrace("SetTextSlaveKiss "+idx+" "+akActor.GetName())
	if idx < 0
		return
	endif
	if akActor == None
		return
	endif
	DOM_Mind akMind = akActor.mind
	if akMind == None
		return
	endif
	
	bool has_caps = StartTextSlaveAbuse(idx, akActor, false) ; not aggressive event
	string txt = akMind.memory_abuse_txt[idx]
	txt += TitleTextSlaveAbuse(idx, akActor, has_caps, true) ; needs comma 
	string reason = akMind.memory_abuse_reason[idx]
	bool is_success = akMind.memory_abuse_flag[idx] 
	if is_success 
		string type = akMind.memory_abuse_type[idx]
		int ntimes = akMind.memory_abuse_ntimes[idx]
		if ntimes > 1
			txt += " came to give me a kiss." ;
		else
			txt += " came to give me a "+type+" kiss." ;
		endif
		txt += reason
		if ntimes > 1
			if ntimes > 3
				txt += " It has been like that for many times now."
			elseif ntimes > 2
				txt += " It was the third time in a row."
			else
				txt += " It's the second time, what's going on?"
			endif
		endif
	else
		txt += " approached me trying to put "+DOMPlayerAlias.GetPlayerPossessive()+" dirty lips on mine."
		txt += " I immediately set boundaries, this "+DOMPlayerAlias.playerBadName+" better not try anything like that again."
		int ntimes = akMind.memory_abuse_ntimes[idx]
		if ntimes > 1
			if ntimes > 3
				txt += " It has been like that for many times now, but I keep pushing "+DOMPlayerAlias.GetPlayerObjective()+" away."
			elseif ntimes > 2
				txt += " It was the third time in a row, "+DOMPlayerAlias.GetPlayerPronoun()+" doesn't seem to understand."
			else
				txt += " It's the second time, "+DOMPlayerAlias.GetPlayerPronoun()+" "+DOMPlayerAlias.GetPlayerHaveVerb()+" to stop now!"
			endif
		endif
	endif
	akMind.memory_abuse_txt[idx] = txt
	;LogTrace("SetTextSlavePricing idx="+idx+" "+akActor.GetName()+" "+akMind.memory_abuse_txt[idx])
EndFunction

Function SetTextSlaveGivePromise(int idx, DOM_Actor akActor)
	;LogTrace("SetTextSlaveGivePromise "+idx+" "+akActor.GetName())
	if idx < 0
		return
	endif
	if akActor == None
		return
	endif
	DOM_Mind akMind = akActor.mind
	if akMind == None
		return
	endif
		
	bool has_caps = StartTextSlaveAbuse(idx, akActor, false) ; not aggressive event
	string txt = akMind.memory_abuse_txt[idx]
	txt += TitleTextSlaveAbuse(idx, akActor, has_caps, true) ; needs comma 
	string reason = akMind.memory_abuse_reason[idx]
	txt += " promised me "+reason+"." 
	if reason == "rapture"
		txt += " Apparently, "+DOMPlayerAlias.GetPlayerPronoun()+" "+DOMPlayerAlias.GetPlayerHaveVerb()+" a very high opinion of "+DOMPlayerAlias.GetPlayerObjective()+"self."
	elseif reason == "pain"
		txt += " I guess that's only if I don't behave. It could be worth a shot."
	elseif reason == "sacrifice"
		txt += " I guess "+DOMPlayerAlias.GetPlayerPronoun()+" meant figuratively, or "+DOMPlayerAlias.GetPlayerPronoun()+" "+DOMPlayerAlias.GetPlayerBeVerb()+" crazier than I thought."
	else
		txt += " I guess that's only if I behave. It could be worth a shot."
	endif
	int ntimes = akMind.memory_abuse_ntimes[idx]
	if ntimes > 1
		if ntimes > 3
			txt += " It has been too many times, I am not sure I trust those promises anymore."
		elseif ntimes > 2
			txt += " It was the third time in a row, should I still believe "+DOMPlayerAlias.GetPlayerObjective()+"?"
		else
			txt += " It's the second time. Are we still talking about the same promise?"
		endif
	endif
	akMind.memory_abuse_txt[idx] = txt
	;LogTrace("SetTextSlaveGivePromise idx="+idx+" "+akActor.GetName()+" "+akMind.memory_abuse_txt[idx])
EndFunction

Function SetTextSlaveKeptPromise(int idx, DOM_Actor akActor)
	;LogTrace("SetTextSlaveKeptPromise "+idx+" "+akActor.GetName())
	if idx < 0
		return
	endif
	if akActor == None
		return
	endif
	DOM_Mind akMind = akActor.mind
	if akMind == None
		return
	endif
	
	; Current event
	int mood           = akMind.memory_abuse_mood[idx]
	int level          = akMind.memory_abuse_level[idx]
	; Previous event
	int prev_mood
	int prev_level
	if idx == 0
		prev_mood   = akMind.memory_capture_mood
		prev_level  = 0
	else
		int prev_idx = idx-(1)
		prev_mood   = akMind.memory_abuse_mood[prev_idx]
		prev_level  = akMind.memory_abuse_level[prev_idx]
	endif
	
	bool has_caps = StartTextSlaveAbuse(idx, akActor, false) ; not aggressive event
	string txt = akMind.memory_abuse_txt[idx]
	txt += TitleTextSlaveAbuse(idx, akActor, has_caps, true) ; needs comma 
	string reason = akMind.memory_abuse_reason[idx]
	bool is_success = akMind.memory_abuse_flag[idx] ; this is actually flatter success
	txt += " kept "+DOMPlayerAlias.GetPlayerPossessive()+" promise of giving me "+reason+"."
	if reason == "pain" || reason == "sacrifice"
		txt += " I guess I deserved it."
	elseif (idx%4) == 0
		txt += " I am honestly quite surprised!"
	elseif (idx%4) == 1
		txt += " I wonder what's going on in "+DOMPlayerAlias.GetPlayerPossessive()+" mind."
	elseif (idx%4) == 2
		txt += " Maybe there is still some hope in there."
	elseif (idx%4) == 3
		txt += " "+DOMPlayerAlias.GetPlayerBeVerb()+" "+DOMPlayerAlias.GetPlayerPronoun()+" trying to mess with my mind?"
	endif
	if mood != 10 && mood != 11 && mood > 1 && mood != prev_mood
		txt += " It "+GetMoodSlaveText(mood)+"."
	elseif level != prev_level
		string the_level = GetTrainingStatusName(level)
		txt += " I felt completely "+the_level+"."
	endif
	akMind.memory_abuse_txt[idx] = txt
	;LogTrace("SetTextSlaveKeptPromise idx="+idx+" "+akActor.GetName()+" "+akMind.memory_abuse_txt[idx])
EndFunction

Function SetTextSlaveShowering(int idx, DOM_Actor akActor)
	;LogTrace("SetTextSlaveShowering "+idx+" "+akActor.GetName())
	if idx < 0
		return
	endif
	if akActor == None
		return
	endif
	DOM_Mind akMind = akActor.mind
	if akMind == None
		return
	endif
	
	; Current event
	int mood           = akMind.memory_abuse_mood[idx]
	int level          = akMind.memory_abuse_level[idx]
	; Previous event
	int prev_mood
	int prev_level
	if idx == 0
		prev_mood   = akMind.memory_capture_mood
		prev_level  = 0
	else
		int prev_idx = idx-(1)
		prev_mood   = akMind.memory_abuse_mood[prev_idx]
		prev_level  = akMind.memory_abuse_level[prev_idx]
	endif
	
	bool has_caps = StartTextSlaveAbuse(idx, akActor, false) ; not aggressive event
	string txt = akMind.memory_abuse_txt[idx]
	txt += TitleTextSlaveAbuse(idx, akActor, has_caps, true) ; needs comma 
	string dirty_txt = 	akMind.memory_abuse_reason[idx]
	int dirty_level
	int len = StringUtil.GetLength(dirty_txt)
	if len > 2
		dirty_level = 100
	else
		dirty_level = StringUtil.AsOrd(dirty_txt)*10 
	endif
	bool is_success = akMind.memory_abuse_flag[idx]
	if !is_success
		txt += " told me to clean myself. In this cold, "+DOMPlayerAlias.GetPlayerBeVerb()+" "+DOMPlayerAlias.GetPlayerPronoun()+" crazy?"
		if dirty_level >= 100
			txt += " Though, "+DOMPlayerAlias.GetPlayerPronoun()+" "+DOMPlayerAlias.GetPlayerBeVerb()+" right, I smell worse than a dirty mammoth."
		elseif dirty_level >= 50
			txt += " Though, I must admit, I could use a nice bath."
		else 
			txt += " I am not sure the water was even cleaner than me."
		endif
		if mood != 10 && mood != 11 && mood > 1 && mood != prev_mood
			txt += " It "+GetMoodSlaveText(mood)+"."
		elseif level != prev_level
			string the_level = GetTrainingStatusName(level)
			txt += " I felt completely "+the_level+"."
		endif
	else
		txt += " forced me to clean myself."
		if dirty_level >= 100
			txt += " It could have been where everybody clean their dirty laundry and dishes. I didn't care so much because I was really filthy"
		elseif dirty_level >= 50
			txt += " The water was crystal clear. Plus, I must admit I needed it"
		else 
			txt += " Was the water even clean? I felt so exposed"
		endif
		if mood != 10 && mood != 11 && mood > 1 && mood != prev_mood
			txt += ", and it "+GetMoodSlaveText(mood)+"."
		elseif level != prev_level
			string the_level = GetTrainingStatusName(level)
			txt += ", and I felt completely "+the_level+"."
		else
			txt += "!"
		endif
	endif
	int ntimes = akMind.memory_abuse_ntimes[idx]
	if ntimes > 1
		if ntimes > 3
			if dirty_level < 50
				if akMind.memory_abuse_respectful[idx]
					txt += " It has been too many times, I am not that dirty "+DOMPlayerAlias.GetPlayerTitle()+"."
				else
					txt += " It has been too many times, I am not that dirty, you "+DOMPlayerAlias.playerBadName+"."
				endif
			else
				if akMind.memory_abuse_respectful[idx]
					txt += " It has been too many times, get used to the smell "+DOMPlayerAlias.GetPlayerTitle()+"!"
				else
					txt += " It has been too many times, get used to the smell, you "+DOMPlayerAlias.playerBadName+"!"
				endif
			endif
		elseif ntimes > 2
			if is_success
				txt += " It was the third time in a row, I start to have a weird smell, is that soap?"
			else
				txt += " It was the third time in a row, and yes, I know, I don't smell like roses."
			endif
		else
			if is_success
				txt += " It was the second time, was that really useful?"
			else
				if akMind.memory_abuse_respectful[idx]
					txt += " It was the second time, please do not insist "+DOMPlayerAlias.GetPlayerTitle()+"!"
				else
					txt += " It was the second time, mind your own business, you "+DOMPlayerAlias.playerBadName+"!"
				endif
			endif
		endif
	endif
	akMind.memory_abuse_txt[idx] = txt
	;LogTrace("SetTextSlaveShowering idx="+idx+" "+akActor.GetName()+" "+akMind.memory_abuse_txt[idx])
EndFunction

Function SetTextSlaveStrip(int idx, DOM_Actor akActor)
	;LogTrace("SetTextSlaveStrip "+idx+" "+akActor.GetName())
	if idx < 0
		return
	endif
	if akActor == None
		return
	endif
	DOM_Mind akMind = akActor.mind
	if akMind == None
		return
	endif
	
	; Current event
	int mood           = akMind.memory_abuse_mood[idx]
	int level          = akMind.memory_abuse_level[idx]
	; Previous event
	int prev_mood
	int prev_level
	if idx == 0
		prev_mood   = akMind.memory_capture_mood
		prev_level  = 0
	else
		int prev_idx = idx-(1)
		prev_mood   = akMind.memory_abuse_mood[prev_idx]
		prev_level  = akMind.memory_abuse_level[prev_idx]
	endif
	
	bool has_caps = StartTextSlaveAbuse(idx, akActor, false) ; not aggressive event
	bool is_success = akMind.memory_abuse_flag[idx]
	string txt = akMind.memory_abuse_txt[idx]
	txt += TitleTextSlaveAbuse(idx, akActor, has_caps, true) ; needs comma 
	if akMind.memory_abuse_type[idx] == "strip"
		if is_success
			txt += " forced me to strip"
		else
			txt += " told me to strip"
		endif
	else
		txt += " came to me "
		if (idx%10) == 0
			txt += " and proceeded to "
		elseif (idx%10) == 1
			txt += " and started to "
		elseif (idx%10) == 2
			txt += " and decided to "
		elseif (idx%10) == 3
			txt += " and seemed determined to "
		elseif (idx%10) == 4
			txt += " and began to "
		elseif (idx%10) == 5
			txt += " and suddenly tried to "
		elseif (idx%10) == 6
			txt += " with a weird grin on "+DOMPlayerAlias.GetPlayerPossessive()+" face and started to "
		elseif (idx%10) == 7
			txt += " and tried to "
		elseif (idx%10) == 8
			txt += " and without warning proceeded to "
		elseif (idx%10) == 9
			txt += " angrily and began to "
		endif
			txt += " rip my clothes off"
	endif
	string the_place = akMind.memory_abuse_reason[idx]
	if the_place == "city"
		txt += ", in the middle of a city. With all those people around"
		if is_success
			txt += ", I felt so exposed"
		else
			txt += ", like I was going to put on a show"
		endif
	elseif the_place == "dungeon"
		txt += ", in a damp and scary dungeon"
		if !is_success
			txt += ", in front of who knows what "
		endif
	else ; "wilderness"
		txt += ", right there, out in the wilderness"
		if !is_success
			txt += ", I would have cought a cold for sure "
		endif
	endif
	if mood != 10 && mood != 11 && mood > 1 && mood != prev_mood
		txt += ", and it "+GetMoodSlaveText(mood)+"."
	elseif level != prev_level
		string the_level = GetTrainingStatusName(level)
		txt += ", and I felt completely "+the_level+"."
	else
		txt += "!"
	endif
	int ntimes = akMind.memory_abuse_ntimes[idx]
	if ntimes > 1
		if ntimes > 3
			txt += " Then I got to put my clothes back on and take them off again, and again, finally I lost count!"
		elseif ntimes > 2
			txt += " Then I got to put my clothes back on and take them off again, and on and off again!"
		else
			txt += " Then I got to put my clothes back on, but soon after I was asked to take them off again!"
		endif
	endif
	akMind.memory_abuse_txt[idx] = txt
	;LogTrace("SetTextSlaveStrip idx="+idx+" "+akActor.GetName()+" "+akMind.memory_abuse_txt[idx])
EndFunction

Function SetTextSlaveBrand(int idx, DOM_Actor akActor)
	;LogTrace("SetTextSlaveBrand "+idx+" "+akActor.GetName())
	if idx < 0
		return
	endif
	if akActor == None
		return
	endif
	DOM_Mind akMind = akActor.mind
	if akMind == None
		return
	endif
	
	; Current event
	int mood           = akMind.memory_abuse_mood[idx]
	int level          = akMind.memory_abuse_level[idx]
	; Previous event
	int prev_mood
	int prev_level
	if idx == 0
		prev_mood   = akMind.memory_capture_mood
		prev_level  = 0
	else
		int prev_idx = idx-(1)
		prev_mood   = akMind.memory_abuse_mood[prev_idx]
		prev_level  = akMind.memory_abuse_level[prev_idx]
	endif
	
	bool has_caps = StartTextSlaveAbuse(idx, akActor, false) ; not aggressive event
	bool is_success = akMind.memory_abuse_flag[idx]
	string txt = akMind.memory_abuse_txt[idx]
	txt += TitleTextSlaveAbuse(idx, akActor, has_caps, true) ; needs comma 
	txt += " went to me with a hot branding iron"
	if (idx%5) == 0
		txt += " and began approaching it to my "
	elseif (idx%5) == 1
		txt += " and started approaching it to my "
	elseif (idx%5) == 2
		txt += " and decided to aim for my "
	elseif (idx%5) == 3
		txt += " and seemed determined to aim for my "
	elseif (idx%5) == 4
		txt += " and without warning approached it to my "
	endif
	txt += akMind.memory_abuse_type[idx]+", that was VERY painful!"

	string the_place = akMind.memory_abuse_reason[idx]
	if the_place == "city"
		txt += " It was in the middle of a city. With all those people around"
	elseif the_place == "dungeon"
		txt += " It was  in a damp and scary dungeon"
	else ; "wilderness"
		txt += " It was somewhere, lost in the wilderness"
	endif
	if mood != 10 && mood != 11 && mood > 1 && mood != prev_mood
		txt += ", and it "+GetMoodSlaveText(mood)+"."
	elseif level != prev_level
		string the_level = GetTrainingStatusName(level)
		txt += ", and I felt completely "+the_level+"."
	else
		txt += "!"
	endif
	int ntimes = akMind.memory_abuse_ntimes[idx]
	if ntimes > 1
		if ntimes > 3
			txt += " I might not have a single square each of skin left, because apparently one branding was not enough, now I am all covered in branding iron marks.."
		elseif ntimes > 2
			txt += " My whole body is sore, because apparently I needed three branding iron marks."
		else
			txt += " Apparently one branding was not enough, so I got two."
		endif
	endif
	akMind.memory_abuse_txt[idx] = txt
	;LogTrace("SetTextSlaveBrand idx="+idx+" "+akActor.GetName()+" "+akMind.memory_abuse_txt[idx])
EndFunction

Function SetTextSlaveCollar(int idx, DOM_Actor akActor)
	;LogTrace("SetTextSlaveCollar "+idx+" "+akActor.GetName())
	if idx < 0
		return
	endif
	if akActor == None
		return
	endif
	DOM_Mind akMind = akActor.mind
	if akMind == None
		return
	endif
	
	; Current event
	int mood           = akMind.memory_abuse_mood[idx]
	int level          = akMind.memory_abuse_level[idx]
	; Previous event
	int prev_mood
	int prev_level
	if idx == 0
		prev_mood   = akMind.memory_capture_mood
		prev_level  = 0
	else
		int prev_idx = idx-(1)
		prev_mood   = akMind.memory_abuse_mood[prev_idx]
		prev_level  = akMind.memory_abuse_level[prev_idx]
	endif
	
	bool has_caps = StartTextSlaveAbuse(idx, akActor, false) ; not aggressive event
	string txt = akMind.memory_abuse_txt[idx]
	txt += TitleTextSlaveAbuse(idx, akActor, has_caps, true) ; needs comma 
	txt += " forced me to wear a collar. I felt so degraded"
	if mood != 10 && mood != 11 && mood > 1 && mood != prev_mood
		txt += ", and it "+GetMoodSlaveText(mood)+"."
	elseif level != prev_level
		string the_level = GetTrainingStatusName(level)
		txt += ", and I felt completely "+the_level+"."
	else
		txt += "!"
	endif
	int ntimes = akMind.memory_abuse_ntimes[idx]
	if ntimes > 1
		if ntimes > 3
			txt += DOMPlayerAlias.GetPlayerPronoun()+" might have a kink of collaring people, because "+DOMPlayerAlias.GetPlayerPronoun()+" would not stop taking it on and off."
		elseif ntimes > 2
			txt += " Why would I need to collared three times?"
		else
			txt += " Later I thought "+DOMPlayerAlias.GetPlayerPronoun()+" would remove it, but no, I got collared again."
		endif
	endif
	akMind.memory_abuse_txt[idx] = txt
	;LogTrace("SetTextSlaveCollar idx="+idx+" "+akActor.GetName()+" "+akMind.memory_abuse_txt[idx])
EndFunction

Function SetTextSlaveGag(int idx, DOM_Actor akActor)
	;LogTrace("SetTextSlaveGag "+idx+" "+akActor.GetName())
	if idx < 0
		return
	endif
	if akActor == None
		return
	endif
	DOM_Mind akMind = akActor.mind
	if akMind == None
		return
	endif
	
	; Current event
	int mood           = akMind.memory_abuse_mood[idx]
	int level          = akMind.memory_abuse_level[idx]
	; Previous event
	int prev_mood
	int prev_level
	if idx == 0
		prev_mood   = akMind.memory_capture_mood
		prev_level  = 0
	else
		int prev_idx = idx-(1)
		prev_mood   = akMind.memory_abuse_mood[prev_idx]
		prev_level  = akMind.memory_abuse_level[prev_idx]
	endif
	
	bool has_caps = StartTextSlaveAbuse(idx, akActor, false) ; not aggressive event
	string txt = akMind.memory_abuse_txt[idx]
	txt += TitleTextSlaveAbuse(idx, akActor, has_caps, true) ; needs comma 
	txt += " forced me to wear a gag. I felt so powerless"
	if mood != 10 && mood != 11 && mood > 1 && mood != prev_mood
		txt += ", and it "+GetMoodSlaveText(mood)+"."
	elseif level != prev_level
		string the_level = GetTrainingStatusName(level)
		txt += ", and I felt completely "+the_level+"."
	else
		txt += "!"
	endif
	int ntimes = akMind.memory_abuse_ntimes[idx]
	if ntimes > 1
		if ntimes > 3
			txt += DOMPlayerAlias.GetPlayerPronoun()+" might have a kink of gagging people, because "+DOMPlayerAlias.GetPlayerPronoun()+" would not stop taking it on and off."
		elseif ntimes > 2
			txt += " Why would I need to gagged three times?"
		else
			txt += " Later I thought "+DOMPlayerAlias.GetPlayerPronoun()+" would remove it, but no, I got gagged again."
		endif
	endif
	akMind.memory_abuse_txt[idx] = txt
	;LogTrace("SetTextSlaveGag idx="+idx+" "+akActor.GetName()+" "+akMind.memory_abuse_txt[idx])
EndFunction

Function SetTextSlaveBlindfold(int idx, DOM_Actor akActor)
	;LogTrace("SetTextSlaveBlindfold "+idx+" "+akActor.GetName())
	if idx < 0
		return
	endif
	if akActor == None
		return
	endif
	DOM_Mind akMind = akActor.mind
	if akMind == None
		return
	endif
	
	; Current event
	int mood           = akMind.memory_abuse_mood[idx]
	int level          = akMind.memory_abuse_level[idx]
	; Previous event
	int prev_mood
	int prev_level
	if idx == 0
		prev_mood   = akMind.memory_capture_mood
		prev_level  = 0
	else
		int prev_idx = idx-(1)
		prev_mood   = akMind.memory_abuse_mood[prev_idx]
		prev_level  = akMind.memory_abuse_level[prev_idx]
	endif
	
	bool has_caps = StartTextSlaveAbuse(idx, akActor, false) ; not aggressive event
	string txt = akMind.memory_abuse_txt[idx]
	txt += TitleTextSlaveAbuse(idx, akActor, has_caps, true) ; needs comma 
	if (idx%4) == 0
		txt += " proceeded to "
	elseif (idx%4) == 1
		txt += " started to "
	elseif (idx%4) == 2
		txt += " decided to "
	elseif (idx%4) == 3
		txt += " began to "
	endif
	txt += " blinded me with a piece of cloth. I was utterly helpless"
	if mood != 10 && mood != 11 && mood > 1 && mood != prev_mood
		txt += ", and it "+GetMoodSlaveText(mood)+"."
	elseif level != prev_level
		string the_level = GetTrainingStatusName(level)
		txt += ", and I felt completely "+the_level+"."
	else
		txt += "!"
	endif
	int ntimes = akMind.memory_abuse_ntimes[idx]
	if ntimes > 1
		if ntimes > 3
			txt += DOMPlayerAlias.GetPlayerPronoun()+" might have a kink of blindfolding people, because "+DOMPlayerAlias.GetPlayerPronoun()+" would not stop taking it on and off."
		elseif ntimes > 2
			txt += " Why would I need to blindfolded three times?"
		else
			txt += " Later I thought "+DOMPlayerAlias.GetPlayerPronoun()+" would remove it, but no, I got blindfolded again."
		endif
	endif
	akMind.memory_abuse_txt[idx] = txt
	;LogTrace("SetTextSlaveBlindfold idx="+idx+" "+akActor.GetName()+" "+akMind.memory_abuse_txt[idx])
EndFunction

Function SetTextSlavePlug(int idx, DOM_Actor akActor)
	;LogTrace("SetTextSlavePlug "+idx+" "+akActor.GetName())
	if idx < 0
		return
	endif
	if akActor == None
		return
	endif
	DOM_Mind akMind = akActor.mind
	if akMind == None
		return
	endif
	
	; Current event
	int mood           = akMind.memory_abuse_mood[idx]
	int level          = akMind.memory_abuse_level[idx]
	; Previous event
	int prev_mood
	int prev_level
	if idx == 0
		prev_mood   = akMind.memory_capture_mood
		prev_level  = 0
	else
		int prev_idx = idx-(1)
		prev_mood   = akMind.memory_abuse_mood[prev_idx]
		prev_level  = akMind.memory_abuse_level[prev_idx]
	endif
	
	bool has_caps = StartTextSlaveAbuse(idx, akActor, false) ; not aggressive event
	string txt = akMind.memory_abuse_txt[idx]
	txt += TitleTextSlaveAbuse(idx, akActor, has_caps, true) ; needs comma 
	if (idx%4) == 0
		txt += " proceeded to "
	elseif (idx%4) == 1
		txt += " started to "
	elseif (idx%4) == 2
		txt += " decided to "
	elseif (idx%4) == 3
		txt += " began to "
	endif
	string type = akMind.memory_abuse_reason[idx]
	if type == "anal"
		txt += " insert "+akMind.memory_abuse_reason[idx]+" into my ass. It kind of hurted"
	elseif type == "vaginal"
		txt += " insert "+akMind.memory_abuse_reason[idx]+" into my most intimate parts. It was so degrading"
	else
		txt += " insert "+akMind.memory_abuse_reason[idx]+" into my most intimate parts. It was so degrading"
	endif
	if mood != 10 && mood != 11 && mood > 1 && mood != prev_mood
		txt += ", and it "+GetMoodSlaveText(mood)+"."
	elseif level != prev_level
		string the_level = GetTrainingStatusName(level)
		txt += ", and I felt completely "+the_level+"."
	else
		txt += "!"
	endif
	int ntimes = akMind.memory_abuse_ntimes[idx]
	if ntimes > 1
		if ntimes > 3
			txt += DOMPlayerAlias.GetPlayerPronoun()+" might have a kink of blindfolding people, because "+DOMPlayerAlias.GetPlayerPronoun()+" would not stop taking it on and off."
		elseif ntimes > 2
			txt += " Why would I need to blindfolded three times?"
		else
			txt += " Later I thought "+DOMPlayerAlias.GetPlayerPronoun()+" would remove it, but no, I got blindfolded again."
		endif
	endif
	akMind.memory_abuse_txt[idx] = txt
	;LogTrace("SetTextSlaveBlindfold idx="+idx+" "+akActor.GetName()+" "+akMind.memory_abuse_txt[idx])
EndFunction

string Function GetMoodSlaveText(int mood)
	if mood == 1 ; just captured
		return "made me feel so helpless"
	elseif mood == 18 ; defiant
		return " made me feel even more defiant"
	elseif mood == 19 ; crushed
		return " made me feel like my world was crumbling"
	elseif mood == 20 ; proud
		return "really annoyed me, how dare "+DOMPlayerAlias.GetPlayerPronoun()
	endif
	return "made me so "+GetMoodStatusName(mood)
EndFunction

Function LogTrace(string msg)
	if DOMCore.verboseMode
		Debug.Trace("DOM_Diary: "+msg)
	endif
EndFunction

Function LogInfo(string msg)
	Debug.Trace("DOM_Diary: "+msg)
EndFunction

