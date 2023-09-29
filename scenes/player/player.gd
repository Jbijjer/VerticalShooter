extends CharacterBody2D


@onready var sprite_2d = $Sprite2D

@export var laser = preload("res://scenes/laser/bluelaser.tscn")
@onready var audio_stream_player = $AudioStreamPlayer


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("Shoot"):
		shoot()
		
	if sprite_2d.get_animation() == "death":
		if not sprite_2d.is_playing():
			die()
	
	
func shoot():
	var l = laser.instantiate() as Area2D
	get_tree().root.add_child(l)
	l.shoot(Vector2(global_position.x, global_position.y - 40) , true)
	
	
func _physics_process(delta):
	if PlayerManager.lives <= 0:
		return
	get_input()
	move_and_slide()
	
	
func get_input():
	check_cur_speed()
	if Input.is_action_pressed("Right"):
		velocity = Vector2(PlayerManager.cur_speed, 0)
	elif Input.is_action_pressed("Left"):
		velocity = Vector2(-PlayerManager.cur_speed, 0) 
	else:
		velocity = Vector2.ZERO
		reset_cur_speed()
	is_out_of_bound()
	
	
func check_cur_speed():
	if (PlayerManager.cur_speed + PlayerManager.ACCELERATION_RATE <= PlayerManager.max_speed):
		PlayerManager.cur_speed += PlayerManager.ACCELERATION_RATE
	else:
		PlayerManager.cur_speed = PlayerManager.max_speed
		
		
func reset_cur_speed():
	PlayerManager.cur_speed = PlayerManager.MIN_SPEED
		
		
func is_out_of_bound():
	if global_position.x <= 0.0:
		global_position.x = 0.0
	elif global_position.x >= 720.0:
		global_position.x = 720
	
func hit():
	PlayerManager.lives -= 1
	SignalManager.combo_reset.emit()
	SignalManager.player_hit.emit()	
	if PlayerManager.lives <= 0:
		sprite_2d.play("death")
		audio_stream_player.play()
	else:
		var i = randi_range(1,2)
		if WeaponManager.level > 1 and PlayerManager.speed_level > 1:
			if i == 1:
				WeaponManager.decrease_weapon_power(1)
				SignalManager.weapon_update.emit()
			if i == 2:
				PlayerManager.decrease_max_speed(1)
				SignalManager.speed_update.emit()
		elif WeaponManager.level > 1:
			WeaponManager.decrease_weapon_power(1)
			SignalManager.weapon_update.emit()
		elif PlayerManager.speed_level > 1:
			PlayerManager.decrease_max_speed(1)
			SignalManager.speed_update.emit()
			
			
		
func die():
	SignalManager.player_died.emit()
	queue_free()


func _on_area_2d_area_entered(area):
	if area.is_in_group("weapon"):
		hit()


func _on_area_2d_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	if area.is_in_group("enemy"):
		hit()
