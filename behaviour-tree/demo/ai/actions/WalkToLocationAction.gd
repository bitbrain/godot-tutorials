extends ActionLeaf

export(Vector2) var location

var target_reached = false

func tick(actor, blackboard):
	if not actor.is_connected("target_reached", self, "_target_reached"):
		actor.connect("target_reached", self, "_target_reached")
	if self.target_reached:
		self.target_reached = false
		actor.disconnect("target_reached", self, "_target_reached")
		return SUCCESS
	if location != null:
		actor.target_location = location
		return RUNNING
	else:
		return FAILURE

func _target_reached():
	self.target_reached = true
