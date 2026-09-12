Scriptname PHHSHEconomics extends Quest  Conditional

PHHSHInterface Property PHHSHInter Auto

Function EvaluateTarget(Actor target)
	String s
	if (target == none)
		s = "No target"
	else
		float base_health  = target.GetBaseAv("health")/100.0    ; Level 1 value is 100 for all races
		float base_stamina = target.GetBaseAv("stamina")/100.0   ; Level 1 value is 100 for all races
		float base_magicka = target.GetBaseAv("magicka")/100.0   ; Between 0 and 1000 depending on race and level
		int HealthRating = (math.ceiling(base_health / 100.0))
		int PhysiqueRating = (math.ceiling(base_stamina / 100.0))
		int IntellectRating = (math.ceiling(base_magicka / 100.0))
		int TrainingRating = (PHHSHInter.getActorTraining(target)) as int
		bool isMage = ((base_magicka > base_stamina) && (base_magicka > base_health))

		s = "Evaluating: " + target.GetDisplayName() + "\n"
		s += "Value: " + SpecialValue(target) + "\n"
		s += "Health: " + HealthRating
		s += "  Physique: " + PhysiqueRating
		s += "  Intellect: " + IntellectRating
		s += "\nTraining: " + TrainingRating
		s += "  Weight: " + target.GetLeveledActorBase().GetWeight()
		s += "  Speech: " + target.GetBaseActorValue("SpeechCraft")
		s += "\nIsMage: " + isMage
		s += "\nAuction Slave:" + AcceptAtAuction(target) + "   Approved for Quest:" + AcceptAsSpecial(target)
		s += "\n" + DeclinedReason
	endif
	Debug.Messagebox(s)
	


EndFunction

bool Function AcceptAtAuction(Actor a)
	return (SpecialValue(a) >= 2000)
EndFunction

bool Function AcceptAsSpecial(Actor a)
	Race r = a.GetRace()
	DeclinedReason = ""
	DeclinedIndex = 0
	AcceptedIndex = 0
	int sextraining = PHHSHInter.GetSexTraining(a) 

	bool is_female = (a.GetLeveledActorBase().GetSex() == 1)
	if ((Is_Female) && ((r == RedGuardRace) || (r == RedGuardVRace)) )
		if (PHHSHInter.GetSubmissionTraining(a) > 50) 
			DeclinedIndex = 0
			AcceptedIndex = 1
			return true
		else 
			DeclinedReason = "Redguard but Not submissive"
			DeclinedIndex = 1
		endif
	endif

	if  ((r == ElderRace) || (r == ElderVRace)) 
		if ((a.GetBaseAv("magicka") > a.GetBaseAv("health")) ||  (a.GetBaseAv("magicka") > a.GetBaseAv("stamina"))   )
			DeclinedIndex = 0
			AcceptedIndex = 2
			return true
		else
			DeclinedReason = "Old and not educated"
			DeclinedIndex = 2
			return false
		endif
	endif

	if (PHHSHInter.GetCombatTraining(a) > 45)
		DeclinedIndex = 0
		if (Is_Female)
			AcceptedIndex = 3
		else
			AcceptedIndex = 4
		endif
		return true
	endif

	if ((PHHSHInter.GetSubmissionTraining(a) > 50) && (Is_Female))	
		if (PHHSHInter.GetRespectTraining(a) > 45)
			DeclinedIndex = 0
			AcceptedIndex = 5
			return true
		else
			if (DeclinedIndex == 0)
				DeclinedReason = "Submissive but not respectful"
				DeclinedIndex = 3
			endif
		endif
	endif

	if  ((Is_Female) && ((r == NordRace) || (r == NordVRace) || (r == ImperialRace) || (r == ImperialVRace))  )
		if (sexTraining  > 45)
			DeclinedIndex = 0
			AcceptedIndex = 6
			return true
		else
			DeclinedReason = "Untrained in lovemaking"
			DeclinedIndex = 4
		endif
	endif

	if ((!Is_Female) && ((r == KhajiitRace) || (r == KhajiitVRace)) )
		DeclinedIndex = 0
		AcceptedIndex = 7
		return true
	endif

	if (DeclinedIndex == 0)
		DeclinedReason = "Train in fighting or make them a good servant"
		if (!Is_Female)
			DeclinedIndex = 5
		else
			DeclinedIndex = 6
		endif
	endif

	return false
