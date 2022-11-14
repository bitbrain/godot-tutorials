extends ConditionLeaf

func tick(actor, blackboard):
	if actor.is_carrying():
		return SUCCESS
	return FAILURE
