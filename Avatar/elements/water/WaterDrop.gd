extends RigidBody2D

var destination_area = false
var force

func _on_Timer_timeout():
	queue_free()


func _integrate_forces(state):
	if destination_area:
		linear_velocity = force*(destination_area.global_position - global_position)
		sleeping = false
