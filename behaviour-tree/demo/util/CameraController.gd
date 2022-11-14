extends Node

signal on_camera_swap(camera)

onready var sound = $AudioStreamPlayer

var camera_list : Array
var current_camera = 0

func _ready():
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("WorldAudio"), 0)
	self.camera_list = get_tree().get_nodes_in_group("Cameras")

func _process(delta):
	if Input.is_action_just_pressed("swap_camera"):
		current_camera = current_camera + 1
		if current_camera >= self.camera_list.size():
			current_camera = 0
		camera_list[current_camera].current = true
		emit_signal("on_camera_swap", camera_list[current_camera])
		sound.play()
		if camera_list[current_camera].get_parent() is Villager:
			AudioServer.set_bus_volume_db(AudioServer.get_bus_index("WorldAudio"), 10)
		else:
			AudioServer.set_bus_volume_db(AudioServer.get_bus_index("WorldAudio"), 0)
