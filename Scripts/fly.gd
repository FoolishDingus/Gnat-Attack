extends CharacterBody2D


#@onready var target_position : Vector2i() # targets the location of a flower
@onready var sprite : Sprite2D = $FlySprite
@onready var hitbox : Area2D = $FlyHitbox
@onready var is_alive : bool = true
var flight_direction : Vector2
var speed = 300.0
var damage : int = 2 # damage dealt to flowers

func _physics_process(_delta: float) -> void:
	# add flower location as target location
	# flight_direction = (target_position - position).normalized()
	if Input.is_action_pressed("ui_left"):
		velocity.x = -speed
	elif Input.is_action_pressed("ui_right"):
		velocity.x = speed
	else:
		velocity.x = 0
	
	if Input.is_action_pressed("ui_down"):
		velocity.y = speed
	elif Input.is_action_pressed("ui_up"):
		velocity.y = -speed
	else:
		velocity.y = 0
	
	move_and_slide()


# kill if clicked on, triggered in player script
func kill() -> void:
	is_alive = false # prevents fly from dealing damage while dead
	sprite.frame = 2 # switch to dead sprite 
	await get_tree().create_timer(0.5).timeout # wait to despawn
	queue_free() # remove from game
