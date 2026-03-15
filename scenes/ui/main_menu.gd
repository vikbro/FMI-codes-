extends Control
var start_pos:    Vector2
var end_pos:      Vector2
var interp_time:  float
var interp_end:   float

var lerped_value: Vector2

func _prep_lerp(start: Vector2, end: Vector2, seconds: float) -> void:
	interp_time = 0.0
	interp_end  = seconds
	start_pos   = start
	end_pos     = end

func _process(delta: float) -> void:
	if interp_time < interp_end:
		interp_time  = minf(interp_time + delta, interp_end)
		lerped_value = start_pos.lerp(end_pos, interp_time / interp_end)
