extends Node

@onready var intro_music = $IntroMusic

func play_intro_music():
	intro_music.play()

func stop_intro_music():
	intro_music.stop()
	
	
