extends Node


func _input(event):
	if event.is_action_pressed("Enter"):
		start_game()
		

func _process(delta):
#	if Input.is_even):
#		start_game()
	pass	


func _on_button_pressed():
	start_game()


func start_game():
	GameManager.new_game()
