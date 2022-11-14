extends TreeAction

func _start_action(actor):
	actor.water()
	
func _change_tree(tree):
	tree.water()

func _tick_internally(actor, blackboard):
	var closest_tree = blackboard.get("closest-tree")
	# abort watering in case closest tree has grown
	# in the meantime
	if closest_tree != null:
		if not closest_tree.is_completely_chopped() and closest_tree.is_watered():
			blackboard.erase("closest-tree")
