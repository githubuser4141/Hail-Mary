/// Subtype for vision-granting equipments
/obj/item/mecha_parts/mecha_equipment/vision
	name = "vision trait giver subtype module for exosuits"
	desc = "you shouldn't be seeing this."
	selectable = FALSE
	var/list/vision_traits
	equip_type = EQUIP_MISC

/obj/item/mecha_parts/mecha_equipment/vision/attach(obj/mecha/M)
	. = ..()
	M.remove_vision()
	M.vision_modes |= vision_traits
	M.grant_vision()

/obj/item/mecha_parts/mecha_equipment/vision/detach(atom/moveto)
	chassis.remove_vision()
	chassis.vision_modes -= vision_traits
	. = ..()
	chassis.grant_vision()

/obj/item/mecha_parts/mecha_equipment/vision/meson_scanner
	name = "vehicle meson scanner"
	desc = "A vehicle-mounted viewport that integrates night vision and a mesonic scanner."
	icon_state = "mecha_meson"
	vision_traits = list(TRAIT_MESON_VISION, TRAIT_NIGHT_VISION)

/obj/item/mecha_parts/mecha_equipment/vision/thermal_scanner
	name = "vehicle thermal scanner"
	desc = "A vehicle-mounted viewport that integrates night vision and a thermal camera."
	icon_state = "mecha_thermal"
	vision_traits = list(TRAIT_THERMAL_VISION, TRAIT_NIGHT_VISION)
