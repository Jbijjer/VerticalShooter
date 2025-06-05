extends BaseLevel

var enemy1 = preload("res://scenes/enemies/enemy1red.tscn")
var enemy2 = preload("res://scenes/enemies/enemy1green.tscn")
@onready var FinalBlitzMusic = $AudioStreamPlayer

var level_1_limit = 5
var level_2_limit = 10
var level_3_limit = 15

func _ready():
	enemy_scenes = [enemy1, enemy2]
	sublevel_limits = [level_1_limit, level_2_limit, level_3_limit]
	sublevel_configs = [
		{"probabilities": [100, 0]},
		{"timer_min": 1.5, "timer_max": 3.0, "probabilities": [70, 30]},
		{"timer_min": 1.0, "timer_max": 2.0, "probabilities": [45, 55]}
	]
	super._ready()
