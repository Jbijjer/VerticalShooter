extends Area2D

const SPEED = 10.0
const POWER = 1
@onready var sprite_2d = $Sprite2D

var direction = 1
var is_player_laser = false

func _physics_process(delta):
	global_position.y += SPEED * direction


func shoot(gp: Vector2, is_player: bool):
	is_player_laser = is_player
	global_position = gp
	if is_player_laser:
		direction = -1
	else:
		direction = 1
		sprite_2d.flip_v = true
 # Replace with function body.


func _on_area_entered(area):		
	queue_free()	
