extends RigidBody2D

var destination_area = false
var force
var frozen :bool = false


func _integrate_forces(state):
	if destination_area:
		linear_velocity = force*(destination_area.global_position - global_position)
		sleeping = false
	if frozen:
		sleeping = true
