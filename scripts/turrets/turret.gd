class_name Turret
extends Node2D

@export var stats: TurretStats
@export var bullet_stats: BulletStats

@export var health_component: HealthComponent
@export var shoot_component: ShootComponent
@export var detection_component: DetectionComponent

func _ready() -> void:
	health_component.stats = stats
	health_component.current_health = stats.max_health
	shoot_component.stats = stats
	shoot_component.bullet_stats = bullet_stats
	detection_component.stats = stats
	detection_component.shoot_component = shoot_component
	detection_component.update_radius()

func _process(_delta: float) -> void:
	var target: Node2D = shoot_component.target
	if not is_instance_valid(target):
		shoot_component.target = null
		return
	rotation = (target.global_position - global_position).angle()

# Add to your existing turret.gd

func _on_area_input_event(_viewport, event: InputEvent, _shape_idx) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		if UpgradeManager.is_placing():
			UpgradeManager.try_apply_to_turret(self)
