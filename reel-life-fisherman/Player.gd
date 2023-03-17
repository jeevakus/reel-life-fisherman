extends Area2D

signal fish
signal hook

# Declare member variables here. 
export var speed = 400 # How fast the player will move (pixels/sec).
var screen_size # Size of the game window.

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	$Sprite.position.x = $AnimatedSprite.position.x - 45
	$Sprite.position.y = $AnimatedSprite.position.y + 10

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2.ZERO # The player's movement vector.
	
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
		
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite.animation = "row"
		$AnimatedSprite.z_index = 1
	else:
		if Input.is_action_pressed("fish_down"):
			$AnimatedSprite.animation = "fish"
			emit_signal("fish")
		elif Input.is_action_pressed("hook_up"):
			$AnimatedSprite.animation = "hook"
			emit_signal("hook")
		else:
			$AnimatedSprite.animation = "idle"
			$AnimatedSprite.z_index = 0
		
		
	position += velocity * delta
	position.x = clamp(position.x,0,screen_size.x)
	
	if velocity.x != 0:
		#$AnimatedSprite.animation = "row"
		if velocity.x < 0:
			$Sprite.position.x = $AnimatedSprite.position.x + 45
			$AnimatedSprite.flip_h = true
			$Sprite.flip_h = true
		else:
			$Sprite.position.x = $AnimatedSprite.position.x - 45
			$AnimatedSprite.flip_h = false
			$Sprite.flip_h = false

func start(pos):
	position = pos

		
		
