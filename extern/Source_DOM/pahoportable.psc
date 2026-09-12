Scriptname PAHOPortable extends Quest  Conditional

PHHSHInterface Property PHHSHInter Auto
DOM_ZAZ Property DOMZAZ Auto

Function TestPlace()
	Place(1)
EndFunction

Function PlacePermaCamp()
	Place(2)
EndFunction

Function PlaceCamp()
	Place(3)
EndFunction

Actor Function GetGuardTempCamp()
	if TempCamp == None
		return None
	endif
	if TempCamp.GetRef() == None
		return None
	endif
	return (TempCamp as PHHSHPortableCellScript).Guard
EndFunction

string Function GetNameTempCamp()
	if TempCamp == None
		return ""
	endif
	if TempCamp.GetRef() == None
		return ""
	endif
	Location the_loc = TempCamp.GetRef().GetCurrentLocation()
	string the_loc_name
	if the_loc != None
		the_loc_name = the_loc.GetName()
		if the_loc_name != ""
			return the_loc_name
		endif
	endif
	Cell the_cell = TempCamp.GetRef().GetParentCell()
	if the_cell == None
		return "Somewhere"
	endif
	the_loc_name = the_cell.GetName()
	if the_loc_name == ""
		return "Somewhere"
	endif		
	return the_loc_name
EndFunction

Actor Function GetEligibleSexPartner(Actor slave)
	ReferenceAlias[] refsInCell = SlaveRefsInCell(slave.GetParentCell())
	int i = 0
	Actor partner
	while (refsInCell[i] != None)
		partner = refsInCell[i].GetActorRef()
		if ((!partner.IsInFaction(PHHSH.WallChainFaction)) && (!partner.IsInFaction(PHHSH.InSceneFaction))  && (!partner.IsInFaction(PHHSH.TaskmasterFaction))  && (!partner.IsInFaction(PHHSH.TaskAssignedFaction)) && (partner.IsInFaction(PHHSH.HouseFreeSexFaction)) && (partner != slave) && (PHHSH.DOMSexlab.IsValidActor(partner)) )
			return partner
		endif
		i+=1
	endwhile
	return None
EndFunction

Function TryApplyTears(Actor slave)
	if (PHHSH.HasZazExtension)	
		Spell tears = Game.GetFormFromFile(0x0000595b, "ZazExtensionPack.esm") as Spell
		if (tears != None)
			tears.Cast(Game.GetPlayer(), slave)
		endif
	endif
EndFunction


Function FindFreeSexPartner(Actor slave)
	ReferenceAlias[] refsInCell = SlaveRefsInCell(slave.GetParentCell())
	int i = 0
	int j = 0
	Actor[] partners = new Actor[128]
	Actor partner
	Actor partner2

	int sexHook = slave.GetFormId()
	if (sexHook < 0)
		sexHook = math.abs(sexHook) as int
	endif

	while (refsInCell[i] != None)
		partner = refsInCell[i].GetActorRef()
		if ((!partner.IsInFaction(PHHSH.WallChainFaction))   && (!partner.IsInFaction(PHHSH.TaskmasterFaction))  && (!partner.IsInFaction(PHHSH.TaskAssignedFaction)) && (!partner.IsInFaction(PHHSH.InSceneFaction)) && (partner.IsInFaction(PHHSH.HouseFreeSexFaction)) && (partner != slave) && (PHHSH.DOMSexlab.IsValidActor(partner)) )
			partners[j] = partner
			j += 1
		endif
		i+=1
	endwhile

	if (j > 0)
		int pindex = utility.Randomint(0, j - 1)

		partner = partners[pindex]
		partner.AddToFaction(PHHSH.InSceneFaction)
		slave.AddToFaction(PHHSH.InSceneFaction)
		partner.SetDontMove(false)
		slave.SetDontMove(false)
		Debug.SendAnimationEvent(partner, "IdleForceDefaultState")
		Debug.SendAnimationEvent(slave, "IdleForceDefaultState")

		PHHSHHouseSlave slaveScript = PHHSH.SlaveRef(slave)
		PHHSHHouseSlave partnerScript = PHHSH.SlaveRef(partner)
		PHHSHHouseSlave partnerScript2

		slaveScript.SexHook = sexHook
		partnerScript.SexHook = sexHook
		int partnerCount = 2

		actor[] sexActors
		int pindex2 = utility.Randomint(0, j - 1)
		if (pindex2 != pindex)
			partner2 = partners[pindex2]
			partner2.AddToFaction(PHHSH.InSceneFaction)
			partner2.SetDontMove(false)
			Debug.SendAnimationEvent(partner2, "IdleForceDefaultState")

			partnerScript2 = PHHSH.SlaveRef(partner2)
			partnerScript2.SexHook = sexHook

			;debug.notification("Sex " + slave.GetDisplayName() + " with partners:" + partner.GetDisplayName() + " and " + partner2.GetDisplayName())
			sexActors = new actor[3]
    			sexActors[0] = partner
    			sexActors[1] = slave
    			sexActors[2] = partner2

			partnerCount = 3
		else	
			;debug.notification("Sex " + slave.GetDisplayName() + " with partner:" + partner.GetDisplayName())
			sexActors = new actor[2]
    			sexActors[0] = partner
    			sexActors[1] = slave
		endif

	    	sslBaseAnimation[] anims
    		anims = PHHSH.DOMSexlab.GetAnimationsByTagsBase(partnerCount, "")

   		PHHSH.DOMSexlab.StartSex(sexActors, anims, partner, true, "" + sexHook)
		slaveScript.RegisterForModEvent("AnimationEnd_" + sexHook, "OnSLAnimationEnd")
		partnerScript.RegisterForModEvent("AnimationEnd_" + sexHook, "OnSLAnimationEnd")
		if (partnerCount == 3)
			partnerScript2.RegisterForModEvent("AnimationEnd_" + sexHook, "OnSLAnimationEnd")
		endif
		PHHSHInter.TrainSex(slave,4)
		PHHSHInter.TrainSex(partner,4)
		if (partnerCount == 3)
			PHHSHInter.TrainSex(partner2,4)
		endif
	endif
EndFunction

Function Place(int cellType)			; 1 = cell, 2 = permacamp, 3 = tempcamp
	LogTrace("PAHOPortable Place camp type="+cellType)
	PHHSHPortableScript Placer = PlacerAlias as PHHSHPortableScript
	PlacingCellType = cellType

	if !CheckValidTargetCell(cellType)
		LogTrace("PAHOPortable Place not valid target")
		return
	endif
	if ( (Placer.GetRef() != Game.GetPlayer()) && (GetFreeCell(cellType)) )
		Game.DisablePlayerControls()
		utility.wait(0.1)
		Game.EnablePlayerControls()
		Debug.Notification("[Enter] to place, [ESC] to cancel")
		Placer.ForceRefTo(Game.GetPlayer())
		ObjectReference placeholder		
		if (cellType <= 2)
			placeholder = Game.GetPlayer().PlaceAtMe(Cage1.GetBaseObject() , 1)
			placeholder.SetScale(1.19)
		else
			placeholder = Game.GetPlayer().PlaceAtMe(BedRoll.GetBaseObject() , 1)
		endif
		placeholder.MoveTo(Game.GetPlayer(), 200, 0, 0, true)
		Placer.Listen(placeholder, true)
	else
		debug.notification("No more cells are available")
		LogTrace("PAHOPortable Place No more cells available")
	endif
EndFunction

Function PlaceCell(float X, float Y, float Z, float Rot, int cellType)
	PHHSHPortableCellScript cellScript = GetFreeCell(cellType)
	LogTrace("PAHOPortable PlaceCell type="+cellType+" ref="+cellScript)
	if cellScript == None
		LogTrace("PAHOPortable PlaceCell FAILED")
		return
	endif
	if (cellType <= 2)
		cellScript.PlaceCell(X, Y, Z, Rot)
	else
		cellScript.PlaceBox(X, Y, Z, Rot)
	endif
EndFunction

Function PlaceFurniture()
;	ReferenceAlias c = HoldingCellrefForCell(Game.GetPlayer().GetParentCell())
;	if ((c == None)) ; || (c == TempCamp))
;		debug.notification("You cannot place torture devices here")
;		return;
;	endif
	MenuFurni()
