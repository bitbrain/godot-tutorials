extends Node2D

onready var ship = $"%Ship"
onready var debug_line = $Line2D

func _ready():
	for villager in get_tree().get_nodes_in_group("Villagers"):
		villager.swim()

func _on_Ship_arrive():
	ship.get_stash_area().place(0)
	ship.get_stash_area().place(1)
	ship.get_stash_area().place(2)
	ship.get_stash_area().place(3)


func _on_Player_path_changed(path):
	debug_line.points = path
