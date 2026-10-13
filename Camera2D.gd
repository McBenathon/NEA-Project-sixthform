extends Camera2D


var speed = 5

func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("Right"):
		global_position.x  += speed
	if Input.is_action_pressed("Left"):
		global_position.x  -= speed
	if Input.is_action_pressed("jump"):
		global_position.y  -= speed
	if Input.is_action_pressed("down"):
		global_position.y  += speed
	
