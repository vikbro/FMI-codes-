class_name UpgradeSelectionMenu
extends Control

@onready var upgrade_flow_container: HFlowContainer = %UpgradeFlowContainer
@onready var upgrade_description: Label = %UpgradeDescription
@onready var select_btn: Button = %SelectBtn

@export var upgrade_ui_scene: PackedScene

var selected_upgrade_ui: UpgradeUI = null

func _ready() -> void:
	UpgradeManager.upgrade_offer_ready.connect(_on_upgrade_offer_ready)
	select_btn.pressed.connect(_on_select_btn_pressed)
	select_btn.disabled = true
	visible = false

func _on_upgrade_offer_ready(options: Array[PackedScene]) -> void:
	print(options)
	_populate(options)
	visible = true

func _populate(options: Array[PackedScene]) -> void:
	for child in upgrade_flow_container.get_children():
		child.queue_free()
	selected_upgrade_ui = null
	select_btn.disabled = true
	upgrade_description.text = ""

	for scene in options:
		var ui: UpgradeUI = upgrade_ui_scene.instantiate()
		ui.upgrade_scene = scene
		upgrade_flow_container.add_child(ui)
		ui.upgrade_selected.connect(_on_upgrade_ui_selected)

func _on_upgrade_ui_selected(ui: UpgradeUI) -> void:
	selected_upgrade_ui = ui
	upgrade_description.text = ui.description
	select_btn.disabled = false

func _on_select_btn_pressed() -> void:
	if selected_upgrade_ui == null:
		return
	UpgradeManager.choose_upgrade(selected_upgrade_ui.upgrade_scene)
	visible = false
