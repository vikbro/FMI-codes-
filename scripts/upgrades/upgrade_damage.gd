class_name DamageUpgrade
extends Node

@export var bonus: float = 10.0

func _ready():
	var turret = get_parent() as Turret
	turret.bullet_stats.damage += bonus
