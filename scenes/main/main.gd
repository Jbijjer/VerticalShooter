extends Node
@onready var enemy_spawn_timer = $EnemySpawnTimer

var enemy = preload("res://scenes/enemy/enemy.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	clean_scene()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_enemy_spawn_timer_timeout():
	spawn_enemy()
	
	
func spawn_enemy():	
	var e = enemy.instantiate() as Node2D
	get_tree().root.add_child(e)
	e.global_position.x = randf_range(25,690)
	e.global_position.y = -25	
	enemy_spawn_timer.wait_time = randi_range(2, 5)
	

func clean_scene():
	var enemies = get_tree().root.get_children()
	for e in enemies:
		if e.is_in_group("enemy"):
			e.queue_free()
