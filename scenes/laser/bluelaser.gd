extends Area2D

var speed = 10.0
const POWER = 5
@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var audio_stream_player = $AudioStreamPlayer


var direction = -1
var is_player_weapon = true

func _physics_process(delta):
	global_position.y += speed * direction


func shoot(gp: Vector2, is_player: bool):
	global_position = gp	
	audio_stream_player.play()


func _on_screen_exited():
	SignalManager.combo_reset.emit()
	queue_free()


func _on_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	queue_free()
