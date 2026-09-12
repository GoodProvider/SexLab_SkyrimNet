Scriptname BHguestsMoveIn extends Quest

BHDOMinterface Property UBDOM Auto

referencealias Property BHguest01 auto
GlobalVariable Property aa_andragon_guest1inBH auto
referencealias Property BHguest02 auto
GlobalVariable Property aa_andragon_guest2inBH auto
referencealias Property BHguest03 auto
GlobalVariable Property aa_andragon_guest3inBH auto
referencealias Property BHguest04 auto
GlobalVariable Property aa_andragon_guest4inBH auto
referencealias Property BHguest05 auto
GlobalVariable Property aa_andragon_guest5inBH auto
referencealias Property BHguest06 auto
GlobalVariable Property aa_andragon_guest6inBH auto
referencealias Property BHguest07 auto
GlobalVariable Property aa_andragon_guest7inBH auto
referencealias Property BHguest08 auto
GlobalVariable Property aa_andragon_guest8inBH auto
referencealias Property BHguest09 auto
GlobalVariable Property aa_andragon_guest9inBH auto
referencealias Property BHguest10 auto
GlobalVariable Property aa_andragon_guest10inBH auto
Faction Property BHGuestFaction auto
Faction Property BHAdoptionFaction auto
Faction Property BHPlaceholderFaction auto
GlobalVariable Property aa_andragon_guestCount auto
Faction Property BHGuardFaction auto
Actor Property BHGuard01default auto
Actor Property BHGuard02default auto
Actor Property BHGuard03default auto
Actor Property BHGuard04default auto
referencealias Property BHguard01 auto
referencealias Property BHguard02 auto
referencealias Property BHguard03 auto
referencealias Property BHguard04 auto
GlobalVariable Property aa_andragon_guardpos_1 auto
GlobalVariable Property aa_andragon_guardpos_2 auto
GlobalVariable Property aa_andragon_guardpos_3 auto
GlobalVariable Property aa_andragon_guardpos_4 auto
Actor Property BHGuest01default auto
Actor Property BHGuest02default auto
Actor Property BHGuest03default auto
Actor Property BHGuest04default auto
Actor Property BHGuest05default auto
Actor Property BHGuest06default auto
Actor Property BHGuest07default auto
Actor Property BHGuest08default auto
Actor Property BHGuest09default auto
Actor Property BHGuest10default auto
GlobalVariable Property aa_andragon_guestpos_1 auto
GlobalVariable Property aa_andragon_guestpos_2 auto
GlobalVariable Property aa_andragon_guestpos_3 auto
GlobalVariable Property aa_andragon_guestpos_4 auto
GlobalVariable Property aa_andragon_guestpos_5 auto
GlobalVariable Property aa_andragon_guestpos_6 auto
GlobalVariable Property aa_andragon_guestpos_7 auto
GlobalVariable Property aa_andragon_guestpos_8 auto
GlobalVariable Property aa_andragon_guestpos_9 auto
GlobalVariable Property aa_andragon_guestpos_10 auto
referencealias Property BHguest11 auto
referencealias Property BHguest12 auto
referencealias Property BHguest13 auto
referencealias Property BHguest14 auto
referencealias Property BHguest15 auto
referencealias Property BHguest16 auto
referencealias Property BHguest17 auto
referencealias Property BHguest18 auto
referencealias Property BHguest19 auto
referencealias Property BHguest20 auto
referencealias Property BHjail01 auto
GlobalVariable Property aa_andragon_jail1inBH auto
referencealias Property BHjail02 auto
GlobalVariable Property aa_andragon_jail2inBH auto
Faction Property BHJailFaction auto
GlobalVariable Property aa_andragon_jailCount auto
referencealias Property BHdark01 auto
GlobalVariable Property aa_andragon_dark1inBH auto
referencealias Property BHdark02 auto
GlobalVariable Property aa_andragon_dark2inBH auto
referencealias Property BHdark03 auto
GlobalVariable Property aa_andragon_dark3inBH auto
referencealias Property BHdark04 auto
GlobalVariable Property aa_andragon_dark4inBH auto
Faction Property BHdarkFaction auto
GlobalVariable Property aa_andragon_darkCount auto
referencealias Property BHdress01 auto
referencealias Property BHdress02 auto
Faction Property BHDress1Faction auto
Faction Property BHDress2Faction auto
ObjectReference Property jaildest auto
ObjectReference Property jailoutdest auto
ObjectReference Property prisondoor auto
ObjectReference Property prisondoor2 auto

