extends CheckButton

@export var transitioner : Transitioner



func _on_toggled(_button_pressed:bool):
	transitioner.set_next_animation(button_pressed)
