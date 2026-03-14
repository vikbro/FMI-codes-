class_name Turret
extends Node2D

@export var stats: TurretStats
@export var bullet_stats: BulletStats

@export var health_component: HealthComponent
@export var shoot_component: ShootComponent
@export var detection_component: DetectionComponent

func _ready():
	health_component.stats = stats
	health_component.current_health = stats.max_health  # ← moved here

	shoot_component.stats = stats
	shoot_component.bullet_stats = bullet_stats

	detection_component.stats = stats
	detection_component.shoot_component = shoot_component
	detection_component.update_radius()
