Scriptname SOA_RegisterEventsSexlabScript extends ActiveMagicEffect  

SOA_PartnerTrackingQuestScript	Property SOA_Arrays					Auto	;SOA_ActorList

Actor			Property mySelf							Auto
Quest			Property SOA_PartnerTrackingQuest		Auto
Quest			Property SOA_RegisterSexEvents			Auto
Actor[]			SexlabActors

Function OnEffectStart(Actor akTarget, Actor akCaster)
	UnregisterForAllModEvents()
	if (Game.GetModByName("SexLab.esm") != 255)
		RegisterForModEvent("AnimationStart", "AnimationStartEvent")
		RegisterForModEvent("AnimationEnd", "AnimationEndEvent")
		RegisterForModEvent("SexLabOrgasmSeparate", "SLSOEvent")
	endIf
EndFunction

Event AnimationStartEvent(string EventName, string argString, Float argNum, form sender)
	Debug.Trace("SOA_RegisterEventsSexlabScript AnimationStartEvent")
	RegisterForModEvent("AnimationStart", "AnimationStartEvent")
	SexLabFramework SexLab = GetMeMyForm(0x000D62, "SexLab.esm") as SexLabFramework
	SexlabActors = SexLab.HookActors(argString as string)
	sslBaseAnimation animation = SexLab.HookAnimation(argNum as String)
	if SexlabActors.find(mySelf)
		SOA_Arrays.SOA_PlayerStats[12] = 0.0
		int mySex = (GetMeMyForm(0xD62, "SexLab.esm") as SexLabFramework).GetGender(mySelf) as int
		If animation.hasTag("FM") || animation.hasTag("MF")
			Debug.Trace("SOA_RegisterEventsSexlabScript AnimationStartEvent 1 L="+SexlabActors.length)
			if SexlabActors.length > 2
				SexlabActors[2] = None
			endif
			Debug.Trace("SOA_RegisterEventsSexlabScript AnimationStartEvent 2")
			SOA_Arrays.SOA_PlayerStats[12] = 2.0	;two actors in sex scene
			Debug.Trace("SOA_RegisterEventsSexlabScript AnimationStartEvent 3")
		elseIf animation.hasTag("FFM") || animation.hasTag("MFF")
			SOA_Arrays.SOA_PlayerStats[12] = 3.2	;two Female and one Male actors in sex scene
		elseIf animation.hasTag("MMF") || animation.hasTag("FMM")
			SOA_Arrays.SOA_PlayerStats[12] = 3.1	;one Female and two Male actors in sex scene
		else
			SOA_Arrays.SOA_PlayerStats[12] = 2.9	;unknown sex scene
		endIf
		if SexlabActors.length > 2
			(SOA_PartnerTrackingQuest as SOA_PartnerTrackingQuestScript).SOA_AnimationStart(SexlabActors[0], SexlabActors[1], SexlabActors[2], mySex)
		else
			(SOA_PartnerTrackingQuest as SOA_PartnerTrackingQuestScript).SOA_AnimationStart(SexlabActors[0], SexlabActors[1], None, mySex)
		endif
	endIf
EndEvent

bool Function IsInArray(Actor[] actorArray, Actor akActor)
	int n = actorArray.length
	int i = 0
	while i < n
		if actorArray[i] == akActor
			return true
		endIf
		i += 1
	endwhile
	return false
EndFunction

Event AnimationEndEvent(string EventName, string argString, Float argNum, form sender)
	RegisterForModEvent("AnimationEnd", "AnimationEndEvent")		
	;SexlabActors = New Actor[3]
	SexLabFramework SexLab = GetMeMyForm(0x000D62, "SexLab.esm") as SexLabFramework
	SexlabActors = SexLab.HookActors(argString)
	string animHook = (argNum as String)
	sslBaseAnimation animation = SexLab.HookAnimation(animHook)
	
	if IsInArray(SexlabActors, mySelf)
		int mySex = (GetMeMyForm(0xD62, "SexLab.esm") as SexLabFramework).GetGender(mySelf) as int
		bool isVaginal = false
		bool isAnal = false
		bool isOral = false
		if animation.HasTag("Vaginal")
			isVaginal = true
		endIf
		if animation.HasTag("Anal")
			isAnal = true
		endIf
		if animation.HasTag("Oral")
			isOral = true
		endIf
		if SexlabActors.length > 2
			(SOA_PartnerTrackingQuest as SOA_PartnerTrackingQuestScript).SOA_AnimationEnd(SexlabActors[0], SexlabActors[1], SexlabActors[2],isVaginal, isAnal, isOral, mySex)
		else
			(SOA_PartnerTrackingQuest as SOA_PartnerTrackingQuestScript).SOA_AnimationEnd(SexlabActors[0], SexlabActors[1], None,isVaginal, isAnal, isOral, mySex)
		endif
	endIf
EndEvent

event SLSOEvent(Form actorRef = none, int SLSO_Int = -42)			
	RegisterForModEvent("SexLabOrgasmSeparate", "SLSOEvent")
	if ((actorRef == none) || (SLSO_Int == -42))
		return
	endIf
	SOA_Arrays.SOA_PlayerStats[37] = 1.0
	SexlabActors = New Actor[3]
	SexLabFramework SexLab = GetMeMyForm(0x000D62, "SexLab.esm") as SexLabFramework
	SexlabActors = SexLab.HookActors(SLSO_Int as string)
	Actor ActorCumming = actorRef as Actor
	if SOA_Arrays.SOA_PlayerStats[12] == 2.0
		SexlabActors[2] = None
	endIf
	(SOA_RegisterSexEvents as SOAQuestScript).SOA_SLSOEvent(SexlabActors[0], SexlabActors[1], SexlabActors[2],SLSO_Int, ActorCumming, true)
EndEvent

form function GetMeMyForm(int formNumber, string pluginName) global
	int theLO = Game.GetModByName(pluginName)
	if ((theLO == 255) || (theLO == 0)) ; 255 = not found, 0 = no skse
		Debug.Trace(pluginName + " not loaded or SKSE not found", 1)
		return none
	elseIf (theLO > 255) ; > 255 = ESL
		; the first FIVE hex digits in an ESL are its address, so a formNumber exceeding 0xFFF or below 0x800 is invalid
		if ((Math.LogicalAnd(0xFFFFF000, formNumber) != 0) || (Math.LogicalAnd(0x00000800, formNumber) == 0))
			Debug.Messagebox("Plugin " + pluginName + " has FormIDs outside the range\nallocated for ESL plugins!: " + formNumber)
			Debug.Trace("ESL-flagged plugin " + pluginName + " contains invalid FormIDs: " + formNumber, 2)
			return none
		endIf
		; getmodbyname reports an ESL as 256 higher than the game indexes it internally
		theLO -= 256
		return Game.GetFormEx(Math.LogicalOr(Math.LogicalOr(0xFE000000, Math.LeftShift(theLO, 12)), formNumber))
	else	; regular ESL-free plugin
		return Game.GetFormEx(Math.LogicalOr(Math.LeftShift(theLO, 24), formNumber))
	endIf
endFunction
