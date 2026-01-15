#define INTEGRITY_BUGGY 200
#define INTEGRITY_CAR 300
#define INTEGRITY_TRUCK 500
#define INTEGRITY_ARMORED_CAR 600
#define INTEGRITY_VERTIBIRD 300
#define INTEGRITY_BALLOON 200

#define VEHICLE_PIXEL_SHIFT_WAGON list("pixel_x" = -18, "pixel_y" = -0)
#define VEHICLE_PIXEL_SHIFT_GROUNDCAR list("pixel_x" = -20, "pixel_y" = -8)
#define VEHICLE_PIXEL_SHIFT_VERTIBIRD list("pixel_x" = -138, "pixel_y" = -138)
#define VEHICLE_PIXEL_SHIFT_BALLOON list("pixel_x" = -138, "pixel_y" = 0)

#define HANDLING_PROFILE_BUGGY list(\
	"min_speed" = 3,\
	"max_speed" = 0.8,\
	"drag" = 1,\
	"acceleration" = 1,\
	"turning_speed_loss" = 0.5,\
	"turning_stability" = 2,\
	"step_energy_drain" = 1,\
	"normal_step_energy_drain" = 1\
	)

#define HANDLING_PROFILE_CAR list(\
	"min_speed" = 4,\
	"max_speed" = 1,\
	"drag" = 0.8,\
	"acceleration" = 0.8,\
	"turning_speed_loss" = 0.7,\
	"turning_stability" = 1,\
	"step_energy_drain" = 0.5,\
	"normal_step_energy_drain" = 0.5\
	)

#define HANDLING_PROFILE_PICKUP list(\
	"min_speed" = 4.5,\
	"max_speed" = 1.5,\
	"drag" = 0.7,\
	"acceleration" = 0.7,\
	"turning_speed_loss" = 0.7,\
	"turning_stability" = 2,\
	"step_energy_drain" = 1,\
	"normal_step_energy_drain" = 1\
	)

#define HANDLING_PROFILE_TRUCK list(\
	"min_speed" = 5,\
	"max_speed" = 1.8,\
	"drag" = 0.7,\
	"acceleration" = 0.5,\
	"turning_speed_loss" = 1,\
	"turning_stability" = 3,\
	"step_energy_drain" = 1.5,\
	"normal_step_energy_drain" = 1.5\
	)

#define HANDLING_PROFILE_ARMORED list(\
	"min_speed" = 6,\
	"max_speed" = 2.2,\
	"drag" = 1,\
	"acceleration" = 0.5,\
	"turning_speed_loss" = 1,\
	"turning_stability" = 2,\
	"step_energy_drain" = 2,\
	"normal_step_energy_drain" = 2\
	)

#define HANDLING_PROFILE_EXOSUIT list(\
	"min_speed" = 3,\
	"max_speed" = 2,\
	"drag" = 1.5,\
	"acceleration" = 1,\
	"turning_speed_loss" = 1,\
	"turning_stability" = 3,\
	"step_energy_drain" = 5,\
	"normal_step_energy_drain" = 5\
	)

#define HANDLING_PROFILE_WAGON list(\
	"min_speed" = 3,\
	"max_speed" = 1.2,\
	"drag" = 1.5,\
	"acceleration" = 0.8,\
	"turning_speed_loss" = 0.8,\
	"turning_stability" = 2,\
	"step_energy_drain" = 0.2,\
	"normal_step_energy_drain" = 0.2\
	)

#define HANDLING_PROFILE_VERTIBIRD list(\
	"min_speed" = 3,\
	"max_speed" = 0.8,\
	"drag" = 0.3,\
	"acceleration" = 1.5,\
	"turning_speed_loss" = 0.5,\
	"turning_stability" = 1,\
	"step_energy_drain" = 4,\
	"normal_step_energy_drain" = 4\
	)

#define HANDLING_PROFILE_BALLOON list(\
	"min_speed" = 5,\
	"max_speed" = 2,\
	"drag" = 0.1,\
	"acceleration" = 0.5,\
	"turning_speed_loss" = 0.2,\
	"turning_stability" = 1,\
	"step_energy_drain" = 0.1,\
	"normal_step_energy_drain" = 0.1\
	)

#define EQUIPMENT_VEHICLE_STRIPPED list(\
	/obj/item/mecha_parts/mecha_equipment/seat = 1\
	)

#define EQUIPMENT_VERTIBIRD_CARGO list(\
	/obj/item/mecha_parts/mecha_equipment/seat = 6,\
	/obj/item/mecha_parts/mecha_equipment/trunk = 1\
	)

#define EQUIPMENT_VERTIBIRD_COMBAT list(\
	/obj/item/mecha_parts/mecha_equipment/seat = 4,\
	/obj/item/mecha_parts/mecha_equipment/weapon/ballistic/lmg/auto,\
	/obj/item/mecha_parts/mecha_equipment/weapon/ballistic/missile_rack\
	)

#define EQUIPMENT_BALLOON_COMBAT list(\
	/obj/item/mecha_parts/mecha_equipment/seat = 2,\
	/obj/item/mecha_parts/mecha_equipment/weapon/ballistic/lmg/auto\
	)

#define EQUIPMENT_CAR_COMBAT_SHOTGUN list(\
	/obj/item/mecha_parts/mecha_equipment/seat = 4,\
	/obj/item/mecha_parts/mecha_equipment/weapon/ballistic/scattershot\
	)

#define EQUIPMENT_CAR_COMBAT_RIFLE list(\
	/obj/item/mecha_parts/mecha_equipment/seat = 3,\
	/obj/item/mecha_parts/mecha_equipment/weapon/ballistic/lmg/auto\
	)

#define EQUIPMENT_TRUCK_CARGO list(\
	/obj/item/mecha_parts/mecha_equipment/seat = 8,\
	/obj/item/mecha_parts/mecha_equipment/trunk = 1\
	)
