Scriptname phhshSlaveInfoEffectScript extends activemagiceffect  

; WARNING! Script is a modified version of PAHSlaveInfoEffectScript, changed to include slave stats from HSH slaves.

PHHSHStorageFunctions Property PHHSH Auto
PHHSHInterface Property PHHSHInter Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
	if (akTarget.IsInFaction(PHHSH.HouseSlaveFaction))
debug.notification("HSH Slave")
		String t = "Slave " + akTarget.GetDisplayName()

		if PHHSHInter.DOM != None
			t +=  "\n\nSubmission Training: " + PHHSHInter.GetSubmissionTraining(akTarget) \
				+ "\nHumiliation Training: " + PHHSHInter.GetHumiliationTraining(akTarget) \
				+ "\nResignation Training: " + PHHSHInter.GetResignationTraining(akTarget) \
				+ "\nRespect Training: " + PHHSHInter.GetRespectTraining(akTarget) \
				+ "\nCombat Training: " + PHHSHInter.GetCombatTraining(akTarget) \
				+ "\nPose Training: " + PHHSHInter.GetPoseTraining(akTarget) \
				+ "\nSex Training: " + PHHSHInter.GetSexTraining(akTarget)
		else
			t += 	  "\n\nSubmission Training: " + PHHSHInter.GetSubmissionTraining(akTarget) \
				+ "\nRespect Training: " + PHHSHInter.GetRespectTraining(akTarget) \
				+ "\nCombat Training: " + PHHSHInter.GetCombatTraining(akTarget) \
				+ "\nPose Training: " + PHHSHInter.GetPoseTraining(akTarget) \
				+ "\nSex Training: " + PHHSHInter.GetSexTraining(akTarget)
		endif

		PhhshHouseSlave slaveRef = PHHSH.SlaveRef(akTarget)
		if (akTarget.IsInFaction(PHHSH.IsTrainerFaction))
			t += "\n\nTraining: " + slaveRef.trainee.GetDisplayName()
		elseif (akTarget.IsInFaction(PHHSH.IsTraineeFaction))
			t += "\n\nTrained by: " + slaveRef.trainer.GetDisplayName()
		endif
		Debug.MessageBox(t)
	else
		PHHSHInter.SlaveInfoEffect(akTarget,akCaster)
	endif
EndEvent

