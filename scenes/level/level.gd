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

var enemy = preload("res://scenes/enemy/enemy.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	clean_scene()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_enemy_spawn_timer_timeout():
	spawn_enemy()
	
	
func spawn_enemy():	
	var e = enemy.instantiate() as Node2D
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
	enemy_spawn_timer.wait_time = randi_range(2, 4)
	

func clean_scene():
	var enemies = get_tree().root.get_children()
	for e in enemies:
		if e.is_in_group("enemy"):
			e.queue_free()
