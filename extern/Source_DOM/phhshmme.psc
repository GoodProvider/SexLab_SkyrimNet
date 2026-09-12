Scriptname phhshMME extends Quest  

bool Function CheckMME()
	if (Game.GetModByname("MilkModNEW.esp") != 255)
		if (MMEQuest == None)
			MilkMaidFaction = Game.GetFormFromFile(0x0004D53B, "MilkModNEW.esp") As Faction
			BeingMilkedPassive = Game.GetFormFromFile(0x000369A8, "MilkModNEW.esp") As Spell
			WellMilkedBreasts = Game.GetFormFromFile(0x00039f87, "MilkModNEW.esp") As Spell
			MilkCuirass = Game.GetFormFromFile(0x00005b10, "MilkModNEW.esp") As Armor
			MMEQuest = Game.GetFormFromFile(0x0000e209, "MilkModNEW.esp") As Quest
		endif
		return true
	else
		MilkMaidFaction = None
		BeingMilkedPassive = None
		WellMilkedBreasts = None
		MilkCuirass = None
		MMEQuest =  None
		return false
	endif
EndFunction

Function SelfMilk(Actor slave)
	if (MMEQuest != None)
		int i = MMSlot(slave)
		if (i >= 0)
			(MMEQuest as MilkQuest).Milking(slave, 0, 1, 1)
		endif
	endif
EndFunction

bool Function IsMilkMaid(Actor slave)
	if (MilkMaidFaction != None)
		return slave.IsInFaction(MilkMaidFaction )
	else
		return false
	endif
EndFunction

bool Function IsBeingMilked(Actor slave)
	if (BeingMilkedPassive != None)
		return slave.HasSpell(BeingMilkedPassive)
	else
		return false
	endif
EndFunction

bool Function ReadyForMilking(Actor slave)
	if (WellMilkedBreasts != None)
		return !slave.HasSpell(WellMilkedBreasts)
	else
		return false
	endif
EndFunction

bool Function IsWearingMilkEquipment(Actor slave)
	if (MilkCuirass != None)
		Form maidArmor = slave.GetWornForm(Armor.GetMaskForSlot(32))
		return (MilkCuirass == maidArmor)
	else
		return false
	endif
EndFunction

Float Function MilkPercentage(Actor slave)
	if (MMEQuest != None)
		int i = MMSlot(slave)
		if (i < 0) 
			return 0
		else
			Float MilkCnt = MME_Storage.getMilkCurrent((MMEQuest as MilkQuest).MILKmaid[i])
			Float MilkMax = MME_Storage.getMilkMaximum((MMEQuest as MilkQuest).MILKmaid[i])
			return MilkCnt / MilkMax * 100
		endif
	else
		return 0
	endif
EndFunction

Float Function MilkLevel(Actor slave)
	if (MMEQuest != None)
		int i = MMSlot(slave)
		if (i < 0) 
			return 0
		else
			return MME_Storage.getMilkCurrent((MMEQuest as MilkQuest).MILKmaid[i])
		endif
	else
		return 0
	endif
EndFunction

int Function MMSlot(Actor slave)
	if (MMEQuest != None)
		return (MMEQuest as MilkQuest).MILKmaid.find(slave) 
	else
		return -1
	endif
EndFunction

; Copied from MME!
Function InitMilking(Actor slave, Actor milker)
	actor[] sexActors = new actor[2]
	sslBaseAnimation[] anims
	anims = new sslBaseAnimation[1]

	sexActors[0] = slave
	sexActors[1] = milker

	if sexActors[1].GetLeveledActorBase().GetSex() == 0 
		anims[0] = PHHSH.DOMSexlab.GetbyRegistrar("zjBreastFeedingVar")		;Straight
	else
		anims[0] = PHHSH.DOMSexlab.GetbyRegistrar("zjBreastFeeding")			;Lesbian
	endif

	PHHSH.DOMSexlab.StartSex(sexActors, anims)
EndFunction


Faction Property MilkMaidFaction Auto Hidden
Spell Property BeingMilkedPassive Auto Hidden
Spell Property WellMilkedBreasts Auto Hidden
Armor Property MilkCuirass Auto Hidden
Quest Property MMEQuest Auto Hidden

phhshStorageFunctions Property PHHSH Auto