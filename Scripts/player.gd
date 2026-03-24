extends Sprite2D

#region New Code Region
# added:
# changed window stretch mode to canvas layer so text renders at a higher resolution
# made changes to how UI is coded
# spawners move back and forth and have been moved offscreen
# increased the radius where fly targets are randomized, making movement slightly less rigid
# added timers for spawners to activate, allowing a gradual increase in difficulty
# message on lose screen for getting new high score
# added main menu w/ logo as starting scene, lose screen button has been updated to go there as well
# added screen settings, allowing fullscreen and changing window size
# pressing the escape key at any time will close the game

# todo
# add sound effects for swatter and flies dying and(?) flying

# maybe randomize spawn timer to make it harder to keep track of spawn rates
# maybe add fruit bait: placed with right click, nearby flys target it for easy kills, limited to 3 per run
#endregion

# Called when the node enters the scene tree for the first time.
@onready var mouse_position : Vector2 = get_local_mouse_position() # keeps track of mouse
# link child nodes to variables so you don't have to call them constantly
@onready var hitbox : Area2D = $AttackArea

func _ready() -> void:
	# swatter follows mouse, hide mouse
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	mouse_position = get_viewport().get_mouse_position() # keeps track of mouse
	position = mouse_position
	
	if Input.is_action_just_pressed("left_click"):
		attack()


func attack():
	frame = 1 # swatting sprite
	for area in hitbox.get_overlapping_areas():
		if "FlyHitbox" in area.name: # check if clicking on fly:
			area.get_parent().kill() # kill fly
	await get_tree().create_timer(0.1).timeout
	frame = 0 # back to normal sprite
