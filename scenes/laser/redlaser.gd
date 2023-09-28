extends "res://scenes/laser/laser.gd"

func shoot(gp: Vector2):
	global_position = gp
	

func play():
	$AudioStreamPlayer.play()
