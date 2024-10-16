//pickuptruck

/obj/mecha/combat/phazon/pickuptruck
	name = "\improper pickup truck"
	desc = "A old vehicule, runing on powercell."
	icon = 'icons/mecha/pickuptruck.dmi'
	icon_state = "pickuptruck"
	pixel_x = -17
	pixel_y = -3
	max_integrity = 300
	step_in = 1.2
	step_energy_drain = 0.4
	armor = ARMOR_VALUE_VEHICLE_MEDIUM
	stepsound = 'sound/f13machines/buggy_loop.ogg'
	turnsound = 'sound/f13machines/buggy_loop.ogg'
	wreckage = /obj/structure/mecha_wreckage/fallout
	cargo_capacity = 2

	max_weapons_equip = 1
	max_utility_equip = 5
	max_misc_equip = 1

	facing_modifiers = list(FRONT_ARMOUR = 0.8, SIDE_ARMOUR = 1, BACK_ARMOUR = 1.25)

/obj/mecha/combat/phazon/pickuptruck/Initialize(mapload)
	. = ..()
	var/obj/item/mecha_parts/mecha_equipment/hydraulic_clamp/fallout13/vehicle_straps/ME = new(src)
	ME.attach(src)

/obj/mecha/combat/phazon/pickuptruck/go_out()
	..()
	update_icon()

/obj/mecha/combat/phazon/pickuptruck/moved_inside(mob/living/carbon/human/H)
	..()
	update_icon()

/obj/mecha/combat/phazon/pickuptruck/GrantActions(mob/living/user, human_occupant = 0)
	cycle_action.Grant(user, src)
	lights_action.Grant(user, src)
	stats_action.Grant(user, src)
	eject_action.Grant(user, src)
	klaxon_action.Grant(user, src)

/obj/mecha/combat/phazon/pickuptruck/RemoveActions(mob/living/user, human_occupant = 0)
	cycle_action.Remove(user)
	lights_action.Remove(user)
	stats_action.Remove(user)
	eject_action.Remove(user)
	klaxon_action.Remove(user)

/obj/mecha/combat/phazon/pickuptruck/loaded/Initialize()
	. = ..()
	var/obj/item/mecha_parts/mecha_equipment/ME = new
	ME = new /obj/item/mecha_parts/mecha_equipment/seat
	ME.attach(src)
	ME = new /obj/item/mecha_parts/mecha_equipment/seat
	ME.attach(src)
	ME = new /obj/item/mecha_parts/mecha_equipment/seat
	ME.attach(src)

	//pickuptruck blue

/obj/mecha/combat/phazon/pickuptruck/blue
	name = "\improper pickup truck"
	desc = "A old vehicule, runing on powercell."
	icon = 'icons/mecha/pickuptruck-blue.dmi'
	icon_state = "pickuptruck"
	max_integrity = 300
	armor = ARMOR_VALUE_VEHICLE_MEDIUM
	wreckage = /obj/structure/mecha_wreckage/buggy

/obj/mecha/combat/phazon/pickuptruck/blue/loaded/Initialize()
	. = ..()
	var/obj/item/mecha_parts/mecha_equipment/ME = new
	ME = new /obj/item/mecha_parts/mecha_equipment/seat
	ME.attach(src)
	ME = new /obj/item/mecha_parts/mecha_equipment/seat
	ME.attach(src)
	ME = new /obj/item/mecha_parts/mecha_equipment/seat
	ME.attach(src)

//pickuptruck bos

/obj/mecha/combat/phazon/pickuptruck/bos
	name = "\improper BoS pickup truck"
	desc = "A old vehicule, runing on powercell."
	icon = 'icons/mecha/pickuptruck-bos.dmi'
	icon_state = "pickuptruck"
	max_integrity = 300
	armor = ARMOR_VALUE_VEHICLE_MEDIUM
	wreckage = /obj/structure/mecha_wreckage/buggy

/obj/mecha/combat/phazon/pickuptruck/bos/loaded/Initialize()
	. = ..()
	var/obj/item/mecha_parts/mecha_equipment/ME = new
	ME = new /obj/item/mecha_parts/mecha_equipment/seat
	ME.attach(src)
	ME = new /obj/item/mecha_parts/mecha_equipment/seat
	ME.attach(src)

//pickuptruck bos AND Kiana

/obj/mecha/combat/phazon/pickuptruck/bos/armed
	name = "\improper BoS pickup truck with gunner"
	desc = "A old vehicule, runing on powercell. Its a A modified brotherhood truck, with the addition of a laser rifle at the back, maned by Paladin Kiana Davberg."
	icon = 'icons/mecha/pickuptruck-gunbos.dmi'
	icon_state = "pickuptruck"
	max_integrity = 300
	armor = ARMOR_VALUE_VEHICLE_MEDIUM
	wreckage = /obj/structure/mecha_wreckage/buggy
	cargo_capacity = 1

	facing_modifiers = list(FRONT_ARMOUR = 0.8, SIDE_ARMOUR = 1, BACK_ARMOUR = 1.5) // There's whole ass paladin in the way..

/obj/mecha/combat/phazon/pickuptruck/bos/armed/loaded/Initialize()
	. = ..()
	var/obj/item/mecha_parts/mecha_equipment/ME = new
	ME = new /obj/item/mecha_parts/mecha_equipment/seat
	ME.attach(src)
	ME = new /obj/item/mecha_parts/mecha_equipment/seat
	ME.attach(src)
	ME = new /obj/item/mecha_parts/mecha_equipment/weapon/energy/laser/heavy
	ME.attach(src)

