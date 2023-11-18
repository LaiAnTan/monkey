extends Node2D

@export var mob_scene: PackedScene
@export var player_scene: PackedScene
@export var hud_scene: PackedScene

var score

func _ready():
	new_game()

func game_over():
	$MobTimer.stop()

func new_game():
	
	# clear mobs
	get_tree().call_group("Enemies", "queue_free")
	
	var hud = hud_scene.instantiate()
	add_child(hud)
	
	score = 0
	
	var player = player_scene.instantiate()
	add_child(player)
	
	$Player.connect("death", game_over)
	$Player.start($StartPosition.position)
	$StartTimer.start()

func _on_start_timer_timeout():
	$MobTimer.start()

func _on_mob_timer_timeout():
	
	var mob = mob_scene.instantiate()
	
	var mob_spawn_location = get_node("MobPath/MobSpawnLocation")
	mob_spawn_location.progress_ratio = randf()

	# Set the mob's position to a random location.
	mob.position = mob_spawn_location.position

	# Spawn the mob by adding it to the Main scene.
	add_child(mob)
