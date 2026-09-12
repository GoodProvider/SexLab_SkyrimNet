Scriptname pahscPackHorseCoreScript extends Quest   Conditional

Event OnInit()
	Game.GetPlayer().AddPerk(PackhorsePerk)
	Debug.Notification("PAH Slave carting started")
	CountPackHorses()
EndEvent


Function FindSlaves()
;	AvailableSlaveCount = 0
	AvailableSlaves = new Actor[10]
	FindSlaves.Start()
	utility.wait(0.5)
	AvailableSlaves[0] = FindSlaves.Slave1.GetActorRef()
	AvailableSlaves[1] = FindSlaves.Slave2.GetActorRef()
	AvailableSlaves[2] = FindSlaves.Slave3.GetActorRef()
	AvailableSlaves[3] = FindSlaves.Slave4.GetActorRef()
	AvailableSlaves[4] = FindSlaves.Slave5.GetActorRef()
	FindSlaves.Stop()
EndFunction

Function TieToHorse(ObjectReference horse)
	FindSlaves.Start()
	utility.wait(0.5)
	Actor slave1 = FindSlaves.Slave1.GetActorRef()
	Actor slave2 = FindSlaves.Slave2.GetActorRef()
	Actor slave3 = FindSlaves.Slave3.GetActorRef()
	Actor slave4 = FindSlaves.Slave4.GetActorRef()
	Actor slave5 = FindSlaves.Slave5.GetActorRef()

	if (slave1 == None)
		debug.notification("No slaves found")
		return
	endif

	Form f = Game.GetFormFromFile(0x00008057, "PAHSlaveCart.esp") as Form
;	Form f = Game.GetFormFromFile(0x0004138d, "skyrim.esm") as Form
;	ObjectReference r = Game.GetPlayer().PlaceAtMe(TestObject)
	ObjectReference r = Game.GetPlayer().PlaceAtMe(f)
	ObjectReference r2 = Game.GetPlayer().PlaceAtMe(f)

	int ds = 25
	int d = -25

	utility.wait(0.5)
	Game.AddHavokBallAndSocketConstraint (Game.GetPlayer(), "NPC COM [COM ]", r, "HotIron", ds, d, 0, ds, 0, 0)
	Game.AddHavokBallAndSocketConstraint (r, "HotIron", Game.GetPlayer(), "NPC COM [COM ]",  -ds, 0, 0, -ds, d, 0)
	Game.AddHavokBallAndSocketConstraint (Game.GetPlayer(), "NPC COM [COM ]", r2, "HotIron", 0, d, ds, 0, 0, 0)
	Game.AddHavokBallAndSocketConstraint (r, "HotIron", r2, "HotIron", 0, 0, ds, 0, 0, 0)

	slave1.setvehicle(r)
	slave1.PlayIdle(HorseTieR1)


; 	Game.AddHavokBallAndSocketConstraint (Game.GetPlayer(), "NPC COM [COM ]", r, "InvisibleHook", 50, 60, 10, 50, 0, 0)
; 	Game.AddHavokBallAndSocketConstraint (r, "InvisibleHook", Game.GetPlayer(), "NPC COM [COM ]", -50, 60, 10, 50, 0, 0)
; 	Game.AddHavokBallAndSocketConstraint (Game.GetPlayer(), "NPC Neck [Neck", r, "HotIron", 0, 0, 0, 100, 0, 0)

;	if (slave1 != None)
;		Rider1Alias.ForceRefTo(slave1)
;		slave1.EvaluatePackage()
;		horse.Activate(slave1)
;		utility.wait(10)
;		Horse1Alias.ForceRefTo(horse)
;		(horse as Actor).EvaluatePackage()
;		slave1.PlayIdle(HorseTie1)
;		ObjectReference r = Game.GetPlayer().PlaceAtMe(TestObject)
;		r.tethertohorse(horse)
;		slave1.setvehicle(horse)
;	endif
EndFunction

