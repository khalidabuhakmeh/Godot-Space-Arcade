extends Node

@export var score = 0
@export var game_speed = 1.0

signal score_changed(score: String)

func increment_score():
	score += 100
	if score % 1000 == 0:
		game_speed += .25
		print("current gamespeed: " + str(game_speed))
	score_changed.emit(str(score))
	print("current score: " + str(score))

func game_over():
	var game_over_screen = get_tree().get_first_node_in_group("game_over")
	game_over_screen.visible = true
	print("Game Over")
	
func restart() -> void:
	score = 0
	game_speed = 1.0
	score_changed.emit(str(score))
	get_tree().reload_current_scene()
	print("restart")

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		restart()
