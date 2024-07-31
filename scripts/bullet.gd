extends Area2D
class_name Bullet

@onready var collision = $CollisionShape2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	
func disable() -> void:
	collision.disabled = true
	visible = false
	
func enable() -> void:
	collision.disabled = false
	visible = true
