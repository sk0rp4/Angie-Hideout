extends CharacterBody2D

@export var speed: float = 125.0
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
var last_direction : Vector2 = Vector2.DOWN


func _physics_process(delta):
	var input_vector = Vector2.ZERO

	if Input.is_action_pressed("ui_up"):
		input_vector.y -= 1
	if Input.is_action_pressed("ui_down"):
		input_vector.y += 1
	if Input.is_action_pressed("ui_left"):
		input_vector.x -= 1
	if Input.is_action_pressed("ui_right"):
		input_vector.x += 1


	input_vector = input_vector.normalized()

	velocity = input_vector * speed
	move_and_slide()
	
# Animation walking
	if input_vector != Vector2.ZERO:
	# Save last direction
		last_direction = input_vector

	if input_vector.y < 0:
		animated_sprite.play("walk_up")
	elif input_vector.y > 0:
		animated_sprite.play("walk_down")
	elif input_vector.x != 0:
		animated_sprite.play("walk_right")
		animated_sprite.flip_h = input_vector.x < 0
	else:
	# No movement — play idle based on last direction
		if last_direction.y < 0:
			animated_sprite.play("idle_up")
		elif last_direction.y > 0:
			animated_sprite.play("idle_down")
		elif last_direction.x != 0:
			animated_sprite.play("idle_right")
			animated_sprite.flip_h = last_direction.x < 0
