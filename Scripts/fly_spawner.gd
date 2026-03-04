extends Node2D

@export var enabled : bool = true
@onready var spawn_timer : Timer = $SpawnTimer
@onready var fly = preload("res://Scenes/fly.tscn")   # loads flys to be spawned
@export_enum ("none", "up/down", "left/right") var movement_direction : String = "none" # sets which direction spawners move
#@onready var current_scene = get_tree().get_root() # get current level so spawner can add flies to it
#@onready var spawn_position : Vector2 = global_position

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawn_timer.start() # Replace with function body.

# spawn flies when SpawnTimer runs out
func _on_spawn_timer_timeout() -> void:
	if enabled:
		var instance = fly.instantiate() # create fly object
		#instance.position = global_position # place fly at spawner's global position
		add_child.call_deferred(instance) # add fly to current scene
