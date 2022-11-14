extends Node

export(float) var radius = 18.0
export(float) var speed = 5.1

var rotation_vector = Vector2.ZERO
var parent_pos = Vector2.ZERO

func _ready():
	var parent = get_parent() as Node2D
	parent_pos = parent.position
	rotation_vector.x = radius
	
func _process(delta):
	rotation_vector = rotation_vector.rotated( delta * speed)
	get_parent().position = parent_pos + rotation_vector
