class_name EndGame extends Node2D

func _ready() -> void:
	pass # Replace with function body.

func setWinner(playerWon: int) -> void:
	var playerWonText = "Player " + str(playerWon) + " won"
	
	$CanvasLayer/VBoxContainer/Label.text = playerWonText
	
func exit_to_menu() -> void:
	NavigatorEventBus.navigate_to_menu.emit()

# Called when the node enters the scene tree for the first time.



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_pressed() -> void:
	exit_to_menu()
