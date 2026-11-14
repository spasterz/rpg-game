extends CharacterBody2D

var speed : int = 100
var direction : Vector2
var is_attacking : bool
@onready var sprite : AnimatedSprite2D = $AnimatedSprite2D
@onready var attack_timer : Timer = $attack_timer
var current_direction : String = "down"

func _ready() -> void:
	pass
	
func _process(delta: float) -> void:
	direction = Input.get_vector("left", "right", "up", "down")
	
	if Input.is_action_just_pressed("attack"):
		if attack_timer.is_stopped():
			print("player attack")
			player_attack()
	
	if direction == Vector2.ZERO && is_attacking == false:
		if current_direction == "down":
			sprite.play("idle")
		elif current_direction == "up":
			sprite.play("up-walk")
			sprite.pause()
			sprite.frame = 2
		elif current_direction == "right":
			sprite.play("side-walk")
			sprite.pause()
			sprite.frame = 2
		elif current_direction == "left":
			sprite.play("side-walk")
			sprite.pause()
			sprite.frame = 2
		
		
	if direction != Vector2.ZERO && is_attacking == false:
		velocity = direction * speed
		if abs(direction.x) > abs(direction.y):
			if direction.x > 0:
				sprite.flip_h = false
				sprite.play("side-walk")
				current_direction = "right"			
			else:
				sprite.flip_h = true
				sprite.play("side-walk")
				current_direction = "left"
		else:
			if direction.y > 0:
				sprite.play("down-walk")
				current_direction = "down"
			else:
				sprite.play("up-walk")
				current_direction = "up"
		
		move_and_slide()
	
func player_attack():
	is_attacking = true
	attack_timer.start()
	velocity = Vector2.ZERO
	
	if current_direction == "right" || current_direction == "left":
		sprite.play("side-attack")
	elif current_direction == "down":
		sprite.play("down-attack")
	elif current_direction == "up":
		sprite.play("up-attack")

func _on_animated_sprite_2d_animation_finished() -> void:
	if sprite.animation == "side-attack" || sprite.animation == "down-attack" || sprite.animation == "up-attack":
		is_attacking = false
		print(is_attacking)
		
