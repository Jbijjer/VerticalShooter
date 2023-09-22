extends CharacterBody2D

const MIN_SPEED: float = 100.0
const MAX_SPEED: float = 350.0
const ACCELERATION_RATE: float = 10


@onready var sprite_2d = $Sprite2D
var cur_speed: float = MIN_SPEED

@export var laser = preload("res://scenes/laser/bluelaser.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	SignalManager.enemy_died.connect(on_enemy_died)

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
	if GameManager.HP <= 0:
		return
	get_input()
	move_and_slide()
	
	
func get_input():
	check_cur_speed()
	if Input.is_action_pressed("Right"):
		velocity = Vector2(cur_speed, 0)
	elif Input.is_action_pressed("Left"):
		velocity = Vector2(-cur_speed, 0) 
	else:
		velocity = Vector2.ZERO
		reset_cur_speed()
	is_out_of_bound()
	
	
func check_cur_speed():
	if (cur_speed + ACCELERATION_RATE <= MAX_SPEED):
		cur_speed += ACCELERATION_RATE
	else:
		cur_speed = MAX_SPEED
		
		
func reset_cur_speed():
	cur_speed = MIN_SPEED
		
		
func is_out_of_bound():
	if global_position.x <= 0.0:
		global_position.x = 0.0
	elif global_position.x >= 720.0:
		global_position.x = 720
	
func hit(power: float):
	GameManager.HP -= power
	SignalManager.combo_reset.emit()
	SignalManager.player_hit.emit()
	if GameManager.HP <= 0:
		sprite_2d.play("death")
		
		
func die():
	SignalManager.player_died.emit()
	queue_free()

func on_enemy_died(points: int):
	pass


func _on_area_2d_area_entered(area):
	if area.is_in_group("weapon"):
		area.queue_free()
		hit(area.POWER)


func _on_area_2d_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	if area.is_in_group("enemy"):
		hit(1)
