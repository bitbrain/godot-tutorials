extends TreeAction

func _start_action(actor):
	actor.dig()
	
func _change_tree(tree):
	tree.plant()
