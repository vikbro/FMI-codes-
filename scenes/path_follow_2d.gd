extends PathFollow2D

@onready var enemy: Node2D = $Node2D
@export var stats: EnemyStats
@onready var planet: Planet = $"../../Planet"
@onready var planet_2: Planet = $"../../Planet2"

var area_pl: Area2D
var tracker: bool = false
var direction

func _ready() -> void:
	enemy.stats = stats
	enemy.global_position = global_position

func _process(delta: float) -> void:
	Event.detection_planet.connect(_checker)
	if tracker == false:
		progress = progress + enemy.stats.speed * delta
	else:
		direction = (area_pl.position - enemy.global_position).normalized()
		enemy.global_position += direction * delta * stats.speed
	#enemy._on_area_detected(planet.gravity_radius, delta)
#	enemy._on_area_detected(planet_2.gravity_radius, delta)
func _checker(check: bool, area: Area2D):
	if check == true:
		tracker = true
	else:
		area_pl = area
