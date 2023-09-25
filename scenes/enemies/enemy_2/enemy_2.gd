extends CharacterBody2D

var enemy = Enemy.new()

@onready var timer = $Timer
@onready var sprite_2d = $Sprite2D
@onready var laser = preload("res://scenes/laser/greenlaser.tscn")
	
func _ready():
	SignalManager.start_final_blitz.connect(on_final_blitz)
	enemy.hp = 3
	enemy.points = 200
	enemy.direction_x = 0
	enemy.direction_y = 1
	

func _physics_process(delta):
	velocity = enemy.move(global_position)
	move_and_slide()
			
	
func _process(delta):	
	enemy.process(sprite_2d)
	if enemy.is_dead:
		queue_free()
			
			
func on_final_blitz():
	enemy.speed = EnemyManager.max_speed
	enemy.is_hidden = false		
		

func hit(power: float):
	enemy.hit(power, sprite_2d)


func _on_timer_timeout():
	var l = enemy.shoot(laser, global_position)
	if l != null:
		get_tree().root.add_child(l)
	

func _on_screen_exited():	
	global_position.y = -25
	enemy.exited_screen()


func _on_area_entered(area):
	enemy.check_if_hit(area, sprite_2d)
				

func _on_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	enemy.check_if_player_collision(area, sprite_2d)
