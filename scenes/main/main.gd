extends Node

var enemy = preload("res://scenes/enemy/enemy.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_timer_timeout():
	var e = enemy.instantiate()
	get_tree().root.add_child(e)
	# Replace with function body.
