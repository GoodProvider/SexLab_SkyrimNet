Scriptname DOM_Sexlab extends Quest  
Import Utility
Import DOM_Util

Actor Property PlayerRef Auto
DOM_Core Property DOMCore Auto
DOM_Zaz Property DOMZaz Auto
DOM_Ostim Property DOMOstim Auto
SexLabFramework Property SexLab Auto Hidden
Faction Property SexLabAnimatingFaction Auto Hidden ; SexLabAnimatingFaction "SexLab Animating Actors" [FACT:0300E50F]
Faction Property SexLabForbiddenActors Auto Hidden
Faction Property slaArousal Auto Hidden
Faction Property slaArousalLocked Auto Hidden
Faction Property DOMActionTied Auto
Faction Property DOMAnimatingFaction Auto
Faction Property DOMNbSex Auto
Faction Property DOMNbRape Auto
Faction Property DOMVirginVaginal Auto
Faction Property DOMVirginAnal Auto
Faction Property DOMVirginOral Auto
Faction Property DOMVirginSame Auto
Faction Property DOMVirginGangbang Auto
Faction Property DOMTrainVaginal Auto
Faction Property DOMTrainAnal Auto
Faction Property DOMTrainOral Auto
Faction Property DOMModVaginal Auto
Faction Property DOMModOral Auto
Faction Property DOMModAnal Auto
Faction Property DOMAnimatingVaginal Auto
Faction Property DOMAnimatingAnal Auto
Faction Property DOMAnimatingOral Auto
Faction Property DOMAnimatingSame Auto
Faction Property DOMAnimatingThreesome Auto
Faction Property DOMAnimatingAggressive Auto
Faction Property DOMAnimatingWithPlayer Auto

GlobalVariable Property DOM_HasSexlab Auto 
MagicEffect Property HDTHeelEffect Auto Hidden
FormList Property Beds Auto

Keyword Property SexLabActive Auto Hidden
Keyword Property SexLabNoStrip Auto Hidden
Keyword Property SexLabAlwaysStrip Auto Hidden

; Toggles
bool Property startSexlabPreferablyPlayer = true Auto Hidden 
bool Property startSexlabPreferablyNPC = true Auto Hidden 
bool Property startSexlabPreferablyDOM = true Auto Hidden 
bool Property doRipOffBeforeSex = false Auto Hidden
bool Property undressBeforeSex = true Auto Hidden
bool Property redressAfterSex = true Auto Hidden
bool Property HasHDTHeels Auto Hidden
bool Property HasNiOverride Auto Hidden
bool Property requireSLTags = true Auto Hidden
bool Property requireSLTags3 = false Auto Hidden
bool Property requireSLTags4 = false Auto Hidden
bool Property separateOrgasmToggle = false Auto Hidden
bool Property alwaysAggressiveToggle = false Auto Hidden
bool Property alwaysGentleToggle = false Auto Hidden
bool Property useAggressiveTag = true Auto Hidden
float Property postRapeDelay = 15.0 Auto Hidden
string Property DefaultSexlabExtraTags = "" Auto Hidden ; Extra tags to use in Sexlab scenes

Function Initialize()
	LogInfo("==============================================================================")
	LogInfo("==                          DOM: Sexlab interface                           ==")
	LogInfo("==============================================================================")
	If Game.GetModByName("SexLab.esm") != 255
		DOM_HasSexlab.SetValue(1)
		SexLab                 = Game.GetFormFromFile(0x00000D62, "SexLab.esm") As SexLabFramework
		SexLabAnimatingFaction = Game.GetFormFromFile(0x0000E50F, "SexLab.esm") As Faction
		SexLabForbiddenActors  = Game.GetFormFromFile(0x00049068, "SexLab.esm") As Faction
		if Beds == None
			Beds               = Game.GetFormFromFile(0x00049068, "SexLab.esm") As FormList
		endif
	else
		DOM_HasSexlab.SetValue(0)
		SexLab                 = None
		SexLabAnimatingFaction = None
		SexLabForbiddenActors  = None
		if Beds == None
			Beds               = Game.GetFormFromFile(0x00159F1B, "DiaryOfMine.esm") As FormList
		endif
	endif
	if Game.GetModByName("SexLabAroused.esm") != 255
		slaArousal       = Game.GetFormFromFile(0x0003FC36, "SexLabAroused.esm") As Faction
		slaArousalLocked = Game.GetFormFromFile(0x0007649C, "SexLabAroused.esm") As Faction
	elseif Game.GetModByName("ArousedRedux.esm") != 255
		slaArousal = Game.GetFormFromFile(0x3FC36, "ArousedRedux.esm") As Faction
		slaArousalLocked = Game.GetFormFromFile(0x0007649C, "ArousedRedux.esm") As Faction
	else
		slaArousal       = None
		slaArousalLocked = None
	endif
 	SexLabActive      = Keyword.GetKeyword("SexLabActive")
 	SexLabNoStrip     = Keyword.GetKeyword("SexLabNoStrip")
 	SexLabAlwaysStrip = Keyword.GetKeyword("SexLabAlwaysStrip")
	if SexLabAlwaysStrip == None
		SexLabAlwaysStrip = Keyword.GetKeyword("AlwaysStrip")
	endif
	HasHDTHeels   = Game.GetModByName("hdtHighHeel.esm") != 255
	if HasHDTHeels
		HDTHeelEffect = Game.GetFormFromFile(0x800, "hdtHighHeel.esm") as MagicEffect
	else
		HDTHeelEffect = None
	endif
	HasNiOverride = SKSE.GetPluginVersion("SKEE64") >= 7 || NiOverride.GetScriptVersion() >= 7 ;SSE
	if Sexlab == None
		LogInfo("WARNING: Sexlab NOT FOUND! has_sexlab="+DOM_HasSexlab.GetValue())
		UnregisterForModEvent("AnimationEnd_PostRape")
		UnregisterForModEvent("AnimationEnd_PostFornicate")
	else
		LogInfo("Sexlab found! has_sexlab="+DOM_HasSexlab.GetValue())
		RegisterForModEvent("HookAnimationEnd_PostRape", "PostRape")
		RegisterForModEvent("HookAnimationEnd_PostFornicate", "PostFornicate")
	endif
	if DOMZaz == None
		LogTrace("Recovering DOMZaz")
		DOMZaz = DOMCore.DOMZaz
	endif
EndFunction

bool Function IsActorActive(Actor akRef)
	if akRef == None
		return false
	endif
	if IsAnimating(akRef)
		return true
	endif
	if SexLabActive != None && akRef.HasKeyWord(SexLabActive)
		return true
	endif
	return false
EndFunction

bool Function IsAnimating(Actor akRef)
	;LogAnim("IsAnimating Actor="+akRef)
	if akRef == None
		return false
	endif
	;LogAnim("IsAnimating Faction="+SexLabAnimatingFaction)
	if SexLabAnimatingFaction != None
		;LogAnim("IsAnimating IsInFaction="+akRef.IsInFaction(SexLabAnimatingFaction))
		if akRef.IsInFaction(SexLabAnimatingFaction)
			return true
		endif
	endif
	return DOMOstim.IsAnimating(akRef)
EndFunction

Function ClearAnimatingFaction(Actor akRef)
	if akRef == None
		return
	endif
	if SexLabAnimatingFaction == None
		return
	endif
	akRef.RemoveFromFaction(SexLabAnimatingFaction)
EndFunction

Function SetAnimatingFaction(Actor akRef)
	if akRef == None
		return
	endif
	if SexLabAnimatingFaction == None
		return
	endif
	akRef.AddToFaction(SexLabAnimatingFaction)
EndFunction

Function SetForbidden(Actor akRef, bool value)
	if akRef == None
		return
	endif
	if SexLabForbiddenActors == None
		return
	endif
	if value
		akRef.AddToFaction(SexLabForbiddenActors)
	else
		akRef.RemoveFromFaction(SexLabForbiddenActors)
	endif
EndFunction

sslThreadController Function GetController(int tid)
	if Sexlab == None
		return None
	endif
	return SexLab.GetController(tid)
EndFunction
 
Function TrackActor(Actor akRef, string the_event)
	if Sexlab == None
		return
	endif
	SexLab.trackActor(akRef, the_event)
EndFunction

Function UnTrackActor(Actor akRef, string the_event)
	if Sexlab == None
		return
	endif
	SexLab.untrackActor(akRef, the_event)
EndFunction

Spell Function GetHDTSpell(Actor ActorRef) ; From Sexlab
	if !HasHDTHeels || !HDTHeelEffect || !ActorRef; || !ActorRef.GetWornForm(Armor.GetMaskForSlot(37))
		return none
	endif
	int i = ActorRef.GetSpellCount()
	while i
		i -= 1
		Spell SpellRef = ActorRef.GetNthSpell(i)
		;LogTrace("Checking "+SpellRef.GetName()+" ("+SpellRef+") for HDT HighHeels")
		if SpellRef && StringUtil.Find(SpellRef.GetName(), "Heel") != -1
			return SpellRef
		endif
		int n = SpellRef.GetNumEffects()
		while n
			n -= 1
			if SpellRef.GetNthEffectMagicEffect(n) == HDTHeelEffect
				return SpellRef
			endif
		endWhile
	endWhile
	return none
