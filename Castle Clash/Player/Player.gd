extends KinematicBody2D

const MAX_MOVE_SPEED = 90

var velocity = Vector2.ZERO
onready var walls = get_node("/root/Game/Walls")

onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")

func _physics_process(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	input_vector.y = Input.get_action_strength("down") - Input.get_action_strength("up")
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		animationTree.set("parameters/Idle/blend_position", input_vector)
		animationTree.set("parameters/Walk/blend_position", input_vector)
		animationState.travel("Walk")
		velocity = input_vector * MAX_MOVE_SPEED
		
	else:
		animationState.travel("Idle")
		velocity = Vector2.ZERO
		
	move_and_slide(velocity)