EndFunction

Function MenuFurni()
	if (PHHSH.hasZaz8)
		MenuZap8FurniRoot()
		return
	elseif (PHHSH.hasTaraPack)
		MenuTaraFurniRoot()
		return
	endif

	int response = FurnitureMessage.Show()
	Form furni = None
	if (response == 0)
		return
	elseif (response == 1)
		furni = DOMZaz.GetFurniturePole()
	elseif (response == 2)
		furni = DOMZaz.GetFurnitureTCross()
	elseif (response == 3)
		furni = DOMZaz.GetFurnitureXCross()
	elseif (response == 4)
		furni = DOMZaz.GetFurniturePillory()
	elseif (response == 5)
		furni = DOMZaz.GetFurnitureStocks()
	elseif (response == 6)
		furni = DOMZaz.GetFurnitureRack()
	elseif (response == 7)
		furni = DOMZaz.GetFurnitureWheel()
	elseif (response == 8)
		furni = DOMZaz.GetFurniturePony()
	elseif (PHHSH.HasZaz622p)
		MenuFurniZap1()
		return
	elseif (PHHSH.HasZazExtension)
		MenuFurniZex()
		return
	endif

	if (furni != None)
		ObjectReference fm = PlaceForm(furni, 0, 0, 0, Game.GetPlayer().GetAngleZ(), 0, 0, 0, 0)
	endif
EndFunction

Function MenuFurniZap1()
	Form furni = None

	int response = Furniture2Message.Show()
	if (response == 0)
		return
	elseif (response == 1)
		furni = Game.GetFormFromFile(0x00096766, "ZaZAnimationPack.esm") 	; Big wheel
	elseif (response == 2)
		furni = Game.GetFormFromFile(0x0013d9b3, "ZaZAnimationPack.esm") 	; Chandelier
	elseif (response == 3)
		furni = Game.GetFormFromFile(0x00063d0e, "ZaZAnimationPack.esm") 	; Gibbet
	elseif (response == 4)
		furni = Game.GetFormFromFile(0x0013d9b7, "ZaZAnimationPack.esm") 	; Saddle
	elseif (response == 5)
		furni = Game.GetFormFromFile(0x000a5ac8, "ZaZAnimationPack.esm") 	; Chair
	elseif (response == 6)
		furni = Game.GetFormFromFile(0x001d5919, "ZaZAnimationPack.esm") 	; Dildo pony
	elseif (response == 7)
		furni = Game.GetFormFromFile(0x0013d9b8, "ZaZAnimationPack.esm") 	; Stool
	elseif (response == 8)
		furni = Game.GetFormFromFile(0x0013d9b6, "ZaZAnimationPack.esm") 	; Tilt Wheel
	else
		MenuFurniZap2()
		return
	endif

	if (furni != None)
		ObjectReference fm = PlaceForm(furni, 0, 0, 0, Game.GetPlayer().GetAngleZ(), 0, 0, 0, 0)
	endif
EndFunction


Function MenuFurniZap2()
	Form furni = None

	int response = Furniture3Message.Show()
	if (response == 0)
		return
	elseif (response == 1)
		furni = Game.GetFormFromFile(0x001d592c, "ZaZAnimationPack.esm") 	; Water wheel
	elseif (response == 2)
		furni = Game.GetFormFromFile(0x0004a7dd, "ZaZAnimationPack.esm") 	; Bed
	elseif (response == 3)
		furni = Game.GetFormFromFile(0x00147bd2, "ZaZAnimationPack.esm") 	; Rack
	elseif (response == 4)
		furni = Game.GetFormFromFile(0x00300631, "ZaZAnimationPack.esm") 	; Pole 1
	elseif (response == 5)
		furni = Game.GetFormFromFile(0x00300637, "ZaZAnimationPack.esm") 	; Pole 2
	elseif (response == 6)
		furni = Game.GetFormFromFile(0x0015c021, "ZaZAnimationPack.esm") 	; Wheel
	elseif (response == 7)
		furni = Game.GetFormFromFile(0x001d5929, "ZaZAnimationPack.esm") 	; Turning wheel
	elseif (response == 8)
		furni = Game.GetFormFromFile(0x001daa3a, "ZaZAnimationPack.esm") 	; Barrel
	else
		MenuFurni()
		return
	endif

	if (furni != None)
		ObjectReference fm = PlaceForm(furni, 0, 0, 0, Game.GetPlayer().GetAngleZ(), 0, 0, 0, 0)
	endif
EndFunction


Function MenuFurniZex()
	Form furni = None

	int response = Furniture2Message.Show()
	if (response == 0)
		return
	elseif (response == 1)
		furni = Game.GetFormFromFile(0x0000fba8, "ZazExtensionPack.esm") 	; Big wheel
	elseif (response == 2)
		furni = Game.GetFormFromFile(0x0000bacb, "ZazExtensionPack.esm") 	; Chandelier
	elseif (response == 3)
		furni = Game.GetFormFromFile(0x00003e1c, "ZazExtensionPack.esm") 	; Gibbet
	elseif (response == 4)
		furni = Game.GetFormFromFile(0x0000bac8, "ZazExtensionPack.esm") 	; Saddle
	elseif (response == 5)
		furni = Game.GetFormFromFile(0x0000bacd, "ZazExtensionPack.esm") 	; Chair
	elseif (response == 6)
		furni = Game.GetFormFromFile(0x0000d5e5, "ZazExtensionPack.esm") 	; Dildo pony
	elseif (response == 7)
		furni = Game.GetFormFromFile(0x0000bac9, "ZazExtensionPack.esm") 	; Stool
	elseif (response == 8)
		furni = Game.GetFormFromFile(0x0000bace, "ZazExtensionPack.esm") 	; Tilt Wheel
	else
		MenuFurni()
		return
	endif

	if (furni != None)
		ObjectReference fm = PlaceForm(furni, 0, 0, 0, Game.GetPlayer().GetAngleZ(), 0, 0, 0, 0)
	endif
EndFunction


Function MenuZap8FurniRoot()
	int response = -1
	if (PHHSH.Zaz8Version <= 0)
		response = FurnitureTRMessage.Show()
	else
		response = FurnitureTR8Message.Show()
	endif
	Form furni = None
	if (response == 0)
		return
	elseif (response == 1)
		MenuZap8FurniFurni()
	elseif (response == 2)
		MenuZap8FurniGibbets()
	elseif (response == 3)
		MenuZap8FurniPoles()
	elseif (response == 4)
		MenuZap8FurniItems()
	elseif (response == 5)
		MenuZap8FurniCrosses()
	elseif (response == 6)
		MenuZap8FurniTorture()
	elseif (response == 7)
		MenuZap8FurniShackles()
	elseif (response == 8)
		MenuZap8FurniRacks()
	else
		if (PHHSH.Zaz8Version <= 0)
			MenuZap8FurniMisc()
		else
			MenuZap8FurniRoot2()
		endif
	endif
EndFunction

Function MenuZap8FurniRoot2()
	int response = -1
	response = FurnitureTR8BMessage.Show()

	if (response == 0)
		return
	elseif (response == 1)
		MenuZap8FurniMisc()
	elseif (response == 2)
		MenuZap8FurniMisc2()
	elseif (response == 3)
		MenuZap8FurniBigPoles()
	elseif (response == 4)
		MenuZap8FurniOutdoors()
	elseif (response == 5)
		if (PHHSH.Zaz8Version >= 2)
			MenuZap8FurniLoose()
		else
			MenuZap8FurniRoot()
		endif
	elseif (response == 6)
		MenuZap8FurniRoot()
	endif

EndFunction

Function MenuZap8FurniLoose()
	int response = FurnitureTLoose8Message.Show()
	Form furni = None
	if (response == 0)
		MenuZap8FurniRoot2()
	elseif (response == 1)
		furni = Game.GetFormFromFile(0x00285385, "ZaZAnimationPack.esm") 	
	elseif (response == 2)
		furni = Game.GetFormFromFile(0x0026389e, "ZaZAnimationPack.esm") 	
	elseif (response == 3)
		furni = Game.GetFormFromFile(0x0005ac01, "ZaZAnimationPack.esm") 	
	endif
	if (furni != None)
		ObjectReference fm = PlaceForm(furni, 0, 0, 0, Game.GetPlayer().GetAngleZ(), 0, 0, 0, 0)
	endif
