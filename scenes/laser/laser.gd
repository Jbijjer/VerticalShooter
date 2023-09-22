extends Area2D

const SPEED = 10.0
const POWER = 1
@onready var sprite_2d = $Sprite2D

var direction = 1
var is_player_weapon = false

func _physics_process(delta):
	global_position.y += SPEED * direction


func shoot(gp: Vector2, is_player: bool):
	is_player_weapon = is_player
	global_position = gp
	if is_player_weapon:
		direction = -1
	else:
		direction = 1
		sprite_2d.flip_v = true


func _on_screen_exited():
	if is_player_weapon:
		SignalManager.combo_reset.emit()
	queue_free()
#
#
