//Increases delay as the server gets more overloaded,
//as sleeps aren't cheap and sleeping only to wake up and sleep again is wasteful
#define DELTA_CALC max(((max(world.tick_usage, world.cpu) / 100) * max(Master.sleep_delta,1)), 1)

/proc/stoplag()
	// If we're initializing, our tick limit might be over 100 (testing config), but stoplag() penalizes procs that go over.
	// 	Unfortunately, this penalty slows down init a *lot*. So, we disable it during boot and lobby, when relatively few things should be calling this.
	if (!Master || Master.initializing || !Master.round_started)	
		sleep(world.tick_lag)
		return 1

	. = 0
	var/i = 1
	do
		. += round(i*DELTA_CALC)
		sleep(i*world.tick_lag*DELTA_CALC)
		i *= 2
	while (world.tick_usage > min(TICK_LIMIT_TO_RUN, CURRENT_TICKLIMIT))

#undef DELTA_CALC
