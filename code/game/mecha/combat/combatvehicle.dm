// VERTIBIRD

/obj/mecha/combat/combatvehicle/vertibird
	name = "\improper Combat Vertibird"
	desc = "A real useable, and working vertibird, maintained with luck, sweat, and ducktape. This one seems to be more focused toward combat."
	icon = 'icons/mecha/vb-vertibird.dmi'
	icon_state = "vb"
	pixel_shift_profile = VEHICLE_PIXEL_SHIFT_VERTIBIRD
	vehicle_driving_profile = HANDLING_PROFILE_VERTIBIRD
	equipment_profile = EQUIPMENT_VEHICLE_STRIPPED
	max_integrity = INTEGRITY_VERTIBIRD
	deflect_chance = 30
	armor = ARMOR_VALUE_LIGHT
	wreckage = /obj/structure/mecha_wreckage/vertibird
	force = 30
	max_equip = 4
	canstrafe = TRUE
	movement_type = FLYING
	stepsound = 'sound/f13machines/vertibird_loop.ogg'
	turnsound = 'sound/f13machines/vertibird_loop.ogg'

/obj/structure/mecha_wreckage/vertibird
	name = "\improper Vertibird Wreck"
	desc = "Mayday, Mayday, Vertibird going down... IN STYLE."
	icon = 'icons/mecha/vb-vertibird.dmi'
	icon_state = "vb-broken"
	pixel_x = -138
	pixel_y = -138

/obj/mecha/combat/combatvehicle/vertibird/GrantActions(mob/living/user, human_occupant = 0)
	internals_action.Grant(user, src)
	cycle_action.Grant(user, src)
	lights_action.Grant(user, src)
	stats_action.Grant(user, src)
	strafing_action.Grant(user, src)
	zoom_action.Grant(user, src)
	eject_action.Grant(user, src)
	landing_action.Grant(user, src)

/obj/mecha/combat/combatvehicle/vertibird/RemoveActions(mob/living/user, human_occupant = 0)
	internals_action.Remove(user)
	cycle_action.Remove(user)
	lights_action.Remove(user)
	stats_action.Remove(user)
	strafing_action.Remove(user)
	zoom_action.Remove(user)
	eject_action.Remove(user)
	landing_action.Remove(user)

/obj/mecha/combat/combatvehicle/vertibird/obj_destruction()
	for(var/mob/M in src)
		to_chat(M, span_brass("The vertibird is going to crash!"))
		M.dust()
	playsound(src, 'sound//f13machines//vertibird_crash.ogg', 100, 0)
	src.visible_message(span_userdanger("The reactor has gone critical, its going to blow!"))
	addtimer(CALLBACK(src,.proc/go_critical),breach_time)

/obj/mecha/combat/combatvehicle/vertibird/proc/go_critical()
	explosion(get_turf(loc))
	Destroy(src)

/obj/mecha/combat/combatvehicle/vertibird/loaded
	equipment_profile = EQUIPMENT_VERTIBIRD_COMBAT

/obj/mecha/combat/combatvehicle/vertibird/loaded/Initialize()
	. = ..()
	max_ammo()

///NCR VERTIBIRD

/obj/mecha/combat/combatvehicle/vertibird/ncr
	name = "\improper NCR Attack Vertibird"
	desc = "A real useable, and working vertibird, maintained with luck, sweat, and ducktape. This one seems to be more focused toward combat, and is painted in the colors of the NCR."
	icon = 'icons/mecha/vb-vertibird-ncr.dmi'
	icon_state = "vb"

/obj/mecha/combat/combatvehicle/vertibird/ncr/loaded
	equipment_profile = EQUIPMENT_VERTIBIRD_COMBAT

/obj/mecha/combat/combatvehicle/vertibird/ncr/loaded/Initialize()
	. = ..()
	max_ammo()

///VERTIBIRD ENCLAVE

/obj/mecha/combat/combatvehicle/vertibird/enclave
	name = "\improper Enclave Naval Vertibird"
	desc = "A real useable, and working vertibird, maintained with luck, sweat, and ducktape. This one seems to be more focused toward combat, and be stored in a ship. Thats peak Enclave tech."
	icon = 'icons/mecha/vb-vertibird-enclave.dmi'
	icon_state = "vb"

/obj/mecha/combat/combatvehicle/vertibird/enclave/loaded
	equipment_profile = EQUIPMENT_VERTIBIRD_COMBAT

/obj/mecha/combat/combatvehicle/vertibird/enclave/loaded/Initialize()
	. = ..()
	max_ammo()

/// BOS Vertibird

/obj/mecha/combat/combatvehicle/vertibird/brotherhood
	name = "\improper Brotherhood Vertibird"
	desc = "A real useable, and working vertibird, maintained with luck, sweat, and ducktape. This one seems to be more focused toward combat, and marked with brotherhood markings."
	icon = 'icons/mecha/vb-vertibird-bos.dmi'
	icon_state = "vb"

/obj/mecha/combat/combatvehicle/vertibird/brotherhood/loaded
	equipment_profile = EQUIPMENT_VERTIBIRD_COMBAT

/obj/mecha/combat/combatvehicle/vertibird/brotherhood/loaded/Initialize()
	. = ..()
	max_ammo()

///Legion balloon

