extends RigidBody2D

var is_moving:bool = false


func _ready():
	for i in get_tree().get_nodes_in_group("ice_spikes_selected"):
		add_collision_exception_with(i)


func _on_IceSpike_body_entered(body):
	gravity_scale = 1


func _integrate_forces(state):
	if not is_moving:
		look_at(get_global_mouse_position())


func shoot(target:Vector2):
	is_moving = true
	look_at(target)
	var vec_to_target = target - global_position
	linear_velocity = 1000*vec_to_target.normalized()


func _on_Timer_timeout():
	queue_free()
