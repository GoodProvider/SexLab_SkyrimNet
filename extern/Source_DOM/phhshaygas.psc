Scriptname phhshAygas extends Quest  

bool Function HasAygas()
	bool ok = false
	if (Game.GetModByname("PAH_AndYouGetASlave.esp") != 255)
		ok = (Game.GetFormFromFile(0x0001015c, "PAH_AndYouGetASlave.esp"))
	else
		ok = false
	endif
	return ok
EndFunction

bool Function StoreSlave(Actor slave)
	AygasCoreScript Aygas = Game.GetFormFromFile(0x0000182b, "PAH_AndYouGetASlave.esp") as  AygasCoreScript
	return Aygas.StorageFunctions.StoreSlave(slave)
	return false
EndFunction

; This Function is meant to be used on non Aygas actors who carry Aygas money (aygas actors also have some factions that need to be cleared)
int Function CollectAygasGold(Actor slave)
	int amount = StorageUtil.GetIntValue(slave, "aygasMoney")
	StorageUtil.SetIntValue(slave, "aygasMoney", 0)
	return amount
	return 0	
EndFunction


