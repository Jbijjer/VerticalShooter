extends CharacterBody2D

const SPEED = 150.0

func _physics_process(delta):
	velocity = Vector2(0, -SPEED)
	move_and_slide()	


func _on_body_entered(body):
	if body.is_class("enemy"):
		queue_free()
	

 # Replace with function body.
