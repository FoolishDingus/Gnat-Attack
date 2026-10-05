extends Sprite2D

#region New Code Region
# added:
# added animation player for flies
# replaced flower's hp debug with health bar for release build
# simplified flower code
# added particles when flies are hit by player
# added 3D fly render from Blender to lose screen
# reduced points from killing flies to be 1 point per kill, as there wasn't much purpose to making them 100 each
# added sound effects from freesound.org
# fly spawners increase the default speed of spawned flies every 30 seconds
# added export preset to build the project

# scrapped for time
# maybe randomize spawn timer to make it harder to keep track of spawn rates
# maybe add fruit bait: placed with right click, nearby flys target it for easy kills, limited to 3 per run

# edit hitboxes to use collision masks, adjust code accordingly
# added 1440p and 4k options to windowed mode

# dev high score: 97 points
#endregion

# Called when the node enters the scene tree for the first time.
@onready var mouse_position : Vector2 = get_local_mouse_position() # keeps track of mouse
# link child nodes to variables so you don't have to call them constantly
@onready var hitbox : Area2D = $AttackArea
@onready var sfx : AudioStreamPlayer = $SmackSFX

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
	sfx.smack() # play smack SFX at 0.95 seconds of audio file
	for area in hitbox.get_overlapping_areas():
		if "FlyHitbox" in area.name:       # check if clicking on fly:
			if area.get_parent().is_alive: # prevents multiple particle effects appearring if you keep clicking dead fly
				area.get_parent().kill()   # kill fly
	await get_tree().create_timer(0.1).timeout
	frame = 0 # back to normal sprite
