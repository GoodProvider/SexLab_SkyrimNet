Scriptname aygasMenuScript extends SKI_ConfigBase  

AYGASInterface Property AYGASInter Auto

int proTrader
int proHandler
int proPimp
int proPatron
int proTrainer
int proHelpingHand
int proMadame
int proTaskmaster
int proSkillSlavery

int optDifficulty
int optEvents 
int optBuyback
int optMessages
int optLogging
int optBruma
int optReset
int optUninstall
int optGaySex
int optTeleport
int optSaleRate
int optSpawnRatio
int optTestEvent
int optUseWorldFurniture
int optSpawnFurniture
int optCheat
int optCheatCities

event OnConfigInit()
	Pages = new string[4]
	Pages[0] = "Slavery"
	Pages[1] = "Progress"
	Pages[2] = "Options"
	Pages[3] = "Your slaves"
endEvent

event OnPageReset(string page)
	if (page == "" )
		LoadCustomContent("aygas.dds", 176, 73)	

	elseif (page == "Slavery")
		UnloadCustomContent()
		SetCursorFillMode(TOP_TO_BOTTOM)
		SetCursorPosition(0)
		AddHeaderOption("Slavery in Towns")
		AddTextOption("Bruma", SlaveryLevelString(Aygas.EventFunctions.EvaluateSlaveryLevel(Aygas.EventFunctions.BrumaLocation)))
		AddTextOption("Dawnstar", SlaveryLevelString(Aygas.EventFunctions.EvaluateSlaveryLevel(Aygas.EventFunctions.DawnstarLocation)))
		AddTextOption("Markath", SlaveryLevelString(Aygas.EventFunctions.EvaluateSlaveryLevel(Aygas.EventFunctions.MarkarthLocation)))
		AddTextOption("Morthal", SlaveryLevelString(Aygas.EventFunctions.EvaluateSlaveryLevel(Aygas.EventFunctions.MorthalLocation)))
		AddTextOption("Riften", SlaveryLevelString(Aygas.EventFunctions.EvaluateSlaveryLevel(Aygas.EventFunctions.RiftenLocation)))
		AddTextOption("Solitude", SlaveryLevelString(Aygas.EventFunctions.EvaluateSlaveryLevel(Aygas.EventFunctions.SolitudeLocation)))
		AddTextOption("Whiterun", SlaveryLevelString(Aygas.EventFunctions.EvaluateSlaveryLevel(Aygas.EventFunctions.WhiterunLocation)))
		AddTextOption("Windhelm", SlaveryLevelString(Aygas.EventFunctions.EvaluateSlaveryLevel(Aygas.EventFunctions.WindhelmLocation)))
		AddTextOption("Winterhold", SlaveryLevelString(Aygas.EventFunctions.EvaluateSlaveryLevel(Aygas.EventFunctions.WinterholdLocation)))
		AddTextOption("Falkreath", SlaveryLevelString(Aygas.EventFunctions.EvaluateSlaveryLevel(Aygas.EventFunctions.FalkreathLocation)))
		AddEmptyOption()

		AddTextOption("Helgen", SlaveryLevelString(Aygas.EventFunctions.EvaluateSlaveryLevel(Aygas.EventFunctions.HelgenLocation)))
		AddTextOption("Ivarstead", SlaveryLevelString(Aygas.EventFunctions.EvaluateSlaveryLevel(Aygas.EventFunctions.IvarsteadLocation)))
		AddTextOption("Riverwood", SlaveryLevelString(Aygas.EventFunctions.EvaluateSlaveryLevel(Aygas.EventFunctions.RiverwoodLocation)))
		AddTextOption("Rorikstead", SlaveryLevelString(Aygas.EventFunctions.EvaluateSlaveryLevel(Aygas.EventFunctions.RoriksteadLocation)))

		SetCursorPosition(1)
		AddHeaderOption("Your location")
		Location loc = Game.GetPlayer().GetCurrentLocation()
		int lvl
		string locName
		if (loc != None)
			locName = loc.GetName()
			if (locName == "")
				locName = "Unknown"
			endif
			Aygas.EventFunctions.EvaluateSlaveryLevel(loc)
			lvl = Aygas.EventFunctions.SlaveryLevelAtLocation
		else
			locName = "Unknown"
			lvl = -1
		endif
		AddTextOption(locName, SlaveryLevelString(lvl))
		AddEmptyOption()
		AddHeaderOption("Totals")

		int count = 0
		int i = StorageUtil.FormListCount(none, "aygasOwners")
		while(i > 0)
			i-=1
			Actor a = StorageUtil.FormListGet(none, "aygasOwners", i) as Actor
			count += StorageUtil.FormListCount(a, "aygasSlaves")
		endwhile

		AddTextOption("Nr. of Slaves", count)
		AddTextOption("Nr. of Owners", StorageUtil.FormListCount(none, "aygasOwners"))

	elseif (page == "Progress")
		UnloadCustomContent()
		SetCursorFillMode(TOP_TO_BOTTOM)
		SetCursorPosition(0)
		AddHeaderOption("Achievements")
		proTrader = AddToggleOption("Slave Trader", aygas.proTrader || aygas.SCheat)
		proHandler = AddToggleOption("Handler", aygas.proHandler  || aygas.SCheat)
		proPimp = AddToggleOption("Pimp", aygas.proPimp  || aygas.SCheat)
		proPatron = AddToggleOption("Patron", aygas.proPatron  || aygas.SCheat)
		proTrainer = AddToggleOption("Trainer", aygas.proTrainer  || aygas.SCheat)
		proHelpingHand = AddToggleOption("Helping Hand", aygas.proHelpingHand  || aygas.SCheat)
		if Game.GetPlayer().GetActorBase().GetSex() == 0
			proMadame = AddToggleOption("Monsieur", aygas.proMadame  || aygas.SCheat)
		else
			proMadame = AddToggleOption("Madame", aygas.proMadame  || aygas.SCheat)
		endif
		proTaskmaster = AddToggleOption("Taskmaster", aygas.proTaskmaster  || aygas.SCheat)

		SetCursorPosition(1)
		AddHeaderOption("Skill")
		proSkillSlavery = AddTextOption("Slavery", Aygas.proLevelSlavery)

	elseif (page == "Options")
		Aygas.GetSoftRequirements()
		UnloadCustomContent()
		SetCursorFillMode(TOP_TO_BOTTOM)
		SetCursorPosition(0)
		AddTextOption("Version", Aygas.Version())
		AddEmptyOption()

		AddHeaderOption("Gameplay")
		optDifficulty = AddMenuOption("Difficulty", DifficultyString(Aygas.SDifficulty))
		optEvents  = AddToggleOption("Events in towns", aygas.SDoEvents)
		optBuyback = AddToggleOption("Can buy back slaves", Aygas.SBuyBack)
		optUseWorldFurniture = AddToggleOption("Use world torture devices", Aygas.SUseWorldFurniture)
		optSpawnFurniture = AddToggleOption("   Spawn torture device if none can be found", Aygas.SSpawnFurniture)
		optGaySex = AddMenuOption("Gay/lesbian sex", GaySexString(Aygas.SGaySex))
		optSpawnRatio = AddMenuOption("Sex of new slaves", SpawnRatioString(Aygas.SSlaveSpawnRatio))
		optSaleRate = AddSliderOption("Slave sale rate", Aygas.SSaleRate, "{0}")
		optCheat  = AddToggleOption("Cheat mode", aygas.SCheat)
		optCheatCities  = AddToggleOption("All towns at max slavery", aygas.SCheatCities)
		AddEmptyOption()

		AddHeaderOption("Diagnostics")
		optMessages = AddToggleOption("Debug messages", Aygas.SDebugMessage)
		optLogging = AddToggleOption("Debug logging", Aygas.SDebugLog )
		optReset = AddTextOption("[ Click to restart mod ]", "")
		optUninstall = AddTextOption("[ Click to uninstall mod ]", "")
		AddTextOption("Slaves in the storage pool",  Aygas.StorageFunctions.Cellmarker.GetParentCell().GetNumRefs(43))
		optTestEvent = AddMenuOption("Start event", "[Select to start]")

		SetCursorPosition(1)
		AddHeaderOption("Detected Mods")
		AddTextOption("SexLab", "OK")
		AddTextOption("Paradise Halls",  DependencyString((AygasInter.PAH != None) , false))
		AddTextOption("Home Sweet Home", DependencyString((Aygas.HasHSH) , true))
		AddTextOption("ZaZ 8.0+", DependencyString(Aygas.HasZaz8 , false))
		AddTextOption("Interactive BDSM", DependencyString(Aygas.HasTortureFramework , true))
		AddTextOption("Diary of Mine (DOM)", DependencyString((AYGASInter.DOM != None) , true))
		optBruma = AddTextOption("Beyond Skyrim - Bruma", DependencyString((Aygas.CyrMerchantFaction != None) , true))
	elseif (page == "Your slaves")
		UnloadCustomContent()
		SetCursorFillMode(LEFT_TO_RIGHT)
		SetCursorPosition(0)
		AddHeaderOption("Your working slaves")
		AddEmptyOption()

		int i = StorageUtil.FormListCount(Game.GetPlayer(), "aygasSlaves")
		if (i > 0)
			while(i > 0)
				i-=1
				Actor slave = StorageUtil.FormListGet(Game.GetPlayer(), "aygasSlaves", i) as Actor
				if (slave != None)
					AddTextOption(slave.GetDisplayname(), slave.GetCurrentLocation().GetName())
					int slaveType = slave.GetFactionRank(Aygas.SlaveTypeFaction)
					string job = "Jobless"
					string jobAction = "Idle"
					if ((slavetype == 1) || (slavetype == 2))
						job = "Prostitute"
						if (slave.GetFactionRank(Aygas.JobOverrideAction) != 3)
							jobAction = "Turning tricks"
						else
							jobAction = "Tied at the roadside"
						endif
					elseif (slavetype == 13)
						job = "Courtesan"
						jobAction = "Entertaining"
					elseif (slavetype == 14)
						job = "Bought at auction"
						jobAction = "Waiting"
					endif
					AddTextOption(job + " (" + JobExperienceString(slave) + ")", jobAction)
				else
					Form s = StorageUtil.FormListGet(Game.GetPlayer(), "aygasSlaves", i)
					if (s != None)
						AddTextOption("[Slave unloaded]", "")
					else
						AddTextOption("[Slave in unloaded area]", "")
					endif
					AddTextOption("", "")
				endif
			endwhile
		endif

		optTeleport = AddTextOption("(Click to teleport missing slaves to you)", "")

	endif
