// Clickable stat() button.
/obj/effect/statclick
	name = "Initializing..."
	var/target

/obj/effect/statclick/New(loc, text, target)
	..()
	name = text
	src.target = target

/obj/effect/statclick/proc/update(text)
	name = text
	return src

/obj/effect/statclick/debug/Click(location, control, params)
	usr.client.debug_variables(target)

// Debug verbs.
/client/verb/restart_controller(controller in list("Master", "Failsafe"))
	set category = "MC Debug"
	set name = "Restart Controller"
	set desc = "Restart one of the various periodic loop controllers for the game (be careful!)"

	switch(controller)
		if("Master")
			new/datum/controller/master()
		if("Failsafe")
			new /datum/controller/failsafe()

	world << "Admin [usr]/([usr.ckey]) has restarted the [controller] controller."

// Subsystems that cmd_ss_panic can hard-restart.
// *MUST* have New() use NEW_SS_GLOBAL.
var/list/panic_targets = list(
	"Garbage" = /datum/controller/subsystem/garbage_collector,
)

// Subsystems that might do funny things or lose data if hard-restarted.
// Makes subsystem require an additional confirmation to restart.
var/list/panic_targets_data_loss = list()

/client/verb/cmd_ss_panic(controller in panic_targets)
	set category = "MC Debug"
	set name = "Force-Restart Subsystem"
	set desc = "Hard-restarts a subsystem. May break things, use with caution."

	if (alert("Hard-Restart [controller]? Use with caution, this may break things.", "Subsystem Restart", "No", "No", "Yes") != "Yes")
		usr << "Aborted."
		return

	// If it's marked as potentially causing data-loss (like SStimer), require another confirmation.
	if (panic_targets_data_loss[controller])
		if (alert("This subsystem ([controller]) may cause data loss or strange behavior if restarted! Continue?", "AAAAAA", "No", "No", "Yes") != "Yes")
			usr << "Aborted."
			return

	world << "SS PANIC: [controller] hard-restart by [usr]!"

	// NEW_SS_GLOBAL will handle destruction of old controller & data transfer, just create a new one and add it to the MC.
	var/ctype = panic_targets[controller]
	Master.subsystems += new ctype

	sortTim(Master.subsystems, /proc/cmp_subsystem_display)
