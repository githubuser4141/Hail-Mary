/obj/mecha/fallout_vehicle/proc/drag_slowdown(var/index,var/slowdown_amount = drag)
	if(speed[index] > 0)
		speed[index] = max(speed[index] - drag,0)
	else
		speed[index] = min(speed[index] + drag,0)

/obj/mecha/fallout_vehicle/proc/movement_loop(var/speed_index_target = 1)
	var/noprocstart = 0
	if(moving_x || moving_y)
		noprocstart = 1
	switch(speed_index_target)
		if(1)
			moving_x = 1
		if(2)
			moving_y = 1
	if(noprocstart)
		return
	spawn()
		while (moving_x || moving_y)
			sleep(max(min_speed - (abs(speed[1]) + abs(speed[2]) ),max_speed))
			if(speed[1] == 0)
				moving_x = 0
			else
				if(speed[1] > 0)
					last_move = EAST
					. = Move(get_step(loc,EAST),EAST)
				else
					last_move = WEST
					. = Move(get_step(loc,WEST),WEST)

			if(speed[2] == 0)
				moving_y = 0
			else
				if(speed[2] > 0)
					last_move = NORTH
					. = Move(get_step(loc,NORTH),NORTH)
				else
					last_move = SOUTH
					. = Move(get_step(loc,SOUTH),SOUTH)
			var/list/index_list = list(1,2)
			for(var/index in index_list)
				if(last_moved_axis == index)
					continue
				drag_slowdown(index)
			if(world.time >= acceleration_delay)
				last_moved_axis = 0

/obj/mecha/fallout_vehicle/domove(direction)
	if(world.time < acceleration_delay)
		return 0
	acceleration_delay = world.time + max(max_speed, min_speed - (abs(speed[1]) + abs(speed[2])))

	if(!occupant)
		return -1

	if(!(direction in list(NORTH,SOUTH,EAST,WEST)))
		var/dirturn = 45
		if(prob(50))
			dirturn = -45
		direction = turn(direction,dirturn)
	switch(direction)
		if(NORTH)
			last_moved_axis = 2
			speed[2] = min(speed[2] + acceleration,min_speed)

		if(SOUTH)
			last_moved_axis = 2
			speed[2] = max(speed[2] - acceleration,-min_speed)

		if(EAST)
			last_moved_axis = 1
			speed[1] = min(speed[1] + acceleration,min_speed)

		if(WEST)
			last_moved_axis = 1
			speed[1] = max(speed[1] - acceleration,-min_speed)
	if(last_moved_axis == 1)
		drag_slowdown(2,acceleration)
	else
		drag_slowdown(1,acceleration)
	if(braking_mode == 1) //If we're braking, we don't get the leeway in movement.
		last_moved_axis = 0

	if(speed[1] != 0 && !moving_x)
		movement_loop(1)
	else if(speed[2] != 0 && !moving_y)
		movement_loop(2)
	return 1

/obj/mecha/fallout_vehicle/proc/collide_with_obstacle(var/atom/obstacle)
	if(istype(obstacle,/mob/living))
		var/mob/living/hit_mob = obstacle
		playsound(loc,collision_sound,100,0,4)
		hit_mob.Paralyze(1)
		hit_mob.take_overall_damage(force)
	else
		acceleration_delay = world.time + min_speed
		if(last_move == EAST || last_move == WEST)
			moving_x = 0
			speed[1] = 0
		else if(last_move == NORTH || last_move == SOUTH)
			speed[2] = 0
			moving_y = 0
		last_moved_axis = 0
	visible_message("<span class = 'notice'>[src] collides wth [obstacle]</span>")

/*
/obj/mecha/fallout_vehicle/proc/do_flip(var/reason = "")
	if(occupant && !enclosed && prob(75))
		occupant_fall()
	completely_disabled = 1
	vehicle_flipped = 1
	flip_vehicle_sprite()

/obj/mecha/fallout_vehicle/proc/flip_vehicle_sprite()

*/