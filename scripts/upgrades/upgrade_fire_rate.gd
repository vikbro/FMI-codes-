class_name FireRateUpgrade
extends Node

@export var multiplier: float = 2.0

func _ready():
	var turret = get_parent() as Turret
	turret.stats.fire_rate *= multiplier
