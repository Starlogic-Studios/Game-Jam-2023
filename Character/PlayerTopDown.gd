extends CharacterBody2D

# @onready var massbar = get_node("/root/TestLevel/HUD/StatusBars/DisplayContainer/ResourceDisplay/massbar")
# @onready var camera = $Camera2D  # Add this line

@export var max_speed = 600
@export var accel = 1500
@export var friction = 600
@export var camera_speed = 100  # Add this line

var input = Vector2.ZERO
var mass : float = 40

func _physics_process(delta):
	player_movement(delta)
	keep_player_in_viewport(delta)  # Call this function here

func get_input():
	input.x = int(Input.is_action_pressed("right")) - int(Input.is_action_pressed("left"))
	input.y= int(Input.is_action_pressed("down")) - int(Input.is_action_pressed("up"))
	return input.normalized()

func player_movement(delta):
	input = get_input()
	# Adding friction
	if input == Vector2.ZERO:
		if velocity.length() > (friction * delta):
			velocity -= velocity.normalized() * (friction * delta)
		else:
			velocity = Vector2.ZERO
	# Adding acceleration
	else: 
		velocity += (input * accel * delta)
		velocity = velocity.limit_length(max_speed)
	
	move_and_slide()

# Add this function
func keep_player_in_viewport(delta):
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


#For updating status_bar
# func update_ui():
# 	massbar.value = mass

func _on_mass_test_timer_timeout():
	if mass < 100:
		mass += 10
		if mass > 100:
			mass = 100
	if mass <= 0:
		mass = 0
