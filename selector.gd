extends Sprite2D

@export var snap_size_x: int = 18
@export var snap_size_y: int = 18

var mousepos: Vector2 = Vector2.ZERO

func _physics_process(delta: float) -> void:
	update_pos_snapped()
	
func update_pos_snapped():
	mousepos = Vector2(int(get_global_mouse_position().x / snap_size_x), # so that snaps perfectly
						int(get_global_mouse_position().y / snap_size_y) # to block size
	)
	global_position = mousepos * snap_size_x 
