Scriptname pahscCoreScript extends Quest Conditional

Function PutSlaveInCart(Actor slave)
		zbfCartManager cart = SlaveCartAlias.GetRef() as zbfCartManager
		if (cart != None)
			; PAH slaves need to be locked out of changes to prevent escaping
			PAHLockSlave(slave, true)

			if (!cart.AddActorToCart(slave))
				; Adding to cart failed, re-enable PAH slave
				PAHLockSlave(slave, false)
			endif
			UpdateCartAliases()
		else
			Debug.Notification("Slave cart alias not filled, this should never happen!")
		endif
EndFunction

Function RemoveFromCart(Actor slave)
	PAHLockSlave(slave, false)
EndFunction

Function PAHLockSlave(Actor slave, bool lock)
	if DOM01 == None
		if PAH == None
			return
		endif
		PAHSlave slaveRef = PAH.GetSlave(slave)
		if (slaveRef != None)
			slaveRef.actor_alias.SetCanChangeStates(!lock)
		endif
		return
	endif
	if DOM01.DOMPAH.isPAH(slave)
		PAHSlave slaveRef = DOM01.DOMPAH.PAH.GetSlave(slave)
		if (slaveRef != None)
			slaveRef.actor_alias.SetCanChangeStates(!lock)
			return
		endif
	endif
	DOM_Actor akActor = DOM01.GetActor(slave)
	if akActor != None
		if lock
			akActor.EnterOnDuty("enters the slave cart","in slave cart")
		else
			akActor.ExitOnDuty()
		endif
	endif
EndFunction


Function UpdateCartAliases()
	zbfCartManager cart = SlaveCartAlias.GetRef() as zbfCartManager
	HasSlave1 = (cart.Slave1 != None)
	if (HasSlave1)
		CartSlave1.ForceRefTo(cart.Slave1)
	else
		CartSlave1.ForceRefTo(UnnamedActor)
	endif
	HasSlave2 = (cart.Slave2 != None)
	if (HasSlave2)
		CartSlave2.ForceRefTo(cart.Slave2)
	else
		CartSlave2.ForceRefTo(UnnamedActor)
	endif
	HasSlave3 = (cart.Slave3 != None)
	if (HasSlave3)
		CartSlave3.ForceRefTo(cart.Slave3)
	else
		CartSlave3.ForceRefTo(UnnamedActor)
	endif
	HasSlave4 = (cart.Slave4 != None)
	if (HasSlave4)
		CartSlave4.ForceRefTo(cart.Slave4)
	else
		CartSlave4.ForceRefTo(UnnamedActor)
	endif
	HasSlave5 = (cart.Slave5 != None)
	if (HasSlave5)
		CartSlave5.ForceRefTo(cart.Slave5)
	else
		CartSlave5.ForceRefTo(UnnamedActor)
	endif
EndFunction

Function BuySlaveCart(int price)
		Game.GetPlayer().RemoveItem(Gold, price)
		SlaveCartBought  = true
		SetObjectiveDisplayed(10, true)
		If (Game.GetModByName("PAH_HomeSweetHome.esp") != 255)
			PHHSHHunterOperation q = Game.GetFormFromFile(0x00012861, "PAH_HomeSweetHome.esp") As PHHSHHunterOperation
			if q != None
				q.SlaveCartBought = true
			endif
		endif
EndFunction

ReferenceAlias Property SlaveCartAlias Auto
ReferenceAlias Property CartSlave1 Auto
ReferenceAlias Property CartSlave2 Auto
ReferenceAlias Property CartSlave3 Auto
ReferenceAlias Property CartSlave4 Auto
ReferenceAlias Property CartSlave5 Auto
bool Property HasSlave1 Auto Hidden Conditional
bool Property HasSlave2 Auto Hidden Conditional
bool Property HasSlave3 Auto Hidden Conditional
bool Property HasSlave4 Auto Hidden Conditional
bool Property HasSlave5 Auto Hidden Conditional
bool Property SlaveCartBought Auto Hidden Conditional

MiscObject Property Gold  Auto  
Message Property CartMessage Auto
Actor Property UnnamedActor Auto

DOM_Core Property DOM01 Auto
PAHCore Property PAH Auto

