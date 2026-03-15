class_name UpgradeBase
extends Node

@export var upgrade_name: String = "Upgrade"
@export var description: String = "Description"
@export var base_cost: float = 50.0
@export var cost_multiplier: float = 1.5

var _purchase_count: int = 0

func get_cost() -> float:
	return base_cost * pow(cost_multiplier, _purchase_count)

func on_purchased() -> void:
	_purchase_count += 1

func apply(_turret: Turret) -> void:
	pass
