tool
class_name Ship
extends Node2D

signal arrive
signal depart

onready var ship_animation_player = $ShipAnimationPlayer
onready var captain_animation = $CaptainAnimationPlayer
onready var captain = $ShipPosition/Captain
onready var ship_sound = $ShipSound
onready var timer = $Timer
onready var stash_area = $ShipPosition/StashArea

var departed = false

func get_stash_area() -> StashArea:
	return stash_area
	
func _ready():
	captain_animation.play("captain")
	call_deferred("_arrived")
	captain.position.x = -7
	captain.position.y = 7
	
func ring_bell():
	ship_sound.play()

func _arrived():
	departed = false
	ship_animation_player.play("swim")
	emit_signal("arrive")
	
func _departed():
	departed = true
	timer.start()
	
func _depart():
	emit_signal("depart")

func _on_Timer_timeout():
	if departed:
		ship_animation_player.play("arrive")

func _on_StashArea_on_place():
	if stash_area != null and stash_area.get_next_available_slot() < 0:
		ship_animation_player.play("depart")
