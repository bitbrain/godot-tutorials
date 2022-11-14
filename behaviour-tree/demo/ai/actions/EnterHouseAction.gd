extends ActionLeaf

func tick(actor, blackboard):
	if actor.visible:
		actor.get_house().enter_house()
		actor.visible = false
		actor.idle()
		return SUCCESS
	else:
		return FAILURE
