extends Node


func _ready():
	$blueportal.play("open")
	SoundManager.play_intro_music()


func _process(delta):
	if $blueportal.get_animation() == "open":
		if !$blueportal.is_playing():
			$blueportal.play("idle")


func _input(event):
	if event.is_action_pressed("Enter"):
		SoundManager.stop_intro_music()
		start_game()


func start_game():
	get_tree().change_scene_to_file(CutsceneManager.intro_scene)


func _on_timer_timeout():
	$MeteorBrownBig1/AnimationPlayer.play("travel")
