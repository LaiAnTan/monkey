extends CanvasLayer

func _ready():
	$Player.connect("hit", update_health_bar)
	$ProgressBar.max_value = $Player.max_health
	
func update_health_bar():
	$ProgressBar.value = $Player.health
