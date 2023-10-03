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

var enemy1 = preload("res://scenes/enemies/enemy1red.tscn")
var enemy2 = preload("res://scenes/enemies/enemy1green.tscn")
var enemy3 = preload("res://scenes/enemies/enemy2red.tscn")
@onready var final_blitz_music = $FinalBlitzMusic

var enemy_2_probability = 35
var enemy_3_probability = -5

var level_1_limit = 5#15
var level_2_limit = 10#25
var level_3_limit = 15#45
var current_sublevel = 0
var is_flawless_victory = false


func _ready():
	clean_scene()
	SignalManager.final_blitz_warning.connect(on_final_blitz_warning)
	update_ui()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	verify_progress()
	
	
func verify_progress():
	if level_3_limit <= GameManager.enemy_killed and current_sublevel == 3:
		GameManager.is_final_blitz = true
		if get_tree().get_nodes_in_group("enemy").size() <= 0:
			SignalManager.level_finished.emit()		
			final_blitz_music.stop()
	if level_3_limit <= GameManager.enemy_killed and current_sublevel == 2:
		enemy_spawn_timer.stop()	
		var enemies = get_tree().get_nodes_in_group("enemy")
		if enemies.size() > 0:
			for enemy in enemies:
				if enemy.global_position.y <= -25:				
					SignalManager.final_blitz_warning.emit()
					final_blitz_music.play()
					current_sublevel = 3		
					break
		current_sublevel = 3					
	if level_2_limit <= GameManager.enemy_killed and current_sublevel == 1:
		GameManager.enemy_spawn_timer_min = 1.0
		GameManager.enemy_spawn_timer_max = 2.0
		current_sublevel = 2
		enemy_2_probability = 60
		enemy_3_probability = 30		
	if level_1_limit <= GameManager.enemy_killed and current_sublevel == 0:
		GameManager.enemy_spawn_timer_min = 1.5
		GameManager.enemy_spawn_timer_max = 3.0
		current_sublevel = 1
		enemy_2_probability = 30
		enemy_3_probability = 15
		

func _on_enemy_spawn_timer_timeout():
	if !GameManager.is_final_blitz:
		spawn_enemy()
	
	
func spawn_enemy():	
	var e
	var rnd = randi_range(0,100)
	if enemy_3_probability >=rnd:
		e = enemy3.instantiate() as Node2D
	elif enemy_2_probability >=rnd:
		e = enemy2.instantiate() as Node2D
	else:
		e = enemy1.instantiate() as Node2D
	
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
			
			
func update_ui():
	SignalManager.speed_update.emit(false)
	SignalManager.score_updated.emit(0)
	SignalManager.weapon_speed_update.emit(false)
	SignalManager.weapon_update.emit(false)
	SignalManager.combo_update.emit()
			
			
func on_final_blitz_warning():
	var enemies_missed = $HBEnemies.get_children()
	if enemies_missed.is_empty():
		SignalManager.start_final_blitz.emit()
	else:
		for enemy in enemies_missed:
			enemy.play("flash")
		$FinalBlitzWarningTimer.start()
		


func _on_final_blitz_warning_timer_timeout():
	var enemies_missed = $HBEnemies.get_children()
	for enemy in enemies_missed:
		enemy.queue_free()
	SignalManager.start_final_blitz.emit() # Replace with function body.
