extends CharacterBody2D

const SPEED = 100.0
@export var HP = 1
@export var POINTS = 1
@onready var laser = preload("res://scenes/laser/laser.tscn")

func _ready():
	pass


func _physics_process(delta):
	velocity = Vector2(0, SPEED)
	
	move_and_slide()
	
	
func hit(power: float):
	HP -= power
	if HP <= 0:
		SignalManager.enemy_died.emit(POINTS)
		die()
		
		
func die():
	queue_free()


func _on_timer_timeout():
	var l = laser.instantiate()
	l.is_player_laser = false
	get_tree().root.add_child(l)
	l.shoot(Vector2(global_position.x, global_position .y + 100), false)
