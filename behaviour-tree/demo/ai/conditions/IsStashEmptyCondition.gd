extends ConditionLeaf

var stash_area:StashArea

func tick(actor, blackboard):
	var next_full_slot = stash_area.get_next_full_slot()
	if next_full_slot == -1:
		return SUCCESS
	return FAILURE
