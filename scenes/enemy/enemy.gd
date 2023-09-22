extends CharacterBody2D

var SPEED = 100.0
@export var HP = 1
@export var POINTS = 100
@export var XP = 1
@onready var laser = preload("res://scenes/laser/redlaser.tscn")
@onready var sprite_2d = $Sprite2D
var dying = false

func _ready():
	pass

func _process(delta):
	if sprite_2d.get_animation() == "death":
		if !dying:	
			update_score_combo()
			dying = true		
		if not sprite_2d.is_playing():
			die()
			

func update_score_combo():
	SignalManager.score_updated.emit(POINTS)
	SignalManager.combo_increase.emit()	
	

func _physics_process(delta):
	velocity = Vector2(0, SPEED)
	
	move_and_slide()
	
	
func hit(power: float):
	if HP > 0:
		HP -= power
		if HP <= 0:
			SPEED = 0
			sprite_2d.play("death")
			sprite_2d.rotation = randi_range(0,360)
		
func die():
	SignalManager.enemy_died.emit(XP)
	queue_free()


func _on_timer_timeout():
	if sprite_2d.get_animation() == "death":
		if sprite_2d.is_playing():
			return
	var l = laser.instantiate()
	l.is_player_weapon = false
	get_tree().root.add_child(l)
	l.shoot(Vector2(global_position.x, global_position .y + 40), false)


func _on_screen_exited():
	global_position.y = -25 # Replace with function body.


func _on_area_entered(area):
	if HP > 0:
		if area.is_in_group("weapon"):
			if (area.is_player_weapon):
				hit(WeaponManager.weapon_power)
				area.queue_free()


func _on_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	if HP > 0:
		if area.is_in_group("player"):
				hit(100.0)
