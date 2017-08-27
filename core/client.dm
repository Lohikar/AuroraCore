/client/script = {"<style>
body					{font-family: Verdana, sans-serif;}

h1, h2, h3, h4, h5, h6	{color: #0000ff;font-family: Georgia, Verdana, sans-serif;}

em						{font-style: normal;font-weight: bold;}

.prefix					{font-weight: bold;}
.log_message			{color: #386AFF;	font-weight: bold;}

.danger					{color: #ff0000; font-weight: bold;}
.warning				{color: #ff0000; font-style: italic;}
.rose					{color: #ff5050;}
.info					{color: #0000CC;}
.notice					{color: #000099;}

.interface				{color: #330033;}

.good                   {color: #4f7529; font-weight: bold;}
.bad                    {color: #ee0000; font-weight: bold;}

</style>"}

/client
	parent_type = /datum
	var/datum/marked_datum

/client/verb/start()
	set name = "Start Round"
	set desc = "Sets the MC to 'round started' state. Server must be rebooted to undo."

	if (global.round_is_started)
		usr << "The round is already started!"
	else
		global.round_is_started = TRUE
		Master.RoundStart()
		world << "[src] has started the round."

/client/Topic(href, href_list, hsrc)
	if(!usr || usr != mob)	//stops us calling Topic for somebody else's client. Also helps prevent usr=null
		return

	if (href_list["_src_"] == "vars")
		return view_var_Topic(href,href_list,hsrc)
