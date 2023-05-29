extends Node2D


@onready var canvas_layer = $CanvasLayer
@onready var ui = $CanvasLayer/DayNightCycleUI
@onready var sound_machine = $SoundMachine


func _ready():
	canvas_layer.visible = true
