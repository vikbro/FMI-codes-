@tool
extends Node2D
class_name Planet

@export var gravity_radius: float = 200.0:
	set(value):
		gravity_radius = value
		_update_shape()

@export var planet_texture: Texture2D:
	set(value):
		planet_texture = value
		_update_sprite()

@export var planet_scale: float = 1.0:
	set(value):
		planet_scale = value
		_update_scale()

@export var resource_generator_component: ResourceGeneratorComponent
@export var progress_bars: PlanetProgressBars
@export var satelite: PackedScene
@onready var plant_sprite: Sprite2D = $PlantSprite

func _ready() -> void:
	if Engine.is_editor_hint():
		return

	if resource_generator_component:
		assert(resource_generator_component.stats != null,
			"Planet: ResourceGeneratorComponent has no stats assigned in the inspector!")
		resource_generator_component.setup()

	if progress_bars:
		progress_bars.setup(resource_generator_component)

	var vector_node := get_node_or_null("Node2D")
	vector_node.r = plant_sprite.texture.get_height() / 2
	if vector_node and vector_node.has_signal("spawn_satelite_data"):
		vector_node.spawn_satelite_data.connect(_on_spawn_satelite_data)
	else:
		push_warning("Planet: could not find vector Node2D with spawn_satelite_data signal.")

func _on_spawn_satelite_data(base_orbit_fraction: float, orbit_speed: float) -> void:
	_spawn_satelite(base_orbit_fraction, orbit_speed)

func _spawn_satelite(base_orbit_fraction: float, orbit_speed: float) -> void:
	if satelite == null:
		push_warning("Planet: no satelite PackedScene assigned in the inspector.")
		return

	var instance := satelite.instantiate()

	var orbit_path := instance as Path2D
	if orbit_path == null:
		push_warning("Planet: satelite scene root is not a Path2D.")
		return

	var orbit_body := orbit_path.get_node_or_null("Sattelite")
	if orbit_body == null:
		push_warning("Planet: could not find 'Sattelite' PathFollow2D inside the satelite scene.")
		return

	orbit_body.orbit_speed = orbit_speed
	orbit_body.base_orbit_fraction = base_orbit_fraction
	orbit_body.current_planet = self
	Global_Audio.launch.play()
	get_tree().current_scene.add_child(instance)

func _update_shape() -> void:
	var shape_node = get_node_or_null("Area2D/CollisionShape2D")
	if shape_node == null:
		return
	if not shape_node.shape is CircleShape2D:
		shape_node.shape = CircleShape2D.new()
	shape_node.shape.radius = gravity_radius

func _update_sprite() -> void:
	var sprite = get_node_or_null("PlantSprite")
	if sprite and planet_texture:
		sprite.texture = planet_texture

func _update_scale() -> void:
	var sprite = get_node_or_null("PlantSprite")
	if sprite:
		sprite.scale = Vector2(planet_scale, planet_scale)
