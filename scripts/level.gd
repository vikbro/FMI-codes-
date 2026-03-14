extends Node2D

var Sun = preload("res://scenes/Sun.tscn")
var Earth = preload("res://scenes/earth.tscn")
var Moon = preload("res://scenes/moon.tscn")
@onready var cam: Camera2D = $Camera2D
var sun
var earth
var moon

var all_childs = []

func _ready() -> void:
	ProjectSettings.set_setting("physics/2d/default_gravity", 0)
	sun = Sun.instantiate()
	add_child(sun)
	all_childs.append(sun)
	earth = Earth.instantiate()
	add_child(earth)
	all_childs.append(earth)
	moon = Moon.instantiate()
	add_child(moon)
	all_childs.append(moon)
	sun.set_global_position(Vector2(100, 100))
	earth.set_global_position(Vector2(1500, 100))
	moon.set_global_position(Vector2(1600, 100))

func _process(delta: float) -> void:
	change_cam_pos()
	for current in all_childs:
		for new_body in all_childs:
			if(new_body != current):
				new_body.velocity_change(current, delta)
	
	#for body in all_childs:
		#body.position_change(delta)
	
#func _physics_process(delta: float) -> void:

func change_cam_pos():
	cam.position = lerp(cam.position, earth.position, 0.5)
