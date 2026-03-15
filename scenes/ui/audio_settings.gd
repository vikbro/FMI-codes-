extends Node

@onready var master_slider: HSlider = $CanvasLayer/MarginContainer/VBoxContainer/MasterContainer/HSlider
@onready var music_slider: HSlider = $CanvasLayer/MarginContainer/VBoxContainer/MusicContainer/HSlider
@onready var sfx_slider: HSlider = $CanvasLayer/MarginContainer/VBoxContainer/SFXContainer/HSlider

func _ready() -> void:
	# Set slider ranges to 0.0 - 1.0
	for slider in [master_slider, music_slider, sfx_slider]:
		slider.min_value = 0.0
		slider.max_value = 1.0
		slider.step = 0.01

	# Initialise sliders to current bus volumes.
	master_slider.value = db_to_linear(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Master")))
	music_slider.value = db_to_linear(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Music")))
	sfx_slider.value = db_to_linear(AudioServer.get_bus_volume_db(AudioServer.get_bus_index("SFX")))

	master_slider.value_changed.connect(_on_master_changed)
	music_slider.value_changed.connect(_on_music_changed)
	sfx_slider.value_changed.connect(_on_sfx_changed)

func _on_master_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), linear_to_db(value))

func _on_music_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), linear_to_db(value))

func _on_sfx_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), linear_to_db(value))