EndFunction

bool Function HasNoStripKeyword(Form the_form)
	if SexLabNoStrip != None && the_form.HasKeyword(SexLabNoStrip)
		return true
	endif
	if the_form.HasKeywordString("SexLabNoStrip")
		return true
	endif
	if SexLab == None
		return false
	endif
	if SexLabUtil.HasKeywordSub(the_form,"NoStrip")
		return true
	endif
	return false
EndFunction

bool Function HasAlwaysStripKeyword(Form the_form)
	if SexLabAlwaysStrip != None && the_form.HasKeyword(SexLabAlwaysStrip)
		return true
	endif
	if SexLab == None
		return false
	endif
	if SexLabUtil.HasKeywordSub(the_form,"AlwaysStrip")
		return true
	endif
	return false
EndFunction

Function TreatAsMale(Actor akRef)
	if Sexlab == None
		return
	endif
	SexLab.TreatAsMale(akRef)
EndFunction

Function TreatAsFemale(Actor akRef)
	if Sexlab == None
		return
	endif
	SexLab.TreatAsFemale(akRef)
EndFunction

bool Function IsInterracial(int r1, int r2)
	if r1 < 10 || r2 < 10
		return false
	endif
	int x1 = r1 / 10
	int x2 = r2 / 10
	if x1 == x2
		return false
	endif
	return true
EndFunction

Function ClearCum(Actor akRef)
	if Sexlab != None
		Sexlab.ClearCum(akRef)
	endif
	DOMOstim.ClearCum(akRef)
	ClearExtra(akRef)
EndFunction

Function ClearExtra(Actor akRef)
    ; (kPAF_MainQuestScript as PAF_MainQuestScript).Bathe(akRef)
EndFunction

int Function GetGender(Actor akRef)
	if akRef == None
		return -1
	endif
	if Sexlab == None
		return akRef.GetLeveledActorBase().GetSex()
	endif
	return SexLab.GetGender(akRef)
EndFunction

Function StripActor(Actor ActorRef, Actor VictimRef = none)
	if Sexlab == None
		return
	endif
	Sexlab.StripActor(ActorRef, VictimRef)
EndFunction

Function ResetSexuality(Actor akRef, bool isFemale)
	if Sexlab == None
		return
	endif
	if !isFemale
		Sexlab.Stats.SetSkillFloat(akRef, "Males",0)
		SexLab.CalcSexuality(isFemale,0, SexLab.GetSkill(akRef, "Females"))
	else
		Sexlab.Stats.SetSkillFloat(akRef, "Females",0)			
		SexLab.CalcSexuality(isFemale, SexLab.GetSkill(akRef, "Males"), 0)
	endif
EndFunction

int Function GetSexlabValue(Actor _a, string stat, int x = 0)
	if Sexlab == None
		return 0
	endif
	int y = SexLab.Stats.GetSkill(_a, stat)
	if x < 0 && y < 0
		return 0
	endif
	if y > x
		return y
	elseif x > 100
		return 100
	endif
	return x
EndFunction

float Function GetStat(Actor akRef, string the_stat)
	if Sexlab == None
		return 0.0
	endif
	return SexLab.Stats.GetSkillFloat(akRef, the_stat)
EndFunction

Function SetStat(Actor akRef, string the_stat, float value)
	if Sexlab == None
		return
	endif
	Sexlab.Stats.SetSkillFloat(akRef, the_stat, value)
EndFunction

Function CopyStat(Actor target, Actor source, string the_stat)
	if Sexlab == None
		return
	endif
	;LogTrace("CopyStat "+source.GetDisplayName()+" "+the_stat+" value="+SexLab.Stats.GetSkillFloat(source, the_stat))
	SexLab.Stats.SetSkillFloat(target, the_stat, SexLab.Stats.GetSkillFloat(source, the_stat))
EndFunction

Function ClearStats(Actor akRef)
	if Sexlab == None
		return
	endif
	SexLab.Stats.EmptyStats(akRef)
EndFunction

bool Function HasOrgasmEffects()
	if Sexlab == None
		return false
	endif
	return Sexlab.Config.OrgasmEffects
EndFunction

bool Function UseLipSync()
	if Sexlab == None
		return false
	endif
	return Sexlab.Config.UseLipSync
EndFunction

Function PickVoice(Actor akRef, int volume, bool isVictim)
	if Sexlab == None
		return
	endif
	Sexlab.PickVoice(akRef).Moan(akRef, volume, isVictim)
EndFunction

Function PlayVoice(sslBaseVoice SexlabVoice, Actor akRef, bool isVictim)
	if Sexlab == None
		return
	endif
	float Volume = Sexlab.Config.VoiceVolume
	if Volume > 0.5
		Volume = 1.0
	endif
	Sound.SetInstanceVolume(SexlabVoice.GetSound(100, isVictim).Play(akRef), Volume)
EndFunction

Function PlayOrgasm(Actor akRef)
	if Sexlab == None
		return
	endif
	float Volume = Sexlab.Config.SFXVolume
	if Volume > 0.5
		Volume = 1.0
	endif
	Sound.SetInstanceVolume(Sexlab.Config.OrgasmFX.Play(akRef), Volume)
EndFunction

float Function HandleArousalAfterAssign(Actor akRef, int actorSex)
	if akRef == None
		return 0.0
	endif
	if slaArousalLocked != None
		akRef.SetFactionRank(slaArousalLocked,1)
	endif
	float arousal_value
	if slaArousal != None
		arousal_value = akRef.GetFactionRank(slaArousal)
	else
		arousal_value = 0.0
	endif
	if (actorSex %2) == 0 ; Actors with SOS
		int position = ((arousal_value-(50.0))/5.0) as int
		if position == 0
			Debug.sendAnimationEvent(akRef, "SOSFlaccid")
		else
			HandleErection(akRef, 0.0, arousal_value)
		endif
	endif
	return arousal_value
EndFunction

Function HandleArousalBeforeClear(Actor akRef, int actorSex)
	if akRef == None
		return
	endif
	if slaArousalLocked != None
		akRef.RemoveFromFaction(slaArousalLocked)
	endif
EndFunction

Function HandleArousal(Actor akRef, float akPrevArousal, float akNextArousal, int actorSex)
	; Arousal level between 0 and 200
	if akRef == None
		return
	endif
	if akPrevArousal == akNextArousal
		return ; no changes
	endif
	if slaArousal != None
		int rank = (akNextArousal) as int
		if rank > 100
			rank = 100
		elseif rank < 0
			rank = 0
		endif
		akRef.SetFactionRank(slaArousal,rank)
	endif
	if SexLabAnimatingFaction != None && akRef.IsInFaction(SexLabAnimatingFaction)
		return ; handled by Sexlab
	endif
	if (actorSex %2) == 0 ; Actors with SOS
		HandleErection(akRef,akPrevArousal,akNextArousal)
	endif
EndFunction

float Function GetArousalValue(Actor akRef)
	if akRef == None
		return 0.0
	endif
	if slaArousal == None
		return 0.0
	endif
	return akRef.GetFactionRank(slaArousal) as float
EndFunction

Function SetArousalValue(Actor akRef, float akNextArousal)
	if akRef == None
		return
	endif
	if slaArousal == None
		return
	endif
	int rank = (akNextArousal) as int
	if rank > 100
		rank = 100
	elseif rank < 0
		rank = 0
	endif
	akRef.SetFactionRank(slaArousal,rank)
EndFunction

Function HandleErection(Actor akRef, float akPrevArousal, float akNextArousal)
	int prev_position = ((akPrevArousal-(50.0))/5.0) as int
	int next_position = ((akNextArousal-(50.0))/5.0) as int
	if prev_position < -10
		prev_position = -10
	elseif prev_position > 10
		prev_position = 10
	endif
	if next_position < -10
		next_position = -10
	elseif next_position > 10
		next_position = 10
	endif
	if prev_position == next_position
		return ; no changes
	endif

	; arousal position level between -10 and 10
	if next_position < -9
		Debug.sendAnimationEvent(akRef, "SOSFlaccid")
	elseif next_position > 9
		Debug.sendAnimationEvent(akRef, "SOSBend9")
	else
		Debug.sendAnimationEvent(akRef, "SOSBend" + next_position)
	endif
EndFunction

sslBaseVoice Function GetVoice(Actor akRef, bool isCreature)
	if Sexlab == None
		return None
	endif
	if isCreature
		Race akActorRace  = akRef.GetLeveledActorBase().GetRace()
		string racekey = sslCreatureAnimationSlots.GetRaceKey(akActorRace) ; Global Function
		return Sexlab.Config.VoiceSlots.PickByRaceKey(racekey)
	endif
	return Sexlab.Config.VoiceSlots.PickVoice(akRef)
EndFunction

Function PlayMoan(sslBaseVoice SexlabVoice, Actor akRef, int strength, bool isVictim, bool SexlabUseLipSync)
	if SexlabVoice == None
		return
	endif
	SexlabVoice.PlayMoan(akRef, strength, isVictim, SexlabUseLipSync)
EndFunction

