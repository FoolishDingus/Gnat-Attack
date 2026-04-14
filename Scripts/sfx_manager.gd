extends AudioStreamPlayer

var last_pitch : float = 1.0
# Called when the node enters the scene tree for the first time.

# dead fly smack
func dead_sfx() -> void:
	#while(pitch_scale - last_pitch < 0.1): # checks that pitch isn't too similar to previous sound (not needed here, use for objects that play sounds often)
	randomize() # set random seed for pitch
	pitch_scale = randf_range(0.8, 1.2) # set pitch to random value
	play(1.8)                # play sound at 1.8 seconds of audio file
	last_pitch = pitch_scale # set last pitch to current value

# fly swatter smack
func smack():
	randomize() # set random seed for pitch
	pitch_scale = randf_range(0.95, 1.15) # set pitch to random value
	play(0.95)                # play sound at 0.95 seconds of audio file
	last_pitch = pitch_scale # set last pitch to current value
