extends CanvasLayer

@onready var label = $Label
var is_paused = false


func _process(delta):
	if Input.is_action_just_pressed("Pause"):
		if(!is_paused):
			label.show()
			is_paused = true
			GameManager.pause_game()
		else:
			label.hide()
			is_paused = false
			GameManager.pause_game()
			
