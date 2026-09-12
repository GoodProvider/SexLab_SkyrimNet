;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 3
Scriptname PHHSHCatchMerian Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_2
Function Fragment_2(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
;
CatchUpWithMerian(akSpeaker)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

DOM_Core Property DOM01 Auto

Function CatchUpWithMerian(Actor akSpeaker)
	Quest qst = getowningquest()
	qst.SetObjectiveCompleted(20)
	(qst as PAHOCatchMoreCriminals).SlaversManifestBook.Enable(true)
	qst.setstage(20)
	if akSpeaker == None
		return
	endif
	DOM_Actor akActor = DOM01.GetActor(akSpeaker)
	if akActor == None
		int rank = akSpeaker.GetFactionRank(DOM01.DOMTrainRespect)
		if rank < 0
			rank = 0
		endif
		akSPeaker.SetFactionRank(DOM01.DOMTrainRespect,rank+15)
	else
		akActor.mind.TrainRespect(20.0)
	endif
EndFunction