Function MoveDarkIn(Actor Guest) 
	  UBDOM.MoveDarkIn(Guest)
      If (aa_andragon_dark1inBH.GetValueInt() == 0)
			BHdark01.ForceRefTo(Guest)
			aa_andragon_dark1inBH.SetValueInt(1)
	  ElseIf (aa_andragon_dark2inBH.GetValueInt() == 0)
			BHdark02.ForceRefTo(Guest)
			aa_andragon_dark2inBH.SetValueInt(1)
	  ElseIf (aa_andragon_dark3inBH.GetValueInt() == 0)
			BHdark03.ForceRefTo(Guest)
			aa_andragon_dark3inBH.SetValueInt(1)
	  ElseIf (aa_andragon_dark4inBH.GetValueInt() == 0)
			BHdark04.ForceRefTo(Guest)
			aa_andragon_dark4inBH.SetValueInt(1)
	  Else
			UBDOM.ActorOffDuty(Guest)
		    return
	  endif
	  Guest.AddToFaction(BHdarkFaction)
	  Guest.AddToFaction(BHAdoptionFaction)
	  Guest.AddToFaction(BHPlaceholderFaction)
	  Guest.EvaluatePackage()
	  aa_andragon_darkCount.SetValueInt(aa_andragon_darkCount.GetValueInt() + 1)
EndFunction

Function MoveDarkOut(Actor Guest, referencealias BHguestAlias)
	Guest.RemoveFromFaction(BHdarkFaction)
	Guest.RemoveFromFaction(BHAdoptionFaction)
	Guest.RemoveFromFaction(BHPlaceholderFaction)
	If (BHguestAlias == BHdark01)
		aa_andragon_dark1inBH.SetValueInt(0)
	ElseIf (BHguestAlias == BHdark02)
		aa_andragon_dark2inBH.SetValueInt(0)
	ElseIf (BHguestAlias == BHdark03)
		aa_andragon_dark3inBH.SetValueInt(0)
	ElseIf (BHguestAlias == BHdark04)
		aa_andragon_dark4inBH.SetValueInt(0)
	endif
      BHguestAlias.Clear()
      aa_andragon_darkCount.SetValueInt(aa_andragon_darkCount.GetValueInt() - 1)	
	UBDOM.ActorOffDuty(Guest)
	Guest.EvaluatePackage()
EndFunction

Function MoveJailIn(Actor Guest) 
	UBDOM.MoveJailIn(Guest)
    If (aa_andragon_jail1inBH.GetValueInt() == 0)
			BHjail01.ForceRefTo(Guest)
                    Guest.AddToFaction(BHDress1Faction)
			BHdress01.ForceRefTo(Guest)
			aa_andragon_jail1inBH.SetValueInt(1)
	ElseIf (aa_andragon_jail2inBH.GetValueInt() == 0)
			BHjail02.ForceRefTo(Guest)
                    Guest.AddToFaction(BHDress2Faction)
			BHdress02.ForceRefTo(Guest)
			aa_andragon_jail2inBH.SetValueInt(1)
	Else
			UBDOM.ActorOffDuty(Guest)
		    return
	endif
	Guest.AddToFaction(BHJailFaction)
	Guest.EvaluatePackage()
	aa_andragon_jailCount.SetValueInt(aa_andragon_jailCount.GetValueInt() + 1)
EndFunction

Function MoveJailOut(Actor Guest, referencealias BHguestAlias)
	Guest.RemoveFromFaction(BHJailFaction)
	If (BHguestAlias == BHjail01)
		aa_andragon_jail1inBH.SetValueInt(0)
              Guest.AddToFaction(BHDress1Faction)
		BHdress01.ForceRefTo(Guest)
		prisondoor.setopen(true)
	ElseIf (BHguestAlias == BHjail02)
		aa_andragon_jail2inBH.SetValueInt(0)
              Guest.AddToFaction(BHDress2Faction)
		BHdress02.ForceRefTo(Guest)
		prisondoor2.setopen(true)
	endif
    BHguestAlias.Clear()
	aa_andragon_jailCount.SetValueInt(aa_andragon_jailCount.GetValueInt() - 1)	
	UBDOM.ActorOffDuty(Guest)
	Guest.EvaluatePackage()
EndFunction

