class_name DetectionComponent
extends Node

@export var area: Area2D
@export var collision_shape: CollisionShape2D

var stats: TurretStats
var shoot_component: ShootComponent

func _ready():
	area.area_entered.connect(_on_area_entered)
	area.area_exited.connect(_on_area_exited)

func update_radius():
	var shape = collision_shape.shape as CircleShape2D
	shape.radius = stats.detection_radius

func _on_area_entered(other_area: Area2D):
	if not other_area.is_in_group("enemies"):
		return
	var enemy := other_area.get_parent()
	if shoot_component.target == null:
		shoot_component.target = enemy

func _on_area_exited(other_area: Area2D):
	if not other_area.is_in_group("enemies"):
		return
	var enemy := other_area.get_parent()
	if shoot_component.target == enemy:
		shoot_component.target = null
