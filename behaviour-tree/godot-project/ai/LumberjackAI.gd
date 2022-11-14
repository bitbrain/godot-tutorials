extends BeehaveRoot

export(NodePath) var stash_area_path

onready var stash_area = get_node(stash_area_path)

func _ready():
	# ensure _ready() has been finished everywhere else
	yield(get_tree().root, "ready")