sslBaseAnimation[] Function GetAggressiveFMAnims()
	sslBaseAnimation[] anims = new sslBaseAnimation[3]
	anims[0] = SexLab.GetAnimationByName("Zyn Licking")
	anims[1] = SexLab.GetAnimationByName("Mitos Female FaceDOM")
	anims[2] = SexLab.GetAnimationByName("Leito Cunnilingus")
	return anims
EndFunction

sslBaseAnimation[] Function GetAnimationsByTagsNoExtra(int ActorCount, string tags, string supressedTags = "", bool RequireAll = true)
	LogTrace("GetAnimationsByTagsNoExtra ActorCount="+ActorCount+" tags="+tags+" supressedTags="+supressedTags+" RequireAll="+RequireAll)
	sslBaseAnimation[] anims = SexLab.GetAnimationsByTags(ActorCount, tags, supressedTags, RequireAll)
	if anims.length != 0
		LogTrace("GetAnimationsByTagsNoExtra NO EXTRA TAGS number of anims="+anims.length)
		return anims
	endif
	anims = SexLab.GetAnimationsByTags(ActorCount, tags, supressedTags, false)
	if anims.length != 0
		LogTrace("GetAnimationsByTagsNoExtra NO EXTRA TAGS requireAll=false number of anims="+anims.length)
		return anims
	endif
	anims = SexLab.GetAnimationsByTags(ActorCount, "", supressedTags, false)
	if anims.length != 0
		LogTrace("GetAnimationsByTagsNoExtra NO TAGS number of anims="+anims.length)
		return anims
	endif
	anims = SexLab.GetAnimationsByTags(ActorCount, "", "", false)
	LogTrace("GetAnimationsByTagsNoExtra NO TAGS NO SUPPRESSION number of anims="+anims.length)
	return anims
EndFunction

sslBaseAnimation[] Function GetAnimationsByTagsNoRequireAll(int ActorCount, string tags, string supressedTags = "")
	int n = GetNumberOfTags(DefaultSexlabExtraTags)
	LogTrace("GetAnimationsByTagsNoRequireAll ActorCount="+ActorCount+" tags="+tags+" supressedTags="+supressedTags+" extra tags="+DefaultSexlabExtraTags)
	sslBaseAnimation[] anims = SexLab.GetAnimationsByTags(ActorCount, AddTag(tags,DefaultSexlabExtraTags), supressedTags, false)
	if anims.length != 0
		LogTrace("GetAnimationsByTagsNoRequireAll Number of extra tags="+n+" number of anims="+anims.length)
		return anims
	endif
	anims = SexLab.GetAnimationsByTags(ActorCount, tags, supressedTags, false)
	if anims.length != 0
		LogTrace("GetAnimationsByTagsNoRequireAll NO EXTRA TAGS number of anims="+anims.length)
		return anims
	endif
	anims = SexLab.GetAnimationsByTags(ActorCount, "", supressedTags, false)
	if anims.length != 0
		LogTrace("GetAnimationsByTagsNoRequireAll NO TAGS AT ALL! number of anims="+anims.length)
		return anims
	endif
	; Failure, last try
	anims = SexLab.GetAnimationsByTags(ActorCount, "", "", false)
	LogTrace("GetAnimationsByTagsNoRequireAll NO TAGS AT ALL NO SUPPRESSION! number of anims="+anims.length)
	return anims
EndFunction

sslBaseAnimation[] Function GetAnimationsByTagsBase(int ActorCount, string tags, string supressedTags = "", bool RequireAll = true)
	if SexLab == None
		return None
	endif
	sslBaseAnimation[] anims = SexLab.GetAnimationsByTags(ActorCount, tags, supressedTags, RequireAll)
	return anims
EndFunction

sslBaseAnimation[] Function GetAnimationsByTags(int ActorCount, string tags, string supressedTags = "", bool RequireAll = true)
	LogTrace("GetAnimationsByTags ActorCount="+ActorCount+" tags="+tags+" supressedTags="+supressedTags+" RequireAll="+RequireAll+" extra tags="+DefaultSexlabExtraTags)
	if DefaultSexlabExtraTags == "" ; No extra tags
		return GetAnimationsByTagsNoExtra(ActorCount,tags,supressedTags,RequireAll)
	endif
	if !RequireAll ; Do not require all
		return GetAnimationsByTagsNoRequireAll(ActorCount,tags,supressedTags)
	endif
	int n = GetNumberOfTags(DefaultSexlabExtraTags)
	; Require all tags
	sslBaseAnimation[] anims = SexLab.GetAnimationsByTags(ActorCount, AddTag(tags,DefaultSexlabExtraTags), supressedTags, true)
	if anims.length != 0
		LogTrace("GetAnimationsByTags Number of extra tags="+n+" number of anims="+anims.length)
		return anims
	endif
	; try only one extra tag at a time
	int itag = RandomInt(0,n-(1))
	string extraTag = GetTagByIndex(itag,DefaultSexlabExtraTags)
	anims = SexLab.GetAnimationsByTags(ActorCount, AddTag(tags,extraTag), supressedTags, true)
	LogTrace("GetAnimationsByTags Number of extra tags="+n+" Selected extra tag: itag="+itag+" "+extraTag+" number of anims="+anims.length)
	if anims.length != 0
		LogTrace("GetAnimationsByTags Tag loop success itag="+itag)
		return anims
	endif
	; Will need to loop
	int j = itag + 1
	while j < n
		extraTag = GetTagByIndex(j,DefaultSexlabExtraTags)
		anims = SexLab.GetAnimationsByTags(ActorCount, AddTag(tags,extraTag), supressedTags, true)
		LogTrace("GetAnimationsByTags Number of extra tags="+n+" Selected extra tag: itag="+j+" "+extraTag+" number of anims="+anims.length)
		if anims.length != 0
			LogTrace("GetAnimationsByTags Tag loop success itag="+j)
			return anims
		endif
		j += 1
	endwhile
	j = 0
	while j < itag
		extraTag = GetTagByIndex(j,DefaultSexlabExtraTags)
		anims = SexLab.GetAnimationsByTags(ActorCount, AddTag(tags,extraTag), supressedTags, true)
		LogTrace("GetAnimationsByTags Number of extra tags="+n+" Selected extra tag: itag="+j+" "+extraTag+" number of anims="+anims.length)
		if anims.length != 0
			LogTrace("GetAnimationsByTags Tag loop success itag="+j)
			return anims
		endif
		j += 1
	endwhile
	; Failure, try without extra tags
	anims = SexLab.GetAnimationsByTags(ActorCount, tags, supressedTags, true)
	if anims.length != 0
		LogTrace("GetAnimationsByTags NO EXTRA TAGS number of anims="+anims.length)
		return anims
	endif
	; try without RequireAll
	anims = SexLab.GetAnimationsByTags(ActorCount, tags, supressedTags, false)
	if anims.length != 0
		LogTrace("GetAnimationsByTags NO EXTRA TAGS AND NOT REQUIRE ALL number of anims="+anims.length)
		return anims
	endif
	; Failure, try without tags
	anims = SexLab.GetAnimationsByTags(ActorCount, "", supressedTags, false)
	if anims.length != 0
		LogTrace("GetAnimationsByTags NO TAGS AT ALL AND NOT REQUIRE ALL! number of anims="+anims.length)
		return anims
	endif
	; Failure, last try
	anims = SexLab.GetAnimationsByTags(ActorCount, "", "", false)
	LogTrace("GetAnimationsByTags NO TAGS AT ALL NO SUPPRESSION AND NOT REQUIRE ALL! number of anims="+anims.length)
	return anims
EndFunction

sslBaseAnimation Function GetbyRegistrar(string the_reg)
	if Sexlab == None
		return None
	endif
	return Sexlab.AnimSlots.GetbyRegistrar(the_reg)
EndFunction

Function UndressActorBeforeSex(sslThreadModel Model, Actor akRef, DOM_Actor akActor, DOM_Actor akAgressor, bool is_aggressive)
	if akRef == PlayerRef
		Model.DisableUndressAnimation(akRef)
		return
	endif
	if !undressBeforeSex
		Model.DisableUndressAnimation(akRef)
	elseIf is_aggressive && akRef.GetWornForm(4) != None
		StripActor(akRef, akRef)
	Else
		StripActor(akRef)
	endif
	if akActor == None
		return
	endif
	string the_order = "UndressBeforeSex"
	akActor.RegisterForOrder(None,the_order,"",is_aggressive)
	DOMCore.SendDOMOrder(None,the_order,"",is_aggressive)
EndFunction

bool Function isValidActor(Actor akRef, DOM_Actor akActor = None)
	if akActor == None && akRef == None
		LogTrace("Actor is not valid")
		return false
	endif
	return true
EndFunction

bool Function isTiedActor(Actor akRef)
	if akRef.isInFaction(DOMActionTied)
		return true
	endif
	if DOMCore.DOMPAH.isTied(akRef)
		return true
	endif
	return false
EndFunction

bool Function isFemdom(Actor akRef, int actorSex)
	;LogTrace("isFemdom akRef="+akRef+" actorSex="+actorSex)
	if akRef == PlayerRef && actorSex == 1
		return true
	endif
	return false
EndFunction

int Function GetActorSex(Actor akRef, DOM_Actor akActor)
	if akActor == None 
		return GetGender(akRef)
	endif
	akActor.was_sexlab_ended = false
	return akActor.actorSex % 2
