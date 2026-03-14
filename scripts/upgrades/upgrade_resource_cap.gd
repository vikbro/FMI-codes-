class_name ResourceCapUpgrade
extends Node

@export var bonus: float = 50.0

func _ready() -> void:
	var turret = get_parent() as Turret
	turret.resource_stats.max_resources += bonus
