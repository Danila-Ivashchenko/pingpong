extends CanvasLayer


const MAX_GAME_SCORE_LIMIT = 20
const MIN_GAME_SCORE_LIMIT = 1

@export var score_label: Label

func _get_max_score():
	return int(score_label.text)

func _on_start_game_but_pressed() -> void:
	print("Start")
	NavigatorEventBus.navigated_to_game.emit(MainGame.PlayerMode.AI, _get_max_score())


func _on_exit_but_pressed() -> void:
	get_tree().quit()


func _on_start_pvp_game_but_pressed() -> void:
	print("Start PvP")
	NavigatorEventBus.navigated_to_game.emit(MainGame.PlayerMode.PVP, _get_max_score())

func _on_max_score_up_pressed() -> void:
	update_score(1)
	
func _on_max_score_down_pressed() -> void:
	update_score(-1)
	
func update_score(delta: int) -> void:
	var current_score: int 
	
	current_score = int(score_label.text)
	
	var new_score = current_score + delta
	
	if  new_score >= MIN_GAME_SCORE_LIMIT and new_score <= MAX_GAME_SCORE_LIMIT:
		current_score += delta
		score_label.text = str(current_score)
