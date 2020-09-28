extends Control

onready var main = get_parent().get_parent()
onready var player = main.get_node("Player")


func _process(_delta):
	# Set Labels
	$GridContainer/FPS.text = "FPS: %s" % Engine.get_frames_per_second()
	$GridContainer/Element.text = "Element: %s" % player.current_element
	$GridContainer/IsAvatar.text = "Is Avatar: %s" % player.stats.is_avatar
	$GridContainer/Health.text = "Health: %s / %s" % [player.stats.current_health, player.stats.max_health]
	$GridContainer/Energy.text = "Energy: %s / %s" % [player.stats.current_energy, player.stats.max_energy]
	
	# Other
	if Input.is_action_just_pressed("right_click"):
		var water_drop = preload("res://scenes/WaterDrop.tscn").instance()
		water_drop.global_position = get_global_mouse_position()
		main.get_node("water").add_child(water_drop)
