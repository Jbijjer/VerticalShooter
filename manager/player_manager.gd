extends Node


var lives: int = 3
var MIN_SPEED: float = 75.0
var MAX_SPEED: float = 250.0
var ACCELERATION_RATE: float = 10
var cur_speed: float = MIN_SPEED


func reset():
	lives = 3
	cur_speed = MIN_SPEED