EndFunction

Function TrainFaction(Actor akTarget, Faction the_faction, int value)
	int rank = akTarget.GetFactionRank(the_faction)
	if rank >= 255
		return
	endif
	if rank < 0
		rank = 0
	endif
	rank += value
	if rank > 255
		rank = 255
	endif
	akTarget.SetFactionRank(the_faction,rank)
EndFunction

Function TrainVirginity(Actor akTarget, Faction the_faction)
	int rank = akTarget.GetFactionRank(the_faction)
	if rank > 1 ; already processed
		return
	endif
	if akTarget.IsInFaction(DOMAnimatingWithPlayer)
		akTarget.SetFactionRank(the_faction,2)
	else
		akTarget.SetFactionRank(the_faction,3)
	endif
EndFunction

Function TrainSex(Actor akTarget, Faction the_faction, Faction the_mod, string sl_stat, float base_amount)
	if !akTarget.IsInFaction(the_faction)
		float x = GetStat(akTarget, sl_stat)
		base_amount += x
	endif
	TrainFaction(akTarget,the_faction,(GetTrainingValue(akTarget,the_faction,the_mod,base_amount) as int))
EndFunction

float Function GetTrainingValue(Actor akTarget, Faction the_faction, Faction the_mod, float base_amount)
	if !akTarget.IsInFaction(the_mod)
		return base_amount
	endif
	float mod = GetModifierFromFaction(akTarget,the_mod)
	float the_training = akTarget.GetFactionRank(the_faction)
	if the_training < 0.0
		the_training = 0.0
	endif
	if the_training >= 100.0
		return 0.0
	endif
	float multiplier = 0.1 + (0.9*(1.0-(the_training/100.0)))
	return (multiplier*mod*base_amount)
EndFunction

Function TrainNPC(Actor akTarget)
	if akTarget == None
		return
	endif
	if akTarget.GetFactionRank(DOMAnimatingFaction) != 2 ; 2 is sex animation
		return
	endif
	akTarget.RemoveFromFaction(DOMAnimatingFaction)
	if akTarget.IsInFaction(DOMAnimatingVaginal)
		TrainVirginity(akTarget,DOMVirginVaginal)
		TrainSex(akTarget,DOMTrainVaginal,DOMModVaginal,"Vaginal",5.0)
		akTarget.RemoveFromFaction(DOMAnimatingVaginal)
	endif
	if akTarget.IsInFaction(DOMAnimatingAnal)
		TrainVirginity(akTarget,DOMVirginAnal)
		TrainSex(akTarget,DOMTrainAnal,DOMModAnal,"Anal",5.0)
		akTarget.RemoveFromFaction(DOMAnimatingAnal)
	endif
	if akTarget.IsInFaction(DOMAnimatingOral)
		TrainVirginity(akTarget,DOMVirginOral)
		TrainSex(akTarget,DOMTrainOral,DOMModOral,"Oral",5.0)
		akTarget.RemoveFromFaction(DOMAnimatingOral)
	endif
	if akTarget.IsInFaction(DOMAnimatingThreesome)
		TrainVirginity(akTarget,DOMVirginGangbang)
		akTarget.RemoveFromFaction(DOMAnimatingThreesome)
	endif
	if akTarget.IsInFaction(DOMAnimatingSame)
		TrainVirginity(akTarget,DOMVirginSame)
		akTarget.RemoveFromFaction(DOMAnimatingSame)
	endif
	if akTarget.IsInFaction(DOMAnimatingWithPlayer)
		TrainFaction(akTarget,DOMNbSex,1)
		if akTarget.IsInFaction(DOMAnimatingAggressive)
			TrainFaction(akTarget,DOMNbRape,1)
			akTarget.RemoveFromFaction(DOMAnimatingAggressive)
		endif
		akTarget.RemoveFromFaction(DOMAnimatingWithPlayer)
	elseif akTarget.IsInFaction(DOMAnimatingAggressive)
		akTarget.RemoveFromFaction(DOMAnimatingAggressive)		
	endif
EndFunction

Function SetSexFlags(Actor akTarget, DOM_Actor akActor, bool has_player, bool is_aggressive, bool is_dominant, bool is_threesome, string tags)
	if akActor == None
		SetSexFlagsNPC(akTarget, has_player, is_aggressive, is_threesome)
		return
	endif
	DOM_Mind akMind = akActor.mind
	akMind.sex_is_dominant = is_dominant
	akMind.sex_with_player = has_player
	akMind.sex_is_threesome = is_threesome
	akMind.sex_with_animal = false
	akMind.sex_with_undead = false
	akMind.sex_with_creature = false
	akMind.sex_with_animunculi = false
	akMind.sex_is_interracial = false
	akMind.sex_with_taboo = false
	akMind.sex_with_inlaw = false
	akMind.sex_with_relative = false
	string[] global_tags = PapyrusUtil.StringSplit(tags,",")
	akMind.SetSexTags(global_tags)
	LogTrace("SetSexFlags: "+akActor.GetName()+" sex_is_interracial="+akMind.sex_is_interracial+" sex_with_undead="+akMind.sex_with_undead+" sex_with_animal="+akMind.sex_with_animal+" sex_with_creature="+akMind.sex_with_creature+" sex_with_animunculi="+akMind.sex_with_animunculi)
EndFunction

Function SetSexFlagsNPC(Actor akTarget, bool has_player, bool is_not_consensual, bool is_threesome)
	if akTarget == None
		return
	endif
	if has_player
		akTarget.SetFactionRank(DOMAnimatingWithPlayer,1)
	endif
	if is_not_consensual
		akTarget.SetFactionRank(DOMAnimatingAggressive,1)
	endif
	if is_threesome
		akTarget.SetFactionRank(DOMAnimatingThreesome,1)
	endif
EndFunction

Function handleSexStartNPC(Actor akTarget, bool is_vaginal, bool is_anal, bool is_oral, bool is_same_sex)
	if akTarget == None
		return
	endif
	if is_vaginal
		akTarget.SetFactionRank(DOMAnimatingVaginal,1)
	endif
	if is_anal
		akTarget.SetFactionRank(DOMAnimatingAnal,1)
	endif
	if is_oral
		akTarget.SetFactionRank(DOMAnimatingOral,1)
	endif
	if is_same_sex
		akTarget.SetFactionRank(DOMAnimatingSame,1)
	endif
EndFunction

Function SetSpecialFlags(Actor actor1, DOM_Actor akActor1, Actor actor2, DOM_Actor akActor2)
	if akActor1 == None
		return
	endif
	DOM_Mind akMind1 = akActor1.mind
	if actor2.HasKeywordString("ActorTypeAnimal")
		akMind1.sex_with_animal = true
	endif
	if actor2.HasKeywordString("ActorTypeUndead")
		akMind1.sex_with_undead = true
	endif
	if actor2.HasKeywordString("ActorTypeCreature")
		akMind1.sex_with_creature = true
	endif
	if actor2.HasKeywordString("ActorTypeDwarven")
		akMind1.sex_with_animunculi = true
	endif
	if akActor2 != none
		if IsInterracial(akActor1.actorRace,akActor2.actorRace)
			akMind1.sex_is_interracial = true
		endif
	elseif IsInterracial(akActor1.actorRace,DOMCore.GetActorRace(actor2))
		akMind1.sex_is_interracial = true
	endif				
	int rel12 = DOMCore.GetFriendshipType(actor1,actor2)
	if rel12 >= 3 && rel12 <= 7 ; parents, siblings, grand-parents
		LogTrace("Setting sex to taboo for "+akActor1.getName()+" with "+actor2.GetDisplayName())
		akMind1.sex_with_taboo = true
	elseif rel12 >= 18 && rel12 <= 20 ; in-laws
		LogTrace("Setting sex with inlaw for "+akActor1.getName()+" with "+actor2.GetDisplayName())
		akMind1.sex_with_inlaw = true
	elseif rel12 >= 8 && rel12 <= 17 ; other relatives
		LogTrace("Setting sex with relative for "+akActor1.getName()+" with "+actor2.GetDisplayName())
		akMind1.sex_with_relative = true
	endif
	LogTrace("SetSpecialFlags: "+akActor1.GetName()+" sex_is_interracial="+akMind1.sex_is_interracial+" sex_with_undead="+akMind1.sex_with_undead+" sex_with_animal="+akMind1.sex_with_animal+" sex_with_creature="+akMind1.sex_with_creature+" sex_with_animunculi="+akMind1.sex_with_animunculi)
EndFunction

Actor Function GetReadyForScene(Actor akRef, DOM_Actor akActor)
	if akRef == None
		if akActor != None
			akRef = akActor.akRef
		else
			akRef = PlayerRef
		endif
	endif
	;LogTrace("GetReadyForScene akRef="+akRef)
	if akActor != None
		string the_order = "DoStandUpAndCalm"
		akActor.RegisterForOrder(None,the_order,"",true)
		DOMCore.SendDOMOrder(None,the_order,"",true)
	else
		StandUpActor(akRef)
		CalmActorFast(akRef)
	endif
	akRef.SetFactionRank(DOMAnimatingFaction,2) ; 2 is sex animation
	return akRef
