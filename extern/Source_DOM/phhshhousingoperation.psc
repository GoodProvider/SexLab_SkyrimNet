Scriptname PHHSHHousingOperation extends Quest  Conditional

Function RemoveMarkath()
	MarkathCell.Disable()
EndFunction

Function RemoveWhiterun()
	WhiterunCell.Disable()
EndFunction

Function RemoveWindhelm()
	WindhelmCell.Disable()
EndFunction

Function RemoveSolitude()
	SolitudeCell.Disable()
EndFunction

Function RemoveRiften()
	RiftenCell.Disable()
EndFunction


Function UpgradeMarkath(int price)
	MarkathEnchant.Disable()
	MarkathCell.Enable()
	Game.GetPlayer().RemoveItem(Gold, price)
	Game.GetPlayer().AddItem(CellKey, 1)
EndFunction

Function UpgradeWhiterun(int price)
	WhiterunAlchy.Disable()
	WhiterunChildBRoom.Disable()
	WhiterunAlchyStart.Disable()
	WhiterunCell.Enable()
	Game.GetPlayer().RemoveItem(Gold, price)
	Game.GetPlayer().AddItem(CellKey, 1)
EndFunction

Function UpgradeWindhelm(int price)
	WindhelmGBroom.Disable()
	WindhelmCell.Enable()
	Game.GetPlayer().RemoveItem(Gold, price)
	Game.GetPlayer().AddItem(CellKey, 1)
EndFunction

Function UpgradeSolitude(int price)
	SolitudeGuestBedroom.Disable()
	SolitudeCell.Enable()
	Game.GetPlayer().RemoveItem(Gold, price)
	Game.GetPlayer().AddItem(CellKey, 1)
EndFunction

Function UpgradeRiften(int price)
	RiftenEnchant.Disable()
	RiftenChildBRoom.Disable()
	RiftenCell.Enable()
	Game.GetPlayer().RemoveItem(Gold, price)
	Game.GetPlayer().AddItem(CellKey, 1)
	RiftenEnchantDisable.Enable()
EndFunction

Function BuyPortableCell(int price,int cellType)
	Game.GetPlayer().RemoveItem(Gold, price)
	if (cellType == 1)
		Game.GetPlayer().AddItem(PortableCellToken , 1)
	elseif (cellType == 2)
		Game.GetPlayer().AddItem(PortablePermaCampToken , 1)
	else
		Game.GetPlayer().AddItem(PortableCampToken , 1)
	endif
EndFunction

ObjectReference Property WhiterunAlchyStart Auto
ObjectReference Property WhiterunAlchy Auto
ObjectReference Property WhiterunCell Auto
ObjectReference Property WhiterunChildBRoom Auto

ObjectReference Property RiftenCell Auto
ObjectReference Property RiftenEnchant Auto
ObjectReference Property RiftenEnchantDisable Auto
ObjectReference Property RiftenChildBRoom Auto

ObjectReference Property WindhelmGBroom Auto
ObjectReference Property WindhelmCell Auto

ObjectReference Property SolitudeGuestBedroom Auto
ObjectReference Property SolitudeCell Auto

ObjectReference Property MarkathEnchant Auto
ObjectReference Property MarkathCell Auto

MiscObject Property PortableCellToken Auto
MiscObject Property PortableCampToken Auto
MiscObject Property PortablePermaCampToken Auto


PAHOPortable Property PortableFunctions Auto

Key Property Cellkey Auto

Message Property HouseWarningMsg Auto
MiscObject Property Gold Auto
