extends PopupDialog

var selected_element = ""
onready var main = get_parent().get_parent()
onready var player = main.get_node("Player")


func _input(_event):
	if not player.stats.is_avatar :
		return
	
	if Input.is_action_pressed("element_wheel"):
		visible = true
	else:
		visible = false
		player.current_element = selected_element


func _on_WaterLabel_mouse_entered():
	selected_element = "water"
	

func _on_FireLabel_mouse_entered():
	selected_element = "fire"


func _on_EarthLabel_mouse_entered():
	selected_element = "earth"


func _on_AirLabel_mouse_entered():
	selected_element = "air"
