class_name TripleShotUpgrade
extends UpgradeBase

@export var count: int = 3
@export var spread_angle: float = 20.0

func apply(turret: Turret) -> void:
	turret.bullet_stats.bullet_count = count
	turret.bullet_stats.spread_angle = spread_angle
