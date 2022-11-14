tool
class_name StashArea
extends Node2D

signal on_place
signal on_take

const STASH_DIMENSION = 16

export(int) var stash_size = 12
export(int) var stash_per_row = 4
export(bool) var show_ground = true

onready var StashSlot = preload("res://world_objects/stashbox/StashSlot.tscn")
onready var slots = $Slots
onready var place_sound = $PlaceSound
onready var take_sound = $TakeSound

var pointer = Vector2.ZERO

func _ready():
	for i in range(0, stash_size):
		if i % stash_per_row == 0:
			pointer.x = 0
			pointer.y += STASH_DIMENSION
		else:
			pointer.x += STASH_DIMENSION
		
		var slot = StashSlot.instance()
		slot.position = pointer
		slot.show_ground = show_ground
		slots.add_child(slot)

func get_next_available_slot() -> int:
	for i in range(0, stash_size):
		if slots.get_child(i).has_space():
			return i
	return -1
	
func get_next_full_slot() -> int:
	for i in range(0, stash_size):
		if not slots.get_child(i).has_space():
			return i
	return -1
	
func get_slot_position(slot:int) -> Vector2:
	return slots.get_child(slot).global_position
	
func place(slot:int) -> bool:
	var success = slots.get_child(slot).place_box()
	if success:
		place_sound.play()
		emit_signal("on_place")
	return success
	
func take(slot:int) -> StashSlot:
	var success = slots.get_child(slot).take_box()
	if success:
		take_sound.play()
		emit_signal("on_take")
	return success
	
func clear():
	for slot in slots.get_children():
		slot.take_box()
