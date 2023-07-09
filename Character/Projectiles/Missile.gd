extends Area2D

@export var speed = 350

var velocity = Vector2.ZERO

func _physics_process(delta):
	velocity.y += speed * delta
	position += velocity * delta

func _on_Missile_body_entered(_body):
	queue_free()

func _on_Lifetime_timeout():
	queue_free()