EndFunction

bool Function isActorPlayer(int n, Actor[] akActors)
	int i = 0
	while i < n
		if akActors[i] == PlayerRef
			return true
		endif
		i+= 1
	endWhile
	return false
EndFunction

string Function GetSuppressedTags(Actor akRef,  bool is_allgirls, bool is_aggressive, bool is_femdom, bool has_player)
	string supressedTags
	If isTiedActor(akRef)
		supressedTags = "SubSub"
	Else
		supressedTags = ""
	endif
	If !is_allgirls
		supressedTags = AddTag(supressedTags,"Lesbian,FF")
	endif
	if has_player && !is_femdom
		supressedTags = AddTag(supressedTags,"femdom")
	endif
	return supressedTags
EndFunction

string Function GetAdditionalTags(string tags, Actor akRef, bool is_allgirls, bool is_aggressive, bool is_femdom, bool has_player, int nbActors)
	If isTiedActor(akRef)
		tags = AddTag(tags,"Wrists")
	endif
	If is_aggressive && useAggressiveTag
		tags = AddTag(tags,"Aggressive")
	endif
	If is_allgirls
		tags = AddTag(tags,"Lesbian")
	endif
	if has_player && is_femdom
		tags = AddTag(tags,"femdom")
	endif
	if is_femdom && stringUtil.find(tags,"Oral") >= 0 ; female is licked
		tags = AddTag(tags,"Cunnilingus")
	endif
	return tags
EndFunction

Function StartNotSexlab(Actor[] akActors, DOM_Actor[] akDOMActors, string tags, bool is_punishment = false, string reason_name = "")
	int nac = checkValidActors(akActors, akDOMActors)
	if nac < 1
		return
	endif
	akActors = ActorsReadyForScene(nac,akActors, akDOMActors)
	
	bool has_player    = isActorPlayer(nac,akActors)
	bool is_aggressive = isAggressiveScene(nac,akActors[0],is_punishment)

	int[] actorsSex = GetActorsSex(nac,akActors, akDOMActors)

	; add a few necessary tags
	;Wait(5.0)
	if stringUtil.find(tags,"Oral") < 0 && stringUtil.find(tags,"Vaginal") < 0 && stringUtil.find(tags,"Anal") < 0
		tags = AddTag(tags,"Oral,Vaginal,Anal")
	endif
	tags =  AddTag(tags,DefaultSexlabExtraTags)
	if is_aggressive
		if tags == ""
			tags = "Aggressive"
		else
			tags += ",Aggressive"
		endif
	endif
	string[] tag_list = PapyrusUtil.StringSplit(tags)
	
	; Set Dominant/submissive actors and other flags
	ActorsFlagsForScene(nac,akActors, akDOMActors, has_player, is_aggressive, tags)
	
	; start sex
	int i = 0
	while i < nac
		if akDOMActors[i] != None
			akDOMActors[i].OnSexStart(None, has_player, is_aggressive) ; hasPlayer, isNotConsensual=aggro
		endif
		SetAnimatingFaction(akActors[i])
		i += 1
	endwhile
	If is_aggressive && nac > 1 && akDOMActors[0] != None
		akDOMActors[0].StartPunishingByActor(akActors[1], reason_name, "rape")
	endif	

	; NPCs
	bool is_vaginal = false
	bool is_anal    = false
	bool is_oral    = false		
	bool is_same_sex = false	
	If StringHasTag(tags,"Vaginal")
		is_vaginal = true
	endif
	If StringHasTag(tags,"Anal")
		is_anal = true
	endif
	If StringHasTag(tags,"Oral")
		is_oral = true
	endif
	If StringHasTag(tags,"Lesbian") || StringHasTag(tags,"Gay")
		is_same_sex = true
	else
		is_same_sex = true
		i = 1
		while i < nac
			if ((actorsSex[i])%2) != ((actorsSex[0])%2)
				is_same_sex = false
			endif
			i += 1
		endwhile
	endif
	if !is_vaginal && !is_anal && !is_oral ; safe check
		is_vaginal = true
		is_anal    = true
		is_oral    = true
	endif

	ActorsStartScene(nac,akActors, akDOMActors, tag_list, is_vaginal, is_anal, is_oral, is_same_sex)

	Wait(10.0)

	; check orgasm
	ActorsCheckOrgasm(nac,akActors, akDOMActors, has_player)
	
	Wait(10.0)

	; end sex
	ActorsEndScene(nac,akActors, akDOMActors, tag_list, has_player)

	Wait(10.0)
	
	i = 0
	while i < nac
		ClearAnimatingFaction(akActors[i])
		i += 1
	endwhile
EndFunction

Function QuickStart(Actor actor0, Actor actor1, string hook)
	DOM_Actor akDOMActor0 = DOMCore.GetActor(actor0)
	DOM_Actor akDOMActor1 = DOMCore.GetActor(actor1)
	if akDOMActor0 == None && akDOMActor1 == None && Sexlab != None
		Sexlab.QuickStart(actor0, actor1, none, none, none, none, hook)
	endif
	bool is_punishment = false
	Actor[] akActors        = new Actor[2]
	DOM_Actor[] akDOMActors = new DOM_Actor[2]
	akActors[0]    = actor0
	akDOMActors[0] = akDOMActor0
	akActors[1]    = actor1
	akDOMActors[1] = akDOMActor1
	StartSexlabWithArrays(akActors, akDOMActors, "", "", is_punishment, "", None, true, hook)
EndFunction

Function QuickStartThreesome(Actor actor0, Actor actor1, Actor actor2, Actor actor3, Actor actor4, string hook)
	DOM_Actor akDOMActor0 = DOMCore.GetActor(actor0)
	DOM_Actor akDOMActor1 = DOMCore.GetActor(actor1)
	DOM_Actor akDOMActor2 = DOMCore.GetActor(actor2)
	DOM_Actor akDOMActor3 = DOMCore.GetActor(actor3)
	DOM_Actor akDOMActor4 = DOMCore.GetActor(actor4)
	if akDOMActor0 == None && akDOMActor1 == None && akDOMActor2 == None && akDOMActor3 == None  && akDOMActor4 == None && Sexlab != None
		Sexlab.QuickStart(actor0, actor1, actor2, actor3, actor4, actor0, hook)
		return
	endif
	bool is_punishment = false
	Actor[] akActors        = new Actor[5]
	DOM_Actor[] akDOMActors = new DOM_Actor[5]
	akActors[0]    = actor0
	akDOMActors[0] = akDOMActor0
	akActors[1]    = actor1
	akDOMActors[1] = akDOMActor1
	akActors[2]    = actor2
	akDOMActors[2] = akDOMActor2
	akActors[3]    = actor3
	akDOMActors[3] = akDOMActor3
	akActors[4]    = actor4
	akDOMActors[4] = akDOMActor4
	StartSexlabWithArrays(akActors, akDOMActors, "", "", is_punishment, "", None, true, hook)
EndFunction

Function StartSex(Actor[] sexActors, sslBaseAnimation[] anims, Actor victim=None, bool allowBed=false, string hook="")
	if !sexActors
		return
	endif
	int n = sexActors.length
	LogTrace("StartSex: nactors="+n)
	if n < 1 
		return
	endif
	int i = 0
	int k = 0
	bool no_dom_actor = true
	Actor[] akActors = new Actor[8]
	DOM_Actor[] akDOMActors = new DOM_Actor[8]
	while i < n && i < 8 && k < 8
		if sexActors[i] != None
			akActors[k]    = sexActors[i]
			akDOMActors[k] = DOMCore.GetActor(sexActors[i])
			if akDOMActors[k] != None
				no_dom_actor = false
			endif
			LogTrace("StartSex: n="+k+" actor="+akActors[k].GetDisplaYname()+" DOM_Actor="+akDOMActors[k])
			k += 1
		endif
		i += 1
	endwhile
	if no_dom_actor && Sexlab != None
		LogTrace("StartSex: Start Sexlab without any DOM_Actor")
		Sexlab.StartSex(sexActors, anims, victim, None, allowBed, hook)
		return
	endif
	if k == 1 && !no_dom_actor
		LogTrace("StartSex: Start masturbating DOM_Actor")
		akDOMActors[0].DoMasturbate(None,"")
		return
	endif
	bool is_punishment = true
	if Victim == None
		is_punishment = false
	endif
	LogTrace("StartSex: Start sex scene for DOM_Actor")
	StartSexlabWithAnims(akActors, akDOMActors, "", "", is_punishment, "", anims, None, allowBed, hook)
EndFunction

int Function checkValidActors(Actor[] akActors, DOM_Actor[] akDOMActors)
	int nac = akActors.length
	if nac < 1
		return 0
	endif
	if nac > 8 
		nac = 8 ; limit to 8 actors in scene
	endif
	int nad = akDOMActors.length
	if nad < 1
		return 0
	endif
	if nad < nac
		nac = nad
	endif
	int i = 0
	while i < nac
		if !isValidActor(akActors[i],akDOMActors[i])
			return 0
		endif
		i += 1
	endwhile
	return nac
EndFunction

