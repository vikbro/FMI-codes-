extends Label

func _ready() -> void:
	print("Label ready, connecting signal...")
	ResourceManager.resources_changed.connect(_on_resources_changed)
	print("Connected! Current value: ", ResourceManager.total_resources)
	_on_resources_changed(ResourceManager.total_resources)

func _on_resources_changed(total: float) -> void:
	print("Signal received! Total: ", total)
	text = str(total)
	print("Text set to: ", text)
