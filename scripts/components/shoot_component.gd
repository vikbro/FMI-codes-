class_name ShootComponent
extends Node

@export var bullet_scene: PackedScene

var stats: TurretStats
var bullet_stats: BulletStats
var target: Node2D = null

var _timer: float = 0.0

func _process(delta: float):
	if target == null:
		return
	_timer += delta
	if _timer >= 1.0 / stats.fire_rate:
		_timer = 0.0
		_fire()

func _fire():
	var direction = (target.global_position - get_parent().global_position).normalized()
	_fire_in_direction(direction)

func _fire_in_direction(direction: Vector2):
	var count = bullet_stats.bullet_count

	for i in count:
		var angle_offset = 0.0
		if count > 1:
			angle_offset = lerp(
				-bullet_stats.spread_angle,
				bullet_stats.spread_angle,
				float(i) / (count - 1)
			)

		var b = bullet_scene.instantiate()
		get_tree().current_scene.add_child(b)
		b.global_position = get_parent().global_position
		b.setup(direction.rotated(deg_to_rad(angle_offset)), bullet_stats)
