extends Node

var main_scene: PackedScene = preload("res://scenes/level/level.tscn")

var HP: float = 3.0
var MAX_HP: float = 3.0
var is_game_over = false


func _ready():
	pass
	
	
func pause_game():	
	if !is_game_over:
		get_tree().paused = !get_tree().paused 
	else:
		new_game()
	
	
func new_game():
	ScoreManager.score = 0
	ScoreManager.level_up_score_needed = 1000
	ScoreManager.score_needed_growth = 500
	is_game_over = false
	get_tree().paused = false
	load_main_scene()
	
	
func load_main_scene() -> void:
	get_tree().change_scene_to_packed(main_scene)

