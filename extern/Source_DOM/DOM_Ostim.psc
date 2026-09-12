Scriptname DOM_Ostim extends Quest  
Import OLibrary
Import DOM_Util

Actor Property PlayerRef Auto
DOM_Core Property DOMCore Auto
DOM_API Property domfw Auto
DOM_Sexlab Property DOMSexlab Auto 
Faction Property OstimAnimatingFaction Auto Hidden
GlobalVariable Property DOM_HasOstim Auto 
Bool Property IsOCumInstalled = false Auto Hidden
Quest property OCum_API = None Auto Hidden

Function Initialize()
	LogInfo("===============================================================================")
	LogInfo("==                           DOM: Ostim interface                            ==")
	LogInfo("===============================================================================")
	If Game.GetModByName("OStim.esp") != 255
		DOM_HasOstim.SetValue(1)
		LogInfo(" Ostim found! has_ostim="+DOM_HasOstim.GetValue())
		OstimAnimatingFaction = Game.GetFormFromFile(0x00000ECA, "OStim.esp") As Faction ; OStimActorCountFaction
		RegisterForModEvent("ostim_start",  "OnSceneStart")
		RegisterForModEvent("ostim_orgasm", "OnOrgasm")
		RegisterForModEvent("ostim_end",    "OnSceneEnd")
		RegisterForModEvent("ostim_thread_end", "OnThreadEnd")	
	else
		DOM_HasOstim.SetValue(0)
		LogInfo(" WARNING: Ostim NOT FOUND! has_ostim="+DOM_HasOstim.GetValue())
		OstimAnimatingFaction = None
		UnRegisterForModEvent("ostim_start")
        UnRegisterForModEvent("ostim_orgasm")
		UnregisterForModEvent("ostim_end")
        UnregisterForModEvent("ostim_thread_end")
	endif
	If Game.GetModByName("OCum.esp") != 255
		IsOCumInstalled = true
		OCum_API = Quest.GetQuest("OCumQuest") as Quest ;0x001800
	Else
		IsOCumInstalled = false
		OCum_API = None
	EndIf
EndFunction

bool Function IsAnimating(Actor akRef)
	if OstimAnimatingFaction == None
		return false
	endif
	return akRef.IsInFaction(OstimAnimatingFaction)
EndFunction

Function ClearCum(Actor akRef)
	if OCum_API == None
		return
	endif
    OCum_API.OnAnimationEvent(akRef, "SoundPlay.FSTSwimSwim")
EndFunction

Function StartOStimWithArrays(Actor[] akActors, DOM_Actor[] akDOMActors, string tags, bool is_punishment = false, string reason_name = "")
	int nac = DOMSexlab.checkValidActors(akActors, akDOMActors)
	if nac < 2
		return
	endif
    string name1 = akActors[0].GetDisplayName()
    string name2 = akActors[1].GetDisplayName()
	LogTrace("StartOStimWithArrays: with "+nac+" actors "+name1+" and "+name2)	
	akActors = DOMSexlab.ActorsReadyForScene(nac,akActors, akDOMActors)
	
	bool has_player    = DOMSexlab.isActorPlayer(nac,akActors)
	bool is_aggressive = DOMSexlab.isAggressiveScene(nac,akActors[0],is_punishment)

	int[] actorsSex = DOMSexlab.GetActorsSex(nac,akActors, akDOMActors)

	if is_aggressive
		if tags == ""
			tags = "Aggressive"
		else
			tags += ",Aggressive"
		endif
	endif
	string[] tag_list = PapyrusUtil.StringSplit(tags)

	; Set Dominant/submissive actors and other flags
	DOMSexlab.ActorsFlagsForScene(nac,akActors, akDOMActors, has_player, is_aggressive, tags)

	; start sex
	int i = 0
	while i < nac
		if akDOMActors[i] != None
			akDOMActors[i].OnSexStart(None, has_player, is_aggressive) ; hasPlayer, isNotConsensual=aggro
		endif
		DOMSexlab.SetAnimatingFaction(akActors[i])
		i += 1
	endwhile
	If is_aggressive && nac > 1 && akDOMActors[0] != None
		akDOMActors[0].StartPunishingByActor(akActors[1], reason_name, "rape")
	endif	
		
	string ostim_tags = GetSLTagsToOStim(tags)
	string SceneName = GetRandomSceneWithSceneTag(akActors, ostim_tags)
	int TID = OThread.QuickStart(akActors, SceneName)
	LogTrace("StartOStimWithArrays: Starting Scene: " + SceneName+" TID="+TID)

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

	DOMSexlab.ActorsStartScene(nac,akActors, akDOMActors, tag_list, is_vaginal, is_anal, is_oral, is_same_sex)
EndFunction

