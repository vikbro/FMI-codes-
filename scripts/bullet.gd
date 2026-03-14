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

func _process(delta: float):
	global_position += _direction * _stats.speed * delta

	if global_position.distance_squared_to(_spawn_position) > max_range * max_range:
		queue_free()

func _on_body_entered(body: Node2D):
	if body.is_in_group("Enemy"):
		var health = body.get_node_or_null("HealthComponent") as HealthComponent
		if health:
			health.take_damage(_stats.damage)
		queue_free()
