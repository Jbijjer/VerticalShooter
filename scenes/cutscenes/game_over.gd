extends Label


# Called when the node enters the scene tree for the first time.
func _ready():
        visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.



func play():
        visible = true
        $AnimationPlayer.play("cutscene")
