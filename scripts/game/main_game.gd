class_name MainGame extends Sprite2D

enum PlayerMode {
	AI,
	PVP
}

var score: Array[int] = [0, 0]
var playerMode: PlayerMode = PlayerMode.PVP
var maxScore: int = 1023

func _ready() -> void:
	$Player2Controller.is_ai = playerMode == PlayerMode.AI

func _process(delta: float) -> void:
	pass
	
func _on_score_left_body_entered(body: Node2D) -> void:
	#todo add goal sound
	score[1] += 1
	print("goal to left")
	$BallController/Ball.new_ball()
	$Hud/Player2Score.text = str(score[1])
	_check_win()

func _on_score_right_body_entered(body: Node2D) -> void:
	#todo add goal sound
	score[0] += 1
	$BallController/Ball.new_ball()
	$Hud/Player1Score.text = str(score[0])
	_check_win()
	
func _check_win():
	if score[0] >= maxScore:
		NavigatorEventBus.navigate_to_end_game.emit(1)
	if score[1] >= maxScore:
		NavigatorEventBus.navigate_to_end_game.emit(2)

func _on_ball_timer_timeout() -> void:
	#$"../BallController/Ball".new_ball()
	$BallController/Ball.new_ball()
