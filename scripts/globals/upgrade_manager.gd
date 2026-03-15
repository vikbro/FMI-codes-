extends Node

@export var upgrade_pool_data: UpgradePoolData

enum State { IDLE, CHOOSING, PLACING }

signal upgrade_offer_ready(options: Array[PackedScene])
signal upgrade_placed(turret: Turret)

var state: State = State.IDLE
var held_upgrade_scene: PackedScene = null
var upgrade_pool: Array[PackedScene] = []

func _ready() -> void:
	if upgrade_pool_data:
		upgrade_pool = upgrade_pool_data.upgrades.duplicate()

func offer_upgrades() -> void:
	if state != State.IDLE:
		push_warning("UpgradeManager: tried to offer upgrades while not IDLE")
		return
	if upgrade_pool.size() < 2:
		push_warning("UpgradeManager: not enough upgrades in pool")
		return

	state = State.CHOOSING
	var pool_copy = upgrade_pool.duplicate()
	pool_copy.shuffle()
	var options: Array[PackedScene] = [pool_copy[0], pool_copy[1]]
	upgrade_offer_ready.emit(options)

func choose_upgrade(scene: PackedScene) -> void:
	if state != State.CHOOSING:
		return
	held_upgrade_scene = scene
	state = State.PLACING

func try_apply_to_turret(turret: Turret) -> void:
	if state != State.PLACING or held_upgrade_scene == null:
		return
	var upgrade = held_upgrade_scene.instantiate() as UpgradeBase
	turret.add_child(upgrade)
	upgrade.apply(turret)
	held_upgrade_scene = null
	state = State.IDLE
	upgrade_placed.emit(turret)

func is_placing() -> bool:
	return state == State.PLACING
