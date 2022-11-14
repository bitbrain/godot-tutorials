extends ActionLeaf

func tick(actor, blackboard):
	if not actor.visible:
		actor.get_house().leave_house()
		actor.visible = true
		actor.reset()
	return SUCCESS