EndFunction

Function MenuZap8FurniMisc2()
	int response = FurnitureTMiscB8Message.Show()
	Form furni = None
	float zoff = 0
	if (response == 0)
		MenuZap8FurniRoot2()
	elseif (response == 1)
		furni = Game.GetFormFromFile(0x00085e57, "ZaZAnimationPack.esm") 	
	elseif (response == 2)
		furni = Game.GetFormFromFile(0x00078048, "ZaZAnimationPack.esm") 	
	elseif (response == 3)
		furni = Game.GetFormFromFile(0x00059b48, "ZaZAnimationPack.esm") 	
	elseif (response == 4)
		furni = Game.GetFormFromFile(0x0007dc1d, "ZaZAnimationPack.esm") 	
	elseif (response == 5)
		furni = Game.GetFormFromFile(0x0007dc22, "ZaZAnimationPack.esm") 
		zoff = 100
	elseif (response == 6)
		furni = Game.GetFormFromFile(0x0007f1b6, "ZaZAnimationPack.esm")
		zoff = -30
	elseif (response == 7)
		furni = Game.GetFormFromFile(0x0028432a, "ZaZAnimationPack.esm") 
	elseif (response == 8)
		furni = Game.GetFormFromFile(0x002858f1, "ZaZAnimationPack.esm") 
	elseif (response == 9)
		furni = Game.GetFormFromFile(0x00059ad8, "ZaZAnimationPack.esm") 
	endif
	if (furni != None)
		ObjectReference fm = PlaceForm(furni, 0, 0, zoff, Game.GetPlayer().GetAngleZ(), 0, 0, 0, 0)
	endif
EndFunction

Function MenuZap8FurniBigPoles()
	int response = FurnitureTPolesB8Message.Show()
	Form furni = None
	if (response == 0)
		MenuZap8FurniRoot2()
	elseif (response == 1)
		furni = Game.GetFormFromFile(0x00085367, "ZaZAnimationPack.esm") 	
	elseif (response == 2)
		furni = Game.GetFormFromFile(0x00085362, "ZaZAnimationPack.esm") 	
	elseif (response == 3)
		furni = Game.GetFormFromFile(0x0008535d, "ZaZAnimationPack.esm") 	
	elseif (response == 4)
		furni = Game.GetFormFromFile(0x00085358, "ZaZAnimationPack.esm") 	
	elseif (response == 5)
		furni = Game.GetFormFromFile(0x0008534e, "ZaZAnimationPack.esm") 	
	endif
	if (furni != None)
		ObjectReference fm = PlaceForm(furni, 0, 0, 0, Game.GetPlayer().GetAngleZ(), 0, 0, 0, 0)
	endif
EndFunction

Function MenuZap8FurniOutdoors()
	int response = FurnitureTOutdoor8Message.Show()
	Form furni = None
	if (response == 0)
		MenuZap8FurniRoot2()
	elseif (response == 1)
		furni = Game.GetFormFromFile(0x0008076c, "ZaZAnimationPack.esm") 	
	elseif (response == 2)
		furni = Game.GetFormFromFile(0x00046d03, "ZaZAnimationPack.esm") 	
	elseif (response == 3)
		furni = Game.GetFormFromFile(0x000863c1, "ZaZAnimationPack.esm") 	
	elseif (response == 4)
		furni = Game.GetFormFromFile(0x00046cf8, "ZaZAnimationPack.esm") 	
	elseif (response == 5)
		furni = Game.GetFormFromFile(0x00049e7b, "ZaZAnimationPack.esm") 	
	elseif (response == 6)
		furni = Game.GetFormFromFile(0x00046cf2, "ZaZAnimationPack.esm") 	
	elseif (response == 7)
		furni = Game.GetFormFromFile(0x00046cf4, "ZaZAnimationPack.esm") 	
	elseif (response == 8)
		furni = Game.GetFormFromFile(0x00049e77, "ZaZAnimationPack.esm") 	
	elseif (response == 9)
		furni = Game.GetFormFromFile(0x000a0509, "ZaZAnimationPack.esm") 	
	endif
	if (furni != None)
		ObjectReference fm = PlaceForm(furni, 0, 0, 0, Game.GetPlayer().GetAngleZ(), 0, 0, 0, 0)
	endif

EndFunction


Function MenuZap8FurniCrosses()
	int response = FurnitureTCrosses8Message.Show()
	Form furni = None
	if (response == 0)
		MenuZap8FurniRoot()
	elseif (response == 1)
		furni = Game.GetFormFromFile(0x00026d3c, "ZaZAnimationPack.esm") 	
	elseif (response == 2)
		furni = Game.GetFormFromFile(0x0003bc69, "ZaZAnimationPack.esm") 	
	elseif (response == 3)
		furni = Game.GetFormFromFile(0x00026d33, "ZaZAnimationPack.esm") 	
	elseif (response == 4)
		furni = Game.GetFormFromFile(0x00026d34, "ZaZAnimationPack.esm") 	
	elseif (response == 5)
		furni = Game.GetFormFromFile(0x000419f0, "ZaZAnimationPack.esm") 	
	elseif (response == 6)
		furni = Game.GetFormFromFile(0x00041a00, "ZaZAnimationPack.esm") 	
	elseif (response == 7)
		furni = Game.GetFormFromFile(0x000500af, "ZaZAnimationPack.esm") 	; Farm cross
	endif
	if (furni != None)
		ObjectReference fm = PlaceForm(furni, 0, 0, 0, Game.GetPlayer().GetAngleZ(), 0, 0, 0, 0)
	endif
EndFunction

Function MenuZap8FurniFurni()
	int response = FurnitureTFurni8Message.Show()
	Form furni = None
	if (response == 0)
		MenuZap8FurniRoot()
	elseif (response == 1)
		furni = Game.GetFormFromFile(0x00059ae2, "ZaZAnimationPack.esm") 	
	elseif (response == 2)
		furni = Game.GetFormFromFile(0x00048881, "ZaZAnimationPack.esm") 	
	elseif (response == 3)
		furni = Game.GetFormFromFile(0x00048882, "ZaZAnimationPack.esm") 	
	elseif (response == 4)
		furni = Game.GetFormFromFile(0x00045c20, "ZaZAnimationPack.esm") 	
	elseif (response == 5)
		furni = Game.GetFormFromFile(0x00045c1c, "ZaZAnimationPack.esm") 	
	elseif (response == 6)
		furni = Game.GetFormFromFile(0x0003f2e0, "ZaZAnimationPack.esm") 	
	elseif (response == 7)
		furni = Game.GetFormFromFile(0x00059b64, "ZaZAnimationPack.esm") 	
	endif
	if (furni != None)
		ObjectReference fm = PlaceForm(furni, 0, 0, 0, Game.GetPlayer().GetAngleZ(), 0, 0, 0, 0)
	endif
EndFunction

Function MenuZap8FurniGibbets()
	int response = FurnitureTGibbetsMessage.Show()
	Form furni = None
	if (response == 0)
		MenuZap8FurniRoot()
	elseif (response == 1)
		furni = Game.GetFormFromFile(0x0004eac7, "ZaZAnimationPack.esm") 	
	elseif (response == 2)
		furni = Game.GetFormFromFile(0x00038f8f, "ZaZAnimationPack.esm") 	
	elseif (response == 3)
		furni = Game.GetFormFromFile(0x00038f87, "ZaZAnimationPack.esm") 	
	elseif (response == 4)
		furni = Game.GetFormFromFile(0x00038f7f, "ZaZAnimationPack.esm") 	
	elseif (response == 5)
		furni = Game.GetFormFromFile(0x00038f81, "ZaZAnimationPack.esm") 	
	endif
	if (furni != None)
		ObjectReference fm = PlaceForm(furni, 0, 0, 0, Game.GetPlayer().GetAngleZ(), 0, 0, 0, 0)
	endif
