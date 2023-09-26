extends ProgressBar


func _ready():
	SignalManager.score_updated.connect(on_score_updated)
	SignalManager.level_up.connect(on_level_up)
	max_value = ScoreManager.level_up_score_needed

	
func on_score_updated(points: int):
	value += points * ComboManager.cur_combo_multiplier


func on_level_up():
	value = 0
	max_value = ScoreManager.score_needed_base + ScoreManager.score_needed_growth
	
