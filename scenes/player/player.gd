extends CharacterBody2D

const SPEED: float = 200.0

@export var laser = PackedScene


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("Shoot"):
		get_parent().add_child(laser)
	
	
func _physics_process(delta):
	if Input.is_action_pressed("Right"):
		velocity = Vector2(SPEED, 0)
	elif Input.is_action_pressed("Left"):
		velocity = Vector2(-SPEED, 0) 
	else:
		velocity = Vector2.ZERO
	move_and_slide()
