class_name StashSlot
extends Sprite

export(bool) var show_ground = true

onready var stash_box = $StashBox

func _ready():
	if not show_ground:
		texture = null

func place_box() -> bool:
	if not stash_box.visible:
		stash_box.visible = true
		stash_box.collision_layer = 1
		stash_box.collision_mask = 1
		return true
	return false
	
func take_box() -> bool:
	if stash_box.visible:
		stash_box.visible = false
		stash_box.collision_layer = 0
		stash_box.collision_mask = 0
		return true
	return false

func has_space() -> bool:
	return not stash_box.visible 
