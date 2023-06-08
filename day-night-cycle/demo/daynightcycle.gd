extends CanvasModulate

const REAL_TIME_MINUTE_DURATION = (2 * PI) / 1440


signal time_tick(day:int, hour:int, minute:int)


@export var gradient_texture:GradientTexture1D
@export var TIME_MULTIPLIER = 20.0
@export var INITIAL_HOUR = 12:
	set(h):
		time = h * 60 * REAL_TIME_MINUTE_DURATION


var time:float= 0.0
var past_minute:int= -1
var real_time_minute_duration:float


func _ready() -> void:
	time = REAL_TIME_MINUTE_DURATION * 60 * INITIAL_HOUR


func _process(delta: float) -> void:
	time += delta * REAL_TIME_MINUTE_DURATION * TIME_MULTIPLIER
	
	var value = (sin(time - PI / 2.0) + 1.0) / 2.0
	self.color = gradient_texture.gradient.sample(value)
	
	_recalculate_time()	

		
func _recalculate_time() -> void:
	var total_minutes = int(time / REAL_TIME_MINUTE_DURATION)
	var day = int(total_minutes / 1440.0)

	var minutes_in_day = total_minutes % 1440

	var hours = int(minutes_in_day / 60.0)
	var minutes = int(minutes_in_day % 60)
	
	if past_minute != minutes:
		past_minute = minutes
		time_tick.emit(day, hours, minutes)

