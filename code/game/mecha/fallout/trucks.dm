//////////// NCR TRUCK //////////////

/obj/mecha/combat/phazon/ncrtruck
	name = "\improper NCR Truck"
	desc = "A truck running on powercells. Nice eh ? still a wreck."
	icon = 'icons/mecha/ncrtruck.dmi'
	icon_state = "ncrtruck"
	pixel_x = -15
	pixel_y = 0
	max_integrity = 600
	armor = ARMOR_VALUE_VEHICLE_TRUCK
	max_weapons_equip = 1
	max_utility_equip = 8
	stepsound = 'sound/f13machines/buggy_loop.ogg'
	turnsound = 'sound/f13machines/buggy_loop.ogg'
	wreckage = /obj/structure/mecha_wreckage/ncrtruck
	var/list/cargo = new
	var/cargo_capacity = 30
	var/hides = 0

/obj/structure/mecha_wreckage/ncrtruck
	name = "\improper NCR Truck wreckage"
	desc = "Its a truck ! BROKEN TRUCK."
	icon = 'icons/fallout/vehicles/medium_vehicles.dmi'
	icon_state = "derelict"

/obj/mecha/combat/phazon/ncrtruck/go_out()
	..()
	update_icon()

/obj/mecha/combat/phazon/ncrtruck/moved_inside(mob/living/carbon/human/H)
	..()
	update_icon()

/obj/mecha/combat/phazon/ncrtruck/Destroy()
	for(var/atom/movable/A in cargo)
		A.forceMove(drop_location())
		step_rand(A)
	cargo.Cut()
	return ..()

/obj/mecha/combat/phazon/ncrtruck/GrantActions(mob/living/user, human_occupant = 0)
	cycle_action.Grant(user, src)
	lights_action.Grant(user, src)
	stats_action.Grant(user, src)
	eject_action.Grant(user, src)
	klaxon_action.Grant(user, src)

/obj/mecha/combat/phazon/ncrtruck/RemoveActions(mob/living/user, human_occupant = 0)
	cycle_action.Remove(user)
	lights_action.Remove(user)
	stats_action.Remove(user)
	eject_action.Remove(user)
	klaxon_action.Remove(user)

/obj/mecha/combat/phazon/ncrtruck/loaded/Initialize()
	. = ..()
	var/obj/item/mecha_parts/mecha_equipment/ME = new
	ME = new /obj/item/mecha_parts/mecha_equipment/seat
	ME.attach(src)
	ME = new /obj/item/mecha_parts/mecha_equipment/seat
	ME.attach(src)
	ME = new /obj/item/mecha_parts/mecha_equipment/seat
	ME.attach(src)
	ME = new /obj/item/mecha_parts/mecha_equipment/seat
	ME.attach(src)
	ME = new /obj/item/mecha_parts/mecha_equipment/seat
	ME.attach(src)
	ME = new /obj/item/mecha_parts/mecha_equipment/seat
	ME.attach(src)

//////////// NCR TRUCK MP //////////////

/obj/mecha/combat/phazon/ncrtruck/mp
	name = "\improper NCR MP Truck"
	desc = "A truck running on powercells. Nice eh ? still a wreck. This Truck has been given to the NCR MPs, the running gear has been improved."
	icon = 'icons/mecha/ncrtruck-mp.dmi'
	icon_state = "ncrtruck"
	max_integrity = 600
	armor = ARMOR_VALUE_VEHICLE_TRUCK
	wreckage = /obj/structure/mecha_wreckage/ncrtruck

/obj/mecha/combat/phazon/ncrtruck/mp/GrantActions(mob/living/user, human_occupant = 0)
	cycle_action.Grant(user, src)
	lights_action.Grant(user, src)
	stats_action.Grant(user, src)
	eject_action.Grant(user, src)
	klaxon_action.Grant(user, src)
	sirens_action.Grant(user, src)

/obj/mecha/combat/phazon/ncrtruck/mp/RemoveActions(mob/living/user, human_occupant = 0)
	cycle_action.Remove(user)
	lights_action.Remove(user)
	stats_action.Remove(user)
	eject_action.Remove(user)
	klaxon_action.Remove(user)
	sirens_action.Remove(user)

/obj/mecha/combat/phazon/ncrtruck/mp/loaded/Initialize()
	. = ..()
	var/obj/item/mecha_parts/mecha_equipment/ME = new
	ME = new /obj/item/mecha_parts/mecha_equipment/seat
	ME.attach(src)
	ME = new /obj/item/mecha_parts/mecha_equipment/seat
	ME.attach(src)
	ME = new /obj/item/mecha_parts/mecha_equipment/seat
	ME.attach(src)

