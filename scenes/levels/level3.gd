extends Node
@onready var enemy_spawn_timer = $EnemySpawnTimer
@onready var enemy_spawner_1 = $HBEnemySpawner/EnemySpawner1
@onready var enemy_spawner_2 = $HBEnemySpawner/EnemySpawner2
@onready var enemy_spawner_3 = $HBEnemySpawner/EnemySpawner3
@onready var enemy_spawner_4 = $HBEnemySpawner/EnemySpawner4
@onready var enemy_spawner_5 = $HBEnemySpawner/EnemySpawner5
@onready var enemy_spawner_6 = $HBEnemySpawner/EnemySpawner6
@onready var enemy_spawner_7 = $HBEnemySpawner/EnemySpawner7
@onready var enemy_spawner_8 = $HBEnemySpawner/EnemySpawner8


var enemy1green = preload("res://scenes/enemies/enemy1green.tscn")
var enemy2green = preload("res://scenes/enemies/enemy2green.tscn")
var enemy2red = preload("res://scenes/enemies/enemy2red.tscn")

var enemy_2_probability = 55
var enemy_3_probability = 10

var level_3_1_limit = 5#20
var level_3_2_limit = 10#40
var level_3_3_limit = 15#65
var current_sublevel = 0
var is_fighting_boss : bool = false
var is_screen_shaken : bool = false

func _ready():
	clean_scene()	
	SignalManager.final_blitz_warning.connect(on_final_blitz_warning)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if level_3_3_limit <= GameManager.enemy_killed and current_sublevel == 3:
		if is_fighting_boss:
			move_boss()
		else:
			SignalManager.boss_fight_start.emit()
			is_screen_shaken = true
			$ScreenShakeTimer.start()
			$red_boss.is_hidden = false
			is_fighting_boss = true
			move_boss()
			
	if level_3_3_limit <= GameManager.enemy_killed and current_sublevel == 2:
		enemy_spawn_timer.stop()
		var enemies = get_tree().get_nodes_in_group("enemy")
		for enemy in enemies:
			if enemy.global_position.y == -25:
				SignalManager.final_blitz_warning.emit()
				current_sublevel = 3
		current_sublevel = 3
				
	if level_3_2_limit <= GameManager.enemy_killed and current_sublevel == 1:
		GameManager.enemy_spawn_timer_min = 1.0
		GameManager.enemy_spawn_timer_max = 2.0
		current_sublevel = 2
		enemy_2_probability = 80
		enemy_3_probability = 50
		
	if level_3_1_limit <= GameManager.enemy_killed and current_sublevel == 0:
		GameManager.enemy_spawn_timer_min = 1.5
		GameManager.enemy_spawn_timer_max = 3.0
		current_sublevel = 1
		enemy_2_probability = 60
		enemy_3_probability = 30
		
	if is_screen_shaken:
		shake(3)
		

func _on_enemy_spawn_timer_timeout():
	if !GameManager.is_final_blitz:
		spawn_enemy()
	
	
func spawn_enemy():	
	var e
	var rnd = randi_range(0,100)
	if enemy_3_probability >=rnd:
		e = enemy2green.instantiate() as Node2D
	elif enemy_2_probability >=rnd:
		e = enemy1green.instantiate() as Node2D
	else:
		e = enemy2red.instantiate() as Node2D
	
	get_tree().root.add_child(e)
	var i = randi_range(1, 8)
	match i:
		1: 
			e.global_position = enemy_spawner_1.global_position
		2: 
			e.global_position = enemy_spawner_2.global_position
		3: 
			e.global_position = enemy_spawner_3.global_position
		4: 
			e.global_position = enemy_spawner_4.global_position
		5: 
			e.global_position = enemy_spawner_5.global_position
		6: 
			e.global_position = enemy_spawner_6.global_position
		7: 
			e.global_position = enemy_spawner_7.global_position
		8: 
			e.global_position = enemy_spawner_8.global_position
			
	enemy_spawn_timer.wait_time = randf_range(GameManager.enemy_spawn_timer_min, GameManager.enemy_spawn_timer_max)
	

func clean_scene():
	EnemyManager.speed = EnemyManager.MIN_SPEED
	var enemies = get_tree().root.get_children()
	for e in enemies:
		if e.is_in_group("enemy"):
			e.queue_free()
			
			
func on_final_blitz_warning():
	var enemies_saved = $HBEnemies.get_children()
	if enemies_saved.is_empty():
		SignalManager.start_final_blitz.emit()
	else:
		for enemy in enemies_saved:
			enemy.play("flash")
		$FinalBlitzWarningTimer.start()
		

func _on_final_blitz_warning_timer_timeout():
	var enemies_saved = $HBEnemies.get_children()
	for enemy in enemies_saved:
		enemy.queue_free()
	SignalManager.start_final_blitz.emit() # Replace with function body.


func move_boss():
	$red_boss.move()
	
	
func shake(shake_amount : float):
	$Camera2D.set_offset(Vector2( \
		randf_range(-1.0, 1.0) * shake_amount, \
		randf_range(-1.0, 1.0) * shake_amount \
	))


func _on_screen_shake_timer_timeout():
	is_screen_shaken = false
