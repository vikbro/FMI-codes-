extends Control

func _ready() -> void:
	Global_Audio.lose.stream.loop = true
	Global_Audio.lose.play()

func _on_return_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/ui/MainMenu.tscn")


func _on_quit_pressed() -> void:
	get_tree().quit()
