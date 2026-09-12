ScriptName BB_TDF_Scanner extends activemagiceffect
 
Quest Property InitQuest Auto
BB_TDFEnhanced_ScannerInit Property BB_Init Auto
BM_licenses Property license Auto
BM_licenses_mcm Property license_mcm Auto
GlobalVariable Property BB_ModsInitialized Auto

Function PlayerCheckPublicWhore()
	
	quest PW1 = Game.GetFormFromFile(0x043705, "Public Whore.esp") as Quest
	quest PW2 = Game.GetFormFromFile(0x0467FB, "Public Whore.esp") as Quest
	quest PW3 = Game.GetFormFromFile(0x0467FC, "Public Whore.esp") as Quest
	quest PW4 = Game.GetFormFromFile(0x0467FD, "Public Whore.esp") as Quest
	quest PW5 = Game.GetFormFromFile(0x0467FE, "Public Whore.esp") as Quest
	quest PW6 = Game.GetFormFromFile(0x0467FF, "Public Whore.esp") as Quest
	quest PW7 = Game.GetFormFromFile(0x046800, "Public Whore.esp") as Quest
	quest PW8 = Game.GetFormFromFile(0x046801, "Public Whore.esp") as Quest
	quest PW9 = Game.GetFormFromFile(0x046802, "Public Whore.esp") as Quest

    if (PW1.isRunning() || PW2.isRunning() || PW3.isRunning() || PW4.isRunning() || PW5.isRunning() || PW6.isRunning() || PW7.isRunning() || PW8.isRunning() || PW9.isRunning())
	    BB_IsPublicWhore.SetValue(1)
    else
		BB_IsPublicWhore.SetValue(0)
	endif
	
	;Debug.Trace("Public Whore Quest 1 Active: " +PW1.IsRunning() as string)
	;Debug.Trace("Public Whore Quest 2 Active: " +PW2.IsRunning() as string)
	;Debug.Trace("Public Whore Quest 3 Active: " +PW3.IsRunning() as string)
	;Debug.Trace("Public Whore Quest 4 Active: " +PW4.IsRunning() as string)
	;Debug.Trace("Public Whore Quest 5 Active: " +PW5.IsRunning() as string)
	;Debug.Trace("Public Whore Quest 6 Active: " +PW6.IsRunning() as string)
	;Debug.Trace("Public Whore Quest 7 Active: " +PW7.IsRunning() as string)
	;Debug.Trace("Public Whore Quest 8 Active: " +PW8.IsRunning() as string)
	;Debug.Trace("Public Whore Quest 9 Active: " +PW9.IsRunning() as string)
EndFunction

Function CheckForInstalledMods()
;	Debug.Trace("TDF Scanner - CheckForInstalledMods")

    if (Game.GetModByName("SexLab - Sexual Fame [SLSF].esm") != 255)
		BB_SLSF_Installed.SetValue(1)
	else
		BB_SLSF_Installed.SetValue(0)
	endif
    if (Game.GetModByName("SL Survival.esp") != 255)
		BB_SLS_Installed.SetValue(1)
	else
		BB_SLS_Installed.SetValue(0)
	endif
    if (Game.GetModByName("Licenses.esp") != 255)
		BB_BM_Installed.SetValue(1)
	else
		BB_BM_Installed.SetValue(0)
	endif
    if (Game.GetModByName("paradise_halls.esm") != 255)
		BB_PAH_Installed.SetValue(1)
	else
		BB_PAH_Installed.SetValue(0)
	endif
    if (Game.GetModByName("PAH_HomeSweetHome.esp") != 255)
		BB_PHH_Installed.SetValue(1)
	else
		BB_PHH_Installed.SetValue(0)
	endif
    if (Game.GetModByName("DiaryOfMine.esm") != 255)
		BB_DOM_Installed.SetValue(1)
	else
		BB_DOM_Installed.SetValue(0)
	endif
    if (Game.GetModByName("ZaZAnimationPack.esm") != 255)
		BB_ZAZ_Installed.SetValue(1)
	else
		BB_ZAZ_Installed.SetValue(0)
	endif
    if (Game.GetModByName("MiasLair.esp") != 255)
		BB_MIA_Installed.SetValue(1)
	else
		BB_MIA_Installed.SetValue(0)
	endif
    if (Game.GetModByName("SexLab Eager NPCs.esp") != 255)
		BB_SLEN_Installed.SetValue(1)
	else
		BB_SLEN_Installed.SetValue(0)
	endif
    if (Game.GetModByName("Public Whore.esp") != 255)
		BB_PW_Installed.SetValue(1)
	else
		BB_PW_Installed.SetValue(0)
	endif
	BB_ModsInitialized.SetValue(1)
