extends Node


var sound_volume = 0:
	set(value):
		sound_volume = value
		$AudioStreamPlayer.volume_db = sound_volume
var inverse_controls = false
var sensitivity = 1.0
