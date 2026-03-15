extends Node2D

@onready var turret: Turret = $Turret

func _ready():
	$CanvasLayer/HBoxContainer/Button.pressed.connect(_on_radius_upgrade)
	$CanvasLayer/HBoxContainer/Button2.pressed.connect(_on_damage_upgrade)
	$CanvasLayer/HBoxContainer/Button3.pressed.connect(_on_multishot_upgrade)

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			var direction = (get_global_mouse_position() - turret.global_position).normalized()
			turret.shoot_component._fire_in_direction(direction)

func _on_radius_upgrade():
	var upgrade = RadiusUpgrade.new()
	upgrade.bonus = 100.0
	turret.add_child(upgrade)
	print("Radius is now: ", turret.stats.detection_radius)

func _on_damage_upgrade():
	var upgrade = DamageUpgrade.new()
	turret.add_child(upgrade)
	print("Damage is now: ", turret.bullet_stats.damage)

func _on_multishot_upgrade():
	var upgrade = TripleShotUpgrade.new()
	turret.add_child(upgrade)
	print("Bullet count is now: ", turret.bullet_stats.bullet_count)

func _on_button_4_pressed() -> void:
	UpgradeManager.offer_upgrades()
	pass # Replace with function body.
