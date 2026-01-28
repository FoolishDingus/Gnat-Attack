extends Sprite2D

# todo
#region New Code Region
# fly movement
# flower script
# fly spawners to instantiate flies
# score system in global script
# fail state for all flowers dying
# backup to github

# maybe add bait: placed with right click, nearby flys target it for easy kills, limited to 3 per run
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
