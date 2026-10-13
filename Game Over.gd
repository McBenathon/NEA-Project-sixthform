extends Node2D

func _on_Buttonrestart_button_down():
	get_tree().change_scene_to_file("res://Level/Main.tscn") #changes the scene to the start of the game
	ActorClass.kill_count = 0
	ActorClass.upgrade_lvl = 0
	ActorClass.damagerange = 20
	#these reset all the variables so the game can be started from new again
	
func _on_Buttonexit_button_down():
	get_tree().quit() #exits the game
