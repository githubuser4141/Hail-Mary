/obj/item/mecha_parts/mecha_equipment/weapon
	name = "mecha weapon"
	range = RANGED
	var/projectile
	var/fire_sound
	var/projectiles_per_shot = 1
	var/variance = 0
	var/is_automatic = FALSE
	var/randomspread = 0 //use random spread for machineguns, instead of shotgun scatter
	var/projectile_delay = 0
	var/firing_effect_type = /obj/effect/temp_visual/dir_setting/firing_effect	//the visual effect appearing when the weapon is fired.
	var/kickback = TRUE //Will using this weapon in no grav push mecha back.
	mech_flags = EXOSUIT_MODULE_COMBAT
	equip_type = EQUIP_WEAPON

/obj/item/mecha_parts/mecha_equipment/weapon/proc/get_shot_amount()
	return projectiles_per_shot

/obj/item/mecha_parts/mecha_equipment/weapon/action(atom/target, params)
	if(!action_checks(target))
		return 0

	var/turf/curloc = get_turf(chassis)
	var/turf/targloc = get_turf(target)
	if (!targloc || !istype(targloc) || !curloc)
		return 0
	if (targloc == curloc)
		return 0

	set_ready_state(0)
	for(var/i=1 to get_shot_amount())
		var/obj/item/projectile/A = new projectile(curloc)
		A.firer = chassis.occupant
		A.original = target
		if(!A.suppressed && firing_effect_type)
			new firing_effect_type(get_turf(src), chassis.dir)

		var/spread = 0
		if(variance)
			if(randomspread)
				spread = round((rand() - 0.5) * variance)
			else
				spread = round((i / projectiles_per_shot - 0.5) * variance)
		A.preparePixelProjectile(target, chassis.occupant, params, spread)

		A.fire()
		playsound(chassis, fire_sound, 50, 1)

		sleep(max(0, projectile_delay))

	if(kickback)
		chassis.newtonian_move(turn(chassis.dir,180))
	chassis.mecha_log_message("Fired from [src.name], targeting [target].")
	return 1


//Base energy weapon type
/obj/item/mecha_parts/mecha_equipment/weapon/energy
	name = "general energy weapon"
	firing_effect_type = /obj/effect/temp_visual/dir_setting/firing_effect/energy

/obj/item/mecha_parts/mecha_equipment/weapon/energy/get_shot_amount()
	return min(round(chassis.fuel_holder.volume / energy_drain), projectiles_per_shot)

/obj/item/mecha_parts/mecha_equipment/weapon/energy/start_cooldown()
	set_ready_state(0)
	chassis.use_power(energy_drain*get_shot_amount())
	addtimer(CALLBACK(src, PROC_REF(set_ready_state), 1), equip_cooldown)

/obj/item/mecha_parts/mecha_equipment/weapon/energy/laser
	equip_cooldown = 7
	name = "\improper CH-PS \"Immolator\" laser"
	desc = "A weapon for combat exosuits. Shoots basic lasers."
	icon_state = "mecha_laser"
	energy_drain = 50
	projectile = /obj/item/projectile/beam/laser/mech/light
	fire_sound = 'sound/weapons/laser.ogg'
	harmful = TRUE

/obj/item/mecha_parts/mecha_equipment/weapon/energy/laser/heavy
	equip_cooldown = 14
	name = "\improper CH-LC \"Solaris\" laser cannon"
	desc = "A weapon for combat exosuits. Shoots heavy lasers."
	icon_state = "mecha_laser"
	energy_drain = 75
	projectile = /obj/item/projectile/beam/laser/mech/heavy
	fire_sound = 'sound/weapons/lasercannonfire.ogg'

/obj/item/mecha_parts/mecha_equipment/weapon/energy/ion
	equip_cooldown = 16
	name = "\improper MKIV ion heavy cannon"
	desc = "A weapon for combat exosuits. Shoots technology-disabling ion beams. Don't catch yourself in the blast!"
	icon_state = "mecha_ion"
	energy_drain = 120
	projectile = /obj/item/projectile/ion
	fire_sound = 'sound/weapons/laser.ogg'

