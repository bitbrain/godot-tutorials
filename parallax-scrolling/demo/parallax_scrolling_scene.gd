extends Node2D

@onready var camera_2d: Camera2D = %Camera2D

var dead_zone_radius: float = 60 # Pixels, adjust this value to change the dead zone size
var speed: float = 200 # Adjust speed of camera movement

func _process(delta: float) -> void:
	var screen_center: Vector2 = camera_2d.get_screen_center_position()
	var mouse_position: Vector2 = camera_2d.get_global_mouse_position()
	var direction_to_mouse: Vector2 = mouse_position - screen_center
	var distance_to_mouse: float = direction_to_mouse.length()

	if distance_to_mouse > dead_zone_radius:
		var movement_direction: Vector2 = direction_to_mouse.normalized()
		var movement: Vector2 = movement_direction * speed * delta
		camera_2d.global_position += movement
