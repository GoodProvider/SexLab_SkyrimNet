;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname TIF__06091FF3 Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
PHHSHFlexiStorage qst = GetOwningQuest() as PHHSHFlexiStorage 
Debug.Trace("TIF__06091FF3 GreetAnim")
qst.PHHSH.PoseAnim(akSpeaker, qst.PHHSH.GreetAnim())
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment
