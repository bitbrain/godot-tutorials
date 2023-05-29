extends CanvasModulate


signal time_tick(day:int, hour:int, minute:int)


@export var gradient_texture:GradientTexture1D
@export var TIME_MULTIPLIER = 20.0
@export var INITIAL_HOUR = 12


var time_scale:float= ((2 * PI) / 1440) * TIME_MULTIPLIER
var time:float= 0.0
var past_minute:int= -1
var real_time_minute_duration:float


func _ready() -> void:
	real_time_minute_duration = (2 * PI) / 1440
	time += real_time_minute_duration * 60 * INITIAL_HOUR


func _process(delta: float) -> void:
	var prev_time = time
	time += delta * time_scale
	var value = (sin(time - PI / 2) + 1.0) / 2.0
	self.color = gradient_texture.gradient.sample(value)

	var total_minutes = int(time / real_time_minute_duration)
	var minutes_in_day = total_minutes % 1440
	var hours = int(minutes_in_day / 60)
	var minutes = int(minutes_in_day % 60)
	var day = int(total_minutes / 1440)
	if past_minute != minutes:
		past_minute = minutes
		time_tick.emit(day, hours, minutes)