endFunction

Function CheckSLSLicenseExpiry()
;  Debug.Trace("TDF Scanner - CheckSLSLicenseExpiry")
; Set SLS Whore license Expiry time, if installed
  quest fucko = Game.GetFormFromFile(0x000813, "Licenses.esp") as Quest
  float iq

	if ((((BB_BM_Installed.GetValue() as string) as int) == 1) && ((fucko as BM_Licenses_mcm).isWhoreLicenseFeatureEnabled as int) == 1)
		fucko = Game.GetFormFromFile(0x000D62, "Licenses.esp") as Quest
		if (fucko as BM_Licenses).hasWhoreLicense == true
			iq = (fucko as BM_Licenses).whoreLicenseExpirationTime
		else
			iq = -1
		endif
		BB_SLS_Whore_License_Expiry.SetValue(iq)
		float CurrentTime = Utility.GetCurrentGameTime()
		BB_SLS_License_DaysPassed.SetValue(CurrentTime)
	elseif (((BB_SLS_Installed.GetValue() as string) as int) == 1)
		iq = (Game.GetFormFromFile(0x0D09E8, "SL Survival.esp") as GlobalVariable).GetValue() as float
		BB_SLS_Whore_License_Expiry.SetValue(iq)
		float CurrentTime = Utility.GetCurrentGameTime()
		BB_SLS_License_DaysPassed.SetValue(CurrentTime)
	else
		BB_SLS_Whore_License_Expiry.SetValue(0)
	endif
endFunction

Function ClearTDFReferences()
;	Debug.Trace("TDF Scanner - Clear Alias References.")
	if (pNearbyActor1 != NONE)
		pNearbyActor1.Clear()
	endif
	pNearbyActor2.Clear()
	pNearbyActor3.Clear()
	pNearbyActor4.Clear()
	pNearbyActor5.Clear()
	pNearbyActor6.Clear()
	pNearbyActor7.Clear()
	pNearbyActor8.Clear()
	pNearbyActor9.Clear()
	pNearbyActor10.Clear()
	pNearbyActor11.Clear()
	pNearbyActor12.Clear()
	pNearbyActor13.Clear()
	pNearbyActor14.Clear()
	pNearbyActor15.Clear()
	pNearbyActor16.Clear()
	ScanActor = New Actor[16]

;	if (InitQuest.GetAlias(1) == pNearbyActor1 as Alias)
;		Debug.Trace("Check For Slaves -  Couldn't clear Actor 1.")
;		Debug.Trace("Check For Slaves -  Get Nearby Actor name of: " + pNearbyActor1.GetActorReference().GetBaseObject().GetName())
;		Debug.Trace("Check For Slaves -  Get Alias name of: " + (InitQuest.GetAlias(1) as ReferenceAlias).GetActorReference().GetBaseObject().GetName())
;	else
;		Debug.Trace("Check For Slaves -  Clear Refs Says Actor 1 REF was cleared.")
;	endif
endFunction


