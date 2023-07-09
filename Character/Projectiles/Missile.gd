extends Area2D

@export var speed = 50
@export var mass = 1

var explosion_scene = preload("res://Character/Projectiles/explosion.tscn")
var velocity = Vector2.ZERO

func _physics_process(delta):
	velocity.y += speed * delta
	position += velocity * delta

func _on_Missile_body_entered(body):
	if body.has_method("take_mass"):
		body.take_damage(mass)
	queue_free()

func _on_Lifetime_timeout():
	queue_free()
