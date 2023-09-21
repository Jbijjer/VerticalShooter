extends CharacterBody2D

const MIN_SPEED: float = 150.0
const MAX_SPEED: float = 450.0
const ACCELERATION_RATE: float = 10

@export var HP = 5

var cur_speed: float = MIN_SPEED


@export var laser = preload("res://scenes/laser/bluelaser.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	SignalManager.enemy_died.connect(on_enemy_died)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("Shoot"):
		shoot()
	
	
func shoot():
	var l = laser.instantiate() as Area2D
	get_tree().root.add_child(l)
	l.shoot(Vector2(global_position.x, global_position.y - 40) , true)
	
	
func _physics_process(delta):
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
	print(str("HP : ", HP))
	HP -= power
	if HP <= 0:
		die()
		
		
func die():
	SignalManager.player_died.emit()
	queue_free()


func on_enemy_died(points: int):
	GameManager.update_xp(points)


func _on_area_2d_area_entered(area):
	if area.is_in_group("weapon"):
		hit(area.POWER)


func _on_area_2d_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	if area.is_in_group("enemy"):
		hit(1)
