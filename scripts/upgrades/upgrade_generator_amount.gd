class_name GeneratorAmountUpgrade
extends Node

#More resources per tick
@export var bonus: float = 1.0

func _ready() -> void:
	var turret = get_parent() as Turret
	turret.resource_stats.amount_per_tick += bonus
