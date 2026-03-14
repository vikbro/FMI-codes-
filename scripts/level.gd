extends Node2D

var Sun = preload("res://scenes/Sun.tscn")
var Earth = preload("res://scenes/earth.tscn")
var Moon = preload("res://scenes/moon.tscn")
@onready var cam: Camera2D = $Camera2D
var sun
var earth
var moon

func _ready() -> void:
	ProjectSettings.set_setting("physics/2d/default_gravity", 0)
	sun = Sun.instantiate()
	add_child(sun)
	earth = Earth.instantiate()
	add_child(earth)
	moon = Moon.instantiate()
	add_child(moon)
	sun.set_global_position(Vector2(100, 100))
	earth.set_global_position(Vector2(1500, 100))
	moon.set_global_position(Vector2(1600, 100))

func _process(delta: float) -> void:
	change_cam_pos()
	

func change_cam_pos():
	cam.position = lerp(cam.position, earth.position, 0.5)

func update_velocity(other_body: RigidBody2D, delta):
	pass
#	var distance = 