/obj/item/mecha_parts/mecha_equipment/weapon/energy/tesla
	equip_cooldown = 25
	name = "\improper MKI Tesla Cannon"
	desc = "A weapon for combat exosuits. Fires bolts of electricity similar to the experimental tesla engine."
	icon_state = "mecha_ion"
	energy_drain = 500
	projectile = /obj/item/projectile/energy/tesla/cannon
	fire_sound = 'sound/magic/lightningbolt.ogg'
	harmful = TRUE

/obj/item/mecha_parts/mecha_equipment/weapon/energy/pulse
	equip_cooldown = 40
	name = "\improper MKII heavy pulse cannon"
	desc = "A weapon for combat exosuits. Shoots powerful destructive blasts."
	icon_state = "mecha_pulse"
	energy_drain = 500
	projectile = /obj/item/projectile/beam/laser/mech/pulse
	fire_sound = 'sound/weapons/marauder.ogg'
	harmful = TRUE

/obj/item/mecha_parts/mecha_equipment/weapon/energy/plasma
	equip_cooldown = 6
	name = "217-D Heavy Plasma Cutter"
	desc = "A device that shoots resonant plasma bursts at extreme velocity. The blasts are capable of crushing rock and demolishing solid obstacles."
	icon_state = "mecha_plasmacutter"
	item_state = "plasmacutter"
	lefthand_file = 'icons/mob/inhands/weapons/guns_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/guns_righthand.dmi'
	energy_drain = 50
	projectile = /obj/item/projectile/plasma/adv/mech
	fire_sound = 'sound/weapons/plasma_cutter.ogg'
	harmful = TRUE

/obj/item/mecha_parts/mecha_equipment/weapon/energy/taser
	name = "\improper PBT \"Pacifier\" mounted taser"
	desc = "A weapon for combat exosuits. Shoots non-lethal stunning electrodes."
	icon_state = "mecha_taser"
	energy_drain = 50
	equip_cooldown = 10
	projectile = /obj/item/projectile/energy/electrode
	fire_sound = 'sound/weapons/taser.ogg'

//Base ballistic weapon type
/obj/item/mecha_parts/mecha_equipment/weapon/ballistic
	name = "general ballistic weapon"
	fire_sound = 'sound/weapons/gunshot.ogg'
	var/projectiles
	var/projectiles_cache //ammo to be loaded in, if possible.
	var/projectiles_cache_max
	var/projectile_energy_cost
	var/disabledreload //For weapons with no cache (like the rockets) which are reloaded by hand
	var/ammo_type

/obj/item/mecha_parts/mecha_equipment/weapon/ballistic/get_shot_amount()
	return min(projectiles, projectiles_per_shot)

/obj/item/mecha_parts/mecha_equipment/weapon/ballistic/action_checks(target)
	if(!..())
		return 0
	if(projectiles <= 0)
		return 0
	return 1

/obj/item/mecha_parts/mecha_equipment/weapon/ballistic/get_equip_info()
	return "[..()] \[[src.projectiles][projectiles_cache_max &&!projectile_energy_cost?"/[projectiles_cache]":""]\][!disabledreload &&(src.projectiles < initial(src.projectiles))?" - <a href='?src=[REF(src)];rearm=1'>Rearm</a>":null]"


/obj/item/mecha_parts/mecha_equipment/weapon/ballistic/rearm()
	if(projectiles < initial(projectiles))
		var/projectiles_to_add = initial(projectiles) - projectiles

		if(projectile_energy_cost)
			while(chassis.get_charge() >= projectile_energy_cost && projectiles_to_add)
				projectiles++
				projectiles_to_add--
				chassis.use_power(projectile_energy_cost)

		else
			if(!projectiles_cache)
				return FALSE
			if(projectiles_to_add <= projectiles_cache)
				projectiles = projectiles + projectiles_to_add
				projectiles_cache = projectiles_cache - projectiles_to_add
			else
				projectiles = projectiles + projectiles_cache
				projectiles_cache = 0

		send_byjax(chassis.occupant,"exosuit.browser","[REF(src)]",src.get_equip_info())
		return TRUE


