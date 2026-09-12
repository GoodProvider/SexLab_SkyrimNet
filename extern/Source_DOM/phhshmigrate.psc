Scriptname PHHSHMigrate extends Quest  

bool Property alwaysTrue Auto

bool Function NeedsMigration()
	return false
EndFunction

Function Migrate()
	Debug.Notification("HSH: Migration skipped")
EndFunction

Function MigrateSlave(ReferenceAlias fromSlot, PHHSHPortableCellScript toCell)
	Actor slave = fromSlot.GetActorRef()
	if (slave != None)
		slave.SetDontMove(true)
		slave.EnableAI(false)
		fromSlot.UnregisterForUpdate()
		;(fromSlot as PHHSHHouseSlave).DoNotClearFactions = true;
		(fromSlot as PHHSHHouseSlave).DoClear()
		utility.wait(0.5)
		FlexiFunctions.RegisterInCell(slave)
		slave.EnableAI(true)
		slave.SetDontMove(false)
	endif
EndFunction

Function CopyCell(PHHSHPortableCellScript oldCell, PHHSHPortableCellScript newCell)
	newCell.CellWallF = oldCell.CellWallF 
	newCell.CellDoor = oldCell.CellDoor 
	newCell.CellTop = oldCell.CellTop 
	newCell.CellWallL = oldCell.CellWallL 
	newCell.CellWallR = oldCell.CellWallR 
	newCell.CellWallO = oldCell.CellWallO
	newCell.CellLamp = oldCell.CellLamp 
	newCell.CellLight = oldCell.CellLight 
	newCell.BedRoll = oldCell.BedRoll 

	oldCell.CellWallF = None 
	oldCell.CellDoor = None
	oldCell.CellTop = None
	oldCell.CellWallL = None
	oldCell.CellWallR = None
	oldCell.CellWallO = None
	oldCell.CellLamp = None 
	oldCell.CellLight = None 
	oldCell.BedRoll = None 

	newCell.ParentCell = oldCell.ParentCell
	oldcell.RemoveCell(true)
EndFunction

ObjectReference Property MarkerWhiterun Auto
ObjectReference Property MarkerRiften Auto
ObjectReference Property MarkerMarkath Auto
ObjectReference Property MarkerWindhelm Auto
ObjectReference Property MarkerSolitude Auto

PHHSHStorageFunctions Property PHHSH Auto
PHHSHFlexiStorage Property FlexiFunctions Auto

Spell Property PlaceSpell Auto
Spell Property RemoveSpell Auto
