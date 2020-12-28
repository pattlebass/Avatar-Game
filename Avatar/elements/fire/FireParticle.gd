extends RigidBody2D


func _ready():
	set_physics_process(false)


func _physics_process(delta):
	if sleeping:
		queue_free()
	else:
		apply_central_impulse(-linear_velocity*0.1)
		modulate -= Color(0, 0, 0, 0.1)

func _on_FireParticle_body_entered(_body):
	$Timer.start(0.2)


func _on_Timer_timeout():
	set_physics_process(true)
