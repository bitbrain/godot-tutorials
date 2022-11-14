extends ConditionLeaf

func tick(actor, blackboard):
	if actor.visible:
		return FAILURE
	else:
		return SUCCESS
