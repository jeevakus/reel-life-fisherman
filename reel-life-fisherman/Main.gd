extends Node

export(PackedScene) var fish_scene
signal score

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	$Player.start($StartPosition.position)
	$Player.show()
	$Music.play()

func new_game():
	$StartTimer.start()
	$HUD.show_message("Get Ready")

func _on_StartTimer_timeout():
	$FishTimer.start()
	
func _on_FishTimer_timeout():
	# Create a new instance of the Fish scene.
	var fish = fish_scene.instance()

	# Choose a random location on Path2D
	var fish_spawn_location = get_node("FishPath/FishSpawnLocation")
	fish_spawn_location.offset = randi()

	# Set the fish's direction to only left-and-right
	var direction = fish_spawn_location.rotation + PI/2
	if (abs(direction) > 0+1 && abs(direction) < PI-1) || (abs(direction) > PI + 1 && abs(direction) < 3*PI/2 +1):
		direction += PI/2 

	# Set the fish's position and direction
	fish.position = fish_spawn_location.position + Vector2(0.0,200.0)
	fish.rotation = direction
		
	# Choose the velocity for the fish.
	var velocity = Vector2(rand_range(100.0, 150.0), 0.0)
	fish.linear_velocity = velocity.rotated(direction)

	# Spawn the fish by adding it to the Main scene.
	add_child(fish)

# Reference of Animation Player from NULL Game Dev
func _on_Player_fish():
	if get_node("AnimationPlayer").current_animation != "Hook":
		get_node("AnimationPlayer").play("Fish")

func _on_Player_hook():
	if get_node("AnimationPlayer").current_animation != "Fish":
		get_node("AnimationPlayer").play("Hook")

func _on_Hook_body_entered(body):
	body.queue_free()
	emit_signal("score")
