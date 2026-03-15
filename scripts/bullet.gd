class_name Bullet
extends Area2D

var _direction: Vector2
var _stats: BulletStats
var _spawn_position: Vector2

@export var max_range: float = 100_000.0

func setup(direction: Vector2, stats: BulletStats):
	_direction = direction
	_stats = stats

func _ready() -> void:
	_spawn_position = global_position
	area_entered.connect(_on_area_entered)

func _process(delta: float):
	global_position += _direction * _stats.speed * delta
	if global_position.distance_squared_to(_spawn_position) > max_range * max_range:
		queue_free()

func _on_area_entered(other_area: Area2D):
	if not other_area.is_in_group("enemies"):
		return
	var enemy := other_area.get_parent() as Enemy
	if enemy:
		enemy.take_damage(_stats.damage)
	queue_free()
