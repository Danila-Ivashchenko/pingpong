extends Node

@onready var player:Player = get_node("Player")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	player.y_inp = Input.get_action_strength("ui_down_extra") - Input.get_action_strength("ui_up_extra")
