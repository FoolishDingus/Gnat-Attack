extends Sprite2D

@onready var hp : int = 500
@onready var is_attacked : bool = false
@onready var is_flower_alive : bool = true
@onready var hitbox : Area2D = $FlowerHitbox

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.flowers_left += 1 # used to keep track of alive flowers in global.gd
	Global.update_flower_count()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if is_flower_alive:                      # check if flower is alive before running any code
		if hitbox.has_overlapping_areas():   # check if any area2Ds are overlapping
			var num_flies : int = 0
			for area in hitbox.get_overlapping_areas():
				if area.name == "FlyHitbox": # check for every fly overlapping
					var parent = area.get_parent() #
					if parent.is_alive:      # check if fly is alive before dealing damage
						num_flies += 1
						hp -= parent.damage  # fly deals damage
			if num_flies > 0:                # check if flies attacked
				is_attacked = true
			else:
				is_attacked = false
		else:
			is_attacked = false # go back to normal sprite if no areas are found
		
		# change sprite if attacked
		if is_attacked == true:
			frame = 1 # shocked sprite
		else:
			frame = 0 # normal sprite
		
		if hp < 1:
			is_flower_alive = false # stop above code from running after dying
			dead()                  # switch to dead sprite and disappear
	
	debug()


func dead():
	hitbox.monitoring = false
	frame = 2                    # dead sprite
	Global.flowers_left -= 1     # reduce global flowers_left by 1 in global script
	Global.update_flower_count() # change visible counter
	if Global.flowers_left == 0: # if else used to prevent going to lose screen too early
		await get_tree().create_timer(2).timeout # wait to despawn
		get_tree().change_scene_to_file.call_deferred("res://Scenes/lose_screen.tscn") # load lose screen at end of frame
	else:
		await get_tree().create_timer(2).timeout # wait to despawn
		queue_free() # despawn


func debug():
	$HP.text = "HP: " + str(hp) # show hp under flower
