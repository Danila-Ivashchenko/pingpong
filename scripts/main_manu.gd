extends CanvasLayer

func _on_start_game_but_pressed() -> void:
	print("Start")
	get_tree().change_scene_to_file("res://scenes/game.tscn")


func _on_exit_but_pressed() -> void:
	get_tree().quit()
