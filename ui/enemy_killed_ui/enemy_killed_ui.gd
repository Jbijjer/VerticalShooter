extends Label

# Called when the node enters the scene tree for the first time.
func _ready():
	SignalManager.enemy_explodes.connect(on_enemy_explodes)


func on_enemy_explodes():
	text = str("ENEMY KILLED : ",GameManager.enemy_killed)

