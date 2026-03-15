extends PathFollow2D

@export var stats: EnemyStats
@export var enemy_scene = preload("res://enemy.tscn")

#var enemy = preload("res://enemy.tscn")
var rng = RandomNumberGenerator.new()
var my_rng
var tracker: bool = false
var direction
var area_pl: Area2D
var offset = 0
var en_array: Array
var offset_arr: Array

func _ready() -> void:
	spawn_enemies(1)
	#enemy_scene.instantiate()
	#add_child(enemy)
	#enemy.global_position = global_position
	#enemy.stats = EnemyStats

func _process(delta: float) -> void:
	Event.detection_planet.connect(_checker)
	for i in en_array.size():
		if tracker == false:
			progress += en_array[i].stats.speed * delta
			h_offset = offset_arr[i]
		else:
			direction = (area_pl.global_position - en_array[i].global_position).normalized()
			en_array[i].global_position += direction * delta * en_array[i].stats.speed
		#my_rng = rng.randf_range(0, 1)
		#enemy.instantiate()
		#$"..".add_child(enemy)
		#enemy.progress = my_rng
		#offset = rng.randf_range(-15, 15)
	#Event.detection_planet.connect(_checker)
	#if tracker == false:
		#progress = progress + enemy.EnemyStats.speed * delta
	#else:
		#direction = (area_pl.global_position - enemy.global_position).normalized()
		#enemy.position += direction * delta * enemy.stats.speed

func spawn_enemies(num: int):
	for i in num:
		my_rng = rng.randf_range(0, 1)
		var enemy = enemy_scene.instantiate()
		add_child(enemy)
		progress = 0
		#progress = my_rng
		offset = rng.randf_range(-15, 15)
		offset_arr.append(offset)
		en_array.append(enemy)
		await get_tree().create_timer(abs(offset)).timeout

func _checker(check: bool, area: Area2D):
	#my_rng = rng.randf_range(0, 10)
	#await get_tree().create_timer(my_rng)
	#enemy.instantiate()
	#add_child(enemy)
	#enemy.global_position = global_position
	#enemy.stats = EnemyStats
	if check == true:
		tracker = true
		area_pl = area
		#queue_free()
	else:
		pass

#
#var enemy = preload("res://enemy.tscn")
#var enemy1 = preload("res://enemy.tscn")
##@onready var enemy: Node2D = $Node2D
##@onready var enemy1: Node2D = $Node2D
#@export var stats: EnemyStats
#@onready var planet: Planet = $"../../Planet"
#@onready var planet_2: Planet = $"../../Planet2"
#
#var area_pl: Area2D
#var tracker: bool = false
#var direction
#
#func _ready() -> void:
	#enemy.instantiate()
	#add_child(enemy)
	#enemy1.instantiate()
	#add_child(enemy1)
##	enemy.stats = stats
	#enemy.global_position = global_position
##	enemy1.stats = stats
	#enemy1.global_position = global_position
	#
#func _process(delta: float) -> void:
	#Event.detection_planet.connect(_checker)
	#if tracker == false:
		#progress = progress + enemy.stats.speed * delta
	#else:
		#direction = (area_pl.global_position - enemy.global_position).normalized()
		#enemy.global_position += direction * delta * stats.speed
	##enemy._on_area_detected(planet.gravity_radius, delta)
##	enemy._on_area_detected(planet_2.gravity_radius, delta)
#func _checker(check: bool, area: Area2D):
	#if check == true:
		#tracker = true
		#area_pl = area
	#else:
		#pass