/obj/item/mecha_parts/mecha_equipment/weapon/ballistic/needs_rearm()
	. = !(projectiles > 0)



/obj/item/mecha_parts/mecha_equipment/weapon/ballistic/Topic(href, href_list)
	..()
	if (href_list["rearm"])
		src.rearm()
	return

/obj/item/mecha_parts/mecha_equipment/weapon/ballistic/action(atom/target)
	if(..())
		projectiles -= get_shot_amount()
		send_byjax(chassis.occupant,"exosuit.browser","[REF(src)]",src.get_equip_info())
		return 1


/obj/item/mecha_parts/mecha_equipment/weapon/ballistic/carbine
	name = "\improper FNX-99 \"Hades\" Carbine"
	desc = "A weapon for combat exosuits. Shoots incendiary bullets."
	icon_state = "mecha_carbine"
	equip_cooldown = 10
	projectile = /obj/item/projectile/bullet/incendiary/fnx99
	projectiles = 24
	projectiles_cache = 24
	projectiles_cache_max = 96
	harmful = TRUE
	ammo_type = "incendiary"

//Shotgun

/obj/item/mecha_parts/mecha_equipment/weapon/ballistic/scattershot
	name = "\improper LBX AC 10 \"Scattershot\""
	desc = "A weapon for vehicules. Usualy carried by a pilot of the passengers. Shoots a spread of pellets."
	icon_state = "mecha_scatter"
	fire_sound = 'sound/weapons/sound_weapons_mech_shotgun.ogg'
	equip_cooldown = 20
	projectile = /obj/item/projectile/bullet/scattershot
	projectiles = 40
	projectiles_cache = 40
	projectiles_cache_max = 160
	projectiles_per_shot = 4
	variance = 25
	harmful = TRUE
	ammo_type = "scattershot"

/obj/item/mecha_parts/mecha_equipment/weapon/ballistic/scattershot/hobo
	name = "\improper Hobot vehicule Shotgun"
	desc = "A modified shotgun used to kick some ass from a vehicule."
	icon_state = "mecha_scatter"
	fire_sound = 'sound/f13weapons/auto5.ogg'
	equip_cooldown = 20
	projectile = /obj/item/projectile/bullet/scattershot
	projectiles = 20
	projectiles_cache = 20
	projectiles_cache_max = 130
	projectiles_per_shot = 3
	variance = 25
	harmful = TRUE
	ammo_type = "scattershot"

/obj/item/mecha_parts/mecha_equipment/weapon/ballistic/scattershot/auto
	name = "\improper Upgraded vehicule Shotgun"
	desc = "A modified shotgun used to kick some ass from a vehicule."
	icon_state = "mecha_scatter"
	fire_sound = 'sound/weapons/sound_weapons_mech_mortar.ogg'
	equip_cooldown = 8
	projectile = /obj/item/projectile/bullet/scattershot
	projectiles = 15
	projectiles_cache = 15
	projectiles_cache_max = 250
	projectiles_per_shot = 5
	variance = 25
	is_automatic = TRUE
	harmful = TRUE
	ammo_type = "scattershot"

/obj/item/mecha_parts/mecha_equipment/weapon/ballistic/seedscatter
	name = "\improper Melon Seed \"Scattershot\""
	desc = "A weapon for combat exosuits. Shoots a spread of pellets, shaped as seed."
	icon_state = "mecha_scatter"
	equip_cooldown = 20
	projectile = /obj/item/projectile/bullet/seed
	projectiles = 20
	projectiles_cache = 20
	projectiles_cache_max = 160
	projectiles_per_shot = 10
	variance = 25
	harmful = TRUE
	ammo_type = "scattershot"

//HMG

