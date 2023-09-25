extends CharacterBody2D

@export var hp = 1
@export var points = 300
@onready var laser = preload("res://scenes/laser/redlaser.tscn")
@onready var sprite_2d = $Sprite2D
var is_dying = false
var is_hidden = false
@onready var timer = $Timer
var direction_x = 1

var speed = EnemyManager.speed
	
func _ready():
	SignalManager.start_final_blitz.connect(on_final_blitz)

func _process(delta):
	if sprite_2d.get_animation() == "death":
		if sprite_2d.is_playing():
			if !is_dying:
				update_interface()
				is_dying = true
		else:
			die()				
			
			
func on_final_blitz():
	speed = EnemyManager.max_speed
	is_hidden = false		
			

func update_interface():
	SignalManager.score_updated.emit(points)
	SignalManager.combo_increase.emit()	
	SignalManager.enemy_explodes.emit()
	

func _physics_process(delta):	
	if (!is_hidden):
		velocity = Vector2(speed * direction_x, speed)
		if global_position.x >= 700:
			direction_x = -1
		if global_position.x <= 0:
			direction_x = 1
		
		move_and_slide()
	
	
func hit(power: float):
	if (!is_hidden):
		if hp > 0:
			hp -= power
			if hp <= 0:
				speed = 0
				sprite_2d.play("death")
				sprite_2d.rotation = randi_range(0,360)
		
func die():
	queue_free()


func _on_timer_timeout():
	if (!is_hidden):
		if hp > 0:
			var l = laser.instantiate()
			l.is_player_weapon = false
			get_tree().root.add_child(l)
			l.shoot(Vector2(global_position.x, global_position .y + 40), false)


func _on_screen_exited():
	global_position.y = -25
	if(!GameManager.is_final_blitz):
		is_hidden = true
		SignalManager.enemy_saved.emit()


func _on_area_entered(area):
	if hp > 0:
		if area.is_in_group("weapon"):
			if (area.is_player_weapon):
				hit(WeaponManager.weapon_power)				
				area.queue_free()


func _on_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	if hp > 0:
		if area.is_in_group("player"):
				hit(100.0)