Function CheckForNWSFollowers(actor aActor)
	if (Game.GetModByName("nwsFollowerFramework.esp") == 255)
		return
	endif
  
	faction NWSFollowerFaction = Game.GetFormFromFile(0x016EB3,"nwsFollowerFramework.esp") as Faction
	faction NWSGuardFaction = Game.GetFormFromFile(0x0750ED,"nwsFollowerFramework.esp") as Faction
	faction ImportedFollowerFaction = Game.GetFormFromFile(0x016EB1,"nwsFollowerFramework.esp") as Faction

	if (!aActor.IsInFaction(TDF_NWSFollowerFaction))
		if (aActor.IsInFaction(NWSFollowerFaction) || aActor.IsInFaction(NWSGuardFaction) || aActor.IsInFaction(ImportedFollowerFaction))
			aActor.AddToFaction(TDF_NWSFollowerFaction)
			if (aActor.IsInFaction(TDF_HSHSlaveFaction))
				aActor.RemoveFromFaction(TDF_HSHSlaveFaction)
			endif
			if (aActor.IsInFaction(TDF_DOMSlaveTraineeFaction))
				aActor.RemoveFromFaction(TDF_DOMSlaveTraineeFaction)
			endif
		endif
	endif

endFunction

Function CheckIfSlaverIsHooker(actor aActor, int IsSlaver)
	int x = 0
	while (x < 6)
		if (aActor != NONE && aActor == Hookers[x].GetActorRef())
			if (IsSlaver == 2)
				Debug.Notification("Hooker " + ((x+1) as string) + ": " + aActor.GetDisplayName() + " has been promoted to DoM Slave Trainer rank. Releasing as a hooker...")
			else
				Debug.Notification("Hooker " + ((x+1) as string) + ": " + aActor.GetDisplayName() + " has been promoted to DoM Slaver rank. Releasing as a hooker...")
			endif
			int y = 0
			while (y < 8)
				(PimpingQuests[x] as bb_pimpingandplayerquestutil).QuestClear[y].Clear()
				y += 1
			endWhile

			int MoneyEarned = ((GoldEarned[x].GetValueInt()) * ((100 - ((HookersCut.GetValue() as string) as float)) / 100)) as int
			;Debug.Notification("Total Cash Earned: " + (GoldEarned[x].GetValueInt() as string) + " , Hooker's Cut: " + (HookersCut.GetValue() as string) + " . Your Pay: " + (MoneyEarned as string) + " .")
			Game.GetPlayer().AddItem(Gold, MoneyEarned)
			GoldEarned[x].SetValue(0)
			PimpingQuests[x].Stop()
			PimpingQuests[x].SetStage(0)
			x = 5
		endif
		x += 1
	endWhile
endFunction

Function CheckForSlaves()
;	By declaring these up top, we only have to check once per script cycle
	faction PAHE_PlayerSlaveMeat
	faction PAHE_SlaveMeat
	faction PHH_HomeboySlave
	faction DOM_Slave
	faction DOM_Slaver
	faction DOM_History
	faction DOM_SlaveTraining
	faction MIA_SlaveMeat 
	faction MIA_MaleMeat
	faction ZAZ_BondageSlave



;	Debug.Trace("TDF Scanner - Check for Slaves Running")
    ScanActor = New Actor[16]
    ScanActor[0] = pNearbyActor1.GetActorReference()
    ScanActor[1] = pNearbyActor2.GetActorReference()
    ScanActor[2] = pNearbyActor3.GetActorReference()
    ScanActor[3] = pNearbyActor4.GetActorReference()
    ScanActor[4] = pNearbyActor5.GetActorReference()
    ScanActor[5] = pNearbyActor6.GetActorReference()
    ScanActor[6] = pNearbyActor7.GetActorReference()
    ScanActor[7] = pNearbyActor8.GetActorReference()
    ScanActor[8] = pNearbyActor9.GetActorReference()
    ScanActor[9] = pNearbyActor10.GetActorReference()
    ScanActor[10] = pNearbyActor11.GetActorReference()
    ScanActor[11] = pNearbyActor12.GetActorReference()
    ScanActor[12] = pNearbyActor13.GetActorReference()
    ScanActor[13] = pNearbyActor14.GetActorReference()
    ScanActor[14] = pNearbyActor15.GetActorReference()
    ScanActor[15] = pNearbyActor16.GetActorReference()
