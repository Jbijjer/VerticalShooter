extends Node

const INIT_MAX_SPEED = 250.0
const ACCELERATION_RATE: float = 10
const LVL_UP_GROWTH = 25

var lives: int = 3
var MIN_SPEED: float = 75.0
var max_speed: float = INIT_MAX_SPEED
var speed_level = 1
var weapon_speed_level = 1
var cur_speed: float = MIN_SPEED
var shoot_wait_time: float = 0.25


func reset():
	lives = 3
	cur_speed = MIN_SPEED


func increase_max_speed(i: int):
	speed_level += i
	max_speed = INIT_MAX_SPEED + (LVL_UP_GROWTH * speed_level)


func decrease_max_speed(i: int):
	if speed_level > 1:
		speed_level -= i
		max_speed = INIT_MAX_SPEED + (LVL_UP_GROWTH * speed_level)


func increase_max_weapon_speed(i: int):
	if weapon_speed_level < 4:
		weapon_speed_level += i 
		shoot_wait_time -= 0.05


func decrease_max_weapon_speed(i: int):
	if weapon_speed_level > 1:
		weapon_speed_level -= i
		shoot_wait_time += 0.1
