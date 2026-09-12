;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname PHHSHKidnappingEquipment Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
QF_PAHOKidnapping_060228C3 qst = GetOwningQuest() as QF_PAHOKidnapping_060228C3
Game.GetPlayer().AddItem(qst.letter2, 1)
Game.GetPlayer().AddItem(qst.rope, 1)
qst.SetStage(70)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