Actor[] Function ActorsReadyForScene(int nac, Actor[] akActors, DOM_Actor[] akDOMActors)
	int i = 0
	while i < nac
		akActors[i] = GetReadyForScene(akActors[i],akDOMActors[i])
		i += 1
	endwhile
	if nac == 1
		if akDOMActors[0] != None
			akDOMActors[0].has_sex_alone = true
		endif
	endif		
	return akActors
EndFunction

Function ActorsFlagsForScene(int nac, Actor[] akActors, DOM_Actor[] akDOMActors, bool has_player, bool is_aggressive, string tags)
	bool is_threesome = (nac > 2)
	int i = 0
	while i < nac
		if i == 0
			SetSexFlags(akActors[i],akDOMActors[i],has_player,is_aggressive,false,is_threesome,tags) ; is_dominant, 
		else
			SetSexFlags(akActors[i],akDOMActors[i],has_player,false,true,is_threesome,tags)
		endif
		i += 1
	endwhile
	i = 0
	while i < nac
		int j = 0
		while j < nac
			if i != j
				SetSpecialFlags(akActors[i],akDOMActors[i],akActors[j],akDOMActors[j]) 
			endif
			j += 1
		endwhile
		i += 1
	endwhile
EndFunction

Function ActorsNPCStartScene(int nac, Actor[] akActors, DOM_Actor[] akDOMActors, bool is_vaginal,bool is_anal, bool is_oral, bool is_same_sex)
	int i = 0
	while i < nac
		if akDOMActors[i] == None && akActors[i] != PlayerRef
			handleSexStartNPC(akActors[i],is_vaginal,is_anal,is_oral,is_same_sex)
		endif
		i += 1
	endwhile
EndFunction

Function ActorsStartScene(int nac, Actor[] akActors, DOM_Actor[] akDOMActors, string[] tag_list, bool is_vaginal,bool is_anal, bool is_oral, bool is_same_sex)
	int i = 0
	while i < nac
		if akDOMActors[i] != None && akDOMActors[i].mind != None
			if i == 0
				akDOMActors[i].mind.handleSexStart(true, tag_list)
			else
				akDOMActors[i].mind.handleSexStart(false, tag_list)
			endif
		elseif akActors[i] != PlayerRef
			handleSexStartNPC(akActors[i],is_vaginal,is_anal,is_oral,is_same_sex)
		endif
		i += 1
	endwhile
EndFunction

Function ActorsCheckOrgasm(int nac, Actor[] akActors, DOM_Actor[] akDOMActors, bool has_player)
	int i = 0
	while i < nac
		if akDOMActors[i] != None && akDOMActors[i].mind != None
			akDOMActors[i].mind.handleSexOrgasm(has_player)
		endif
		i += 1
	endwhile
EndFunction

Function ActorsEndScene(int nac, Actor[] akActors, DOM_Actor[] akDOMActors, string[] tag_list, bool has_player)
	int i = 0
	while i < nac
		if akDOMActors[i] != None
			if akDOMActors[i].mind != None
				akDOMActors[i].mind.handleSexEnd(tag_list,has_player)
			endif
			akDOMActors[i].SexlabEndScene()
		elseif akActors[i] != PlayerRef
			TrainNPC(akActors[i])
		endif
		i += 1
	endwhile
EndFunction

bool Function isAggressiveScene(int nac, Actor akRef, bool is_punishment)
	if nac < 2
		return false
	endif
	if isTiedActor(akRef)
		return true
	endif
	if is_punishment
		if alwaysGentleToggle
			return false
		endif
		return true
	elseif alwaysAggressiveToggle
		return true
	endif
	return false
EndFunction

int[] Function GetActorsSex(int nac, Actor[] akActors, DOM_Actor[] akDOMActors)
	int[] actorsSex = new int[8]
	int i = 0
	while i < nac
		actorsSex[i] = GetActorSex(akActors[i],akDOMActors[i])
		i += 1
	endwhile
	return actorsSex
EndFunction

Function StartSexlabWithArrays(Actor[] akActors, DOM_Actor[] akDOMActors, string tied_pose, string tags = "", bool is_punishment = false, string reason_name = "", ObjectReference CenterOn = None, bool AllowBed = true, string Hook = "")
	int nac = checkValidActors(akActors, akDOMActors)
	if nac < 1
		return
	endif
	LogTrace("StartSexlabWithArrays: with "+nac+" actors")
	akActors = ActorsReadyForScene(nac,akActors, akDOMActors)
	
	bool use_anims     = false
	bool has_player    = isActorPlayer(nac,akActors)
	bool is_aggressive = isAggressiveScene(nac,akActors[0],is_punishment)
	If !isTiedActor(akActors[0])
		tied_pose = ""
	endif
	
	int[] actorsSex = GetActorsSex(nac,akActors, akDOMActors)
	bool is_allgirls = true
	bool femdom      = false
	bool has_NPCs    = false
	int i = 0
	while i < nac
		if ((actorsSex[i])%2)==0
			is_allgirls = false
		endif
		if akActors[i] == PlayerRef && ((actorsSex[i])%2)==1
			femdom = true
		endif
		if akActors[i] != PlayerRef && akDOMActors[i] == None
			has_NPCs = true
		endif
		i += 1
	endwhile
	if !has_player && nac > 1
		if ((actorsSex[i])%2)==1
			femdom = true
		endif
	endif
	LogTrace("StartSexlabWithArrays: is_allgirls="+is_allgirls+" femdom="+femdom+" is_aggressive="+is_aggressive+" has_player="+has_player)
	
	; Set up tags
	LogTrace("StartSexlabWithArrays: tags="+tags)
	string startingAnim = tied_pose
	string supressedTags = GetSuppressedTags(akActors[0],is_allgirls,is_aggressive,femdom,has_player)
	tags = GetAdditionalTags(tags,akActors[0],is_allgirls,is_aggressive,femdom,has_player,2)
	sslBaseAnimation[] anims
	if !use_anims
		if femdom && !is_allgirls && is_aggressive ; && !is_threesome
			anims = GetAggressiveFMAnims()
			use_anims = true
		endif
	endif
	LogTrace("StartSexlabWithArrays: Use anims="+use_anims)
	LogTrace("StartSexlabWithArrays: all tags="+tags)
	
	if DOMOstim.DOM_HasOstim.GetValue() == 1
		if ((!startSexlabPreferablyPlayer &&  has_player) || (!startSexlabPreferablyNPC && !has_player && has_NPCs) || (!startSexlabPreferablyDOM && !has_player && !has_NPCs))
			LogTrace("StartSexlabWithArrays: USING OSTIM")
			DOMOstim.StartOStimWithArrays(akActors, akDOMActors, tags, is_aggressive, reason_name)
			return
		endif
	endif

	; Set Dominant/submissive actors and other flags
	ActorsFlagsForScene(nac,akActors, akDOMActors, has_player, is_aggressive, tags)
	
	If is_aggressive && nac > 1 && akDOMActors[0] != None
		akDOMActors[0].StartPunishingByActor(akActors[1], reason_name, "rape")
	endif	

	; NPCs
	bool is_vaginal = false
	bool is_anal    = false
	bool is_oral    = false		
	bool is_same_sex = false	
	If StringHasTag(tags,"Vaginal")
		is_vaginal = true
	endif
	If StringHasTag(tags,"Anal")
		is_anal = true
	endif
	If StringHasTag(tags,"Oral")
		is_oral = true
	endif
	If StringHasTag(tags,"Lesbian") || StringHasTag(tags,"Gay")
		is_same_sex = true
	else
		is_same_sex = true
		i = 1
		while i < nac
			if ((actorsSex[i])%2) != ((actorsSex[0])%2)
				is_same_sex = false
			endif
			i += 1
		endwhile
	endif
	if !is_vaginal && !is_anal && !is_oral ; safe check
		is_vaginal = true
		is_anal    = true
		is_oral    = true
	endif
	LogTrace("StartSexlabWithArrays: is_vaginal="+is_vaginal+" is_anal="+is_anal+" is_oral="+is_oral+" is_same_sex="+is_same_sex)

	ActorsNPCStartScene(nac,akActors, akDOMActors, is_vaginal, is_anal, is_oral, is_same_sex)

	; Sexlab is not installed
	if Sexlab == None
		LogTrace("StartSexlabWithArrays: LOAD SEXLAB FAILED")
		StartNotSexlab(akActors, akDOMActors, tags, is_punishment, reason_name)
		return
	endif

	; Check all actors are loaded
	bool all_loaded = true
	i = 0
	while i < nac
		if !(akActors[i].Is3DLoaded())
			all_loaded = false
		endif
		i += 1
	endwhile
	if !all_loaded
		LogTrace("StartSexlabWithArrays: LOAD ACTORS FAILED")
		StartNotSexlab(akActors, akDOMActors, tags, is_punishment, reason_name)
		return		
	endif
	
	; Start sexlab
	sslThreadModel Model = SexLab.NewThread()
	if Model == None
		LogTrace("StartSexlabWithArrays: LOAD MODEL FAILED")
		StartNotSexlab(akActors, akDOMActors, tags, is_punishment, reason_name)
		return
	endif

	; Add actors, females first
	bool allActorsAdded = true
	i = 0
	while i < nac
		bool is_victim = false
		if i == 0
			is_victim = is_aggressive
		endif
		if ((actorsSex[i])%2)==1
			if Model.AddActor(akActors[i], IsVictim = is_victim) < 0
				allActorsAdded = false
			endif
		endif
		i += 1
	endwhile
	; Next add males
	i = 0
	while i < nac
		bool is_victim = false
		if i == 0
			is_victim = is_aggressive
		endif
		if ((actorsSex[i])%2)!=1
			if Model.AddActor(akActors[i], IsVictim = is_victim) < 0
				allActorsAdded = false
			endif
		endif
		i += 1
	endwhile
	if !allActorsAdded
		LogTrace("StartSexlabWithArrays: ADD ACTOR FAILED")
		StartNotSexlab(akActors, akDOMActors, tags, is_punishment, reason_name)
		return
	endif

	; Setup Sexlab
	If !use_anims
		bool requireTags
		if nac <= 2
			requireTags = requireSLTags
		elseif nac == 3
			requireTags = requireSLTags3
		elseif nac >= 4
			requireTags = requireSLTags4
		endif
		anims = GetAnimationsByTags(nac, tags, supressedTags, requireTags)
		LogTrace("StartSexlabWithArrays: Number of animations found: "+anims.length)
	endif
	
	i = 0
	while i < nac
		bool is_victim = false
		DOM_Actor akAbuser = None
		if i == 0
			is_victim = is_aggressive
			if nac > 1
				akAbuser  = akDOMActors[1]
			endif
		endif
		UndressActorBeforeSex(Model,akActors[i],akDOMActors[i],akAbuser,is_victim)
		i += 1
	endwhile
	
	Model.SetAnimations(anims)
	If startingAnim != ""
		model.SetStartAnimationEvent(akActors[0], startingAnim)
	endif
	
	if CenterOn != None
		Model.CenterOnObject(CenterOn)
	endif
	Model.DisableBedUse(!AllowBed)
	if hook != ""
		Model.SetHook(hook)
	endif
	If is_aggressive
		Model.SetHook("PostRape")
		Model.DisableRedress(akActors[0])
		if akDOMActors[0] != None
			akDOMActors[0].SexlabAnimIn  = DOMCore.DOM_Anim.GetPostRapeAnimIn(akDOMActors[0])
			akDOMActors[0].SexlabAnimOut = DOMCore.DOM_Anim.GetPostRapeAnimOut(akDOMActors[0])
			model.setEndAnimationEvent(akActors[0], akDOMActors[0].SexlabAnimIn)
		else
			model.setEndAnimationEvent(akActors[0], DOMCore.DOM_Anim.GetPostRapeAnimInNPC(akActors[0]))
		endif
	Else
		Model.SetHook("PostFornicate")
	endif
	if Model.StartThread()
		return
	endif
	LogTrace("StartSexlabWithArrays: SEXLAB THREAD FAILED")
	StartNotSexlab(akActors, akDOMActors, tags, is_punishment, reason_name)
