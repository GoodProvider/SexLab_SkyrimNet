Scriptname _JSW_BB_Compatibility extends Quest

Actor Property PlayerRef  Auto                          ; Reference to the player. Game.GetPlayer() is slow

_JSW_BB_Storage Property Storage  Auto                  ; Storage data helper

GlobalVariable Property VerboseMode  Auto               ; Show verbose notification messages
GlobalVariable Property AllowCreatures  Auto            ; Allow insemination from creatures
GlobalVariable Property BirthRace  Auto                 ; The race inheritance of the baby (mother = 0, father = 1, random = 2, specific = 3)
GlobalVariable Property BirthRaceSpecific  Auto         ; The specific unconditional race of the child

Quest Property RelationshipAdoptable  Auto
Quest Property RelationshipAdoption  Auto

Keyword Property ActorTypeNPC  Auto                     ; Only NPC tagged actors can be tracked
Keyword Property ActorTypeCreature  Auto                ; Keyword for identifying creature types
Keyword Property SpawnedChild  Auto                     ; Keyword for identifying Fertility Mode children

function SexLabOrgasm(string hookName, string argString, float argNum, Form sender)
{Worker function for SexLab's orgasm event}
    SexLabFramework SexLab = Game.GetFormFromFile(0x00000D62, "SexLab.esm") as SexLabFramework
    Actor[] actorList = SexLab.HookActors(argString)
    Actor femaleTarget = none
    Actor maleTarget = none
    int i = 0
    
    while (i < actorList.Length)
        if (!femaleTarget && actorList[i] && (SexLab.GetGender(actorList[i]) == 1 || SexLab.GetGender(actorList[i]) == 3))
            femaleTarget = actorList[i]
        elseIf (!maleTarget && actorList[i] && (SexLab.GetGender(actorList[i]) == 0 || SexLab.GetGender(actorList[i]) == 2))
            maleTarget = actorList[i]
        endIf
        
        i += 1
    endWhile
    
    if (!femaleTarget || !maleTarget)
        ; Must have both a male and a female
        return
    endIf
    
    if (!AllowCreatures.GetValueInt() && maleTarget.HasKeyword(ActorTypeCreature))
        ; Exclude creature insemination if disabled
        return
    endIf
    
    sslBaseAnimation animation = SexLab.HookAnimation(argString)
    int actorIndex = Storage.TrackedActorAdd(femaleTarget) ; Attempt to track the female if needed
    int spermCount = Utility.RandomInt(0, 300)
    
    ; Extremely simple check, but functional for the most part
    if (animation.HasTag("Vaginal") || animation.HasTag("Creampie") || animation.HasTag("VaginalCum"))
        if (Storage.LastConception[actorIndex] == 0.0)
            ; Add sperm to the first female found in the actor list
            Storage.LastInsemination[actorIndex] = Utility.GetCurrentGameTime()
            
            if (Storage.SpermCount[actorIndex] <= spermCount)
                Storage.CurrentFather[actorIndex] = maleTarget.GetDisplayName()
                Storage.FatherRaceId[actorIndex] = maleTarget.GetRace().GetFormID()
            endIf
            
            Storage.SpermCount[actorIndex] = Storage.SpermCount[actorIndex] + spermCount
        endIf
        
        Debug.Notification(maleTarget.GetDisplayName() + " came inside " + femaleTarget.GetDisplayName())
    elseIf (animation.HasTag("Anal") || animation.HasTag("AnalCreampie") || animation.HasTag("AnalCum"))
        ; Perform a low percentage check for anal animations
        if (Utility.RandomInt(1, 100) < 2)
            if (Storage.LastConception[actorIndex] == 0.0)
                ; Add sperm to the first female found in the actor list
                Storage.LastInsemination[actorIndex] = Utility.GetCurrentGameTime()
                
                if (Storage.SpermCount[actorIndex] <= spermCount)
                    Storage.CurrentFather[actorIndex] = maleTarget.GetDisplayName()
                    Storage.FatherRaceId[actorIndex] = maleTarget.GetRace().GetFormID()
                endIf
            
                Storage.SpermCount[actorIndex] = Storage.SpermCount[actorIndex] + spermCount
            endIf
            
            Debug.Notification(maleTarget.GetDisplayName() + " came inside " + femaleTarget.GetDisplayName())
        endIf
    endIf
endFunction

function SexLabSeparateOrgasm(Form actorRef, int thread)
{Worker function for SexLab's separate orgasm event}
    SexLabFramework SexLab = Game.GetFormFromFile(0x00000D62, "SexLab.esm") as SexLabFramework
    String argString = thread as String
    Actor maleTarget = actorRef as Actor
    Actor femaleTarget = none
    
    if (SexLab.GetGender(maleTarget) != 0 && SexLab.GetGender(maleTarget) != 2)
        return
    endIf
    
    Actor[] actorList = SexLab.HookActors(argString)
    
    if (actorList.Length > 1 && maleTarget != actorList[0])
        if (actorList[0] && (SexLab.GetGender(actorList[0]) == 1 || SexLab.GetGender(actorList[0]) == 3))
            femaleTarget = actorList[0]
        endIf
    endIf
    
    if (!femaleTarget || !maleTarget)
        ; Must have both a male and a female
        return
    endIf
    
    if (!AllowCreatures.GetValueInt() && maleTarget.HasKeyword(ActorTypeCreature))
        ; Exclude creature insemination if disabled
        return
    endIf
    
    sslBaseAnimation animation = SexLab.HookAnimation(argString)
    int actorIndex = Storage.TrackedActorAdd(femaleTarget) ; Attempt to track the female if needed
    int spermCount = Utility.RandomInt(0, 300)
    
    ; Extremely simple check, but functional for the most part
    if (animation.HasTag("Vaginal") || animation.HasTag("Creampie") || animation.HasTag("VaginalCum"))
        if (Storage.LastConception[actorIndex] == 0.0)
            ; Add sperm to the first female found in the actor list
            Storage.LastInsemination[actorIndex] = Utility.GetCurrentGameTime()
            Storage.SpermCount[actorIndex] = Storage.SpermCount[actorIndex] + spermCount
            Storage.CurrentFather[actorIndex] = maleTarget.GetDisplayName()
            Storage.FatherRaceId[actorIndex] = maleTarget.GetRace().GetFormID()
        endIf
        
        Debug.Notification(maleTarget.GetDisplayName() + " came inside " + femaleTarget.GetDisplayName())
    elseIf (animation.HasTag("Anal") || animation.HasTag("AnalCreampie") || animation.HasTag("AnalCum"))
        ; Perform a low percentage check for anal animations
        if (Utility.RandomInt(1, 100) < 2)
            if (Storage.LastConception[actorIndex] == 0.0)
                ; Add sperm to the first female found in the actor list
                Storage.LastInsemination[actorIndex] = Utility.GetCurrentGameTime()
                Storage.SpermCount[actorIndex] = Storage.SpermCount[actorIndex] + spermCount
                Storage.CurrentFather[actorIndex] = maleTarget.GetDisplayName()
                Storage.FatherRaceId[actorIndex] = maleTarget.GetRace().GetFormID()
            endIf
            
            Debug.Notification(maleTarget.GetDisplayName() + " came inside " + femaleTarget.GetDisplayName())
        endIf
    endIf
endFunction

int function GetActorGender(Actor akActor)
{Convenience function to isolate SexLab as much as possible}
    int sex = akActor.GetLeveledActorBase().GetSex()
	Debug.Trace("FM+ GetActorGender actor="+akActor.GetDisplayName()+" Base gender="+sex)
    
    if (Game.GetFormFromFile(0x00000D62, "SexLab.esm"))
       sex = (Game.GetFormFromFile(0x00000D62, "SexLab.esm") as SexLabFramework).GetGender(akActor)
		Debug.Trace("FM+ GetActorGender actor="+akActor.GetDisplayName()+" Sexlab gender="+sex)
    endIf
    
    return sex
endFunction

string function TryAdoptChildMcm(Actor child)
{Debug function for spawning and adopting a child in the MCM}
    if (!child.HasKeyword(SpawnedChild))
        return "Invalid actor selected"
    endIf
    
    BYOHRelationshipAdoptableScript adoptData = (RelationshipAdoptable as BYOHRelationshipAdoptableScript)
    BYOHRelationshipAdoptionScript adoptHookScript = (RelationshipAdoption as BYOHRelationshipAdoptionScript)
    PHX_HomeManagerScript multipleAdoptions = Game.GetFormFromFile(0x00009a15, "HearthfireMultiKid.esp") as PHX_HomeManagerScript
    
    if (adoptHookScript.numChildrenAdopted == 6)
		; Adopted children maxed out with Hearthfire Multiple Adoptions
		return "Maximum adoptions reached"
	elseIf (!multipleAdoptions && adoptHookScript.numChildrenAdopted == 2)
		; Adopted children maxed out with vanilla Hearthfire
		return "Maximum adoptions reached"
	endIf
    
    int destination = 0
    bool hasBeds = false
    bool inTargetLocation = false
    Location targetLocation = none
    
    ; Make sure that the current status of house ownership is available
    adoptData.UpdateHouseStatus()
    
    if (multipleAdoptions && multipleAdoptions.getCurrentHomeLocation())
		destination = adoptData.ValidateMoveDestination(9, 0)
		targetLocation = MultipleAdoptions.getCurrentHomeLocation()
		inTargetLocation = (PlayerRef.GetCurrentLocation() == targetLocation)
	else
		; Fall back to default behavior (vanilla homes)
		destination = adoptData.ValidateMoveDestination(0, 0)
		targetLocation = adoptHookScript.TranslateHouseIntToInteriorLoc(destination)
		inTargetLocation = (PlayerRef.GetCurrentLocation() == targetLocation)
	endIf
    
    if (destination != 0 && !inTargetLocation)
        ; The target house is stored in variable07 on the child actor by Hearthfire, so we'll do the same
        child.SetActorValue("Variable07", destination)
        
        ; Adopt and go!
        RelationshipAdoption.SetStage(10)
        adoptHookScript.AdoptChild(child)
        
        child.EvaluatePackage()
        child.MoveToPackageLocation()
        
        child.SetActorValue("Variable06", 0) ; Set child state to normal activity
	    child.SetActorValue("Variable07", 0) ; Set forcegreet to uninitialized
        
        return "Adopting for target location: " + targetLocation.GetName()
    else
        return "No valid available houses"
    endIf
endFunction

Actor function TrySpawnChildAdopt(Actor akActor)
{Attempt to spawn a child actor through the Hearthfire adoption system}
	int actorIndex = Storage.TrackedActors.Find(akActor)
	int raceIndex
	
	if (BirthRace.GetValueInt() == 0)
	    raceIndex = Storage.BirthMotherRace.Find(akActor.GetLeveledActorBase().GetRace())
	elseIf (BirthRace.GetValueInt() == 1)
		if (Storage.FatherRaceId[actorIndex] == -1)
			; Safety check for a missing father race, use the mother
			raceIndex = Storage.BirthMotherRace.Find(akActor.GetLeveledActorBase().GetRace())
		else
			raceIndex = Storage.BirthMotherRace.Find(Game.GetForm(Storage.FatherRaceId[actorIndex]) as Race)
		endIf
	elseIf (BirthRace.GetValueInt() == 2)
		if (Storage.FatherRaceId[actorIndex] == -1)
			; Safety check for a missing father race, use the mother
			raceIndex = Storage.BirthMotherRace.Find(akActor.GetLeveledActorBase().GetRace())
		elseIf (Utility.RandomInt(1, 100) < 50)
			raceIndex = Storage.BirthMotherRace.Find(akActor.GetLeveledActorBase().GetRace())
		else
			raceIndex = Storage.BirthMotherRace.Find(Game.GetForm(Storage.FatherRaceId[actorIndex]) as Race)
		endIf
    else
    	raceIndex = BirthRaceSpecific.GetValueInt()
    endIf
    
    if (raceIndex != -1)
        BYOHRelationshipAdoptableScript adoptData = (RelationshipAdoptable as BYOHRelationshipAdoptableScript)
        BYOHRelationshipAdoptionScript adoptHookScript = (RelationshipAdoption as BYOHRelationshipAdoptionScript)
        PHX_HomeManagerScript multipleAdoptions = Game.GetFormFromFile(0x00009a15, "HearthfireMultiKid.esp") as PHX_HomeManagerScript
        
        if (adoptHookScript.numChildrenAdopted == 6)
			; Adopted children maxed out with Hearthfire Multiple Adoptions
			return none
		elseIf (!multipleAdoptions && adoptHookScript.numChildrenAdopted == 2)
			; Adopted children maxed out with vanilla Hearthfire
			return none
		endIf
        
        int destination = 0
        bool hasBeds = false
        bool inTargetLocation = false
        Location targetLocation = none
        
        ; Make sure that the current status of house ownership is available
        adoptData.UpdateHouseStatus()
        
        if (multipleAdoptions && multipleAdoptions.getCurrentHomeLocation())
			destination = adoptData.ValidateMoveDestination(9, 0)
			targetLocation = MultipleAdoptions.getCurrentHomeLocation()
			inTargetLocation = (PlayerRef.GetCurrentLocation() == targetLocation)
		else
			; Fall back to default behavior (vanilla homes)
			destination = adoptData.ValidateMoveDestination(0, 0)
			targetLocation = adoptHookScript.TranslateHouseIntToInteriorLoc(destination)
			inTargetLocation = (PlayerRef.GetCurrentLocation() == targetLocation)
		endIf
        
        if (destination != 0 && !inTargetLocation)
            int gender = Utility.RandomInt(0, 1)
            
            ActorBase childBase = Storage.Children[2 * raceIndex + gender]
            
            ; Match hair color to the parent
            childBase.SetHairColor(akActor.GetActorBase().GetHairColor())
            
            Actor child = PlayerRef.PlaceActorAtMe(childBase) as Actor
        
            ; The target house is stored in variable07 on the child actor by Hearthfire, so we'll do the same
            child.SetActorValue("Variable07", destination)
            
            ; Adopt and go!
            RelationshipAdoption.SetStage(10)
            adoptHookScript.AdoptChild(child)
            
            child.EvaluatePackage()
            child.MoveToPackageLocation()
            
            if (VerboseMode.GetValueInt())
	        	Debug.Notification("Mother '" + akActor.GetDisplayName() + "': New child sent to " + targetLocation.GetName())
	        endIf
	        
	        child.SetActorValue("Variable06", 0) ; Set child state to normal activity
	        child.SetActorValue("Variable07", 0) ; Set forcegreet to uninitialized
            
            return child
        else
        	if (VerboseMode.GetValueInt())
        		if (destination == 0)
	        		Debug.Notification("Mother '" + akActor.GetDisplayName() + "': No available homes for child growth")
	        	endIf
	        	
	        	if (inTargetLocation)
	        		Debug.Notification("Mother '" + akActor.GetDisplayName() + "': Player cannot be in the target home for child growth")
	        	endIf
	        endIf
	        
            return none
        endIf
    else
        ; The actor's race is unsupported
        if (VerboseMode.GetValueInt())
        	Debug.Notification("Mother '" + akActor.GetDisplayName() + "': Unsupported race for child growth")
        endIf
        
        return none
    endIf
endFunction