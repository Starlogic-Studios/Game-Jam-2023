extends Control

@onready var player : Player = get_tree().get_first_node_in_group("player")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	var massBar = get_node("HBoxContainer/MassBar")
	massBar.value = player.mass
