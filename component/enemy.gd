extends CharacterBody2D

class_name Enemy
var is_dying = false
var is_hidden = false
var is_dead = false

@export var laser = PackedScene
@export var hp: int
@export var points: int
@export var direction_x: int
@export var direction_y: int
@onready var sprite_2d = $Sprite2D
@onready var timer = $Timer
@onready var collision_shape_2d_2 = $Area2D/CollisionShape2D2

var speed = EnemyManager.speed
	

func _ready():
	SignalManager.start_final_blitz.connect(on_final_blitz)


func _physics_process(delta):	
	velocity = move(global_position)
	move_and_slide()

func _process(delta):	
	if sprite_2d.get_animation() == "death":
		if sprite_2d.is_playing():
			if !is_dying:
				update_interface()
				is_dying = true
		else:
			is_dead = true
	if is_dying:
		collision_shape_2d_2.set_deferred("disabled", true)
	if is_dead:
		queue_free()
			
			
func move(gp: Vector2):
	if (!is_hidden):
		if gp.x >= 700:
			direction_x = -1
		if gp.x <= 10:
			direction_x = 1
		return Vector2(speed * direction_x, speed * direction_y)
	return Vector2.ZERO
			

func update_interface():
	SignalManager.score_updated.emit(points)
	SignalManager.combo_increase.emit()	
	SignalManager.enemy_explodes.emit()	
	
		
func final_blitz():
	speed = EnemyManager.max_speed
	is_hidden = false


func hit(power: float, sprite_2d: AnimatedSprite2D):
	if (!is_hidden):
		if hp > 0:
			hp -= power
			if hp <= 0:
				speed = 0
				sprite_2d.play("death")
				sprite_2d.rotation = randi_range(0,360)
				
				
func shoot(laser: PackedScene, gp: Vector2):
	if (!is_hidden):
		if hp > 0:
			var l = laser.instantiate()
			l.is_player_weapon = false
			l.shoot(Vector2(gp.x, gp.y + 40))
			return l
		return null
	return null
	
	
func exited_screen():
	if(!GameManager.is_final_blitz):
		is_hidden = true
		SignalManager.enemy_saved.emit()
	
	
func check_if_hit(area: Area2D, sprite_2d: AnimatedSprite2D):
	if hp > 0:
		if area.is_in_group("weapon"):
			if (area.is_player_weapon):
				hit(WeaponManager.weapon_power, sprite_2d)
				
				
func check_if_player_collision(area: Area2D, sprite_2d: AnimatedSprite2D):
	if hp > 0:
		if area.is_in_group("player"):
				hit(100.0, sprite_2d)
			
			
func on_final_blitz():
	final_blitz()


func _on_timer_timeout():
	var l = shoot(laser, global_position)
	if l != null:
		get_tree().root.add_child(l)
		l.play()
	

func _on_screen_exited():	
	global_position.y = -25
	exited_screen()


func _on_area_entered(area):
	check_if_hit(area, sprite_2d)
				

func _on_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	check_if_player_collision(area, sprite_2d)