/obj/item/mecha_parts/mecha_equipment/weapon/ballistic/lmg
	name = "\improper Ultra AC 2"
	desc = "A weapon for combat exosuits. Shoots a rapid, three shot burst."
	icon_state = "mecha_uac2"
	fire_sound = 'sound/weapons/sound_weapons_mech_autocannon.ogg'
	equip_cooldown = 10
	projectile = /obj/item/projectile/bullet/lmg
	projectiles = 300
	projectiles_cache = 300
	projectiles_cache_max = 1200
	projectiles_per_shot = 3
	is_automatic = TRUE
	variance = 6
	randomspread = 1
	projectile_delay = 2
	harmful = TRUE
	ammo_type = "lmg"

/obj/item/mecha_parts/mecha_equipment/weapon/ballistic/lmg/auto
	name = "\improper AC AUTO"
	desc = "A weapon for combat exosuits. Automatic."
	icon_state = "mecha_uac2"
	fire_sound = 'sound/f13weapons/bozar_fire.ogg'
	equip_cooldown = 2
	projectile = /obj/item/projectile/bullet/lmg/auto
	projectiles = 150
	projectiles_cache = 150
	projectiles_cache_max = 1200
	variance = 6
	projectiles_per_shot = 3
	randomspread = 1.08
	harmful = TRUE
	ammo_type = "lmg"

/obj/item/mecha_parts/mecha_equipment/weapon/ballistic/lmg/hobo
	name = "\improper Improvised HMG"
	desc = "A automatic machine gun make with scraps."
	icon_state = "mecha_uac2"
	fire_sound = 'sound/f13weapons/boltfire.ogg'
	equip_cooldown = 10
	projectile = /obj/item/projectile/bullet/lmg/hobo
	projectiles = 25
	projectiles_cache = 25
	projectiles_cache_max = 1200
	projectiles_per_shot = 2
	variance = 6
	is_automatic = TRUE
	randomspread = 1.2
	harmful = TRUE
	ammo_type = "lmg"

/obj/item/mecha_parts/mecha_equipment/weapon/ballistic/minigun
	name = "\improper Minigun"
	desc = "A heavy machine gun capable of rapidly firing 7.62mm rounds. ready for vehicle mounting, with internal ammo box."
	icon_state = "mecha_uac2"
	fire_sound = 'sound/f13weapons/antimaterielfire.ogg'
	equip_cooldown = 1
	projectile = /obj/item/projectile/bullet/a762
	projectiles = 300
	projectiles_cache = 300
	projectiles_cache_max = 600
	projectiles_per_shot = 1
	variance = 6
	is_automatic = TRUE
	randomspread = 112
	harmful = TRUE
	ammo_type = "minigun"
	var/overheat = 0
	var/overheat_max = 160
	var/heat_diffusion = 2.5 //How much heat is lost per tick
	var/damage = 25



/obj/item/mecha_parts/mecha_equipment/weapon/ballistic/minigun/Initialize()
	. = ..()
	START_PROCESSING(SSobj, src)

/obj/item/mecha_parts/mecha_equipment/weapon/ballistic/minigun/Destroy()
	STOP_PROCESSING(SSobj, src)
	return ..()

/obj/item/mecha_parts/mecha_equipment/weapon/ballistic/minigun/process()
	overheat = max(0, overheat - heat_diffusion)

/obj/item/mecha_parts/mecha_equipment/weapon/ballistic/minigun/action(atom/target, params)
	if(!action_checks(target))
		return 0
	var/turf/curloc = get_turf(chassis)
	var/turf/targloc = get_turf(target)
	if (!targloc || !istype(targloc) || !curloc)
		return 0
	if (targloc == curloc)
		return 0
	if(overheat < overheat_max)
		overheat += projectiles_per_shot
	else
		chassis.occupant_message("The gun's heat sensor locked the trigger to prevent barrel damage.")
		return
	chassis.occupant.DelayNextAction(3)
	set_ready_state(0)
	for(var/i=1 to get_shot_amount())
		var/obj/item/projectile/A = new projectile(curloc)
		A.firer = chassis.occupant
		A.original = target
		A.damage = damage
		if(!A.suppressed && firing_effect_type)
			new firing_effect_type(get_turf(src), chassis.dir)

		var/spread = 0
		if(variance)
			if(randomspread)
				spread = round((rand() - 0.5) * variance)
			else
				spread = round((i / projectiles_per_shot - 0.5) * variance)
		A.preparePixelProjectile(target, chassis.occupant, params, spread)

		A.fire()
		overheat++
		projectiles--
		playsound(chassis, fire_sound, 50, 1)
		chassis.occupant.DelayNextAction(1)

	if(kickback)
		chassis.newtonian_move(turn(chassis.dir,180))

	return 1






