extends Node2D

@onready var spawn_timer : Timer = $SpawnTimer
@onready var fly = load("res://Scenes/fly.tscn")   # loads flys to be spawned
@onready var current_scene = get_tree().get_root() # get current level so spawner can add flies to it

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawn_timer.start() # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
	#spawn_timer.


# spawn flies when SpawnTimer runs out
func _on_spawn_timer_timeout() -> void:
	var instance = fly.instantiate() # create fly object
	instance.position = global_position # place fly at spawner's global position
	current_scene.add_child.call_deferred(instance) # add fly to current scene
