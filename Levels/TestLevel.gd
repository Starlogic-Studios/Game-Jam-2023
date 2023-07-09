extends Node2D

@onready var missile = preload("res://Character/Projectiles/missile.tscn")

func _on_timer_timeout():
	var projectile = missile.instantiate()
	projectile.position = Vector2(randf_range(50, 1100), 0)
	add_child(projectile)