/obj/item/mecha_parts/mecha_equipment/weapon/ballistic/missile_rack
	name = "\improper SRM-8 missile rack"
	desc = "A weapon for combat exosuits. Launches light explosive missiles."
	icon_state = "mecha_missilerack"
	projectile = /obj/item/projectile/bullet/a84mm_he
	fire_sound = 'sound/weapons/sound_weapons_mech_mortar.ogg'
	projectiles = 8
	projectiles_cache = 0
	projectiles_cache_max = 0
	disabledreload = TRUE
	equip_cooldown = 60
	harmful = TRUE
	ammo_type = "missiles_he"

/obj/item/mecha_parts/mecha_equipment/weapon/ballistic/missile_rack/breaching
	name = "\improper BRM-6 missile rack"
	desc = "A weapon for combat exosuits. Launches low-explosive breaching missiles designed to explode only when striking a sturdy target."
	icon_state = "mecha_missilerack_six"
	projectile = /obj/item/projectile/bullet/a84mm_br
	projectiles = 6
	projectiles_cache = 0
	projectiles_cache_max = 0
	disabledreload = TRUE
	equip_cooldown = 60
	harmful = TRUE
	ammo_type = "missiles_br"


/obj/item/mecha_parts/mecha_equipment/weapon/ballistic/launcher
	var/missile_speed = 2
	var/missile_range = 30
	var/diags_first = FALSE

/obj/item/mecha_parts/mecha_equipment/weapon/ballistic/launcher/action(target)
	if(!action_checks(target))
		return
	var/obj/O = new projectile(chassis.loc)
	playsound(chassis, fire_sound, 50, 1)
	mecha_log_message("Launched a [O.name] from [name], targeting [target].")
	projectiles--
	proj_init(O)
	O.throw_at(target, missile_range, missile_speed, chassis.occupant, FALSE, diagonals_first = diags_first)
	return 1

//used for projectile initilisation (priming flashbang) and additional logging
/obj/item/mecha_parts/mecha_equipment/weapon/ballistic/launcher/proc/proj_init(obj/O)
	return

/obj/item/mecha_parts/mecha_equipment/weapon/ballistic/launcher/anykind
	name = "\improper Pheumonic launcher"
	desc = "A weapon for combat exosuits. anything loaded in it."
	icon_state = "mecha_grenadelnchr"
	projectile = null
	fire_sound = 'sound/weapons/grenadelaunch.ogg'
	projectiles = 0
	projectiles_cache = 15
	projectiles_cache_max = 20
	missile_speed = 1.5
	equip_cooldown = 10
	var/det_time = 20
	ammo_type = "Anything"
	var/list/obj/stuffs = new
	var/open = FALSE

/obj/item/mecha_parts/mecha_equipment/weapon/ballistic/launcher/anykind/action(target)
	if(!action_checks(target))
		return
	if(!stuffs.len)
		chassis.occupant_message("Nothing to shoot!")
		return
	var/obj/O = stuffs[1]
	playsound(chassis, fire_sound, 50, 1)
	mecha_log_message("Launched a [O.name] from [name], targeting [target].")
	stuffs -= stuffs[1]
	proj_init(O)
	var/turf/nextt = (get_turf(src))
	O.forceMove(nextt)
	O.throw_at(target, missile_range, missile_speed, chassis.occupant, FALSE, diagonals_first = diags_first)
	return 1

