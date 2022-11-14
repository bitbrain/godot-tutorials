extends ConditionLeaf

var stash_area:StashArea

func tick(actor, blackboard):
	var next_available_slot = stash_area.get_next_available_slot()
	if next_available_slot != -1:
		return SUCCESS
	return FAILURE
