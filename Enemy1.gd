extends Actor

func _physics_process(delta: float) -> void: #main function of enemy1 script
	var current_pos = $Skeleton3D.get_global_position() #returns position of the enemy
	var lastpos = Vector2.ZERO
	var direction = Vector2.ZERO 
	direction = get_direction()
	$AnimationPlayer.play("skeletonNormal") #plays the enemies animation
	velocity = calculate_move_velocity(velocity, speed, direction, current_pos) #enemy movement
	set_velocity(velocity)
	set_up_direction(FLOOR_NORMAL)
	move_and_slide()
	velocity = velocity
	




	
func get_direction(): #returns the direction the enemy needs to move using positon of the player
	return Vector2($"../Player".get_position().x - $Skeleton3D.get_global_position().x, 
	0)
	

func calculate_move_velocity( #calculates the velocity of the enemy and adds gravity
		linear_velocity: Vector2,
		speed: Vector2,
		direction: Vector2,
		current_pos: Vector2
	) -> Vector2:
	var out: = linear_velocity
	out.x = (speed.x - 298) * direction.x
	out.y += gravity * get_physics_process_delta_time()
	if current_pos.y < $"../Player".get_global_position().y and is_on_wall() == true:
		out.y += gravity * get_physics_process_delta_time()
	if current_pos.y > $"../Player".get_global_position().y and is_on_wall() == true:
		out.y = -100
	return out


func damage_calc(): #generates the amount of damage the enemy deals
	var damagecalc = RandomNumberGenerator.new() #random number generator
	damagecalc.randomize()
	var damage = damagecalc.randf_range(10.0, ActorClass.damagerange)
	return damage
	


func _on_Area2D_damage_area_entered(area): 
	damage = damage_calc()
	if enemyhealth > 0: #if the enemy has health the enemy takes damage
		enemyhealth -= damage
		$ProgressBar_enemy.value = enemyhealth
	if enemyhealth <= 0: #if the enemy doesnt have health the enemy dies
		ActorClass.kill_count += 1
		ActorClass.enemies_num -= 1
		ActorClass.heal = true #heals player
		queue_free()

