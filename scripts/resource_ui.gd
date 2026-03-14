class_name PlanetProgressBars
extends Control

@onready var storage_capacity: ProgressBar = $StorageCapacity
@onready var generation_progress: ProgressBar = $GenerationProgress

var _resource_generator_component: ResourceGeneratorComponent

func setup(generator_comp: ResourceGeneratorComponent) -> void:
	_resource_generator_component = generator_comp

	var planet = get_parent() as Planet
	if planet:
		scale = Vector2(planet.planet_scale, planet.planet_scale)

	# Shows global total instead of local capacity
	storage_capacity.min_value = 0.0
	storage_capacity.max_value = 999.0  # visual ceiling, not a real cap
	storage_capacity.value = ResourceManager.total_resources
	ResourceManager.resources_changed.connect(_on_resources_changed)

	generation_progress.min_value = 0.0
	generation_progress.max_value = 1.0

func _process(_delta: float) -> void:
	if _resource_generator_component:
		generation_progress.value = _resource_generator_component.get_progress()

func _on_resources_changed(current: float) -> void:
	storage_capacity.value = current
	#storage_capacity.max_value = ResourceManager.max_resources

func _exit_tree() -> void:
	if ResourceManager.resources_changed.is_connected(_on_resources_changed):
		ResourceManager.resources_changed.disconnect(_on_resources_changed)
