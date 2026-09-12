scriptName RealNamesChange extends Quest

GlobalVariable Property RNBandit Auto
GlobalVariable Property RNForsworn Auto
GlobalVariable Property RNGuard Auto
GlobalVariable Property RNStendarr Auto
GlobalVariable Property RNThalmor Auto
GlobalVariable Property RNVampire Auto
GlobalVariable Property RNDragon Auto
GlobalVariable Property RNDragonPriest Auto
GlobalVariable Property RNDaedra Auto
GlobalVariable Property RNCreature Auto
GlobalVariable Property RNOther Auto

GlobalVariable Property RNDoLastNames Auto

GlobalVariable Property RNQuestName Auto

Faction Property FacBandit Auto
Faction Property FacForsworn Auto
Faction Property FacHagraven Auto
Faction Property FacGuard Auto
Faction Property FacStendarr Auto
Faction Property FacThalmor Auto
Faction Property FacVampire Auto
Faction Property FacVampireThrall Auto
Faction Property FacDragon Auto
Faction Property FacDragonPriest Auto
Faction Property FacDaedra Auto
Faction Property FacCreature Auto
Faction Property NameChangedFaction = None Auto Hidden

FormList Property UniquesRename Auto
FormList Property NonUniqueNoRename Auto

bool Function ShouldChangeName(Actor akTarget)
	if akTarget == None
		Debug.Trace("RealNamesChange: Skipping actor=NONE")
		return false
	endif
	if NameChangedFaction == None && Game.GetModByName("DiaryOfMine.esm") != 255
		NameChangedFaction = Game.GetFormFromFile(0x00F6EC5B, "DiaryOfMine.esm") as Faction
	endif
	if NameChangedFaction != None
		if akTarget.IsInFaction(NameChangedFaction)
			;Debug.Trace("RealNamesChange: Skipping actor in name changed faction "+akTarget.GetDisplayName()+" "+NameChangedFaction)
			return false
		endif
	endif
	string current_name = akTarget.GetDisplayName()
	bool doChangeName
	ActorBase abTarget = akTarget.GetLeveledActorBase()
	if abTarget == None
		Debug.Trace("RealNamesChange: Skipping actor with NONE ActorBase "+current_name)
		if NameChangedFaction != None
			akTarget.SetFactionRank(NameChangedFaction,0) ; 0=something went wrong
		endif
		return false
	endif
	string base_name = abTarget.GetName()
	if base_name != current_name && current_name != ""
		Debug.Trace("RealNamesChange: Skipping already renamed actor "+current_name+" "+base_name)
		doChangeName =  false
	elseif abTarget.IsUnique()
		If UniquesRename.Find(abTarget) >= 0
			; Target is Unique, but is on the list to rename anyway
			Debug.Trace("RealNamesChange: Will Rename UNIQUE "+current_name+" "+base_name)
			doChangeName =  true
		Else
			; Target is unique, and not on the list to rename anyway
			Debug.Trace("RealNamesChange: Won't Rename UNIQUE "+current_name+" "+base_name)
			doChangeName =  false
		EndIf
	Else ; Target is not unique
		If NonUniqueNoRename.Find(abTarget) >= 0
			; Target is not unique, but is on the list to not rename
			Debug.Trace("RealNamesChange: Won't Rename NON-UNIQUE "+current_name+" "+base_name)
			doChangeName =  false
		Else
			; Target is not unique, and is not on the list to not rename
			Debug.Trace("RealNamesChange: Will Rename NON-UNIQUE "+current_name+" "+base_name)
			doChangeName =  true
		Endif
	EndIf
	if NameChangedFaction != None
		akTarget.SetFactionRank(NameChangedFaction,1) ; 1=name was not changed by Real Names
	endif
	;Debug.Trace("RealNamesChange: Will Rename actor doChangeName="+doChangeName+" current name="+current_name+" "+base_name)
	return doChangeName
EndFunction

Function ChangeName(Actor akTarget, String newFirstName, String newLastName)
	If RNQuestName.GetValue() as int == 0
		QuestNamefalse(akTarget, newFirstName, newLastName)
	Else
		QuestNametrue(akTarget, newFirstName, newLastName)
	EndIf
	if NameChangedFaction != None
		akTarget.SetFactionRank(NameChangedFaction,2) ; 2=name was changed by Real Names
	endif
EndFunction

