Scriptname phhshOffsetRestraints extends Quest  

Function PunishWithRanDOMWornCollar(Actor slave, int secs)
	if ((!PHHSH.HasTaraAnims) && (!PHHSH.HasTaraAnims2))
		return
	endif

	phhshHouseSlave slaveRef = PHHSH.SlaveRef(slave)
	if (slaveRef != None)
		slaveRef.AddOffsetRestraint(RanDOMWornCollar(), secs)
	endif
EndFunction

Form Function RanDOMWornCollar()
	int r = utility.Randomint(1,5)
	form restraint

	if (PHHSH.HasTaraAnims)
		if (r == 1)
			restraint = Game.GetFormFromFile(0x00000d63, "TaraOffsetBondagePack.esp") as Armor
		elseif (r == 2)
			restraint = Game.GetFormFromFile(0x00001d95, "TaraOffsetBondagePack.esp") as Armor
		elseif (r == 3)
			restraint = Game.GetFormFromFile(0x00001d97, "TaraOffsetBondagePack.esp") as Armor
		elseif (r == 4)
			restraint = Game.GetFormFromFile(0x00001d9b, "TaraOffsetBondagePack.esp") as Armor
		else
			restraint = Game.GetFormFromFile(0x00001d9d, "TaraOffsetBondagePack.esp") as Armor
		endif
	else
		if (r == 1)
			restraint = Game.GetFormFromFile(0x00030d0d, "ZaZAnimationPack.esm") as Armor
		elseif (r == 2)
			restraint = Game.GetFormFromFile(0x0002857b, "ZaZAnimationPack.esm") as Armor
		elseif (r == 3)
			restraint = Game.GetFormFromFile(0x00033d9b, "ZaZAnimationPack.esm") as Armor
		elseif (r == 4)
			restraint = Game.GetFormFromFile(0x00028b9b, "ZaZAnimationPack.esm") as Armor
		else
			restraint = Game.GetFormFromFile(0x00033d9e, "ZaZAnimationPack.esm") as Armor
		endif
	endif
	return restraint
EndFunction

phhshStorageFunctions Property PHHSH auto