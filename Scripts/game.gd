extends Node2D

@onready var user_interface : CanvasLayer = $UI # get UI node from the Level1 scene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# prepare HUD
	user_interface.get_child(0).text = "Flowers Left: " + str(Global.flowers_left) + "\nScore: " + str(Global.score)
	Input.mouse_mode = Input.MOUSE_MODE_CONFINED_HIDDEN # mouse can't leave window during gameplay, swatter will show where mouse is

# called whenever a fly or flower dies
func update_hud():
	user_interface.get_child(0).text = "Flowers Left: " + str(Global.flowers_left) + "\nScore: " + str(Global.score)
