extends Node

@export var night_hour = 18
@export var day_hour = 5

@onready var day_jingle: AudioStreamPlayer = $DayJingle
@onready var night_jingle: AudioStreamPlayer = $NightJingle
@onready var day_soundscape: AudioStreamPlayer = $DaySoundscape
@onready var night_soundscape: AudioStreamPlayer = $NightSoundscape


func set_daytime(day: int, hour: int, minute: int) -> void:
	if hour <= day_hour or hour >= night_hour:
		# check if we need to play night soundscape
		if not night_soundscape.playing:
			night_soundscape.play()
			day_soundscape.stop()
	else:
		# check if we need to play day soundscape
		if not day_soundscape.playing:
			day_soundscape.play()
			night_soundscape.stop()
	if hour == day_hour and minute == 0:
		day_jingle.play()
		day_soundscape.play()
		night_soundscape.stop()
	if hour == night_hour and minute == 0:
		night_jingle.play()
		day_soundscape.stop()
		night_soundscape.play()
