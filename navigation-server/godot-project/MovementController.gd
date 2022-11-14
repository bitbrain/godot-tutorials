class_name MovementController
extends Node2D


onready var ClickEffect = preload("res://util/ClickEffect.tscn")
onready var npc:Villager = get_parent()

func _input(event):
   if event is InputEventMouseButton and event.pressed:
	   var target_location = get_global_mouse_position()
	   npc.set_target_location(target_location)
	   var clickEffect = ClickEffect.instance()
	   clickEffect.global_position = target_location
	   clickEffect.set_as_toplevel(true)
	   get_parent().add_child(clickEffect)
