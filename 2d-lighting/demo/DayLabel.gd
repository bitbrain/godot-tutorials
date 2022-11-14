extends Label

export(NodePath) var day_night_cycle_path

var day_night_cycle : DayNightCycle

func _ready():
	day_night_cycle = get_node(day_night_cycle_path) as DayNightCycle
	day_night_cycle.connect("day_tick", self, "_day_tick")
	
func _day_tick(day) -> void:
	text = "Day " + str(day)
