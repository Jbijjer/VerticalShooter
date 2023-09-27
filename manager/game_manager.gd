extends Node

var is_game_over = false
var is_paused = false
var is_leveling_up = false
var level = 1
var enemy_spawn_timer_max = 3.5
var enemy_spawn_timer_min = 2
var enemy_killed = 0
var is_final_blitz = false


func _ready():
	SignalManager.pause_game.connect(on_pause_game)
	SignalManager.enemy_explodes.connect(on_enemy_explodes)
	SignalManager.start_final_blitz.connect(on_final_blitz)
	
	
func on_pause_game():	
	get_tree().paused = !get_tree().paused 	
	
	
func on_enemy_explodes():
	enemy_killed += 1
	
	
func on_final_blitz():
	is_final_blitz = true
	
	
	
func new_game():
	ScoreManager.reset()
	ComboManager.reset()
	WeaponManager.reset()
	PlayerManager.reset()
	is_game_over = false
	is_paused = false
	enemy_killed = 0
	get_tree().paused = false
	load_level_1()
	
	
func load_level_1() -> void:
	get_tree().change_scene_to_file(LevelManager.level1_scene)

