/obj/mecha/working/ripley
	name = "\improper APLU \"Ripley\""
	desc = "Autonomous Power Loader Unit. This newer model is refitted with powerful armour against the dangers of planetary mining."
	icon_state = "ripley"
	step_in = 3 //Move speed, lower is faster.
	max_temperature = 20000
	max_integrity = 300
	armor = ARMOR_VALUE_MEDIUM
	max_utility_equip = 4
	max_weapons_equip = 2
	max_misc_equip = 2
	wreckage = /obj/structure/mecha_wreckage/ripley
	var/hides = 0

/obj/mecha/working/ripley/go_out()
	..()
	update_icon()

/obj/mecha/working/ripley/moved_inside(mob/living/carbon/human/H)
	..()
	update_icon()
/*
/obj/mecha/working/ripley/Initialize()
	. = ..()
	AddComponent(/datum/component/armor_plate,3,/obj/item/stack/sheet/animalhide/goliath_hide,list("melee" = 10, "bullet" = 5, "laser" = 5))
*/

/obj/mecha/working/ripley/firefighter
	desc = "Autonomous Power Loader Unit. This model is refitted with additional thermal protection."
	name = "\improper APLU \"Firefighter\""
	icon_state = "firefighter"
	step_in = 4
	max_temperature = 65000
	max_integrity = 400
	resistance_flags = LAVA_PROOF | FIRE_PROOF | ACID_PROOF
	lights_power = 7
	armor = ARMOR_VALUE_MEDIUM
	wreckage = /obj/structure/mecha_wreckage/ripley/firefighter


/obj/mecha/working/ripley/deathripley // Admin-only mecha.
	desc = "OH SHIT IT'S THE DEATHSQUAD WE'RE ALL GONNA DIE"
	name = "\improper DEATH-RIPLEY"
	icon_state = "deathripley"
	step_in = 2
	max_temperature = 100000
	max_integrity = 500
	armor = ARMOR_VALUE_MEDIUM
	lights_power = 7
	wreckage = /obj/structure/mecha_wreckage/ripley/deathripley
	step_energy_drain = 0

	max_utility_equip = 3
	max_weapons_equip = 1
	max_misc_equip = 2

/obj/mecha/working/ripley/deathripley/Initialize()
	. = ..()
	var/obj/item/mecha_parts/mecha_equipment/ME = new /obj/item/mecha_parts/mecha_equipment/hydraulic_clamp/kill
	ME.attach(src)

/obj/mecha/working/ripley/deathripley/real
	desc = "OH SHIT IT'S THE DEATHSQUAD WE'RE ALL GONNA DIE. FOR REAL"

/obj/mecha/working/ripley/deathripley/real/Initialize()
	. = ..()
	for(var/obj/item/mecha_parts/mecha_equipment/E in equipment)
		E.detach()
		qdel(E)
	equipment.Cut()
	var/obj/item/mecha_parts/mecha_equipment/ME = new /obj/item/mecha_parts/mecha_equipment/hydraulic_clamp/kill/real
	ME.attach(src)

/obj/mecha/working/ripley/clarke
	desc = "A pre-War design by Vault-Tec to protect workers in hazardous post-War conditions. This model has had its internal ore box replaced with a generic storage module."
	name = "\improper Clarke"
	icon_state = "clarke"
	max_temperature = 65000
	max_integrity = 300
	step_in = 1.6
	resistance_flags = LAVA_PROOF | FIRE_PROOF | ACID_PROOF
	lights_power = 7
	step_energy_drain = 30 //slightly higher energy drain since you movin those wheels FAST
	armor = ARMOR_VALUE_MEDIUM
	wreckage = /obj/structure/mecha_wreckage/clarke
	cargo_capacity = 10
	canstrafe = FALSE

	max_weapons_equip = 2
	max_utility_equip = 2
	max_misc_equip = 2

/obj/mecha/working/clarke/moved_inside(mob/living/carbon/human/H)
	. = ..()
	if(.)
		var/datum/atom_hud/hud = GLOB.huds[DATA_HUD_DIAGNOSTIC_ADVANCED]
		hud.add_hud_to(H)

/obj/mecha/working/clarke/go_out()
	if(isliving(occupant))
		var/mob/living/L = occupant
		var/datum/atom_hud/hud = GLOB.huds[DATA_HUD_DIAGNOSTIC_ADVANCED]
		hud.remove_hud_from(L)
	return ..()

/obj/mecha/working/clarke/mmi_moved_inside(obj/item/mmi/M, mob/user)
	. = ..()
	if(.)
		var/datum/atom_hud/hud = GLOB.huds[DATA_HUD_DIAGNOSTIC_ADVANCED]
		var/mob/living/brain/B = M.brainmob
		hud.add_hud_to(B)

/obj/mecha/working/ripley/mining
	desc = "An old, dusty mining Ripley."
	name = "\improper APLU \"Miner\""
	obj_integrity = 75 //Low starting health

/obj/mecha/working/ripley/mining/Initialize()
	. = ..()
	if(fuel_holder)
		fuel_holder.reagents.remove_reagent("welding_fuel", fuel_holder.reagents.total_volume*0.25) //Starts at very low fuel
	if(prob(70)) //Maybe add a drill
		if(prob(15)) //Possible diamond drill... Feeling lucky?
			var/obj/item/mecha_parts/mecha_equipment/drill/diamonddrill/D = new
			D.attach(src)
		else
			var/obj/item/mecha_parts/mecha_equipment/drill/D = new
			D.attach(src)

	else //Add plasma cutter if no drill
		var/obj/item/mecha_parts/mecha_equipment/weapon/energy/plasma/P = new
		P.attach(src)

	//Add ore box to cargo
	cargo.Add(new /obj/structure/ore_box(src))

	//Attach hydraulic clamp
	var/obj/item/mecha_parts/mecha_equipment/hydraulic_clamp/HC = new
	HC.attach(src)
	for(var/obj/item/mecha_parts/mecha_tracking/B in trackers)//Deletes the beacon so it can't be found easily
		qdel(B)

	var/obj/item/mecha_parts/mecha_equipment/mining_scanner/scanner = new
	scanner.attach(src)
