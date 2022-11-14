extends KinematicBody2D

export var ACCELERATION = 250
export var FRICTION = 550
export var MAX_SPEED = 50
export var ROLL_SPEED = 80

enum {
	RUN,
	ROLL,
	JUMP
}

onready var animation_tree = $AnimationTree
onready var animation_state = animation_tree.get("parameters/playback")

var velocity = Vector2.ZERO
var roll_vector = Vector2.DOWN
var state = RUN
var roll_finished = false

func _ready():
	animation_tree.active = true
	
func _physics_process(delta):
	match state:
		RUN:	
			run_state(delta)
		ROLL:
			roll_state(delta)
	
func run_state(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		roll_vector = input_vector
		animation_tree.set("parameters/Idle/blend_position", input_vector)
		animation_tree.set("parameters/Run/blend_position", input_vector)
		animation_tree.set("parameters/Jump/blend_position", input_vector)
		animation_tree.set("parameters/Roll/blend_position", input_vector)
		animation_state.travel("Run")
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
	else:
		animation_state.travel("Idle")
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)

	velocity = move_and_slide(velocity)
	
	if velocity.length() > 0 && Input.is_action_just_pressed("roll"):
		state = ROLL
		roll_finished = false
	
func roll_state(delta):
	if !roll_finished:
		velocity = roll_vector * ROLL_SPEED
	else:
		velocity = velocity * 0.9
	animation_state.travel("Roll")
	velocity = move_and_slide(velocity)

func jump_finished():
	state = RUN
	velocity = Vector2.ZERO
	
func roll_prefinished():
	roll_finished = true
	
func roll_finished():
	state = RUN
	velocity = velocity * 0.5
