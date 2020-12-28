extends PopupDialog

onready var main = get_parent().get_parent()
onready var player = main.get_node("Player")
onready var selected_element = player.current_element


func _input(_event):
	if not player.stats.is_avatar :
		return
	
	if Input.is_action_pressed("element_wheel"):
		visible = true
	elif Input.is_action_just_released("element_wheel"):
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

func _on_FireColor_pressed():
	pass # Replace with function body.
