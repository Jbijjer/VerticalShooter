extends CharacterBody2D
class_name Enemy

var hp = 1
var points = 100
var is_dying = false
var direction_x = 0
var direction_y = 1
var is_hidden = false
var is_dead = false

var speed = EnemyManager.speed


func process(sprite_2d: AnimatedSprite2D):
	if sprite_2d.get_animation() == "death":
		if sprite_2d.is_playing():
			if !is_dying:
				update_interface()
				is_dying = true
		else:
			is_dead = true
			
			
func move(gp: Vector2):
	if (!is_hidden):
		if gp.x >= 700:
			direction_x = -1
		if gp.x <= 10:
			direction_x = 1
		return Vector2(speed * direction_x, speed * direction_y)
	return Vector2.ZERO
			

func update_interface():
	SignalManager.score_updated.emit(points)
	SignalManager.combo_increase.emit()	
	SignalManager.enemy_explodes.emit()	
	
		
func final_blitz():
	speed = EnemyManager.max_speed
	is_hidden = false


func hit(power: float, sprite_2d: AnimatedSprite2D):
	if (!is_hidden):
		if hp > 0:
			hp -= power
			if hp <= 0:
				speed = 0
				sprite_2d.play("death")
				sprite_2d.rotation = randi_range(0,360)
				
				
func shoot(laser: PackedScene, gp: Vector2):
	if (!is_hidden):
		if hp > 0:
			var l = laser.instantiate()
			l.is_player_weapon = false
			l.shoot(Vector2(gp.x, gp.y + 40), false)
			return l
		return null
	return null
	
	
func exited_screen():
	if(!GameManager.is_final_blitz):
		is_hidden = true
		SignalManager.enemy_saved.emit()
	
	
func check_if_hit(area: Area2D, sprite_2d: AnimatedSprite2D):
	if hp > 0:
		if area.is_in_group("weapon"):
			if (area.is_player_weapon):
				hit(WeaponManager.weapon_power, sprite_2d)
				
				
func check_if_player_collision(area: Area2D, sprite_2d: AnimatedSprite2D):
	if hp > 0:
		if area.is_in_group("player"):
				hit(100.0, sprite_2d)
