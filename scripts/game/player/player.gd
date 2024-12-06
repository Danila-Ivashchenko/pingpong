class_name Player

extends CharacterBody2D

const PADDLE_SPEED : int = 20000


var win_heigth: int
var p_height: int

var y_inp: float = 0.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	win_heigth = get_viewport().size.y
	p_height = $ColorRect.get_size().y


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	velocity.y = y_inp * delta * PADDLE_SPEED
	
	move_and_slide()
	
	position.y = clamp(position.y, - win_heigth / 2, win_heigth / 2 - p_height)
	