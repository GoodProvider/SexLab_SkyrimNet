Scriptname bh_dressup extends ObjectReference  
   referencealias Property BHexit01 auto
   referencealias Property BHexit02 auto
   referencealias Property BHdress01 auto
   referencealias Property BHdress02 auto
   referencealias Property BHdress01a auto
   referencealias Property BHdress02a auto
   referencealias Property BHdress01b auto
   referencealias Property BHdress02b auto
   referencealias Property BHdress03 auto
   referencealias Property BHdress04 auto
   referencealias Property BHdress05 auto
   Armor Property JewelryRingSilver auto
   Faction Property BHdress3fact auto
   Faction Property BHdress4fact auto
   Faction Property BHdress5fact auto
   Faction Property BHdress1fact auto
   Faction Property BHdress2fact auto
   ObjectReference Property prisonchest1 auto
   ObjectReference Property prisonchest2 auto
   ObjectReference Property prisonchest3 auto
   ObjectReference Property prisonchest4 auto
   ObjectReference Property prisonchest5 auto
   ObjectReference Property prisonchesttemp auto
   Key Property bhkey auto
   Faction Property BHprisonfact auto
   Faction Property BHdarkfaction auto
   Faction Property BHexitfact auto
   Outfit Property NoOutfit auto
   ObjectReference Property prisonchest1_1 auto
   ObjectReference Property prisonchest2_1 auto
   ObjectReference Property prisonchest3_1 auto
   ObjectReference Property prisonchest4_1 auto
   ObjectReference Property prisonchest5_1 auto
   ObjectReference Property entrydoor auto


