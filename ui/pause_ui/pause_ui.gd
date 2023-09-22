extends CanvasLayer

@onready var label = $Label


func _ready():
	SignalManager.pause_game.connect(on_pause_game)
	


func _process(delta):
	if Input.is_action_just_pressed("Pause"):
		SignalManager.pause_game.emit()
			

func on_pause_game():
	if(!GameManager.is_paused and !GameManager.is_leveling_up):
		label.show()
		GameManager.is_paused = true
	else:
		label.hide()
		GameManager.is_paused = false
			