EndFunction


Function StartSexlabWithAnims(Actor[] akActors, DOM_Actor[] akDOMActors, string tied_pose, string tags, bool is_punishment, string reason_name, sslBaseAnimation[] anims, ObjectReference CenterOn = None, bool AllowBed = true, string Hook = "")
	if !anims
		StartSexlabWithArrays(akActors, akDOMActors, tied_pose, tags, is_punishment, reason_name, CenterOn, allowBed, hook)
		return
	endif
	int nac = checkValidActors(akActors, akDOMActors)
	if nac < 1
		return
	endif
	LogTrace("StartSexlabWithAnims: with "+nac+" actors")
	akActors = ActorsReadyForScene(nac,akActors, akDOMActors)
	
	bool use_anims     = true
	bool has_player    = isActorPlayer(nac,akActors)
	bool is_aggressive = isAggressiveScene(nac,akActors[0],is_punishment)
	If !isTiedActor(akActors[0])
		tied_pose = ""
	endif
	
	int[] actorsSex = GetActorsSex(nac,akActors, akDOMActors)
	bool is_allgirls = true
	bool femdom      = false
	bool has_NPCs    = false
	int i = 0
	while i < nac
		if ((actorsSex[i])%2)==0
			is_allgirls = false
		endif
		if akActors[i] == PlayerRef && ((actorsSex[i])%2)==1
			femdom = true
		endif
		if akActors[i] != PlayerRef && akDOMActors[i] == None
			has_NPCs = true
		endif
		i += 1
	endwhile
	if !has_player && nac > 1
		if ((actorsSex[i])%2)==1
			femdom = true
		endif
	endif
	LogTrace("StartSexlabWithAnims: is_allgirls="+is_allgirls+" femdom="+femdom+" is_aggressive="+is_aggressive+" has_player="+has_player)
	
	; Set up tags
	LogTrace("StartSexlabWithAnims: tags="+tags)
	string startingAnim = tied_pose
	string supressedTags = GetSuppressedTags(akActors[0],is_allgirls,is_aggressive,femdom,has_player)
	tags = GetAdditionalTags(tags,akActors[0],is_allgirls,is_aggressive,femdom,has_player,2)
	if !use_anims
		if femdom && !is_allgirls && is_aggressive ; && !is_threesome
			anims = GetAggressiveFMAnims()
			use_anims = true
		endif
	endif
	LogTrace("StartSexlabWithAnims: Use anims="+use_anims)
	LogTrace("StartSexlabWithAnims: all tags="+tags)
	
	if DOMOstim.DOM_HasOstim.GetValue() == 1
		if ((!startSexlabPreferablyPlayer &&  has_player) || (!startSexlabPreferablyNPC && !has_player && has_NPCs) || (!startSexlabPreferablyDOM && !has_player && !has_NPCs))
			LogTrace("StartSexlabWithAnims: USING OSTIM")
			DOMOstim.StartOStimWithArrays(akActors, akDOMActors, tags, is_aggressive, reason_name)
			return
		endif
	endif

	; Set Dominant/submissive actors and other flags
	ActorsFlagsForScene(nac,akActors, akDOMActors, has_player, is_aggressive, tags)
	
	If is_aggressive && nac > 1 && akDOMActors[0] != None
		akDOMActors[0].StartPunishingByActor(akActors[1], reason_name, "rape")
	endif	

	; NPCs
	bool is_vaginal = false
	bool is_anal    = false
	bool is_oral    = false		
	bool is_same_sex = false	
	If StringHasTag(tags,"Vaginal")
		is_vaginal = true
	endif
	If StringHasTag(tags,"Anal")
		is_anal = true
	endif
	If StringHasTag(tags,"Oral")
		is_oral = true
	endif
	If StringHasTag(tags,"Lesbian") || StringHasTag(tags,"Gay")
		is_same_sex = true
	else
		is_same_sex = true
		i = 1
		while i < nac
			if ((actorsSex[i])%2) != ((actorsSex[0])%2)
				is_same_sex = false
			endif
			i += 1
		endwhile
	endif
	if !is_vaginal && !is_anal && !is_oral ; safe check
		is_vaginal = true
		is_anal    = true
		is_oral    = true
	endif
	LogTrace("StartSexlabWithAnims: is_vaginal="+is_vaginal+" is_anal="+is_anal+" is_oral="+is_oral+" is_same_sex="+is_same_sex)

	ActorsNPCStartScene(nac,akActors, akDOMActors, is_vaginal, is_anal, is_oral, is_same_sex)

	; Sexlab is not installed
	if Sexlab == None
		LogTrace("StartSexlabWithAnims: LOAD SEXLAB FAILED")
		StartNotSexlab(akActors, akDOMActors, tags, is_punishment, reason_name)
		return
	endif

	; Check all actors are loaded
	bool all_loaded = true
	i = 0
	while i < nac
		if !(akActors[i].Is3DLoaded())
			all_loaded = false
		endif
		i += 1
	endwhile
	if !all_loaded
		LogTrace("StartSexlabWithAnims: LOAD ACTORS FAILED")
		StartNotSexlab(akActors, akDOMActors, tags, is_punishment, reason_name)
		return		
	endif
	
	; Start sexlab
	sslThreadModel Model = SexLab.NewThread()
	if Model == None
		LogTrace("StartSexlabWithAnims: LOAD MODEL FAILED")
		StartNotSexlab(akActors, akDOMActors, tags, is_punishment, reason_name)
		return
	endif

	; Add actors, females first
	bool allActorsAdded = true
	i = 0
	while i < nac
		bool is_victim = false
		if i == 0
			is_victim = is_aggressive
		endif
		if ((actorsSex[i])%2)==1
			if Model.AddActor(akActors[i], IsVictim = is_victim) < 0
				allActorsAdded = false
			endif
		endif
		i += 1
	endwhile
	; Next add males
	i = 0
	while i < nac
		bool is_victim = false
		if i == 0
			is_victim = is_aggressive
		endif
		if ((actorsSex[i])%2)!=1
			if Model.AddActor(akActors[i], IsVictim = is_victim) < 0
				allActorsAdded = false
			endif
		endif
		i += 1
	endwhile
	if !allActorsAdded
		LogTrace("StartSexlabWithAnims: ADD ACTOR FAILED")
		StartNotSexlab(akActors, akDOMActors, tags, is_punishment, reason_name)
		return
	endif

	; Setup Sexlab
	If !use_anims
		bool requireTags
		if nac <= 2
			requireTags = requireSLTags
		elseif nac == 3
			requireTags = requireSLTags3
		elseif nac >= 4
			requireTags = requireSLTags4
		endif
		anims = GetAnimationsByTags(nac, tags, supressedTags, requireTags)
		LogTrace("StartSexlabWithAnims: Number of animations found: "+anims.length)
	endif
	
	i = 0
	while i < nac
		bool is_victim = false
		DOM_Actor akAbuser = None
		if i == 0
			is_victim = is_aggressive
			if nac > 1
				akAbuser  = akDOMActors[1]
			endif
		endif
		UndressActorBeforeSex(Model,akActors[i],akDOMActors[i],akAbuser,is_victim)
		i += 1
	endwhile
	
	Model.SetAnimations(anims)
	If startingAnim != ""
		model.SetStartAnimationEvent(akActors[0], startingAnim)
	endif
	
	if CenterOn != None
		Model.CenterOnObject(CenterOn)
	endif
	Model.DisableBedUse(!AllowBed)
	if hook != ""
		Model.SetHook(hook)
	endif
	If is_aggressive
		Model.SetHook("PostRape")
		Model.DisableRedress(akActors[0])
		if akDOMActors[0] != None
			akDOMActors[0].SexlabAnimIn  = DOMCore.DOM_Anim.GetPostRapeAnimIn(akDOMActors[0])
			akDOMActors[0].SexlabAnimOut = DOMCore.DOM_Anim.GetPostRapeAnimOut(akDOMActors[0])
			model.setEndAnimationEvent(akActors[0], akDOMActors[0].SexlabAnimIn)
		else
			model.setEndAnimationEvent(akActors[0], DOMCore.DOM_Anim.GetPostRapeAnimInNPC(akActors[0]))
		endif
	Else
		Model.SetHook("PostFornicate")
	endif
	if Model.StartThread()
		return
	endif
	LogTrace("StartSexlabWithAnims: SEXLAB THREAD FAILED")
	StartNotSexlab(akActors, akDOMActors, tags, is_punishment, reason_name)
