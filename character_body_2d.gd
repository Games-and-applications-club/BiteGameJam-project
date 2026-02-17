extends CharacterBody2D

@export var speed = 300.0
@export var jump_velocity = -450.0
@export var wall_slide_speed = 150.0
@export var wall_jump_force = 400.0

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	if not is_on_floor():
		if is_on_wall_only() and velocity.y > 0:
			velocity.y += (gravity * 0.5) * delta
			velocity.y = min(velocity.y, wall_slide_speed)
		else:
			velocity.y += gravity * delta

	var jump_attempt = Input.is_action_just_pressed("ui_accept") or Input.is_action_just_pressed("ui_up")

	if jump_attempt:
		if is_on_floor():
			velocity.y = jump_velocity
		elif is_on_wall_only():
			velocity.y = jump_velocity
			velocity.x = get_wall_normal().x * wall_jump_force

	var direction = Input.get_axis("ui_left", "ui_right")
	
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	move_and_slide()