endEvent

event OnOptionHighlight(int option)
	if (option == proTrader)
		SetInfoText("You have built some reputation as a slave trader. Slave owners will offer to sell you their slaves.\nRequires 10 Slavery")
	elseif (option == proHandler)
		SetInfoText("You have some skill at handling slaves, enough to safely let others have their way with them. For coin, of course. In towns where slavery is accepted or in the wilderness, you can offer your slaves for such sport.\nRequires 20 Slavery; must have sold at least 2 slaves as prostitutes (" + CompletionString(aygas.proProstitutesSold, 2) +  ")")
	elseif (option == proPatron)
		SetInfoText("You are known to attend slave Pit Fights. The pit masters trust you enough to let you enter your own slaves in the competition\nRequires 30 slavery. Must have attended 2 pit fights (" + CompletionString(aygas.proFightAttended, 2) +  ")")
	elseif (option == proPimp)
		SetInfoText("You know how to keep your slaves in line while they work. You can have them turning tricks unsupervised, in the streets or at an inn if you pay the owner for the privilege.\nRequires 40 slavery. Your slaves must have turned at least 15 tricks (" + CompletionString(Aygas.proProstituteTricks, 15) + ")")
	elseif (option == proTrainer)
		SetInfoText("Your slaves are doing well in the pits, thanks to your training. Auction Masters are interested to buy your stock.\nRequires 40 Slavery. Must have won 3 pit fights (" + CompletionString(aygas.proFightWon, 3) +  ")")
	elseif (option == proHelpingHand)
		string s1
		string s2
		string s3
		if (Aygas.proSoldSexSlave > 0)
			s1 = " (done)"
		endif
		if (Aygas.proSoldShopAssistant > 0)
			s2 = " (done)"
		endif
		if (Aygas.proSoldWorker > 0)
			s3 = " (done)"
		endif
		SetInfoText("You know how to train slaves for a certain task, and sell them to the right person. Why not rent out these valuable chattel instead of selling them?\nRequires 50 Slavery. Must have sold a sexual companion" + s1 + ", a shop assistant" + s2 + ", and a worker" + s3)
	elseif (option == proMadame)
		SetInfoText("Your pleasure slaves have gained you a reputation for quality. Perhaps you'll want to open your own brothel in one of your properties.\nRequires 60 Slavery. Must have 5 pleasure slaves working for you (" + Aygas.PlayerWhores() + "/5)")
	elseif (option == proTaskmaster )
		SetInfoText("You can have your slaves work for you at a variety of tasks, such as gathering resources\nRequires 70 slavery. Must have the Helping Hand and Madame perks.")
	elseif (option == proSkillSlavery)
		SetInfoText("Your skill at the slave trade. Increases when you buy or sell slaves.")
	elseif (option == optUseWorldFurniture)
		SetInfoText("Use existing torture equipment around town to punish slaves, instead of spawning the equipment.  Requires Home Sweet Home (and some pre placed torture devices)")
	elseif (option == optSpawnFurniture)
		SetInfoText("If no torture devices can be found to punish a slave, spawn a random temporary one")
	elseif (option == optDifficulty)
		SetInfoText("Determines how fast you will gain Slavery skill, and how quickly towns will become accustomed to slavery")
	elseif (option == optEvents)
		SetInfoText("Enable to have towns run auctions and pit fights when slavery becomes accepted there")
	elseif (option == optBuyback)
		SetInfoText("With this option enabled, slave owners will offer to sell their slaves to you (when you have the prerequisite reputation)")
	elseif (option == optBruma)
		SetInfoText("With Beyond Skyrim - Bruma installed, the town of Bruma can become a hub for slave trade like the towns in Skyrim")
	elseif (option == optMessages)
		SetInfoText("Display on-screen diagnostic information")
	elseif (option == optLogging)
		SetInfoText("Record diagnostic data in the Papyrus log")
	elseif (option == optSpawnRatio)
		SetInfoText("Determines if newly spawned slaves will be mostly men or women")
	elseif (option == optSaleRate)
		SetInfoText("Sets the rate at which slave owners buy and sell their slaves. This rate is compounded with their satisfaction with each slave")
	elseif (option == optGaySex)
		SetInfoText("Determines how common gay / lesbian sex is")
	elseif (option == optUninstall)
		SetInfoText("Do this before uninstalling this mod")
	elseif (option == optCheat)
		SetInfoText("Select this to obtain all perks.  If you turn this off later, you will retain only those perks you have earned")
	elseif (option == optCheatCities)
		SetInfoText("Select this to set all towns and cities at the maximum slavery level")
	endif
