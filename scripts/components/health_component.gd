class_name HealthComponent
extends Node

signal died
signal health_changed(new_hp: float)

var stats: TurretStats
var current_health: float

func take_damage(amount: float):
	current_health -= amount
	health_changed.emit(current_health)
	if current_health <= 0:
		died.emit()

func heal(amount: float):
	current_health = minf(current_health + amount, stats.max_health)
	health_changed.emit(current_health)
