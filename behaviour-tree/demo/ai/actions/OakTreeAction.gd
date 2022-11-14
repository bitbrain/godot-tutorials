class_name TreeAction
extends ActionLeaf

var action_performed = false
var action_queued = false
var animation_finished = false
var tree

func tick(actor, blackboard):
	_tick_internally(actor, blackboard)
	
	if not actor.is_connected("action_performed", self, "_action_performed"):
		actor.connect("action_performed", self, "_action_performed")
	if not actor.is_connected("animation_finished", self, "_animation_finished"):
		actor.connect("animation_finished", self, "_animation_finished")
	
	tree = blackboard.get("closest-tree")
	
	if tree == null:
		action_performed = false
		action_queued = false
		animation_finished = false
		actor.disconnect("action_performed", self, "_action_performed")
		actor.disconnect("animation_finished", self, "_animation_finished")
		return FAILURE
		
	if animation_finished and _can_finish(actor, tree):
		tree = null
		action_performed = false
		action_queued = false
		animation_finished = false
		_on_complete(actor)
		actor.disconnect("action_performed", self, "_action_performed")
		actor.disconnect("animation_finished", self, "_animation_finished")
		return SUCCESS
		
	if not action_queued and not action_performed:
		action_queued = true
		animation_finished = false
		_start_action(actor)
		
	return RUNNING

func _action_performed() -> void:
	action_performed = true
	_change_tree(tree)

func _animation_finished() -> void:
	animation_finished = true
	action_performed = false
	action_queued = false
	
func _can_finish(actor, tree):
	return true
	
func _start_action(actor):
	pass
	
func _change_tree(tree):
	pass

func _on_complete(actor):
	pass
	
func _tick_internally(actor, blackboard):
	pass
