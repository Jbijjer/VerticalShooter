extends Node


func _ready():
	SignalManager.weapon_update.connect(on_weapon_update)
	SignalManager.speed_update.connect(on_speed_update)
	SignalManager.weapon_speed_update.connect(on_weapon_speed_update)


func on_weapon_update():
	$Weapon/Label.text = str(": ", WeaponManager.level)
	$Weapon/AnimationPlayer.play("flash")
	
	
func on_speed_update():
	$Speed/Label2.text = str(": ", PlayerManager.speed_level)
	$Speed/AnimationPlayer2.play("flash")
	
	
func on_weapon_speed_update():
	$WeaponSpeed/Label2.text = str(": ", PlayerManager.weapon_speed_level)
	$WeaponSpeed/AnimationPlayer2.play("flash")