Event OnSceneStart(String EventName, String sceneId, Float startThreadID, Form Sender)
	Actor the_actor = Sender as Actor
	LogTrace("OnSceneStart "+EventName+" scene="+sceneId+" TID="+(startThreadID as int)+" actor="+the_actor)
EndEvent

Event OnSceneEnd(String EventName, String sceneId, Float endThreadID, Form Sender)
	Actor the_actor = Sender as Actor
	LogTrace("OnSceneEnd "+EventName+" scene="+sceneId+" TID="+(endThreadID as int)+" actor="+the_actor)
EndEvent

Event OnOrgasm(String EventName, String OrgasmAnimation, Float OrgasmThreadID, Form Sender)
    Actor the_actor = Sender as Actor
    LogTrace("OnOrgasm "+EventName+" anim="+OrgasmAnimation+" TID="+(OrgasmThreadID as int)+" actor="+the_actor)
    if the_actor != None
		LogTrace(the_actor.GetDisplayName()+" had an orgasm!")
		if the_actor != PlayerRef
			DOM_Mind akMind = DOMCore.GetActorMind(the_actor)
			if akMind != None
				akMind.handleSexOrgasm(akMind.sex_with_player)
            else
                LogTrace("OnOrgasm for NPC="+the_actor)
            endif
        endif
	endif
EndEvent

Event OnThreadEnd(String EventName, String StrArgs, Float EndingThreadID, Form Sender)
	Actor the_actor = Sender as Actor
    LogTrace("OnSceneEnd "+EventName+" args="+StrArgs+" TID="+(EndingThreadID as int)+" actor="+the_actor)
	Actor[] participants = OThread.GetActors(EndingThreadID as int)
	if participants.length <= 0
		LogInfo("WARNING number of participants is ZERO")
		return
	endif
    int i = 0
    while i < participants.Length
		if participants[i] != PlayerRef
			DOM_Mind akMind = DOMCore.GetActorMind(participants[i])
			if akMind != None
				akMind.handleSexEnd(akMind.GetSexTags(),akMind.sex_with_player)
			else
				DOMSexlab.TrainNPC(participants[i])
			endif
			DOMSexlab.ClearAnimatingFaction(participants[i])
        endif
        i += 1
    endwhile
	DOMSexlab.ClearAnimatingFaction(the_actor)
EndEvent

;/
	POSITION_TAGS = new string[16]
	POSITION_TAGS[0]  = "allfours"
	POSITION_TAGS[1]  = "bendover"
	POSITION_TAGS[2]  = "facingaway"
	POSITION_TAGS[3]  = "handstanding"
	POSITION_TAGS[4]  = "kneeling"
	POSITION_TAGS[5]  = "lyingback"
	POSITION_TAGS[6]  = "facingaway"
	POSITION_TAGS[7]  = "lyingfront"
	POSITION_TAGS[8]  = "lyingside"
	POSITION_TAGS[9]  = "onbottom"
	POSITION_TAGS[10] = "ontop"
	POSITION_TAGS[11] = "sitting"
	POSITION_TAGS[12] = "spreadlegs"
	POSITION_TAGS[13] = "squatting"
	POSITION_TAGS[14] = "standing"
	POSITION_TAGS[15] = "suspended"
/;

string Function GetSLTagsToOStim(string sl_tags) ; multi tags function
	if sl_tags == ""
		return ""
	endif
	string tags = ""
	if stringUtil.find(sl_tags,"Missionary") >= 0
		tags = AddTag(tags,"lyingback")
	endif
	if stringUtil.find(sl_tags,"Doggy") >= 0 || stringUtil.find(sl_tags,"Doggystyle") >= 0
		tags = AddTag(tags,"allfours")
	endif
	if stringUtil.find(sl_tags,"Cowgirl") >= 0 || stringUtil.find(sl_tags,"ReverseCowgirl") >= 0
		tags = AddTag(tags,"ontop")
	endif
	if stringUtil.find(sl_tags,"Standing") >= 0
		tags = AddTag(tags,"standing")
	endif
	if stringUtil.find(sl_tags,"Aggressive") >= 0
		tags = AddTag(tags,"aggressive")
	endif
	if stringUtil.find(sl_tags,"Vaginal") >= 0
		tags = AddTag(tags,"vaginalsex")
	endif
	if stringUtil.find(sl_tags,"Oral") >= 0
		tags = AddTag(tags,"oralsex")
	endif
	if stringUtil.find(sl_tags,"Anal") >= 0
		tags = AddTag(tags,"analsex")
	endif
	return tags
EndFunction

Function LogInfo(string msg)
	Debug.Trace("DOM_OStim: "+msg)
EndFunction

Function LogTrace(string msg)
	if DOMCore.verboseMode
		Debug.Trace("DOM_OStim: "+msg)
	endif
EndFunction
