class_name ResourceGeneratorComponent
extends Node

@export var stats: ResourceStats

var _timer: Timer

func setup() -> void:
	_timer = Timer.new()
	_timer.wait_time = 1.0 / stats.tick_rate
	_timer.autostart = true
	_timer.timeout.connect(_on_tick)
	add_child(_timer)

func _on_tick() -> void:
	ResourceManager.deposit(stats.amount_per_tick)

func refresh_timer() -> void:
	_timer.wait_time = 1.0 / stats.tick_rate
	_timer.start()

func get_progress() -> float:
	if _timer == null:
		return 0.0
	return 1.0 - (_timer.time_left / _timer.wait_time)
