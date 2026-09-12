Scriptname PHHSHFurnitureRemover extends ObjectReference  

Event OnLoad()
	ObjectReference aimItem = Game.GetCurrentCrosshairRef()
	if (aimItem != None)
		if ((aimItem.GetBaseObject() ==  PHHSH.HR_HavocChain) || (aimItem.GetBaseObject() == WallRing ))
			aimItem.Delete()
			return
		else
			int mod = Math.LogicalAnd(aimItem.GetBaseObject().GetFormId(), 0xff000000) / 0x1000000
			if (Game.GetModName(mod) == "ZazAnimationPack.esm")
				aimItem.Delete()
				return
			endif
		endif
	endif

	ObjectReference furni = Game.FindClosestReferenceOfAnyTypeInList(PHHSH.PortableFunctions.ZazFurnitureList(), X, Y, Z, 100)
	if (furni != none)
		furni.Delete()
		furni = None
	else
		ObjectReference chain = Game.FindClosestReferenceOfType(PHHSH.HR_HavocChain, X, Y, Z, 100)
		if (chain != none)
			chain.MoveTo(chain, 0, 0, -12000)		; In case it cannot be deleted
			chain.Delete()
			chain = None
		else
			ObjectReference ring = Game.FindClosestReferenceOfType(WallRing , X, Y, Z, 100)
			if (ring != none)
				ring.MoveTo(chain, 0, 0, -12000)		; In case it cannot be deleted
				ring.Delete()
				ring= None
			endif
		endif
	endif
	Delete()
EndEvent

PHHSHStorageFunctions Property PHHSH Auto
Activator Property WallRing Auto