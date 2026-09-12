Scriptname phhshHavokHandling extends Quest Conditional

Function PrepareToAttach(Actor slave)
	; Clear attached chains and prepare slave to be attached to chains
	PHHSHHouseSlave slaveScript = PHHSH.SlaveRef(slave)
	if (slaveScript)
		slaveScript.ChainWristL = None
		slaveScript.ChainWristR = None
		slaveScript.ChainAnkleL = None
		slaveScript.ChainAnkleR = None
		slaveScript.ChainNeck = None
		PHHSH.RestrainAtMarker(slave, "", 8)
	endif
EndFunction


Function AttachLimbToChain(Actor slave)
	PHHSHHouseSlave slaveScript = PHHSH.SlaveRef(slave)
	if (slaveScript != None)
		if ((slaveScript.ChainWristL != None) && (slaveScript.ChainWristR != None) && (slaveScript.ChainAnkleL != None) && (slaveScript.ChainAnkleR != None) && (slaveScript.ChainNeck != None))
			Debug.Notification("Slave is fully chained up")
		else
			usedLeftWrist = (slaveScript.ChainWristL != None)
			usedRightWrist = (slaveScript.ChainWristR != None)
			usedLeftAnkle = (slaveScript.ChainAnkleL != None)
			usedRightAnkle = (slaveScript.ChainAnkleR != None)
			usedNeck = (slaveScript.ChainNeck != None)
			response = AttachMenu.Show()

			if (response != 0)
				OnUpdate()
				UsingSlave = slave
				RegisterForUpdate(5)
				RegisterForKey(28)
				RegisterForKey(1)
			endif
		endif
	endif
EndFunction


Function ExitAttach()
	UnregisterForKey(28)
	UnregisterForKey(1)
	UnregisterForUpdate()
	UsingSlave = None
EndFunction

Event OnKeyDown(int keyCode)
	if (keyCode == 28)
		ObjectReference obj = Game.GetCurrentCrosshairRef()
		if (obj.GetBaseObject() == PHHSH.HR_HavocChain)
			Actor slave = UsingSlave
			ExitAttach()
			PHHSHHouseSlave slaveScript = PHHSH.SlaveRef(slave)
			if (slaveScript)
				if (response == 1)
					slaveScript.ChainWristL = obj
				elseif (response == 2)
					slaveScript.ChainWristR = obj
				elseif (response == 3)
					slaveScript.ChainAnkleL = obj
				elseif (response == 4)
					slaveScript.ChainAnkleR = obj
				elseif (response == 5)
					slaveScript.ChainNeck = obj
				endif
				slaveScript.BindToChains()
				AttachLimbToChain(slave)
			endif
		endif
	elseif (keyCode == 1)
		ExitAttach()
	endif
EndEvent

Event OnUpdate()
	ReferenceAlias c = PHHSH.PortableFunctions.HoldingCellrefForCell(Game.GetPlayer().GetParentCell())
	if (c != None)
		Debug.Notification("Aim at a chain, Enter to attach, Esc to cancel")
	endif
EndEvent

PHHSHStorageFunctions Property PHHSH Auto
Actor Property UsingSlave Auto
Message Property AttachMenu Auto
int Property response Auto

bool Property usedLeftWrist Auto Conditional
bool Property usedRightWrist Auto Conditional
bool Property usedLeftAnkle Auto Conditional
bool Property usedRightAnkle Auto Conditional
bool Property usedNeck Auto Conditional