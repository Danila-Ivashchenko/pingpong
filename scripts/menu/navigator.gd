extends Node

var mainGameScene: PackedScene = preload("res://scenes/main_game.tscn")
var menuScene: PackedScene = preload("res://scenes/main_manu.tscn")
var endGameScene: PackedScene = preload("res://scenes/end_game.tscn")

func _ready() -> void:
	NavigatorEventBus.navigated_to_game.connect(navigate_to_game)
	NavigatorEventBus.navigate_to_menu.connect(navigate_to_menu)
	NavigatorEventBus.navigate_to_end_game.connect(navigate_to_end_game)
	
func navigate_to_end_game(playerWone: int):
	clear()
	var end_game = endGameScene.instantiate() as EndGame
	end_game.setWinner(playerWone)
	add_child(end_game)
	
func navigate_to_menu():
	clear()
	var node = menuScene.instantiate()
	add_child(node)
	
func navigate_to_game(playerType, maxScore: int):
	clear()
	var mainGame = mainGameScene.instantiate() as MainGame
	print(playerType)
	mainGame.playerMode = playerType
	mainGame.maxScore = maxScore
	add_child(mainGame)
	
func clear():
	for child in get_children():
		remove_child(child)
		child.queue_free()
