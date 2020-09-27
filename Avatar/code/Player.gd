extends KinematicBody2D

# Movement
var run_speed = 250
var jump_speed = 550
var gravity = 1200

var velocity = Vector2()
var jumping = false

# Other
onready var main = get_parent()

var bending_abilities = {
	"firebending":{"level":5, "color":Global.fire_colors.blue, "lightning_level":3},
	"airbending":{"level":5, "flight_level":3},
	"waterbending":{"level":5, "bloodbending_level":3,"healing_level":3},
	"earthbending":{"level":5, "metalbending_level":3, "lavabending_level":3},
}

var stats = {
	"current_health":100,
	"max_health":100,
	"current_energy":100,
	"max_energy":100,
	"is_avatar":true,
	"avatar_state_level": 3,
	"can_redirect_lightning":true,
	"bending_abilities":bending_abilities,
}

var current_element = "water"


func _ready():
	print(stats)


func get_movement():
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


func get_bending_input():
	if current_element == "fire":
		if Input.is_action_pressed("ability1"):
			var fire_particle = preload("res://scenes/FireParticle.tscn").instance()
			var direction = (get_global_mouse_position() - global_position).normalized()
			if Input.is_action_pressed("left_click"):
				fire_particle.global_position = global_position
				fire_particle.apply_central_impulse(direction*1000)
				main.add_child(fire_particle)
			elif Input.is_action_just_pressed("right_click"):
				fire_particle.global_position = global_position
				fire_particle.apply_central_impulse(direction*1000)
				main.add_child(fire_particle)
				
		elif Input.is_action_pressed("ability2"):
			var lightning = preload("res://scenes/Lightning.tscn").instance()
			if Input.is_action_just_pressed("left_click"):
				lightning.global_position = position
				main.add_child(lightning)
				
	elif current_element == "air":
		pass

	elif current_element == "water":
		if Input.is_action_pressed("ability1"):
			var water_area2d = $AbilityNodes/WaterArea2D
			if Input.is_action_pressed("left_click"):
				water_area2d.get_node("CollisionShape2D").disabled = false
				water_area2d.global_position = get_global_mouse_position()
			else:
				water_area2d.get_node("CollisionShape2D").disabled = true
				
		elif Input.is_action_pressed("ability2"):
			pass

	elif current_element == "earth":
		pass


func _physics_process(delta):
	get_bending_input()
	
	# Movement
	get_movement()
	velocity.y += gravity * delta
	if jumping and is_on_floor():
		jumping = false
	velocity = move_and_slide(velocity, Vector2(0, -1))
