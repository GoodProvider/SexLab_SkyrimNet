Scriptname aygasSellScript extends Quest  Conditional

AYGASInterface Property AYGASInter Auto

Function Clear()
	aygas.ClearSellSlots()
EndFunction

Function EvaluateSlaveSlot(int idx)
	int n = Aygas.SellSlots.length
	if idx < 0 || idx >= n
		Debug.Trace("AygasSellScript OfferSlave wrong idx="+idx+" / "+n)
		return
	endif
	ReferenceAlias ref = Aygas.SellSlots[idx]
	if ref == None
		Debug.Trace("AygasSellScript OfferSlave NONE ref idx="+idx+" / "+n)
		return
	endif
	Actor akTarget = ref.GetActorRef()
	if akTarget == None
		Debug.Trace("AygasSellScript OfferSlave NONE target idx="+idx+" / "+n)
		return
	endif
	EvaluateSlave(akTarget)
EndFunction

Function EnterFightSlave(int idx)
	int n = Aygas.SellSlots.length
	if idx < 0 || idx >= n
		Debug.Trace("AygasSellScript EnterFightSlave wrong idx="+idx+" / "+n)
		return
	endif
	ReferenceAlias ref = Aygas.SellSlots[idx]
	if ref == None
		Debug.Trace("AygasSellScript EnterFightSlave NONE ref idx="+idx+" / "+n)
		return
	endif
	Actor akTarget = ref.GetActorRef()
	if akTarget == None
		Debug.Trace("AygasSellScript EnterFightSlave NONE target idx="+idx+" / "+n)
		return
	endif
	Aygas.EventFunctions.FightPlayerSlave(akTarget)
EndFunction

Function AuctionSlave(int idx)
	int n = Aygas.SellSlots.length
	if idx < 0 || idx >= n
		Debug.Trace("AygasSellScript AuctionSlave wrong idx="+idx+" / "+n)
		return
	endif
	ReferenceAlias ref = Aygas.SellSlots[idx]
	if ref == None
		Debug.Trace("AygasSellScript AuctionSlave NONE ref idx="+idx+" / "+n)
		return
	endif
	Actor akTarget = ref.GetActorRef()
	if akTarget == None
		Debug.Trace("AygasSellScript AuctionSlave NONE target idx="+idx+" / "+n)
		return
	endif
	Aygas.EventFunctions.AuctionPlayerSlave(akTarget)
EndFunction

Function OfferSlave(Actor akSpeaker, int idx)
	int n = Aygas.SellSlots.length
	if idx < 0 || idx >= n
		Debug.Trace("AygasSellScript OfferSlave wrong idx="+idx+" / "+n)
		return
	endif
	ReferenceAlias ref = Aygas.SellSlots[idx]
	if ref == None
		Debug.Trace("AygasSellScript OfferSlave NONE ref idx="+idx+" / "+n)
		return
	endif
	Actor akTarget = ref.GetActorRef()
	if akTarget == None
		Debug.Trace("AygasSellScript OfferSlave NONE target idx="+idx+" / "+n)
		return
	endif
	ConsiderSlave(akTarget, akSpeaker)
EndFunction

