extends BaseLevel

var enemy1 = preload("res://scenes/enemies/enemy1red.tscn")
var enemy2 = preload("res://scenes/enemies/enemy1green.tscn")
var enemy3 = preload("res://scenes/enemies/enemy2red.tscn")
@onready var final_blitz_music = $FinalBlitzMusic

var level_1_limit = 5
var level_2_limit = 10
var level_3_limit = 15

func _ready():
    enemy_scenes = [enemy1, enemy2, enemy3]
    sublevel_limits = [level_1_limit, level_2_limit, level_3_limit]
    sublevel_configs = [
        {"probabilities": [65, 35, 0]},
        {"timer_min": 1.5, "timer_max": 3.0, "probabilities": [70, 15, 15]},
        {"timer_min": 1.0, "timer_max": 2.0, "probabilities": [40, 30, 30]}
    ]
    update_ui()
    super._ready()

func update_ui():
    SignalManager.speed_update.emit(false)
    SignalManager.score_updated.emit(0)
    SignalManager.weapon_speed_update.emit(false)
    SignalManager.weapon_update.emit(false)
    SignalManager.combo_update.emit()

