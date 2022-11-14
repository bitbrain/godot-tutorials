extends ConditionLeaf

var ship:Ship setget _set_ship

var arrived = false

func tick(actor, blackboard):
	if arrived or not ship.departed:
		return SUCCESS
	return FAILURE

func _set_ship(s):
	ship = s
	if not ship.is_connected("arrive", self, "_on_arrive"):
		ship.connect("arrive", self, "_on_arrive")
	if not ship.is_connected("depart", self, "_on_depart"):
		ship.connect("depart", self, "_on_depart")
		
func _on_arrive():
	self.arrived = true
	
func _on_depart():
	self.arrived = false
