/mob/Stat()
	. = ..()
	if(statpanel("MC"))
		stat("CPU:", world.cpu)
		stat("Tick Usage:", world.tick_usage)
		stat("Instances:", world.contents.len)
		if(Master)
			Master.stat_entry()
		else
			stat("Master Controller:", "ERROR")
		if(Failsafe)
			Failsafe.stat_entry()
		else
			stat("Failsafe Controller:", "ERROR")
		if (Master)
			stat(null, "- Subsystems -")
			for(var/datum/controller/subsystem/SS in Master.subsystems)
				if (!Master.initializing && SS.flags & SS_NO_DISPLAY)
					continue

				SS.stat_entry()
