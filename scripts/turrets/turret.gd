class_name Turret
extends Node2D

@export var stats: TurretStats
@export var bullet_stats: BulletStats
@export var resource_stats: ResourceStats

@export var health_component: HealthComponent
@export var shoot_component: ShootComponent
@export var detection_component: DetectionComponent
@export var resource_component: ResourceComponent
@export var resource_generator_component: ResourceGeneratorComponent

func _ready() -> void:
	# Combat setup
	health_component.stats = stats
	health_component.current_health = stats.max_health
	shoot_component.stats = stats
	shoot_component.bullet_stats = bullet_stats
	detection_component.stats = stats
	detection_component.shoot_component = shoot_component
	detection_component.update_radius()

	if resource_component and resource_generator_component:
		#resource_component.stats = resource_stats
		resource_generator_component.stats = resource_stats
		resource_generator_component.setup()
		resource_component.resources_changed.connect(_on_resources_changed)

func _on_resources_changed(current: float) -> void:
	ResourceManager.deposit(current - ResourceManager.total_resources)
