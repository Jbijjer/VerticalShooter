extends CanvasLayer
@onready var title_label = $TitleLabel
@onready var sub_title = $TitleLabel/SubTitle

func _ready():
	SignalManager.level_finished.connect(on_level_finished)
	
	
func _process(delta): 
	if visible == true:
		if Input.is_action_just_pressed("Enter"):
			GameManager.on_pause_game()		
			GameManager.is_final_blitz = false		
			if GameManager.level == 2:
				get_tree().change_scene_to_file(LevelManager.level2_scene)
			elif GameManager.level == 3:
				get_tree().change_scene_to_file(LevelManager.level3_scene)
	if GameManager.level == 2:
		$TextGameOver.text = "   
								  THE INTERCEPTOR :
								  Fugitive escaped... Don't loose him... 
Call for back ups!"
	if GameManager.level == 3:
		$TextGameOver.text = "   
								  THE INTERCEPTOR :
								  GO AWAY! I'LL TAKE CARE OF HIM!"
	
	
func on_level_finished():
	GameManager.enemy_spawn_timer_min = 2
	GameManager.enemy_spawn_timer_max = 3.5
	GameManager.level += 1
	GameManager.enemy_killed = 0
	GameManager.enemy_missed = 0
	show()
	GameManager.on_pause_game()