EndFunction

Function MenuZap8FurniItems()
	int response = FurnitureTItemsMessage.Show()
	Form furni = None
	if (response == 0)
		MenuZap8FurniRoot()
	elseif (response == 1)
		furni = Game.GetFormFromFile(0x00045bd5, "ZaZAnimationPack.esm") 	
	elseif (response == 2)
		furni = Game.GetFormFromFile(0x00045bd6, "ZaZAnimationPack.esm") 	
	elseif (response == 3)
		furni = Game.GetFormFromFile(0x0000fde0, "ZaZAnimationPack.esm") 	
	elseif (response == 4)
		furni = Game.GetFormFromFile(0x00045bcf, "ZaZAnimationPack.esm") 	
	elseif (response == 5)
		furni = Game.GetFormFromFile(0x00045bd1, "ZaZAnimationPack.esm") 	
	elseif (response == 6)
		furni = Game.GetFormFromFile(0x0005f33e, "ZaZAnimationPack.esm") 	
	elseif (response == 7)
		furni = Game.GetFormFromFile(0x00059ae0, "ZaZAnimationPack.esm") 	
	elseif (response == 8)
		furni = Game.GetFormFromFile(0x00059b50, "ZaZAnimationPack.esm") 	
	elseif (response == 9)
		furni = Game.GetFormFromFile(0x00049e85, "ZaZAnimationPack.esm") 	
	endif
	if (furni != None)
		ObjectReference fm = PlaceForm(furni, 0, 0, 0, Game.GetPlayer().GetAngleZ(), 0, 0, 0, 0)
	endif
EndFunction

Function MenuZap8FurniMisc()
	int response = FurnitureTMisc8Message.Show()
	Form furni = None
	Form furniAct = None
	if (response == 0)
		MenuZap8FurniRoot()
	elseif (response == 1)
		furni = Game.GetFormFromFile(0x0005dd88, "ZaZAnimationPack.esm") 	
	elseif (response == 2)
		furni = Game.GetFormFromFile(0x0000dd49, "ZaZAnimationPack.esm") 	
	elseif (response == 3)
		furni = Game.GetFormFromFile(0x00026d3e, "ZaZAnimationPack.esm") 	
	elseif (response == 4)
		furni = Game.GetFormFromFile(0x00026d43, "ZaZAnimationPack.esm") 	
	elseif (response == 5)
		furni = Game.GetFormFromFile(0x0004c4c1, "ZaZAnimationPack.esm") 	
		furniAct = Game.GetFormFromFile(0x0004c4c9, "ZaZAnimationPack.esm") 	
		PlaceForm(furniAct, 0, 0, 0, Game.GetPlayer().GetAngleZ(), -6, -46, 92, 90)
	elseif (response == 6)
		furni = Game.GetFormFromFile(0x00059b62, "ZaZAnimationPack.esm") 	; Dream catcher
	elseif (response == 7)
		furni = Game.GetFormFromFile(0x00056961, "ZaZAnimationPack.esm") 	; Wheel indoor
	elseif (response == 8)
		furni = Game.GetFormFromFile(0x0005e869, "ZaZAnimationPack.esm") 	; Struggle rope
	endif
	if (furni != None)
		ObjectReference fm = PlaceForm(furni, 0, 0, 0, Game.GetPlayer().GetAngleZ(), 0, 0, 0, 0)
	endif
EndFunction

Function MenuZap8FurniPoles()
	int response = FurnitureTPoles8Message.Show()
	Form furni = None
	if (response == 0)
		MenuZap8FurniRoot()
	elseif ((response == 1) && (PHHSH.Zaz8Version < 2))
		furni = Game.GetFormFromFile(0x00045627, "ZaZAnimationPack.esm") 	
	elseif ((response == 1) && (PHHSH.Zaz8Version >= 2))
		furni = Game.GetFormFromFile(0x00283da9, "ZaZAnimationPack.esm") 	
	elseif (response == 2)
		furni = Game.GetFormFromFile(0x00045626, "ZaZAnimationPack.esm") 	
	elseif ((response == 3) && (PHHSH.Zaz8Version < 2))
		furni = Game.GetFormFromFile(0x00044ab2, "ZaZAnimationPack.esm") 	
	elseif ((response == 3) && (PHHSH.Zaz8Version >= 2))
		furni = Game.GetFormFromFile(0x0026e678, "ZaZAnimationPack.esm") 	
	elseif (response == 4)
		furni = Game.GetFormFromFile(0x00045624, "ZaZAnimationPack.esm") 	
	elseif (response == 5)
		furni = DOMZaz.GetFurniturePole ()	
	elseif (response == 6)
		furni = Game.GetFormFromFile(0x0006c77d, "ZaZAnimationPack.esm") 	; Slave pole
	elseif (response == 7)
		furni = Game.GetFormFromFile(0x00283db0, "ZaZAnimationPack.esm") 	
	elseif (response == 8)
		furni = Game.GetFormFromFile(0x0028537e, "ZaZAnimationPack.esm") 	
	endif

	if (furni != None)
		ObjectReference fm = PlaceForm(furni, 0, 0, 0, Game.GetPlayer().GetAngleZ(), 0, 0, 0, 0)
	endif
EndFunction

Function MenuZap8FurniRacks()
	int response = FurnitureTRacksMessage.Show()
	Form furni = None
	Form furniAct = None
	if (response == 0)
		MenuZap8FurniRoot()
	elseif (response == 1)
		furni = Game.GetFormFromFile(0x0000e2bf, "ZaZAnimationPack.esm") 	
	elseif (response == 2)
		furni = Game.GetFormFromFile(0x0004a989, "ZaZAnimationPack.esm") 	
		furniAct = Game.GetFormFromFile(0x0004a995, "ZaZAnimationPack.esm") 	
		PlaceForm(furniAct, 0, 0, 0, Game.GetPlayer().GetAngleZ(), -40, -25, 75, 0)
	elseif (response == 3)
		furni = Game.GetFormFromFile(0x00049ea7, "ZaZAnimationPack.esm") 	
		furniAct = Game.GetFormFromFile(0x00049ea9, "ZaZAnimationPack.esm") 	
		PlaceForm(furniAct, 0, 0, 0, Game.GetPlayer().GetAngleZ(), -42, 80, 83, 0)
	elseif (response == 4)
		furni = Game.GetFormFromFile(0x0006451e, "ZaZAnimationPack.esm") 	
	elseif (response == 5)
		furni = Game.GetFormFromFile(0x00026d2e, "ZaZAnimationPack.esm") 	
	elseif (response == 6)
		furni = Game.GetFormFromFile(0x00026d32, "ZaZAnimationPack.esm") 	
	endif

	if (furni != None)
		ObjectReference fm = PlaceForm(furni, 0, 0, 0, Game.GetPlayer().GetAngleZ(), 0, 0, 0, 0)
	endif
EndFunction

Function MenuZap8FurniShackles()
	int response = FurnitureTShacklesMessage.Show()
	Form furni = None
	if (response == 0)
		MenuZap8FurniRoot()
	elseif (response == 1)
		furni = Game.GetFormFromFile(0x000408f0, "ZaZAnimationPack.esm") 	
	elseif (response == 2)
		furni = Game.GetFormFromFile(0x000408ef, "ZaZAnimationPack.esm") 	
	elseif (response == 3)
		furni = Game.GetFormFromFile(0x000408ed, "ZaZAnimationPack.esm") 	
	elseif (response == 4)
		furni = Game.GetFormFromFile(0x000408ec, "ZaZAnimationPack.esm") 	
	elseif (response == 5)
		furni = Game.GetFormFromFile(0x0003b6dd, "ZaZAnimationPack.esm") 	
	elseif (response == 6)
		furni = Game.GetFormFromFile(0x0003b6df, "ZaZAnimationPack.esm") 	
	elseif (response == 7)
		furni = Game.GetFormFromFile(0x000a4bbe, "ZaZAnimationPack.esm") 	
	endif

	if (furni != None)
		ObjectReference fm = PlaceForm(furni, 0, 0, 0, Game.GetPlayer().GetAngleZ(), 0, 0, 0, 0)
	endif
