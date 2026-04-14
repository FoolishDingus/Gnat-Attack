extends CanvasLayer

# game variables
@onready var flowers_left : int = 0 # keeps track of how many flowers are alive
@onready var score : int = 0
@onready var high_score : int = 0
const HIGHSCORE = "user://highscore.save" # location of file that saves high score (user)
# screen setting variables
@onready var fullscreen_on : bool = false
@onready var current_resolution : Vector2i = Vector2i(1280,720)
@onready var resolution_key : int = 1 # defaults to value 1 from dropdown menu (720p is currently index 1)
# to see save file: C:\Users\user_name_here\AppData\Roaming\Godot\app_userdata\CIS 434 Project

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_window().set_size(current_resolution)
	get_window().move_to_center()
	load_score() # get high score from file and set high score variable to that value


func save_score():
	var file = FileAccess.open(HIGHSCORE, FileAccess.WRITE_READ)
	if file:
		file.store_32(high_score) # stores 32-bit integer
		file.close()
	else: # prevents program from crashing if unable to save high score
		print("Failed to save high score. ", HIGHSCORE)

func load_score():
	var file = FileAccess.open(HIGHSCORE, FileAccess.READ)
	if FileAccess.file_exists(HIGHSCORE):
		high_score = file.get_32()

func update_score(points):
	score += points

func update_high_score():
	high_score = score
	save_score()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("escape"):
		get_tree().quit()


# fps debug
#func _input(event: InputEvent) -> void:
	#if Input.is_action_just_pressed("debug_fps"):
		#if Engine.max_fps == 60:
			#change_fps(30)
		#else:
			#change_fps(60)
	#
#func change_fps(framerate : int):
	#Engine.max_fps = framerate
	#print(str(Engine.max_fps))
