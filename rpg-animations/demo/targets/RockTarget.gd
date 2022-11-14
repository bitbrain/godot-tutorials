class_name RockTarget
extends StaticBody2D


onready var SPRITES = [$SpriteFull, $SpriteHalf, $SpriteAlmostGone]

export(int) var health = 5

func hit() -> void:
	if health > 0:
		health = health - 1
		var index = _remap_range(health, 5, 0, 0, SPRITES.size())
		for i in range(0, SPRITES.size()):
			SPRITES[i].visible = i == index
		if health == 0:
			queue_free()

func _remap_range(input:int, minInput:int, maxInput:int, minOutput:int, maxOutput:int):
	return int(float(input - minInput) / float(maxInput - minInput) * float(maxOutput - minOutput) + minOutput)	
