extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.

var score := [0, 0]

func _process(delta: float) -> void:
	pass
	
func _on_score_left_body_entered(body: Node2D) -> void:
	#todo add goal sound
	score[1] += 1
	print("goal to left")
	$BallController/Ball.new_ball()
	$Hud/Player2Score.text = str(score[1])

func _on_score_right_body_entered(body: Node2D) -> void:
	#todo add goal sound
	score[0] += 1
	print("goal to right")
	$BallController/Ball.new_ball()
	$Hud/Player1Score.text = str(score[0])

func _on_ball_timer_timeout() -> void:
	#$"../BallController/Ball".new_ball()
	$BallController/Ball.new_ball()
