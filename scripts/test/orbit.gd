@tool
extends Path2D

const BEZIER_C := 0.5522847

@export var orbit_radius: float = 150.0
@export var current_planet: Node2D = null

func _ready() -> void:
	if current_planet:
		generate_orbit(current_planet.global_position, orbit_radius)

func generate_orbit(center: Vector2, radius: float) -> void:
	orbit_radius = radius
	global_position = Vector2.ZERO  # path lives in world space
	curve = Curve2D.new()
	
	var c := radius * BEZIER_C
	var num_points := 4
	
	for i in num_points:
		var angle := (TAU / num_points) * i
		var point := center + Vector2(cos(angle) * radius, sin(angle) * radius)
		var tangent := Vector2(-sin(angle) * c, cos(angle) * c)
		curve.add_point(point, -tangent, tangent)
	
	# Close the loop
	var close_point := center + Vector2(orbit_radius, 0)
	var close_tangent := Vector2(0, c)
	curve.add_point(close_point, -close_tangent, close_tangent)
