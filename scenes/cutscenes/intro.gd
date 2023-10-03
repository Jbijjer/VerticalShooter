extends Node
@onready var animation_player = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	animation_player.play("cutscene")


func _input(event):
	if event.is_action_pressed("Enter"):
		SoundManager.stop_intro_music()
		get_tree().change_scene_to_file("res://scenes/cutscenes/level1_begin.tscn")
