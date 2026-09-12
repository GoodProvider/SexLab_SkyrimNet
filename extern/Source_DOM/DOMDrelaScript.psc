Scriptname DOMDrelaScript extends ReferenceAlias  
Import Utility

Topic Property DOM03QuestKimliHelp Auto
ReferenceAlias Property Kimli Auto

Event OnDeath(Actor akKiller)
	Wait(1.0)
	Debug.Notification("You hear some strange noise from upstairs")
	Wait(1.0)
	Actor akRef = Kimli.GetActorRef()
	if akRef != None
		akRef.Say(DOM03QuestKimliHelp,akRef,false)
	endif
EndEvent