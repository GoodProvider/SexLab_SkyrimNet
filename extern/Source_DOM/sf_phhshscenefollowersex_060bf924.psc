;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 33
Scriptname SF_PHHSHSceneFollowerSex_060BF924 Extends Scene Hidden

;BEGIN FRAGMENT Fragment_26
Function Fragment_26()
;BEGIN CODE
phhshSceneSLA qst = GetOwningQuest() as phhshSceneSLA 
qst.FollowerRef.GetActorRef().MoveTo(qst.FollowerBedRef.GetRef())
qst.FollowerSlaveRef.GetActorRef().MoveTo(qst.FollowerBedRef.GetRef())
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_23
Function Fragment_23()
;BEGIN CODE
phhshSceneSLA qst = GetOwningQuest() as phhshSceneSLA 
qst.PHHSH.DoSlaveAbuseDuo(qst.FollowerSlaveRef.GetActorRef(), qst.FollowerRef.GetActorRef(), qst.PHHSH.FollowersAggro)
qst.FollowerSlaveRef.GetActorRef().RemoveFromFaction(DOMAnimatingFaction)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_7
Function Fragment_7()
;BEGIN CODE
phhshSceneSLA qst = GetOwningQuest() as phhshSceneSLA 
;Debug.SendAnimationEvent(qst.FollowerRef.GetActorRef(), "IdleForceDefaultState")
;Debug.SendAnimationEvent(qst.FollowerSlaveRef.GetActorRef(), "IdleForceDefaultState")
qst.FollowerSlaveRef.GetActorRef().SetFactionRank(DOMAnimatingFaction,2)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_12
Function Fragment_12()
;BEGIN CODE
phhshSceneSLA qst = GetOwningQuest() as phhshSceneSLA 
utility.wait(1)
Debug.SendAnimationEvent(qst.FollowerRef.GetActorRef(), "IdlePointFar_02")
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Faction Property DOMAnimatingFaction Auto
