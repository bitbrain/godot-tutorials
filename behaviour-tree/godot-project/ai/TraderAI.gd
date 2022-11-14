extends BeehaveRoot

export(NodePath) var ship_path
export(NodePath) var stash_area_path
export(NodePath) var boat_dock_position_path

onready var ship = get_node(ship_path)
onready var stash_area = get_node(stash_area_path)
onready var boat_dock_position = get_node(boat_dock_position_path)

func _ready():
	# ensure _ready() has been finished everywhere else
	yield(get_tree().root, "ready")
