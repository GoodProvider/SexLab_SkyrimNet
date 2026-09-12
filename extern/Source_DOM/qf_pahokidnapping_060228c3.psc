;BEGIN FRAGMENT CODE - Do not edit anything between this and the end comment
;NEXT FRAGMENT INDEX 28
Scriptname qf_pahokidnapping_060228c3 Extends Quest Hidden

;BEGIN ALIAS PROPERTY GuardD
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_GuardD Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Guards
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Guards Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY GuardK
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_GuardK Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Player
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Player Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Deeja
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Deeja Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Saar
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Saar Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY DockChest
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_DockChest Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Pardo
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Pardo Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Melina
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Melina Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY RaFail
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_RaFail Auto
;END ALIAS PROPERTY

;BEGIN ALIAS PROPERTY Samir
;ALIAS PROPERTY TYPE ReferenceAlias
ReferenceAlias Property Alias_Samir Auto
;END ALIAS PROPERTY

;BEGIN FRAGMENT Fragment_10
Function Fragment_10()
;BEGIN CODE
setObjectiveCompleted(70)
setObjectiveDisplayed(80)
Alias_Player.Clear()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_4
Function Fragment_4()
;BEGIN CODE
SetObjectiveCompleted(20)
SetObjectiveDisplayed(30)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_19
Function Fragment_19()
;BEGIN CODE
SetObjectiveDisplayed(72)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_25
Function Fragment_25()
;BEGIN CODE
SetObjectiveCompleted(100)
setObjectiveDisplayed(110)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_14
Function Fragment_14()
;BEGIN CODE
setObjectiveCompleted(80)
setObjectiveDisplayed(100)
CampEnableMarker.Enable()
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_15
Function Fragment_15()
;BEGIN CODE
if !PlayerKeptMelina
   setObjectiveCompleted(110)
else
   setObjectiveCompleted(115)
endif
setObjectiveDisplayed(120)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_0
Function Fragment_0()
;BEGIN CODE
SetObjectiveDisplayed(10)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_23
Function Fragment_23()
;BEGIN CODE
SetObjectiveCompleted(100)
setObjectiveDisplayed(110)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_2
Function Fragment_2()
;BEGIN CODE
SetObjectiveDisplayed(20)
SetObjectiveDisplayed(10, false)
Alias_RaFail.getRef().Enable()
Alias_Melina.getRef().Enable()
PlayerKeptMelina = false
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_7
Function Fragment_7()
;BEGIN CODE
DockChest.Enable()
setObjectiveCompleted(40)
setObjectiveDisplayed(50)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_6
Function Fragment_6()
;BEGIN CODE
setObjectiveCompleted(30)
setObjectiveDisplayed(40)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_16
Function Fragment_16()
;BEGIN CODE
setObjectiveCompleted(120)
CampEnableMarker.Disable()
if !PlayerKeptMelina
	Alias_Melina.GetActorRef().Disable()
	Alias_Samir.GetActorRef().Disable()
	Alias_Pardo.GetActorRef().SetFactionRank(PHHSH.PAHHunterVendorFaction, 1)
else
	Alias_Melina.Clear()
	Alias_Samir.GetActorRef().Disable()
	Alias_Pardo.GetActorRef().SetFactionRank(PHHSH.PAHHunterVendorFaction, 2)
endif
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_26
Function Fragment_26()
;BEGIN CODE
setObjectiveCompleted(120)
CampEnableMarker.Disable()
if !PlayerKeptMelina
	Alias_Melina.GetActorRef().Disable()
	Alias_Samir.GetActorRef().Disable()
	Alias_Pardo.GetActorRef().SetFactionRank(PHHSH.PAHHunterVendorFaction, 1)
else
	Alias_Melina.Clear()
	Alias_Samir.GetActorRef().Disable()
	Alias_Pardo.GetActorRef().SetFactionRank(PHHSH.PAHHunterVendorFaction, 2)
endif
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_8
Function Fragment_8()
;BEGIN CODE
SetObjectiveCompleted(50)
setObjectiveDisplayed(60)
;END CODE
EndFunction
;END FRAGMENT

