extends Label

# Called when the node enters the scene tree for the first time.
func _ready():
	SignalManager.enemy_saved.connect(on_enemy_saved)


func on_enemy_saved():
	text = str("ENEMY SAVED : ",GameManager.enemy_saved)

