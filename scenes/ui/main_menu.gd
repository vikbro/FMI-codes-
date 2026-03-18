extends Control

func _ready() -> void:
	Global_Audio.mainm.stream.loop = true
	Global_Audio.mainm.play()

func _on_start_pressed() -> void:
	Global_Audio.click.play()
	Global_Audio.mainm.stream.loop = false
	Global_Audio.mainm.stop()
	get_tree().change_scene_to_file("res://scenes/orbit_test.tscn")

func _on_quit_pressed() -> void:
	Global_Audio.click.play()
	get_tree().quit()

func _on_options_pressed() -> void:
	pass
