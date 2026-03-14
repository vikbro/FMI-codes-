extends Node

signal resources_changed(total: float)

var total_resources: float = 0.0

func deposit(amount: float) -> void:
	total_resources += amount
	resources_changed.emit(total_resources)

func spend(amount: float) -> bool:
	if total_resources < amount:
		return false
	total_resources -= amount
	resources_changed.emit(total_resources)
	return true

func has(amount: float) -> bool:
	return total_resources >= amount
