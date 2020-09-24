extends Node2D


func _process(delta):
	$icon.position = get_global_mouse_position()
