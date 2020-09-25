extends KinematicBody2D

# Movement
var run_speed = 200
var jump_speed = 400
var gravity = 1200

var velocity = Vector2()
var jumping = false

# Other
var fire_colors = {"blue":Color.blue, "red":Color.red}
var abilities = {
	"firebending":{"level":10, "color":fire_colors.blue, "lightning_level":3},
	"waterbending":{"level":10, "bloodbending_level":3,},
	}


func get_input():
	velocity.x = 0
	var right = Input.is_action_pressed("right")
	var left = Input.is_action_pressed("left")
	var jump = Input.is_action_just_pressed("jump")

	if jump and is_on_floor():
		jumping = true
		velocity.y = -jump_speed
	if right:
		velocity.x += run_speed
	if left:
		velocity.x -= run_speed

func _physics_process(delta):
	get_input()
	velocity.y += gravity * delta
	if jumping and is_on_floor():
		jumping = false
	velocity = move_and_slide(velocity, Vector2(0, -1))
