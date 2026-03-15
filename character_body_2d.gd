extends CharacterBody2D
var input_direction
const  speed = 500

func get_input():
	input_direction = Input.get_vector("camera_left", "camera_right", "camera_up", "camera_down")

func _process(delta: float) -> void:
	get_input()
	global_position += input_direction * delta * speed
