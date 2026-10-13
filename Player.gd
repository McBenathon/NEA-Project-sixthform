extends Actor

func jump(): #double jump function
	var jump = 1.0
	if is_on_floor() and jump_count != 0: #resets the jump count if the player is on floor
		jump_count = 0 
	if jump_count<jump_max: #if space pressed in air and this is met it will jump again
		if Input.is_action_just_pressed("jump"):
			jump = -1.0
			jump_count += 1 #adds one to jump count
		else:
			jump = 1.0
	return jump



func _physics_process(delta: float) -> void: #main function
	var is_jump_interrupted: = Input.is_action_just_released("jump") and velocity.y < 0.0
	var jump = jump()
	var direction: = get_direction(jump)
	velocity = calculate_move_velocity(velocity, direction, speed, is_jump_interrupted) #calculates
	set_velocity(velocity)
	set_up_direction(FLOOR_NORMAL)
	move_and_slide()
	velocity = velocity #movement function                 the movement
	var sprint = is_sprint()
	if velocity.x == 0:
		move = false 
	elif Input.is_action_pressed("Right"): #if button D pressed
		$AnimationPlayer.play("run") #plays animation
		$player.scale.x = 2 #sets the direction the player is looking (right)
		move = true
	elif Input.is_action_pressed("Left"): #if button A pressed
		$AnimationPlayer.play("run") #plays animation
		$player.scale.x = -2 #sets the direction the player is looking (left)
		move = true
	elif Input.is_action_pressed("jump") and Input.is_action_pressed("Left"):
		move = true
	elif Input.is_action_pressed("jump") and Input.is_action_pressed("Right"):
		move = true
	if Input.is_action_pressed("sprint") and move == true: #inceases the speed of the player
		speed.x = 400
	else:
		speed.x = 200 #normal speed
	if playerhealth > 100: #resets health to 100 if it goes above from healing
		playerhealth = 100
	if ActorClass.heal == true: #heals player by 5
		playerhealth += 5
		ActorClass.heal = false #resets the heal variable
	$ProgressBar.value = playerhealth #updates healthbar of player



func get_direction(jump) -> Vector2: #direction calculator based on button input strength
	return Vector2(
		Input.get_action_strength("Right") - Input.get_action_strength("Left"),
		jump
	)


func calculate_move_velocity( #calculates the velocity of the player in x and y directions
		linear_velocity: Vector2,
		direction: Vector2,
		speed: Vector2,
		is_jump_interrupted: bool
	) -> Vector2:
	var out: = linear_velocity
	out.x = speed.x * direction.x #x velocity
	out.y += gravity * get_physics_process_delta_time() #adds gravity
	if direction.y == -1.0:
		out.y = speed.y * direction.y
	if is_jump_interrupted:
		out.y = 0.0
	return out


func is_sprint():
	return Input.get_action_strength("sprint") #returns strength of shift key


func damage_calc(): #damage calculator for enemies against the player
	var damagecalc = RandomNumberGenerator.new()
	damagecalc.randomize()
	var enemy_damage = damagecalc.randf_range(5.0, enemy_damagerange) #damage range varies depending on
	return enemy_damage                                               #which enemy hits the player
	

func _on_Area2D_damage_area_entered(area): #when the player enters the enemies hitbox
	var enemy_damage = damage_calc()
	if playerhealth > 0:  
		playerhealth -= enemy_damage
	if playerhealth <= 0:
		get_tree().change_scene_to_file("res://Level/Game Over.tscn") #game over screen
	



func _on_Button_button_down(): #sword upgrade requirements
	if ActorClass.kill_count >= 20:
		ActorClass.damagerange = 30
		ActorClass.upgrade_lvl = 1
	if ActorClass.kill_count >= 40:
		ActorClass.damagerange = 40
		ActorClass.upgrade_lvl = 2
	if ActorClass.kill_count >= 60:
		ActorClass.damagerange = 50
		ActorClass.upgrade_lvl = 3
	if ActorClass.kill_count >= 80:
		ActorClass.damagerange = 55
		ActorClass.upgrade_lvl = 4
	if ActorClass.kill_count >= 100:
		ActorClass.damagerange = 60
		ActorClass.upgrade_lvl = 5
