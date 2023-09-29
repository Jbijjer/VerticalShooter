extends CanvasLayer

# Called when the node enters the scene tree for the first time.
func _ready():
	SignalManager.flawless_victory.connect(on_flawless_victory)


func on_flawless_victory():
	show()

