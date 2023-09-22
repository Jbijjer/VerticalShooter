extends Label


func _ready():
	SignalManager.score_updated.connect(on_score_updated)

	
func on_score_updated(points: int):
	text = str("SCORE : ",ScoreManager.score)
