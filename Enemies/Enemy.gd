extends CharacterBody2D

@onready var player = get_tree().get_first_node_in_group("Player")

@export var speed = 200

var screen_size

func _ready():
	screen_size = get_viewport_rect().size
	add_to_group("Enemies", true)
	

func _physics_process(delta):
	
	$AnimatedSprite2D.play()
	
	velocity.x = player.get_position().x - position.x
	velocity.y = player.get_position().y - position.y

	if velocity.length() > 0:
		velocity = velocity.normalized() * speed

	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)
	
	if velocity.x < 0:
		$AnimatedSprite2D.flip_h = true
	else:
		$AnimatedSprite2D.flip_h = false
	
	
