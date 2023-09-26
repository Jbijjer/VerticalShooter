extends Node

@onready var life_1 = $Life1
@onready var life_2 = $Life2
@onready var life_3 = $Life3

# Called when the node enters the scene tree for the first time.
func _ready():
	SignalManager.player_hit.connect(on_player_hit)
	SignalManager.player_heal.connect(on_player_heal)
	update_hp()


func on_player_hit():
	update_hp()
		

func on_player_heal():
	update_hp()
	
	
func update_hp():
	if (PlayerManager.lives == 3):
		life_3.show()
		life_2.show()
		life_1.show()
	elif (PlayerManager.lives == 2):
		life_3.hide()
		life_2.show()
		life_1.show()
	elif (PlayerManager.lives == 1):
		life_3.hide()
		life_2.hide()
		life_1.show()
	elif (PlayerManager.lives == 0):
		life_3.hide()
		life_2.hide()
		life_1.hide()
	
