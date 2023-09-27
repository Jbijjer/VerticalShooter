extends Node

const MIN_SPEED = 100.0

var speed = MIN_SPEED
var max_speed = 200.0


func _ready():
	SignalManager.level_up.connect(on_level_up)


func on_level_up():
	if speed < max_speed:
		speed += 10
