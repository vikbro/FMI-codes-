class_name UpgradeUI
extends Control

signal upgrade_selected(ui: UpgradeUI)

@export var upgrade_scene: PackedScene
@export var upgrade_name_text: String = "Upgrade Name"
@export var description: String = "Description here."

@onready var upgrade_name: RichTextLabel = %UpgradeName

func _ready() -> void:
	upgrade_name.text = upgrade_name_text
	gui_input.connect(_on_gui_input)

func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		print("Clicked")
		upgrade_selected.emit(self)
