extends Node2D



func _on_Buttonexit_button_down():
	get_tree().quit() #exits the game


func _on_Button_play_button_down():
	get_tree().change_scene_to_file("res://Level/Loading_screen.tscn") #changes scene to the loading screen




