extends BaseLevel

var enemy2red = preload("res://scenes/enemies/enemy2red.tscn")
var enemy1green = preload("res://scenes/enemies/enemy1green.tscn")
var enemy2green = preload("res://scenes/enemies/enemy2green.tscn")

var level_1_limit = 5
var level_2_limit = 10
var level_3_limit = 15

var is_fighting_boss : bool = false
var is_screen_shaken : bool = false

func _ready():
	enemy_scenes = [enemy2red, enemy1green, enemy2green]
	sublevel_limits = [level_1_limit, level_2_limit, level_3_limit]
	sublevel_configs = [
		{"probabilities": [70, 20, 10]},
		{"timer_min": 1.5, "timer_max": 3.0, "probabilities": [40, 30, 30]},
		{"timer_min": 1.0, "timer_max": 2.0, "probabilities": [30, 30, 40]}
	]
	update_ui()
	super._ready()

func update_ui():
	SignalManager.speed_update.emit(false)
	SignalManager.score_updated.emit(0)
	SignalManager.weapon_speed_update.emit(false)
	SignalManager.weapon_update.emit(false)
	SignalManager.combo_update.emit()

func _process(delta):
	super._process(delta)
	if is_screen_shaken:
		shake(3)

func verify_progress():
	if level_3_limit <= GameManager.enemy_killed and current_sublevel == 3:
		if is_fighting_boss:
			move_boss()
		else:
			GameManager.is_final_blitz = true
			SignalManager.boss_fight_start.emit()
			is_screen_shaken = true
			$ScreenShakeTimer.start()
			$red_boss.is_hidden = false
			is_fighting_boss = true
			move_boss()
	else:
		super.verify_progress()

func move_boss():
	$red_boss.move()

func shake(amount: float):
	$Camera2D.add_shake(amount)

func _on_screen_shake_timer_timeout():
	is_screen_shaken = false
