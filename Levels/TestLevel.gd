extends Node2D

@onready var player = $Player
@onready var camera = $Camera2D


# Called when the node enters the scene tree for the first time.
# func _ready():
# 	camera.position = Vector2.ZERO
# 	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(_delta):
#	while camera.position.y > -28000:
#		await get_tree().create_timer(0.3).timeout  # Wait for 2 seconds
#		camera.position.y -= player.characterVelocity
