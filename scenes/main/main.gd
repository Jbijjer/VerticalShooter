extends Node


func _input(event):
	if event.is_action_pressed("Enter"):
		start_game()


func start_game():
	GameManager.new_game()
