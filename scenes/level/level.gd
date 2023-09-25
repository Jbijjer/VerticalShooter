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

var enemy_1 = preload("res://scenes/enemies/enemy/enemy.tscn")
var enemy_2 = preload("res://scenes/enemies/enemy_2/enemy_2.tscn")
var enemy_3 = preload("res://scenes/enemies/enemy_3/enemy_3.tscn")

var enemy_1_probability = 90
var enemy_2_probability = 10
var enemy_3_probability = 0

var level_1_1_limit = 5
var level_1_2_limit = 10
var level_1_3_limit = 15
var current_sublevel = 0


func _ready():
	clean_scene()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if level_1_3_limit <= GameManager.enemy_killed and current_sublevel == 3:
		print(str(get_tree().get_nodes_in_group("enemy").size()))
		if get_tree().get_nodes_in_group("enemy").size() <= 0:
			SignalManager.level_finished.emit()
			
	if level_1_3_limit <= GameManager.enemy_killed and current_sublevel == 2:
		var enemies = get_tree().get_nodes_in_group("enemy")
		for enemy in enemies:
			print(enemy.global_position.y)
			if !enemy.global_position.y == -25:
				enemy.queue_free()
		SignalManager.start_final_blitz.emit()
		current_sublevel = 3
				
	if level_1_2_limit <= GameManager.enemy_killed and current_sublevel == 1:
		GameManager.enemy_spawn_timer_min = 1.0
		GameManager.enemy_spawn_timer_max = 3.5
		current_sublevel = 2
		enemy_2_probability = 50
		enemy_3_probability = 20
		
	if level_1_1_limit <= GameManager.enemy_killed and current_sublevel == 0:
		GameManager.enemy_spawn_timer_min = 1.5
		GameManager.enemy_spawn_timer_max = 4.0
		current_sublevel = 1
		enemy_2_probability = 20
		enemy_3_probability = 10
		

func _on_enemy_spawn_timer_timeout():
	if !GameManager.is_final_blitz:
		spawn_enemy()
	
	
func spawn_enemy():	
	var e
	var rnd = randi_range(0,100)
	if enemy_3_probability >= rnd:
		e = enemy_3.instantiate() as Node2D
	elif enemy_2_probability >=rnd:
		e = enemy_2.instantiate() as Node2D
	else:
		e = enemy_1.instantiate() as Node2D
	
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
	var enemies = get_tree().root.get_children()
	for e in enemies:
		if e.is_in_group("enemy"):
			e.queue_free()
