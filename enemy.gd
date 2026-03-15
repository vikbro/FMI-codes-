extends Node2D
class_name Enemy

@export var stats: EnemyStats

var _target_planet: Node2D = null

func _ready() -> void:
	_update_collision_shape()

func init(target_planet: Node2D) -> void:
	_target_planet = target_planet

func _update_collision_shape() -> void:
	var shape_node = get_node_or_null("Area2D/CollisionShape2D")
	if shape_node == null:
		return
	if not shape_node.shape is CircleShape2D:
		shape_node.shape = CircleShape2D.new()
	shape_node.shape.radius = stats.radius

func _process(delta: float) -> void:
	if _target_planet == null:
		return
	var direction := (_target_planet.global_position - global_position).normalized()
	global_position += direction * stats.speed * delta

	# Flip the sprite horizontally based on which way the enemy is moving.
	var sprite := get_node_or_null("Sprite2D") as Sprite2D
	if sprite:
		sprite.flip_h = direction.x < 0.0

func take_damage(dmg: int) -> void:
	stats.health -= dmg
	if stats.health <= 0:
		queue_free()
