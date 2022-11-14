tool
class_name WoodTree
extends StaticBody2D

enum TreeState {
	PLANTED,
	GROWING,
	GROWN,
	CHOPPING,
	CHOPPED
}

export(TreeState) var state = TreeState.PLANTED

onready var planted_sprite = $PlantedSprite
onready var grow_sprites = $GrowSprites.get_children()
onready var grown_sprite = $GrownSprite
onready var chop_sprites = $ChopSprites.get_children()
onready var falling_tree_sound = $FallingTreeSound
onready var chop_tree_sound = $ChopSounds
onready var plant_sounds = $PlantSounds
onready var grow_timer = $GrowTimer

var grow_stage:int = -1
var chop_stage:int = -1

func _ready():
	grown_sprite.visible = true

func is_watered() -> bool:
	return state != TreeState.PLANTED

func water() -> void:
	if not is_watered():
		state = TreeState.GROWING
		grow_sprites[0].visible = true
		grow_timer.start()
		
func is_completely_chopped() -> bool:
	return state == TreeState.CHOPPED

func plant() -> void:
	if is_completely_chopped() or state == TreeState.PLANTED:
		plant_sounds.play()
		chop_stage = -1
		state = TreeState.PLANTED
		planted_sprite.visible = true
		grow_timer.stop()
		for chop_sprite in chop_sprites:
			chop_sprite.visible = false
	
func is_still_growing() -> bool:
	return state == TreeState.GROWING
	
func can_chop() -> bool:
	return state == TreeState.GROWN or state == TreeState.CHOPPING

func chop() -> void:
	if can_chop():
		state = TreeState.CHOPPING
		chop_tree_sound.play()
		grown_sprite.visible = false
		if chop_stage >= 0:
			chop_sprites[chop_stage].visible = false
		chop_stage += 1
		chop_sprites[chop_stage].visible = true
		if chop_stage == chop_sprites.size() - 1:
			state = TreeState.CHOPPED
			falling_tree_sound.play()
	
func _on_GrowTimer_timeout():
	if state == TreeState.GROWING:
		if grow_stage == grow_sprites.size() - 1:
			for grow_sprite in grow_sprites:
				grow_sprite.visible = false
			state = TreeState.GROWN
			grown_sprite.visible = true
			grow_stage = -1
			return
		if grow_stage >= 0:
			grow_sprites[grow_stage].visible = false
		grow_stage += 1
		grow_sprites[grow_stage].visible = true
		