Function ConsiderSlave(Actor slave, Actor buyer)
	SlaveOnOffer = slave
	Aygas.GetSoftRequirements()
	IsFemale = (Aygas.SexLab.GetGender(slave) == 1)

	float sexTraining = AYGASInter.GetSexTraining(slave)
	float slaveTraining = AYGASInter.GetSubmissionTraining(slave)
		slaveTraining += AYGASInter.GetHumiliationTraining(slave)
		slaveTraining += AYGASInter.GetResignationTraining(slave)
		slaveTraining = slaveTraining/3.0

	bool IsSexTrained = (sexTraining >= 50.0)
	bool IsObedient = (slaveTraining >= 50.0)

	bool BuyerIsCaravanMerchant = buyer.IsInFaction(Aygas.CaravanFaction)
	bool BuyerIsMerchant = buyer.IsInFaction(Aygas.MerchantFaction)
	if ((Aygas.CyrMerchantFaction != None) && (buyer.IsInFaction(Aygas.CyrMerchantFaction )))
		BuyerIsMerchant = true
	endif
	bool BuyerIsInnkeeper = buyer.IsInFaction(Aygas.InnkeeperFaction)
	if ((Aygas.CyrInnkeeperFaction != None) && (buyer.IsInFaction(Aygas.CyrInnkeeperFaction)))
		BuyerIsInnkeeper = true
	endif
	bool BuyerIsFemale = (Aygas.SexLab.GetGender(buyer) == 1)
	bool BuyerIsMiner =  buyer.IsInFaction(Aygas.MinerFaction)
	bool BuyerIsLumberjack = buyer.IsInFaction(Aygas.LumberjackFaction)
	bool BuyerIsFarmer = buyer.IsInFaction(Aygas.FarmerFaction)
	
	Aygas.DebugMessage("OB:" + isobedient + "  ST:" + issextrained + "," + sexTraining + "  Inn:" + BuyerIsInnkeeper)
	Aygas.DebugMessage("Female:" + BuyerIsFemale + "  Miner:" + BuyerIsMiner + " Farmer:" + BuyerIsFarmer)


	int basePrice = AYGASInter.getSlavePrice(slave)

	baseType = 0
	; Find most expensive option buyer might want
	; 1 = prostitute
	; 2 = prostitute for sale / bound
	; 3 = shop slave
	; 4 = work slave for sale
	; 5 = generic work slave
	; 6 = Sex Slave
	; 7 = Personal slave for sale
	; 8 = Personal slave
	; 9 = Serving slave (Inns)
	; 10 = Farm slave
	; 11 = Fighting pit slave
	; 12 = Necromancer victim
	; 13 = Prostitute in player brothel
	; 14 = Slave sold at auction (waiting for pickup)

	; Check for prostitute (work or sale)
	if ((IsSexTrained) && (IsObedient) && (!BuyerIsMiner) && (!BuyerIsLumberjack) && (!BuyerIsFarmer))
		if (BuyerIsInnkeeper)
			baseType = 1
			basePrice += 2500
		elseif (BuyerIsCaravanMerchant)
			baseType = 2
			basePrice += 2000
		endif
	endif

	; Check for shop slave
	if ((baseType==0) && (isObedient) && (BuyerIsMerchant) &&  (!BuyerIsInnKeeper))
		baseType = 3
		basePrice += 1500
	endif

	; Check for work slave (work or sale)
	if ((baseType==0) && (isObedient))
		if (BuyerIsCaravanMerchant)
			baseType = 4
			basePrice += 1200
		elseif ((BuyerIsMiner) || (BuyerIsLumberjack) )
			baseType = 5
			basePrice += 1200
		elseif  (BuyerIsFarmer)
			baseType = 10
			basePrice += 1200
		elseif (BuyerIsInnkeeper)
			baseType = 9
			basePrice += 1400		
		endif
	endif

	; Check for sex slave
	if ((baseType == 0) && (IsSexTrained) && (Aygas.GenderCheck(slave, buyer)))
		baseType = 6
		basePrice += 1900
	endif

	; Check for personal slave
	if (baseType == 0)
		if (BuyerIsCaravanMerchant)
			baseType = 7
			basePrice += 700
		elseif ((!BuyerIsMerchant) && (!BuyerIsFarmer) && (!BuyerIsLumberjack) && (!BuyerIsMiner) && (!BuyerIsInnKeeper))
			if (slaveTraining >= 60)
				baseType = 5
				basePrice += 1200	
			else
				baseType = 8
				basePrice += 1000
			endif
		endif
	endif

	basePrice = FindMaximumPriceForBuyer(buyer,basePrice)
	Aygas.DebugMessage("Type: " + baseType)
	int variance = basePrice / 5
	int finalPrice = basePrice + Utility.RandomInt(-variance, variance)
	SlavePrice = finalPrice
;	aygasPriceProperty.SetValueInt(finalPrice)
;	UpdateCurrentInstanceGlobal(aygasPriceProperty)
EndFunction

Function BuyBackSlave(Actor Seller)
	Actor slave = aygas.SelectedSlot.GetActorRef()
	if (slave == None)
		return
	endif

	int sat = StorageUtil.GetIntValue(slave, "OwnerSatisfaction")	; 1 = crap, 2 = adequate, 3 = good, 4 = outstanding
	int price = StorageUtil.GetIntValue(slave, "Price")
	int finalPrice = price * (sat + 1) / 2
;	debug.notification("Buy back " + slave.GetDisplayName() + "  price:" + price + "  sat:" + sat)
;	aygasPriceProperty.SetValueInt(finalPrice)
;	UpdateCurrentInstanceGlobal(aygasPriceProperty)
;	SlavePrice = finalPrice

	if (BuySlaveMessage.Show(finalPrice) == 1)
		Aygas.BuySlave(slave, Seller, finalPrice)
	endif
EndFunction

Function PickupSlave(Actor slave)
	Actor owner = StorageUtil.GetFormValue(slave, "Owner") as Actor
	Aygas.BuySlave(slave, owner, 0)
	ReferenceAlias r = Aygas.EventFunctions.SlaveSlot(slave)
	if (r != None)
			r.Clear()
	endif
EndFunction


Function OfferForSlave(Actor Buyer)
;	Do you wish to buy <Alias=SellSlot1> for %0f septims?
	if (SlaveOnOffer != None)
		Aygas.SelectedSlot.ForceRefTo(SlaveOnOffer)
;		float value = aygasPriceProperty.GetValue()
		Debug.Notification(buyer.GetDisplayName()+" could buy "+SlaveOnOffer.GetDisplayName()+" for "+SlavePrice+" gold")
		if (SellSlaveMessage.Show(SlavePrice) == 1)
			if (SlaveOnOffer == None)
				debug.notification("Could not sell this slave, please try again")
			else
				Aygas.SellSlave(SlaveOnOffer, Buyer, baseType, SlavePrice, true)
			endif
		endif
	endif
