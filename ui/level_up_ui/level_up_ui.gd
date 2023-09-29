extends CanvasLayer

@onready var title_label = $MC/VBoxContainer/TitleLabel
@onready var timer = $Timer
@onready var audio_stream_player = $AudioStreamPlayer


func _ready():
	SignalManager.level_up.connect(on_level_up)	

	
func _process(delta):
	if timer.is_stopped():
		if (GameManager.is_leveling_up):
			if Input.is_action_just_pressed("Left"):
				if PlayerManager.lives < 3:
					_on_lifeup_pressed()
			elif Input.is_action_just_pressed("Down"):
				_on_speedup_pressed()
			elif Input.is_action_just_pressed("Right"):
				_on_damageup_pressed()
			elif Input.is_action_just_pressed("Up"):
				_on_weaponspeedup_pressed()

func on_level_up():
	timer.start()
	show()
	audio_stream_player.play()
	GameManager.is_leveling_up = true
	SignalManager.pause_game.emit()
	var weapons = get_tree().get_nodes_in_group("weapon")
	for weapon in weapons:
		weapon.queue_free()


func _on_lifeup_pressed():
	if PlayerManager.lives == 3:
		PlayerManager.lives += 1
		SignalManager.player_heal.emit()
		quit_upgrades()


func _on_weaponspeedup_pressed():
	if PlayerManager.weapon_speed_level > 0.1:
		PlayerManager.increase_max_weapon_speed(1)
		SignalManager.weapon_speed_update.emit()
		quit_upgrades()


func _on_speedup_pressed():
	PlayerManager.increase_max_speed(1)
	SignalManager.speed_update.emit()
	quit_upgrades()


func _on_damageup_pressed():
	if WeaponManager.level <= 4:
		WeaponManager.increase_weapon_power(1)
		SignalManager.weapon_update.emit()
		quit_upgrades()
	
	
func quit_upgrades():	
	hide()
	SignalManager.pause_game.emit()
	GameManager.is_leveling_up = false
