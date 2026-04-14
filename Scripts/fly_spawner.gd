extends Node2D

@export var enabled : bool = true
@export var enable_timer : float = 0 # time in seconds before flies are allowed to spawn
@onready var spawn_timer : Timer = $SpawnTimer
@onready var fly = preload("res://Scenes/fly.tscn")   # loads flys to be spawned
@onready var starting_position : Vector2 = global_position
@export_enum ("none", "up/down", "left/right") var movement_type : String = "none" # sets which movement_direction spawners move
@onready var movement_direction : int = 1
var fly_speed : float = 2
const SPEED : int = 3 # speed spawners move offscreen (movement makes it harder to tell where flies are coming from)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if enable_timer > 0:
		await get_tree().create_timer(enable_timer).timeout # wait to activate before spawning flies
		enabled = true
	spawn_timer.start()

func _process(_delta: float) -> void:
	match movement_type:
		"up/down":
			# if position moves past certain height, change movement_direction
			if global_position.y < starting_position.y - 100: # too high, start moving down
				movement_direction = 1
			elif position.y > starting_position.y + 100:      # too low, start moving up
				movement_direction = -1
			global_position.y += SPEED * movement_direction   # always moving
		# similar setup for left/right
		"left/right":
			if global_position.x < starting_position.x - 100: # too high, start moving down
				movement_direction = 1
			elif position.x > starting_position.x + 100:      # too low, start moving up
				movement_direction = -1
			global_position.x += SPEED * movement_direction   # always moving
		_:
			pass

# spawn flies when SpawnTimer runs out
func _on_spawn_timer_timeout() -> void:
	if enabled:
		var instance = fly.instantiate()     # create fly object
		add_child.call_deferred(instance)    # add fly to current scene
		instance.global_position = global_position # spawn fly at current position of spawner
		instance.top_level = true                  # stops spawned flies from moving whenever the spawner moves
		if fly_speed != instance.speed:
			instance.speed = fly_speed             # changes speed of flys if speedup timer has ended
