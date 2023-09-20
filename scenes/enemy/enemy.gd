extends CharacterBody2D

const SPEED = 100.0

func _physics_process(delta):
	velocity = Vector2(0, SPEED)
	
	move_and_slide()
