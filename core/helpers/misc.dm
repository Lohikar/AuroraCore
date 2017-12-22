/proc/crash_with(msg)
	CRASH(msg)

/proc/warning(msg)
	world.log << "## WARNING: [msg]"

/proc/get_area(O)
	var/turf/loc = get_turf(O)
	if(loc)
		. = loc.loc

/proc/Ceiling(x, y=1)
	return -round(-x / y) * y
