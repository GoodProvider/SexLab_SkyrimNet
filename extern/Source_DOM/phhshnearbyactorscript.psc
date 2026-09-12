Scriptname PHHSHNearbyActorScript extends Quest  

PHHSHInterface Property PHHSHInter Auto

ReferenceAlias Property PlayerFollower1 Auto
ReferenceAlias Property Follower1 Auto
ReferenceAlias Property Follower2 Auto
ReferenceAlias Property Follower3 Auto
ReferenceAlias Property HSHSlave1 Auto
ReferenceAlias Property PAHSlave1 Auto
ReferenceAlias Property Taskmaster Auto

Function Detect()
	Clear()
	Stop()
	utility.wait(3)
	Start()
	utility.wait(2)
	PHHSH.Taskmaster.HouseHasTaskmaster = (Taskmaster.GetActorRef() != None)
;	Debug()
EndFunction

Function Clear()
	PlayerFollower1.Clear()
	Follower1.Clear()
	Follower2.Clear()
	Follower3.Clear()
	HSHSlave1.Clear()
	PAHSlave1.Clear()
EndFunction

Function Debug()
	string s = "Followers:\n"
	if (Follower1.GetActorRef() != None)
		s += "1 - " + Follower1.GetActorRef().GetDisplayName() + "\n"
	endif
	if (Follower2.GetActorRef() != None)
		s += "2 - " + Follower2.GetActorRef().GetDisplayName() + "\n"
	endif
	if (Follower3.GetActorRef() != None)
		s += "3 - " + Follower3.GetActorRef().GetDisplayName() + "\n"
	endif
	Debug.Messagebox(s)
EndFunction

Actor Function RandomFollower()
	int count = 0
	if (Follower3.GetActorRef() != None)
		count = 3
	elseif (Follower2.GetActorRef() != None)
		count = 2
	elseif (Follower1.GetActorRef() != None)
		count = 1
	endif
	if (count > 0)
		int i = utility.Randomint(1, count)
		if (i == 1)
			return Follower1.GetActorRef()
		elseif (i == 2)
			return Follower2.GetActorRef()
		else
			return Follower3.GetActorRef()
		endif
	else
		return None
	endif
EndFunction

Actor Function RandomPlayerFollower()
	return PlayerFollower1.GetActorRef()
EndFunction

Actor Function RandomSexSlave()
	Actor a1 = None
	Actor a2 = None
	if ((HSHSlave1.GetActorRef() != None) && (!PHHSHInter.IsActorActive(HSHSlave1.GetActorRef())) )
		a1 = HSHSlave1.GetActorRef()
	endif

	if ((PAHSlave1.GetActorRef() != None) && (!PHHSHInter.IsActorActive(PAHSlave1.GetActorRef())) )
		a2 = PAHSlave1.GetActorRef()
	endif

	if ((a1 != None) && (a2 != None))
		if (utility.RandomInt(1,2) == 1)
			return a1
		else
			return a2
		endif
	elseif (a1 != None)
		return a1
	else
		return a2
	endif
EndFunction

phhshStorageFunctions Property PHHSH Auto