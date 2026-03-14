class_name RadiusUpgrade
extends Node

@export var bonus: float = 100.0

func _ready():
	var turret = get_parent() as Turret
	turret.stats.detection_radius += bonus
	turret.detection_component.update_radius()
