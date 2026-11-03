extends CharacterBody2D

var speed : int = 100
var direction : Vector2
@onready var sprite : AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	direction = Input.get_vector("left", "right", "up", "down")
	velocity = direction * speed
	
	if direction != Vector2.ZERO:
		if abs(direction.x) > abs(direction.y):
			if direction.x > 0:
				sprite.flip_h = false
				sprite.play("side-walk")
			else:
				sprite.flip_h = true
				sprite.play("side-walk")
		else:
			if direction.y > 0:
				sprite.play("down-walk")
			else:
				sprite.play("up-walk")
				
	move_and_slide()
