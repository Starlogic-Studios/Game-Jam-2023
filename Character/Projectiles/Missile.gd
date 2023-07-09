extends Area2D

@export var speed = 50
@export var damage = 10

var explosion_scene = preload("res://Character/Projectiles/explosion.tscn")
var velocity = Vector2.ZERO

func _physics_process(delta):
	velocity.y += speed * delta
	position += velocity * delta

func _on_Missile_body_entered(body):
	if body.get_parent().has_method("take_damage"):
		body.get_parent().take_damage(damage)
	var explosion = explosion_scene.instantiate()
	explosion.global_position = global_position
	get_parent().add_child(explosion)
	queue_free()

func _on_Lifetime_timeout():
	queue_free()
