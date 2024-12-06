extends CharacterBody2D
#
#

@onready var colision:CollisionShape2D = get_node("BallColisiton")

const MAX_BOUNCE: float = 5.0

var x_inp : float = 0.0
var y_inp : float = 0.0

var win_size : Vector2

const ACCEL : int = 50
const START_SPEED : int = 600
var speed : float

var direction : Vector2

var velosity = Vector2.ZERO


func _ready() -> void:
	win_size = get_viewport_rect().size
	
	
	
func new_ball():
	print("NEW BALL")
	
	position.x = 0
	position.y = 0
	
	speed = START_SPEED
	
	direction = random_direction()
	print(direction)
	
func random_direction():
	var dir := Vector2()
	
	dir.x = [1, -1].pick_random()
	dir.y = randf_range(-1, 1)
	
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
	
	new_dir.y = (dist / (collider.p_height)) * MAX_BOUNCE
	
	print("new direction:", new_dir)
	
	return new_dir.normalized()

func _physics_process_(delta: float) -> void:	
	var mac = move_and_collide(direction * speed * delta)

	if mac != null:
		var collider = mac.get_collider()
		
		if collider.get_class() == 'CharacterBody2D':
			direction = new_direction(collider)
		else:
			direction = direction.bounce(mac.get_normal())
			
			
func normalize_velocity(x, y):
	
	if x != 0 and y != 0:
		x = x / 1.4
		y = x / 1.4
	
	return [x, y]

func _physics_process_old(delta: float) -> void:
	
	var normalized_inps = normalize_velocity(x_inp, y_inp)
	
	var delta_bounce = 0
	
	velocity.x = normalized_inps[0] * (delta + speed)
	velocity.y = normalized_inps[1] * (delta + speed)
	
	var mac = move_and_collide(direction * speed * delta)
	
	if mac != null:
		var collider = mac.get_collider()
		
		if collider.get_class() == 'CharacterBody2D':
			#print("Player collider")
			#var player_mid_y = collider.position.y
			#var ball_y = position.y
			#
			#delta_bounce = ((player_mid_y - ball_y) / (collider.p_height / 2)) * MAX_BOUNCE
			direction = new_direction(collider)
			
			direction = direction.bounce(direction)
			
		print(delta_bounce)
			
		var normal = mac.get_normal()
		
		if normal.y != 0:
			direction.y *= -1
			direction.x += randf_range(-0.1, 0.1) + delta_bounce
			
		if normal.x != 0:
			direction.x *= -1
			direction.y += randf_range(-0.1, 0.1)

func _physics_process(delta: float) -> void:
	
	
	var k_collision = move_and_collide(direction * delta * speed)
	
	if k_collision != null:
		print("bounce")
		
		#todo add bounce sound
		
		var collider = k_collision.get_collider()
		
		if collider.get_class() == 'CharacterBody2D':
			direction = new_direction(collider)
			direction = direction.bounce(direction)
			
		
		var normal = k_collision.get_normal()
		
		if normal.y != 0:
			direction.y *= -1
			direction.x += randf_range(-0.1, 0.1)
			
		if normal.x != 0:
			direction.x *= -1
			direction.y += randf_range(-0.1, 0.1)
	
	

func _on_score_left_body_entered(body: Node2D) -> void:
	pass # Replace with function body.


func _on_score_right_body_entered(body: Node2D) -> void:
	pass # Replace with function body.
