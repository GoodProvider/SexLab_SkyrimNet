;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname DOMThugSlaveHire Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
;
DOM_ThugSlaveHire(akSpeaker)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

DOM_Core Property DOMCore Auto
DOM_SlaverManager Property DOM01 Auto

Function DOM_ThugSlaveHire(Actor akTarget)
	int resignation = DOMCore.DOMPAH.GetResignationFromFaction(akTarget)
	int submission = DOMCore.DOMPAH.GetSubmissionFromFaction(akTarget)
	
	if resignation >= 70 || submission >= 70
		DOM01.AddActor(akTarget,false)
	else
		Debug.MessageBox("Maybe that was a bit premature.")
		DOM_Actor sl_alias = DOMCore.GetSlave(akTarget)
		if sl_alias != None
			sl_alias.TryRunAway()
		endif
	endif
EndFunction
