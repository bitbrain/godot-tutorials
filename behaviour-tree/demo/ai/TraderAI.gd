extends BeehaveRoot

export(NodePath) var ship_path
export(NodePath) var stash_area_path
export(NodePath) var boat_dock_position_path

onready var ship = get_node(ship_path)
onready var stash_area = get_node(stash_area_path)
onready var boat_dock_position = get_node(boat_dock_position_path)

onready var walk_to_stash_area = $"%WalkToStashArea"
onready var take_box_action = $"%TakeBoxAction"
onready var walk_to_dock = $"%WalkToDock"
onready var place_box_on_ship = $"%PlaceBoxOnShip"
onready var has_ship_arrived = $"%HasShipArrived"
onready var has_ship_stash_free_space = $"%HasShipStashFreeSpace"
onready var is_stash_empty = $"%IsStashEmpty"

func _ready():
	# ensure _ready() has been finished everywhere else
	yield(get_tree().root, "ready")
	walk_to_stash_area.stash_area = stash_area
	take_box_action.stash_area = stash_area
	walk_to_dock.location = boat_dock_position.position
	place_box_on_ship.stash_area = ship.get_stash_area()
	has_ship_arrived.ship = ship
	has_ship_stash_free_space.stash_area = ship.get_stash_area()
	is_stash_empty.stash_area = stash_area
