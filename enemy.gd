extends Node2D

@export var stats: EnemyStats
@onready var area_enemy: Area2D = $Area2D
#@onready var path_follow_2d: PathFollow2D = $".."
var track: bool = false
var area_signal: Area2D
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer


func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass

func take_damage(dmg: int):
	stats.health = stats.health - dmg
	Global_Audio.enemy_hit.play()
	await Global_Audio.swoosh.finished
	print(12)

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.get_script() == get_script():
		return
	else:
		print("hu")
		track = true
		area_signal = area
		Event.detection_planet.emit(track, area)


#func _passing_func():
	#pass
