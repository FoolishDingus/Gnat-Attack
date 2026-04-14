extends Sprite2D

@onready var hp : float = 500
@onready var is_flower_alive : bool = true
@onready var hitbox : Area2D = $FlowerHitbox
@onready var health_bar : ProgressBar = $HealthBar
@onready var health_bar_timer : Timer = $HealthBar/HealthBarTimer
const MAX_HP : int = 500

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.flowers_left += 1 # used to keep track of alive flowers in global.gd
	health_bar.value = MAX_HP


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if is_flower_alive:                      # check if flower is alive before running any code
		if hitbox.has_overlapping_areas():   # check if any area2Ds are overlapping
			var num_flies : int = 0          # used to change sprites if attacked
			for area in hitbox.get_overlapping_areas():
				if area.name == "FlyHitbox": # check for every fly overlapping (stops player from being detected)
					var parent = area.get_parent() # get fly object
					if parent.is_alive:      # check if fly is alive before dealing damage
						num_flies += 1
						hp -= parent.damage  # fly deals damage
			# update sprites and health bar
			health_bar.value = (hp/MAX_HP) * 100
			if num_flies > 0:                 # check if flies attacked
				frame = 1                     # shocked sprite
				health_bar.visible = true     # show health bar when attacked
			else:
				frame = 0                     # normal sprite
				if health_bar_timer.is_stopped():
					health_bar_timer.start()  # start timer to hide health bar
		
		if hp < 1:
			is_flower_alive = false # stop above code from running after dying
			dead()                  # switch to dead sprite and disappear
	#debug()


func dead():
	hitbox.monitoring = false
	frame = 2                    # dead sprite
	Global.flowers_left -= 1     # reduce global flowers_left by 1 in global script
	owner.update_hud()           # updates flowers left counter on HUD
	$FlowerDiesSFX.play()        # play dramatic sound when flower dies
	if Global.flowers_left == 0: # if else used to prevent going to lose screen too early
		await get_tree().create_timer(2).timeout # wait to despawn
		get_tree().change_scene_to_file.call_deferred("res://Scenes/lose_screen.tscn") # load lose screen at end of frame
	else:
		await get_tree().create_timer(2).timeout # wait to despawn
		queue_free() # despawn

func healthbar_visibility_timeup() -> void:
	if (hp/MAX_HP) > 0.2:          # keeps health bar visible if at low health
		health_bar.visible = false # hide health bar when not attacked

#func debug():
	#$HP.text = "HP: " + str(hp) # show hp under flower
