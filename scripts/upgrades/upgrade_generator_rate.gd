class_name GeneratorRateUpgrade
extends Node

@export var multiplier: float = 1.5

#Speeds up how often ticks happen
func _ready() -> void:
	var turret = get_parent() as Turret
	turret.resource_stats.tick_rate *= multiplier
	turret.resource_generator_component.refresh_timer()
