extends Area2D

@export var tilemap_path: NodePath

var is_swinging = true

var tilemap : TileMap

func _ready() -> void:
	tilemap = get_node(tilemap_path)
	
	
func _physics_process(delta: float) -> void:
	
	look_at(get_global_mouse_position()) #sword always looking where the mouse is
	if Input.is_action_pressed("left_MB"):
		var tile : Vector2i = tilemap.local_to_map($CollisionPolygon2D.global_position)
		var ID = tilemap.get_cell(int(tile.x), int(tile.y)) # returns the cell index
		if ID != -1 and ID < 5:
			tilemap.set_cell(1, tile, -1) #deletes block
	
