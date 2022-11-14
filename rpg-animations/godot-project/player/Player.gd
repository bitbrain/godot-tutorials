class_name Player
extends KinematicBody2D

export var ACCELERATION = 350
export var FRICTION = 850
export var MAX_SPEED = 100
export var ROLL_SPEED = 180

enum {
	RUN,
	ROLL,
	JUMP,
	MINING,
	WOODCUTTING
}

var velocity = Vector2.ZERO
var direction_vector = Vector2.DOWN
var state = RUN
var roll_finished = false
var targets = []
var direction = Vector2.ZERO
	
func _physics_process(delta):
	match state:
		RUN:	
			run_state(delta)
		ROLL:
			roll_state(delta)
		JUMP:
			jump_state(delta)
		MINING:
			mining_state(delta)
		WOODCUTTING:
			woodcutting_state(delta)
	
func run_state(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		direction_vector = input_vector
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)

	velocity = move_and_slide(velocity)
	
	if velocity.length() > 0 && Input.is_action_just_pressed("roll"):
		state = ROLL
		roll_finished = false
	elif velocity.length() == 0 && Input.is_action_just_pressed("jump"):
		state = JUMP
	elif velocity.length() == 0 && Input.is_action_pressed("action"):
		if is_tree_infront():
			state = WOODCUTTING
		elif is_rock_infront():
			state = MINING
	
func roll_state(delta):
	if !roll_finished:
		velocity = direction_vector * ROLL_SPEED
	else:
		velocity = velocity * 0.9
	velocity = move_and_slide(velocity)
	
func jump_state(delta):
	velocity = move_and_slide(velocity)
	
func mining_state(delta):
	velocity = move_and_slide(velocity)
	
func woodcutting_state(delta):
	velocity = move_and_slide(velocity)

func animation_finished():	
	if !Input.is_action_pressed("action"):
		state = RUN
		velocity = Vector2.ZERO
	
func roll_prefinished():
	roll_finished = true
	
func roll_finished():
	state = RUN
	velocity = velocity * 0.5
	
func on_target_hit() -> void:
	for target in targets:
		target.hit()
		
func is_tree_infront():
	for target in targets:
		if target is TreeTarget:
			return true
	return false
	
func is_rock_infront():
	for target in targets:
		if target is RockTarget:
			return true
	return false

func _on_Hitbox_body_entered(body):
	targets.append(body)

func _on_Hitbox_body_exited(body):
	targets.erase(body)
