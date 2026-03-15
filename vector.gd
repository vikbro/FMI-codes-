extends Node2D

signal spawn_satelite_data(base_orbit_fraction: float, orbit_speed: float)

var vector: Vector2
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
	# Emit only when the user presses Enter in the LineEdit.
	$LineEdit.text_submitted.connect(_on_angle_submitted)

func _on_angle_submitted(text: String) -> void:
	var theta = -text.to_float()
	if theta >= 0 or theta <= -180:
		push_warning("Vector: angle must be between -180 and 0 exclusive.")
		return

	var x = 20 * cos(deg_to_rad(theta))
	var y = 20 * sin(deg_to_rad(theta))
	R = abs(x / cos(deg_to_rad(theta)))
	direction = 4 * Vector2(x, y)
	L = theta + rad_to_deg(atan((sqrt(x * x + y * y) * cos(deg_to_rad(theta))) / r))
	vx = (direction.x + R * cos(deg_to_rad(L)) * cos(deg_to_rad(L - theta)))
	vy = (direction.y + R * cos(deg_to_rad(90 - L)) * cos(deg_to_rad(L - theta)))
	vector = Vector2(x, y)
	orbit_vector = Vector2(vx, vy)
	queue_redraw()

	spawn_satelite_data.emit(y / 20.0, vx / 10.0)

	# Hide input after confirming.
	$Label.visible = false
	$LineEdit.visible = false

func _draw() -> void:
	draw_line(Vector2.ZERO, vector, Color.BLACK, 5)
	draw_line(direction, orbit_vector, Color.RED, 7)

func _on_button_pressed() -> void:
	$Label.visible = true
	$LineEdit.visible = true
	$LineEdit.grab_focus()
