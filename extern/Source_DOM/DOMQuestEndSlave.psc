;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname DOMQuestEndSlave Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
;
DOMQuestEndSlave(akSpeaker)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

ReferenceAlias Property Kimli Auto
ReferenceAlias Property Olava Auto
Actor Property PlayerRef Auto
DOM_Core Property DOMCore Auto
DOM_SlaverManager Property DOM01 Auto
MiscObject Property Gold001 Auto
Message Property DOMFamilyRansomMessage Auto 

Faction Property DOMActionWaiting Auto
Faction Property DOMActionFollowing Auto
Faction Property DOMActionTied Auto
Faction Property DunPlayerAllyFaction Auto
Faction Property PotentialFollowerFaction Auto
Faction Property CurrentFollowerFaction Auto
Faction Property DOMActorFamilyFaction Auto
Faction Property DOMActorFamilyReunited Auto
Faction Property DOMActorExcludedFaction Auto

Function DOMQuestEndSlave(Actor akTarget)
	; Ransom Kimli
    int value = DOMCore.DOMGenerator.getActorPrice(Kimli.GetActorRef())
	int ibutton = DOMFamilyRansomMessage.show(value as float)  
	if ibutton != 0
		return
	endif
	; Olava
	If akTarget.GetRelationshipRank(PlayerRef) < 3
		akTarget.SetRelationshipRank(PlayerRef, 3)
	endif
	; Kimli
	Actor akRef = Kimli.GetActorRef()
	akRef.RemoveFromFaction(DOMActionWaiting)
	akRef.RemoveFromFaction(DOMActionTied)
	akRef.RemoveFromFaction(DOMActionFollowing)
	If akRef.GetRelationshipRank(PlayerRef) < 4
		akRef.SetRelationshipRank(PlayerRef, 4)
	endif
	akRef.SetPlayerTeammate(false)
	akRef.AddToFaction(DunPlayerAllyFaction)
	akRef.AddToFaction(PotentialFollowerFaction)
	akRef.SetFactionRank(CurrentFollowerFaction, -1)
	GetOwningQuest().SetStage(50)
	Kimli.Clear()
	ActorUtil.ClearPackageOverride(akRef)
	akRef.EvaluatePackage()
	; Release
 	DOM01.ReleaseActor(akRef)
	akRef.SetFactionRank(DOMActorFamilyReunited,1)
	akTarget.RemoveFromFaction(DOMActorFamilyFaction)
      PlayerRef.addItem(Gold001, value)
      Olava.GetActorRef().RemoveFromFaction(DOMActorExcludedFaction)
EndFunction


