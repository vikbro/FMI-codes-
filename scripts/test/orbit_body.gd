extends PathFollow2D

@export var orbit_speed: float = 0.1
@export var current_planet: Node2D = null

var _speed_sign: float = 1.0  # +1 or -1, preserves direction after switch
var _switching := false

func _ready() -> void:
	$Area2D.area_entered.connect(_on_area_entered)

func _process(delta: float) -> void:
	progress_ratio = fmod(progress_ratio + orbit_speed * _speed_sign * delta, 1.0)

func _on_area_entered(area: Area2D) -> void:
	var new_planet: Node2D = area.get_parent()
	if new_planet == current_planet or _switching:
		return
	_switching = true
	switch_orbit(new_planet)

func switch_orbit(new_planet: Node2D) -> void:
	var orbit_path := get_parent() as Path2D

	var world_pos := global_position
	var current_ratio := progress_ratio
	
	var baked_length := orbit_path.curve.get_baked_length()
	var next_ratio := fmod(current_ratio + 0.001 * _speed_sign, 1.0)
	var current_dir := (
		orbit_path.curve.sample_baked(baked_length * next_ratio) -
		orbit_path.curve.sample_baked(baked_length * current_ratio)
	).normalized()

	#var new_radius: float = new_planet.get("gravity_radius") * 0.6
	var new_radius: float = new_planet.get("gravity_radius")
	orbit_path.generate_orbit(new_planet.global_position, new_radius)
	current_planet = new_planet

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
