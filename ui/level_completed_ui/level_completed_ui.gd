extends CanvasLayer
@onready var title_label = $TitleLabel
var level2_scene = preload("res://scenes/levels/level2/level2.tscn")

func _ready():
	SignalManager.level_finished.connect(on_level_finished)
	GameManager.level += 1
	
func _process(delta):
	if title_label.visible == true:
		if Input.is_action_just_pressed("Shoot"):
			if GameManager.level == 2:
				get_tree().change_scene_to_packed(level2_scene)
	
	
func on_level_finished():
	title_label.show()
	GameManager.on_pause_game()
