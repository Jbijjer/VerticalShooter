extends CanvasLayer
@onready var title_label = $TitleLabel


func _ready():
	SignalManager.player_died.connect(on_player_died)
	SignalManager.level_finished.connect(on_player_died)
	
	
func _process(delta):
	if GameManager.is_game_over:
		if Input.is_action_just_pressed("Pause"):
			GameManager.on_pause_game()
			title_label.hide()
			GameManager.new_game()
	
	
func on_player_died():
	title_label.show()
	GameManager.is_game_over = true
	GameManager.on_pause_game()