EndEvent

event OnOptionMenuOpen(int option)
	if (option == optDifficulty)
		string[] DifficultyList
		DifficultyList= new string[3]
		DifficultyList[0] = DifficultyString(0)
		DifficultyList[1] = DifficultyString(1)
		DifficultyList[2] = DifficultyString(2)
		SetMenuDialogOptions(DifficultyList)
		SetMenuDialogStartIndex(Aygas.SDifficulty)
		SetMenuDialogDefaultIndex(1)
	elseif (option == optGaySex)
		string[] SexList
		SexList= new string[3]
		SexList[0] = GaySexString(0)
		SexList[1] = GaySexString(1)
		SexList[2] = GaySexString(2)
		SetMenuDialogOptions(SexList)
		SetMenuDialogStartIndex(Aygas.SGaySex)
		SetMenuDialogDefaultIndex(1)
	elseif (option == optSpawnRatio)
		string[] Ratio
		Ratio= new string[5]
		Ratio[0] = SpawnRatioString(-2)
		Ratio[1] = SpawnRatioString(-1)
		Ratio[2] = SpawnRatioString(0)
		Ratio[3] = SpawnRatioString(1)
		Ratio[4] = SpawnRatioString(2)
		SetMenuDialogOptions(Ratio)
		SetMenuDialogStartIndex(Aygas.SSlaveSpawnRatio + 2)
		SetMenuDialogDefaultIndex(2)
	elseif (option == optTestEvent)
		SetMenuDialogOptions(Locations())
		SetMenuDialogStartIndex(0)
		SetMenuDialogDefaultIndex(0)
	endif
