Scriptname aygasPropsScript extends Quest  

string Filename = "../Aygas/sets.json"

Function BuildSet(int locationCode)
	float a
	if (JSONUtil.GetPathStringValue(Filename, "." + locationCode + ".CageMarker.X", "") != "")
		float x = JSONUtil.GetPathIntValue(Filename, "." + locationCode + ".CageMarker.X", 0)
		float y = JSONUtil.GetPathIntValue(Filename, "." + locationCode + ".CageMarker.Y", 0)
		float z = JSONUtil.GetPathIntValue(Filename, "." + locationCode + ".CageMarker.Z", 0)
		a = JSONUtil.GetPathIntValue(Filename, "." + locationCode + ".CageMarker.Angle", 0)
		Events.CageMarker.MoveTo(Events.SceneMarker.GetRef(), x, y, z, true)
		Utility.Wait(1)
;		Events.CageMarker.SetAngle(Events.SceneMarker.GetRef().GetAngleX(),Events.SceneMarker.GetRef().GetAngleY(), a)
		Events.Aygas.DebugLog("Got marker info for " + locationCode + " at " + x +  ", " + y + ", " + z + ": " + a )
	endif
	if (JSONUtil.GetPathStringValue(Filename, "." + locationCode + ".Cage.X", "") != "")
		float xc = JSONUtil.GetPathIntValue(Filename, "." + locationCode + ".Cage.X", 0)
		float yc = JSONUtil.GetPathIntValue(Filename, "." + locationCode + ".Cage.Y", 0)
		float zc = JSONUtil.GetPathIntValue(Filename, "." + locationCode + ".Cage.Z", 0)
		CageInstance = Events.CageMarker.PlaceAtMe(Events.Cage.GetbaseObject(), 1)
		CageInstance.MoveTo(Events.CageMarker, xc, yc, zc, true)
		Events.CageMarkerRef.ForceRefTo(CageInstance)
	else
;		CageInstance =  Events.CageMarker.PlaceAtMe(CageMarker, 1)
;		Events.CageMarkerRef.ForceRefTo(CageInstance)
		Events.CageMarkerRef.ForceRefTo(Events.CageMarker)
	endif
	float sa
	if (JSONUtil.GetPathStringValue(Filename, "." + locationCode + ".StockMarker.X", "") != "")
		float sx = JSONUtil.GetPathIntValue(Filename, "." + locationCode + ".StockMarker.X", 0)
		float sy = JSONUtil.GetPathIntValue(Filename, "." + locationCode + ".StockMarker.Y", 0)
		float sz = JSONUtil.GetPathIntValue(Filename, "." + locationCode + ".StockMarker.Z", 0)
		sa = JSONUtil.GetPathIntValue(Filename, "." + locationCode + ".StockMarker.Angle", 0)
		StockInstance = Events.SceneMarker.GetRef().PlaceAtMe(Events.SlaveStock3.GetbaseObject(), 1)
		Events.StockMarkerRef.ForceRefTo(StockInstance)
		StockInstance.MoveTo(Events.SceneMarker.GetRef(), sx,sy, sz, false)
;		StockInstance.SetAngle(StockInstance.GetAngleX(),StockInstance.GetAngleY(), sa)
	endif
	if (JSONUtil.GetPathStringValue(Filename, "." + locationCode + ".Fight.X", "") != "")
		float x = JSONUtil.GetPathIntValue(Filename, "." + locationCode + ".Fight.X", 0)
		float y = JSONUtil.GetPathIntValue(Filename, "." + locationCode + ".Fight.Y", 0)
		float z = JSONUtil.GetPathIntValue(Filename, "." + locationCode + ".Fight.Z", 0)
		Events.FightMarker.MoveTo(Events.SceneMarker.GetRef(), x, y, z, true)
		Events.FightMarkerRef.ForceRefTo(Events.FightMarker)
	endif

	Utility.Wait(10)
	if (StockInstance != None)
		StockInstance.TranslateTo(StockInstance.X, StockInstance.Y, StockInstance.Z, StockInstance.GetAngleX(),StockInstance.GetAngleY(), sa, 300, 300)
	endif
	if (Events.CageMarker != None)
		Events.CageMarker.TranslateTo(Events.CageMarker.X, Events.CageMarker.Y, Events.CageMarker.Z, Events.SceneMarker.GetRef().GetAngleX(),Events.SceneMarker.GetRef().GetAngleY(), a, 300, 300)
	endif
