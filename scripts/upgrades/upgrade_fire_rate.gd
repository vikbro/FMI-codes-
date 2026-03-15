class_name FireRateUpgrade
extends UpgradeBase

@export var multiplier: float = 2.0

func apply(turret: Turret) -> void:
	turret.stats.fire_rate *= multiplier
