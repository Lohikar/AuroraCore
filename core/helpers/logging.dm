// Shims for logging procs to make porting code easier.

#define LOGLINE(source,content) "\[[time2text(world.realtime, "hh:mm:ss")]\] [source]: [content]"

/proc/log_mc(msg)
	world.log << LOGLINE("MASTER", msg)

/proc/log_notice(msg)
	world << LOGLINE("NOTICE", msg)

/proc/log_ss(subsystem, text, log_world = TRUE)
	world.log << LOGLINE("SS[subsystem || "???"]", text)
	if (log_world)
		world << LOGLINE("SS[subsystem || "???"]", text)

/proc/log_game(text)
	world.log << LOGLINE("GAME", text)

/proc/log_debug(text)
	world.log << LOGLINE("DEBUG", text)

/proc/log_warning(text)
	world.log << LOGLINE("WARNING", text)