Function QuestNamefalse(Actor akTarget, String newFirstName, String newLastName)

	ActorBase TargetRef = akTarget.GetLeveledActorBase()
	; ; Debug.Trace("RealNamesChange: akTarget.IsInFaction(FacBandit) = " + akTarget.IsInFaction(FacBandit))
	IF akTarget.IsInFaction(FacBandit)
		Int RNBanditGV = RNBandit.GetValue() as int
		If RNBanditGV == 0
			Return
		ElseIf RNBanditGV == 1
			string newName = newFirstName
			if (RNDoLastNames.GetValue() == 1 && newLastName != "")
				newName += " " + newLastName
			endif
			if (StorageUtil.HasStringValue(akTarget, "RNE_Name"))
				newName = StorageUtil.GetStringValue(akTarget, "RNE_Name")
			Else
				StorageUtil.SetStringValue(akTarget, "RNE_Name", newName)
			EndIf
			akTarget.SetDisplayName(newName, false)
			Return
		ElseIf RNBanditGV == 2
			String oldname = TargetRef.GetName()
			string newName = newFirstName
			if (RNDoLastNames.GetValue() == 1 && newLastName != "")
				newName += " " + newLastName
			endif
			if (StorageUtil.HasStringValue(akTarget, "RNE_Name"))
				newName = StorageUtil.GetStringValue(akTarget, "RNE_Name")
			Else
				StorageUtil.SetStringValue(akTarget, "RNE_Name", newName)
			EndIf
			akTarget.SetDisplayName(newName + ", " + oldname, false)
			Return
		Endif	
	Endif
	; ; Debug.Trace("RealNamesChange: akTarget.IsInFaction(FacForsworn) = " + akTarget.IsInFaction(FacForsworn))
	; ; Debug.Trace("RealNamesChange: akTarget.IsInFaction(FacHagraven) = " + akTarget.IsInFaction(FacHagraven))
	IF akTarget.IsInFaction(FacForsworn) || akTarget.IsInFaction(FacHagraven)
		Int RNForswornGV = RNForsworn.GetValue() as int
		If RNForswornGV == 0
			Return
		ElseIf RNForswornGV == 1
			string newName = newFirstName
			if (RNDoLastNames.GetValue() == 1 && newLastName != "")
				newName += " " + newLastName
			endif
			if (StorageUtil.HasStringValue(akTarget, "RNE_Name"))
				newName = StorageUtil.GetStringValue(akTarget, "RNE_Name")
			Else
				StorageUtil.SetStringValue(akTarget, "RNE_Name", newName)
			EndIf
			akTarget.SetDisplayName(newName, false)
			Return
		ElseIf RNForswornGV == 2
			String oldname = TargetRef.GetName()
			string newName = newFirstName
			if (RNDoLastNames.GetValue() == 1 && newLastName != "")
				newName += " " + newLastName
			endif
			if (StorageUtil.HasStringValue(akTarget, "RNE_Name"))
				newName = StorageUtil.GetStringValue(akTarget, "RNE_Name")
			Else
				StorageUtil.SetStringValue(akTarget, "RNE_Name", newName)
			EndIf
			akTarget.SetDisplayName(newName + ", " + oldname, false)
			Return
		Endif	
	Endif
	; Debug.Trace("RealNamesChange: akTarget.IsInFaction(FacGuard) = " + akTarget.IsInFaction(FacGuard))
	IF akTarget.IsInFaction(FacGuard)
		Int RNGuardGV = RNGuard.GetValue() as int
		If RNGuardGV == 0
			Return
		ElseIf RNGuardGV == 1
			string newName = newFirstName
			if (RNDoLastNames.GetValue() == 1 && newLastName != "")
				newName += " " + newLastName
			endif
			if (StorageUtil.HasStringValue(akTarget, "RNE_Name"))
				newName = StorageUtil.GetStringValue(akTarget, "RNE_Name")
			Else
				StorageUtil.SetStringValue(akTarget, "RNE_Name", newName)
			EndIf
			akTarget.SetDisplayName(newName, false)
			Return
		ElseIf RNGuardGV == 2
			String oldname = TargetRef.GetName()
			string newName = newFirstName
			if (RNDoLastNames.GetValue() == 1 && newLastName != "")
				newName += " " + newLastName
			endif
			if (StorageUtil.HasStringValue(akTarget, "RNE_Name"))
				newName = StorageUtil.GetStringValue(akTarget, "RNE_Name")
			Else
				StorageUtil.SetStringValue(akTarget, "RNE_Name", newName)
			EndIf
			akTarget.SetDisplayName(newName + ", " + oldname, false)
			Return
		Endif	
	Endif
	; Debug.Trace("RealNamesChange: akTarget.IsInFaction(FacStendarr) = " + akTarget.IsInFaction(FacStendarr))
	IF akTarget.IsInFaction(FacStendarr)
		Int RNStendarrGV = RNStendarr.GetValue() as int
		If RNStendarrGV == 0
			Return
		ElseIf RNStendarrGV == 1
			string newName = newFirstName
			if (RNDoLastNames.GetValue() == 1 && newLastName != "")
				newName += " " + newLastName
			endif
			if (StorageUtil.HasStringValue(akTarget, "RNE_Name"))
				newName = StorageUtil.GetStringValue(akTarget, "RNE_Name")
			Else
				StorageUtil.SetStringValue(akTarget, "RNE_Name", newName)
			EndIf
			akTarget.SetDisplayName(newName, false)
			Return
		ElseIf RNStendarrGV == 2
			String oldname = TargetRef.GetName()
			string newName = newFirstName
			if (RNDoLastNames.GetValue() == 1 && newLastName != "")
				newName += " " + newLastName
			endif
			if (StorageUtil.HasStringValue(akTarget, "RNE_Name"))
				newName = StorageUtil.GetStringValue(akTarget, "RNE_Name")
			Else
				StorageUtil.SetStringValue(akTarget, "RNE_Name", newName)
			EndIf
			akTarget.SetDisplayName(newName + ", " + oldname, false)
			Return
		Endif	
	Endif
	; Debug.Trace("RealNamesChange: akTarget.IsInFaction(FacThalmor) = " + akTarget.IsInFaction(FacThalmor))
	IF akTarget.IsInFaction(FacThalmor)
		Int RNThalmorGV = RNThalmor.GetValue() as int
		If RNThalmorGV == 0
			Return
		ElseIf RNThalmorGV == 1
			string newName = newFirstName
			if (RNDoLastNames.GetValue() == 1 && newLastName != "")
				newName += " " + newLastName
			endif
			if (StorageUtil.HasStringValue(akTarget, "RNE_Name"))
				newName = StorageUtil.GetStringValue(akTarget, "RNE_Name")
			Else
				StorageUtil.SetStringValue(akTarget, "RNE_Name", newName)
			EndIf
			akTarget.SetDisplayName(newName, false)
			Return
		ElseIf RNThalmorGV == 2
			String oldname = TargetRef.GetName()
			string newName = newFirstName
			if (RNDoLastNames.GetValue() == 1 && newLastName != "")
				newName += " " + newLastName
			endif
			if (StorageUtil.HasStringValue(akTarget, "RNE_Name"))
				newName = StorageUtil.GetStringValue(akTarget, "RNE_Name")
			Else
				StorageUtil.SetStringValue(akTarget, "RNE_Name", newName)
			EndIf
			akTarget.SetDisplayName(newName + ", " + oldname, false)
			Return
		Endif	
	Endif
	; Debug.Trace("RealNamesChange: akTarget.IsInFaction(FacVampire) = " + akTarget.IsInFaction(FacVampire))
	; Debug.Trace("RealNamesChange: akTarget.IsInFaction(FacVampireThrall) = " + akTarget.IsInFaction(FacVampireThrall))
	IF akTarget.IsInFaction(FacVampire) || akTarget.IsInFaction(FacVampireThrall)
		Int RNVampireGV = RNVampire.GetValue() as int
		If RNVampireGV == 0
			Return
		ElseIf RNVampireGV == 1
			string newName = newFirstName
			if (RNDoLastNames.GetValue() == 1 && newLastName != "")
				newName += " " + newLastName
			endif
			if (StorageUtil.HasStringValue(akTarget, "RNE_Name"))
				newName = StorageUtil.GetStringValue(akTarget, "RNE_Name")
			Else
				StorageUtil.SetStringValue(akTarget, "RNE_Name", newName)
			EndIf
			akTarget.SetDisplayName(newName, false)
			Return
		ElseIf RNVampireGV == 2
			String oldname = TargetRef.GetName()
			string newName = newFirstName
			if (RNDoLastNames.GetValue() == 1 && newLastName != "")
				newName += " " + newLastName
			endif
			if (StorageUtil.HasStringValue(akTarget, "RNE_Name"))
				newName = StorageUtil.GetStringValue(akTarget, "RNE_Name")
			Else
				StorageUtil.SetStringValue(akTarget, "RNE_Name", newName)
			EndIf
			akTarget.SetDisplayName(newName + ", " + oldname, false)
			Return
		Endif	
	Endif

	; Debug.Trace("RealNamesChange: akTarget.IsInFaction(FacDragon) = " + akTarget.IsInFaction(FacDragon))
	IF akTarget.IsInFaction(FacDragon)
		Int RNDragonGV = RNDragon.GetValue() as int
		; Debug.Trace("RNDragonGV = " + RNDragonGV)
		If RNDragonGV == 0
			Return
		ElseIf RNDragonGV == 1
			string newName = newFirstName
			if (RNDoLastNames.GetValue() == 1 && newLastName != "")
				newName += " " + newLastName
			endif
			if (StorageUtil.HasStringValue(akTarget, "RNE_Name"))
				newName = StorageUtil.GetStringValue(akTarget, "RNE_Name")
			Else
				StorageUtil.SetStringValue(akTarget, "RNE_Name", newName)
			EndIf
			akTarget.SetDisplayName(newName, false)
			Return
		ElseIf RNDragonGV == 2
			String oldname = TargetRef.GetName()
			string newName = newFirstName
			if (RNDoLastNames.GetValue() == 1 && newLastName != "")
				newName += " " + newLastName
			endif
			if (StorageUtil.HasStringValue(akTarget, "RNE_Name"))
				newName = StorageUtil.GetStringValue(akTarget, "RNE_Name")
			Else
				StorageUtil.SetStringValue(akTarget, "RNE_Name", newName)
			EndIf
			akTarget.SetDisplayName(newName + ", " + oldname, false)
			Return
		Endif	
	Endif

	; Debug.Trace("RealNamesChange: akTarget.IsInFaction(FacDragonPriest) = " + akTarget.IsInFaction(FacDragonPriest))
	IF akTarget.IsInFaction(FacDragonPriest)
		Int RNDragonPriestGV = RNDragonPriest.GetValue() as int
		; Debug.Trace("RNDragonPriestGV = " + RNDragonPriestGV)
		If RNDragonPriestGV == 0
			Return
		ElseIf RNDragonPriestGV == 1
			string newName = newFirstName
			if (RNDoLastNames.GetValue() == 1 && newLastName != "")
				newName += " " + newLastName
			endif
			if (StorageUtil.HasStringValue(akTarget, "RNE_Name"))
				newName = StorageUtil.GetStringValue(akTarget, "RNE_Name")
			Else
				StorageUtil.SetStringValue(akTarget, "RNE_Name", newName)
			EndIf
			akTarget.SetDisplayName(newName, false)
			Return
		ElseIf RNDragonPriestGV == 2
			String oldname = TargetRef.GetName()
			string newName = newFirstName
			if (RNDoLastNames.GetValue() == 1 && newLastName != "")
				newName += " " + newLastName
			endif
			if (StorageUtil.HasStringValue(akTarget, "RNE_Name"))
				newName = StorageUtil.GetStringValue(akTarget, "RNE_Name")
			Else
				StorageUtil.SetStringValue(akTarget, "RNE_Name", newName)
			EndIf
			akTarget.SetDisplayName(newName + ", " + oldname, false)
			Return
		Endif	
	Endif

	; Debug.Trace("RealNamesChange: akTarget.IsInFaction(FacDaedra) = " + akTarget.IsInFaction(FacDaedra))
	IF akTarget.IsInFaction(FacDaedra)
		Int RNDaedraGV = RNDaedra.GetValue() as int
		; Debug.Trace("RNDaedraGV = " + RNDaedraGV)
		If RNDaedraGV == 0
			Return
		ElseIf RNDaedraGV == 1
			string newName = newFirstName
			if (RNDoLastNames.GetValue() == 1 && newLastName != "")
				newName += " " + newLastName
			endif
			if (StorageUtil.HasStringValue(akTarget, "RNE_Name"))
				newName = StorageUtil.GetStringValue(akTarget, "RNE_Name")
			Else
				StorageUtil.SetStringValue(akTarget, "RNE_Name", newName)
			EndIf
			akTarget.SetDisplayName(newName, false)
			Return
		ElseIf RNDaedraGV == 2
			String oldname = TargetRef.GetName()
			string newName = newFirstName
			if (RNDoLastNames.GetValue() == 1 && newLastName != "")
				newName += " " + newLastName
			endif
			if (StorageUtil.HasStringValue(akTarget, "RNE_Name"))
				newName = StorageUtil.GetStringValue(akTarget, "RNE_Name")
			Else
				StorageUtil.SetStringValue(akTarget, "RNE_Name", newName)
			EndIf
			akTarget.SetDisplayName(newName + ", " + oldname, false)
			Return
		Endif	
	Endif

	; Debug.Trace("RealNamesChange: akTarget.IsInFaction(FacCreature) = " + akTarget.IsInFaction(FacCreature))
	IF akTarget.IsInFaction(FacCreature)
		Int RNCreatureGV = RNCreature.GetValue() as int
		; Debug.Trace("RNCreatureGV = " + RNCreatureGV)
		If RNCreatureGV == 0
			Return
		ElseIf RNCreatureGV == 1
			string newName = newFirstName
			if (RNDoLastNames.GetValue() == 1 && newLastName != "")
				newName += " " + newLastName
			endif
			if (StorageUtil.HasStringValue(akTarget, "RNE_Name"))
				newName = StorageUtil.GetStringValue(akTarget, "RNE_Name")
			Else
				StorageUtil.SetStringValue(akTarget, "RNE_Name", newName)
			EndIf
			akTarget.SetDisplayName(newName, false)
			Return
		ElseIf RNCreatureGV == 2
			String oldname = TargetRef.GetName()
			string newName = newFirstName
			if (RNDoLastNames.GetValue() == 1 && newLastName != "")
				newName += " " + newLastName
			endif
			if (StorageUtil.HasStringValue(akTarget, "RNE_Name"))
				newName = StorageUtil.GetStringValue(akTarget, "RNE_Name")
			Else
				StorageUtil.SetStringValue(akTarget, "RNE_Name", newName)
			EndIf
			akTarget.SetDisplayName(newName + ", " + oldname, false)
			Return
		Endif	
	Endif

	; Debug.Trace("RealNamesChange: Target falls under 'Other'")
		Int RNOtherGV = RNOther.GetValue() as int
		If RNOtherGV == 0
			Return
		ElseIf RNOtherGV == 1
			string newName = newFirstName
			if (RNDoLastNames.GetValue() == 1 && newLastName != "")
				newName += " " + newLastName
			endif
			if (StorageUtil.HasStringValue(akTarget, "RNE_Name"))
				newName = StorageUtil.GetStringValue(akTarget, "RNE_Name")
			Else
				StorageUtil.SetStringValue(akTarget, "RNE_Name", newName)
			EndIf
			akTarget.SetDisplayName(newName, false)
			Return
		ElseIf RNOtherGV == 2
			String oldname = TargetRef.GetName()
			string newName = newFirstName
			if (RNDoLastNames.GetValue() == 1 && newLastName != "")
				newName += " " + newLastName
			endif
			if (StorageUtil.HasStringValue(akTarget, "RNE_Name"))
				newName = StorageUtil.GetStringValue(akTarget, "RNE_Name")
			Else
				StorageUtil.SetStringValue(akTarget, "RNE_Name", newName)
			EndIf
			akTarget.SetDisplayName(newName + ", " + oldname, false)
			Return
		Endif	

