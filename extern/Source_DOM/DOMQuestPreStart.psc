;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname DOMQuestPreStart Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
;
DOMQuestPreStart(akSpeaker)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Faction Property DOMActorExcludedFaction Auto
ReferenceAlias Property Olava Auto
ReferenceAlias Property Kimli Auto
Package Property DOMKimliSitCross Auto

Function DOMQuestPreStart(Actor akSpeaker)
	Olava.GetActorRef().SetFactionRank(DOMActorExcludedFaction,1)
	Actor akRef = Kimli.GetActorRef()
	Package current_package = akRef.GetCurrentPackage()
	if current_package != DOMKimliSitCross
		ActorUtil.AddPackageOverride(akRef , DOMKimliSitCross, 127, 1)
	endif
EndFunction
