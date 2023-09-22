extends Label

# Called when the node enters the scene tree for the first time.
func _ready():
	SignalManager.combo_increase.connect(on_combo_increase)
	SignalManager.combo_reset.connect(on_combo_reset)


func on_combo_increase():
	text = str("COMBO : ",ComboManager.cur_combo_count)


func on_combo_reset():
	text = str("COMBO : 0")