EndEvent

event OnOptionMenuAccept(int option, int index)
	if (option == optDifficulty)
		Aygas.SDifficulty = index
		SetMenuOptionValue(option, DifficultyString(index))
		Aygas.EventFunctions.AdjustCities()
	elseif (option == optGaySex)
		Aygas.SGaySex = index
		SetMenuOptionValue(option, GaySexString(index))
	elseif (option == optSpawnRatio)
		Aygas.SSlaveSpawnRatio = index - 2
		SetMenuOptionValue(option, SpawnRatioString(Aygas.SSlaveSpawnRatio))
	elseif (option == optTestEvent)
		SetMenuOptionValue(option, "--> Close menu to continue")
		Location l
		if (index == 1)
			l = Aygas.EventFunctions.DawnstarLocation				
		elseif (index == 2)
			l = Aygas.EventFunctions.MarkarthLocation
		elseif (index == 3)
			l = Aygas.EventFunctions.RiftenLocation
		elseif (index == 4)
			l = Aygas.EventFunctions.SolitudeLocation
		elseif (index == 5)
			l = Aygas.EventFunctions.WinterholdLocation
		elseif (index == 6)
			l = Aygas.EventFunctions.WindhelmLocation
		elseif (index == 7)
			l = Aygas.EventFunctions.WhiterunLocation
		elseif (index == 8)
			l = Aygas.EventFunctions.FalkreathLocation
		elseif (index == 9)
			l = Aygas.EventFunctions.RiverwoodLocation
		elseif (index == 10)
			l = Aygas.EventFunctions.RoriksteadLocation
		elseif (index == 11)
			l = Aygas.EventFunctions.MorthalLocation
		elseif (index == 12)
			l = Aygas.EventFunctions.IvarsteadLocation
		elseif (index == 13)
			l = Aygas.EventFunctions.HelgenLocation
		elseif (index == 14)
			l = Aygas.EventFunctions.BrumaLocation
		endif
		Aygas.EventFunctions.ForceEvent(l)
	endif
