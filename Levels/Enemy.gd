extends CharacterBody2D


@onready var spawner = $ProjectileSpawnPoint

func spawn_projectile():
	var spawn_point = spawner.global_position
	var scene = load("res://Projectile.tscn")
	var projectile = scene.instance()
	projectile.global_position = spawn_point
        #optionally add projectile to root node as a child