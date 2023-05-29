extends Node2D


@onready var canvas_layer = $CanvasLayer
@onready var canvas_modulate = $CanvasModulate
@onready var ui = $CanvasLayer/DayNightCycleUI
@onready var sound_machine = $SoundMachine


func _ready() -> void:
	canvas_layer.visible = true
	canvas_modulate.time_tick.connect(ui.set_daytime)
	canvas_modulate.time_tick.connect(sound_machine.set_daytime)
