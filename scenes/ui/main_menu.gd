extends Control

func _ready() -> void:
	Global_Audio.mainm.stream.loop = true
	Global_Audio.mainm.play()

func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://enemy.tscn")

func _on_quit_pressed() -> void:
	get_tree().quit()

func _on_options_pressed() -> void:
	pass
