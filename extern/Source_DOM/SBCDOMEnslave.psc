;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 0
Scriptname SBCDOMEnslave Extends TopicInfo Hidden

;BEGIN FRAGMENT Fragment_2
Function Fragment_2(ObjectReference akSpeakerRef)
Actor akSpeaker = akSpeakerRef as Actor
;BEGIN CODE
SBCtoDOMEnslave(akSpeaker)
;
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

Actor Property PlayerRef Auto

DOM_Core Property DOM01 Auto
DOM_SlaveManager Property DOM02 Auto
Faction Property DOMBeingCaptured Auto
Faction Property DOMActorExcludedFaction Auto
Faction Property DOMActorExcludedDialogue Auto

GlobalVariable Property SBCFollowCount Auto
SBC_Library  Property SBCMain Auto
Armor Property SBC_cuffsSetPadded_Black01 Auto
Message Property SBC_DOMOptionsMSG Auto
SoulGem  Property SoulGemBlack Auto
SoulGem  Property SoulGemBlackFilled Auto
SoulGem  Property DA01SoulGemBlackStar Auto
ActorBase Property LvlBanditMissile Auto
ObjectReference Property SomethingSomewhere Auto

Function SBCtoDOMEnslave(Actor akTarget)
	if akTarget.IsInFaction(DOMBeingCaptured)
		return
	endif
	if PlayerRef.GetItemCount(SoulGemBlackFilled) <= 0
		Debug.MessageBox("You lack a Black Soul to power the transition.")
		return
	endif
	int iButton = SBC_DOMOptionsMSG.Show()
	if iButton == 1
		return
	endif
	if PlayerRef.GetItemCount(DA01SoulGemBlackStar) >= 0 && !CheckBlackStarEmpty()
		Finalize(akTarget)
	elseIf PlayerRef.GetItemCount(SoulGemBlackFilled) >= 1
		PlayerRef.RemoveItem(SoulGemBlackFilled, 1, true)
		PlayerRef.AddItem(SoulGemBlack, 1, true)
		Finalize(akTarget)
	else
		debug.MessageBox("You lack a Black Soul to power the transition.")
	endif
EndFunction

Function Finalize(actor akTarget)
	SBCMain.SBCCaptiveFollowPlayer(akTarget, false)
	debug.Notification("Enslaving to DOM")
	Form to_be_removed = akTarget.GetWornForm(0x8000) ; kSlotMask45 = 0x00008000 Unnamed
	if to_be_removed != None
		akTarget.RemoveItem(to_be_removed) ; any SBC cuffs
	endif
	PlayerRef.AddItem(SBC_cuffsSetPadded_Black01) ; exchange SBC cuffs with this one
	akTarget.SetFactionRank(DOMBeingCaptured,2) ; preapre for DOM capture
	DOM_Actor akActor = DOM02.Capture(akTarget,"")
	if akActor == None
		 akTarget.RemoveFromFaction(DOMBeingCaptured)
		 return
	endif
	akActor.mind.TrainRespect(20.0)  ; Respect boost for tied up capture
EndFunction

bool Function CheckBlackStarEmpty()
	actor akTarget = SomethingSomewhere.PlaceAtMe(LvlBanditMissile) as actor ; Somewhere in zSBCStorage
	PlayerRef.RemoveItem(SoulGemBlack, 1, true, akTarget)
	akTarget.Kill(none)
	bool isBlackStarEmpty = PlayerRef.TrapSoul(akTarget)
	PlayerRef.RemoveItem(DA01SoulGemBlackStar, 1, true)
	PlayerRef.AddItem(DA01SoulGemBlackStar, 1, true)
	akTarget.RemoveItem(SoulGemBlack, 1, true, PlayerRef)
	return isBlackStarEmpty
EndFunction
