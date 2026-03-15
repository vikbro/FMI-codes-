class_name RadiusUpgrade
extends UpgradeBase

@export var bonus: float = 100.0

func apply(turret: Turret) -> void:
	turret.stats.detection_radius += bonus
	turret.detection_component.update_radius()
