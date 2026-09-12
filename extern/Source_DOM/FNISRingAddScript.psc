Scriptname FNISRingAddScript extends Quest 

Int Property CurrentGroup = 0 Auto
Int Property NextIdle = 0 Auto
Idle[] Property FNISidle Auto

Quest[] Property SubQuest Auto
Int[] Property QuestCnt Auto
Actor[] Property FNISnpc Auto
Quest Property FNISquest1 Auto
Quest Property FNISquest2 Auto
Quest Property FNISquest3 Auto
Quest Property FNISquest4 Auto
Quest Property FNISquest5 Auto
Quest Property FNISquest6 Auto
Quest Property FNISquest7 Auto
Quest Property FNISquest8 Auto
Quest Property FNISquest9 Auto
Quest Property FNISquest10 Auto

Spell Property IdleSpell Auto
Armor Property FNISIdleRing Auto
Armor Property FNISSelectRing Auto

bool do_skip_addring = true

Event OnInit()
int i
	Utility.Wait(1)
	Actor player = Game.GetPlayer()
	player.AddSpell(IdleSpell, false)
	if !do_skip_addring
		player.AddItem(FNISIdleRing, 1, true)
		player.AddItem(FNISSelectRing, 1, true)
	endif
	
	SubQuest = new Quest[11]
	SubQuest[1] = FNISquest1
	SubQuest[2] = FNISquest2
	SubQuest[3] = FNISquest3
	SubQuest[4] = FNISquest4
	SubQuest[5] = FNISquest5
	SubQuest[6] = FNISquest6
	SubQuest[7] = FNISquest7
	SubQuest[8] = FNISquest8
	SubQuest[9] = FNISquest9
	SubQuest[10] = FNISquest10

	QuestCnt = new Int[11]
	FNISnpc = new Actor[11]
	i = 0
	while ( i <= 10 )
		QuestCnt[i] = 0
		FNISnpc[i] = None
		i = i + 1
	endWhile
	
	FNISidle = new Idle[81]
	FNISidle[0] = FNISidle1
	FNISidle[1] = FNISidle2
	FNISidle[2] = FNISidle3
	FNISidle[3] = FNISidle4
	FNISidle[4] = FNISidle5
	FNISidle[5] = FNISidle6
	FNISidle[6] = FNISidle7
	FNISidle[7] = FNISidle8
	FNISidle[8] = FNISidle9
	FNISidle[9] = FNISidle10
	FNISidle[10] = FNISidle11
	FNISidle[11] = FNISidle12
	FNISidle[12] = FNISidle13
	FNISidle[13] = FNISidle14
	FNISidle[14] = FNISidle15
	FNISidle[15] = FNISidle16
	FNISidle[16] = FNISidle17
	FNISidle[17] = FNISidle18
	FNISidle[18] = FNISidle19
	FNISidle[19] = FNISidle20
	FNISidle[20] = FNISidle21
	FNISidle[21] = FNISidle22
	FNISidle[22] = FNISidle23
	FNISidle[23] = FNISidle24
	FNISidle[24] = FNISidle25
	FNISidle[25] = FNISidle26
	FNISidle[26] = FNISidle27
	FNISidle[27] = FNISidle28
	FNISidle[28] = FNISidle29
	FNISidle[29] = FNISidle30
	FNISidle[30] = FNISidle31
	FNISidle[31] = FNISidle32
	FNISidle[32] = FNISidle33
	FNISidle[33] = FNISidle34
	FNISidle[34] = FNISidle35
	FNISidle[35] = FNISidle36
	FNISidle[36] = FNISidle37
	FNISidle[37] = FNISidle38
	FNISidle[38] = FNISidle39
	FNISidle[39] = FNISidle40
	FNISidle[40] = FNISidle41
	FNISidle[41] = FNISidle42
	FNISidle[42] = FNISidle43
	FNISidle[43] = FNISidle44
	FNISidle[44] = FNISidle45
	FNISidle[45] = FNISidle46
	FNISidle[46] = FNISidle47
	FNISidle[47] = FNISidle48
	FNISidle[48] = FNISidle49
	FNISidle[49] = FNISidle50
	FNISidle[50] = FNISidle51
	FNISidle[51] = FNISidle52
	FNISidle[52] = FNISidle53
	FNISidle[53] = FNISidle54
	FNISidle[54] = FNISidle55
	FNISidle[55] = FNISidle56
	FNISidle[56] = FNISidle57
	FNISidle[57] = FNISidle58
	FNISidle[58] = FNISidle59
	FNISidle[59] = FNISidle60
	FNISidle[60] = FNISidle61
	FNISidle[61] = FNISidle62
	FNISidle[62] = FNISidle63
	FNISidle[63] = FNISidle64
	FNISidle[64] = FNISidle65
	FNISidle[65] = FNISidle66
	FNISidle[66] = FNISidle67
	FNISidle[67] = FNISidle68
	FNISidle[68] = FNISidle69
	FNISidle[69] = FNISidle70
	FNISidle[70] = FNISidle71
	FNISidle[71] = FNISidle72
	FNISidle[72] = FNISidle73
	FNISidle[73] = FNISidle74
	FNISidle[74] = FNISidle75
	FNISidle[75] = FNISidle76
	FNISidle[76] = FNISidle77
	FNISidle[77] = FNISidle78
	FNISidle[78] = FNISidle79
	FNISidle[79] = FNISidle80
	FNISidle[80] = FNISidle81
