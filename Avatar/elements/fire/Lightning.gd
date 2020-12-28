extends RayCast2D

var lightning_number = 1

var end_point
var distance_to_endpoint
var current_lenght = 0


func _ready():
	end_point = get_global_mouse_position()
	distance_to_endpoint = end_point.distance_to(position)
	cast_to = get_local_mouse_position()

func _physics_process(delta):
	if current_lenght >= distance_to_endpoint:
		$Timer.start()
		set_physics_process(false)
	
	current_lenght = min(current_lenght+50, distance_to_endpoint)
	
	$Sprite.scale.x = current_lenght / 64
	$Sprite.material.set_shader_param("uv_multiplier", current_lenght / 64)
	$Sprite.material.set_shader_param("lightning_number", lightning_number)
	$Sprite.look_at(end_point)


func _on_Timer_timeout():
	queue_free()
