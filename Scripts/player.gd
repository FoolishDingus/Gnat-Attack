extends Sprite2D

#region New Code Region
# added:
# debug fly movement
# flowers can now be attacked and killed
# added counter in global script that tracks how many flowers are left
# created fly spawners to instantiate flies

# todo
# automate fly movement (add target_position placed on the nearest flower, move randomly in a set range towards target)
# add fail state for all flowers dying
# score system in global script (add UI nodes to player?)
# add main menu with screen settings

# maybe add fruit bait: placed with right click, nearby flys target it for easy kills, limited to 3 per run
#endregion

# Called when the node enters the scene tree for the first time.
@onready var mouse_position : Vector2 = get_local_mouse_position() # keeps track of mouse
# link child nodes to variables so you don't have to call them constantly
@onready var hitbox : Area2D = $AttackArea

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	mouse_position = get_viewport().get_mouse_position() # keeps track of mouse
	position = mouse_position
	#SetPosition(global_position, mouse_position)
	#move_and_slide()
	#print(str(get_local_mouse_position()))
	if Input.is_action_just_pressed("left_click"):
		attack()

func attack():
	frame = 1 # swatting sprite
	for area in hitbox.get_overlapping_areas():
		if "FlyHitbox" in area.name: # check if clicking on fly:
			area.get_parent().kill() # kill fly
	await get_tree().create_timer(0.1).timeout
	frame = 0 # back to normal sprite