EndFunction



Function QuestNametrue(Actor akTarget, String newFirstName, String newLastName)

	ActorBase TargetRef = akTarget.GetLeveledActorBase()

	IF akTarget.IsInFaction(FacBandit)
		Int RNBanditGV = RNBandit.GetValue() as int
		If RNBanditGV == 0
			Return
		ElseIf RNBanditGV == 1
			string newName = newFirstName
			if (RNDoLastNames.GetValue() == 1 && newLastName != "")
				newName += " " + newLastName
			endif
			if (StorageUtil.HasStringValue(akTarget, "RNE_Name"))
				newName = StorageUtil.GetStringValue(akTarget, "RNE_Name")
			Else
				StorageUtil.SetStringValue(akTarget, "RNE_Name", newName)
			EndIf
			akTarget.SetDisplayName(newName, true)
			Return
		ElseIf RNBanditGV == 2
			String oldname = TargetRef.GetName()
			string newName = newFirstName
			if (RNDoLastNames.GetValue() == 1 && newLastName != "")
				newName += " " + newLastName
			endif
			if (StorageUtil.HasStringValue(akTarget, "RNE_Name"))
				newName = StorageUtil.GetStringValue(akTarget, "RNE_Name")
			Else
				StorageUtil.SetStringValue(akTarget, "RNE_Name", newName)
			EndIf
			akTarget.SetDisplayName(newName + ", " + oldname, true)
			Return
		Endif	
	Endif

	IF akTarget.IsInFaction(FacForsworn) || akTarget.IsInFaction(FacHagraven)
		Int RNForswornGV = RNForsworn.GetValue() as int
		If RNForswornGV == 0
			Return
		ElseIf RNForswornGV == 1
			string newName = newFirstName
			if (RNDoLastNames.GetValue() == 1 && newLastName != "")
				newName += " " + newLastName
			endif
			if (StorageUtil.HasStringValue(akTarget, "RNE_Name"))
				newName = StorageUtil.GetStringValue(akTarget, "RNE_Name")
			Else
				StorageUtil.SetStringValue(akTarget, "RNE_Name", newName)
			EndIf
			akTarget.SetDisplayName(newName, true)
			Return
		ElseIf RNForswornGV == 2
			String oldname = TargetRef.GetName()
			string newName = newFirstName
			if (RNDoLastNames.GetValue() == 1 && newLastName != "")
				newName += " " + newLastName
			endif
			if (StorageUtil.HasStringValue(akTarget, "RNE_Name"))
				newName = StorageUtil.GetStringValue(akTarget, "RNE_Name")
			Else
				StorageUtil.SetStringValue(akTarget, "RNE_Name", newName)
			EndIf
			akTarget.SetDisplayName(newName + ", " + oldname, true)
			Return
		Endif	
	Endif

	IF akTarget.IsInFaction(FacGuard)
		Int RNGuardGV = RNGuard.GetValue() as int
		If RNGuardGV == 0
			Return
		ElseIf RNGuardGV == 1
			string newName = newFirstName
			if (RNDoLastNames.GetValue() == 1 && newLastName != "")
				newName += " " + newLastName
			endif
			if (StorageUtil.HasStringValue(akTarget, "RNE_Name"))
				newName = StorageUtil.GetStringValue(akTarget, "RNE_Name")
			Else
				StorageUtil.SetStringValue(akTarget, "RNE_Name", newName)
			EndIf
			akTarget.SetDisplayName(newName, true)
			Return
		ElseIf RNGuardGV == 2
			String oldname = TargetRef.GetName()
			string newName = newFirstName
			if (RNDoLastNames.GetValue() == 1 && newLastName != "")
				newName += " " + newLastName
			endif
			if (StorageUtil.HasStringValue(akTarget, "RNE_Name"))
				newName = StorageUtil.GetStringValue(akTarget, "RNE_Name")
			Else
				StorageUtil.SetStringValue(akTarget, "RNE_Name", newName)
			EndIf
			akTarget.SetDisplayName(newName + ", " + oldname, true)
			Return
		Endif	
	Endif

	IF akTarget.IsInFaction(FacStendarr)
		Int RNStendarrGV = RNStendarr.GetValue() as int
		If RNStendarrGV == 0
			Return
		ElseIf RNStendarrGV == 1
			string newName = newFirstName
			if (RNDoLastNames.GetValue() == 1 && newLastName != "")
				newName += " " + newLastName
			endif
			if (StorageUtil.HasStringValue(akTarget, "RNE_Name"))
				newName = StorageUtil.GetStringValue(akTarget, "RNE_Name")
			Else
				StorageUtil.SetStringValue(akTarget, "RNE_Name", newName)
			EndIf
			akTarget.SetDisplayName(newName, true)
			Return
		ElseIf RNStendarrGV == 2
			String oldname = TargetRef.GetName()
			string newName = newFirstName
			if (RNDoLastNames.GetValue() == 1 && newLastName != "")
				newName += " " + newLastName
			endif
			if (StorageUtil.HasStringValue(akTarget, "RNE_Name"))
				newName = StorageUtil.GetStringValue(akTarget, "RNE_Name")
			Else
				StorageUtil.SetStringValue(akTarget, "RNE_Name", newName)
			EndIf
			akTarget.SetDisplayName(newName + ", " + oldname, true)
			Return
		Endif	
	Endif

	IF akTarget.IsInFaction(FacThalmor)
		Int RNThalmorGV = RNThalmor.GetValue() as int
		If RNThalmorGV == 0
			Return
		ElseIf RNThalmorGV == 1
			string newName = newFirstName
			if (RNDoLastNames.GetValue() == 1 && newLastName != "")
				newName += " " + newLastName
			endif
			if (StorageUtil.HasStringValue(akTarget, "RNE_Name"))
				newName = StorageUtil.GetStringValue(akTarget, "RNE_Name")
			Else
				StorageUtil.SetStringValue(akTarget, "RNE_Name", newName)
			EndIf
			akTarget.SetDisplayName(newName, true)
			Return
		ElseIf RNThalmorGV == 2
			String oldname = TargetRef.GetName()
			string newName = newFirstName
			if (RNDoLastNames.GetValue() == 1 && newLastName != "")
				newName += " " + newLastName
			endif
			if (StorageUtil.HasStringValue(akTarget, "RNE_Name"))
				newName = StorageUtil.GetStringValue(akTarget, "RNE_Name")
			Else
				StorageUtil.SetStringValue(akTarget, "RNE_Name", newName)
			EndIf
			akTarget.SetDisplayName(newName + ", " + oldname, true)
			Return
		Endif	
	Endif

	IF akTarget.IsInFaction(FacVampire) || akTarget.IsInFaction(FacVampireThrall)
		Int RNVampireGV = RNVampire.GetValue() as int
		If RNVampireGV == 0
			Return
		ElseIf RNVampireGV == 1
			string newName = newFirstName
			if (RNDoLastNames.GetValue() == 1 && newLastName != "")
				newName += " " + newLastName
			endif
			if (StorageUtil.HasStringValue(akTarget, "RNE_Name"))
				newName = StorageUtil.GetStringValue(akTarget, "RNE_Name")
			Else
				StorageUtil.SetStringValue(akTarget, "RNE_Name", newName)
			EndIf
			akTarget.SetDisplayName(newName, true)
			Return
		ElseIf RNVampireGV == 2
			String oldname = TargetRef.GetName()
			string newName = newFirstName
			if (RNDoLastNames.GetValue() == 1 && newLastName != "")
				newName += " " + newLastName
			endif
			if (StorageUtil.HasStringValue(akTarget, "RNE_Name"))
				newName = StorageUtil.GetStringValue(akTarget, "RNE_Name")
			Else
				StorageUtil.SetStringValue(akTarget, "RNE_Name", newName)
			EndIf
			akTarget.SetDisplayName(newName + ", " + oldname, true)
			Return
		Endif	
	Endif

	IF akTarget.IsInFaction(FacDragon)
		Int RNDragonGV = RNDragon.GetValue() as int
		; Debug.Trace("RNDragonGV = " + RNDragonGV)
		If RNDragonGV == 0
			Return
		ElseIf RNDragonGV == 1
			string newName = newFirstName
			if (RNDoLastNames.GetValue() == 1 && newLastName != "")
				newName += " " + newLastName
			endif
			if (StorageUtil.HasStringValue(akTarget, "RNE_Name"))
				newName = StorageUtil.GetStringValue(akTarget, "RNE_Name")
			Else
				StorageUtil.SetStringValue(akTarget, "RNE_Name", newName)
			EndIf
			akTarget.SetDisplayName(newName, true)
			Return
		ElseIf RNDragonGV == 2
			String oldname = TargetRef.GetName()
			string newName = newFirstName
			if (RNDoLastNames.GetValue() == 1 && newLastName != "")
				newName += " " + newLastName
			endif
			if (StorageUtil.HasStringValue(akTarget, "RNE_Name"))
				newName = StorageUtil.GetStringValue(akTarget, "RNE_Name")
			Else
				StorageUtil.SetStringValue(akTarget, "RNE_Name", newName)
			EndIf
			akTarget.SetDisplayName(newName + ", " + oldname, true)
			Return
		Endif	
	Endif

	IF akTarget.IsInFaction(FacDragonPriest)
		Int RNDragonPriestGV = RNDragonPriest.GetValue() as int
		; Debug.Trace("RNDragonPriestGV = " + RNDragonPriestGV)
		If RNDragonPriestGV == 0
			Return
		ElseIf RNDragonPriestGV == 1
			string newName = newFirstName
			if (RNDoLastNames.GetValue() == 1 && newLastName != "")
				newName += " " + newLastName
			endif
			if (StorageUtil.HasStringValue(akTarget, "RNE_Name"))
				newName = StorageUtil.GetStringValue(akTarget, "RNE_Name")
			Else
				StorageUtil.SetStringValue(akTarget, "RNE_Name", newName)
			EndIf
			akTarget.SetDisplayName(newName, true)
			Return
		ElseIf RNDragonPriestGV == 2
			String oldname = TargetRef.GetName()
			string newName = newFirstName
			if (RNDoLastNames.GetValue() == 1 && newLastName != "")
				newName += " " + newLastName
			endif
			if (StorageUtil.HasStringValue(akTarget, "RNE_Name"))
				newName = StorageUtil.GetStringValue(akTarget, "RNE_Name")
			Else
				StorageUtil.SetStringValue(akTarget, "RNE_Name", newName)
			EndIf
			akTarget.SetDisplayName(newName + ", " + oldname, true)
			Return
		Endif	
	Endif

	IF akTarget.IsInFaction(FacDaedra)
		Int RNDaedraGV = RNDaedra.GetValue() as int
		; Debug.Trace("RNDaedraGV = " + RNDaedraGV)
		If RNDaedraGV == 0
			Return
		ElseIf RNDaedraGV == 1
			string newName = newFirstName
			if (RNDoLastNames.GetValue() == 1 && newLastName != "")
				newName += " " + newLastName
			endif
			if (StorageUtil.HasStringValue(akTarget, "RNE_Name"))
				newName = StorageUtil.GetStringValue(akTarget, "RNE_Name")
			Else
				StorageUtil.SetStringValue(akTarget, "RNE_Name", newName)
			EndIf
			akTarget.SetDisplayName(newName, true)
			Return
		ElseIf RNDaedraGV == 2
			String oldname = TargetRef.GetName()
			string newName = newFirstName
			if (RNDoLastNames.GetValue() == 1 && newLastName != "")
				newName += " " + newLastName
			endif
			if (StorageUtil.HasStringValue(akTarget, "RNE_Name"))
				newName = StorageUtil.GetStringValue(akTarget, "RNE_Name")
			Else
				StorageUtil.SetStringValue(akTarget, "RNE_Name", newName)
			EndIf
			akTarget.SetDisplayName(newName + ", " + oldname, true)
			Return
		Endif	
	Endif

	IF akTarget.IsInFaction(FacCreature)
		Int RNCreatureGV = RNCreature.GetValue() as int
		; Debug.Trace("RNCreatureGV = " + RNCreatureGV)
		If RNCreatureGV == 0
			Return
		ElseIf RNCreatureGV == 1
			string newName = newFirstName
			if (RNDoLastNames.GetValue() == 1 && newLastName != "")
				newName += " " + newLastName
			endif
			if (StorageUtil.HasStringValue(akTarget, "RNE_Name"))
				newName = StorageUtil.GetStringValue(akTarget, "RNE_Name")
			Else
				StorageUtil.SetStringValue(akTarget, "RNE_Name", newName)
			EndIf
			akTarget.SetDisplayName(newName, true)
			Return
		ElseIf RNCreatureGV == 2
			String oldname = TargetRef.GetName()
			string newName = newFirstName
			if (RNDoLastNames.GetValue() == 1 && newLastName != "")
				newName += " " + newLastName
			endif
			if (StorageUtil.HasStringValue(akTarget, "RNE_Name"))
				newName = StorageUtil.GetStringValue(akTarget, "RNE_Name")
			Else
				StorageUtil.SetStringValue(akTarget, "RNE_Name", newName)
			EndIf
			akTarget.SetDisplayName(newName + ", " + oldname, true)
			Return
		Endif	
	Endif

		Int RNOtherGV = RNOther.GetValue() as int
		If RNOtherGV == 0
			Return
		ElseIf RNOtherGV == 1
			string newName = newFirstName
			if (RNDoLastNames.GetValue() == 1 && newLastName != "")
				newName += " " + newLastName
			endif
			if (StorageUtil.HasStringValue(akTarget, "RNE_Name"))
				newName = StorageUtil.GetStringValue(akTarget, "RNE_Name")
			Else
				StorageUtil.SetStringValue(akTarget, "RNE_Name", newName)
			EndIf
			akTarget.SetDisplayName(newName, true)
			Return
		ElseIf RNOtherGV == 2
			String oldname = TargetRef.GetName()
			string newName = newFirstName
			if (RNDoLastNames.GetValue() == 1 && newLastName != "")
				newName += " " + newLastName
			endif
			if (StorageUtil.HasStringValue(akTarget, "RNE_Name"))
				newName = StorageUtil.GetStringValue(akTarget, "RNE_Name")
			Else
				StorageUtil.SetStringValue(akTarget, "RNE_Name", newName)
			EndIf
			akTarget.SetDisplayName(newName + ", " + oldname, true)
			Return
		Endif	

EndFunction