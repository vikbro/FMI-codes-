class_name DamageUpgrade
extends UpgradeBase

@export var bonus: float = 10.0

func apply(turret: Turret) -> void:
	turret.bullet_stats.damage += bonus
