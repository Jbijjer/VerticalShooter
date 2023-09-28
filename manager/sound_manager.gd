extends Node

@onready var enemylaser = "res://assets/audio/sfx_laser2.ogg"

func play_enemylaser_sound():
	var audio = AudioStreamPlayer.new()
	if FileAccess.file_exists(enemylaser):
		var sfx = load(enemylaser) 
		sfx.set_loop(false)
		audio.stream = sfx
		audio.play()
	
	