EndFunction

Function MenuZap8FurniTorture()
	int response = FurnitureTTortureMessage.Show()
	Form furni = None
	if (response == 0)
		MenuZap8FurniRoot()
	elseif (response == 1)
		furni = Game.GetFormFromFile(0x00038467, "ZaZAnimationPack.esm") 	
	elseif ((response == 2) && (PHHSH.Zaz8Version < 2))
		furni = Game.GetFormFromFile(0x00040e9c, "ZaZAnimationPack.esm") 	
	elseif ((response == 2) && (PHHSH.Zaz8Version >= 2))
		furni = Game.GetFormFromFile(0x00037ebc, "ZaZAnimationPack.esm") 	
	elseif ((response == 3) && (PHHSH.Zaz8Version < 2))
		furni = Game.GetFormFromFile(0x00040e9d, "ZaZAnimationPack.esm") 	
	elseif ((response == 3) && (PHHSH.Zaz8Version >= 2))
		furni = Game.GetFormFromFile(0x0003b13c, "ZaZAnimationPack.esm") 	
	elseif ((response == 4) && (PHHSH.Zaz8Version < 2))
		furni = Game.GetFormFromFile(0x00040e9e, "ZaZAnimationPack.esm") 	
	elseif ((response == 4) && (PHHSH.Zaz8Version >= 2))
		furni = Game.GetFormFromFile(0x0008533f, "ZaZAnimationPack.esm") 	
	elseif (response == 5)
		furni = Game.GetFormFromFile(0x00037eb6, "ZaZAnimationPack.esm") 	
	elseif (response == 6)
		furni = Game.GetFormFromFile(0x0003846c, "ZaZAnimationPack.esm") 	
	elseif ((response == 7) && (PHHSH.Zaz8Version < 2))
		furni = Game.GetFormFromFile(0x00038458, "ZaZAnimationPack.esm") 	
	elseif ((response == 7) && (PHHSH.Zaz8Version >= 2))
		furni = Game.GetFormFromFile(0x00038468, "ZaZAnimationPack.esm") 	
	elseif (response == 8)
		furni = Game.GetFormFromFile(0x00038469, "ZaZAnimationPack.esm") 	
	endif

	if (furni != None)
		ObjectReference fm = PlaceForm(furni, 0, 0, 0, Game.GetPlayer().GetAngleZ(), 0, 0, 0, 0)
	endif
EndFunction

Function MenuTaraFurniRoot()
	int response = FurnitureTRMessage.Show()
	Form furni = None
	if (response == 0)
		return
	elseif (response == 1)
		MenuTaraFurniFurni()
	elseif (response == 2)
		MenuTaraFurniGibbets()
	elseif (response == 3)
		MenuTaraFurniPoles()
	elseif (response == 4)
		MenuTaraFurniItems()
	elseif (response == 5)
		MenuTaraFurniCrosses()
	elseif (response == 6)
		MenuTaraFurniTorture()
	elseif (response == 7)
		MenuTaraFurniShackles()
	elseif (response == 8)
		MenuTaraFurniRacks()
	else
		MenuTaraFurniMisc()
	endif

	if (furni != None)
		ObjectReference fm = PlaceForm(furni, 0, 0, 0, Game.GetPlayer().GetAngleZ(), 0, 0, 0, 0)
	endif
EndFunction


Function MenuTaraFurniCrosses()
	int response = FurnitureTCrossesMessage.Show()
	Form furni = None
	if (response == 0)
		MenuTaraFurniRoot()
	elseif (response == 1)
		furni = Game.GetFormFromFile(0x0002fd51, "TaraUltimateFurniturePack.esm") 	
	elseif (response == 2)
		furni = Game.GetFormFromFile(0x0001bbcb, "TaraUltimateFurniturePack.esm") 	
	elseif (response == 3)
		furni = Game.GetFormFromFile(0x000195f8, "TaraUltimateFurniturePack.esm") 	
	elseif (response == 4)
		furni = Game.GetFormFromFile(0x000195f9, "TaraUltimateFurniturePack.esm") 	
	elseif (response == 5)
		furni = Game.GetFormFromFile(0x00010fd2, "TaraUltimateFurniturePack.esm") 	
	elseif (response == 6)
		furni = Game.GetFormFromFile(0x00010fcc, "TaraUltimateFurniturePack.esm") 	
	endif
	if (furni != None)
		ObjectReference fm = PlaceForm(furni, 0, 0, 0, Game.GetPlayer().GetAngleZ(), 0, 0, 0, 0)
	endif
EndFunction


Function MenuTaraFurniFurni()
	int response = FurnitureTFurniMessage.Show()
	Form furni = None
	if (response == 0)
		MenuTaraFurniRoot()
	elseif (response == 1)
		furni = Game.GetFormFromFile(0x000228f7, "TaraUltimateFurniturePack.esm") 	
	elseif (response == 2)
		furni = Game.GetFormFromFile(0x00014b86, "TaraUltimateFurniturePack.esm") 	
	elseif (response == 3)
		furni = Game.GetFormFromFile(0x00014b87, "TaraUltimateFurniturePack.esm") 	
	elseif (response == 4)
		furni = Game.GetFormFromFile(0x0000c35d, "TaraUltimateFurniturePack.esm") 	
	elseif (response == 5)
		furni = Game.GetFormFromFile(0x0000c35b, "TaraUltimateFurniturePack.esm") 	
	endif
	if (furni != None)
		ObjectReference fm = PlaceForm(furni, 0, 0, 0, Game.GetPlayer().GetAngleZ(), 0, 0, 0, 0)
	endif
EndFunction

Function MenuTaraFurniGibbets()
	int response = FurnitureTGibbetsMessage.Show()
	Form furni = None
	if (response == 0)
		MenuTaraFurniRoot()
	elseif (response == 1)
		furni = Game.GetFormFromFile(0x00004a46, "TaraUltimateFurniturePack.esm") 	
	elseif (response == 2)
		furni = Game.GetFormFromFile(0x0000658c, "TaraUltimateFurniturePack.esm") 	
	elseif (response == 3)
		furni = Game.GetFormFromFile(0x0001d185, "TaraUltimateFurniturePack.esm") 	
	elseif (response == 4)
		furni = Game.GetFormFromFile(0x00005534, "TaraUltimateFurniturePack.esm") 	
	elseif (response == 5)
		furni = Game.GetFormFromFile(0x00005535, "TaraUltimateFurniturePack.esm") 	
	endif
	if (furni != None)
		ObjectReference fm = PlaceForm(furni, 0, 0, 0, Game.GetPlayer().GetAngleZ(), 0, 0, 0, 0)
	endif
EndFunction

Function MenuTaraFurniItems()
	int response = FurnitureTItemsMessage.Show()
	Form furni = None
	if (response == 0)
		MenuTaraFurniRoot()
	elseif (response == 1)
		furni = Game.GetFormFromFile(0x00018015, "TaraUltimateFurniturePack.esm") 	
	elseif (response == 2)
		furni = Game.GetFormFromFile(0x000174d6, "TaraUltimateFurniturePack.esm") 	
	elseif (response == 3)
		furni = Game.GetFormFromFile(0x00018017, "TaraUltimateFurniturePack.esm") 	
	elseif (response == 4)
		furni = Game.GetFormFromFile(0x000174dd, "TaraUltimateFurniturePack.esm") 	
	elseif (response == 5)
		furni = Game.GetFormFromFile(0x000174df, "TaraUltimateFurniturePack.esm") 	
	elseif (response == 6)
		furni = Game.GetFormFromFile(0x000275c4, "TaraUltimateFurniturePack.esm") 	
	elseif (response == 7)
		furni = Game.GetFormFromFile(0x000228f5, "TaraUltimateFurniturePack.esm") 	
	elseif (response == 8)
		furni = Game.GetFormFromFile(0x000228e8, "TaraUltimateFurniturePack.esm") 	
	elseif (response == 9)
		furni = Game.GetFormFromFile(0x00020259, "TaraUltimateFurniturePack.esm") 	
	endif
	if (furni != None)
		ObjectReference fm = PlaceForm(furni, 0, 0, 0, Game.GetPlayer().GetAngleZ(), 0, 0, 0, 0)
	endif