EndEvent


Idle property FNISidle1 Auto
Idle property FNISidle2 Auto
Idle property FNISidle3 Auto
Idle property FNISidle4 Auto
Idle property FNISidle5 Auto
Idle property FNISidle6 Auto
Idle property FNISidle7 Auto
Idle property FNISidle8 Auto
Idle property FNISidle9 Auto
Idle property FNISidle10 Auto
Idle property FNISidle11 Auto
Idle property FNISidle12 Auto
Idle property FNISidle13 Auto
Idle property FNISidle14 Auto
Idle property FNISidle15 Auto
Idle property FNISidle16 Auto
Idle property FNISidle17 Auto
Idle property FNISidle18 Auto
Idle property FNISidle19 Auto
Idle property FNISidle20 Auto
Idle property FNISidle21 Auto
Idle property FNISidle22 Auto
Idle property FNISidle23 Auto
Idle property FNISidle24 Auto
Idle property FNISidle25 Auto
Idle property FNISidle26 Auto
Idle property FNISidle27 Auto
Idle property FNISidle28 Auto
Idle property FNISidle29 Auto
Idle property FNISidle30 Auto
Idle property FNISidle31 Auto
Idle property FNISidle32 Auto
Idle property FNISidle33 Auto
Idle property FNISidle34 Auto
Idle property FNISidle35 Auto
Idle property FNISidle36 Auto
Idle property FNISidle37 Auto
Idle property FNISidle38 Auto
Idle property FNISidle39 Auto
Idle property FNISidle40 Auto
Idle property FNISidle41 Auto
Idle property FNISidle42 Auto
Idle property FNISidle43 Auto
Idle property FNISidle44 Auto
Idle property FNISidle45 Auto
Idle property FNISidle46 Auto
Idle property FNISidle47 Auto
Idle property FNISidle48 Auto
Idle property FNISidle49 Auto
Idle property FNISidle50 Auto
Idle property FNISidle51 Auto
Idle property FNISidle52 Auto
Idle property FNISidle53 Auto
Idle property FNISidle54 Auto
Idle property FNISidle55 Auto
Idle property FNISidle56 Auto
Idle property FNISidle57 Auto
Idle property FNISidle58 Auto
Idle property FNISidle59 Auto
Idle property FNISidle60 Auto
Idle property FNISidle61 Auto
Idle property FNISidle62 Auto
Idle property FNISidle63 Auto
Idle property FNISidle64 Auto
Idle property FNISidle65 Auto
Idle property FNISidle66 Auto
Idle property FNISidle67 Auto
Idle property FNISidle68 Auto
Idle property FNISidle69 Auto
Idle property FNISidle70 Auto
Idle property FNISidle71 Auto
Idle property FNISidle72 Auto
Idle property FNISidle73 Auto
Idle property FNISidle74 Auto
Idle property FNISidle75 Auto
Idle property FNISidle76 Auto
Idle property FNISidle77 Auto
Idle property FNISidle78 Auto
Idle property FNISidle79 Auto
Idle property FNISidle80 Auto
Idle property FNISidle81 Auto
