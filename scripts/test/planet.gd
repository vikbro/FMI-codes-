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

func _ready() -> void:
	_update_shape()
	_update_sprite()
	_update_scale()

	if Engine.is_editor_hint():
		return

	if resource_generator_component:
		assert(resource_generator_component.stats != null,
			"Planet: ResourceGeneratorComponent has no stats assigned in the inspector!")
		resource_generator_component.setup()

	if progress_bars:
		progress_bars.setup(resource_generator_component)

func _update_shape() -> void:
	var shape_node = get_node_or_null("Area2D/CollisionShape2D")
	if shape_node == null:
		return
	var new_shape = CircleShape2D.new()
	new_shape.radius = gravity_radius
	shape_node.shape = new_shape

func _update_sprite() -> void:
	var sprite = get_node_or_null("PlantSprite")
	if sprite and planet_texture:
		sprite.texture = planet_texture

func _update_scale() -> void:
	var sprite = get_node_or_null("PlantSprite")
	if sprite:
		sprite.scale = Vector2(planet_scale, planet_scale)
