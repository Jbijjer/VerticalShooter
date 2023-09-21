extends Area2D

const SPEED = 10.0
const POWER = 1

var direction = 1
var is_player_laser = false

func _physics_process(delta):
	global_position.y += SPEED * direction


func _on_body_entered(body):
	if is_player_laser and body.is_in_group("enemy"):
		body.hit(POWER)
		queue_free()	
	if !is_player_laser and body.is_in_group("player"):
		body.hit(POWER)
		queue_free()	
	

func shoot(gp: Vector2, is_player: bool):
	is_player_laser = is_player
	global_position = gp
	if is_player:
		direction = -1
	else:
		direction = 1
 # Replace with function body.
