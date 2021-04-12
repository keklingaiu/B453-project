extends KinematicBody2D

const MAX_MOVE_SPEED = 90

var count = 0

var save_data = {"0": ["nothing", Vector2(0,0)]}

var velocity = Vector2.ZERO
onready var walls = get_node("/root/Game/Walls")

onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")


#func _ready():
#	var file_check = File.new()
#	if(file_check.file_exists("res://ghosts/" + get_tree().current_scene.name + ".json")):
#		var ghost = preload("res://Player/PlayerGhost.tscn")
#		var load_ghost = ghost.instance()
#		load_ghost.global_position = self.global_position
#		get_parent().call_deferred("add_child", load_ghost)
#
#func do_record():
#	count += 1
#	save_data[String(count)] = [animationState, global_position]
#	if(Input.is_action_just_pressed("record")):
#
#		var f := File.new()
#		f.open("res://ghosts/" + get_tree().current_scene.name + ".json", File.WRITE)
#		prints("Saving to", f.get_path_absolute())
#		f.store_string(JSON.print(save_data))
#		f.close()

func _physics_process(delta):
#	do_record()
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
