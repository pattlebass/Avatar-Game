extends Control

onready var main = get_parent().get_parent()
onready var player = main.get_node("Player")


func _ready():
	# Signals
	$GridContainer/Element.connect("pressed", self, "toggle_from_list", 
	["player.current_element", ["fire", "air", "water", "earth"]])
	$GridContainer/IsAvatar.connect("pressed", self, "toggle_from_list", 
	["player.stats.is_avatar", [true, false]])
	

func _process(_delta):
	# Set Labels
	$GridContainer/FPS.text = "FPS: %s" % Engine.get_frames_per_second()
	$GridContainer/Element.text = "Element: %s" % player.current_element
	$GridContainer/IsAvatar.text = "Is Avatar: %s" % player.stats.is_avatar
	$GridContainer/Health.text = "Health: %s / %s" % [player.stats.current_health, player.stats.max_health]
	$GridContainer/Energy.text = "Energy: %s / %s" % [player.stats.current_energy, player.stats.max_energy]
	
	# Other
	if Input.is_action_just_pressed("right_click") and player.current_element == "water":
		var water_drop = preload("res://scenes/WaterDrop.tscn").instance()
		water_drop.global_position = get_global_mouse_position()
		main.get_node("water").add_child(water_drop)

func toggle_from_list(_var_path, _list):
	var variable = str2var(_var_path)
	var current_index = _list.find(variable)
	if current_index != _list.size() - 1:
		var next_index = current_index + 1
		variable = _list[next_index]
#	print(_var_path)
#	print(variable)
#	print(player.stats.is_avatar)
	print(player.get("stats.is_avatar"))
