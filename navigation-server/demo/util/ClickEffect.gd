extends Node2D

export(float) var max_radius = 30.0
export(float) var animation_time = 1.2

onready var tween : SceneTreeTween = create_tween()

var radius = 0.0

func _ready():
	tween.set_ease(Tween.EASE_OUT)
	tween.set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(self, "radius", max_radius, animation_time)
	tween.parallel().tween_property(self, "modulate", Color(1, 1, 1, 0), animation_time)

	tween.connect("finished", self, "_finished")
	
func _draw():
	draw_circle(Vector2(0, 0), radius, modulate)

func _process(delta):
	update()

func _finished():
	queue_free()