/obj/mecha/combat/combatvehicle/vertibird/balloon
	name = "\improper Legion Recon balloon"
	desc = "The legion maybe doesn't have fancy birds, but will still by the will of Caesar, get wings... And hot air."
	icon = 'icons/mecha/legionballoon.dmi'
	icon_state = "legionballoon"
	pixel_shift_profile = VEHICLE_PIXEL_SHIFT_BALLOON
	vehicle_driving_profile = HANDLING_PROFILE_BALLOON
	max_integrity = INTEGRITY_BALLOON
	deflect_chance = 0
	armor = ARMOR_VALUE_SALVAGE
	max_equip = 4
	stepsound = 'sound/f13ambience/ambigen_15.ogg'
	turnsound = 'sound/f13ambience/ambigen_15.ogg'

/obj/mecha/combat/combatvehicle/vertibird/balloon/obj_destruction()
	for(var/mob/M in src)
		to_chat(M, "<span class='brass'> The balloon is going to crash!</span>")
		M.dust()
	playsound(src, 'sound//f13machines//vertibird_crash.ogg', 100, 0)
	src.visible_message("<span class = 'userdanger'>The balloon's burner is about to blow!</span>")
	addtimer(CALLBACK(src,.proc/go_critical),breach_time)

/obj/mecha/combat/combatvehicle/vertibird/balloon/loaded
	equipment_profile = EQUIPMENT_BALLOON_COMBAT

/obj/mecha/combat/combatvehicle/vertibird/balloon/loaded/Initialize()
	. = ..()
	max_ammo()

//pickuptruck bos AND Kiana

/obj/mecha/combat/combatvehicle/pickuptruck
	equipment_profile = EQUIPMENT_VEHICLE_STRIPPED
	pixel_shift_profile = VEHICLE_PIXEL_SHIFT_GROUNDCAR
	vehicle_handling_profile = HANDLING_PROFILE_PICKUP
	max_integrity = INTEGRITY_CAR
	armor = ARMOR_VALUE_MEDIUM
	stepsound = 'sound/f13machines/buggy_loop.ogg'
	turnsound = 'sound/f13machines/buggy_loop.ogg'
	wreckage = /obj/structure/mecha_wreckage/buggy

/obj/mecha/combat/combatvehicle/pickuptruck/bos/armed
	name = "\improper BoS pickup truck with gunner"
	desc = "A old vehicle, running on fuel. Its a modified brotherhood truck, with the addition of a laser rifle at the back, manned by Paladin Kiana Davberg. Consumes more fuel and is more fragile."
	icon = 'icons/mecha/pickuptruck-gunbos.dmi'
	icon_state = "pickuptruck"
	max_equip = 4

/obj/mecha/combat/combatvehicle/pickuptruck/bos/armed
	equipment_profile = EQUIPMENT_VEHICLE_CAR_COMBAT_LASER

/obj/mecha/combat/combatvehicle/pickuptruck/bos/armed/loaded/Initialize()
	. = ..()
	max_ammo()

/obj/mecha/combat/combatvehicle/buggy
	equipment_profile = EQUIPMENT_VEHICLE_STRIPPED
	pixel_shift_profile = VEHICLE_PIXEL_SHIFT_GROUNDCAR
	vehicle_handling_profile = HANDLING_PROFILE_BUGGY
	max_integrity = INTEGRITY_BUGGY
	armor = ARMOR_VALUE_LIGHT
	stepsound = 'sound/f13machines/buggy_loop.ogg'
	turnsound = 'sound/f13machines/buggy_loop.ogg'
	wreckage = /obj/structure/mecha_wreckage/buggy

//Buggy Ranger AND RICO

/obj/mecha/combat/combatvehicle/buggy/rangerarmed
	name = "\improper Vet Ranger Buggy with gunner"
	desc = "A light vehicle, not very powerful or solid, running on fuel. This one has been recolored by the Rangers... And Ranger Rico ''Gunner'' Davberger is gonna shoot with his shotgun."
	icon = 'icons/mecha/buggyrangergun.dmi'
	icon_state = "rangergun"
	max_equip = 3

/obj/mecha/combat/combatvehicle/buggy/rangerarmed/loaded
	equipment_profile = EQUIPMENT_CAR_COMBAT

/obj/mecha/combat/combatvehicle/buggy/rangerarmed/loaded/Initialize()
	. = ..()
	max_ammo()

//Buggy Legion AND MESALLA

/obj/mecha/combat/combatvehicle/buggy/legionarmed
	name = "\improper Legion Chariot with gunner"
	desc = "A light vehicle, not very powerful or solid, running on fuel... Okay, that's a lie. It's actually run on power generated by the horse...The fuel is here to make sure that some component of the buggy half works. This one has been recolored by the Legion... And Prime Decanus Messala ''Gunner'' Davius is gonna shoot with his shotgun."
	icon = 'icons/mecha/buggy-legiongun.dmi'
	icon_state = "legiongun"
	pixel_shift_profile = VEHICLE_PIXEL_SHIFT_WAGON
	vehicle_handling_profile = HANDLING_PROFILE_WAGON
	equipment_profile = EQUIPMENT_VEHICLE_STRIPPED
	max_integrity = 250
	armor = ARMOR_VALUE_MEDIUM
	max_equip = 3
	stepsound = 'sound/effects/footstep/gallop2.ogg'
	turnsound = 'sound/effects/footstep/gallop1.ogg'
	wreckage = /obj/structure/mecha_wreckage/buggy

/obj/mecha/combat/combatvehicle/buggy/legionarmed/loaded
	equipment_profile = EQUIPMENT_CAR_COMBAT_SHOTGUN

/obj/mecha/combat/combatvehicle/buggy/legionarmed/loaded/Initialize()
	. = ..()
	max_ammo()
