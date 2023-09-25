extends Node

var main_scene: PackedScene = preload("res://scenes/level/level.tscn")

var HP: float = 3.0
var MAX_HP: float = 3.0
var is_game_over = false
var is_paused = false
var is_leveling_up = false
var level = 0
var enemy_spawn_timer_max = 5
var enemy_spawn_timer_min = 2
var enemy_killed = 0
var enemy_saved = 0
var is_final_blitz = false


func _ready():
	SignalManager.pause_game.connect(on_pause_game)
	SignalManager.enemy_saved.connect(on_enemy_saved)
	SignalManager.enemy_explodes.connect(on_enemy_explodes)
	SignalManager.start_final_blitz.connect(on_final_blitz)
	
	
func on_pause_game():	
	get_tree().paused = !get_tree().paused 	
	
	
func on_enemy_explodes():
	enemy_killed += 1
	if (is_final_blitz):
		enemy_saved -= 1
		
		
func on_enemy_saved():
	enemy_saved += 1
	
	
func on_final_blitz():
	is_final_blitz = true
	
	
	
func new_game():
	ScoreManager.score = 0
	ScoreManager.level_up_score_needed = 500
	ScoreManager.score_needed_growth = 250
	ComboManager.cur_combo_multiplier = 1.0
	ComboManager.max_combo = 10.0
	ComboManager.combo_growth = 0.1
	ComboManager.cur_combo_count = 0
	level = 0
	HP = MAX_HP
	is_game_over = false
	is_paused = false
	enemy_killed = 0
	enemy_saved = 0
	get_tree().paused = false
	load_main_scene()
	
	
func load_main_scene() -> void:
	get_tree().change_scene_to_packed(main_scene)

