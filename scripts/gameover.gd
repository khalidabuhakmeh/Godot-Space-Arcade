extends Control

@onready var final_score = $VBoxContainer/FinalScore

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	visible = false
	pass # Replace with function body.

func _on_button_pressed() -> void:
	GameManager.restart()