Function MoveGuestIn(Actor Guest) 
	UBDOM.MoveOccupantIn(Guest,1)
    If (aa_andragon_guest1inBH.GetValueInt() == 0)
			BHguest01.ForceRefTo(Guest)
			aa_andragon_guest1inBH.SetValueInt(1)
	ElseIf (aa_andragon_guest2inBH.GetValueInt() == 0)
			BHguest02.ForceRefTo(Guest)
			aa_andragon_guest2inBH.SetValueInt(1)
	ElseIf (aa_andragon_guest3inBH.GetValueInt() == 0)
			BHguest03.ForceRefTo(Guest)
			aa_andragon_guest3inBH.SetValueInt(1)
	ElseIf (aa_andragon_guest4inBH.GetValueInt() == 0)
			BHguest04.ForceRefTo(Guest)
			aa_andragon_guest4inBH.SetValueInt(1)
	ElseIf (aa_andragon_guest5inBH.GetValueInt() == 0)
			BHguest05.ForceRefTo(Guest)
			aa_andragon_guest5inBH.SetValueInt(1)		
	ElseIf (aa_andragon_guest6inBH.GetValueInt() == 0)
			BHguest06.ForceRefTo(Guest)
			aa_andragon_guest6inBH.SetValueInt(1)		
	ElseIf (aa_andragon_guest7inBH.GetValueInt() == 0)
			BHguest07.ForceRefTo(Guest)
			aa_andragon_guest7inBH.SetValueInt(1)		
	ElseIf (aa_andragon_guest8inBH.GetValueInt() == 0)
			BHguest08.ForceRefTo(Guest)
			aa_andragon_guest8inBH.SetValueInt(1)		
	ElseIf (aa_andragon_guest9inBH.GetValueInt() == 0)
			BHguest09.ForceRefTo(Guest)
			aa_andragon_guest9inBH.SetValueInt(1)		
	ElseIf (aa_andragon_guest10inBH.GetValueInt() == 0)
			BHguest10.ForceRefTo(Guest)
			aa_andragon_guest10inBH.SetValueInt(1)		
	endif
	Guest.AddToFaction(BHGuestFaction)
	Guest.AddToFaction(BHAdoptionFaction)
	Guest.AddToFaction(BHPlaceholderFaction)
	Guest.EvaluatePackage()
	aa_andragon_guestCount.SetValueInt(aa_andragon_guestCount.GetValueInt() + 1)
EndFunction

Function MoveGuestOut(Actor Guest, referencealias BHguestAlias)
	Guest.RemoveFromFaction(BHGuestFaction)
	Guest.RemoveFromFaction(BHAdoptionFaction)
	Guest.RemoveFromFaction(BHPlaceholderFaction)
	If (aa_andragon_guestCount.GetValueInt() > 10)
		    aa_andragon_guestCount.SetValueInt(10)
    ElseIf (BHguestAlias == BHguest01)
		aa_andragon_guest1inBH.SetValueInt(0)
	ElseIf (BHguestAlias == BHguest02)
		aa_andragon_guest2inBH.SetValueInt(0)
	ElseIf (BHguestAlias == BHguest03)
		aa_andragon_guest3inBH.SetValueInt(0)
	ElseIf (BHguestAlias == BHguest04)
		aa_andragon_guest4inBH.SetValueInt(0)
	ElseIf (BHguestAlias == BHguest05)
		aa_andragon_guest5inBH.SetValueInt(0)
	ElseIf (BHguestAlias == BHguest06)
		aa_andragon_guest6inBH.SetValueInt(0)
	ElseIf (BHguestAlias == BHguest07)
		aa_andragon_guest7inBH.SetValueInt(0)
	ElseIf (BHguestAlias == BHguest08)
		aa_andragon_guest8inBH.SetValueInt(0)
	ElseIf (BHguestAlias == BHguest09)
		aa_andragon_guest9inBH.SetValueInt(0)
	ElseIf (BHguestAlias == BHguest10)
		aa_andragon_guest10inBH.SetValueInt(0)
	endif	
	BHguestAlias.Clear()
	aa_andragon_guestCount.SetValueInt(aa_andragon_guestCount.GetValueInt() - 1)	
	UBDOM.ActorOffDuty(Guest)
	Guest.EvaluatePackage()
EndFunction