Function ChainTest()
	Form l = Game.GetFormFromFile(0x00005a96, "PAHSlaveCart.esp") as Form
	ObjectReference r = Game.GetPlayer().PlaceAtMe(l)
	r.MoveTo(Game.GetPlayer(), 0, 0, 250)

	Form f = Game.GetFormFromFile(0x00005533, "PAHSlaveCart.esp") as Form
	PlatformRef = Game.GetPlayer().PlaceAtMe(f)
	utility.wait(1)
	Game.GetPlayer().SetVehicle(PlatformRef)
	FindSlaves.Stop()
	FindSlaves.Start()
	utility.wait(0.5)
	Actor slave1 = FindSlaves.Slave1.GetActorRef()
	Actor slave2 = FindSlaves.Slave2.GetActorRef()
	Actor slave3 = FindSlaves.Slave3.GetActorRef()
	Actor slave4 = FindSlaves.Slave4.GetActorRef()
	Actor slave5 = FindSlaves.Slave5.GetActorRef()
	FindSlaves.Stop()

	int ds = 25
	int d = -25

;	utility.wait(0.5)
;	Game.AddHavokBallAndSocketConstraint (Game.GetPlayer(), "NPC COM [COM ]", r, "HotIron", ds, d, 0, ds, 0, 0)
;	game.addHavokBallAndSocketConstraint(Game.GetPlayer(),"NPC Neck [Neck]",r ,"Chest",0,0,50,0,0,0)
	game.addHavokBallAndSocketConstraint(Game.GetPlayer(),"NPC Neck [Neck]",r ,"Vert07",0,0,0)

	if (slave1 == None)
		debug.notification("No slaves found")
	else
	;	slave1.setvehicle(Game.GetPlayer())
	;	utility.wait(0.5)
		slave1.PlayIdle(HorseTieR1)
	endif

EndFunction


Function SlaveOnHorse(Actor slave)
	pahscPackHorseScript horseRef = None
	CountPackHorses()
	if ((Horse1Occupants >= 0) && (Horse1Occupants < 2))
		horseRef = Horse1Alias as pahscPackHorseScript 
	elseif ((Horse2Occupants >= 0) && (Horse2Occupants < 2))
		horseRef = Horse2Alias as pahscPackHorseScript 
	endif
	if (horseRef != none) 
		horseRef.Ride(slave, None)	
	endif
EndFunction

Function BuyHorse(Actor seller, int price)
	if (Game.GetPlayer().GetItemCount(Gold) >= price)
		pahscPackHorseScript horseRef = None
		if (Horse1Alias.GetRef() == None)
			horseRef  = Horse1Alias as pahscPackHorseScript 
		elseif (Horse2Alias.GetRef() == None)
			horseRef  = Horse2Alias as pahscPackHorseScript 
		else
			Debug.Notification("No free slot for pack horse (this shouldn't happen!)")
			return
		endif
		Game.GetPlayer().RemoveItem(Gold, price)
		Actor newHorse = seller.PlaceAtMe(PackHorse) as Actor
		newHorse.SetFactionRank(HorseCommand, 1)		; 1 = Follow
		horseRef.Assign(newHorse)
		newHorse.EvaluatePackage()
		HorsesOwned += 1
		HorsesActive += 1
	endif
EndFunction

Function LoadSlaves(Actor horse)
	pahscPackHorseScript horseRef = HorseRefForHorse(horse)
	if ((horseRef != none) && (horseRef.HasFreeSeats()))
		; Find a slave
		FindSlaves()
		if (AvailableSlaves[0] != None)
			horseRef.Ride(AvailableSlaves[0], None)
		else
			debug.notification("No slaves around")
		endif
	else
		debug.notification("Horse full or missing")
	endif
EndFunction

Function StableHorse(int price)
	pahscPackHorseScript horseRef = GetPackHorse(false)
	if ((horseRef != None) && (Game.GetPlayer().GetItemCount(Gold) >= price))
		Game.GetPlayer().RemoveItem(Gold, price)
		horseRef.Stable()
	endif
