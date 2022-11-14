extends ActionLeaf

var stash_area:StashArea

func tick(actor, blackboard):
	var next_full_slot = stash_area.get_next_full_slot()
	if next_full_slot != -1 and not actor.is_carrying():
		stash_area.take(next_full_slot)
		actor.carry()
		return SUCCESS
	else:
		return FAILURE
