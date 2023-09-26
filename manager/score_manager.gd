extends Node

var score: int = 0
var score_needed_base = 500
var score_needed_growth = 750
var level_up_score_needed = 500

func _ready():
	SignalManager.score_updated.connect(on_score_updated)
	SignalManager.level_up.connect(on_level_up)
	
	
func on_score_updated(amount: int):
	score += (amount * ComboManager.cur_combo_multiplier)
	if (score >= level_up_score_needed):
		SignalManager.level_up.emit()


func on_level_up():
	score_needed_base += score_needed_growth
	level_up_score_needed += score_needed_base


func reset():	
	ScoreManager.score = 0
	ScoreManager.level_up_score_needed = 500
	ScoreManager.score_needed_growth = 250
