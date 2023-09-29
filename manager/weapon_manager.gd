extends Node

var level = 1
var weapon_power = level * 5.0


func reset():
	level = 1
	
	
func increase_weapon_power(i: int):
	level += i
	weapon_power = level * 5.0


func decrease_weapon_power(i: int):
	if level > 1:
		level -= i
		weapon_power = level * 5.0
		
