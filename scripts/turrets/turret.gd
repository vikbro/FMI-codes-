class_name Turret
extends Node2D

@export var stats: TurretStats
@export var bullet_stats: BulletStats

@export var health_component: HealthComponent
@export var shoot_component: ShootComponent
@export var detection_component: DetectionComponent

@onready var target_sprite: Sprite2D = $Target

var _spin_tween: Tween = null

func _ready() -> void:
	health_component.stats = stats
	health_component.current_health = stats.max_health
	shoot_component.stats = stats
	shoot_component.bullet_stats = bullet_stats
	detection_component.stats = stats
	detection_component.shoot_component = shoot_component
	detection_component.update_radius()

	$Area2D.input_pickable = true
	$Area2D.input_event.connect(_on_area_input_event)

	target_sprite.visible = false
	UpgradeManager.placement_changed.connect(_on_placement_changed)

func _on_placement_changed(is_placing: bool) -> void:
	target_sprite.visible = is_placing
	if is_placing:
		_start_spin()
	else:
		_stop_spin()

func _start_spin() -> void:
	if _spin_tween:
		_spin_tween.kill()
	_spin_tween = create_tween().set_loops()
	_spin_tween.tween_property(target_sprite, "rotation", TAU, 1.5) \
		.as_relative() \
		.set_trans(Tween.TRANS_LINEAR)

func _stop_spin() -> void:
	if _spin_tween:
		_spin_tween.kill()
		_spin_tween = null
	target_sprite.rotation = 0.0

func _process(_delta: float) -> void:
	var target: Node2D = shoot_component.target
	if not is_instance_valid(target):
		shoot_component.target = null
		return
	rotation = (target.global_position - global_position).angle()

func _on_area_input_event(_viewport, event: InputEvent, _shape_idx) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		if UpgradeManager.is_placing():
			UpgradeManager.try_apply_to_turret(self)
			Global_Audio.radar.play()
