class_name ResourceComponent
extends Node

signal resources_changed(current: float)

var stats: ResourceStats

func setup(resource_stats: ResourceStats) -> void:
	stats = resource_stats

func spend(amount: float) -> bool:
	if stats.current_resources < amount:
		return false
	stats.current_resources -= amount
	resources_changed.emit(stats.current_resources)
	return true

func deposit(amount: float) -> void:
	stats.current_resources = minf(stats.current_resources + amount, stats.max_resources)
	resources_changed.emit(stats.current_resources)

func has(amount: float) -> bool:
	return stats.current_resources >= amount