/obj/item/mecha_parts/mecha_equipment/weapon/ballistic/launcher/anykind/proj_init(obj/ammo)
	var/turf/T = get_turf(src)
	message_admins("[ADMIN_LOOKUPFLW(chassis.occupant)] fired a [src] in [ADMIN_VERBOSEJMP(T)]")
	log_game("[key_name(chassis.occupant)] fired a [src] in [AREACOORD(T)]")
	if(istype(ammo, /obj/item/grenade/))
		var/obj/item/grenade/payload = ammo
		addtimer(CALLBACK(payload, TYPE_PROC_REF(/obj/item/grenade, prime)), det_time)

/obj/item/mecha_parts/mecha_equipment/weapon/ballistic/launcher/anykind/attackby(obj/item/W, mob/user, params)
	if(open)
		if(stuffs.len < projectiles_cache_max)
			W.forceMove(src)
			stuffs += W
			projectiles++
		else
			to_chat(user, "The [src] is full!")
		return
	. = ..()

/obj/item/mecha_parts/mecha_equipment/weapon/ballistic/launcher/anykind/screwdriver_act(mob/living/carbon/user, obj/item/I)
	if(user.a_intent != INTENT_DISARM)
		if(open)
			to_chat(user, "<span class='notice'>You close the [src]!.</span>")
		else
			to_chat(user, "<span class='notice'>You open the [src]!.</span>")
		open = !open
		return TRUE
	. = ..()

/obj/item/mecha_parts/mecha_equipment/weapon/ballistic/launcher/anykind/attack_self(mob/user)
	if(open && stuffs.len)
		var/obj/selectedthing = input(user, "Chosee an item to take out.", "Stuffs inside") as null|anything in stuffs
		if(!selectedthing)
			return
		stuffs -= selectedthing
		projectiles--
		selectedthing.forceMove(get_turf(src))
		user.put_in_hand(selectedthing)
		return
	. = ..()

/obj/item/mecha_parts/mecha_equipment/weapon/ballistic/launcher/anykind/AltClick(mob/user)
	if(open && stuffs.len)
		for(var/obj/I in stuffs)
			I.forceMove(get_turf(src))
			stuffs -= I
			projectiles--
		to_chat(user, "<span class='notice'>You empty the [src]!.</span>")
		return
	. = ..()


/obj/item/mecha_parts/mecha_equipment/weapon/ballistic/launcher/flashbang
	name = "\improper SGL-6 grenade launcher"
	desc = "A weapon for combat exosuits. Launches primed flashbangs."
	icon_state = "mecha_grenadelnchr"
	projectile = /obj/item/grenade/flashbang
	fire_sound = 'sound/weapons/grenadelaunch.ogg'
	projectiles = 6
	projectiles_cache = 6
	projectiles_cache_max = 24
	missile_speed = 1.5
	equip_cooldown = 60
	var/det_time = 20
	ammo_type = "flashbang"

/obj/item/mecha_parts/mecha_equipment/weapon/ballistic/launcher/flashbang/proj_init(obj/item/grenade/flashbang/F)
	var/turf/T = get_turf(src)
	message_admins("[ADMIN_LOOKUPFLW(chassis.occupant)] fired a [src] in [ADMIN_VERBOSEJMP(T)]")
	log_game("[key_name(chassis.occupant)] fired a [src] in [AREACOORD(T)]")
	addtimer(CALLBACK(F, TYPE_PROC_REF(/obj/item/grenade/flashbang,prime)), det_time)

/obj/item/mecha_parts/mecha_equipment/weapon/ballistic/launcher/flashbang/clusterbang //Because I am a heartless bastard -Sieve //Heartless? for making the poor man's honkblast? - Kaze
	name = "\improper SOB-3 grenade launcher"
	desc = "A weapon for combat exosuits. Launches primed clusterbangs. You monster."
	projectiles = 3
	projectiles_cache = 0
	projectiles_cache_max = 0
	disabledreload = TRUE
	projectile = /obj/item/grenade/clusterbuster
	equip_cooldown = 90
	ammo_type = "clusterbang"
