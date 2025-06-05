class_name BaseLevel
extends Node

@onready var enemy_spawn_timer = $EnemySpawnTimer
@onready var enemy_spawners = [
$HBEnemySpawner/EnemySpawner1,
$HBEnemySpawner/EnemySpawner2,
$HBEnemySpawner/EnemySpawner3,
$HBEnemySpawner/EnemySpawner4,
$HBEnemySpawner/EnemySpawner5,
$HBEnemySpawner/EnemySpawner6,
$HBEnemySpawner/EnemySpawner7,
$HBEnemySpawner/EnemySpawner8
]

var enemy_scenes: Array[PackedScene] = []
var sublevel_limits: Array[int] = []
var sublevel_configs: Array = []
var enemy_probabilities: Array = []
var current_sublevel := 0

func _ready():
	clean_scene()
	SignalManager.final_blitz_warning.connect(on_final_blitz_warning)
	if sublevel_configs.size() > 0:
		apply_sublevel_config(0)

func _process(delta):
	verify_progress()	

func verify_progress():
	if sublevel_limits.size() >= 3:
		if GameManager.enemy_killed >= sublevel_limits[2] and current_sublevel == 3:
			GameManager.is_final_blitz = true
			if get_tree().get_nodes_in_group("enemy").size() <= 0:
				SignalManager.level_finished.emit()
				if has_node("AudioStreamPlayer"):
					$AudioStreamPlayer.stop()
		if GameManager.enemy_killed >= sublevel_limits[2] and current_sublevel == 2:
			enemy_spawn_timer.stop()
			var enemies = get_tree().get_nodes_in_group("enemy")
			if enemies.size() > 0:
				for enemy in enemies:
					if enemy.global_position.y <= -25:
						SignalManager.final_blitz_warning.emit()
						if has_node("AudioStreamPlayer"):
							$AudioStreamPlayer.play()
						current_sublevel = 3
						break
			current_sublevel = 3
	if GameManager.enemy_killed >= sublevel_limits[1] and current_sublevel == 1:
		apply_sublevel_config(2)
	if GameManager.enemy_killed >= sublevel_limits[0] and current_sublevel == 0:
		apply_sublevel_config(1)

func apply_sublevel_config(index:int) -> void:
	if index >= sublevel_configs.size():
		return
	var cfg = sublevel_configs[index]
	if cfg.has("timer_min"):
		GameManager.enemy_spawn_timer_min = cfg["timer_min"]
	if cfg.has("timer_max"):
		GameManager.enemy_spawn_timer_max = cfg["timer_max"]
	if cfg.has("probabilities"):
		enemy_probabilities = cfg["probabilities"]
	current_sublevel = index

func _on_enemy_spawn_timer_timeout():
	if !GameManager.is_final_blitz:
		spawn_enemy()

func spawn_enemy():
	if enemy_scenes.is_empty() or enemy_probabilities.is_empty():
		return
	var index = weighted_random(enemy_probabilities)
	var enemy = enemy_scenes[index].instantiate() as Node2D
	get_tree().root.add_child(enemy)
	var spawner_index = randi_range(0, enemy_spawners.size() - 1)
	enemy.global_position = enemy_spawners[spawner_index].global_position
	enemy_spawn_timer.wait_time = randf_range(GameManager.enemy_spawn_timer_min, GameManager.enemy_spawn_timer_max)
	enemy_spawn_timer.start()

func weighted_random(weights:Array) -> int:
	var total = 0
	for w in weights:
		total += w
	var rnd = randf_range(0.0, total)
	var cumulative = 0.0
	for i in range(weights.size()):
		cumulative += weights[i]
		if rnd < cumulative:
			return i
	return weights.size() - 1

func clean_scene():
	EnemyManager.speed = EnemyManager.MIN_SPEED
	var enemies = get_tree().root.get_children()
	for e in enemies:
		if e.is_in_group("enemy"):
			e.queue_free()

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
	SignalManager.start_final_blitz.emit()
