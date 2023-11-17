extends Area2D

signal hit

@export var speed = 400
var screen_size

# this function sets up the script
func _ready():
	screen_size = get_viewport_rect().size
	hide() # hide player

# this function is called every frame
func _process(delta):
	
	$AnimatedSprite2D.play()
	
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("up"):
		velocity.y -= 1
	if Input.is_action_pressed("down"):
		velocity.y += 1
	if Input.is_action_pressed("left"):
		velocity.x -= 1
	if Input.is_action_pressed("right"):
		velocity.x += 1
	
	# normalise velocity to be in range 0-1 and multiply by speed
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)
	
	# flip animation based on direction
	if velocity.x < 0:
		$AnimatedSprite2D.flip_h = true
	else:
		$AnimatedSprite2D.flip_h = false

# called when something collides with player
func _on_body_entered(body):
	hide()
	hit.emit()
	$CollisionShape2D.set_deferred("disabled", true) # disable player collision

# start the game
func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false
