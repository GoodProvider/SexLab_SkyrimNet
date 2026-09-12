;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname BB_HookerFree_TIF Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
;
HookerFree(akSpeaker)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Function SetProperties()
	if (Game.GetModByName("paradise_halls.esm") != 255)
		if PAH == None 	
			PAH = Game.GetFormFromFile(0x01FAEF, "paradise_halls.esm") As PAHCore
		endif
	else
		PAH = None
	endif
	if (Game.GetModByName("DiaryOfMine.esm") != 255)
		if DOM01 == None
			DOM01 = Game.GetFormFromFile(0x000D61, "DiaryOfMine.esm") As DOM_Core
		endif
	else
		DOM01 = None
	endif
EndFunction

Function HookerFree(Actor akSpeaker)
	Debug.trace("TDF HookerFree "+akSpeaker)
	SetProperties()
	if PAH != None && akSpeaker.IsInFaction(PAH.PAHPlayerSlaveFaction)
		Debug.Notification("paradise halls independent Slave detected")
		PAH.GetSlave(akSpeaker).Release()
	endif
	if DOM01 != None && akSpeaker.IsInFaction(DOM01.DOMActorFaction)
		Debug.Notification("DOM independent actor detected")
		DOM01.ReleaseActor(akSpeaker)
	endif
	if HookerFree01REF.GetRef() == None
		HookerFree01REF.UnregisterForUpdateGameTime()
		HookerFree01REF.ForceRefTo(akSpeaker)
		HookerFree01REF.RegisterForUpdateGameTime(24)

	elseif HookerFree02REF.GetRef() == None
		HookerFree02REF.UnregisterForUpdateGameTime()
		HookerFree02REF.ForceRefTo(akspeaker)
		HookerFree02REF.RegisterForUpdateGameTime(24)

	elseif HookerFree03REF.GetRef() == None
		HookerFree03REF.UnregisterForUpdateGameTime()
		HookerFree03REF.ForceRefTo(akspeaker)
		HookerFree03REF.RegisterForUpdateGameTime(24)

	elseif HookerFree04REF.GetRef() == None
		HookerFree04REF.UnregisterForUpdateGameTime()
		HookerFree04REF.ForceRefTo(akspeaker)
		HookerFree04REF.RegisterForUpdateGameTime(24)

	elseif HookerFree05REF.GetRef() == None
		HookerFree05REF.UnregisterForUpdateGameTime()
		HookerFree05REF.ForceRefTo(akspeaker)
		HookerFree05REF.RegisterForUpdateGameTime(24)

	elseif HookerFree06REF.GetRef() == None
		HookerFree06REF.UnregisterForUpdateGameTime()
		HookerFree06REF.ForceRefTo(akspeaker)
		HookerFree06REF.RegisterForUpdateGameTime(24)

	elseif HookerFree07REF.GetRef() == None
		HookerFree07REF.UnregisterForUpdateGameTime()
		HookerFree07REF.ForceRefTo(akspeaker)
		HookerFree07REF.RegisterForUpdateGameTime(24)

	elseif HookerFree08REF.GetRef() == None
		HookerFree08REF.UnregisterForUpdateGameTime()
		HookerFree08REF.ForceRefTo(akspeaker)
		HookerFree08REF.RegisterForUpdateGameTime(24)

	elseif HookerFree09REF.GetRef() == None
		HookerFree09REF.UnregisterForUpdateGameTime()
		HookerFree09REF.ForceRefTo(akspeaker)
		HookerFree09REF.RegisterForUpdateGameTime(24)

	elseif HookerFree10REF.GetRef() == None
		HookerFree10REF.UnregisterForUpdateGameTime()
		HookerFree10REF.ForceRefTo(akspeaker)
		HookerFree10REF.RegisterForUpdateGameTime(24)

	elseif HookerFree11REF.GetRef() == None
		HookerFree11REF.UnregisterForUpdateGameTime()
		HookerFree11REF.ForceRefTo(akspeaker)
		HookerFree11REF.RegisterForUpdateGameTime(24)

	elseif HookerFree12REF.GetRef() == None
		HookerFree12REF.UnregisterForUpdateGameTime()
		HookerFree12REF.ForceRefTo(akspeaker)
		HookerFree12REF.RegisterForUpdateGameTime(24)

	elseif HookerFree13REF.GetRef() == None
		HookerFree13REF.UnregisterForUpdateGameTime()
		HookerFree13REF.ForceRefTo(akspeaker)
		HookerFree13REF.RegisterForUpdateGameTime(24)

	elseif HookerFree14REF.GetRef() == None
		HookerFree14REF.UnregisterForUpdateGameTime()
		HookerFree14REF.ForceRefTo(akspeaker)
		HookerFree14REF.RegisterForUpdateGameTime(24)

	elseif HookerFree15REF.GetRef() == None
		HookerFree15REF.UnregisterForUpdateGameTime()
		HookerFree15REF.ForceRefTo(akspeaker)
		HookerFree15REF.RegisterForUpdateGameTime(24)

	elseif HookerFree16REF.GetRef() == None
		HookerFree16REF.UnregisterForUpdateGameTime()
		HookerFree16REF.ForceRefTo(akspeaker)
		HookerFree16REF.RegisterForUpdateGameTime(24)

	elseif HookerFree17REF.GetRef() == None
		HookerFree17REF.UnregisterForUpdateGameTime()
		HookerFree17REF.ForceRefTo(akspeaker)
		HookerFree17REF.RegisterForUpdateGameTime(24)

	elseif HookerFree18REF.GetRef() == None
		HookerFree18REF.UnregisterForUpdateGameTime()
		HookerFree18REF.ForceRefTo(akspeaker)
		HookerFree18REF.RegisterForUpdateGameTime(24)

	elseif HookerFree19REF.GetRef() == None
		HookerFree19REF.UnregisterForUpdateGameTime()
		HookerFree19REF.ForceRefTo(akspeaker)
		HookerFree19REF.RegisterForUpdateGameTime(24)

	elseif HookerFree20REF.GetRef() == None
		HookerFree20REF.UnregisterForUpdateGameTime()
		HookerFree20REF.ForceRefTo(akspeaker)
		HookerFree20REF.RegisterForUpdateGameTime(24)


	else
		Debug.Notification(FailureMessage)

	endif
EndFunction

ReferenceAlias Property HookerFree01REF Auto

ReferenceAlias Property HookerFree02REF Auto

ReferenceAlias Property HookerFree03REF Auto

ReferenceAlias Property HookerFree04REF Auto

ReferenceAlias Property HookerFree05REF Auto

ReferenceAlias Property HookerFree06REF Auto

ReferenceAlias Property HookerFree07REF Auto

ReferenceAlias Property HookerFree08REF Auto

ReferenceAlias Property HookerFree09REF Auto

ReferenceAlias Property HookerFree10REF Auto

ReferenceAlias Property HookerFree11REF Auto

ReferenceAlias Property HookerFree12REF Auto

ReferenceAlias Property HookerFree13REF Auto

ReferenceAlias Property HookerFree14REF Auto

ReferenceAlias Property HookerFree15REF Auto

ReferenceAlias Property HookerFree16REF Auto

ReferenceAlias Property HookerFree17REF Auto

ReferenceAlias Property HookerFree18REF Auto

ReferenceAlias Property HookerFree19REF Auto

ReferenceAlias Property HookerFree20REF Auto  

String Property FailureMessage  Auto  
PAHCore Property PAH Auto
DOM_Core Property DOM01 Auto
