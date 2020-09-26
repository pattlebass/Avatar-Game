extends RigidBody2D


func _on_FireParticle_body_entered(_body):
	$Timer.start(0.2)


func _on_Timer_timeout():
	queue_free()
