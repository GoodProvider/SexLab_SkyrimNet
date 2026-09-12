Scriptname pahscCartScript extends ObjectReference  

; Example script to demonstrate the ZBF slave cart Functionality
; To use:
; - Activate to get onto the cart (will spawn and hitch a horse when used the first time)
; - Tell NPCs to activatein order to get them locked up in the back
; - When on the cart, activate (E) again to dismount 1 passenger
;- After all passengers are gone, activate again to dismount from the cart


Event OnCellLoad()
	if (DrawHorseRef != None)
		((self as ObjectReference) as zbfCartManager).HitchHorse(DrawHorseRef)
	endif
EndEvent

Event OnActivate(ObjectReference acti)
	Actor slave = acti as Actor
	if (slave != None) 
		if (slave != game.GetPlayer())
			; Add NPC slave

			slave.SetDoingFavor(false)					; NPC usually get told to activate the cart, end the favor mode here
			if (((self as ObjectReference) as zbfCartManager).AddActorToCart(slave))
				; Post proccessing for PAHE slaves / Followers
			endif
		else
			; Add horse of needed
			if (((self as ObjectReference) as zbfCartManager).DrawHorse == None)
				Actor horse = slave.PlaceAtMe(DrawHorse) as Actor
				utility.wait(1)
				((self as ObjectReference) as zbfCartManager).HitchHorse(horse)
			endif
		
			; Mount, dismount or remove a slave as needed
			if (((self as ObjectReference) as zbfCartManager).Driver != None)
				if (!((self as ObjectReference) as zbfCartManager).RemoveActorFromCart(None))
					((self as ObjectReference) as zbfCartManager).Dismount()
				endif
			else
				((self as ObjectReference) as zbfCartManager).MountSeat(slave)
			endif
		endif
	endif
EndEvent

ActorBase Property DrawHorse Auto
pahscCoreScript Property Qst Auto
Actor Property DrawHorseRef Auto				; Set this Property to auto hitch cart to this horse on game load