Function SwitchDefaultGuard(Actor Guard, referencealias BHguardAlias)
	int guardpos
	If (BHguardAlias == BHguard01)
		guardpos = 1
	ElseIf (BHguardAlias == BHguard02)
		guardpos = 2
	ElseIf (BHguardAlias == BHguard03)
		guardpos = 3
	ElseIf (BHguardAlias == BHguard04)
		guardpos = 4
	Else
		return
	endif
	UBDOM.MoveGuardIn(Guard,guardpos)
	If guardpos == 1
		BHGuard01default.disable()
		BHguard01.ForceRefTo(Guard)
		aa_andragon_guardpos_1.SetValueInt(1)
	ElseIf guardpos == 2
		BHGuard02default.disable()
		BHguard02.ForceRefTo(Guard)
		aa_andragon_guardpos_2.SetValueInt(1)
	ElseIf guardpos == 3
		BHGuard03default.disable()
		BHguard03.ForceRefTo(Guard)
		aa_andragon_guardpos_3.SetValueInt(1)
	ElseIf guardpos == 4
		BHGuard04default.disable()
		BHguard04.ForceRefTo(Guard)
		aa_andragon_guardpos_4.SetValueInt(1)
	endif
	Guard.AddToFaction(BHGuardFaction)
	Guard.AddToFaction(BHAdoptionFaction)
	Guard.AddToFaction(BHPlaceholderFaction)
	Guard.EvaluatePackage()
EndFunction

Function SwitchCustomGuard(Actor Guard, referencealias BHguardAlias)
	int guardpos
	If (BHguardAlias == BHguard01)
		guardpos = 1
	ElseIf (BHguardAlias == BHguard02)
		guardpos = 2
	ElseIf (BHguardAlias == BHguard03)
		guardpos = 3
	ElseIf (BHguardAlias == BHguard04)
		guardpos = 4
	Else
		return
	endif
	Actor oldActor = BHguardAlias.GetActorReference()
    oldActor.RemoveFromFaction(BHGuardFaction)
	oldActor.RemoveFromFaction(BHAdoptionFaction)
	oldActor.RemoveFromFaction(BHPlaceholderFaction)
	BHguardAlias.Clear()
	UBDOM.ActorOffDuty(oldActor)
	oldActor.EvaluatePackage()
	UBDOM.MoveGuardIn(Guard,guardpos)
	BHguardAlias.ForceRefTo(Guard)
	Guard.AddToFaction(BHGuardFaction)
	Guard.AddToFaction(BHAdoptionFaction)
	Guard.AddToFaction(BHPlaceholderFaction)
	Guard.EvaluatePackage()
EndFunction

Function ReleaseCustomGuard(Actor Guard, referencealias BHguardAlias)
    Guard.RemoveFromFaction(BHGuardFaction)
	Guard.RemoveFromFaction(BHAdoptionFaction)
	Guard.RemoveFromFaction(BHPlaceholderFaction)
	If (BHguardAlias == BHguard01)
		BHGuard01default.enable()
		aa_andragon_guardpos_1.SetValueInt(0)
	endif
	If (BHguardAlias == BHguard02)
		BHGuard02default.enable()
		aa_andragon_guardpos_2.SetValueInt(0)
	endif
	If (BHguardAlias == BHguard03)
		BHGuard03default.enable()
		aa_andragon_guardpos_3.SetValueInt(0)
	endif
	If (BHguardAlias == BHguard04)
		BHGuard04default.enable()
		aa_andragon_guardpos_4.SetValueInt(0)
	endif
	BHguardAlias.Clear()
	UBDOM.ActorOffDuty(Guard)
	Guard.EvaluatePackage()
EndFunction

Function SwitchDefaultOccupant(Actor Guest, referencealias BHguestAlias)
	If (BHguestAlias == BHguest11)
		UBDOM.MoveOccupantIn(Guest,2)
		BHGuest01default.disable()
		BHguest11.ForceRefTo(Guest)
		aa_andragon_guestpos_1.SetValueInt(1)
	ElseIf (BHguestAlias == BHguest12)
		UBDOM.MoveOccupantIn(Guest,2)
		BHGuest02default.disable()
		BHguest12.ForceRefTo(Guest)
		aa_andragon_guestpos_2.SetValueInt(1)
	ElseIf (BHguestAlias == BHguest13)
		UBDOM.MoveOccupantIn(Guest,3)
		BHGuest03default.disable()
		BHguest13.ForceRefTo(Guest)
		aa_andragon_guestpos_3.SetValueInt(1)
	ElseIf (BHguestAlias == BHguest14)
		UBDOM.MoveOccupantIn(Guest,2)
		BHGuest04default.disable()
		BHguest14.ForceRefTo(Guest)
		aa_andragon_guestpos_4.SetValueInt(1)
	ElseIf (BHguestAlias == BHguest15)
		UBDOM.MoveOccupantIn(Guest,2)
		BHGuest05default.disable()
		BHguest15.ForceRefTo(Guest)
		aa_andragon_guestpos_5.SetValueInt(1)
	ElseIf (BHguestAlias == BHguest16)
		UBDOM.MoveOccupantIn(Guest,2)
		BHGuest06default.disable()
		BHguest16.ForceRefTo(Guest)
		aa_andragon_guestpos_6.SetValueInt(1)
	ElseIf (BHguestAlias == BHguest17)
		UBDOM.MoveOccupantIn(Guest,2)
		BHGuest07default.disable()
		BHguest17.ForceRefTo(Guest)
		aa_andragon_guestpos_7.SetValueInt(1)
	ElseIf (BHguestAlias == BHguest18)
		UBDOM.MoveOccupantIn(Guest,2)
		BHGuest08default.disable()
		BHguest18.ForceRefTo(Guest)
		aa_andragon_guestpos_8.SetValueInt(1)
	ElseIf (BHguestAlias == BHguest19)
		UBDOM.MoveOccupantIn(Guest,4)
		BHGuest09default.disable()
		BHguest19.ForceRefTo(Guest)
		aa_andragon_guestpos_9.SetValueInt(1)
	ElseIf (BHguestAlias == BHguest20)
		UBDOM.MoveOccupantIn(Guest,5)
		BHGuest10default.disable()
		BHguest20.ForceRefTo(Guest)
		aa_andragon_guestpos_10.SetValueInt(1)
	Else
		return
	endif
	Guest.AddToFaction(BHGuestFaction)
	Guest.AddToFaction(BHAdoptionFaction)
	Guest.AddToFaction(BHPlaceholderFaction)
	Guest.EvaluatePackage()
