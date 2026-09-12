

Scriptname BB_TDFUtils Extends TopicInfo Hidden


bool Function CheckSlave(Actor aSlave) Global

  if(Game.GetFormFromFile(0x01FAEF, "paradise_halls.esm") != NONE)    
    faction PAHE_PlayerSlaveMeat = Game.GetFormFromFile(0x0047DB, "paradise_halls.esm") as Faction   
    faction PAHE_SlaveMeat = Game.GetFormFromFile(0x00581B, "paradise_halls.esm") as Faction   
	int SlaveMeat = aSlave.GetFactionRank(PAHE_PlayerSlaveMeat)
	int PlayerSlaveMeat = aSlave.GetFactionRank(PAHE_SlaveMeat)
    if (aSlave.IsInFaction(PAHE_PlayerSlaveMeat) || aSlave.IsInFaction(PAHE_SlaveMeat))
	  return 1
	endif
  endif
  
  if (Game.GetFormFromFile(0x003900, "PAH_HomeSweetHome.esp") != NONE)
    
    faction PHH_HomeboySlave = Game.GetFormFromFile(0x008972, "PAH_HomeSweetHome.esp") as Faction   

    if (aSlave.IsInFaction(PHH_HomeboySlave))
	  return 1
	endif
  endif
  
  if (Game.GetFormFromFile(0x000D61, "DiaryOfMine.esm") != NONE)
    
    faction DOM_Slave = Game.GetFormFromFile(0x56C505, "DiaryOfMine.esm") as Faction   
     faction DOM_Slaver = Game.GetFormFromFile(0x1E368B, "DiaryOfMine.esm") as Faction   

    if (aSlave.IsInFaction(DOM_Slave)||aSlave.IsInFaction(DOM_Slaver))
	  return 1
	endif
  endif

  if(Game.GetFormFromFile(0x002DED, "MiasLair.esp") != NONE)
    
    faction MIA_SlaveMeat = Game.GetFormFromFile(0x0085B5, "MiasLair.esp") as Faction   
    faction MIA_MaleMeat = Game.GetFormFromFile(0x027812, "MiasLair.esp") as Faction   

    if (aSlave.IsInFaction(MIA_SlaveMeat) || aSlave.IsInFaction(MIA_MaleMeat))
	  return 1
	endif
  endif
  
  if (Game.GetFormFromFile(0x0137E6, "ZaZAnimationPack.esm") != NONE)
    
    faction ZAZ_BondageSlave = Game.GetFormFromFile(0x0096AE, "ZaZAnimationPack.esm") as Faction   
 
    if (aSlave.IsInFaction(ZAZ_BondageSlave))
	  return 1
	endif
  endif

  return 0

EndFunction


Float Function CheckSLSLicenseExpiry() Global


; Set SLS/BM Whore license Expiry time, if installed
	quest fucko = Game.GetFormFromFile(0x000813, "Licenses.esp") as Quest
	int bBM = (fucko as BM_Licenses_mcm).isWhoreLicenseFeatureEnabled as int
	float iq
    if (Game.GetFormFromFile(0x000868, "Licenses.esp") != NONE && bBM == 1)
		fucko = Game.GetFormFromFile(0x000D62, "Licenses.esp") as Quest

		if (fucko as BM_Licenses).hasWhoreLicense == true
			iq = (fucko as BM_Licenses).whoreLicenseExpirationTime
		else
			iq = -1
		endif
		return iq
	elseif (Game.GetFormFromFile(0x000D64, "SL Survival.esp") != NONE)
		iq = (Game.GetFormFromFile(0x0D09E8, "SL Survival.esp") as GlobalVariable).GetValue() as float
		return iq
	else
		return 0
    endif
EndFunction


bool Function IsPublicWhore() Global

    if (Game.GetFormFromFile(0x000D63, "Public Whore.esp") == NONE)
	     return 0
	endif
	
	quest PW1 = Game.GetFormFromFile(0x043705, "Public Whore.esp") as Quest
	quest PW2 = Game.GetFormFromFile(0x0467FB, "Public Whore.esp") as Quest
	quest PW3 = Game.GetFormFromFile(0x0467FC, "Public Whore.esp") as Quest
	quest PW4 = Game.GetFormFromFile(0x0467FD, "Public Whore.esp") as Quest
	quest PW5 = Game.GetFormFromFile(0x0467FE, "Public Whore.esp") as Quest
	quest PW6 = Game.GetFormFromFile(0x0467FF, "Public Whore.esp") as Quest
	quest PW7 = Game.GetFormFromFile(0x046800, "Public Whore.esp") as Quest
	quest PW8 = Game.GetFormFromFile(0x046801, "Public Whore.esp") as Quest
	quest PW9 = Game.GetFormFromFile(0x046802, "Public Whore.esp") as Quest

    if (PW1.isActive() || PW2.isActive() || PW3.isActive() || PW4.isActive() || PW5.isActive() || PW6.isActive() || PW7.isActive() || PW8.isActive() || PW9.isActive())
        return 1
	endif

	return 0
EndFunction