EndEvent

event OnOptionSelect(int option)
	bool val
	if (option == optEvents)
		Aygas.SDoEvents = !Aygas.SDoEvents
		val = Aygas.SDoEvents
	elseif (option == optBuyback)
		Aygas.SBuyback = !Aygas.SBuyback
		val = Aygas.SBuyback
	elseif (option == optCheat)
		Aygas.SCheat = !Aygas.SCheat
		val = Aygas.SCheat
	elseif (option == optCheatCities)
		Aygas.SCheatCities = !Aygas.SCheatCities
		val = Aygas.SCheatCities
	elseif (option == optMessages)
		Aygas.SDebugMessage = !Aygas.SDebugMessage
		val = Aygas.SDebugMessage
	elseif (option == optUseWorldFurniture)
		if (Aygas.HasHSH)
			Aygas.SUseWorldFUrniture = !Aygas.SUseWorldFUrniture
		endif
		val = Aygas.SUseWorldFUrniture
		if (!val)
			SetToggleOptionValue(optSpawnFurniture, true)
		endif
	elseif (option == optSpawnFurniture)
		if (Aygas.SUseWorldFUrniture )
			Aygas.SSpawnFurniture = !Aygas.SSpawnFUrniture
			val = Aygas.SSpawnFUrniture
		else
			val = true
		endif
	elseif (option == optLogging)
		Aygas.SDebugLog = !Aygas.SDebugLog
		val = Aygas.SDebugLog
	elseif (option == optReset)
		Aygas.Init()
		OnConfigInit()
	elseif (option == optUninstall)
		Aygas.Uninstall()
	elseif (option == optTeleport)
		int i = StorageUtil.FormListCount(Game.GetPlayer(), "aygasSlaves")
		if (i > 0)
			while(i > 0)
				i-=1
				Actor slave = StorageUtil.FormListGet(Game.GetPlayer(), "aygasSlaves", i) as Actor
				if ((slave.GetCurrentLocation() == None) || (slave.GetCurrentLocation().GetName() == ""))
					Debug.Notification("Teleported " + slave.GetDisplayName())
					slave.MoveTo(Game.GetPlayer())
				endif
			endwhile
		endif
	endif
	SetToggleOptionValue(option, val)
