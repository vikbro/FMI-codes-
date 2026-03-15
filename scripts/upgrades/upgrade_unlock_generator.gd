class_name UnlockGeneratorUpgrade
extends UpgradeBase

@export var tick_rate: float = 1.0
@export var amount_per_tick: float = 1.0

func apply(turret: Turret) -> void:
	var res_stats = ResourceStats.new()
	res_stats.tick_rate = tick_rate
	res_stats.amount_per_tick = amount_per_tick
	res_stats.max_resources = 100.0

	var gen = ResourceGeneratorComponent.new()
	gen.stats = res_stats
	turret.add_child(gen)
	turret.resource_generator_component = gen
	#gen.setup(turret.resource_component)
