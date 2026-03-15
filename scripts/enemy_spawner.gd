extends Node2D

@export var enemy_scene: PackedScene
@export var spawn_interval: float = 3.0

var _planets: Array[Node] = []
var _timer: float = 0.0

func _ready() -> void:
	_planets = get_tree().get_nodes_in_group("Planet")
	if _planets.is_empty():
		push_warning("EnemySpawner: no nodes found in group 'Planet'. Add planets to the 'Planet' group.")

func _process(delta: float) -> void:
	_timer += delta
	if _timer >= spawn_interval:
		_timer = 0.0
		_spawn_enemy()

func _spawn_enemy() -> void:
	if enemy_scene == null:
		push_warning("EnemySpawner: no enemy_scene assigned in the inspector.")
		return
	if _planets.is_empty():
		return

	var enemy: Enemy = enemy_scene.instantiate()
	enemy.stats = enemy.stats.duplicate()

	get_tree().current_scene.add_child(enemy)
	enemy.global_position = global_position

	var target: Node2D = _planets[randi() % _planets.size()]
	enemy.init(target)
