extends Node2D


@export var torch_noise:FastNoiseLite
@export var flicker_speed := 20.0
@export var flicker_intensity := 0.15

@onready var light := $PointLight2D
@onready var flames:AnimatedSprite2D = %AnimatedSprite2D


var time := 0.0


func _ready() -> void:
	randomize()
	flames.frame =  randi_range(0, flames.sprite_frames.get_frame_count("On"))
	time = randi_range(0, 1000)

func _process(delta:float) -> void:
	time += delta * flicker_speed
	
	var scale = torch_noise.get_noise_1d(time)
	light.energy = 1.0 + (scale * flicker_intensity)
