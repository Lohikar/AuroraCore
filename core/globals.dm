var/global/midnight_rollovers = 0
var/global/rollovercheck_last_timeofday = 0

var/global/round_is_started = FALSE
var/global/mc_is_started = FALSE

/proc/update_midnight_rollover()
	if (world.timeofday < rollovercheck_last_timeofday) //TIME IS GOING BACKWARDS!
		return midnight_rollovers++
	return midnight_rollovers
