extends Area2D

var speed = 10.0
const POWER = 5
@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var audio_stream_player = $AudioStreamPlayer
@onready var collision_shape_2d_1_4 = $"CollisionShape2D1-4"
@onready var collision_shape_2d_5 = $CollisionShape2D5


var direction = -1
var is_player_weapon = true


func _ready():
	if WeaponManager.level == 5:
		animated_sprite_2d.play("level5")
		collision_shape_2d_1_4.disabled = true
		collision_shape_2d_5.disabled = false
	else:
		animated_sprite_2d.play("level1-4")		
		collision_shape_2d_1_4.disabled = false
		collision_shape_2d_5.disabled = true


func _process(delta):
	if animated_sprite_2d.get_animation() == "explosion":
		if !animated_sprite_2d.is_playing():
			queue_free()			


func _physics_process(delta):
        global_position.y += speed * direction * delta


func shoot(gp: Vector2, is_player: bool):
	global_position = gp	
	audio_stream_player.play()


func _on_screen_exited():
	SignalManager.combo_reset.emit()
	queue_free()


func _on_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	if not area.is_in_group("player"):
		speed = 0
		animated_sprite_2d.play("explosion")
		animated_sprite_2d.rotation = randf_range(-360,360)
