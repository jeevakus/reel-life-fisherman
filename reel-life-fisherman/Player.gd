extends Area2D
export var speed = 400 # How fast the player will move (pixels/sec).
var screen_size # Size of the game window.


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	$Sprite.position.x = $AnimatedSprite.position.x - 30
	$Sprite.position.y = $AnimatedSprite.position.y + 12



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
		$AnimatedSprite.animation = "idle"
		$AnimatedSprite.z_index = 0
		
		
	position += velocity * delta
	position.x = clamp(position.x,0,screen_size.x-100)
	
	if velocity.x != 0:
		#$AnimatedSprite.animation = "row"
		if velocity.x < 0:
			$Sprite.position.x = $AnimatedSprite.position.x + 30
			$AnimatedSprite.flip_h = true
			$Sprite.flip_h = true
		else:
			$Sprite.position.x = $AnimatedSprite.position.x - 30
			$AnimatedSprite.flip_h = false
			$Sprite.flip_h = false
		

		
		
