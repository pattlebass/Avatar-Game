extends Line2D


func _ready():
	add_point(Vector2.ZERO)
	add_point(Vector2.ZERO)


func _process(delta):
	set_point_position(1, get_local_mouse_position())
