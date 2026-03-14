class_name ResourceComponent
extends Node

signal resources_changed(amount: float)

var stats: ResourceStats

func _process(delta: float):
	stats.current_resources += stats.generation_rate * delta
	resources_changed.emit(stats.current_resources)
