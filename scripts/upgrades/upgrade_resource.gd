class_name ResourceUpgrade
extends Node

@export var resource_stats: ResourceStats

func _ready():
	var turret = get_parent() as Turret
	
	var resource_component = ResourceComponent.new()
	resource_component.stats = resource_stats
	turret.add_child(resource_component)
