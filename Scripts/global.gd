extends CanvasLayer

# get monitor resolution and locate the center of screen
#@onready var screen_size : Vector2i = get_viewport().get_visible_rect().size
@onready var flowers_left : int = 0 # keeps track of how many flowers are alive
@onready var flower_label = Label.new() # text UI for flowers left
@onready var score_label = Label.new() # text UI score
@onready var high_score_label = Label.new() # text UI score
@onready var score : int = 0
@onready var high_score : int = 0
const HIGHSCORE = "user://highscore.save" # location of file that saves high score (user)
# to see file: C:\Users\user_name_here\AppData\Roaming\Godot\app_userdata\CIS 434 Project

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_window().set_size(Vector2i(1280,720))
	#get_window().set_size(Vector2i(1920,1080))
	get_window().move_to_center()
	#Input.mouse_mode = Input.MOUSE_MODE_CONFINED_HIDDEN # confines mouse to window, makes it invisible, use when in a level
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN # debug, remove later
	add_child(flower_label)
	add_child(score_label)
	add_child(high_score_label)
	flower_label.text = "Flowers left: " + str(flowers_left)
	score_label.text = "Score: " + str(score)
	score_label.position = Vector2(0,15)
	high_score_label.position = Vector2(0,30)
	#visible = false # hide on main menu, show when starting game
	load_score() # get high score from file and set high score variable to that value

func save_score():
	var file = FileAccess.open(HIGHSCORE, FileAccess.WRITE_READ)
	if file:
		file.store_32(high_score) # stores 32-bit integer
		file.close()
	else: # prevents program from crashing if unable to save high score
		print("Failed to save high score. ", HIGHSCORE)
	#file = null

func load_score():
	var file = FileAccess.open(HIGHSCORE, FileAccess.READ)
	if FileAccess.file_exists(HIGHSCORE):
		high_score = file.get_32()
		high_score_label.text = "High Score: " + str(high_score)

func update_score(points):
	score += points
	score_label.text = "Score: " + str(score)

func update_high_score():
	high_score = score
	high_score_label.text = "High Score: " + str(high_score)
	save_score()

func update_flower_count():
	flower_label.text = "Flowers left: " + str(flowers_left)

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
