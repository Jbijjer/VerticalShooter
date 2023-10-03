extends GPUParticles2D


var timeCreated = Time.get_ticks_msec()
@onready var audio_stream_player = $AudioStreamPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	audio_stream_player.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Time.get_ticks_msec() - timeCreated > 10000:
		queue_free()
