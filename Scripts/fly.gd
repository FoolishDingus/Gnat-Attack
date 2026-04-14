extends CharacterBody2D


@onready var target_position : Vector2i # targets the location of a flower
@onready var sprite : Sprite2D = $FlySprite
@onready var hitbox : Area2D = $FlyHitbox
@onready var notice_range : Area2D = $NoticeRange
@onready var is_alive : bool = true
@onready var direction_timer : Timer = $DirectionTimer
@onready var animation_player = $AnimationPlayer
@onready var particles : CPUParticles2D = $CPUParticles2D
@onready var sfx : AudioStreamPlayer = $SplatSFX
var flight_direction : Vector2
var speed : float = 2
var damage : int = 1               # damage dealt to flowers
var random_direction_x : int = 0   # change direction by 5 pixels at random
var random_direction_y : int = 0   # change direction by 5 pixels at random
var target_distance : float = 1000 # high number to ensure value gets replaced
var points : int = 1             # number of points earned for killing the fly

func _physics_process(_delta: float) -> void:
	# move toward target flower
	# add random numbers to target position
	# add timer so random directions aren't chosen constantly
	if is_alive: # only move while alive
		if direction_timer.is_stopped():
			change_target()
			# add randomness to target location
			random_direction_x = randi_range(-31,31)
			random_direction_y = randi_range(-31,31)
			target_position.x += random_direction_x
			target_position.y += random_direction_y
			direction_timer.start()
		global_position.x = move_toward(global_position.x, target_position.x, speed)
		global_position.y = move_toward(global_position.y, target_position.y, speed)
		#$Target.global_position = target_position # debug, shows where fly will move
	
		# debug movement
		#if Input.is_action_pressed("ui_left"):
			#global_position.x += -speed
		#elif Input.is_action_pressed("ui_right"):
			#global_position.x += speed
		#
		#if Input.is_action_pressed("ui_down"):
			#global_position.y += speed
		#elif Input.is_action_pressed("ui_up"):
			#global_position.y += -speed

	#move_and_slide() # not needed, use when changing velocity, not position


func _process(_delta: float) -> void:
	if is_alive:
		animation_player.play("flying")

func change_target():
	if notice_range.has_overlapping_areas():
		for area in notice_range.get_overlapping_areas():
			if area.name == "FlowerHitbox":
				var target = area.get_parent()
				var distance = global_position.distance_to(target.global_position) # get distance from fly to target
				if target.is_flower_alive && distance < target_distance: # if shortest distance found, set it as target distance
					target_distance = distance
					target_position = target.global_position
		if global_position.distance_to(target_position) == 0: # if reaching target
			target_distance = 1000 # reset target_distance so next flower can be found


# kill if clicked on, triggered in player script
func kill() -> void:
	is_alive = false # prevents fly from dealing damage while dead
	animation_player.stop()
	sprite.frame = 2          # switch to dead sprite
	sfx.dead_sfx()            # play splat sfx from SplatSFX node
	particles.emitting = true # add hit particles
	if !Global.flowers_left == 0:
		Global.update_score(points) # add points to score
	points = 0                      # prevent earning points from clicking on dead flies
	get_tree().current_scene.update_hud()      # updates score
	await get_tree().create_timer(0.5).timeout # wait to despawn
	queue_free() # remove from game
