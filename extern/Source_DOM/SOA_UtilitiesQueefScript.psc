Scriptname SOA_UtilitiesQueefScript extends Quest  

SOA_PartnerTrackingQuestScript	Property SOA_Arrays	Auto	;SOA_ActorList
  
Sound			Property SOA_PostSexQueef			Auto
Sound			Property SOA_PostOralBurp			Auto
Sound			Property SOA_PostSexQueefSelf		Auto
Sound			Property SOA_PostOralBurpSelf		Auto
Sound			Property SOA_SwallowSemen			Auto
GlobalVariable	Property SOA_BurpSFXonOff			Auto
GlobalVariable	Property SOA_SmellArousalGlobal		Auto
Actor 			Property mySelf						Auto
Spell			Property SOA_PostSexGroan			Auto
Spell			Property SOA_FemaleCumDrip			Auto
EffectShader 	Property SOA_HerSmellWhenQueef		Auto
EffectShader 	Property SOA_BurpCum				Auto
Actor	FemaleOne
Actor	FemaleTwo
int		Queefs
int		Queefs2
int		Burps
int 	MaximumQueefs
int		i
int		j
int		BurpOrQueef		; 1 for Burp,  2 for Queef,  3 for both
float 	TimeWas
bool 	BurpOn = false
bool 	QueefOn = false
bool 	BurpMySelf = false

Function MakeHerQueef(actor ThisNPC, actor OtherNPC, int Orgasms, int BQStatus)
	TimeWas = utility.getCurrentGameTime()
	FemaleOne = ThisNPC
	FemaleTwo = OtherNPC
	BurpOrQueef = BQStatus
	Burps = utility.randomInt(4, 16)
	if Orgasms < 10
		MaximumQueefs = 2
	elseIf Orgasms < 20
		MaximumQueefs = 3
	elseIf Orgasms < 30
		MaximumQueefs = 4
	else
		MaximumQueefs = 6
	endIf
	Queefs = utility.randomInt(1, MaximumQueefs)
	Queefs2 = utility.randomInt(0, (((MaximumQueefs * utility.randomFloat()) + 1) as Int))
	if FemaleTwo != None
		Queefs = (Queefs * 2)
		Queefs2 = (Queefs2 * 2)
		Burps = (Burps * 2)
	endIf
	i = 0
	j = 0
	registerForSingleUpdate(1.0)
EndFunction

Event OnUpdate()
	Actor ThisFemale
	float iMin = 6.0			; i Burps are close together in time
	float iMax = 12.0
	float jMin = 20.0			; longer time between j Burps
	float jMax = 40.0
	if FemaleTwo == None
		ThisFemale = FemaleOne
	else
		If utility.randomInt(0,1)
			ThisFemale = FemaleOne
		else
			ThisFemale = FemaleTwo
		endIf
		iMin = 3.0				; shorter separation to cater for two females
		iMax = 6.0
		jMin = 10.0	
		jMax = 20.0
	endIf
	if ThisFemale == None
		Debug.Trace("SOA_UtilitiesQueefScript NONE actor on update")
		return
	endif
	;Check MCM settings to see if Burps and Queefs are allowed
	if SOA_BurpSFXonOff.getValue() == 1	|| SOA_BurpSFXonOff.getValue() == 3
		BurpOn = true
	endIf
	if SOA_BurpSFXonOff.getValue() >= 2
		QueefOn = true
	endIf
	
	if ThisFemale.is3DLoaded() && SOA_Arrays.SOA_PlayerStats[14] == 0 && (mySelf.getParentCell() == Thisfemale.getParentCell())
	; checking that the NPC hasn't left the cell, and isn't having sex with someone.
		If (utility.getCurrentGameTime() - TimeWas) < 0.125		; stops queefing if more than 3 hour has passed eg. you slept or hotkeyed "Wait"
			if BurpOrQueef == 1 && BurpOn						; if BURP
				if utility.randomInt(0, 2) == 1
					SOA_PostOralBurp.play(ThisFemale)				; 50-50 chance of the female burping this time
					if SOA_SmellArousalGlobal.getValue() == 1.0
						SOA_BurpCum.Play(ThisFemale, 0.2)			; white puff of scent
					endIf
					if utility.randomFloat() > 0.6
						utility.wait(utility.randomFloat(1.0, 2.0))
						SOA_SwallowSemen.play(ThisFemale)
					endIf
				endIf
				if i < Burps
					registerForSingleUpdate(utility.randomFloat(iMin, iMax))
					i += 1
				else
					if j < Burps
						registerForSingleUpdate(utility.randomFloat(jMin, jMax))
						j += 1
					endIf
				endIf
			elseIf BurpOrQueef == 2	&& QueefOn					; if QUEEF
				SOA_PostSexQueef.play(ThisFemale)				; 50-50 chance of the female queefing this time
				SOA_FemaleCumDrip.Cast(ThisFemale, ThisFemale)
				if SOA_SmellArousalGlobal.getValue() == 1.0
					SOA_HerSmellWhenQueef.Play(ThisFemale, 1.0)	
				endIf
				if utility.randomFloat() > 0.5						
					SOA_PostSexGroan.cast(ThisFemale, ThisFemale)
					utility.wait(utility.randomFloat(0.2, 1.0))
				endIf
				SOA_FemaleCumDrip.Cast(ThisFemale, ThisFemale)
				if i < Queefs
					registerForSingleUpdate(utility.randomFloat(iMin, iMax))
					i += 1
				else
					if j < Queefs2
						registerForSingleUpdate(utility.randomFloat(jMin, jMax))
						j += 1
					endIf
				endIf
			else												; if BOTH BURP and QUEEF
				int Chance = utility.randomInt(0, 3)
				if Chance == 0 && QueefOn
						SOA_PostSexQueef.play(ThisFemale)			; 33% chance of the female queefing this time
						SOA_FemaleCumDrip.Cast(ThisFemale, ThisFemale)
						if utility.randomFloat() > 0.5
							utility.wait(utility.randomFloat(0.5, 1.0))
							SOA_PostSexGroan.cast(ThisFemale, ThisFemale)
							
						endIf
						if SOA_SmellArousalGlobal.getValue() == 1.0
							SOA_HerSmellWhenQueef.Play(ThisFemale, 1.0)
						endIf
						SOA_FemaleCumDrip.Cast(ThisFemale, ThisFemale)
				elseIf Chance == 1 && BurpOn
						SOA_PostOralBurp.play(ThisFemale)			; 33% chance of the female burping this time
						if SOA_SmellArousalGlobal.getValue() == 1.0
							SOA_BurpCum.Play(ThisFemale, 0.2)			; white puff of scent
						endIf
						if utility.randomFloat() > 0.6
							utility.wait(utility.randomFloat(1.0, 2.0))
							SOA_SwallowSemen.play(ThisFemale)
						endIf
				endIf
				if i < Queefs
					registerForSingleUpdate(utility.randomFloat(iMin, iMax))
					i += 1
				else
					if j < Queefs2
						registerForSingleUpdate(utility.randomFloat(jMin, jMax))
						j += 1
					endIf
				endIf
			endIf
		endIf
	endIf
EndEvent
