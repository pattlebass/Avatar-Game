extends KinematicBody2D

# Movement
var run_speed = 250
var jump_speed = 450
var gravity = 1200

var velocity = Vector2()
var jumping = false

# Other
var bending_abilities = {
	"firebending":{"level":5, "color":Global.fire_colors.blue, "lightning_level":3},
	"airbending":{"level":5, "flight_level":3},
	"waterbending":{"level":5, "bloodbending_level":3,"healing_level":3},
	"earthbending":{"level":5, "metalbending_level":3, "lavabending_level":3},
}

var stats = {
	"avatar_state_level": 3,
	"can_redirect_lightning":true,
	"bending_abilities":bending_abilities
}


func _ready():
	print(stats)


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
