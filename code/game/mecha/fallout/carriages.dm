//Legion Chariot

/obj/mecha/combat/phazon/buggy/legion
	name = "\improper Legion Chariot"
	desc = "A light vehicle, not very powerfull or solid, running on a power cell... Okay, its a lie. Its actually run on power generated by the horse...The cell is here to make sure that some componant of the half buggy pulled by horses works."
	icon = 'icons/mecha/buggy-legion.dmi'
	icon_state = "legionbuggy"
	pixel_x = -18
	pixel_y = 0
	max_integrity = 250
	step_energy_drain = 0.8
	step_in = 1.2
	armor = ARMOR_VALUE_HEAVY
	stepsound = 'sound/effects/footstep/gallop2.ogg'
	turnsound = 'sound/effects/footstep/gallop1.ogg'
	wreckage = /obj/structure/mecha_wreckage/buggy

	max_utility_equip = 3
	max_weapons_equip = 1
	max_misc_equip = 1

/obj/mecha/combat/phazon/buggy/legion/go_out()
	..()
	update_icon()

/obj/mecha/combat/phazon/buggy/legion/moved_inside(mob/living/carbon/human/H)
	..()
	update_icon()

/obj/mecha/combat/phazon/buggy/legion/GrantActions(mob/living/user, human_occupant = 0)
	cycle_action.Grant(user, src)
	lights_action.Grant(user, src)
	stats_action.Grant(user, src)
	eject_action.Grant(user, src)
	klaxon_action.Grant(user, src)

/obj/mecha/combat/phazon/buggy/legion/RemoveActions(mob/living/user, human_occupant = 0)
	cycle_action.Remove(user)
	lights_action.Remove(user)
	stats_action.Remove(user)
	eject_action.Remove(user)
	klaxon_action.Remove(user)

/obj/mecha/combat/phazon/buggy/legion/loaded/Initialize()
	. = ..()
	var/obj/item/mecha_parts/mecha_equipment/ME = new
	ME = new /obj/item/mecha_parts/mecha_equipment/seat
	ME.attach(src)

//Buggy Legion AND MESALLA

/obj/mecha/combat/phazon/buggy/legionarmed
	name = "\improper Legion Chariot with gunner"
	desc = "A light vehicle, not very powerfull or solid, running on a power cell... Okay, its a lie. Its actually run on power generated by the horse...The cell is here to make sure that some componant of the half buggy pulled by horses works. This one as been recolored by the legions... And Prime Decanus Messala ''Gunner'' Davius is gonna shoot with his shotgun."
	icon = 'icons/mecha/buggy-legiongun.dmi'
	icon_state = "legiongun"
	max_integrity = 250
	step_energy_drain = 0.8
	step_in = 1.2
	armor = ARMOR_VALUE_HEAVY

/obj/mecha/combat/phazon/buggy/legionarmed/GrantActions(mob/living/user, human_occupant = 0)
	cycle_action.Grant(user, src)
	lights_action.Grant(user, src)
	stats_action.Grant(user, src)
	eject_action.Grant(user, src)
	klaxon_action.Grant(user, src)
	smoke_action.Grant(user, src)

/obj/mecha/combat/phazon/buggy/legionarmed/RemoveActions(mob/living/user, human_occupant = 0)
	cycle_action.Remove(user)
	lights_action.Remove(user)
	stats_action.Remove(user)
	eject_action.Remove(user)
	klaxon_action.Remove(user)
	smoke_action.Remove(user)

/obj/mecha/combat/phazon/buggy/legionarmed/loaded/Initialize()
	. = ..()
	var/obj/item/mecha_parts/mecha_equipment/ME = new
	ME = new /obj/item/mecha_parts/mecha_equipment/seat
	ME.attach(src)
	ME = new /obj/item/mecha_parts/mecha_equipment/weapon/ballistic/scattershot
	ME.attach(src)
	max_ammo()

//truckcaravan

/obj/mecha/combat/phazon/truckcaravan
	name = "\improper Truck caravan"
	desc = "A vehicle, not very powerfull or solid, running on a power cell... Okay, its a lie. Its pulled by two brahmins...The cell is here to make sure that some componant of the half buggy pulled by brahmins works."
	icon = 'icons/mecha/truckcaravan.dmi'
	icon_state = "truckcaravan"
	pixel_x = -20
	pixel_y = 0
	max_integrity = 250
	step_in = 1.6
	step_energy_drain = 0.8
	armor = ARMOR_VALUE_HEAVY

	max_utility_equip = 4
	max_weapons_equip = 1
	max_misc_equip = 1

/obj/mecha/combat/phazon/truckcaravan/loaded/Initialize()
	. = ..()
	var/obj/item/mecha_parts/mecha_equipment/ME = new
	ME = new /obj/item/mecha_parts/mecha_equipment/seat
	ME.attach(src)
