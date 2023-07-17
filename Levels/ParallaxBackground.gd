extends ParallaxBackground

@onready var parallaxSpeed = 800

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
#	var parallaxSpeed = get_node("../Player").parallaxSpeed
	scroll_offset.y += parallaxSpeed*delta
