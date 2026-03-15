extends TextureRect

@onready var button: Button = $Button
@onready var button_2: Button = $Button2
@onready var button_3: Button = $Button3
@onready var button_4: Button = $Button4

@onready var label: Label = $HBoxContainer/Label
@onready var label_2: Label = $HBoxContainer/Label2
@onready var label_3: Label = $HBoxContainer/Label3
@onready var label_4: Label = $HBoxContainer/Label4

# Drag the .tscn files from the FileSystem into these slots in the inspector.
@export var damage_upgrade_scene: PackedScene
@export var radius_upgrade_scene: PackedScene
@export var triple_shot_upgrade_scene: PackedScene

var damage_upgrade: DamageUpgrade
var radius_upgrade: RadiusUpgrade
var triple_shot_upgrade: TripleShotUpgrade

func _ready() -> void:
	# Instance each upgrade scene and add as a child so they live in the tree.
	damage_upgrade = damage_upgrade_scene.instantiate()
	radius_upgrade = radius_upgrade_scene.instantiate()
	triple_shot_upgrade = triple_shot_upgrade_scene.instantiate()
	add_child(damage_upgrade)
	add_child(radius_upgrade)
	add_child(triple_shot_upgrade)

	button.pressed.connect(func(): UpgradeManager.begin_placement(damage_upgrade))
	button_2.pressed.connect(func(): UpgradeManager.begin_placement(radius_upgrade))
	button_3.pressed.connect(func(): UpgradeManager.begin_placement(triple_shot_upgrade))

	UpgradeManager.placement_changed.connect(func(_p): _refresh())
	ResourceManager.resources_changed.connect(func(_t): _refresh())
	_refresh()

func _refresh() -> void:
	_update_upgrade(button, label, damage_upgrade)
	_update_upgrade(button_2, label_2, radius_upgrade)
	_update_upgrade(button_3, label_3, triple_shot_upgrade)

func _update_upgrade(btn: Button, lbl: Label, upgrade: UpgradeBase) -> void:
	var cost := upgrade.get_cost()
	var can_afford := ResourceManager.has(cost)
	lbl.text = "%.0f" % cost
	lbl.modulate = Color.WHITE if can_afford else Color.RED
	btn.disabled = not can_afford
