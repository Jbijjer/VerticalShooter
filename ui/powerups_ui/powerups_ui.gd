extends Node


func _ready():
	SignalManager.weapon_update.connect(on_weapon_update)
	SignalManager.speed_update.connect(on_speed_update)
	SignalManager.weapon_speed_update.connect(on_weapon_speed_update)


func on_weapon_update(flash: bool):
	$Weapon/Label.text = str(": ", WeaponManager.level)
	if flash:
		$Weapon/AnimationPlayer.play("flash")
	
	
func on_speed_update(flash: bool):
	$Speed/Label2.text = str(": ", PlayerManager.speed_level)
	if flash:
		$Speed/AnimationPlayer.play("flash")
	
	
func on_weapon_speed_update(flash: bool):
	$WeaponSpeed/Label2.text = str(": ", PlayerManager.weapon_speed_level)
	if flash:
		$WeaponSpeed/AnimationPlayer.play("flash")
