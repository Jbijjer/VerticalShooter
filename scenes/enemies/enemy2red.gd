extends Enemy


func _ready():
	direction_x = randi_range(0,1)
	if direction_x == 0:
		direction_x = -1
