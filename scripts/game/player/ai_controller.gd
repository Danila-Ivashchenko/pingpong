extends Node

@onready var player:Player = get_node("Player")

var ball_pos : Vector2
var dist : int
var move_by : int
var space_delta = 0
var is_ai: bool = true

func _ready() -> void:
	pass
	
func _ai_process(delta: float):
	ball_pos = $"../BallController/Ball".position
	var ball_speed = $"../BallController/Ball".speed
	var ball_dir = $"../BallController/Ball".direction[1]
	
	var ball_y = ball_pos.y
	var ball_x = ball_pos.x
	
	var pos_x = player.position.x
	
	var dist = pos_x - ball_x
	var t = dist / ball_speed
	
	#print(dist)
	
	var pred_y = ball_y + t * ball_speed * ball_dir
	
	var player_y = player.position.y
	var dir = 0
	
	var win_heigth = get_viewport().size.y
	
	
	#print(player_y - pred_y)
	
	if pred_y < 0:
		var pred_t_to_zero = t - ball_y / (ball_speed * ball_dir)
		
		var t_after_zero = t - pred_t_to_zero
		#print(t_after_zero)
		
		var non_zero_y = t_after_zero * ball_speed * ball_dir
		
		#print(non_zero_y, pred_y)
		var new_pred_y = ball_y + (t - pred_t_to_zero)* ball_speed * ball_dir
		#print(new_pred_y)
	
	#while pred_y < 0 or pred_y > win_heigth:
		#print(pred_y)
		#if pred_y < 0:
			#pred_y = -pred_y
		#elif pred_y > win_heigth:
			#pred_y = win_heigth - (win_heigth - pred_y)
			
	#print(abs(player_y - pred_y))
	
	var treshhold_position = randf_range(-player.p_height / 3, 0.0)
	
	if abs(player_y - pred_y) > player.p_height / 2 + treshhold_position:
		#print("ball position:", ball_y)
		#print("player position:", player_y)
		
		if player_y > pred_y :
			dir = -1
		elif player_y < pred_y:
			dir = 1
	
	#print(ball_pos)
	
	player.y_inp = dir
	
func _player_process(delta: float):
	print(Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up"))
	player.y_inp = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if is_ai:
		_ai_process(delta)
	else:
		_player_process(delta)
		
