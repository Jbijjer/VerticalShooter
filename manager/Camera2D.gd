extends Camera2D

var target : Node2D
var shake_strength := 0.0

func _ready():
		if get_parent().has_node("player"):
				target = get_parent().get_node("player")

func _process(delta):
		if target:
				global_position = target.global_position
		if shake_strength > 0.0:
				offset = Vector2(
						randf_range(-shake_strength, shake_strength),
						randf_range(-shake_strength, shake_strength)
				)
				shake_strength = lerp(shake_strength, 0.0, delta * 5)
		else:
				offset = Vector2.ZERO

func add_shake(amount : float):
		shake_strength = max(shake_strength, amount)
