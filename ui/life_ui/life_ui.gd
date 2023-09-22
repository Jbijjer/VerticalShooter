extends Node

@onready var progress_bar = $ProgressBar

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
	progress_bar.value = GameManager.HP
	progress_bar.max_value = GameManager.MAX_HP
	
