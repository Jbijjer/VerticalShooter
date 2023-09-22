extends Area2D

var speed = 10.0
const POWER = 1
@onready var animated_sprite_2d = $AnimatedSprite2D


var direction = 1
var is_player_weapon = false

func _physics_process(delta):
	global_position.y += speed * direction


func shoot(gp: Vector2, is_player: bool):
	is_player_weapon = is_player
	global_position = gp
	if is_player_weapon:
		direction = -1
	else:
		direction = 1
		animated_sprite_2d.flip_v = true


func _on_screen_exited():
	if is_player_weapon:
		SignalManager.combo_reset.emit()
	queue_free()


func _on_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	queue_free()