extends Node

var cur_combo_multiplier = 1
var max_combo = 3.0
var combo_growth = 0.05
var cur_combo_count = 0


func _ready():
	SignalManager.combo_reset.connect(on_combo_reset)
	SignalManager.combo_increase.connect(on_combo_increase)

func on_combo_reset():
	cur_combo_multiplier = 1
	cur_combo_count = 0
	
func on_combo_increase():
	cur_combo_count += 1
	if (cur_combo_multiplier < max_combo):
		cur_combo_multiplier += combo_growth
	if cur_combo_multiplier > max_combo:
		cur_combo_multiplier = max_combo


func reset():	
	ComboManager.cur_combo_multiplier = 1
	ComboManager.max_combo = 2.0
	ComboManager.combo_growth = 0.05
	ComboManager.cur_combo_count = 0