EndFunction

Function EvaluateOwner(Actor owner)
	aygas.EvaluateOwner(owner)
EndFunction

Function EvaluateSlave(Actor slave)
	aygas.SelectedSlot.ForceRefTo(slave)
	DaysSinceSale = Utility.GetCurrentGameTime() - StorageUtil.GetFloatValue(slave, "DateOfSale")
	Satisfaction = StorageUtil.GetIntValue(slave, "OwnerSatisfaction")
	JobAction = slave.GetFactionRank(Aygas.JobOverrideAction)
EndFunction

Function EvaluateAuctionSlave(Actor slave)
	; Sets gender, price and job adjustment, experience and obedience
	; Collect stats

	float sexTraining = AYGASInter.GetSexTraining(slave)
	bool IsSexTrained = (sexTraining >= 50.0)

	; Gender
	Aygas.EventFunctions.AuctionSlaveFemale = (Aygas.SexLab.GetGender(slave) == 1)

	; Adjust job based on stats, if needed
	Aygas.EventFunctions.AuctionSlaveType = slave.GetFactionRank(Aygas.SlaveTypeFaction)

	; Price adjustment

	; Set experience and obedience flags
	float slaveTraining = AYGASInter.GetSubmissionTraining(slave)
		slaveTraining += AYGASInter.GetHumiliationTraining(slave)
		slaveTraining += AYGASInter.GetResignationTraining(slave)
		slaveTraining = slaveTraining/3.0

	bool IsObedient = (slaveTraining >= 60.0)

	Aygas.EventFunctions.AuctionSlaveObedient = IsObedient
EndFunction


int Function FindMaximumPriceForBuyer(Actor buyer, int basePrice)
	float max = AYGASInter.GetNPCWealth(buyer) as float
	if max < 0
		return basePrice
	endif
	float price = basePrice as float
	float currentMax = max/4.0
	if price < currentMax
		Debug.Trace("Get price 1 for buyer: "+buyer.GetDisplayName()+" wealth="+max+" base price="+basePrice+" price="+basePrice)
		return basePrice                                    ; up to max/4 = 0.25max
	endif
	if price < max/2.0
		max = currentMax
		float newPrice = currentMax+(price-currentMax)*0.5  ; up to 3max/8 = 0.375max
		Debug.Trace("Get price 2 for buyer: "+buyer.GetDisplayName()+" wealth="+max+" base price="+basePrice+" price="+newPrice)
		return newPrice as int
	endif
	currentMax = 3.0*max/8.0
	if price < max
		float newPrice = currentMax+(price-currentMax)*0.5  ; up to 11max/16 = 0.6875max
		Debug.Trace("Get price 3 for buyer: "+buyer.GetDisplayName()+" wealth="+max+" base price="+basePrice+" price="+newPrice)
		return newPrice as int
	endif
	currentMax = 11.0*max/16.0
	if price < max*2.0
		float newPrice = currentMax+(price-currentMax)*0.25 ; up to 65max/64 = 1.016max
		Debug.Trace("Get price 4 for buyer: "+buyer.GetDisplayName()+" wealth="+max+" base price="+basePrice+" price="+newPrice)
		return newPrice as int
	endif
	currentMax = 65.0*max/64.0
	Debug.Trace("Get price 5 for buyer: "+buyer.GetDisplayName()+" wealth="+max+" base price="+basePrice+" price="+currentMax)
	return currentMax as int
EndFunction

; TODO: Function to adjust the price based on slavery at location.  Lowest prices for low slavery, highest for places where slavery is up and coming, and a little lower for places with lots of slaves.
float Function PriceFactorForLocation(Location l)
	return 1
EndFunction

; TODO: returns persuasion value for buyer: 100 = will never buy slave, 0 = will always buy.
; Factors in the mod difficulty level
; Buyers in places with low slavery are least eager to buy.  Buyers in places with high slavery slightly less eager.
int Function BuyerPersuasionCheck(Actor buyer)
	return 0
EndFunction

; Adjust the increase in slavery after a sale.  The more towns adopt slavery, the harder it becomes to increase it further.  Towns at or near max slavery affect this score the most.
float Function SlaveryIncreaseFactor()
	return 1
EndFunction



aygasCoreScript Property Aygas Auto

int Property BaseType Auto Conditional Hidden
bool Property IsFemale Auto Conditional Hidden


;GlobalVariable Property aygasPriceProperty auto
int Property SlavePrice Auto Hidden
Actor Property SlaveOnOffer Auto Hidden
Message Property SellSlaveMessage Auto
Message Property BuySlaveMessage Auto

float Property DaysSinceSale Auto Conditional Hidden
int Property Satisfaction Auto Conditional Hidden
int Property JobAction Auto Conditional Hidden

