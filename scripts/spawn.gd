extends Path2D

@onready var spawnpoint = $PathFollow2D
@export var spawnpoint_speed = 200
@export var enemy_speed = 200
@export var player_target: Player

@export var horizontal_spacing = 100
@export var max_enemies_per_row = 3

@export var enemy_textures: Array[Texture2D];
var colors: Array[Color] = [
	Color.CORAL,
	Color.DEEP_SKY_BLUE,
	Color.LIGHT_GREEN,
	Color.PLUM,
	Color.FLORAL_WHITE
]

@onready var original_wait_time = $Timer.wait_time

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	spawnpoint.progress += delta * spawnpoint_speed

func _spawn_enemy() -> void:
	var enemy_scene = preload("res://scenes/enemy.tscn")	
	var texture = enemy_textures.pick_random()
	var color = colors.pick_random()
	for i in randi_range(1, max_enemies_per_row):
		var enemy = enemy_scene.instantiate()
		enemy.position = spawnpoint.position
		enemy.position.x += i * horizontal_spacing
		enemy.speed = enemy_speed
		enemy.texture = texture
		enemy.color = color
		enemy.add_to_group("enemy")
		enemy.target = player_target
		add_child(enemy)
		
	# vary the time so it's not predictable
	$Timer.wait_time = original_wait_time + randf_range(-.5, .5)
		
	pass # Replace with function body.
