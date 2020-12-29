extends RigidBody2D

var target :Vector2 = Vector2(1,0)


func _ready():
	linear_velocity = 10 * target
	look_at(target)


func _on_IceSpike_body_entered(body):
	queue_free()