//pickuptruck mechanic

/obj/mecha/combat/phazon/pickuptruck/mechanic
	name = "\improper mechanic pickup truck"
	desc = "A old vehicule, with a crane runing on fuel."
	icon = 'icons/mecha/pickuptruck-mechanics.dmi'
	icon_state = "pickuptruckmechanic"
	stepsound = 'sound/f13machines/buggy_loop.ogg'
	turnsound = 'sound/f13machines/buggy_loop.ogg'
	wreckage = /obj/structure/mecha_wreckage/buggy
	step_in = 1.2
	step_energy_drain = 0.6
	armor = ARMOR_VALUE_VEHICLE_MED_LIGHT // Less armor, more tools
	cargo_capacity = 5

	max_weapons_equip = 1
	max_utility_equip = 6
	max_misc_equip = 1

/obj/mecha/combat/phazon/pickuptruck/mechanic/Initialize()
	. = ..()
	for(var/obj/item/mecha_parts/mecha_equipment/E in equipment)
		E.detach()
		qdel(E)
	equipment.Cut()
	var/obj/item/mecha_parts/mecha_equipment/ME = new /obj/item/mecha_parts/mecha_equipment/hydraulic_clamp/fallout13
	ME.attach(src)

/obj/mecha/combat/phazon/pickuptruck/mechanic/go_out()
	..()
	update_icon()

/obj/mecha/combat/phazon/pickuptruck/mechanic/moved_inside(mob/living/carbon/human/H)
	..()
	update_icon()

/obj/mecha/combat/phazon/pickuptruck/mechanic/GrantActions(mob/living/user, human_occupant = 0)
	cycle_action.Grant(user, src)
	lights_action.Grant(user, src)
	stats_action.Grant(user, src)
	eject_action.Grant(user, src)
	klaxon_action.Grant(user, src)

/obj/mecha/combat/phazon/pickuptruck/mechanic/RemoveActions(mob/living/user, human_occupant = 0)
	cycle_action.Remove(user)
	lights_action.Remove(user)
	stats_action.Remove(user)
	eject_action.Remove(user)
	klaxon_action.Remove(user)

/obj/mecha/combat/phazon/pickuptruck/mechanic/loaded/Initialize()
	. = ..()
	var/obj/item/mecha_parts/mecha_equipment/ME = new
	ME = new /obj/item/mecha_parts/mecha_equipment/seat
	ME.attach(src)
	ME = new /obj/item/mecha_parts/mecha_equipment/seat
	ME.attach(src)

//jeep

/obj/mecha/combat/phazon/jeep
	name = "\improper pickup truck"
	desc = "A old vehicle, runing on fuel."
	icon = 'icons/mecha/jeep.dmi'
	icon_state = "jeep"
	pixel_x = -15
	pixel_y = 0
	step_in = 1.2
	step_energy_drain = 0.4
	max_integrity = 200
	armor = ARMOR_VALUE_VEHICLE_MEDIUM
	stepsound = 'sound/f13machines/buggy_loop.ogg'
	turnsound = 'sound/f13machines/buggy_loop.ogg'
	wreckage = /obj/structure/mecha_wreckage/buggy
	cargo_capacity = 1

	max_weapons_equip = 1
	max_utility_equip = 4
	max_misc_equip = 1

/obj/mecha/combat/phazon/jeep/go_out()
	..()
	update_icon()

/obj/mecha/combat/phazon/jeep/moved_inside(mob/living/carbon/human/H)
	..()
	update_icon()

/obj/mecha/combat/phazon/jeep/GrantActions(mob/living/user, human_occupant = 0)
	cycle_action.Grant(user, src)
	lights_action.Grant(user, src)
	stats_action.Grant(user, src)
	eject_action.Grant(user, src)
	klaxon_action.Grant(user, src)

/obj/mecha/combat/phazon/jeep/RemoveActions(mob/living/user, human_occupant = 0)
	cycle_action.Remove(user)
	lights_action.Remove(user)
	stats_action.Remove(user)
	eject_action.Remove(user)
	klaxon_action.Remove(user)

/obj/mecha/combat/phazon/jeep/Initialize(mapload)
	. = ..()
	var/obj/item/mecha_parts/mecha_equipment/hydraulic_clamp/fallout13/vehicle_straps/ME = new(src)
	ME.attach(src)

/obj/mecha/combat/phazon/jeep/loaded/Initialize()
	. = ..()
	var/obj/item/mecha_parts/mecha_equipment/ME = new
	ME = new /obj/item/mecha_parts/mecha_equipment/seat
	ME.attach(src)
	ME = new /obj/item/mecha_parts/mecha_equipment/seat
	ME.attach(src)


//jeep Enclave

/obj/mecha/combat/phazon/jeep/enclave
	name = "\improper pickup truck"
	desc = "A old military vehicule, runing on fuel., and recolored"
	icon = 'icons/mecha/jeepenclave.dmi'
	icon_state = "jeepenclave"

///jeep BOS

/obj/mecha/combat/phazon/jeep/bos
	name = "\improper pickup truck"
	desc = "A old military vehicule, runing on fuel, and recolored"
	icon = 'icons/mecha/jeepbos.dmi'
	icon_state = "jeepbos"
