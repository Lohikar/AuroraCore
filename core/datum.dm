/datum
	var/isprocessing = FALSE // If we're processing in a SSprocessing-style list.
	var/list/active_timers   // Any timers active on this object.
	var/gcDestroyed          //Time when this object was destroyed.

// General-purpose process() proc meant for use with SSprocessing-style lists.
//  Returning PROCESS_KILL will cause the object to be pruned from the processing list.
/datum/proc/process()
	return PROCESS_KILL

// Default implementation of clean-up code.
// This should be overridden to remove all references pointing to the object being destroyed.
// Return the appropriate QDEL_HINT; in most cases this is QDEL_HINT_QUEUE.
/datum/proc/Destroy(force=FALSE)
	tag = null
	var/list/timers = active_timers
	active_timers = null
	if (timers)
		for(var/thing in timers)
			var/datum/timedevent/timer = thing
			if (timer.spent)
				continue
			qdel(timer)
	return QDEL_HINT_QUEUE
