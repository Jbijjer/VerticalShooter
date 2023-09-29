extends CharacterBody2D

@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var audio_stream_player = $AudioStreamPlayer
@onready var boss_song = $Boss_Song

var speed = 50
var is_hidden = true
var is_dead = false

@export var laser = PackedScene
@export var laser2 = PackedScene
@export var hp: int
@export var points: int
@export var direction_x: int

var l1
var l2
var l3

func _process(delta):	
	if animated_sprite_2d.get_animation() == "death":
		$Timer.stop()
		if !animated_sprite_2d.is_playing():
			queue_free()


func _physics_process(delta):
	move_and_slide()


func move():
	if !boss_song.playing:
		boss_song.play()
	if global_position.x >= 550:
		direction_x = -1
	if global_position.x <= 165:
		direction_x = 1
	if global_position.y <= 235:
		velocity = Vector2(0, speed)
	else:
		velocity = Vector2(direction_x * speed, 0)
		

func hit(power: float, sprite_2d: AnimatedSprite2D):
	if (!is_hidden):
		if hp > 0:
			hp -= power
			if hp <= 0:
				speed = 0
				#sprite_2d.play("death")
				play_explosion_sound()
				sprite_2d.rotation = randi_range(0,360)
				
				
func play_explosion_sound():
	audio_stream_player.play()
				
				
func shoot(l: PackedScene, gp):
	if hp > 0:
		var la = l.instantiate()
		la.is_player_weapon = false
		la.shoot(gp)
		return la
	else:
		return null


func _on_area_entered(area):
	if global_position.y >= 235:
		if hp > 0:
			if area.is_in_group("weapon"):
				if (area.is_player_weapon):
					hit(WeaponManager.weapon_power, animated_sprite_2d)


func _on_timer_timeout():
	if !is_hidden:
		l2 = shoot(laser2, $Laser2.global_position)
		if l2 != null:
			get_tree().root.add_child(l2)
			l2.play()


func _on_side_laser_timer_timeout():	
	if !is_hidden:
		l1 = shoot(laser, $Laser1.global_position)
		if l1 != null:
			get_tree().root.add_child(l1)
			l1.play()
		l3 = shoot(laser, $Laser3.global_position)
		if l3 != null:
			get_tree().root.add_child(l3)
			l3.play()
