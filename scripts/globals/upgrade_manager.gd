# Autoload as "UpgradeManager" in Project Settings.
extends Node

var _pending_upgrade: UpgradeBase = null

signal placement_changed(is_placing: bool)
signal upgrade_offer_ready()

func is_placing() -> bool:
	return _pending_upgrade != null

func begin_placement(upgrade: UpgradeBase) -> void:
	_pending_upgrade = upgrade
	placement_changed.emit(true)

func cancel_placement() -> void:
	_pending_upgrade = null
	placement_changed.emit(false)

func try_apply_to_turret(turret: Turret) -> void:
	if _pending_upgrade == null:
		return
	var cost: float = _pending_upgrade.get_cost()
	if not ResourceManager.spend(cost):
		push_warning("UpgradeManager: not enough resources (need %.1f)" % cost)
		cancel_placement()
		return
	_pending_upgrade.apply(turret)
	_pending_upgrade.on_purchased()
	cancel_placement()
