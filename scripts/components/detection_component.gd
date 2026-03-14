class_name DetectionComponent
extends Node

@export var area: Area2D
@export var collision_shape: CollisionShape2D

var stats: TurretStats
var shoot_component: ShootComponent

func _ready():
	area.body_entered.connect(_on_body_entered)
	area.body_exited.connect(_on_body_exited)

func update_radius():
	var shape = collision_shape.shape as CircleShape2D
	shape.radius = stats.detection_radius

func _on_body_entered(body: Node2D):
	if body.is_in_group("enemies") and shoot_component.target == null:
		shoot_component.target = body

func _on_body_exited(body: Node2D):
	if shoot_component.target == body:
		shoot_component.target = null