;	if (Actor[0] != NONE)
;		Debug.Trace("Actor " +x as string+ " Name: " + Actor[x].GetActorRef().GetDisplayName()
;	endif

	int x=0
	while (x<16)
;		if(ScanActor[x] != NONE)
;			Debug.Trace ("Check for Slaves - Checking " +ScanActor[x].GetBaseObject().GetName() + " in Slot: " + x as string + ".")
;		else
;			Debug.Trace ("Check for Slaves - Slot: " + x as string + " : No Actor Found.")
;		endif
		int IsSlave = 0
		int IsSlaver = 0
		int IsHSHSlave = 0
		int IsDOMSlaveTrainee = 0

		if(ScanActor[x] != NONE)
			if(BB_PAH_Installed.GetValueInt() == 1) 
				if ( PAHE_PlayerSlaveMeat == NONE)
					PAHE_PlayerSlaveMeat = Game.GetFormFromFile(0x0047DB, "paradise_halls.esm") as Faction 
					PAHE_SlaveMeat = Game.GetFormFromFile(0x00581B, "paradise_halls.esm") as Faction
				endif
				if (ScanActor[x].IsInFaction(PAHE_PlayerSlaveMeat) || ScanActor[x].IsInFaction(PAHE_SlaveMeat))
					IsSlave = 1
;					Debug.Trace("Check for Slaves - " + ScanActor[x].GetBaseObject().GetName() + " is a slave of Paradise Halls.")
;				else
;					Debug.Trace("Check for Slaves - " + ScanActor[x].GetBaseObject().GetName() + " is not a slave of Paradise Halls.")
				endif
			else
;				Debug.Trace("Check for Slaves - Claims Paradise Halls isn't installed")
			endif

  
			if (BB_PHH_Installed.GetValueInt() ==1) ; Need to check this every time, for HSH Slave Status (ineligible for hooking as well as propositions)
    
				if (PHH_HomeboySlave  == NONE)
					PHH_HomeboySlave = Game.GetFormFromFile(0x008972, "PAH_HomeSweetHome.esp") as Faction   
				endif

				if (ScanActor[x].IsInFaction(PHH_HomeboySlave))
					IsSlave = 1
					IsHSHSlave = 1
;					Debug.Trace("Check for Slaves - " + ScanActor[x].GetDisplayName() + " is a slave of Home Sweet Home.")
;				else
;					Debug.Trace("Check for Slaves - " + ScanActor[x].GetDisplayName() + " is not a slave of Home Sweet Home.")
				endif
			endif
  
			if (IsSlave != 1 && BB_DOM_Installed.GetValueInt() == 1)
    
				DOM_Slave = Game.GetFormFromFile(0x56C505, "DiaryOfMine.esm") as Faction   
				DOM_Slaver = Game.GetFormFromFile(0x1E368B, "DiaryOfMine.esm") as Faction   
				DOM_SlaveTraining = Game.GetFormFromFile(0x2523E7, "DiaryOfMine.esm") as Faction 	; Plus help address the DOM Display Name Bug (tm)

				if (ScanActor[x].IsInFaction(DOM_Slave) && !ScanActor[x].IsInFaction(DOM_Slaver) && ScanActor[x].GetFactionRank(DOM_Slave) != 2)
					IsSlave = 1
;					Debug.Trace("Check for Slaves - " + ScanActor[x].GetDisplayName() + " is a slave of Diary of Mine.")
				elseif (ScanActor[x].IsInFaction(DOM_Slaver))
					IsSlaver = 1
;					Debug.Trace("Check for Slaves - " + ScanActor[x].GetDisplayName() + " is a slaver of Diary of Mine.")
				elseif (ScanActor[x].GetFactionRank(DOM_Slave) == 2)
					IsSlaver = 2
;					Debug.Trace("Check for Slaves - " + ScanActor[x].GetDisplayName() + " is a slave trainer of Diary of Mine.")
;				else
;					Debug.Trace("Check for Slaves - " + ScanActor[x].GetDisplayName() + " is not a slave nor slaver of Diary of Mine.")
				endif
				if (ScanActor[x].IsInFaction(DOM_SlaveTraining))
					IsDOMSlaveTrainee = 1
;					Debug.Trace("Check for Slaves - " + ScanActor[x].GetDisplayName() + " is a slave trainee of Diary of Mine.")
				endif
			endif

			if(IsSlave != 1 && BB_MIA_Installed.GetValueInt() == 1)
    
				if (MIA_SlaveMeat == NONE)
					MIA_SlaveMeat = Game.GetFormFromFile(0x0085B5, "MiasLair.esp") as Faction   
					MIA_MaleMeat = Game.GetFormFromFile(0x027812, "MiasLair.esp") as Faction 
				endif

				if (ScanActor[x].IsInFaction(MIA_SlaveMeat) || ScanActor[x].IsInFaction(MIA_MaleMeat))
					IsSlave = 1
;					Debug.Trace("Check for Slaves - " + ScanActor[x].GetBaseObject().GetName() + " is a slave of Mia's Lair.")
;				else
;					Debug.Trace("Check for Slaves - " + ScanActor[x].GetBaseObject().GetName() + " is not a slave of Mia's Lair.")
				endif
			endif
  
			if (IsSlave != 1 && BB_ZAZ_Installed.GetValueInt() == 1)
    
				if (ZAZ_BondageSlave == NONE)
					ZAZ_BondageSlave = Game.GetFormFromFile(0x0096AE, "ZaZAnimationPack.esm") as Faction 
				endif
 
				if (ScanActor[x].IsInFaction(ZAZ_BondageSlave))
					IsSlave = 1
;					Debug.Trace("Check for Slaves - " + ScanActor[x].GetBaseObject().GetName() + " is a slave of Zaz Animation.")
;				else
;					Debug.Trace("Check for Slaves - " + ScanActor[x].GetBaseObject().GetName() + " is not a slave of Zaz Animation.")
				endif
			endif

			if (IsSlave == 1 && !ScanActor[x].IsInFaction(TDF_SlaveFaction))
;				Debug.Trace("Check for Slaves - " + ScanActor[x].GetBaseObject().GetName() + " is added to TDF Slave Faction.")
				ScanActor[x].AddToFaction(TDF_SlaveFaction)
			elseif (IsSlave == 0 && ScanActor[x].IsInFaction(TDF_SlaveFaction))
;				Debug.Trace("Check for Slaves - " + ScanActor[x].GetBaseObject().GetName() + " is removed from TDF Slave Faction.")
				ScanActor[x].RemoveFromFaction(TDF_SlaveFaction)
			endif

			if (IsDOMSlaveTrainee == 1 && !ScanActor[x].IsInFaction(TDF_DOMSlaveTraineeFaction))
;				Debug.Trace("Check for Slaves - " + ScanActor[x].GetBaseObject().GetName() + " is added to TDF DOM Slave Trainee Faction.")
				ScanActor[x].AddToFaction(TDF_DOMSlaveTraineeFaction)
			elseif (IsDOMSlaveTrainee == 0 && ScanActor[x].IsInFaction(TDF_DOMSlaveTraineeFaction))
;				Debug.Trace("Check for Slaves - " + ScanActor[x].GetBaseObject().GetName() + " is removed from TDF DOM Slave Trainee Faction.")
				ScanActor[x].RemoveFromFaction(TDF_DOMSlaveTraineeFaction)
			endif

			if (IsSlaver > 0 && !ScanActor[x].IsInFaction(TDF_SlaverFaction))
;				Debug.Trace("Check for Slaves - " + ScanActor[x].GetDisplayName() + " is added to TDF Slaver Faction.")
				ScanActor[x].AddToFaction(TDF_SlaverFaction)
				CheckIfSlaverIsHooker(ScanActor[x],IsSlaver)
			elseif (IsSlaver == 0 && ScanActor[x].IsInFaction(TDF_SlaverFaction))
;				Debug.Trace("Check for Slaves - " + ScanActor[x].GetDisplayName() + " is removed from TDF Slaver Faction.")
				ScanActor[x].RemoveFromFaction(TDF_SlaverFaction)
			endif

		endif


		if (ScanActor[x] != NONE && BB_DOM_Installed.GetValueInt() == 1)
			DOM_History = Game.GetFormFromFile(0x73413C, "DiaryOfMine.esm") as Faction 
			if (DOM_Slave == NONE) ; Read only if needed - shouldn't be
				DOM_Slave = Game.GetFormFromFile(0x56C505, "DiaryOfMine.esm") as Faction   
				DOM_Slaver = Game.GetFormFromFile(0x1E368B, "DiaryOfMine.esm") as Faction 
				DOM_SlaveTraining = Game.GetFormFromFile(0x2323E7, "DiaryOfMine.esm") as Faction
			endif

  
			if (ScanActor[x].IsInFaction(DOM_Slave) || ScanActor[x].IsInFaction(DOM_SlaveTraining) || ScanActor[x].IsInFaction(DOM_History)  || ScanActor[x].IsInFaction(DOM_Slaver))
;				Debug.Trace("Check for Slaves - Slave Actor: "  + ScanActor[x].GetBaseObject().GetName() + " has DOM origins. Checking Display Name.") 

				string sSlave = ScanActor[x].GetDisplayName()
				if (sSlave == "")
					RecallSlaveDisplayName(ScanActor[x])
				else
					StoreSlaveDisplayName(ScanActor[x])
				endif
			endif
		endif

		if (ScanActor[x] != NONE && isHSHSlave == 1 && ScanActor[x].IsInFaction(TDF_SlaverFaction) == 0)
;			Debug.Trace("Check for Slaves - " + aActor[x].GetDisplayName() + " is added to TDF HSH Slave Faction.")
			ScanActor[x].AddToFaction(TDF_HSHSlaveFaction)
		elseif (ScanActor[x] != NONE && isHSHSlave == 0 && ScanActor[x].IsInFaction(TDF_SlaverFaction) == 1)
;			Debug.Trace("Check for Slaves - " + aActor[x].GetDisplayName() + " is removed from TDF HSH Slave Faction.")
			ScanActor[x].RemoveFromFaction(TDF_HSHSlaveFaction)
		endif	

		if (((ScanActor[x] != NONE && BB_NWS_Installed.GetValue() as string) as int) == 1)
			CheckForNWSFollowers(ScanActor[x])
		endif

		x += 1

	endwhile

endFunction


;Event TDF_FireItUp()
Function TDFFireItUp()

 ;   Debug.Notification("TDF Scanner Initialization - Script Smack Pending!")

	if (((BB_ModsInitialized.GetValue() as string) as int) != 1)
		CheckForInstalledMods()
	endif
	if (((BB_PW_Installed.GetValue() as string) as int) == 1)
		PlayerCheckPublicWhore()
	endif
	if (((BB_SLS_Installed.GetValue() as string) as int) == 1 || ((BB_BM_Installed.GetValue() as string) as int) == 1)
		CheckSLSLicenseExpiry()
	endif
	if (((BB_PAH_Installed.GetValue() as string) as int) == 1 || ((BB_PHH_Installed.GetValue() as string) as int) == 1 || ((BB_DOM_Installed.GetValue() as string) as int) == 1)	
		CheckForSlaves()
	endif
	ClearTDFReferences()
	Utility.Wait(1)
	InitQuest.Reset()
	InitQuest.Stop()
	InitQuest.Start()

	RegisterForSingleUpdate(10.0)
endFunction



; DOM is doing this rampantly, for now -- it's why these functions even exist!


Function StoreSlaveDisplayName(actor aSlave)

	string fileName = "TDF Enhanced Prostitution/SlaveDisplayNames.json"
	int iCount = JsonUtil.GetIntValue(fileName, "DisplayNameCount")
	string sSlave = aSlave.GetDisplayName()
	int iSlave = aSlave.GetFormID()
	int x = 0
	int iFound = 0
;	Debug.Notification ("Storing a Slave Display Name. Name = " + sSlave + ".")
;	Debug.Trace ("TDF_StoreName - Storing a Slave Display Name. Name = " + sSlave + ".")

	while (x < iCount)
		int iStored = JsonUtil.GetIntValue(fileName, "Slave_"+ (x as string) + "_FormID")
		if (iSlave == iStored)
			string sStored = JsonUtil.GetStringValue(fileName, "Slave_"+ (x as string) + "_DisplayName")
			if (sStored == sSlave)
;				Debug.Notification ("Name already stored: " +sStored+ ". Aborting.")
;				Debug.Trace ("TDF_StoreName - Name already stored: " +sStored+ ". Aborting.")
				iFound = 1
				x = iCount
			elseif (sStored != "" && sSlave != "" && sStored != sSlave)
				JsonUtil.SetStringValue(fileName, "Slave_"+ (x as string) + "_DisplayName",sSlave)
;				Debug.Notification ("Actor found, name differs: "+sStored+ ". Changing.")
;				Debug.Trace ("TDF_StoreName - Actor found, name differs: "+sStored+ ". Changing.")
				iFound = 1
				x = iCount
			else	
				x += 1
			endif
		else
			x += 1
		endif
	endwhile

	if (iFound != 1)
		JsonUtil.SetIntValue(fileName, "Slave_"+ (iCount as string) + "_FormID", iSlave)
		JsonUtil.SetStringValue(fileName, "Slave_"+ (iCount as string) + "_DisplayName",sSlave)
		iCount += 1
		JsonUtil.SetIntValue(fileName, "DisplayNameCount", iCount)
;		Debug.Notification ("Actor not found. Adding new entry in Slot: " + iCount as string + ".")
;		Debug.Trace ("TDF_StoreName - Actor not found: " + sSlave + ". Adding new entry in Slot: " + iCount as string + ".")
	endif

endFunction

Function RecallSlaveDisplayName(actor aSlave)
	string fileName = "TDF Enhanced Prostitution/SlaveDisplayNames.json"
	int iCount = JsonUtil.GetIntValue(fileName, "DisplayNameCount")
	string sSlave = aSlave.GetDisplayName()
	int iSlave = aSlave.GetFormID()
;	Debug.Notification("Attempting RecallSlaveDisplayName. Actor Form ID: " + iSlave as string + ".")
;	Debug.Trace("TDF_RecallName - Attempting to Recall a name. Actor Form ID: " + iSlave as string + ".")

	int x = 0
	int iFound = 0

	if (sSlave == "")
		while (x < iCount)
			int iStored = JsonUtil.GetIntValue(fileName, "Slave_"+ (x as string) + "_FormID")
			if (iSlave == iStored)
				string sStored = JsonUtil.GetStringValue(fileName, "Slave_"+ (x as string) + "_DisplayName")
;				Debug.Notification("Found an entry! Name = " + sStored + ".")
;				Debug.Trace("TDF_RecallName - Found an entry! Name = " + sStored + ".")
				if (sStored != "")
					aSlave.SetDisplayName(sStored)
				else
;					Debug.Notification("Blank string entry in table. Last Resort, using Base Object name.")
					sSlave = aSlave.GetLeveledActorBase().GetName()
					Debug.Trace("TDF_RecallName - Blank string entry. Last Resort, using Base Object name: " + sSlave + ".")
					aSlave.SetDisplayName(sSlave)
				endif
				iFound = 1
				x = iCount
			else
				x += 1
			endif
		endWhile
		if (iFound != 1)
;			Debug.Notification("Form ID not found in table, blank display name. Last Resort, using Base Object name.")
;			Debug.Trace("TDF_RecallName - Form ID not found in JSON, blank display name. Last Resort, using Base Object name.")
			string sName = aSlave.GetLeveledActorBase().GetName()
			aSlave.SetDisplayName(sName)
			JsonUtil.SetIntValue(fileName, "Slave_"+ (iCount as string) + "_FormID", iSlave)
			JsonUtil.SetStringValue(fileName, "Slave_"+ (iCount as string) + "_DisplayName",sName)
			iCount += 1
			JsonUtil.SetIntValue(fileName, "DisplayNameCount", iCount)
		endif
	endif

endFunction
					
Event OnEffectStart(Actor akTarget, Actor akCaster)
    if(!InitQuest.IsRunning())
		InitQuest.Start()
	endif
	TDFFireItUp()
EndEvent

Event OnUpdate()
	if(!InitQuest.IsRunning())
		InitQuest.Start()
	endif
	TDFFireItUp()
EndEvent

GlobalVariable Property BB_SLS_Installed Auto
GlobalVariable Property BB_BM_Installed Auto
GlobalVariable Property BB_SLSF_Installed Auto
GlobalVariable Property BB_PAH_Installed Auto
GlobalVariable Property BB_PHH_Installed Auto
GlobalVariable Property BB_MIA_Installed Auto
GlobalVariable Property BB_ZAZ_Installed Auto
GlobalVariable Property BB_SLEN_Installed Auto
GlobalVariable Property BB_DOM_Installed  Auto  
GlobalVariable Property BB_PW_Installed  Auto  
GlobalVariable Property BB_NWS_Installed  Auto  
GlobalVariable Property BB_IsPublicWhore  Auto  
GlobalVariable Property BB_SLS_License_DaysPassed Auto
GlobalVariable Property BB_SLS_Whore_License_Expiry Auto
ReferenceAlias[] Property Hookers Auto
Quest[] Property PimpingQuests Auto


GlobalVariable Property HookersCut Auto
GlobalVariable[] Property GoldEarned Auto

ReferenceAlias Property pNearbyActor1 Auto
ReferenceAlias Property pNearbyActor2 Auto
ReferenceAlias Property pNearbyActor3 Auto
ReferenceAlias Property pNearbyActor4 Auto
ReferenceAlias Property pNearbyActor5 Auto
ReferenceAlias Property pNearbyActor6 Auto
ReferenceAlias Property pNearbyActor7 Auto
ReferenceAlias Property pNearbyActor8 Auto
ReferenceAlias Property pNearbyActor9 Auto
ReferenceAlias Property pNearbyActor10 Auto
ReferenceAlias Property pNearbyActor11 Auto
ReferenceAlias Property pNearbyActor12 Auto
ReferenceAlias Property pNearbyActor13 Auto
ReferenceAlias Property pNearbyActor14 Auto
ReferenceAlias Property pNearbyActor15 Auto
ReferenceAlias Property pNearbyActor16 Auto
Faction Property TDF_SlaveFaction Auto
Faction Property TDF_SlaverFaction Auto
Faction Property TDF_HSHSlaveFaction Auto
Faction Property TDF_DOMSlaveTraineeFaction Auto
Faction Property TDF_NWSFollowerFaction Auto

MiscObject Property Gold Auto
Actor[] Property ScanActor Auto
