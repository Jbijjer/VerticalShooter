extends CanvasLayer

@onready var label = $MC/Label

func _ready():
	SignalManager.player_died.connect(on_player_died)


func _process(delta):
	if Input.is_action_just_pressed("Pause"):
		GameManager.pause_game()
	

func on_player_died():
	label.show()
	
