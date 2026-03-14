extends RigidBody2D

var velocity = Vector2(0, 0)
var force
var b_mass = 20
#var size = 20

func _ready() -> void:
	sleeping = false

func velocity_change(new_body: RigidBody2D, delta):
	var distance = new_body.global_position.distance_to(global_position)
	var force_dir = (new_body.global_position - global_position).normalized()
	force = force_dir * (Event.GRAV * b_mass * new_body.b_mass / distance)
	apply_central_impulse(force)
	#var acceleration = force / b_mass
	#velocity = velocity + acceleration * delta
	#
	#print("hi")
	
func position_change(delta):
	global_position = global_position + velocity * delta