EndFunction

Function MoveSet(int locationCode)
	Events.Aygas.DebugLog("Moving props in location " + locationCode)
	JSONUtil.Unload(Filename)
	if (JSONUtil.GetPathStringValue(Filename, "." + locationCode + ".CageMarker.X", "") != "")
		float x = JSONUtil.GetPathIntValue(Filename, "." + locationCode + ".CageMarker.X", 0)
		float y = JSONUtil.GetPathIntValue(Filename, "." + locationCode + ".CageMarker.Y", 0)
		float z = JSONUtil.GetPathIntValue(Filename, "." + locationCode + ".CageMarker.Z", 0)
		float a = JSONUtil.GetPathIntValue(Filename, "." + locationCode + ".CageMarker.Angle", 0)
		Events.CageMarker.MoveTo(Events.SceneMarker.GetRef(), x, y, z, true)
		Utility.Wait(1)
		Events.CageMarker.SetAngle(Events.SceneMarker.GetRef().GetAngleX(),Events.SceneMarker.GetRef().GetAngleY(), a)
	endif
	if (JSONUtil.GetPathStringValue(Filename, "." + locationCode + ".Cage.X", "") != "")
		float xc = JSONUtil.GetPathIntValue(Filename, "." + locationCode + ".Cage.X", 0)
		float yc = JSONUtil.GetPathIntValue(Filename, "." + locationCode + ".Cage.Y", 0)
		float zc = JSONUtil.GetPathIntValue(Filename, "." + locationCode + ".Cage.Z", 0)
		CageInstance = Events.CageMarkerRef.GetRef()
		CageInstance.MoveTo(Events.CageMarker, xc, yc, zc, true)
	endif
	if (JSONUtil.GetPathStringValue(Filename, "." + locationCode + ".StockMarker.X", "") != "")
		float sx = JSONUtil.GetPathIntValue(Filename, "." + locationCode + ".StockMarker.X", 0)
		float sy = JSONUtil.GetPathIntValue(Filename, "." + locationCode + ".StockMarker.Y", 0)
		float sz = JSONUtil.GetPathIntValue(Filename, "." + locationCode + ".StockMarker.Z", 0)
		float sa = JSONUtil.GetPathIntValue(Filename, "." + locationCode + ".StockMarker.Angle", 0)
		StockInstance = Events.StockMarkerRef.GetRef()
		StockInstance.MoveTo(Events.SceneMarker.GetRef(), sx,sy, sz, false)
		Utility.Wait(1)
		StockInstance.SetAngle(StockInstance.GetAngleX(),StockInstance.GetAngleY(), sa)
	endif
	if (JSONUtil.GetPathStringValue(Filename, "." + locationCode + ".Fight.X", "") != "")
		float x = JSONUtil.GetPathIntValue(Filename, "." + locationCode + ".Fight.X", 0)
		float y = JSONUtil.GetPathIntValue(Filename, "." + locationCode + ".Fight.Y", 0)
		float z = JSONUtil.GetPathIntValue(Filename, "." + locationCode + ".Fight.Z", 0)
		Events.FightMarker.MoveTo(Events.SceneMarker.GetRef(), x, y, z, true)
		Events.FightMarkerRef.ForceRefTo(Events.FightMarker)
	endif

	if (JSONUtil.GetPathStringValue(Filename, "." + locationCode + ".Brazier1.X", "") != "")
		float b1x = JSONUtil.GetPathIntValue(Filename, "." + locationCode + ".Brazier1.X", 0)
		float b1y = JSONUtil.GetPathIntValue(Filename, "." + locationCode + ".Brazier1.Y", 0)
		float b1z = JSONUtil.GetPathIntValue(Filename, "." + locationCode + ".Brazier1.Z", 0)
		float bdz = JSONUtil.GetPathIntValue(Filename, "." + locationCode + ".Brazier1.DZ", 0)

		if (Brazier1InstanceA != None)
			Brazier1InstanceA.Delete()
			Brazier1InstanceB.Delete()
		endif

		Brazier1InstanceA = Events.SceneMarker.GetRef().PlaceAtMe(Events.Brazier1.GetbaseObject(), 1)
		Brazier1InstanceB = Events.SceneMarker.GetRef().PlaceAtMe(Events.Brazier2.GetbaseObject(), 1)
		Brazier1InstanceA.MoveTo(Events.SceneMarker.GetRef(), b1x, b1y, b1z, true)
		Brazier1InstanceB.MoveTo(Events.SceneMarker.GetRef(), b1x, b1y, b1z + bdz, true)

		if (JSONUtil.GetPathStringValue(Filename, "." + locationCode + ".Brazier2.X", "") != "")
			float b2x = JSONUtil.GetPathIntValue(Filename, "." + locationCode + ".Brazier2.X", 0)
			float b2y = JSONUtil.GetPathIntValue(Filename, "." + locationCode + ".Brazier2.Y", 0)
			float b2z = JSONUtil.GetPathIntValue(Filename, "." + locationCode + ".Brazier2.Z", 0)

			if (Brazier2InstanceA != None)
				Brazier2InstanceA.Delete()
				Brazier2InstanceB.Delete()
			endif

			Brazier2InstanceA = Events.SceneMarker.GetRef().PlaceAtMe(Events.Brazier1.GetbaseObject(), 1)
			Brazier2InstanceB = Events.SceneMarker.GetRef().PlaceAtMe(Events.Brazier2.GetbaseObject(), 1)
			Brazier2InstanceA.MoveTo(Events.SceneMarker.GetRef(), b2x, b2y, b2z, true)
			Brazier2InstanceB.MoveTo(Events.SceneMarker.GetRef(), b2x, b2y, b2z + bdz, true)
		endif
	endif