EndFunction

Function MenuTaraFurniMisc()
	int response = FurnitureTMiscMessage.Show()
	Form furni = None
	Form furniAct = None
	if (response == 0)
		MenuTaraFurniRoot()
	elseif (response == 1)
		furni = Game.GetFormFromFile(0x00021810, "TaraUltimateFurniturePack.esm") 	
	elseif (response == 2)
		furni = Game.GetFormFromFile(0x0000ef4d, "TaraUltimateFurniturePack.esm") 	
	elseif (response == 3)
		furni = Game.GetFormFromFile(0x0001f1f9, "TaraUltimateFurniturePack.esm") 	
	elseif (response == 4)
		furni = Game.GetFormFromFile(0x00012013, "TaraUltimateFurniturePack.esm") 	
	elseif (response == 5)
		furni = Game.GetFormFromFile(0x0001a0ca, "TaraUltimateFurniturePack.esm") 	
		furniAct = Game.GetFormFromFile(0x0001ab96, "TaraUltimateFurniturePack.esm") 	
		PlaceForm(furniAct, 0, 0, 0, Game.GetPlayer().GetAngleZ(), -6, -46, 92, 90)
	endif
	if (furni != None)
		ObjectReference fm = PlaceForm(furni, 0, 0, 0, Game.GetPlayer().GetAngleZ(), 0, 0, 0, 0)
	endif
EndFunction

Function MenuTaraFurniPoles()
	int response = FurnitureTPolesMessage.Show()
	Form furni = None
	if (response == 0)
		MenuTaraFurniRoot()
	elseif (response == 1)
		furni = Game.GetFormFromFile(0x00009bb2, "TaraUltimateFurniturePack.esm") 	
	elseif (response == 2)
		furni = Game.GetFormFromFile(0x00009bb1, "TaraUltimateFurniturePack.esm") 	
	elseif (response == 3)
		furni = Game.GetFormFromFile(0x00009baf, "TaraUltimateFurniturePack.esm") 	
	elseif (response == 4)
		furni = Game.GetFormFromFile(0x00009ba3, "TaraUltimateFurniturePack.esm") 	
	elseif (response == 5)
		furni = DOMZaz.GetFurniturePole()
	endif

	if (furni != None)
		ObjectReference fm = PlaceForm(furni, 0, 0, 0, Game.GetPlayer().GetAngleZ(), 0, 0, 0, 0)
	endif
EndFunction

Function MenuTaraFurniRacks()
	int response = FurnitureTRacksMessage.Show()
	Form furni = None
	Form furniAct = None
	if (response == 0)
		MenuTaraFurniRoot()
	elseif (response == 1)
		furni = Game.GetFormFromFile(0x000034a3, "TaraUltimateFurniturePack.esm") 	
	elseif (response == 2)
		furni = Game.GetFormFromFile(0x0001b663, "TaraUltimateFurniturePack.esm") 	
		furniAct = Game.GetFormFromFile(0x0001b665, "TaraUltimateFurniturePack.esm") 	
		PlaceForm(furniAct, 0, 0, 0, Game.GetPlayer().GetAngleZ(), -40, -25, 75, 0)
	elseif (response == 3)
		furni = Game.GetFormFromFile(0x0001b65f, "TaraUltimateFurniturePack.esm") 	
		furniAct = Game.GetFormFromFile(0x0001b661, "TaraUltimateFurniturePack.esm") 	
		PlaceForm(furniAct, 0, 0, 0, Game.GetPlayer().GetAngleZ(), -42, 80, 83, 0)
	elseif (response == 4)
		furni = Game.GetFormFromFile(0x00001d90, "TaraUltimateFurniturePack.esm") 	
	endif

	if (furni != None)
		ObjectReference fm = PlaceForm(furni, 0, 0, 0, Game.GetPlayer().GetAngleZ(), 0, 0, 0, 0)
	endif
EndFunction

Function MenuTaraFurniShackles()
	int response = FurnitureTShacklesMessage.Show()
	Form furni = None
	if (response == 0)
		MenuTaraFurniRoot()
	elseif (response == 1)
		furni = Game.GetFormFromFile(0x00009b9d, "TaraUltimateFurniturePack.esm") 	
	elseif (response == 2)
		furni = Game.GetFormFromFile(0x00009b9c, "TaraUltimateFurniturePack.esm") 	
	elseif (response == 3)
		furni = Game.GetFormFromFile(0x00009b9a, "TaraUltimateFurniturePack.esm") 	
	elseif (response == 4)
		furni = Game.GetFormFromFile(0x00009b99, "TaraUltimateFurniturePack.esm") 	
	elseif (response == 5)
		furni = Game.GetFormFromFile(0x0000ce97, "TaraUltimateFurniturePack.esm") 	
	elseif (response == 6)
		furni = Game.GetFormFromFile(0x0000ce98, "TaraUltimateFurniturePack.esm") 	
	endif

	if (furni != None)
		ObjectReference fm = PlaceForm(furni, 0, 0, 0, Game.GetPlayer().GetAngleZ(), 0, 0, 0, 0)
	endif
EndFunction

Function MenuTaraFurniTorture()
	int response = FurnitureTTortureMessage.Show()
	Form furni = None
	if (response == 0)
		MenuTaraFurniRoot()
	elseif (response == 1)
		furni = Game.GetFormFromFile(0x0002860e, "TaraUltimateFurniturePack.esm") 	
	elseif (response == 2)
		furni = Game.GetFormFromFile(0x0002963d, "TaraUltimateFurniturePack.esm") 	
	elseif (response == 3)
		furni = Game.GetFormFromFile(0x00029bab, "TaraUltimateFurniturePack.esm") 	
	elseif (response == 4)
		furni = Game.GetFormFromFile(0x0002a114, "TaraUltimateFurniturePack.esm") 	
	elseif (response == 5)
		furni = Game.GetFormFromFile(0x00005549, "TaraUltimateFurniturePack.esm") 	
	elseif (response == 6)
		furni = Game.GetFormFromFile(0x00008b45, "TaraUltimateFurniturePack.esm") 	
	elseif (response == 7)
		furni = Game.GetFormFromFile(0x00008b47, "TaraUltimateFurniturePack.esm") 	
	elseif (response == 8)
		furni = Game.GetFormFromFile(0x00008b49, "TaraUltimateFurniturePack.esm") 	
	endif

	if (furni != None)
		ObjectReference fm = PlaceForm(furni, 0, 0, 0, Game.GetPlayer().GetAngleZ(), 0, 0, 0, 0)
	endif
EndFunction

Formlist Function ZazFurnitureList()
	return DOMZaz.GetFurnitureList()
EndFunction

Function StandGuard(Actor grd)
	ReferenceAlias camp = HoldingCellrefForCell(grd.GetParentCell())
	if ((camp != None) && (camp.getRef() != None))
		(camp as PHHSHPortableCellScript).SetGuard(grd)
	endif
EndFunction

ObjectReference Function PlaceItem(ObjectReference objref, float X, float Y, float Z, float Rot, float dX, float dY, float dZ, float dRot)
	ObjectReference ref = Game.GetPlayer().PlaceAtMe(objRef.GetBaseObject() , 1)
	ref.MoveTo(Game.GetPlayer(), X+math.Cos(Rot)*dx+math.sin(Rot)*dy, Y-math.Sin(Rot)*dx+math.Cos(Rot)*dy, Z+dZ, false)
	ref.SetAngle(0, 0, Rot+dRot)
	return ref
EndFunction

ObjectReference Function PlaceForm(Form obj, float X, float Y, float Z, float Rot, float dX, float dY, float dZ, float dRot)
	ObjectReference ref = Game.GetPlayer().PlaceAtMe(obj, 1)
	ref.MoveTo(Game.GetPlayer(), X+math.Cos(Rot)*dx+math.sin(Rot)*dy, Y-math.Sin(Rot)*dx+math.Cos(Rot)*dy, Z+dZ, false)
	ref.SetAngle(0, 0, Rot+dRot)
	return ref
EndFunction


