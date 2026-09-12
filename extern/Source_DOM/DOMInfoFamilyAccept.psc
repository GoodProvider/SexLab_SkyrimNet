;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 1
Scriptname DOMInfoFamilyAccept Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_0
Function Fragment_0(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
;
NPCInfoFamilyAccept(akSpeaker)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

DOM_Core Property DOM01 Auto
ReferenceAlias Property SlaveWithFamily Auto

Function NPCInfoFamilyAccept(Actor akTarget)
  Actor akSlave = SlaveWithFamily.GetActorRef()
  if akSlave != None
   DOM_Actor akActor = DOM01.GetActor(akSlave)
  if akActor != None
    DOM01.NPCFamilyAccept(akTarget,akActor)
  endif
 endif
EndFunction
