extends CharacterBody2D

@export var speed: float = 10.0  # How fast the cow walks
@export var wander_area: Rect2 = Rect2(0, 0, 200, 150) # The rectangle the cow will wander in (x, y, width, height)
													  # Relative to the cow's PARENT node's origin.
													  # Adjust this in the Inspector for each cow instance.

@export_range(0.5, 10.0) var min_idle_time: float = 2.0 # Minimum time to stay idle (seconds)
@export_range(1.0, 15.0) var max_idle_time: float = 5.0 # Maximum time to stay idle (seconds)

# You might need to adjust this path if your nodes are named differently
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var state_timer: Timer = $Timer # Timer to decide when to change state

enum State { IDLE, WANDERING }
var current_state: State = State.IDLE
var target_position: Vector2

# A small distance to consider the target "reached"
const ARRIVAL_THRESHOLD: float = 5.0

func _ready() -> void:
	# Ensure the wander_area is sensible
	if wander_area.size.x <= 0 or wander_area.size.y <= 0:
		printerr("Cow's wander_area has zero or negative size. Cow will not move.")
		set_physics_process(false) # Disable movement logic
		if animated_sprite: animated_sprite.play("idle")
		return

	# Connect the timer's timeout signal to a function
	state_timer.timeout.connect(_on_state_timer_timeout)
	
	# Initial state
	_enter_idle_state()

func _physics_process(_delta: float) -> void:
	if current_state == State.WANDERING:
		var direction_to_target = global_position.direction_to(target_position)
		velocity = direction_to_target * speed
		
		# Check if reached the target
		if global_position.distance_to(target_position) < ARRIVAL_THRESHOLD:
			_enter_idle_state()
		else:
			# Basic animation update (can be expanded for directional sprites)
			if animated_sprite:
				animated_sprite.play("walking")
				# Optional: Flip sprite based on direction
		# Optional: Flip sprite based on direction
			if direction_to_target.x < 0: # Moving left
				animated_sprite.flip_h = false # If base sprite faces left, false keeps it left
			elif direction_to_target.x > 0: # Moving right
				animated_sprite.flip_h = true  # If base sprite faces left, true flips it to face right
	else: # IDLE state
		velocity = Vector2.ZERO
		if animated_sprite:
			animated_sprite.play("idle")
			
	move_and_slide()

func _enter_idle_state() -> void:
	current_state = State.IDLE
	velocity = Vector2.ZERO # Stop moving
	if animated_sprite:
		animated_sprite.play("idle")
	
	# Set timer for how long to stay idle
	var idle_duration = randf_range(min_idle_time, max_idle_time)
	state_timer.start(idle_duration)

func _enter_wandering_state() -> void:
	current_state = State.WANDERING
	_pick_new_target_position()
	if animated_sprite:
		animated_sprite.play("walking") # Start walk animation immediately

func _pick_new_target_position() -> void:
	# Pick a random point within the wander_area
	# The wander_area is relative to the parent's origin. We need a global target.
	var parent_global_pos: Vector2 = Vector2.ZERO
	if get_parent() is Node2D: # Check if parent is a Node2D to get its global position
		parent_global_pos = get_parent().global_position

	var random_x = randf_range(wander_area.position.x, wander_area.position.x + wander_area.size.x)
	var random_y = randf_range(wander_area.position.y, wander_area.position.y + wander_area.size.y)
	
	target_position = parent_global_pos + Vector2(random_x, random_y)

func _on_state_timer_timeout() -> void:
	if current_state == State.IDLE:
		_enter_wandering_state()
	# No need for an else here, as wandering state transitions to idle upon reaching target.
