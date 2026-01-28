extends CharacterBody2D


#@onready var target_position : Vector2i() # targets the location of a flower
@onready var sprite : Sprite2D = $FlySprite
var flight_direction : Vector2
var speed = 300.0

func _physics_process(_delta: float) -> void:
	# add flower location as target location
	# flight_direction = (target_position - position).normalized()
	#move_and_slide()
	pass

# begin killing flower after reaching it
func attack_flower():
	pass

# kill if clicked on, triggered in player script
func kill() -> void:
	# if input = left click && mouse position is 
	sprite.frame = 2 # switch to dead sprite 
	await get_tree().create_timer(0.5).timeout # wait to despawn
	queue_free() # remove from game
