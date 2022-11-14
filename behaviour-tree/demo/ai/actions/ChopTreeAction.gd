extends TreeAction

func _start_action(actor):
	actor.chop()
	
func _change_tree(tree):
	tree.chop()

func _can_finish(actor, tree):
	return tree.is_completely_chopped()

func _on_complete(actor):
	actor.carry()
