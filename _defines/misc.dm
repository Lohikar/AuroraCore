#define TICK_CHECK ( world.tick_usage > CURRENT_TICKLIMIT ? stoplag() : 0 )
#define CHECK_TICK if (world.tick_usage > CURRENT_TICKLIMIT)  stoplag()

#define SOFTREF(A) "\ref[A]"
#define WEAKREF(D) (istype(D, /datum) && !D:gcDestroyed ? (D:weakref ? D:weakref : (D:weakref = new(D))) : null)

#define PROCESS_KILL 26 // Used to trigger removal from a processing list.

#define islist(L) istype(L,/list)

#define key_name(M) (istype(M, /client) ? "[M]/([M:mob])" : ismob(M) ? "[M:client || "*NULL*"]/([M])" : "UNKNOWN SUBJECT")

#define get_turf(A) (get_step(A, 0))

#define RANGE_TURFS(RADIUS, CENTER) \
  block( \
    locate(max(CENTER.x-(RADIUS),1),          max(CENTER.y-(RADIUS),1),          CENTER.z), \
    locate(min(CENTER.x+(RADIUS),world.maxx), min(CENTER.y+(RADIUS),world.maxy), CENTER.z) \
  )

#define THIS_PROC_TYPE .....
#define THIS_PROC_TYPE_STR "[THIS_PROC_TYPE]" //Because you can only obtain a string of THIS_PROC_TYPE using "[]", and it's nice to just +/+= strings
#define THIS_PROC_TYPE_STR_WITH_ARGS "[THIS_PROC_TYPE]([args.Join(",")])"
#define THIS_PROC_TYPE_WEIRD ...... //This one is WEIRD, in some cases (When used in certain defines? (eg: ASSERT)) THIS_PROC_TYPE will fail to work, but THIS_PROC_TYPE_WEIRD will work instead
#define THIS_PROC_TYPE_WEIRD_STR "[THIS_PROC_TYPE_WEIRD]" //Included for completeness
#define THIS_PROC_TYPE_WEIRD_STR_WITH_ARGS "[THIS_PROC_TYPE_WEIRD]([args.Join(",")])" //Ditto

#define PROCLOG(thing) log_debug("[THIS_PROC_TYPE]: [thing]")
#define PROCLOG_WEIRD(thing) log_debug("[THIS_PROC_TYPE_WEIRD]: [thing]")
