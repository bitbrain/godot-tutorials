extends ConditionLeaf

func tick(actor, blackboard):
	var trees = get_tree().get_nodes_in_group("Trees")
	for tree in trees:
		if tree.can_chop():
			return SUCCESS
	return FAILURE