Event OnTriggerEnter(ObjectReference akActionRef)
	Actor temp = akActionRef as actor
      If(temp != Game.GetPlayer()) 
	prisonchesttemp.RemoveAllItems()
	if (temp.IsInFaction(BHdress1fact))
	       temp.removefromfaction(BHdress1fact)
              if (entrydoor.ISDisabled())		
		  	prisonchest1.RemoveAllItems(prisonchesttemp,true,true)
			temp.RemoveAllItems(prisonchest1,true,true)
			prisonchesttemp.RemoveAllItems(temp,true,true)
		Else
		  	prisonchest1_1.RemoveAllItems(prisonchesttemp,true,true)
			temp.RemoveAllItems(prisonchest1_1,true,true)
			prisonchesttemp.RemoveAllItems(temp,true,true)
		endif
		if (temp.IsInFaction(BHprisonfact))
			temp.AddItem(bhkey,1,true)	
		else 
             if (temp.IsInFaction(BHdarkfaction))
			  	BHexit02.ForceRefTo(temp)
	         else
				BHexit01.ForceRefTo(temp)
			endif
			temp.Addtofaction(BHexitfact)
		endif
		BHdress01.Clear()
		BHdress01a.Clear()
		BHdress01b.Clear()
		temp.SetPlayerTeammate(true)
		temp.SetOutfit(NoOutfit)		
		temp.AddItem(JewelryRingSilver, 1, false)
		temp.EquipItem(JewelryRingSilver, false, false)
		temp.UnequipItem(JewelryRingSilver, false, false)
		temp.RemoveItem(JewelryRingSilver, 1, false)
		prisonchest1.RemoveItem(JewelryRingSilver, 1, false)
		prisonchest1_1.RemoveItem(JewelryRingSilver, 1, false)
		temp.EvaluatePackage()
	ElseIf (temp.IsInFaction(BHdress2fact))
	       temp.removefromfaction(BHdress2fact)
              if (entrydoor.ISDisabled())		
	       	prisonchest2.RemoveAllItems(prisonchesttemp,true,true)
			temp.RemoveAllItems(prisonchest2,true,true)
			prisonchesttemp.RemoveAllItems(temp,true,true)
		Else
	       	prisonchest2_1.RemoveAllItems(prisonchesttemp,true,true)
			temp.RemoveAllItems(prisonchest2_1,true,true)
			prisonchesttemp.RemoveAllItems(temp,true,true)
		endif
		if (temp.IsInFaction(BHprisonfact))
			temp.AddItem(bhkey,1,true)	
		else 
             		if (temp.IsInFaction(BHdarkfaction))
			  	BHexit02.ForceRefTo(temp)
	           	else
				BHexit01.ForceRefTo(temp)
			endif
			temp.Addtofaction(BHexitfact)
		endif
		BHdress02.Clear()
		BHdress02a.Clear()
		BHdress02b.Clear()
		temp.SetPlayerTeammate(true)
		temp.SetOutfit(NoOutfit)	
		temp.AddItem(JewelryRingSilver, 1, false)
		temp.EquipItem(JewelryRingSilver, false, false)
		temp.UnequipItem(JewelryRingSilver, false, false)
		temp.RemoveItem(JewelryRingSilver, 1, false)
		prisonchest2.RemoveItem(JewelryRingSilver, 1, false)
		prisonchest2_1.RemoveItem(JewelryRingSilver, 1, false)
		temp.EvaluatePackage()
	ElseIf (temp.IsInFaction(BHdress3fact))
	       temp.removefromfaction(BHdress3fact)
              if (entrydoor.ISDisabled())		
 		       prisonchest3.RemoveAllItems(prisonchesttemp,true,true)
			temp.RemoveAllItems(prisonchest3,true,true)
			prisonchesttemp.RemoveAllItems(temp,true,true)
		Else
		       prisonchest3_1.RemoveAllItems(prisonchesttemp,true,true)
			temp.RemoveAllItems(prisonchest3_1,true,true)
			prisonchesttemp.RemoveAllItems(temp,true,true)
		endif
		BHdress03.Clear()
		temp.SetPlayerTeammate(true)
		temp.SetOutfit(NoOutfit)
		temp.AddItem(JewelryRingSilver, 1, false)
		temp.EquipItem(JewelryRingSilver, false, false)
		temp.UnequipItem(JewelryRingSilver, false, false)
		temp.RemoveItem(JewelryRingSilver, 1, false)
		prisonchest3.RemoveItem(JewelryRingSilver, 1, false)
		prisonchest3_1.RemoveItem(JewelryRingSilver, 1, false)
		if (temp.IsInFaction(BHprisonfact))
			temp.AddItem(bhkey,1,true)	
		else 
             		if (temp.IsInFaction(BHdarkfaction))
			  	BHexit02.ForceRefTo(temp)
	           	else
				BHexit01.ForceRefTo(temp)
			endif
			temp.Addtofaction(BHexitfact)
		endif
		temp.EvaluatePackage()
	ElseIf (temp.IsInFaction(BHdress4fact))
	       temp.removefromfaction(BHdress4fact)
              if (entrydoor.ISDisabled())		
		       prisonchest4.RemoveAllItems(prisonchesttemp,true,true)
			temp.RemoveAllItems(prisonchest4,true,true)
			prisonchesttemp.RemoveAllItems(temp,true,true)
		Else
		       prisonchest4_1.RemoveAllItems(prisonchesttemp,true,true)
			temp.RemoveAllItems(prisonchest4_1,true,true)
			prisonchesttemp.RemoveAllItems(temp,true,true)
		endif
		BHdress04.Clear()
		temp.SetPlayerTeammate(true)
		temp.SetOutfit(NoOutfit)	
		temp.AddItem(JewelryRingSilver, 1, false)
		temp.EquipItem(JewelryRingSilver, false, false)
		temp.UnequipItem(JewelryRingSilver, false, false)
		temp.RemoveItem(JewelryRingSilver, 1, false)
		prisonchest4.RemoveItem(JewelryRingSilver, 1, false)
		prisonchest4_1.RemoveItem(JewelryRingSilver, 1, false)
		if (temp.IsInFaction(BHprisonfact))
		else 
             		if (temp.IsInFaction(BHdarkfaction))
			  	BHexit02.ForceRefTo(temp)
	           	else
				BHexit01.ForceRefTo(temp)
			endif
			temp.Addtofaction(BHexitfact)
		endif
		temp.EvaluatePackage()
	ElseIf (temp.IsInFaction(BHdress5fact))
	       temp.removefromfaction(BHdress5fact)
              if (entrydoor.ISDisabled())		
		       prisonchest5.RemoveAllItems(prisonchesttemp,true,true)
			temp.RemoveAllItems(prisonchest5,true,true)
			prisonchesttemp.RemoveAllItems(temp,true,true)
		Else
		       prisonchest5_1.RemoveAllItems(prisonchesttemp,true,true)
			temp.RemoveAllItems(prisonchest5_1,true,true)
			prisonchesttemp.RemoveAllItems(temp,true,true)
		endif
		BHdress05.Clear()		
		temp.SetPlayerTeammate(true)
		temp.SetOutfit(NoOutfit)	
		temp.AddItem(JewelryRingSilver, 1, false)
		temp.EquipItem(JewelryRingSilver, false, false)
		temp.UnequipItem(JewelryRingSilver, false, false)
		temp.RemoveItem(JewelryRingSilver, 1, false)
		prisonchest5.RemoveItem(JewelryRingSilver, 1, false)
		prisonchest5_1.RemoveItem(JewelryRingSilver, 1, false)
		if (temp.IsInFaction(BHprisonfact))
		else 
             		if (temp.IsInFaction(BHdarkfaction))
			  	BHexit02.ForceRefTo(temp)
	           	else
				BHexit01.ForceRefTo(temp)
			endif
			temp.Addtofaction(BHexitfact)
		endif
		temp.EvaluatePackage()
	endif
	endif
EndEvent

Event OnTriggerLeave(ObjectReference akActionRef) 
EndEvent