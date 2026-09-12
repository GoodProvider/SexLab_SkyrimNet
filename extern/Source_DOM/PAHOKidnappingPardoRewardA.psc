;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname PAHOKidnappingPardoRewardA Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
GetReward()
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Function GetReward()
	QF_PAHOKidnapping_060228C3 qst = GetOwningQuest() as QF_PAHOKidnapping_060228C3
	Game.GetPlayer().RemoveItem(qst.Letterpardo)
	Game.GetPlayer().AddItem(qst.Gold, 4000)
	qst.SetStage(121)
EndFunction
