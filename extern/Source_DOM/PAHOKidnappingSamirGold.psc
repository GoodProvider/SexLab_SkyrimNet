;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname PAHOKidnappingSamirGold Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
SealTheDeal()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

ReferenceAlias Property Alias_Melina Auto
MiscObject Property Gold001 Auto
DOM_Core Property DOM01 Auto

Function SealTheDeal()
	QF_PAHOKidnapping_060228C3 qst = GetOwningQuest() as QF_PAHOKidnapping_060228C3
	Game.GetPLayer().RemoveItem(Gold001, 10000)
	Game.Getplayer().AddItem(qst.LetterPardo, 1)
	qst.SetStage(115)
	qst.PlayerKeepsMelina()
	DOM01.DOMKeys.DOMActorEnslave(Alias_Melina.GetActorRef(),"")
EndFunction
