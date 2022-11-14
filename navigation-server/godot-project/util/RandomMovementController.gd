extends Node2D

export(float) var min_world_bound_x = -400.0
export(float) var min_world_bound_y = -400.0
export(float) var max_world_bound_x = 400.0
export(float) var max_world_bound_y = 600.0

onready var villager:Villager = get_parent()

func _ready():
	yield(get_tree().root, "ready")
	randomize()
	villager.connect("target_reached", self, "_compute_new_target")
	_compute_new_target()

func _compute_new_target():
	var target_position_x = rand_range(min_world_bound_x, max_world_bound_x)
	var target_position_y = rand_range(min_world_bound_y, max_world_bound_y)
	villager.set_target_location(Vector2(target_position_x, target_position_y))
