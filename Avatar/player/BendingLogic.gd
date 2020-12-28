extends Node2D

onready var player = get_parent()
onready var main = player.get_parent()

func _process(delta):
	var current_element = get_parent().current_element
	
	var input = []
	input.append(current_element)
	
	for i in ["ability1", "ability2"]:
		if Input.is_action_pressed(i):
			input.append(i)
	
	match input:
		["fire", "ability1"]:
			if !Input.is_action_pressed("left_click"):
				continue
			var fire_particle = preload("res://elements/fire/FireParticle.tscn").instance()
			var direction = (get_global_mouse_position() - player.global_position).normalized()
			var offset_no = 10
			var offset = Vector2(rand_range(-offset_no, offset_no), rand_range(-offset_no, offset_no))
			fire_particle.global_position = player.global_position + offset
			fire_particle.apply_central_impulse(direction*1000)
			
			var particle_material = fire_particle.get_node("Particles2D").process_material
			var gradient
			
			if player.stats.bending_abilities.firebending.color == "red":
				gradient = preload("res://elements/fire/assets/gradient_red.tres")
			else:
				gradient = preload("res://elements/fire/assets/gradient_blue.tres")
			
			particle_material.color_ramp.gradient = gradient
			
			main.add_child(fire_particle)
		
		["fire", "ability2"]:
			if Input.is_action_just_pressed("left_click"):
				var lightning = preload("res://elements/fire/Lightning.tscn").instance()
				lightning.global_position = player.global_position
				main.add_child(lightning)
		
		["water", "ability1"]:
			var water_area = player.get_node("AbilityNodes/WaterArea2D")
			
			if Input.is_action_pressed("left_click"):
				water_area.get_node("CollisionShape2D").disabled = false
				water_area.global_position = get_global_mouse_position()
				var radius = player.stats.bending_abilities.waterbending.level * 20
				#water_area.get_node("CollisionShape2D").shape.radius = radius
			else:
				water_area.get_node("CollisionShape2D").disabled = true


func _on_WaterArea2D_body_entered(body):
	if body.is_in_group("water_drop"):
		body.sleeping = false
		body.force = player.stats.bending_abilities.waterbending.level
		body.destination_area = player.get_node("AbilityNodes/WaterArea2D")

func _on_WaterArea2D_body_exited(body):
	if body.is_in_group("water_drop"):
		body.destination_area = null
