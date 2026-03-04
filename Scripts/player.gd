extends Sprite2D

#region New Code Region
# added:
# automated fly movement
# lose screen when all flowers are dead
# score system
# high score is saved to a highscore.save file to remember your best score between sessions

# todo
# improve fly AI by having them randomly change direction on their way to flowers
# have spawners move around to make it harder to predict where flies come from, maybe move in circles
# add main menu with screen settings
# add movement code to fly spawners

# maybe randomize spawn timer to make it harder to keep track of spawn rates
# maybe add fruit bait: placed with right click, nearby flys target it for easy kills, limited to 3 per run
#endregion

# Called when the node enters the scene tree for the first time.
@onready var mouse_position : Vector2 = get_local_mouse_position() # keeps track of mouse
# link child nodes to variables so you don't have to call them constantly
@onready var hitbox : Area2D = $AttackArea

func _ready() -> void:
	# swatter follows mouse, hide mouse, make score and flowers left visible
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN
	Global.flower_label.visible = true
	Global.score_label.visible = true
	Global.high_score_label.visible = true

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
