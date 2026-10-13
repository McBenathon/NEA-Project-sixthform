extends Node2D

func _on_Timer_timeout():
	get_tree().change_scene_to_file("res://Level/Main.tscn") #changes scene to start of level 1
