extends Area2D

const SPEED = 10.0
const POWER = 1

var direction = 1
var is_player_weapon = false

func _physics_process(delta):
        global_position.y += SPEED * direction * delta


func _on_screen_exited():
	queue_free()
#

func _on_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	if area.is_in_group("enemy"):		
		return
	queue_free()
