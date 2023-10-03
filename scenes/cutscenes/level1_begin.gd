extends Node

var intro_animation_finished = false
var label1_shown = false
var label2_3_shown = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$Control/player.is_animation_playing = true
	$ConversationCanvas/Label1.visible = false
	
	
func _process(delta):
	intro_animation()	
			
			
func _input(InputEvent):
	if Input.is_action_just_pressed("Enter"):
		if (label1_shown):
			label1_shown = false
			$AnimationPlayer2.play("cutscene")
		if label2_3_shown:
			GameManager.new_game()
			
			
func finish_animation():
	label2_3_shown = true

	
func intro_animation():
	if intro_animation_finished:
		$Control/player.is_animation_playing = false
		return
	if $blueportal.get_animation() == "open":
		if !$blueportal.is_playing():
			$blueportal.play("idle")
			$Control/player/AnimationPlayer.play("exit_portal")
	if $blueportal.get_animation() == "idle":
		if !$Control/player/AnimationPlayer.is_playing():
			$blueportal.play("close")
	if $blueportal.get_animation() == "close":
		if !$blueportal.is_playing():	
			$AnimationPlayer1.play("cutscene")
			intro_animation_finished = true
			label1_shown = true


	
