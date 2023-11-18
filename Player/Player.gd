extends CharacterBody2D

signal hit
signal death

@export var max_speed = 400
@export var accel = 1500
@export var friction = 500
@export var max_health = 10

@onready var axis = Vector2.ZERO
@onready var softCollision = $SoftCollision

var screen_size
var health

# this function sets up the script
func _ready():
	screen_size = get_viewport_rect().size
	health = max_health

	add_to_group("Player", true)
	
	hide() # hide player

# this function is called every frame
func _physics_process(delta):
	move(delta)
	
func get_input_axis():
	
	axis.x = int(Input.is_action_pressed("right")) - int(Input.is_action_pressed("left"))
	axis.y = int(Input.is_action_pressed("down")) - int(Input.is_action_pressed("up"))
	
	return axis.normalized()

func move(delta):
	
	axis = get_input_axis()
	
	if axis == Vector2.ZERO:
		#apply_friction(friction * delta)
		velocity = Vector2.ZERO
	else:
		apply_movement(axis * accel * delta)
		
	move_and_slide()
	
func apply_friction(amount):
	if velocity.length() > amount:
		velocity -= velocity.normalized()
	else:
		velocity = Vector2.ZERO
	
func apply_movement(acceleration):
	velocity += acceleration
	velocity = velocity.limit_length(max_speed)
	
func damage_player():
	health -= 1
	if (health <= 0):
		death.emit()

func disable_enemy_hitbox(body, secs):
	
	# give the enemy a cooldown before it can hit the player again
	var enemy_hitbox = body.get_node("EnemyHitbox")
	enemy_hitbox.set_deferred("disabled", true)
	
	var cooldown = Timer.new();
	
	cooldown.set_wait_time(secs)
	cooldown.set_one_shot(true)
	body.add_child(cooldown)
	cooldown.start()
	
	await cooldown.timeout # wait until timer ends
	
	enemy_hitbox.disabled = false
	cooldown.queue_free()

func _on_body_entered(body): # this broke
	
	hit.emit()
	print("Player was hit")
	damage_player()
	disable_enemy_hitbox(body, 2)

# init the player
func start(pos):
	position = pos
	show()
	$PlayerHitbox.disabled = false
	$AnimatedSprite2D.play("walk")

func _on_death():
	$AnimatedSprite2D.play("death")
	$PlayerHitbox.set_deferred("disabled", true) # disable player collision
