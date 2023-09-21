extends CharacterBody2D

const SPEED: float = 200.0
@export var HP = 5

var laser = preload("res://scenes/laser/laser.tscn") 

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
	l.shoot(Vector2(global_position.x, global_position.y - 100) , true)
	
	
func _physics_process(delta):
	get_input()
	move_and_slide()
	
	
func get_input():
	if Input.is_action_pressed("Right"):
		velocity = Vector2(SPEED, 0)
	elif Input.is_action_pressed("Left"):
		velocity = Vector2(-SPEED, 0) 
	else:
		velocity = Vector2.ZERO
	is_out_of_bound()
		
		
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
	queue_free()


func on_enemy_died(points: int):
	print(str("POINTS : ", points))
