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
					_on_upgrade_1_pressed()
			elif Input.is_action_just_pressed("Down"):
				_on_upgrade_3_pressed()
			elif Input.is_action_just_pressed("Right"):
				_on_upgrade_4_pressed()

func on_level_up():
	timer.start()
	show()
	audio_stream_player.play()
	GameManager.is_leveling_up = true
	SignalManager.pause_game.emit()
	var weapons = get_tree().get_nodes_in_group("weapon")
	for weapon in weapons:
		weapon.queue_free()


func _on_upgrade_1_pressed():
	PlayerManager.lives += 1
	SignalManager.player_heal.emit()
	quit_upgrades()


func _on_upgrade_3_pressed():
	PlayerManager.increase_max_speed(1)
	SignalManager.speed_update.emit()
	quit_upgrades()


func _on_upgrade_4_pressed():
	WeaponManager.increase_weapon_power(1)
	SignalManager.weapon_update.emit()
	quit_upgrades()
	
	
func quit_upgrades():	
	hide()
	SignalManager.pause_game.emit()
	GameManager.is_leveling_up = false
