tool
extends Node2D

var random = RandomNumberGenerator.new()

func _ready():
	randomize()

func play():
	if get_child_count() < 1:
		return
	random.randomize()
	var randomIndex = random.randi_range(0, get_child_count() - 1)
	var player = get_child(randomIndex)
	if player.has_method("play"):
		player.play()
