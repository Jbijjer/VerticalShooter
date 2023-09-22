extends Node

var score: int = 0
var level_up_score_needed = 500
var score_needed_growth = 250

func _ready():
	SignalManager.score_updated.connect(on_score_updated)
	SignalManager.level_up.connect(on_level_up)
	
	
func on_score_updated(amount: int):
	score += (amount * ComboManager.cur_combo_multiplier)
	if (score >= level_up_score_needed):
		SignalManager.level_up.emit()


func on_level_up():
	level_up_score_needed += score_needed_growth + ScoreManager.score
