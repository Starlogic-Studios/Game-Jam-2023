# Player script
extends CharacterBody2D

@onready var massbar = get_node("/root/TestLevel/Camera2D/HUD/StatusBars/DisplayContainer/ResourceDisplay/massbar")
@onready var camera = get_node("/root/TestLevel/Camera2D")

@export var max_speed = 600
@export var accel = 1500
@export var friction = 600
@export var rebound = 300
@export var characterMass : float = 40
@export var characterVelocity : float = 1

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
	massbar.value = characterMass

func _on_mass_test_timer_timeout():
	if characterMass < 100:
		characterMass += 10
		if characterMass > 100:
			characterMass = 100
	if characterMass <= 0:
		characterMass = 0

func keep_player_in_viewport(_delta):
	var screen_center = camera.position + camera.offset
	var screen_size = get_viewport_rect().size / camera.zoom
	var left_bound = screen_center.x - screen_size.x / 2
	var right_bound = screen_center.x + screen_size.x / 2
	var top_bound = screen_center.y - screen_size.y / 2
	var bottom_bound = screen_center.y + screen_size.y / 2

	if position.x < left_bound:
		position.x = left_bound
	elif position.x > right_bound:
		position.x = right_bound
	if position.y < top_bound:
		position.y = top_bound
	elif position.y > bottom_bound:
		position.y = bottom_bound
