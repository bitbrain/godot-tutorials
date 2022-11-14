extends ActionLeaf

enum State {
	CHOPPED,
	GROWN
}

export(State) var state

var target_reached = false
var closest_tree

func tick(actor, blackboard):
	if not actor.is_connected("target_reached", self, "_target_reached"):
		actor.connect("target_reached", self, "_target_reached")
	if self.target_reached:
		self.target_reached = false
		closest_tree = null
		actor.disconnect("target_reached", self, "_target_reached")
		return SUCCESS
	if closest_tree == null:
		closest_tree = _find_closest_tree(actor)
		# no close tree available right now!
		if closest_tree == null:
			return FAILURE
		blackboard.set("closest-tree", closest_tree)
		actor.target_location = closest_tree.global_position
	return RUNNING

func _target_reached():
	self.target_reached = true

func _find_closest_tree(actor):
	var current_distance = 9999999
	var closest_tree = null
	for tree in get_tree().get_nodes_in_group("Trees"):
		if state == State.GROWN:
			if not tree.can_chop():
				continue
		if state == State.CHOPPED:
			if not tree.is_completely_chopped():
				continue
		var tree_distance = actor.global_position.distance_to(tree.global_position)
		if tree_distance < current_distance:
			current_distance = tree_distance
			closest_tree = tree
	return closest_tree
