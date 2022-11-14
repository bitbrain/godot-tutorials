extends ActionLeaf

enum Type {
	PICKUP,
	PLACE
}

export(Type) var type

var stash_area:StashArea

var target_reached = false

func tick(actor, blackboard):
	if not actor.is_connected("target_reached", self, "_target_reached"):
		actor.connect("target_reached", self, "_target_reached")
	if self.target_reached:
		self.target_reached = false
		actor.disconnect("target_reached", self, "_target_reached")
		return SUCCESS
	var next_available_slot = _get_next_slot()
	if next_available_slot > -1:
		actor.target_location = stash_area.get_slot_position(next_available_slot)
		return RUNNING
	else:
		return FAILURE

func _target_reached():
	self.target_reached = true
	
func _get_next_slot() -> int:
	if type == Type.PICKUP:
		return stash_area.get_next_full_slot()
	else:
		return stash_area.get_next_available_slot()
