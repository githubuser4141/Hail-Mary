/obj/mecha/fallout_vehicle
	var/max_speed = 5
	var/min_speed = 1
	var/acceleration = 1 // Amount of speed the vehicle gains when accelerating
	var/drag = 1 // Amount of speed the vehicle loses when not accelerating

	var/acceleration_delay = 1
	var/moving_x = 0
	var/moving_y = 0
	var/last_moved_axis = 0 //1 = X axis, 2 = Y axis.
	var/list/speed = list(0,0) //The delay on movement in these directions.

	var/braking_mode = 0

	var/collision_sound = 'sound/effects/meteorimpact.ogg'

	var/weaponized = FALSE

	stepsound = 'sound/mecha/mechstep.ogg'
	turnsound = 'sound/mecha/mechturn.ogg'
	attacksound = 'sound/weapons/punch4.ogg'
