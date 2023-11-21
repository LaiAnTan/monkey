extends CanvasLayer

@onready var health_bar = $HealthBar

func update_health_bar(health: int) -> void:
	print("update_health_bar called")
	health_bar.value = health
