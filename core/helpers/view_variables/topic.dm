
/client/proc/view_var_Topic(href, href_list, hsrc)
	//This should all be moved over to datum/admins/Topic() or something ~Carn
	if(usr.client != src)
		return
	if(href_list["Vars"])
		debug_variables(locate(href_list["Vars"]))

	else if(href_list["varnameedit"] && href_list["datumedit"])
		var/D = locate(href_list["datumedit"])
		if(!istype(D,/datum) && !istype(D,/client))
			usr << "This can only be used on instances of types /client or /datum"
			return

		modify_variables(D, href_list["varnameedit"], 1)

	else if(href_list["varnamechange"] && href_list["datumchange"])
		var/D = locate(href_list["datumchange"])
		if(!istype(D,/datum) && !istype(D,/client))
			usr << "This can only be used on instances of types /client or /datum"
			return

		modify_variables(D, href_list["varnamechange"], 0)

	else if(href_list["varnamemass"] && href_list["datummass"])
		var/atom/A = locate(href_list["datummass"])
		if(!istype(A))
			usr << "This can only be used on instances of type /atom"
			return

		cmd_mass_modify_object_variables(A, href_list["varnamemass"])

	else if(href_list["delall"])
		var/obj/O = locate(href_list["delall"])
		if(!isobj(O))
			usr << "This can only be used on instances of type /obj"
			return

		var/action_type = alert("Strict type ([O.type]) or type and all subtypes?",,"Strict type","Type and subtypes","Cancel")
		if(action_type == "Cancel" || !action_type)
			return

		var/del_action = alert("Are you really sure you want to delete all objects of type [O.type]?",,"Yes","No", "Hard Delete")
		if(del_action == "No")
			return

		if(alert("Second confirmation required. Delete?",,"Yes","No") != "Yes")
			return

		var/O_type = O.type
		switch(action_type)
			if("Strict type")
				var/i = 0
				for(var/obj/Obj in world)
					if(Obj.type == O_type)
						i++
						if (del_action == "Hard Delete")
							Obj.Destroy(TRUE)
							del(Obj)
						else
							qdel(Obj)
				if(!i)
					usr << "No objects of this type exist"
					return

				world << "<span class='notice'>[key_name(usr)] deleted all objects of type [O_type] ([i] objects deleted)</span>"
			if("Type and subtypes")
				var/i = 0
				for(var/obj/Obj in world)
					if(istype(Obj,O_type))
						i++
						if (del_action == "Hard Delete")
							Obj.Destroy(TRUE)
							del(Obj)
						else
							qdel(Obj, TRUE)
				if(!i)
					usr << "No objects of this type exist"
					return

				world << "<span class='notice'>[key_name(usr)] deleted all objects of type or subtype of [O_type] ([i] objects deleted)</span>"


	else if(href_list["mark_object"])
		var/datum/D = locate(href_list["mark_object"])
		if(!istype(D))
			usr << "This can only be done to instances of type /datum"
			return

		marked_datum = D
		href_list["datumrefresh"] = href_list["mark_object"]

	else if(href_list["rotatedatum"])
		var/atom/A = locate(href_list["rotatedatum"])
		if(!istype(A))
			usr << "This can only be done to instances of type /atom"
			return

		switch(href_list["rotatedir"])
			if("right")	A.set_dir(turn(A.dir, -45))
			if("left")	A.set_dir(turn(A.dir, 45))
		href_list["datumrefresh"] = href_list["rotatedatum"]


	else if(href_list["call_proc"])
		var/datum/D = locate(href_list["call_proc"])
		if(istype(D) || istype(D, /client)) // can call on clients too, not just datums
			callproc_targetpicked(1, D)

	if(href_list["datumrefresh"])
		var/datum/DAT = locate(href_list["datumrefresh"])
		if(istype(DAT, /datum) || istype(DAT, /client))
			debug_variables(DAT)
