extends Node

var main_scene: PackedScene = preload("res://scenes/level/level.tscn")

var HP: float = 3.0
var MAX_HP: float = 3.0
var is_game_over = false
var is_paused = false
var is_leveling_up = false


func _ready():
	SignalManager.pause_game.connect(on_pause_game)
	
	
func on_pause_game():	
	get_tree().paused = !get_tree().paused 	
	
	
func new_game():
	ScoreManager.score = 0
	ScoreManager.level_up_score_needed = 500
	ScoreManager.score_needed_growth = 250
	HP = MAX_HP
	is_game_over = false
	is_paused = false
	get_tree().paused = false
	load_main_scene()
	
	
func load_main_scene() -> void:
	get_tree().change_scene_to_packed(main_scene)