EndFunction

Event PostRape(int tid, bool has_player)
	if Sexlab == None
		return
	endif
	sslThreadController controller = SexLab.GetController(tid)
	Actor Victim = controller.VictimRef

	Victim.AllowPCDialogue(false)
	Victim.SetDontMove()
	DOM_Actor akActor = DOMCore.GetActor(Victim)

	Wait(1.0)
	if akActor != None
		LogTrace("Animation: PostRape() "+akActor.SexlabAnimIn)
		Debug.SendAnimationEvent(Victim, akActor.SexlabAnimIn)
		Wait(postRapeDelay as float)
		LogTrace("Animation: PostRape() "+akActor.SexlabAnimOut)
		Debug.SendAnimationEvent(Victim, akActor.SexlabAnimOut)
		Wait(2.5)
	else
		Debug.SendAnimationEvent(Victim, DOMCore.DOM_Anim.GetPostRapeAnimInNPC(Victim))
		Wait(postRapeDelay as float)
		Debug.SendAnimationEvent(Victim, DOMCore.DOM_Anim.GetPostRapeAnimOutNPC(Victim))
		Wait(2.5)
	endif
	if akActor != None
		akActor.SexlabEndScene()
	elseif Victim != None && Victim != PlayerRef
		TrainNPC(Victim)
	endif
	Victim.AllowPCDialogue(true)
	Victim.SetDontMove(false)

	If Victim.IsInFaction(DOMActionTied)
		if akActor != None
			string the_pose = akActor.GetPose()
			LogTrace("Animation: PostRape() "+the_pose)
			Debug.SendAnimationEvent(Victim, the_pose)
		endif
	Else
		LogTrace("Animation: PostRape() IdleWipeBrow")
		Debug.SendAnimationEvent(Victim, "IdleWipeBrow")
	endif
	Wait(1.0)
	
	; Check all actor positions
	Actor[] Victims = controller.Positions
	int n = Victims.length
	LogTrace("PostRape() Number of actors="+n)
	int i = 0
	int k = 0
	while i < n
		Actor the_victim = Victims[i]
		if the_victim != None && the_victim != PlayerRef
			LogTrace("PostRape() actor "+i+" = "+the_victim.GetDisplayName())
			DOM_Actor the_actor = DOMCore.GetActor(the_victim)
			if the_actor != None
				the_actor.SexlabEndScene()
				k += 1
			else
				TrainNPC(the_victim)
			endif
		endif
		i += 1
	endwhile
	if k == 0 ; if actor list was not filled try aliases
		sslActorAlias[] ActorAlias = controller.ActorAlias
		n = ActorAlias.length
		LogTrace("PostRape() Number of aliases="+n)
		i = 0
		while i < n
			Actor the_victim = ActorAlias[i].ActorRef
			if the_victim != None && the_victim != PlayerRef
				LogTrace("PostRape() alias "+i+" = "+the_victim.GetDisplayName())
				DOM_Actor the_actor = DOMCore.GetActor(the_victim)
				if the_actor != None
					the_actor.SexlabEndScene()
					k += 1
				else
					TrainNPC(the_victim)
				endif
			endif
			i += 1
		endwhile
	endif
	if k == 0 ; if actor list was not filled try victims
		Victims = controller.Victims
		n = Victims.length
		LogTrace("PostRape() Number of victims="+n)
		i = 0
		while i < n
			Actor the_victim = Victims[i]
			if the_victim != None && the_victim != PlayerRef
				LogTrace("PostRape() victim "+i+" = "+the_victim.GetDisplayName())
				DOM_Actor the_actor = DOMCore.GetActor(the_victim)
				if the_actor != None
					the_actor.SexlabEndScene()
					k += 1
				else
					TrainNPC(the_victim)
				endif
			endif
			i += 1
		endwhile
	endif
EndEvent

Event PostFornicate(int tid, bool has_player)
	if Sexlab == None
		return
	endif
	sslThreadController controller = SexLab.GetController(tid)
	if controller == None
		return
	endif
	Actor Victim = controller.VictimRef

	wait(1.0)
	DOM_Actor akActor = DOMCore.GetActor(Victim)
	if akActor != None
		akActor.SexlabEndScene()
		If Victim.IsInFaction(DOMActionTied)
			string the_pose = akActor.GetPose()
			LogTrace("Animation: PostRape() "+the_pose)
			Debug.SendAnimationEvent(Victim, the_pose)
		endif
		if Victim != PlayerRef
			Victim.AllowPCDialogue(true)
		endif
		Victim.SetDontMove(false)
	elseif Victim != None
		TrainNPC(Victim)
		if Victim != PlayerRef
			Victim.AllowPCDialogue(true)
		endif
		Victim.SetDontMove(false)
	endif
	
	wait(1.0)

	; Check all actor positions
	Actor[] Victims = controller.Positions
	int n = Victims.length
	LogTrace("PostFornicate() Number of actors="+n)
	int i = 0
	int k = 0
	while i < n
		Actor the_victim = Victims[i]
		if the_victim != None && the_victim != PlayerRef
			LogTrace("PostFornicate() actor "+i+" = "+the_victim.GetDisplayName())
			DOM_Actor the_actor = DOMCore.GetActor(the_victim)
			if the_actor != None
				the_actor.SexlabEndScene()
				k += 1
			else
				TrainNPC(the_victim)
			endif
		endif
		i += 1
	endwhile
	if k == 0 ; if actor list was not filled try aliases
		sslActorAlias[] ActorAlias = controller.ActorAlias
		n = ActorAlias.length
		LogTrace("PostFornicate() Number of aliases="+n)
		i = 0
		while i < n
			Actor the_victim = ActorAlias[i].ActorRef
			if the_victim != None && the_victim != PlayerRef
				LogTrace("PostFornicate() alias "+i+" = "+the_victim.GetDisplayName())
				DOM_Actor the_actor = DOMCore.GetActor(the_victim)
				if the_actor != None
					the_actor.SexlabEndScene()
					k += 1
				else
					TrainNPC(the_victim)
				endif
			endif
			i += 1
		endwhile
	endif
	if k == 0 ; if actor list was not filled try victims
		Victims = controller.Victims
		n = Victims.length
		LogTrace("PostFornicate() Number of victims="+n)
		i = 0
		while i < n
			Actor the_victim = Victims[i]
			if the_victim != None && the_victim != PlayerRef
				LogTrace("PostFornicate() victim "+i+" = "+the_victim.GetDisplayName())
				DOM_Actor the_actor = DOMCore.GetActor(the_victim)
				if the_actor != None
					the_actor.SexlabEndScene()
					k += 1
				else
					TrainNPC(the_victim)
				endif
			endif
			i += 1
		endwhile
	endif
EndEvent


Function LogAnim(string msg)
	if DOMCore.verboseAnim
		Debug.Trace("DOM_Sexlab:Animation: "+msg)
	endif
EndFunction

Function LogInfo(string msg)
	Debug.Trace("DOM_Sexlab: "+msg)
EndFunction

Function LogTrace(string msg)
	if DOMCore.verboseMode
		Debug.Trace("DOM_Sexlab: "+msg)
	endif
EndFunction
