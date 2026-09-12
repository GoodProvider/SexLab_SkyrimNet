Scriptname aygasTest extends Quest  

aygasCoreScript Property Aygas Auto

Function ClearPimp()
	Aygas.ProPimp = false
	Aygas.proProstituteTricks = 0
EndFunction

Function SetPimp()
	Aygas.ProPimp = true
	Aygas.proProstituteTricks = 15
EndFunction

Function Debug()
	Actor a = Game.GetCurrentCrosshairRef() as Actor
	if (a)
		string s = a.getDisplayName() + " Debugging "
		Debug.MessageBox(s)
		Aygas.Scenes.ProTrickProstitute.ForceRefTo(a)
		Aygas.Scenes.ProTrickCustomer.ForceRefTo(a)
		a.EvaluatePackage()			
	else
		Debug.messagebox("Not an actor")
	endif
EndFunction
