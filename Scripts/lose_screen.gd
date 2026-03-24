extends Control
# handles game over screen

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE # make mouse visible on menus
	$FinalScore.text = "Final Score:\n" + str(Global.score)
	if Global.score > Global.high_score:
		$HighScore.visible = false
		$NewHighScore.visible = true
		Global.update_high_score()
	else:
		$HighScore.text = "High Score: " + str(Global.high_score)


func retry_button() -> void:
	Global.score = 0 # reset score before playing again
	Global.update_score(0)
	get_tree().change_scene_to_file.call_deferred("res://Scenes/game.tscn") # restart game scene


func menu_button() -> void:
	get_tree().change_scene_to_file.call_deferred("res://Scenes/title_screen.tscn")
