extends Node2D

onready var player = get_parent()
onready var main = player.get_parent()

onready var water_area = player.get_node("AbilityNodes/WaterArea2D")


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
			water_area.global_position = get_global_mouse_position()
			if Input.is_action_pressed("left_click"):
				water_area.get_node("CollisionShape2D").disabled = false
				var radius = player.stats.bending_abilities.waterbending.level * 20
				#water_area.get_node("CollisionShape2D").shape.radius = radius
				for water_drop in get_tree().get_nodes_in_group("water_in_area"):
					water_drop.sleeping = false
					water_drop.force = player.stats.bending_abilities.waterbending.level
					water_drop.destination_area = player.get_node("AbilityNodes/WaterArea2D")
			elif Input.is_action_pressed("right_click"):
				water_area.get_node("CollisionShape2D").disabled = false
				for i in get_tree().get_nodes_in_group("water_in_area"):
					i.frozen = true
			else:
				water_area.get_node("CollisionShape2D").disabled = true
		["water", "ability2"]:
			water_area.global_position = get_global_mouse_position()
			if Input.is_action_just_pressed("left_click"):
				water_area.get_node("CollisionShape2D").disabled = false
			if Input.is_action_pressed("left_click"):
				var ice_spike_scene = preload("res://elements/water/IceSpike.tscn")
				for water_drop in get_tree().get_nodes_in_group("water_in_area"):
					var ice_spike = ice_spike_scene.instance()
					ice_spike.global_position = water_drop.global_position
					ice_spike.add_to_group("ice_spikes_selected")
					main.add_child(ice_spike)
					water_drop.queue_free()
			if Input.is_action_just_released("left_click"):
				for icespike in get_tree().get_nodes_in_group("ice_spikes_selected"):
					icespike.shoot(get_global_mouse_position())
					icespike.remove_from_group("ice_spikes_selected")


func _on_WaterArea2D_body_entered(body):
	if body.is_in_group("water_drop"):
		body.add_to_group("water_in_area")


func _on_WaterArea2D_body_exited(body):
	if body.is_in_group("water_drop"):
		body.remove_from_group("water_in_area")
		body.destination_area = null