bool Function IsOccupied(ObjectReference btn)
	if btn == None
		return false
	endif
	if ((TempCamp.GetRef() != None) && ((TempCamp as PHHSHPortableCellScript).CellButton == btn))
		int n = PHHSH.TCampSlot.length
		int i = 0
		while i < n
			if PHHSH.TCampSlot[i].GetRef() != None
				return true
			endif
			i += 1
		endwhile
		return false
	endif
	if btn.GetParentCell() == None
		return false
	endif
	Cell c = btn.GetParentCell()
	ReferenceAlias[] slaves = SlaveRefsInCell(c)
	return (slaves[0] != None)
EndFunction

Actor Function FindNewGuard(ObjectReference btn)
	if btn == None
		return None
	endif
	if btn.GetParentCell() == None
		return None
	endif
	LogTrace("PAHOPortable FindNewGuard btn="+btn)
	if ((TempCamp.GetRef() != None) && ((TempCamp as PHHSHPortableCellScript).CellButton == btn))
		LogTrace("PAHOPortable FindNewGuard temp camp "+PHHSH.TCampSlot.length)
		int n = PHHSH.TCampSlot.length
		int i = 0
		while i < n
			Actor akRef = PHHSH.TCampSlot[i].GetActorRef()
			if akRef != None && PHHSHInter.GetSubmissionlevel(akRef) >= 70 && PHHSHInter.GetCombatTraining(akRef) >= 50
				return akRef
			endif
			i += 1
		endwhile
		return None
	endif
	int n = CountSlaveRefsInCell(btn.GetParentCell())
	ReferenceAlias[] slaveRefs = SlaveRefsInCell(btn.GetParentCell())
	int i = 0
	LogTrace("PAHOPortable FindNewGuard perm camp length="+n)
	while i < n
		LogTrace("PAHOPortable FindNewGuard "+i+" slot="+slaveRefs[i])
		if slaveRefs[i] != None
			Actor akRef = slaveRefs[i].GetActorRef()
			LogTrace("PAHOPortable FindNewGuard "+i+" ref="+akRef)
			if akRef != None
				DOM_Actor akActor = slaveRefs[i] as DOM_Actor
				if akActor != None && akActor.mind != None
					LogTrace("PAHOPortable FindNewGuard "+i+" actor="+akRef.GetDisplayName()+" submission="+akActor.mind.submission+" combat="+akActor.mind.combat_training)
					if akActor.mind.submission >= 70.0 && akActor.mind.combat_training >= 50.0
						LogTrace("PAHOPortable FindNewGuard Found actor="+akRef.GetDisplayName())
						return akRef
					endif
				else
					LogTrace("PAHOPortable FindNewGuard "+i+" actor="+akRef.GetDisplayName()+" submission="+PHHSHInter.GetSubmissionlevel(akRef)+" combat="+PHHSHInter.GetCombatTraining(akRef))
					if PHHSHInter.GetSubmissionlevel(akRef) >= 70.0 && PHHSHInter.GetCombatTraining(akRef) >= 50.0
						LogTrace("PAHOPortable FindNewGuard Found actor="+akRef.GetDisplayName())
						return akRef
					endif
				endif
			endif
		endif
		i += 1
	endwhile
	return None
EndFunction

bool Function CheckValidTargetCell(int cellType)
	cell c = Game.getPlayer().GetParentCell()
	bool isValid = (HoldingCellRefForCell(c) == None)
	if ((!isValid) || (Game.GetPlayer().GetCurrentLocation() == RestlessHunterLocation))
		debug.notification("This place is already set up to keep slaves")
		return false
	endif
	
	if ((!c.isInterior()) && (cellType==1))
		debug.notification("You cannot build a slave cage outdoors")
		return false
	elseif ((c.isInterior()) && (cellType==2))
		debug.notification("You cannot set up camp indoors")
		return false
	endif

	return true
EndFunction

Function TakeOwnership()
	Cell currentCell = Game.GetPlayer().GetparentCell()
	ReferenceAlias cellAlias = HoldingCellrefForCell(currentCell)

	if (cellAlias != None)
		debug.notification("Taken ownership of this house")
		currentCell.SetPublic(true)

		Int iIndex = currentCell.GetNumRefs(28) 
		While iIndex
			iIndex -= 1
			currentCell.GetNthRef(iIndex, 28).SetActorOwner(none)
		EndWhile
		iIndex = currentCell.GetNumRefs(40) 
		While iIndex
			iIndex -= 1
			currentCell.GetNthRef(iIndex, 40).SetActorOwner(none)
		EndWhile
	else
		debug.notification("You have not added a slave cell to this house yet!")
	endif
EndFunction

bool Function SlotMatchesActorBase(ReferenceAlias slot, ActorBase b)
	return ((slot.GetRef() != None) && (slot.GetActorRef().GetActorBase() == b))
EndFunction

Function CheckTransferTargetSet(cell c)
	PHHSHPortableCellScript cellAlias = HoldingCellrefForCell(c) as PHHSHPortableCellScript
	if (cellAlias != None)
		CellSlaveTransferSet = (cellAlias.TransferTargetCell != None)
;		debug.notification("Check transfer in " + cellAlias.GetRef().GetCurrentLocation().GetName() + ": " + cellAlias.TransferTarget.GetRef().GetCurrentLocation().GetName())
		PHHSH.HouseHasNewTattoos = ((PHHSH.HasSlaveTats) && (PHHSH.SlaveTatsFunctions.CheckArray(cellAlias.TattooNew) > 0))
		PHHSH.HouseHasTrainedTattoos = ((PHHSH.HasSlaveTats) && (PHHSH.SlaveTatsFunctions.CheckArray(cellAlias.TattooTrained) > 0))
	else
		CellSlaveTransferSet = false
		PHHSH.HouseHasNewTattoos = false
		PHHSH.HouseHasTrainedTattoos = false
	endif

	; Also check slave tats available
	PHHSH.HasCopiedTattoos = PHHSH.SlaveTatsFunctions.CheckCopiedTats()
EndFunction

Function SetTransferTargetToPlayerCell(int idx)
	SetTransferTarget(Game.GetPlayer().GetParentCell(),cellRefs[idx])
EndFunction

Function RestoreCells()
	int i = 0
	int n = cellRefs.length
	while i < n
		if cellRefs[i] != None
			PHHSHPortableCellScript the_cell = cellRefs[i] as PHHSHPortableCellScript
			if the_cell != None && the_cell.GetRef() != None
				LogTrace("PAHOPortable RestoreCells found cell "+i+" "+the_cell.GetNameCellRef())
				LogTrace("PAHOPortable RestoreCells parent="+the_cell.ParentCell)
				LogTrace("PAHOPortable RestoreCells is_outdoor="+the_cell.IsOutDoorCell())
				LogTrace("PAHOPortable RestoreCells is_indoor="+the_cell.IsInDoorCell())
				if the_cell.Guard != None
					LogTrace("PAHOPortable RestoreCells guard="+the_cell.Guard.GetDisplayName())
				else
					LogTrace("PAHOPortable RestoreCells guard="+the_cell.Guard)
				endif
				LogTrace("PAHOPortable RestoreCells number of aliases="+the_cell.actorCounter)
				PHHSHInter.PHSF.FlexiStorage.CheckCellAliases(the_cell)
			endif
		endif
		i += 1
	endwhile
EndFunction

Function SetTransferTarget(cell c, ReferenceAlias target)
	PHHSHPortableCellScript cellAlias = HoldingCellrefForCell(c) as PHHSHPortableCellScript
	if (cellAlias != None)
;		cellAlias.TransferTarget = target as PHHSHPortableCellScript
		if ((target != None) && (target.GetRef() != None))
			cellAlias.TransferTargetCell = target.GetRef().GetParentCell()
;			debug.notification("Set transfer in " + cellAlias.GetRef().GetCurrentLocation().GetName() + " to " + cellAlias.TransferTargetCell.GetName())
		else
			cellAlias.TransferTargetCell = none 
;			debug.notification("Clear transfer in " + cellAlias.GetRef().GetCurrentLocation().GetName())
		endif
