Scriptname phhshSlaveTats extends Quest  

Import SlaveTats

Function GetAppliedTats(Actor slave)
	if JValue.isExists(CopiedTats)
		JValue.Clear(CopiedTats)
	else
		CopiedTats = JArray.object()
		JValue.Retain(CopiedTats, "HSH")
	endif
	query_applied_tattoos(slave, 0, CopiedTats)
	CopiedFrom = slave.GetDisplayName()
EndFunction

int Function CopyTatsToRef(int ref)
	if JValue.isExists(ref)
		JValue.Release(ref)
	endif

	if JValue.isExists(CopiedTats)
		ref = JValue.DeepCopy(CopiedTats)
		JValue.Retain(ref, "HSH")
	endif	

	return ref
EndFunction

Function ApplyTats(Actor slave, int ref)
	int i = JArray.count(ref)
	while i > 0
		i -= 1
		int entry = JArray.getObj(ref, i)
		add_tattoo(slave, entry)
	endwhile
	synchronize_tattoos(slave, true)
EndFunction


Function ClearArrayRef(int ref)
	if JValue.isExists(ref)
		JValue.Clear(ref)
	endif
EndFunction

bool Function CheckCopiedTats()
	return (CheckArray(CopiedTats) > 0)
EndFunction

int  Function CheckArray(int ref)
	if JValue.isExists(ref)
		return JValue.count(ref)
	else
		return 0
	endif			
EndFunction

int Property CopiedTats = 0 Auto
string Property CopiedFrom Auto
