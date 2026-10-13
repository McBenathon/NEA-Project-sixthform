extends Node2D

#all enemies preloaded
var dirt_enemy_scene = preload("res://Actors/Enemy1.tscn")
var ice_enemy_scene = preload("res://Actors/Enemy2.tscn")
var grass_enemy_scene = preload("res://Actors/Enemy3.tscn")
var fire_enemy_scene = preload("res://Actors/Enemy4.tscn")
var dirt_boss_scene = preload("res://Actors/Boss1.tscn")
var ice_boss_scene = preload("res://Actors/Boss2.tscn")
var grass_boss_scene = preload("res://Actors/Boss3.tscn")
var fire_boss_scene = preload("res://Actors/Boss4.tscn")

func _ready(): #generates the number of enemies and spawns them
	var number = RandomNumberGenerator.new()
	number.randomize()
	var enemy_number = number.randi_range(100, 150) #random number generator
	for x in range(enemy_number):
		generate_enemy1() #spawn function
		x += 1
	ActorClass.enemies_num = enemy_number #enemies remaining variable



func _process(delta):
	if ActorClass.enemies_num == 0:
		$Player.set_position(Vector2(1749, -35)) #moves player back to spawn when the boss spawns
		generate_boss() #boss spawn function
		ActorClass.enemies_num -= 1 #ensures the boss only spawns once
	if ActorClass.enemies_num == -2: #after boss killed
		$Player.set_position(Vector2(0, -1225)) #moves player to second level spawn
		$Timer.start(true) #starts enemy spawning timer
		$Timer.set_wait_time(5.0) #sets timer wait time
		ActorClass.enemies_num -= 1 #ensure the player isnt constantly being moved


func generate_enemy1(): #enemy spawning function level 1
	var number = RandomNumberGenerator.new() 
	number.randomize()
	var rand_x = number.randf_range(0, 3600) #coordinates possible for spawning enemies
	var rand_y = number.randf_range(0, 3600)
	if rand_y < (3600 / 2) and rand_x < (3600 / 2):
		var enemy1 = dirt_enemy_scene.instantiate()
		enemy1.set_position(Vector2(rand_x, rand_y)) #sets coordinates
		add_child(enemy1) #spawns
	elif rand_y >= (3600 / 2) and rand_x <= (3600 / 2):
		var enemy2 = ice_enemy_scene.instantiate()
		enemy2.set_position(Vector2(rand_x, rand_y)) #sets coordinates
		add_child(enemy2) #spawns
	elif rand_y <= (3600 / 2) and rand_x >= (3600 / 2):
		var enemy3 = grass_enemy_scene.instantiate()
		enemy3.set_position(Vector2(rand_x, rand_y)) #sets coordinates
		add_child(enemy3) #spawns
	elif rand_y >= (3600 / 2) and rand_x >= (3600 / 2):
		var enemy4 = fire_enemy_scene.instantiate()
		enemy4.set_position(Vector2(rand_x, rand_y)) #sets coordinates
		add_child(enemy4) #spawns

func generate_enemy2(): #enemy spawning function level 2
	var enemy1 = dirt_enemy_scene.instantiate()
	var enemy2 = ice_enemy_scene.instantiate()
	var enemy3 = grass_enemy_scene.instantiate()
	var enemy4 = fire_enemy_scene.instantiate()
	var Boss1 = dirt_boss_scene.instantiate()
	var Boss2 = ice_boss_scene.instantiate()
	var Boss3 = grass_boss_scene.instantiate()
	var Boss4 = fire_boss_scene.instantiate()
	var number = RandomNumberGenerator.new()
	number.randomize()
	var random_side = number.randf_range(0, 100) #generates which side the enemies spawn
	var random_boss = number.randi_range(0, 1000) #boss probability generator
	print(random_boss)
	if random_side <= 50: #sets coordinates for enemies if the side is left
		enemy1.set_position(Vector2(-24000, -1225))
		enemy2.set_position(Vector2(-24001, -1225))
		enemy3.set_position(Vector2(-24002, -1225))
		enemy4.set_position(Vector2(-24003, -1225))
		add_child(enemy1)
		add_child(enemy2)
		add_child(enemy3)
		add_child(enemy4)
	elif random_side > 50: #sets coordinates for enemies if the side is right
		enemy1.set_position(Vector2(24000, -1225))
		enemy2.set_position(Vector2(24001, -1225))
		enemy3.set_position(Vector2(24002, -1225))
		enemy4.set_position(Vector2(24003, -1225))
		add_child(enemy1)
		add_child(enemy2)
		add_child(enemy3)
		add_child(enemy4)
	if random_boss >= 800: #decides whether a boss is spawned
		var boss_type = number.randi_range(0, 100) #decides which boss is spawned
		if boss_type <= 25:
			Boss1.set_position(Vector2(-24000, -1225))
			add_child(Boss1) 
		elif boss_type > 25 and boss_type <= 50:
			Boss2.set_position(Vector2(24000, -1225))
			add_child(Boss2)
		elif boss_type > 50 and boss_type <= 75:
			Boss3.set_position(Vector2(-24000, -1225))
			add_child(Boss3)
		elif boss_type > 75 and boss_type <= 100:
			Boss4.set_position(Vector2(24000, -1225))
			add_child(Boss4)

func generate_boss(): #boss spawn function level 1
	var Boss1 = dirt_boss_scene.instantiate()
	var Boss2 = ice_boss_scene.instantiate()
	var Boss3 = grass_boss_scene.instantiate()
	var Boss4 = fire_boss_scene.instantiate()
	var number = RandomNumberGenerator.new()
	number.randomize()
	var boss_type = number.randi_range(0, 100) #decides which boss is spawned
	if boss_type <= 25:
		Boss1.set_position(Vector2(2000, -100)) #spawn coordinates
		add_child(Boss1)
	elif boss_type > 25 and boss_type <= 50:
		Boss2.set_position(Vector2(2000, -100)) #spawn coordinates
		add_child(Boss2)
	elif boss_type > 50 and boss_type <= 75:
		Boss3.set_position(Vector2(2000, -100)) #spawn coordinates
		add_child(Boss3)
	elif boss_type > 75 and boss_type <= 100:
		Boss4.set_position(Vector2(2000, -100)) #spawn coordinates
		add_child(Boss4)



func _on_Timer_timeout(): #timer
	for i in range(1): #only spawns one per timer timeout
		generate_enemy2() #enemy spawn function level 2
