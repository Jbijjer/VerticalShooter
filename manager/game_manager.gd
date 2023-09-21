extends Node

var main_scene: PackedScene = preload("res://scenes/main/main.tscn")

var XP: int = 0
var level_up_xp_needed = 5
var xp_needed_growth = 5
var is_game_over = false


func _ready():
	SignalManager.level_up.connect(on_level_up)
	SignalManager.player_died.connect(on_player_died)
	
	
func pause_game():	
	if !is_game_over:
		get_tree().paused = !get_tree().paused 
	else:
		new_game()


func get_xp():
	return XP


func on_level_up():
	XP = 0
	level_up_xp_needed += xp_needed_growth
	
	
func update_xp(amount: int):
	XP += amount
	if (XP >= level_up_xp_needed):
		SignalManager.level_up.emit()


func on_player_died():
	is_game_over = true
	get_tree().paused = true
	
	
func new_game():
	XP = 0
	level_up_xp_needed = 5
	xp_needed_growth = 5
	is_game_over = false
	get_tree().paused = false
	load_main_scene()
	
	
func load_main_scene() -> void:
	get_tree().change_scene_to_packed(main_scene)