;		debug.notification(" >  " + (cellAlias.TransferTarget == target) + " - " + cellAlias.TransferTarget.GetRef().GetCurrentLocation().GetName())
	endif
EndFunction

Function ClearTransferTarget(cell c)
	PHHSHPortableCellScript cellAlias = HoldingCellrefForCell(c) as PHHSHPortableCellScript
	if (cellAlias != None)
		cellAlias.TransferTargetCell = None
;		debug.notification("Explicitly clear transfer in " + cellAlias.GetRef().GetCurrentLocation().GetName())
	endif
EndFunction

ReferenceAlias Function HoldingCellrefForCell(Cell c)
	if TempCamp != None && TempCamp.GetRef() != None
		if (TempCamp as PHHSHPortableCellScript).ParentCell == c
			return TempCamp
		endif
	endif
	int n = CellRefs.length
	int i = 0
	while i < n
		if CellRefs[i] != None && CellRefs[i].GetRef() != None
			if (CellRefs[i] as PHHSHPortableCellScript).ParentCell == c
				return CellRefs[i]
			endif
		endif
		i+= 1
	endwhile
	if TempCamp != None && TempCamp.GetRef() != None
		if (TempCamp as PHHSHPortableCellScript).ParentCell == c
			return TempCamp
		endif
	endif
	return None
EndFunction

PHHSHPortableCellScript Function GetCellRef(int index)
	if !CellRefs
		LogTrace("GetCellRef: no cell refs at all")
		return None
	endif
	int n = CellRefs.length
	if index < 0 || index >= n
		LogTrace("GetCellRef: cell ref index out of range "+index+" / "+n)
		return None
	endif
	return CellRefs[index] as PHHSHPortableCellScript
EndFunction

PHHSHPortableCellScript Function GetFreeCell(int cellType)
	if cellType <= 2
		int i = 0
		int n = CellRefs.length
		while i < n
			if CellRefs[i] != None && CellRefs[i].GetRef() == None
				return CellRefs[i] as PHHSHPortableCellScript 
			endif
			i+= 1
		endwhile
		return None
	endif
	if cellType == 3
		if (TempCamp.GetRef() == None)
			return TempCamp as PHHSHPortableCellScript
		endif
		return None
	endif
	return None
EndFunction

ReferenceAlias[] Function SlaveRefsInCell(Cell c)
	LogTrace("PAHOPortable SlaveRefsInCell cell="+c)

	Cell tc = None
	if  ((TempCamp as PHHSHPortableCellScript).CellButton != None)
		tc = (TempCamp as PHHSHPortableCellScript).CellButton.GetparentCell()
	endif

	if ((TempCamp.GetRef() != None) && (tc != None) && (tc == c))
		return PHHSH.TCampSlot
	elseif (c == HunterCell)
		return PHHSH.HunterSlot
	else
		return SlaveRefsInFlexiStorage(c)
	endif
EndFunction

int Function CountSlaveRefsInCell(Cell c)
	LogTrace("PAHOPortable CountSlaveRefsInCell cell="+c)
	int i = 0;

	Cell tc = None
	if  ((TempCamp as PHHSHPortableCellScript).CellButton != None)
		tc = (TempCamp as PHHSHPortableCellScript).CellButton.GetparentCell()
	endif

	if ((TempCamp.GetRef() != None) && (tc != None) && (tc == c))
		int n = PHHSH.TCampSlot.length
		int k = 0
		while k < n
			if (PHHSH.TCampSlot[k].GetRef() != None)
				i+=1
			endif
			k += 1
		endwhile
		return i
	elseif (c == HunterCell)
		int n = PHHSH.HunterSlot.length
		int k = 0
		while k < n
			if (PHHSH.HunterSlot[k].GetRef() != None)
				i+=1
			endif
			k += 1
		endwhile
		return i
	else
		return CountSlaveRefsInFlexiStorage(c)
	endif
EndFunction

ReferenceAlias[] Function SlaveRefsInFlexiStorage(Cell c)
	LogTrace("PAHOPortable SlaveRefsInFlexiStorage cell="+c)
	ReferenceAlias cr = HoldingCellrefForCell(c) 
	if ((cr == TempCamp) || (cr == None))
		return None ; new ReferenceAlias[1]
	endif
	phhshPortableCellScript cc = cr as phhshPortableCellScript
	if cc == None
		return None ; new ReferenceAlias[1]
	endif
	return cc.GetActorArray()
EndFunction

int Function CountSlaveRefsInFlexiStorage(Cell c)
	LogTrace("PAHOPortable CountSlaveRefsInFlexiStorage cell="+c)
	ReferenceAlias cr = HoldingCellrefForCell(c) 
	if ((cr == TempCamp) || (cr == None))
		LogTrace("PAHOPortable CountSlaveRefsInFlexiStorage ZERO cell ref="+cr)
		return 0
	endif
	phhshPortableCellScript cc = cr as phhshPortableCellScript
	if cc == None
		return 0
	endif
	return cc.actorCounter
EndFunction

Function LogTrace(string msg)
	Debug.Trace("PAHOPortable: "+msg)
EndFunction

ObjectReference  Property WallMarker Auto
ObjectReference  Property CellMarker Auto
ObjectReference  Property BedroomMarker Auto
ObjectReference  Property HouseMarker Auto

ObjectReference  Property Cage1 Auto
ObjectReference  Property Box1 Auto
ReferenceAlias Property PlacerAlias Auto
MiscObject Property CellToken Auto
MiscObject Property CampToken Auto
MiscObject Property PermaCampToken Auto
MiscObject Property UpgradeToken Auto
ObjectReference  Property CageFront Auto
ObjectReference  Property CageSide Auto
ObjectReference  Property CageTop Auto
ObjectReference  Property CageDoor Auto
ObjectReference  Property CageButton Auto
ObjectReference  Property CampFire Auto
ObjectReference  Property Bedroll Auto
ObjectReference  Property Marker Auto
ObjectReference  Property CellLamp Auto
ObjectReference  Property CellLight Auto
ReferenceAlias[] Property CellRefs Auto

ReferenceAlias Property TempCamp Auto
Location[] Property PlayerHouses Auto
Message Property Housemenu Auto
Message Property TempCampmenu Auto
Message Property Markermenu Auto
Message Property MarkerHousemenu Auto
Message Property ConfirmCagemenu Auto
Message Property ConfirmCellMenu Auto
Message Property ConfirmFilledCellMenu Auto
Message Property CampSelectionMenu Auto
Message Property ConfirmRemoveChainMenu Auto

PHHSHStorageFunctions Property PHHSH Auto
bool Property OfferUpgrade Auto Conditional
bool Property OfferCellRemove Auto Conditional
bool Property CellMarkersHidden Auto Conditional
bool Property CellMarkersBusy Auto Conditional
bool Property CellSlaveTransferSet Auto Conditional

Spell Property RemoveFurnitureSpell Auto
Spell Property AddFurnitureSpell Auto

int Property PlacingCellType Auto
Keyword Property CellmarkerKeyword Auto

Message Property FurnitureMessage Auto
Message Property Furniture2Message Auto
Message Property Furniture3Message Auto

Cell Property HunterCell Auto

Location Property RestLessHunterLocation Auto

Message Property FurnitureTRMessage Auto
Message Property FurnitureTR8Message Auto
Message Property FurnitureTR8BMessage Auto
Message Property FurnitureTCrossesMessage Auto
Message Property FurnitureTFurniMessage Auto
Message Property FurnitureTGibbetsMessage Auto
Message Property FurnitureTItemsMessage Auto
Message Property FurnitureTMiscMessage Auto
Message Property FurnitureTPolesMessage Auto
Message Property FurnitureTRacksMessage Auto
Message Property FurnitureTShacklesMessage Auto
Message Property FurnitureTTortureMessage Auto

Message Property FurnitureTCrosses8Message Auto
Message Property FurnitureTMisc8Message Auto
Message Property FurnitureTMiscB8Message Auto
Message Property FurnitureTPoles8Message Auto
Message Property FurnitureTPolesB8Message Auto
Message Property FurnitureTFurni8Message Auto
Message Property FurnitureTOutdoor8Message Auto
Message Property FurnitureTLoose8Message Auto
