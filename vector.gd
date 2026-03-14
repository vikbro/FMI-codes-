extends Node2D

var vector : Vector2
var R
var L
var r = 10
var direction: Vector2
var orbit_vector: Vector2
var vx
var vy

func _ready() -> void:
	$Label.visible = false
	$LineEdit.visible = false


func _draw() -> void:
	draw_line(Vector2.ZERO, vector, Color.BLACK, 5)
	draw_line(direction, orbit_vector, Color.RED, 7)

func _process(delta: float) -> void:
	var theta = - await Event.angle_input
	if theta >= 0 || theta <= -180 || theta == -90:
		pass
	else:
		print(-theta)
		var x = 20 * cos(deg_to_rad(theta))
		var y = 20 * sin(deg_to_rad(theta))
		R = abs(x/cos(deg_to_rad(theta)))
		direction = 4 * Vector2(x, y)
		L = theta + rad_to_deg(atan((sqrt(x * x + y * y) * cos(deg_to_rad(theta))) / r))
		vx =  (direction.x  + R * cos(deg_to_rad(L)) * cos(deg_to_rad(L - theta)))
		vy =  (direction.y + R * cos(deg_to_rad(90 - L)) * cos(deg_to_rad(L - theta)))
		vector = Vector2(x, y)
		orbit_vector = Vector2(vx, vy)
		var speed = Vector2(0, orbit_vector.y)
		var height = Vector2(orbit_vector.x, 0)
		queue_redraw()


func _on_button_pressed() -> void:
	$Label.visible = true
	$LineEdit.visible = true
	
