extends CharacterBody2D

@export var base_speed = 300
@export var base_accel = 500
@export var friction = 60
@export var camera_speed = 100
@export var rotation_speed = 0.5
@export var base_size = Vector2(10, 10)  # Adjust this value as needed

var input = Vector2.ZERO
var mass : float = 25
var max_mass = 100

func _physics_process(delta):
	player_movement(delta)
	move_and_slide()
	keep_player_in_viewport(delta)
	rotation += rotation_speed * delta
	update_size()  # Call this function here

func get_input():
	input.x = int(Input.is_action_pressed("right")) - int(Input.is_action_pressed("left"))
	input.y= int(Input.is_action_pressed("down")) - int(Input.is_action_pressed("up"))
	return input.normalized()

func player_movement(delta):
	input = get_input()
	# Adjust acceleration and maximum speed based on mass
	var adjusted_accel = max(base_accel * sqrt(mass / max_mass), 1)  # Acceleration decreases less severely as mass decreases
	var adjusted_max_speed = base_speed * (max_mass / mass)
	# Adding friction
	if input == Vector2.ZERO:
		if velocity.length() > (friction * delta):
			velocity -= velocity.normalized() * (friction * delta)
		else:
			velocity = Vector2.ZERO
	# Adding acceleration
	else: 
		velocity += (input * adjusted_accel * delta)
		velocity = velocity.limit_length(adjusted_max_speed)
	
	move_and_slide()

func keep_player_in_viewport(_delta):
	var viewport_rect = get_viewport_rect()
	var shape = $CollisionShape2D.shape  # Get the player's CollisionShape2D
	var radius = shape.radius  # Radius of the CircleShape2D
	var bounce_factor = 0.5  # Adjust this value to change the bounciness

	if position.x - radius < viewport_rect.position.x:
		position.x = viewport_rect.position.x + radius
		velocity.x *= -bounce_factor
	elif position.x + radius > viewport_rect.position.x + viewport_rect.size.x:
		position.x = viewport_rect.position.x + viewport_rect.size.x - radius
		velocity.x *= -bounce_factor
	if position.y - radius < viewport_rect.position.y:
		position.y = viewport_rect.position.y + radius
		velocity.y *= -bounce_factor
	elif position.y + radius > viewport_rect.position.y + viewport_rect.size.y:
		position.y = viewport_rect.position.y + viewport_rect.size.y - radius
		velocity.y *= -bounce_factor

func _on_mass_test_timer_timeout():
	if mass < 100:
		mass += 10
		if mass > 100:
			mass = 100
	if mass <= 0:
		mass = 0

func take_mass(amount):
	mass = min(mass + amount, max_mass)  # Increase mass
	print("mass gained")
	if mass >= max_mass:
		print("Max mass!")
	update_size()

func die():
	print("Player died")
	queue_free()  # or start a death animation, etc.

func update_size():
	# Update the player's size based on mass
	var size_factor = mass / max_mass
	scale = base_size * size_factor