EndFunction

Topic Function AuctionEval(Actor a)
	Race r = a.GetRace()
	int sextraining = PHHSHInter.GetSexTraining(a) 
	bool is_female = (a.GetLeveledActorBase().GetSex() == 1)

	if ((Is_Female) && ((r == RedGuardRace) || (r == RedGuardVRace)) )
		if (PHHSHInter.GetSubmissionTraining(a) > 50) 
			PHHSH2.HunterFunctions.PraiseIndex = 1
			return Praise1
		endif
	endif

	if  ((r == ElderRace) || (r == ElderVRace)) 
		if ((a.GetBaseAv("magicka") > a.GetBaseAv("health")) ||  (a.GetBaseAv("magicka") > a.GetBaseAv("stamina"))   )
			PHHSH2.HunterFunctions.PraiseIndex = 2
			return Praise2
		else
			PHHSH2.HunterFunctions.PraiseIndex = 3
			return Praise3
		endif
	endif

	if (PHHSHInter.GetCombatTraining(a) > 45)
		if (Is_Female)
			PHHSH2.HunterFunctions.PraiseIndex = 4
			return Praise4
		else
			PHHSH2.HunterFunctions.PraiseIndex = 5
			return Praise5
		endif
	endif

	if ((PHHSHInter.GetSubmissionTraining(a) > 50) && (Is_Female))	
		if (PHHSHInter.GetRespectTraining(a) > 45)
			PHHSH2.HunterFunctions.PraiseIndex = 6
			return Praise6
		endif
	endif

	if  ((Is_Female) && ((r == NordRace) || (r == NordVRace) || (r == ImperialRace) || (r == ImperialVRace))  )
		if (sextraining > 45)
			PHHSH2.HunterFunctions.PraiseIndex = 7
			return Praise7
		else
			PHHSH2.HunterFunctions.PraiseIndex = 8
			return Praise8
		endif
	endif

	if ((!Is_Female) && ((r == KhajiitRace) || (r == KhajiitVRace)) )
		PHHSH2.HunterFunctions.PraiseIndex = 9
		return Praise9
	endif

	if (!Is_Female)
		PHHSH2.HunterFunctions.PraiseIndex = 10
		return Praise10
	else
		PHHSH2.HunterFunctions.PraiseIndex = 11
		return Praise11
	endif
EndFunction



string Function Praise(Actor a)

EndFunction

string Function Disparage(Actor a)

EndFunction

int Function SpecialValue(Actor a)
	return PHHSHInter.getActorPrice(a)
EndFunction

bool Function IsElder(Actor a)
	if (a == none) 
		return false 
	endif
	Race r = a.GetRace()
	return ((r == ElderRace) || (r == ElderVRace))
EndFunction


String Property AcceptedReason Auto
String Property DeclinedReason Auto
int Property DeclinedIndex Auto Conditional
int Property AcceptedIndex Auto Conditional

Topic Property Praise1 Auto
Topic Property Praise2 Auto
Topic Property Praise3 Auto
Topic Property Praise4 Auto
Topic Property Praise5 Auto
Topic Property Praise6 Auto
Topic Property Praise7 Auto
Topic Property Praise8 Auto
Topic Property Praise9 Auto
Topic Property Praise10 Auto
Topic Property Praise11 Auto


; Race
Race Property ElderRace Auto
Race Property ElderVRace Auto
Race Property RedguardRace Auto
Race Property ImperialRace Auto
Race Property NordRace Auto
Race Property KhajiitRace Auto
Race Property ArgonianRace Auto
Race Property RedguardVRace Auto
Race Property ImperialVRace Auto
Race Property NordVRace Auto
Race Property KhajiitVRace Auto
Race Property ArgonianVRace Auto
Race Property BretonRace Auto
Race Property BretonVRace Auto
Race Property DarkElfRace Auto
Race Property DarkElfVRace Auto
Race Property HighElfRace Auto
Race Property HighElfVRace Auto
Race Property OrcRace Auto
Race Property OrcVRace Auto
Race Property WoodElfRace Auto
Race Property WoodElfVRace Auto

PHHSHStorageFunctions Property PHHSH2 Auto
