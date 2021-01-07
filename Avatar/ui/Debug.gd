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
	$GridContainer/FireColor.text = "Fire color: %s" % player.stats.bending_abilities.firebending.color
	
	# Other
	if Input.is_action_just_pressed("right_click") and player.current_element == "water":
		var water_drop = preload("res://elements/water/WaterDrop.tscn").instance()
		water_drop.global_position = main.get_global_mouse_position()
		main.get_node("water").add_child(water_drop)

func next_in_array(_array:Array, _current):
	if not _array.find(_current)+1 > _array.size()-1:
		return _array[_array.find(_current)+1]
	else:
		return _array[0]

func _on_Element_pressed():
	var values = ["fire", "water", "air", "earth"]
	if player.current_element:
		player.current_element = next_in_array(values, player.current_element)

func _on_IsAvatar_pressed():
	player.stats.is_avatar = !player.stats.is_avatar

func _on_FireColor_pressed():
	var values = ["red", "blue"]
	player.stats.bending_abilities.firebending.color = next_in_array(values, player.stats.bending_abilities.firebending.color)
