extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var screen_size : Vector2i = get_viewport().get_visible_rect().size
	#get_tree().root.content_scale_factor = 1
	get_window().set_size(Vector2i(1280,720))
	get_window().position = Vector2i((screen_size.x/2), (screen_size.y/2))
	#get_window().
	#pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
