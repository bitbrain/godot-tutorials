extends ActionLeaf

var target_reached = false

func tick(actor, blackboard):
	if not actor.is_connected("target_reached", self, "_target_reached"):
		actor.connect("target_reached", self, "_target_reached")
		actor.reset()
	if self.target_reached:
		self.target_reached = false
		actor.disconnect("target_reached", self, "_target_reached")
		return SUCCESS
	actor.target_location = actor.get_house().get_enter_leave_position()
	return RUNNING

func _target_reached():
	self.target_reached = true
