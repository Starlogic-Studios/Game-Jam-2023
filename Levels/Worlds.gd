extends Node2D

@onready var god = $HUD/GameOverScreen
@onready var projectiles = [
	{"scene": preload("res://Character/Projectiles/missile.tscn"), "weight": 50},
	{"scene": preload("res://Character/Projectiles/metorBits.tscn"), "weight": 200},
	# {"scene": preload("res://Assets/PARTICLES/dark-matter.tscn"), "weight": 5},
	# {"scene": preload("res://Assets/PARTICLES/AsteroidEmission.tscn"), "weight": 5},
	# {"scene": preload("res://Assets/PARTICLES/ClassicExplosion.tscn"), "weight": 5},
	# Add more projectile scenes as needed
]

var player = null

func _ready():
	player = get_tree().get_first_node_in_group("player")
	assert(player!=null)
	player.killed.connect(_on_player_killed)

func _on_timer_timeout():
	var projectile_scene = get_random_projectile()
	var projectile = projectile_scene.instantiate()
	projectile.position = Vector2(randf_range(50, 1100), get_viewport_rect().size.y * -1)
	add_child(projectile)

func get_random_projectile():
	var total_weight = 0
	for p in projectiles:
		total_weight += p.weight

	var random_weight = randi() % total_weight
	var weight_sum = 0
	for p in projectiles:
		weight_sum += p.weight
		if weight_sum > random_weight:
			return p.scene
	return null  # This should never happen if the weights are set up correctly

func _on_player_killed():
	await get_tree().create_timer(1.5).timeout
	god.visible = true

