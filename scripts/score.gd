extends Label

@export var prefix := ""

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameManager.score_changed.connect(_update_score)
	text = prefix + str(GameManager.score)
	pass # Replace with function body.

func _update_score(score: String):
	text = prefix + score
