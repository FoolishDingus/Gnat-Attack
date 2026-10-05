extends Control


@onready var resolution_button : OptionButton = $ColorRect/VBoxContainer/ResolutionButton
@onready var fullscreen_button : CheckButton = $ColorRect/VBoxContainer/FullscreenButton
@onready var resolutions = {
	"3840x2160": Vector2i(3840, 2160),
	"2560x1440": Vector2i(2560, 1440),
	"1920x1080": Vector2i(1920, 1080),
	"1280x720": Vector2i(1280, 720),
	"640x360": Vector2i(640, 360)
	}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE # make mouse visible if returning from game
	
	# add all resolutions as an option in the resolution_button dropdown
	for resolution in resolutions:
		resolution_button.add_item(resolution)
	
	resolution_button.selected = Global.resolution_key # set button visual to match current resolution
	if Global.fullscreen_on:                           # mark fullscreen button as pressed if already playing in fullscreen
		fullscreen_button.button_pressed = true


# start the game
func play_button() -> void:
	Global.update_score(0)
	get_tree().change_scene_to_file.call_deferred("res://Scenes/game.tscn") # load game scene


# close the application
func exit_button() -> void:
	get_tree().quit()


func option_resolution_selected(index: int) -> void:
	var resolution_selection : String = resolution_button.get_item_text(index) # get selected resolution
	if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_WINDOWED:
		#DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN) # centers the screen when moving to lower resolution
		get_window().set_size(resolutions[resolution_selection]) # change window size
		get_window().move_to_center()                            # center game window
	# remembered for fullscreen
	Global.current_resolution = resolutions[resolution_selection]
	Global.resolution_key = index


# switch between fullscreen and windowed modes
func option_fullscreen_toggle(fullscreen: bool) -> void:
	if fullscreen:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		Global.fullscreen_on = true
	else: # switch to windowed mode
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		Global.fullscreen_on = false
		get_window().set_size(Global.current_resolution)
		get_window().move_to_center()
