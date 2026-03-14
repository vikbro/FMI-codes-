class_name TripleShotUpgrade
extends Node

@export var count: int = 3
@export var spread_angle: float = 20.0

func _ready():
	var turret = get_parent() as Turret
	turret.bullet_stats.bullet_count = count
	turret.bullet_stats.spread_angle = spread_angle
