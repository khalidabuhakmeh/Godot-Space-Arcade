extends Node2D
class_name Enemy

var explosion_scene = preload("res://scenes/Explosion2.tscn")

@export var speed = 200
@onready var world = get_window().size

@onready var ship = $Ship
@onready var bullet = $Bullet

@export var target: Player

@export var texture: Texture2D:
	set(value):
		$Ship/Sprite2D.texture = value
		
@export var color: Color:
	set(value):
		$Ship/Sprite2D.modulate = value

@onready var collisions: Array[CollisionShape2D] = [
	$Bullet/CollisionShape2D,
	$Ship/CollisionShape2D
]

var is_dead = false
var initial_position_y;
var total_time = 0.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	bullet.disable()
	ship.visible = true
	initial_position_y = bullet.global_position.y
	
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	total_time += delta
	# enemy is still flying
	var current_speed = speed * GameManager.game_speed * delta
	
	if (global_position.x > 0):
		global_position.x -= current_speed
	else:
		if (ship.visible):
			ship.visible = false
		bullet.enable()
		bullet.global_position.x += current_speed * 1.5
		# wave function: sin(time * frequency/width) * amplitude/height + offset
		bullet.global_position.y = sin(total_time * 10) * 50 + initial_position_y

	# bullet traveled all the way back
	if (bullet.visible and bullet.global_position.x > world.x + 400):
		queue_free()

func explode() -> void:
	is_dead = true
	var explosion = explosion_scene.instantiate()
	explosion.has_finished.connect(queue_free)
	add_child(explosion)
	ship.visible = false
	bullet.visible = false	
	explosion.visible = true
	GameManager.increment_score()

func _on_ship_body_entered(body: Node2D) -> void:
	if is_dead:
		return
		
	if body == target:
		if target.dashing:
			explode()
		else:
			target.die()

func _on_bullet_body_entered(body: Node2D) -> void:
	if is_dead:
		return
		
	if body == target and !target.dashing:
		target.die()