EndFunction


Function TeardownSet()
	if (Events.CageMarkerRef.GetRef() != None)
		Events.CageMarkerRef.GetRef().Delete()
		Events.CageMarkerRef.Clear()
		Events.StockMarkerRef.GetRef().Delete()
		Events.StockMarkerRef.Clear()
		Events.FightMarkerRef.Clear()
	endif

	if (Brazier1InstanceA != None)
		Brazier1InstanceA.Delete()
		Brazier1InstanceB.Delete()
		Brazier1InstanceA = None
	endif
	if (Brazier2InstanceA != None)
		Brazier2InstanceA.Delete()
		Brazier2InstanceB.Delete()
		Brazier2InstanceA = None
	endif
EndFunction

Function FlashSet()
	ObjectReference sc = None
	ObjectReference ca = None
	ObjectReference fi = None

	if (Events.SceneMarker.GetRef() != None)
		sc = Events.SceneMarker.GetRef().PlaceAtMe(MarkScene)
	endif
	if (Events.CageMarker != None)
		ca = Events.CageMarker.PlaceAtMe(MarkCage)
	endif
	if (Events.FightMarkerRef.GetRef() != None)
		fi = Events.FightMarkerRef.GetRef().PlaceAtMe(MarkFight)
	endif

;	Utility.Wait(10)
	if (sc != None)
		sc.DeleteWhenAble()
	endif
	if (ca != None)
		ca.DeleteWhenAble()
	endif
	if (fi != None)
		fi.DeleteWhenAble()
	endif


EndFunction


aygasEvents Property Events Auto

ObjectReference Property CageInstance Auto Hidden
ObjectReference Property StockInstance Auto Hidden
ObjectReference Property Brazier1InstanceA Auto Hidden
ObjectReference Property Brazier1InstanceB Auto Hidden
ObjectReference Property Brazier2InstanceA Auto Hidden
ObjectReference Property Brazier2InstanceB Auto Hidden

Furniture Property MarkScene Auto
Furniture Property MarkCage Auto
Furniture Property MarkFight Auto

Static Property CageMarker Auto

Static Property thing auto