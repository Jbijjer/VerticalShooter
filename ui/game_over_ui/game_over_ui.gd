extends Node
@onready var title_label = $CanvasLayer/TitleLabel
@onready var text_game_over = $CanvasLayer/TextGameOver


func _ready():
	SignalManager.player_died.connect(on_player_died)
	
	
func _process(delta):
	if GameManager.is_game_over:
		if Input.is_action_just_pressed("Pause"):
			GameManager.on_pause_game()
			title_label.hide()
			text_game_over.hide()
			GameManager.new_game()
	
	
func on_player_died():
	title_label.show()
	text_game_over.play()
	text_game_over.show()
	GameManager.is_game_over = true
	GameManager.on_pause_game()
