extends CharacterBody2D

@onready var massbar = get_node("/root/TestLevel/HUD/StatusBars/DisplayContainer/ResourceDisplay/massbar")

@export var max_speed = 600
@export var accel = 1500
@export var friction = 600
@export var mass : float = 40
@export var speed : float = 0

var input = Vector2.ZERO

func _physics_process(delta):
	player_movement(delta)
	update_ui()
	keep_player_in_viewport(delta)

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

#For updating status_bar
func update_ui():
	massbar.value = mass

func _on_mass_test_timer_timeout():
	if mass < 100:
		mass += 10
		if mass > 100:
			mass = 100
	if mass <= 0:
		mass = 0

func keep_player_in_viewport(delta):
	var viewport_rect = get_viewport_rect()
	print(position.x, ", ", position.y)
	print(viewport_rect)
	if position.x < 0:
		velocity.x = max_speed/2
	elif position.x > viewport_rect.size.x:
		velocity.x = -max_speed/2
	if position.y < 0:
		velocity.y = max_speed/2
	elif position.y > viewport_rect.size.y:
		velocity.y = -max_speed/2
