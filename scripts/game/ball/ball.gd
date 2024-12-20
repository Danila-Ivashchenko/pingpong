extends CharacterBody2D
#
@onready var colision:CollisionShape2D = get_node("BallColisiton")

const MAX_BOUNCE: float = 5.0
const MAX_BOUNCE_VALUE: float = 5.0

var x_inp : float = 0.0
var y_inp : float = 0.0
var last_position: Vector2
var frame_ticker: int

var win_size : Vector2

const ACCEL : int = 50
const START_SPEED : int = 700
var speed : float

var direction : Vector2

var velosity = Vector2.ZERO


func _ready() -> void:
	win_size = get_viewport_rect().size
	
	
	
func new_ball():
	
	print("NEW BALL")
	
	position.x = 0
	position.y = 0
	
	speed = 0
	
	await get_tree().create_timer(1).timeout
	
	speed = START_SPEED
	
	
	
	direction = random_direction()
	print(direction)
	
func random_direction():
	var dir := Vector2()
	
	dir.x = [1, -1].pick_random()
	dir.y = randf_range(-0.5, 0.5)
	
	return dir.normalized()
	
func normalize_directions(x: int, y: int):
	if x != 0 and y != 0:
		x /= 1.4
		y /= 1.4
		
	return [x, y]
	
func new_direction(collider):
	var ball_y = position.y
	var pad_y = collider.position.y

	var dist = abs(ball_y - (pad_y + collider.p_height / 2))
	
	print("distance between ball and player:", dist)

	var new_dir := Vector2()
	
	if direction.x > 0:
		new_dir.x = -1
	else:
		new_dir.x = 1
		
	var bounce_val = (dist / (collider.p_height)) * MAX_BOUNCE
	
	print("bounce value:", bounce_val)
	
	var y_delta = -sign(direction.y)
	
	new_dir.y = y_delta * (abs(direction.y) + abs(bounce_val))
	
	print("prev direction:", direction)
	print("new direction:", new_dir)
	
	return new_dir.normalized()

func _physics_process(delta: float) -> void:	
	var mac = move_and_collide(direction * speed * delta)

	if mac != null:
		var collider = mac.get_collider()
		direction = direction.bounce(mac.get_normal())
		
		if collider is CharacterBody2D:
			direction.y += collider.velocity.y * 0.001
		
	var current_position = last_position
	last_position = position
	if frame_ticker % 10 == 0:
		frame_ticker = 0
		
		if last_position == current_position && current_position != Vector2(0.0, 0.0):
			print("ball is stack!!!")
			new_ball()
			
func normalize_velocity(x, y):
	
	if x != 0 and y != 0:
		x = x / 1.4
		y = x / 1.4
	
	return [x, y]

func _on_score_left_body_entered(body: Node2D) -> void:
	pass # Replace with function body.


func _on_score_right_body_entered(body: Node2D) -> void:
	pass # Replace with function body.
