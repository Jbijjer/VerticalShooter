extends CanvasLayer

@onready var title_label = $MC/VBoxContainer/TitleLabel
@onready var timer = $Timer

func _ready():
	SignalManager.level_up.connect(on_level_up)
	

	
func _process(delta):
	if timer.is_stopped():
		if (GameManager.is_leveling_up):
			if Input.is_action_just_pressed("Left"):
				_on_upgrade_1_pressed()
			elif Input.is_action_just_pressed("Down"):
				_on_upgrade_3_pressed()
			elif Input.is_action_just_pressed("Right"):
				_on_upgrade_4_pressed()

func on_level_up():
	timer.start()
	show()
	GameManager.is_leveling_up = true
	GameManager.level += 1
	SignalManager.pause_game.emit()
	var weapons = get_tree().get_nodes_in_group("weapon")
	for weapon in weapons:
		weapon.queue_free()


func _on_upgrade_1_pressed():
	GameManager.MAX_HP += 1
	GameManager.HP += 1
	SignalManager.progress_bar_updated.emit()
	quit_upgrades()


func _on_upgrade_2_pressed():
	GameManager.HP = GameManager.MAX_HP
	SignalManager.player_heal.emit()
	quit_upgrades()


func _on_upgrade_3_pressed():
	ComboManager.combo_growth += 0.05
	quit_upgrades()


func _on_upgrade_4_pressed():
	WeaponManager.weapon_power += 0.5
	quit_upgrades()
	
	
func quit_upgrades():	
	hide()
	SignalManager.pause_game.emit()
	GameManager.is_leveling_up = false
