class_name House
extends Node2D

onready var enter_leave_position = $EnterLeavePosition
onready var chimney = $Chimney
onready var door_sound = $DoorSound

var chimney_on = false

func get_enter_leave_position() -> Vector2:
	return enter_leave_position.global_position
	
func enter_house() -> void:
	chimney.frame = 0
	chimney.play("default")
	chimney_on = true
	door_sound.play()
	
func leave_house() -> void:
	chimney_on = false

func _on_Chimney_animation_finished():
	if chimney_on:
		chimney.frame = 0
		chimney.play("default")
