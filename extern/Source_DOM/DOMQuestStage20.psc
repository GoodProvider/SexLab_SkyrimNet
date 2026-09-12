;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname DOMQuestStage20 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
;
DOMQuestSetStage20(akSpeaker)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Actor Property PlayerRef Auto
ReferenceAlias Property Kimli Auto
Package Property DOMKimliSitCross Auto

Function DOMQuestSetStage20(Actor akTarget)
	; Agnis
	If akTarget.GetRelationshipRank(PlayerRef) < 2
		akTarget.SetRelationshipRank(PlayerRef, 2)
	endif

	GetOwningQuest().SetStage(20)
	Actor akRef = Kimli.GetActorRef()
	Package current_package = akRef.GetCurrentPackage()
	if current_package != DOMKimliSitCross
		ActorUtil.AddPackageOverride(akRef , DOMKimliSitCross, 127, 1)
	endif
EndFunction
