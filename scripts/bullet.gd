class_name Bullet
extends Area2D

var _direction: Vector2
var _stats: BulletStats

func setup(direction: Vector2, stats: BulletStats):
	_direction = direction
	_stats = stats

func _process(delta: float):
	global_position += _direction * _stats.speed * delta

func _on_body_entered(body: Node2D):
	if body.is_in_group("Enemy"):
		var health = body.get_node_or_null("HealthComponent") as HealthComponent
		if health:
			health.take_damage(_stats.damage)
		queue_free()
