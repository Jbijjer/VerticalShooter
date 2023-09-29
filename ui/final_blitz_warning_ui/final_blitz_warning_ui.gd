extends CanvasLayer

@onready var animation_player = $Label/AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	SignalManager.final_blitz_warning.connect(on_final_blitz_warning)
	SignalManager.start_final_blitz.connect(on_start_final_blitz)
	SignalManager.level_finished.connect(on_level_finished)

func on_final_blitz_warning():
	animation_player.play("flash")
	show()


func on_start_final_blitz():
	hide()


func on_level_finished():
	hide()
