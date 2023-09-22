extends CanvasLayer

@onready var title_label = $MC/VBoxContainer/TitleLabel

func _ready():
	SignalManager.level_up.connect(on_level_up)	


func on_level_up():
	show()
	GameManager.is_leveling_up = true
	GameManager.level += 1
	SignalManager.pause_game.emit()


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
