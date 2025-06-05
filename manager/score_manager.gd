extends Node

var score: int = 0
var high_score: int = 0
var score_needed_base = 500
var score_needed_growth = 750
var level_up_score_needed = 500

const SAVE_PATH := "user://high_score.save"

func _ready():
        SignalManager.score_updated.connect(on_score_updated)
        SignalManager.level_up.connect(on_level_up)
        load_high_score()
	
	
func on_score_updated(amount: int):
        score += (amount * ComboManager.cur_combo_multiplier)
        if (score >= level_up_score_needed):
                SignalManager.level_up.emit()
        if score > high_score:
                high_score = score
                save_high_score()


func on_level_up():
        score_needed_base += score_needed_growth
        level_up_score_needed += score_needed_base


func reset():
        ScoreManager.score = 0
        ScoreManager.level_up_score_needed = 500
        ScoreManager.score_needed_base = 500
        ScoreManager.score_needed_growth = 750

func load_high_score():
        if FileAccess.file_exists(SAVE_PATH):
                var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
                high_score = int(file.get_line())
                file.close()

func save_high_score():
        var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
        file.store_line(str(high_score))
        file.close()
