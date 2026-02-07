extends CanvasLayer

# get monitor resolution and locate the center of screen
#@onready var screen_size : Vector2i = get_viewport().get_visible_rect().size
@onready var flowers_left : int = 0 # keeps track of how many flowers are alive
@onready var flower_label = Label.new() # text UI for flowers left

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_window().set_size(Vector2i(1280,720))
	#get_window().set_size(Vector2i(1920,1080))
	get_window().move_to_center()
	#Input.mouse_mode = Input.MOUSE_MODE_CONFINED_HIDDEN # confines mouse to window, makes it invisible, use when in a level
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN # debug, remove later
	add_child(flower_label)
	#flower_label.global_position = Vector2(0,0)
	flower_label.text = "Flowers left: " + str(flowers_left)
	#visible = false # hide on main menu, show when starting game


func update_flower_count():
	flower_label.text = "Flowers left: " + str(flowers_left)
	lose_check()

func lose_check():
	if flowers_left == 0:
		pass # add lose code

# fps debug
#func _input(event: InputEvent) -> void:
	##if event.is_action_pressed("debug_fps"):
	#if Input.is_action_just_pressed("debug_fps"):
		#if Engine.max_fps == 60:
			#change_fps(30)
		#else:
			#change_fps(60)
	#
#func change_fps(framerate : int):
	#Engine.max_fps = framerate
	#print(str(Engine.max_fps))
