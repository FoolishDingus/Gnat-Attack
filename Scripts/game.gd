extends Node2D

@onready var user_interface : CanvasLayer = $UI # get UI node from the Level1 scene
@onready var all_spawners : Array = $Spawners.get_children() #

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# prepare HUD
	user_interface.get_child(0).text = "Flowers Left: " + str(Global.flowers_left) + "\nScore: " + str(Global.score)
	Input.mouse_mode = Input.MOUSE_MODE_CONFINED_HIDDEN # mouse can't leave window during gameplay, swatter will show where mouse is
	#await get_tree().create_timer(2).timeout
	
	#print(str($Spawners.get_children()))

# called whenever a fly or flower dies
func update_hud():
	user_interface.get_child(0).text = "Flowers Left: " + str(Global.flowers_left) + "\nScore: " + str(Global.score)

# SpeedupTimer runs endlessly, increasing the speed of flies created by spawners whenever the timer resets
func _on_speedup_timer_timeout() -> void:
	for spawner in all_spawners: # Replace with function body.
		if !(spawner.fly_speed >= 3):  # caps speed increase so flies don't get incredibly fast
			spawner.fly_speed += 0.2   # spawned flies now move at a higher speed
	#print("speed up") # debug line
