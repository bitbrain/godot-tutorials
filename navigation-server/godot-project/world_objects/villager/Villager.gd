class_name Villager
extends KinematicBody2D

signal target_reached

enum AnimationState {
	IDLE = 0,
	SWIM = 1,
}

var AnimationNames = {
	AnimationState.SWIM:"Swim",
	AnimationState.IDLE:"Idle",
}

export(float) var MAX_SPEED = 105

onready var animation_player = $AnimationPlayer
onready var voice_sounds = $VoiceSounds

var velocity = Vector2.ZERO
var target_location = Vector2.ZERO
var state = AnimationState.IDLE
var last_move_velocity = Vector2.ZERO
var current_animation = null
var move_direction = Vector2.ZERO
var did_arrive = false

func _ready():
	# ensure villagers are initially set to their origin
	set_target_location(position)

func make_sound():
	voice_sounds.play()
	
func reset():
	state = AnimationState.IDLE
	
func swim():
	state = AnimationState.SWIM
	
func idle():
	state = AnimationState.IDLE
	velocity = Vector2.ZERO
	
func set_target_location(target:Vector2) -> void:
	did_arrive = false
	target_location = target
	make_sound()

func _physics_process(delta):
	if not visible:
		return
	
	var move_direction = position.direction_to(target_location)
	velocity = move_direction * MAX_SPEED
	look_at_direction(move_direction)
	_play_animation(state)
	
	if not _arrived_at_location():
		velocity = move_and_slide(velocity)
	elif not did_arrive:
		did_arrive = true
		emit_signal("target_reached")
	
func look_at_direction(direction:Vector2) -> void:
	direction = direction.normalized()
	move_direction = direction
	if current_animation != null:
		_play_animation(current_animation)

func _play_walk_sound():
	if not visible:
		return
		
func _arrived_at_location() -> bool:
	return position.distance_to(target_location) < 8
	
func _play_animation(animation_type:int) -> void:
	var animation_type_string = AnimationNames[animation_type]
	var animation_name = animation_type_string + "_" + _get_direction_string(move_direction.angle())
	if animation_name != animation_player.current_animation:
		animation_player.stop(true)
	animation_player.play(animation_name)
	current_animation = animation_type
			
func _get_direction_string(angle:float) -> String:
	var angle_deg = round(rad2deg(angle))
	if angle_deg > -90.0 and angle_deg < 90.0:
		return "Right"
	return "Left"
