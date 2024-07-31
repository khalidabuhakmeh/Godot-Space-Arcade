extends CharacterBody2D
class_name Player

var explosion_scene = preload("res://scenes/Explosion.tscn")

const MARGIN: Vector2 = Vector2(30, 30)

@export var SPEED = 300.0
@export var BOOST_SPEED = 300.0
@export_range(0.0, 5.0) var BOOST_TIMER = 1.0:
	set(value): 
		$DashTimer.wait_time = value

@onready var glow = $Ship/Glow
@onready var dash_timer = $DashTimer
@onready var collision = $CollisionShape2D
@onready var ship = $Ship

var is_alive = true

@export var dashing = false:
	set(value):
		glow.visible = value
		dashing = value

func _ready() -> void:
	dashing = false
	dash_timer.connect("timeout", finished_dashing)

func _physics_process(_delta: float) -> void:

	if !is_alive:
		return

	var world = get_window().size
	
	if (dashing):
		velocity.x = BOOST_SPEED
		velocity.y = 0
	else:
		var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
		velocity = SPEED * direction
		

	move_and_slide()
	
	# Stay in this world
	position = Vector2(clampf(position.x, 0 + MARGIN.x, world.x - MARGIN.x), clampf(position.y, 0 + MARGIN.y, world.y - MARGIN.y))

func _input(event: InputEvent) -> void:
	if !dashing and event.is_action_pressed("ui_accept"):
		start_dashing()

func start_dashing() -> void:
	print("ship is dashing...")
	dashing = true
	dash_timer.start()
	glow.visible = true

func finished_dashing() -> void:
	print("ship stopped dashing...")
	dashing = false
	glow.visible = false
	dash_timer.stop()
	
func die() -> void:
	# you can only die once, right?
	if is_alive:
		is_alive = false
		var explosion = explosion_scene.instantiate()
		add_child(explosion)
		explosion.visible = true
		ship.visible = false	
		GameManager.game_over()
