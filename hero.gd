extends CharacterBody2D

var speed : int = 100
var direction : Vector2

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	direction = Input.get_vector("left", "right", "up", "down")
	velocity = direction * speed
	move_and_slide()