EndFunction

Function SwitchCustomOccupant(Actor Guest, referencealias BHguestAlias)
	Actor oldActor = BHguestAlias.GetActorReference()
    oldActor.RemoveFromFaction(BHGuestFaction)
	oldActor.RemoveFromFaction(BHAdoptionFaction)
	oldActor.RemoveFromFaction(BHPlaceholderFaction)
	BHguestAlias.Clear()
	UBDOM.ActorOffDuty(oldActor)
	oldActor.EvaluatePackage()
	If (BHguestAlias == BHguest13)
		UBDOM.MoveOccupantIn(Guest,3)
	ElseIf (BHguestAlias == BHguest19)
		UBDOM.MoveOccupantIn(Guest,4)
	ElseIf (BHguestAlias == BHguest20)
		UBDOM.MoveOccupantIn(Guest,5)
	Else
		UBDOM.MoveOccupantIn(Guest,2)
	endif
	BHguestAlias.ForceRefTo(Guest)
	Guest.AddToFaction(BHGuestFaction)
	Guest.AddToFaction(BHAdoptionFaction)
	Guest.AddToFaction(BHPlaceholderFaction)
	Guest.EvaluatePackage()
EndFunction

Function ReleaseCustomOccupant(Actor Guest, referencealias BHguestAlias)
    Guest.RemoveFromFaction(BHGuestFaction)
	Guest.RemoveFromFaction(BHAdoptionFaction)
	Guest.RemoveFromFaction(BHPlaceholderFaction)
	If (BHguestAlias == BHguest11)
		BHGuest01default.enable()
		aa_andragon_guestpos_1.SetValueInt(0)
	endif
	If (BHguestAlias == BHguest12)
		BHGuest02default.enable()
		aa_andragon_guestpos_2.SetValueInt(0)
	endif
	If (BHguestAlias == BHguest13)
		BHGuest03default.enable()
		aa_andragon_guestpos_3.SetValueInt(0)
	endif
	If (BHguestAlias == BHguest14)
		BHGuest04default.enable()
		aa_andragon_guestpos_4.SetValueInt(0)
	endif
	If (BHguestAlias == BHguest15)
		BHGuest05default.enable()
		aa_andragon_guestpos_5.SetValueInt(0)
	endif
	If (BHguestAlias == BHguest16)
		BHGuest06default.enable()
		aa_andragon_guestpos_6.SetValueInt(0)
	endif
	If (BHguestAlias == BHguest17)
		BHGuest07default.enable()
		aa_andragon_guestpos_7.SetValueInt(0)
	endif
	If (BHguestAlias == BHguest18)
		BHGuest08default.enable()
		aa_andragon_guestpos_8.SetValueInt(0)
	endif
	If (BHguestAlias == BHguest19)
		BHGuest09default.enable()
		aa_andragon_guestpos_9.SetValueInt(0)
	endif
	If (BHguestAlias == BHguest20)
		BHGuest10default.enable()
		aa_andragon_guestpos_10.SetValueInt(0)
	endif
	BHguestAlias.Clear()
	UBDOM.ActorOffDuty(Guest)
	Guest.EvaluatePackage()
EndFunction