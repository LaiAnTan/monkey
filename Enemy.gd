extends Area2D

@onready var player = get_node("/root/main.tscn/Player")

func _ready():
	pass

func _process(_delta):
	
	$AnimatedSprite2D.play()
	
	var velocity = Vector2.ZERO

