Scriptname pahscSummonCartScript extends ObjectReference  

Event OnEquipped(Actor a)
	if (GetParentCell().IsInterior())
		debug.notification("You cannot summon the cart here!")
	else
		debug.notification("Summoning the cart")

		Game.GetPlayer().SetGhost(true)
		SlaveCart.MoveTo(Game.GetPlayer())
		(SlaveCart as zbfCartManager).RehitchHorse()	
		(SlaveCart as zbfCartManager).ParkingBrake(true)
		Game.GetPlayer().SetGhost(false)
	endif
EndEvent

ObjectReference Property SlaveCart Auto
