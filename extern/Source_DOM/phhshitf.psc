Scriptname phhshITF extends Quest  

bool Property hasITF = false Auto Hidden

Function GetSoftRequirements()
	hasITF = ((Game.GetModByname("ItortureFramework.esm") != 255) && (Game.GetFormFromFile(0x00003519, "ItortureFramework.esm") != None))
EndFunction

ReferenceAlias Function RequestTortureSession(Objectreference furni, Actor submissive, Actor dominant, ObjectReference acti, Keyword actiKwd, bool automatic)
	if !hasITF
		return None
	endif
	ReferenceAlias session = None
	if (itfCoreScript.GetAPI().CheckFurnitureIsEligible(furni))
		session = itfCoreScript.GetAPI().RequestTortureSession(furni, submissive, dominant, acti, actiKwd, automatic)
	endif
	return session
EndFunction