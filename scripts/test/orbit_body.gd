extends PathFollow2D

@export var orbit_speed: float = 0.1
@export var current_planet: Node2D = null

@export var detection_radius: float = 13.0:
	set(value):
		detection_radius = value
		_update_detection_shape()

@export var base_orbit_fraction: float = 0.8

@export var speed_modifier: float = 1.0:
	set(value):
		speed_modifier = max(0.1, value)
		if _ready_complete:
			_update_orbit_radius()

var _speed_sign: float = 1.0
var _switching := false
var _ready_complete := false

func _update_detection_shape() -> void:
	var shape_node = get_node_or_null("Area2D/CollisionShape2D")
	if shape_node == null:
		return
	if not shape_node.shape is CircleShape2D:
		shape_node.shape = CircleShape2D.new()
	shape_node.shape.radius = detection_radius

func _update_orbit_radius() -> void:
	if current_planet == null:
		return
	var orbit_path := get_parent() as Path2D
	if orbit_path == null:
		return
	var world_pos := global_position
	orbit_path.generate_orbit(current_planet.global_position, _calc_radius_for_planet(current_planet))
	progress_ratio = _find_nearest_ratio(orbit_path.curve, world_pos)

func _calc_radius_for_planet(planet: Node2D) -> float:
	var gravity_radius: float = planet.get("gravity_radius")
	return gravity_radius * base_orbit_fraction * speed_modifier

func _ready() -> void:
	if current_planet:
		var orbit_path := get_parent() as Path2D
		orbit_path.generate_orbit(current_planet.global_position, _calc_radius_for_planet(current_planet))
	# No warning if current_planet is null — we handle that case in
	# _on_area_entered by treating the first planet contact as the initial orbit.

	$Area2D.area_entered.connect(_on_area_entered)
	_ready_complete = true

func _process(delta: float) -> void:
	var orbit_path := get_parent() as Path2D
	if orbit_path.curve.get_baked_length() == 0.0:
		return
	progress_ratio = fmod(progress_ratio + orbit_speed * speed_modifier * _speed_sign * delta, 1.0)

func set_speed_modifier(value: float) -> void:
	speed_modifier = value

func _on_area_entered(area: Area2D) -> void:
	var new_planet: Node2D = area.get_parent()
	if not new_planet is Planet:
		return
	if _switching:
		return

	if current_planet == null:
		# No planet yet — treat this as the initial orbit rather than a switch.
		# This handles the case where current_planet wasn't set in the inspector.
		current_planet = new_planet
		var orbit_path := get_parent() as Path2D
		orbit_path.generate_orbit(current_planet.global_position, _calc_radius_for_planet(current_planet))
		return

	if new_planet == current_planet:
		return

	_switching = true
	switch_orbit(new_planet)

func switch_orbit(new_planet: Node2D) -> void:
	var orbit_path := get_parent() as Path2D

	if orbit_path.curve.get_baked_length() == 0.0:
		push_warning("OrbitBody: switch_orbit called before curve was generated, ignoring.")
		_switching = false
		return

	var world_pos := global_position
	var current_ratio := progress_ratio

	var baked_length := orbit_path.curve.get_baked_length()
	var next_ratio := fmod(current_ratio + 0.001 * _speed_sign, 1.0)
	var current_dir := (
		orbit_path.curve.sample_baked(baked_length * next_ratio) -
		orbit_path.curve.sample_baked(baked_length * current_ratio)
	).normalized()

	var new_radius := _calc_radius_for_planet(new_planet)
	orbit_path.generate_orbit(new_planet.global_position, new_radius)
	current_planet = new_planet
	Global_Audio.radar.play()
	var new_baked_length := orbit_path.curve.get_baked_length()
	progress_ratio = _find_nearest_ratio(orbit_path.curve, world_pos)

	var new_ratio_fwd := fmod(progress_ratio + 0.001, 1.0)
	var new_dir_fwd := (
		orbit_path.curve.sample_baked(new_baked_length * new_ratio_fwd) -
		orbit_path.curve.sample_baked(new_baked_length * progress_ratio)
	).normalized()

	if current_dir.dot(new_dir_fwd) < 0.0:
		_speed_sign = -1.0
	else:
		_speed_sign = 1.0
	
	_switching = false

func _find_nearest_ratio(c: Curve2D, world_pos: Vector2) -> float:
	var best_ratio := 0.0
	var best_dist := INF
	var steps := 64
	for i in steps:
		var r := float(i) / steps
		var p := c.sample_baked(c.get_baked_length() * r)
		var d := p.distance_to(world_pos)
		if d < best_dist:
			best_dist = d
			best_ratio = r
	return best_ratio
