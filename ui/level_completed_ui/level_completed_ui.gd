extends CanvasLayer
@onready var title_label = $TitleLabel
@onready var sub_title = $TitleLabel/SubTitle

func _ready():
	SignalManager.level_finished.connect(on_level_finished)
	
func _process(delta): 
	if title_label.visible == true:
		if Input.is_action_just_pressed("Enter"):
			GameManager.on_pause_game()		
			GameManager.is_final_blitz = false		
			if GameManager.level == 2:
				get_tree().change_scene_to_file(LevelManager.level2_scene)
			elif GameManager.level == 3:
				get_tree().change_scene_to_file(LevelManager.level3_scene)
	
	
func on_level_finished():
	GameManager.enemy_spawn_timer_min = 2
	GameManager.enemy_spawn_timer_max = 3.5
	GameManager.enemy_killed = 0
	GameManager.level += 1
	title_label.show()
	sub_title.show()
	GameManager.on_pause_game()