;BEGIN FRAGMENT Fragment_9
Function Fragment_9()
;BEGIN CODE
setObjectiveCompleted(60)
setObjectiveDisplayed(70)
setObjectiveDisplayed(71)
if (CheckRequirements())
   setObjectiveCompleted(71)
else
   Alias_Player.ForceRefTo(Game.GetPlayer())
endif
Game.GetPlayer().AddPerk(SubduePerk)
;END CODE
EndFunction
;END FRAGMENT

;END FRAGMENT CODE - Do not edit anything between this and the begin comment

PHHSHInterface Property PHHSHInter Auto

Function ResetAlias()
	Alias_Player.clear()
	Alias_Player.ForceRefTo(Game.GetPlayer())
	Actor a = Alias_Player.GetActorRef()
	if (a != none)
		debug.notification("Name: " + a.GetDisplayName())
	else
		debug.notification("No alias")
	endif
EndFunction

bool Function CheckRequirements()
	Actor player = Game.getPlayer()
	if ((player.HasSpell(ParalysisSpell)) || (player.HasSpell(MassParalysisSpell)) || (player.GetItemCount(paraScroll)) || (player.GetItemCount(massParaScroll))) 
		return true
	endif
	if ( (player.GetItemCount(Para1)) ||  (player.GetItemCount(Para2)) ||  (player.GetItemCount(Para3)) ||  (player.GetItemCount(Para4)) ||  (player.GetItemCount(Para5)))
		return true
	endif 
	if player.GetItemCount(DOMBludgeon) > 0
		return true
	endif
	return false;
EndFunction

bool PlayerKeptMelina = false
Function PlayerKeepsMelina()
	PlayerKeptMelina = true
EndFunction

bool Function CheckPlayerKeepsMelina()
	return PlayerKeptMelina
EndFunction

Function Subdue()
	Rope = DOMKeys.DOMZaz.GetCuffsRope() as Armor
	Actor melina = Alias_Melina.GetActorRef()
	Debug.SendAnimationEvent(Game.GetPlayer(), "IdleLockpick")
	melina.DispelAllSpells()
	melina.EquipItem(Rope, true, true)
;	melina.SetLookAt(Game.GetPlayer())
;	melina.SetRestrained()
	Game.GetPlayer().RemoveItem(rope, 1)
	SetStage(100)
	melina.Setav("aggression", 0)
	melina.StopCombat()
	melina.EvaluatePackage()
	utility.Wait(7)
;	debug.trace("Subdued")
	melina.UnEquipItem(Rope)
	melina.EquipItem(Rope, true, true)
	melina.AddToFaction(DOMKeys.DOMActionTied)
	melina.RemoveFromFaction(DOMKeys.DOMActorExcludedFaction)
	DOMKeys.DOMDoPutInBagActor(melina, Game.GetPlayer(), false)
EndFunction

Function TransferMelina()
	Actor melina = Alias_Melina.GetActorRef()
	if (melina != none) 
		PHHSH.RemoveSlaveFromDOM(melina)
	endif
EndFunction

DOM_Keys Property DOMKeys Auto

Book Property RaFaLedger  Auto  
Book Property Letter1 Auto
Book Property Letter2 Auto
Armor Property Rope Auto
Book Property LetterPardo Auto
Key Property HunterKey Auto
MiscObject Property Gold Auto
Perk Property SubduePerk Auto
ObjectReference Property Innmarker Auto
ObjectReference Property DockChest Auto
Weapon Property DOMBludgeon Auto

Spell Property ParalysisSpell Auto
Spell Property MassParalysisSpell Auto
Scroll Property ParaScroll Auto
Scroll Property MassParaScroll Auto
Potion Property Para1 Auto
Potion Property Para2 Auto
Potion Property Para3 Auto
Potion Property Para4 Auto
Potion Property Para5 Auto
ObjectReference Property CampEnableMarker Auto

QF_PAHONobleDesires_06028A75 Property NextQuest Auto
PHHSHStorageFunctions Property PHHSH Auto