EndEvent

Event OnOptionSliderOpen(int option)
	if (option == optSaleRate)
		SetSliderDialogStartValue(Aygas.SSaleRate)
		SetSliderDialogDefaultValue(0.0)
		SetSliderDialogRange(0.0, 50.0)
		SetSliderDialogInterval(1.0)
	endif
EndEvent

Event OnOptionSliderAccept(int option, float value)
	if (option == optSaleRate)
		Aygas.SSalerate = Math.Floor(value)
		SetSliderOptionValue(optSaleRate, Aygas.SSaleRate, "{0}")
	endif
EndEvent

string Function SlaveryLevelString(int level)
	if (level == 1)
		return "1: Underground"
	elseif (level == 2)
		return "2: Some"
	elseif (level == 3)
		return "3: Common"
	elseif (level == 4)
		return "4: Active"
	elseif (level == 5)
		return "5: Accepted"
	elseif (level == 0)
		return "0: None"
	endif
	return "Who knows?"
EndFunction

string Function DifficultyString (int level)
	if (level == 1)
		return "Normal"
	elseif (level == 2)
		return "Hard"
	endif
	return "Easy"
EndFunction


string Function GaySexString (int level)
	if (level == 1)
		return "Some"
	elseif (level == 2)
		return "Plenty"
	endif
	return "No"
EndFunction

string Function SpawnRatioString (int ratio)
	if (ratio== 0)
		return "Equal"
	elseif (ratio== 1)
		return "Mostly men"
	elseif (ratio== 2)
		return "Only men"
	elseif (ratio== -1)
		return "Mostly women"
	elseif (ratio== -2)
		return "Only women"
	endif
	return "Undefined"
EndFunction

string Function DependencyString(bool present, bool optional)
	if (present)
		return "OK"
	elseif (optional)
		return "---"
	else
		return "Missing"
	endif
EndFunction

string Function CompletionString(int level, int max)
	if (level > max)
		level = max
	endif
	return level + "/" + max
EndFunction

string Function JobExperienceString(actor slave)
	int lvl = slave.GetFactionRank(Aygas.JobExperience)
	if (lvl < 10)
		return "unskilled"
	elseif (lvl < 25)
		return "beginner"
	elseif (lvl < 40)
		return "apprentice"
	elseif (lvl < 60)
		return "experienced"
	elseif (lvl < 80)
		return "adept"
	else
		return "expert"
	endif
EndFunction

string[] Function Locations()
	string[] s = new string[15]
	s[0]="[Select to start event]"
	s[1]="Dawnstar"
	s[2]="Markarth"
	s[3]="Riften"
	s[4]="Solitude"
	s[5]="Winterhold"
	s[6]="Windhelm"
	s[7]="Whiterun"
	s[8]="Falkreath"
	s[9]="Riverwood"
	s[10]="Rorikstead"
	s[11]="Morthal"
	s[12]="Ivarstead"
	s[13]="Helgen"

	if (Aygas.EventFunctions.BrumaLocation != None)
		s[14]="Bruma"
	endif
	return s
EndFunction


AygasCoreScript Property Aygas Auto