EndFunction

pahscPackHorseScript Function GetPackhorse(bool checkSeatsAvailable)
	if (HorseAvailable(Horse1Alias, false))
		return Horse1Alias as pahscPackHorseScript
	elseif (HorseAvailable(Horse2Alias, false))
		return Horse2Alias as pahscPackHorseScript
	else
		return None
	endif	
EndFunction

bool Function HorseAvailable(ReferenceAlias horseRef, bool checkSeatsAvailable)
	Actor horse = horseRef.GetActorRef()
	if (horse != None)
		if (horse.GetFactionRank(HorseCommand) == 1)
			return true
		else
			return false
		endif
	else
		return false
	endif
EndFunction

Function Claim(Actor horse)
	pahscPackHorseScript horseRef = HorseRefForHorse(horse)
	if (horseRef != None)
		horseRef.Claim()
	endif
EndFunction

Function Hobble(Actor horse)
	pahscPackHorseScript horseRef =  HorseRefForHorse(horse)
	if (horseRef != None) 
		horseRef.Stable()
	endif
EndFunction

Function Dismount(Actor horse)
	pahscPackHorseScript horseRef =  HorseRefForHorse(horse)
	if (horseRef != None) 
		horseRef.Dismount()
	endif
EndFunction



Function MountActorTest()
	FindSlaves.Start()
	Utility.Wait(1)
	Actor slave = FindSlaves.Slave1.GetActorRef()
	if (slave != None)
		debug.notification("Found slave " + slave.GetDisplayname())
		ActorMount.ForceRefTo(slave)
		aHorse = slave
	endif
	FindSlaves.Stop()
EndFunction


pahscPackHorseScript Function HorseRefForHorse(Actor horse)
	if (horse == Horse1Alias.GetRef())
		return Horse1Alias as pahscPackHorseScript 
	elseif (horse == Horse2Alias.GetRef())
		return Horse2Alias as pahscPackHorseScript
	else
		return None
	endif
EndFunction

; Count pack horses and occupants, to correctly drive dialogue
Function CountPackHorses()
	if (Horse1Alias.GetRef() != None)
		if (RiderR1Alias.GetRef() != None)
			Horse1Occupants = 2
		elseif (RiderF1Alias.GetRef() != None)
			Horse1Occupants = 1
		else
			Horse1Occupants = 0
		endif
	else
		Horse1Occupants = -1
	endif

	if (Horse2Alias.GetRef() != None)
		if (RiderR2Alias.GetRef() != None)
			Horse2Occupants = 2
		elseif (RiderF2Alias.GetRef() != None)
			Horse2Occupants = 1
		else
			Horse2Occupants = 0
		endif
	else
		Horse2Occupants = -1
	endif
EndFunction

ReferenceAlias Property Horse1Alias Auto
ReferenceAlias Property Horse2Alias Auto
ReferenceAlias Property ActorMount Auto
ReferenceAlias Property RiderPAlias Auto		; Actor riding pillion behind the player
ReferenceAlias Property RiderF1Alias Auto	; Actor riding in front
ReferenceAlias Property RiderF2Alias Auto
ReferenceAlias Property RiderR1Alias Auto	; Actor riding pillion
ReferenceAlias Property RiderR2Alias Auto

MiscObject Property Gold  Auto  
Idle Property HorseTie1 Auto
Idle Property HorseTieR1 Auto
pahscFindSlavesScript Property FindSlaves Auto
Perk Property PackhorsePerk Auto
ActorBase Property PackHorse Auto
Faction Property HorseCommand Auto

int Property HorsesActive Auto Conditional Hidden
int Property HorsesOwned Auto Conditional Hidden				; Counts nr of pack horses
ObjectReference Property PlatformRef Auto Hidden
Actor[] Property AvailableSlaves Auto Hidden
int Property Horse1Occupants =-1 Auto Conditional 
int Property Horse2Occupants =-1 Auto Conditional 
ObjectReference  Property aHorse Auto Hidden