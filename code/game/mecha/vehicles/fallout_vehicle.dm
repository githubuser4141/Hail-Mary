/obj/mecha // E P V
	var/vehicle_driving_profile = HANDLING_PROFILE_CAR // Generalised define that contains handling factors (speed, accel, drag, etc)
	var/equipment_profile = EQUIPMENT_CAR // Easy define to decide what gear it starts with
	var/pixel_shift_profile = VEHICLE_PIXEL_SHIFT_TRUCK

	var/acceleration_world_delay = 1
	var/moving_x = 0
	var/moving_y = 0
	var/last_moved_axis = 0 //1 = X axis, 2 = Y axis.
	var/list/speed = list(0,0) //The delay on movement in these directions.

// Vars set by defines

	var/max_speed = 3
	var/min_speed = 3
	var/acceleration = 1 // Amount of speed the vehicle gains when accelerating
	var/drag = 1 // Amount of speed the vehicle loses when not accelerating
	var/turning_speed_loss = 1 // Amount of speed the vehicle loses when turning
	var/turning_stability = 1 // Chance to roll over when executing a turn

// End of vars set by defines

	var/braking_mode = 0
	var/current_speed

	var/collision_sound = 'sound/effects/meteorimpact.ogg'

	stepsound = 'sound/mecha/mechstep.ogg'
	turnsound = 'sound/mecha/mechturn.ogg'
	attacksound = 'sound/weapons/punch4.ogg'
