Scriptname pahscTestWandScript extends ObjectReference  

Event OnEquipped(Actor a)
	int response = TestMenu.Show()
	if (response == 1)
		aHorse = Game.GetPlayer().PlaceAtme(horse3) as Actor
	elseif (response == 2) 
		aHorse =Game.GetPlayer().PlaceAtme(horse4) as Actor
	elseif (response == 3) 
		aCart = Game.GetPlayer().PlaceAtme(cart2)
	elseif (response == 4) 
		aCart.TetherToHorse(aHorse)
	elseif (response == 5) 
		;PAHSC.UpdateCartAliases()
		PAHSCH.LoadSlaves(aHorse)
	elseif (response == 6) 
		PAHSCH.TieToHorse(aHorse)
	elseif (response == 7) 
		PAHSCH.ChainTest()
	elseif (response == 8) 
		PAHSCH.OnInit()
	elseif (response == 9) 
		PAHSCH.MountActorTest()
	endif
EndEvent

Actor Property aHorse Auto 
ActorBase Property Horse3 Auto
ActorBase Property Horse4 Auto
Activator Property Cart2 Auto
Message Property TestMenu Auto
ObjectReference Property aCart Auto
pahscPackHorseCoreScript  Property PAHSCH Auto 
pahscCoreScript Property PAHSC Auto